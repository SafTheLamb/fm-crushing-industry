local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

-------------------------------------------------------------------------------- Barrels

if settings.startup["crushing-industry-concrete-mix"].value and settings.startup["crushing-industry-concrete-spoil-amount"].value > 0 then
	local concrete_mix_barrel = data.raw.item["concrete-mix-barrel"]
	if concrete_mix_barrel then
		concrete_mix_barrel.spoil_ticks = 0.26*hour
		concrete_mix_barrel.spoil_result = "concrete"
	end
end

-------------------------------------------------------------------------------- Machine ignorelist

local machine_ignorelist_string = settings.startup["crushing-industry-concrete-machine-ignorelist"].value
assert(type(machine_ignorelist_string) == "string")
local machines_to_ignore = {}
if machine_ignorelist_string ~= "" then
  local split_ignorelist = util.split(machine_ignorelist_string, ',')
  for _,name in pairs(split_ignorelist) do
    machines_to_ignore[name] = true
  end
end

-- base
machines_to_ignore["assembling-machine-1"] = true
-- AAI Industry
machines_to_ignore["burner-assembling-machine"] = true
-- Lignumis
machines_to_ignore["steam-assembling-machine"] = true
-- Mini machines
machines_to_ignore["mini-assembler-1"] = true
-- Micro machines
machines_to_ignore["micro-assembler-1"] = true

-------------------------------------------------------------------------------- Concrete mix

-- Before replacing, figure out the maximum fluid amount a recipe can be crafted with and respect that before modifying
local category_max_fluids = {}
for _,entity in pairs(data.raw["assembling-machine"]) do
  if machines_to_ignore[entity.name] then
    goto continue
  end

  local fluid_box_count = 0
  for _,fluid_box in pairs(entity.fluid_boxes or {}) do
    -- Don't need to check input-output for the production_type, since that's only for boilers
    if fluid_box.production_type == "input" then
      fluid_box_count = fluid_box_count + 1
    end
  end

  -- Update categories the entity can craft, ESPECIALLY if the machine can't accept any fluids
  for _,category_name in pairs(entity.crafting_categories or {}) do
    if category_name ~= "crafting" then
      -- Get the smallest of the max fluid inputs
      if not category_max_fluids[category_name] then
        category_max_fluids[category_name] = {max = fluid_box_count}
      else
        category_max_fluids[category_name].max = math.max(fluid_box_count, category_max_fluids[category_name].max)
      end
      local category_metadata = category_max_fluids[category_name]
      local ingredient_count = entity.ingredient_count or 65535 -- 65535 = max inputs
      if not category_metadata[ingredient_count] then
        category_metadata[ingredient_count] = fluid_box_count
      else
        category_metadata[ingredient_count] = math.min(fluid_box_count, category_metadata[ingredient_count])
      end
    end
  end

  ::continue::
end

--- Returns whether a recipe can be modified to substitute "Concrete" with "Concrete mix"
local function is_recipe_mixable(category_name, fluid_count, ingredient_count)
  local category_metadata = category_max_fluids[category_name]
  if category_metadata then
    -- Check for quick limit
    if category_metadata.max < fluid_count then
      return false
    end
    -- Check for limits of specific ingredient counts
    for i,count in pairs(category_metadata) do
      -- If the machine has enough input slots for the recipe, but not enough fluid slots, then the recipe is NOT "mixable"
      if type(i) == "number" and i >= ingredient_count then
        if count < fluid_count then
          return false
        end
      end
    end
  end
  return true
end

local function fix_recipe_with_fluids(recipe)
  if frep.has_category(recipe, "crafting") then
    frep.replace_category(recipe, "crafting", "crafting-with-fluid")
  end
end

-- replace concrete in recipes in final fixes so the recycling recipe won't be overridden (unless another mod manually re-generates)
-- other mods like Cerys rely on getting concrete from recycling, and frankly that's good to keep in
if settings.startup["crushing-industry-concrete-mix"].value then
  for _,recipe in pairs(data.raw.recipe) do
    local recipe_metadata = CrushingIndustry.concrete_recipes[recipe.name] or {}
    if recipe_metadata.ignore then
      goto continue
    end
    if recipe.category == "recycling" then
      goto continue
    end

    -- find ingredients that can be replaced with concrete mix
    local mix_amount = 0
    local ingredients_to_remove = {}
    local fluid_count = 0
    for ingredient_index,ingredient in pairs(recipe.ingredients or {}) do
      if ingredient.type == "item" then
        local concrete_metadata = CrushingIndustry.concrete_items[ingredient.name] or {}
        if concrete_metadata.scalar and (concrete_metadata.auto_convert ~= false or recipe_metadata.convert) then
          mix_amount = mix_amount + concrete_metadata.scalar * ingredient.amount
          table.insert(ingredients_to_remove, ingredient_index)
        end
      elseif ingredient.type == "fluid" then
        if ingredient.name == "concrete-mix" then
          fix_recipe_with_fluids(recipe)
        else
          fluid_count = fluid_count + 1
        end
      end
    end
    
    if mix_amount > 0 then
      -- Before modifying, make sure the recipe won't be made uncraftable in some machine
      local category_name = recipe.category or "crafting-with-fluid"
      -- If a recipe is crafting, then we'll be overriding it with "crafting-with-fluid" anyway (the one exception to this "rule")
      if category_name == "crafting" then
        category_name = "crafting-with-fluid"
      end
      -- Check the recipe's category and subcategories
      fluid_count = fluid_count + 1
      local ingredient_count = #recipe.ingredients
      if not is_recipe_mixable(category_name, fluid_count, ingredient_count) then
        goto continue
      end
      for _,subcategory_name in pairs(recipe.additional_categories or {}) do
        if not is_recipe_mixable(subcategory_name, fluid_count, ingredient_count) then
          goto continue
        end
      end

      -- remove replaced ingredients, then add concrete mix
      for _,index in pairs(ingredients_to_remove) do
        table.remove(recipe.ingredients, index)
      end
      frep.add_ingredient(recipe.name, {type="fluid", name="concrete-mix", amount=mix_amount})
      fix_recipe_with_fluids(recipe)
    end
    ::continue::
  end
end
