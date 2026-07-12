local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

local item_sounds = require("__base__.prototypes.item_sounds")

--===========================================================================--

if settings.startup["crushing-industry-ore"].value then

------------------------------------------------------------------------------- BZ: Lead

if mods["bzlead"] then
	data:extend({
		{
			type = "item",
			name = "crushed-lead-ore",
			icon = "__crushing-industry__/graphics/icons/compat/crushed-lead-ore.png",
			pictures = {
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-lead-ore.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-lead-ore-1.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-lead-ore-2.png", scale=0.5},
			},
			subgroup = "raw-resource",
			order = data.raw.item["lead-ore"].order.."-c[crushed]",
			inventory_move_sound = item_sounds.resource_inventory_move,
			pick_sound = item_sounds.resource_inventory_pickup,
			drop_sound = item_sounds.resource_inventory_move,
			stack_size = 100,
			weight = 2 * kg
		},
		{
			type = "recipe",
			name = "crushed-lead-ore",
			localised_name = {"recipe-name.lead-ore-crushing"},
			icons = CrushingIndustry.make_crushing_icons("lead-ore"),
			categories = {"basic-crushing"},
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1.2,
			ingredients = {{type="item", name="lead-ore", amount=1}},
			results = {
				{type="item", name="crushed-lead-ore", amount=1, extra_count_fraction=0.5, independent_probability=5/6},
				{type="item", name="crushed-copper-ore", amount=1, independent_probability=1/6},
				CrushingIndustry.make_crushing_byproduct("lead-ore"),
			},
			main_product = "crushed-lead-ore"
		},
		{
			type = "recipe",
			name = "crushed-lead-smelting",
			localised_name = {"recipe-name.crushed-smelting", {"item-name.lead-plate"}},
			icons = {
				{icon="__crushing-industry__/graphics/icons/compat/crushed-lead-ore.png", shift={-12, -12}, scale=0.4},
				{icon="__bzlead__/graphics/icons/lead-plate.png", draw_background=true}
			},
			categories = {"smelting"},
			order = data.raw.recipe["lead-plate"].order.."-c[crushed]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value == true,
			energy_required = 3.2,
			ingredients = {{type="item", name="crushed-lead-ore", amount=1}},
			results = {{type="item", name="lead-plate", amount=1}},
			main_product = "lead-plate",
		}
	})

	ftech.add_unlock("ore-crushing", "crushed-lead-ore")
	ftech.add_unlock("ore-crushing", "crushed-lead-smelting")
	CrushingIndustry.add_smelting_productivity("crushed-lead-smelting")

	if mods["space-age"] then
		frep.replace_category("alternative-metallic-asteroid-crushing", "crushing", "basic-crushing")
		data.raw["furnace"]["electric-crusher"].result_inventory_size = math.max(3, data.raw["furnace"]["electric-crusher"].result_inventory_size)
		frep.replace_ingredient("molten-lead", "lead-ore", "crushed-lead-ore")
		frep.scale_ingredient("molten-lead", "crushed-lead-ore", {amount=1.5})
		frep.replace_result("molten-lead", "copper-ore", "crushed-copper-ore")
		CrushingIndustry.add_molten_productivity("molten-lead")
	end
end

------------------------------------------------------------------------------- BZ: Tin

