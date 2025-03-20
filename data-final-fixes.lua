local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

local function make_recipe_copy(item_type, recipe_name, ingredient_name, crushed_name, tech_name, overlay_icon)
  local item = data.raw[item_type][recipe_name]
  if data.raw.recipe[recipe_name] then
    local recipe_copy = util.table.deepcopy(data.raw.recipe[recipe_name])
    recipe_copy.name = "crushed-"..recipe_copy.name
    recipe_copy.localised_name = {"recipe-name.crushed-crafting", {"item-name."..recipe_name}, {"item-name."..crushed_name}}
    recipe_copy.order = (recipe_copy.order or item.order).."-crushed"
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
