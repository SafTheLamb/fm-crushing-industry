local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")
local futil = require("__fdsl__.lib.util")

if mods["planetaris-arig"] and settings.startup["crushing-industry-planetaris-arig"].value then
	local sand_fluid = data.raw.fluid["planetaris-sand"]
	if sand_fluid then
		sand_fluid.localised_name = {"fluid-name.planetaris-sand-ci"}
	end
	futil.hide_all_prototypes("planetaris-pure-sand")

	local pure_sand_recipes = frep.find_by_ingredient("planetaris-pure-sand")
	for _,recipe in pairs(pure_sand_recipes) do
		frep.modify_ingredient(recipe, "planetaris-pure-sand", {type="item", name="sand"})
	end
	pure_sand_recipes = frep.find_by_result("planetaris-pure-sand")
	for _,recipe in pairs(pure_sand_recipes) do
		frep.modify_result(recipe, "planetaris-pure-sand", {type="item", name="sand"})
	end

	if settings.startup["crushing-industry-glass"].value then
		futil.hide_all_prototypes("planetaris-glass-panel")

		local glass_panel_recipes = frep.find_by_ingredient("planetaris-glass-panel")
		for _,recipe in pairs(glass_panel_recipes) do
			frep.replace_ingredient(recipe, "planetaris-glass-panel", "glass")
			frep.scale_ingredient(recipe, "glass", {amount=15})
		end

		ftech.remove_technology("planetaris-glass-panel")
		if ftech.has_prereq_recursive("condensing-agricultural-tower", "planet-discovery-arig") then
			ftech.merge_technology("condensing-agricultural-tower", "planetaris-compression")
			ftech.set_research_craft_item("planetaris-compression", "planetaris-sifter", 1)
		end
	end

	if settings.startup["crushing-industry-coal"].value then
		-- Original cost is 1 coal
		frep.replace_ingredient("planetaris-plastic-bar", "coal", {type="item", name="crushed-coal", amount=2})
		-- Original cost is 2 coal
		frep.replace_ingredient("planetaris-carbon", "coal", {type="item", name="crushed-coal", amount=3})
	end
end