if mods["bztin"] then
	data:extend({
		{
			type = "item",
			name = "crushed-tin-ore",
			icon = "__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png",
			pictures = {
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-tin-ore-1.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-tin-ore-2.png", scale=0.5},
			},
			subgroup = "raw-resource",
			order = data.raw.item["tin-ore"].order.."-c[crushed]",
			inventory_move_sound = item_sounds.resource_inventory_move,
			pick_sound = item_sounds.resource_inventory_pickup,
			drop_sound = item_sounds.resource_inventory_move,
			stack_size = 100,
			weight = 2 * kg
		},
		{
			type = "recipe",
			name = "crushed-tin-ore",
			localised_name = {"recipe-name.tin-ore-crushing"},
			icons = CrushingIndustry.make_crushing_icons("tin-ore"),
			categories = {"basic-crushing"},
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1,
			ingredients = {{type="item", name="tin-ore", amount=1}},
			results = {
				{type="item", name="crushed-tin-ore", amount=1, extra_count_fraction=0.5},
				CrushingIndustry.make_crushing_byproduct("tin-ore"),
			},
			main_product = "crushed-tin-ore"
		},
		{
			type = "recipe",
			name = "crushed-tin-smelting",
			localised_name = {"recipe-name.crushed-smelting", {"item-name.tin-plate"}},
			icons = {
				{icon="__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png", shift={-12, -12}, scale=0.4},
				{icon="__bztin__/graphics/icons/tin-plate.png", icon_size=128, scale=0.25, draw_background=true}
			},
			categories = {"smelting"},
			order = data.raw.recipe["tin-plate"].order.."-c[crushed]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value == true,
			energy_required = 3.2,
			ingredients = {{type="item", name="crushed-tin-ore", amount=1}},
			results = {{type="item", name="tin-plate", amount=1}},
			main_product = "tin-plate",
		}
	})

	ftech.add_unlock("ore-crushing", "crushed-tin-ore")
	ftech.add_unlock("ore-crushing", "crushed-tin-smelting")
	CrushingIndustry.add_smelting_productivity("crushed-tin-smelting")

	if settings.startup["crushing-industry-byproducts"].value then
		frep.add_result("crushed-tin-ore", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
	end

	if mods["space-age"] then
		CrushingIndustry.add_molten_productivity("molten-tin")
		frep.replace_ingredient("molten-tin", "tin-ore", "crushed-tin-ore")
		frep.scale_ingredient("molten-lead", "crushed-tin-ore", {amount=1.25})
	end
end

------------------------------------------------------------------------------- BZ: Titanium

if mods["bztitanium"] then
	data:extend({
		{
			type = "item",
			name = "crushed-titanium-ore",
			icon = "__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png",
			pictures = {
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore-1.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore-2.png", scale=0.5},
			},
			subgroup = "raw-resource",
			order = data.raw.item["titanium-ore"].order.."-c[crushed]",
			inventory_move_sound = item_sounds.resource_inventory_move,
			pick_sound = item_sounds.resource_inventory_pickup,
			drop_sound = item_sounds.resource_inventory_move,
			stack_size = 100,
			weight = 2 * kg
		}
	})

	if mods["space-age"] then
		frep.replace_ingredient("titanium-in-foundry", "titanium-ore", "crushed-titanium-ore")
		frep.scale_ingredient("titanium-in-foundry", "crushed-titanium-ore", {amount=2})
		ftech.add_unlock("tungsten-steel", "crushed-titanium-ore")
		CrushingIndustry.add_smelting_productivity("titanium-in-foundry")
	else
		-- In space age, titanium is only smelted with the foundry starting from Vulcanus
		data:extend({
			{
				type = "recipe",
				name = "crushed-titanium-smelting",
				localised_name = {"recipe-name.crushed-smelting", {"item-name.titanium-plate"}},
				icons = {
					{icon="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png", shift={-12, -12}, scale=0.4},
					{icon="__bztitanium__/graphics/icons/titanium-plate.png", draw_background=true}
				},
				categories = {"smelting"},
				order = data.raw.recipe["titanium-plate"].order.."-c[crushed]",
				enabled = false,
				allow_productivity = true,
				auto_recycle = false,
				hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value == true,
				energy_required = 3.2,
				ingredients = {{type="item", name="crushed-titanium-ore", amount=10}},
				results = {{type="item", name="titanium-plate", amount=1}},
				main_product = "titanium-plate",
			}
		})

		ftech.add_unlock("titanium-processing", "crushed-titanium-ore")
		ftech.add_unlock("titanium-processing", "crushed-titanium-smelting")
	end

	if settings.startup["crushing-industry-byproducts"].value then
		frep.add_result("crushed-titanium-ore", CrushingIndustry.make_crushing_byproduct("iron-ore", CrushingIndustry.FLAVOR_BYPRODUCT), false)
	end
end

--===========================================================================--

end
