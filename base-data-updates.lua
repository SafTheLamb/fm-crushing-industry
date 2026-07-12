local frep = require("__fdsl__.lib.recipe")

local REMIX = settings.startup["crushing-industry-remix"].value

-------------------------------------------------------------------------- Space crusher

if mods["space-age"] then
	-- always rename it to avoid confusion
	data.raw["assembling-machine"]["crusher"].localised_name = {"entity-name.space-crusher"}
	table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing")
	
	-- upgrade SA's Crusher to the Space Crusher
	if settings.startup["crushing-industry-space-crusher"].value then
		data.raw["assembling-machine"]["crusher"].crafting_speed = 1.5
		data.raw["assembling-machine"]["crusher"].module_slots = 4
	
		if settings.startup["crushing-industry-space-crusher-quality"].value then
			data.raw["assembling-machine"]["crusher"].effect_receiver = {base_effect={quality=1.25, productivity=0.25}}
			data.raw["assembling-machine"]["crusher"].energy_usage = "1080kW"
			frep.add_ingredient("crusher", {type="item", name="quality-module-2", amount=4})
		else
			data.raw["assembling-machine"]["crusher"].effect_receiver = {base_effect={productivity=0.25}}
			data.raw["assembling-machine"]["crusher"].energy_usage = "810kW"
		end
	end
end

-------------------------------------------------------------------------- Ore crushing

if settings.startup["crushing-industry-ore"].value then
	frep.replace_ingredient("concrete", "iron-ore", "crushed-iron-ore")
	if settings.startup["crushing-industry-concrete-mix"].value then
		frep.replace_ingredient("concrete-mix", "iron-ore", "crushed-iron-ore")
	end

	if settings.startup["crushing-industry-byproducts"].value then
		frep.add_result("crushed-iron-ore", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
		frep.add_result("crushed-copper-ore", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
	end

	if mods["space-age"] then
		frep.replace_ingredient("iron-ore-melting", "iron-ore", "crushed-iron-ore")
		frep.scale_ingredient("iron-ore-melting", "crushed-iron-ore", {amount=1.5})
		frep.replace_ingredient("copper-ore-melting", "copper-ore", "crushed-copper-ore")
		frep.scale_ingredient("copper-ore-melting", "crushed-copper-ore", {amount=1.5})

		frep.replace_ingredient("advanced-thruster-oxidizer", "iron-ore", "crushed-iron-ore")
		frep.scale_ingredient("advanced-thruster-oxidizer", "crushed-iron-ore", {amount=2})

		local tungsten_plate_recipe = frep.find("tungsten-plate")
		if tungsten_plate_recipe then
			frep.replace_ingredient("tungsten-plate", "tungsten-ore", "crushed-tungsten-ore")
			frep.scale_ingredient("tungsten-plate", "crushed-tungsten-ore", {amount=2})
			if REMIX then
				frep.set_time("tungsten-plate", 6.4)
			end
		end

		frep.replace_ingredient("holmium-solution", "holmium-ore", "holmium-powder")
		frep.scale_ingredient("holmium-solution", "holmium-powder", {amount=1.5})
		if REMIX then
			frep.set_time("holmium-solution", 8)
		else
		end

		if settings.startup["crushing-industry-byproducts"].value then
			frep.add_result("crushed-tungsten-ore", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.FLAVOR_BYPRODUCT), false)
			if settings.startup["crushing-industry-big-crusher"].value then
				frep.add_result("crushed-tungsten-ore", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FLAVOR_BYPRODUCT), false)
			end
			frep.add_result("holmium-powder", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
		end

		if mods["scrap-industry"] and mods["scrap-industry"] >= "0.8.0" then
			frep.replace_ingredient("fluoroketone", "lithium", "lithium-dust")
			frep.scale_ingredient("fluoroketone", "lithium-dust", {amount=2})
		end
	end
end

-------------------------------------------------------------------------- Coal crushing

if settings.startup["crushing-industry-coal"].value then
	local function replace_coal_ingredient(recipe_name, scale)
		frep.replace_ingredient(recipe_name, "coal", "crushed-coal")
		frep.scale_ingredient(recipe_name, "crushed-coal", scale or {amount=2})
	end

	replace_coal_ingredient("coal-liquefaction", {amount=mods["space-age"] and 2.5 or 1.5})
	replace_coal_ingredient("explosives", {amount=2})
	replace_coal_ingredient("plastic-bar", {amount=2})
	replace_coal_ingredient("carbon")
	replace_coal_ingredient("poison-capsule")
	replace_coal_ingredient("slowdown-capsule")

	if settings.startup["crushing-industry-byproducts"].value then
		frep.add_result("crushed-coal", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FLAVOR_BYPRODUCT), false)
	end
end

-------------------------------------------------------------------------- Asteroid crushing

if mods["space-age"] then
	-- byproducts from asteroid crushing
	if settings.startup["crushing-industry-byproducts"].value then
		frep.add_result("metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
		frep.add_result("carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.FREQUENT_BYPRODUCT, 2, true), false, 2)
		frep.add_result("oxide-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)

		frep.add_result("advanced-metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
		frep.add_result("advanced-carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.COMMON_BYPRODUCT, 2, true), false, 3)
		frep.add_result("advanced-oxide-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)

		if mods["cupric-asteroids"] then
			frep.add_result("cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
			frep.add_result("advanced-cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
		end

		if settings.startup["crushing-industry-ore"].value then
			frep.add_result("advanced-metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("crushed-iron-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 3, true), false, 2)
			if mods["cupric-asteroids"] then
				frep.add_result("advanced-cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("crushed-copper-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 2, true), false, 2)
			end
		end
	end

	-- Modify basic asteroid crushing to be craftable in the basic crusher
	frep.replace_category("metallic-asteroid-crushing", "crafting", "basic-crushing")
	frep.replace_category("carbonic-asteroid-crushing", "crafting", "basic-crushing")
	frep.replace_category("oxide-asteroid-crushing", "crafting", "basic-crushing")
	if mods["cupric-asteroids"] then
		frep.replace_category("cupric-asteroid-crushing", "crafting", "basic-crushing")
	end
end
