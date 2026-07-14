local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

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

		local recipe_techs = ftech.find_by_unlock(recipe_name)
		local crushed_techs = ftech.find_by_unlock(crushed_name)
		local recipe_techs_map = util.list_to_map(recipe_techs)
		local crushed_techs_map = util.list_to_map(crushed_techs)

		local new_tech_map = {}
		for _,recipe_tech in pairs(recipe_techs) do
			if crushed_techs_map[recipe_tech] or ftech.has_any_prereq_recursive(recipe_tech, crushed_techs_map) then
				ftech.add_unlock(recipe_tech, recipe_copy.name)
				new_tech_map[recipe_tech] = true
			end
		end
		local force_unlock = not next(new_tech_map)
		for _,crushed_tech in pairs(crushed_techs) do
			if force_unlock or recipe_techs_map[crushed_tech] or ftech.has_any_prereq_recursive(crushed_tech, recipe_techs_map) then
				ftech.add_unlock(crushed_tech, recipe_copy.name)
				new_tech_map[crushed_tech] = true
			end
		end

		-- Remove any duplicates
		for tech_name,_ in pairs(new_tech_map) do
			if ftech.has_any_prereq_recursive(tech_name, new_tech_map) then
				ftech.remove_unlock(tech_name, recipe_copy.name)
			end
		end
	end
end

if settings.startup["crushing-industry-coal"].value then
	make_recipe_copy("capsule", "grenade", "coal", "crushed-coal",
		{icon="__crushing-industry__/graphics/icons/crushed-coal.png", shift={-12,-12}, scale=0.4, draw_background=true}
	)
end
