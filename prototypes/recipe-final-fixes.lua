local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

local function make_recipe_copy(item_type, recipe_name, ingredient_name, crushed_name, tech_name, overlay_icon)
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
    ftech.add_unlock(tech_name, recipe_copy.name)
  end
end

if settings.startup["crushing-industry-coal"].value then
  make_recipe_copy("capsule", "grenade", "coal", "crushed-coal", "oil-processing",
    {icon="__crushing-industry__/graphics/icons/crushed-coal.png", shift={-12,-12}, scale=0.4, draw_background=true}
  )
end

-- replace concrete in recipes in final fixes so the recycling recipe won't be overridden (unless another mod manually re-generates)
-- other mods like Cerys rely on getting concrete from recycling, and frankly that's good to keep in
if settings.startup["crushing-industry-concrete-mix"].value then
  local concrete_mix_map = {
    ["concrete"] = 10,
    ["refined-concrete"] = 50,
  }

  for _,recipe in pairs(data.raw.recipe) do
    local recipe_metadata = CrushingIndustry.concrete_recipes[recipe.name]
    if recipe_metadata and recipe_metadata.ignore then
      goto continue
    end

    -- find ingredients that can be replaced with concrete mix
    local mix_amount = 0
    local ingredients_to_remove = {}
    for ingredient_index,ingredient in pairs(recipe.ingredients or {}) do
      if ingredient.type == "item" then
        local scalar = concrete_mix_map[ingredient.name]
        if scalar then
          mix_amount = mix_amount + scalar * ingredient.amount
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
