local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

local function tech_requires_prereq(tech_name, prereq_name)
  local open_list = {tech_name}
  local visit_list = {}

  local i = 0
  while i < #open_list do
    i = i + 1
    local visit_tech_name = open_list[i]
    local visit_tech = data.raw.technology[visit_tech_name]
    if visit_tech and not visit_list[visit_tech_name] then
      visit_list[visit_tech_name] = true
      if visit_tech_name == prereq_name then
        return true
      end
      for _,visit_prereq_name in pairs(visit_tech.prerequisites or {}) do
        table.insert(open_list, visit_prereq_name)
      end
    end
  end
  
  return false
end

local function find_unlock_tech(recipe_name)
  for _,tech in pairs(data.raw.technology) do
    if not tech.hidden then
      for _,effect in pairs(tech.effects or {}) do
        if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
          return tech
        end
      end
    end
  end
  return nil
end

local function make_recipe_copy(item_type, recipe_name, ingredient_name, crushed_name, overlay_icon)
  local item = data.raw[item_type][recipe_name]
  if data.raw.recipe[recipe_name] then
    local recipe_copy = util.table.deepcopy(data.raw.recipe[recipe_name])
    recipe_copy.name = "crushed-"..recipe_copy.name
    recipe_copy.localised_name = {"recipe-name.crushed-crafting", {"item-name."..recipe_name}, {"item-name."..crushed_name}}
    recipe_copy.order = (recipe_copy.order or item.order).."-crushed"
    recipe_copy.auto_recycle = false
    if not recipe_copy.icons then
      recipe_copy.icons = {{icon=recipe_copy.icon or item.icon, icon_size=recipe_copy.icon_size or item.icon_size}}
    end
    table.insert(recipe_copy.icons, 1, overlay_icon)
    for _,icon in pairs(recipe_copy.icons) do
      if icon.draw_background ~= false then icon.draw_background = true end
    end
    data:extend({recipe_copy})
    frep.replace_ingredient(recipe_copy.name, ingredient_name, crushed_name)
    local recipe_tech = find_unlock_tech(recipe_name)
    local crushed_tech = find_unlock_tech(crushed_name)
    if recipe_tech and crushed_tech then
      if tech_requires_prereq(recipe_tech.name, crushed_tech.name) then
        ftech.add_unlock(recipe_tech.name, recipe_copy.name)
      else
        ftech.add_unlock(crushed_tech.name, recipe_copy.name)
      end
    else
    end
  end
end

if settings.startup["crushing-industry-coal"].value then
  make_recipe_copy("capsule", "grenade", "coal", "crushed-coal",
    {icon="__crushing-industry__/graphics/icons/crushed-coal.png", shift={-12,-12}, scale=0.4, draw_background=true}
  )
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
    for ingredient_index,ingredient in pairs(recipe.ingredients or {}) do
      if ingredient.type == "item" then
        local concrete_metadata = CrushingIndustry.concrete_items[ingredient.name] or {}
        if concrete_metadata.scalar and (concrete_metadata.auto_convert ~= false or recipe_metadata.convert) then
          mix_amount = mix_amount + concrete_metadata.scalar * ingredient.amount
          table.insert(ingredients_to_remove, ingredient_index)
        end
      end
    end
    
    -- remove replaced ingredients, then add concrete mix
    if mix_amount > 0 then
      for _,index in pairs(ingredients_to_remove) do
        table.remove(recipe.ingredients, index)
      end
      frep.add_ingredient(recipe.name, {type="fluid", name="concrete-mix", amount=mix_amount})
      if not recipe.category or recipe.category == "crafting" then
        recipe.category = "crafting-with-fluid"
      end
    end
    ::continue::
  end
end

-------------------------------------------------------------------------- Basic crusher

-- Make sure all basic crushers can craft all basic crushing recipes
-- Use the electric crusher as the golden standard for all basic crushing categories
local basic_crushing_categories = {}
for _,category in pairs(data.raw.furnace["electric-crusher"].crafting_categories) do
  basic_crushing_categories[category] = true
end

local basic_crushing_max_results = 0
for _,recipe in pairs(data.raw.recipe) do
  if recipe.category and recipe.results and basic_crushing_categories[recipe.category] then
    local num_results = #recipe.results
    if num_results > basic_crushing_max_results then
      basic_crushing_max_results = num_results
    end
  end
end

-- Update all basic crushers with the new result inventory size
for _,furnace in pairs(data.raw.furnace) do
  for _,category in pairs(furnace.crafting_categories) do
    if category == "basic-crushing" then
      if basic_crushing_max_results > furnace.result_inventory_size then
        furnace.result_inventory_size = basic_crushing_max_results
      end
      break
    end
  end
end

-------------------------------------------------------------------------- Asteroid reprocessing

if mods["space-age"] then
  -- Modify asteroid reprocessing recipes to invalidate all productivity bonuses
  local function string_ends_with(str, ending)
    local len = string.len(str)
    return str.sub(str, len - string.len(ending) + 1, len) == ending
  end

  for _,recipe in pairs(data.raw.recipe) do
    if recipe.results and string_ends_with(recipe.name, "-asteroid-reprocessing") then
      for _,result in pairs(recipe.results) do
        result.ignored_by_productivity = 1
      end
    end
  end
end
