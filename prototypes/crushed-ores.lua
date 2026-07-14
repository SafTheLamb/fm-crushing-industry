local item_sounds = require("__base__.prototypes.item_sounds")

local REMIX = false --settings.startup["crushing-industry-recipe-mode"].value == "remix"

--===========================================================================--

if settings.startup["crushing-industry-ore"].value then

------------------------------------------------------------------------------- Iron

data:extend({
	{
		type = "item",
		name = "crushed-iron-ore",
		icon = "__crushing-industry__/graphics/icons/crushed-iron-ore.png",
		pictures = {
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-iron-ore.png", scale=0.5},
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-iron-ore-1.png", scale=0.5},
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-iron-ore-2.png", scale=0.5},
		},
		subgroup = "raw-resource",
		color_hint = { text = "I" },
		order = "e[iron-ore]-c[crushed]",
		inventory_move_sound = item_sounds.resource_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.resource_inventory_move,
		stack_size = 100,
		weight = 2 * kg
	},
	{
		type = "recipe",
		name = "crushed-iron-ore",
		icons = CrushingIndustry.make_crushing_icons("iron-ore"),
		localised_name = {"recipe-name.iron-ore-crushing"},
		categories = {"basic-crushing"},
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = 1.2,
		ingredients = {{type="item", name="iron-ore", amount=1}},
		results = {
			{type="item", name="crushed-iron-ore", amount=1, extra_count_fraction=0.5},
			CrushingIndustry.make_crushing_byproduct("iron-ore"),
		},
		main_product = "crushed-iron-ore"
	},
	{
		type = "recipe",
		name = "crushed-iron-smelting",
		localised_name = {"recipe-name.crushed-smelting", {"item-name.iron-plate"}},
		icons = {
			{icon="__crushing-industry__/graphics/icons/crushed-iron-ore.png", shift={-12, -12}, scale=0.4},
			{icon="__base__/graphics/icons/iron-plate.png", draw_background=true}
		},
		categories = {"smelting"},
		order = "a[smelting]-a[iron-plate]-c[crushed]",
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value == true,
		energy_required = 3.2,
		ingredients = {{type="item", name="crushed-iron-ore", amount=1}},
		results = {{type="item", name="iron-plate", amount=1}},
		main_product = "iron-plate",
	},
})

------------------------------------------------------------------------------- Copper

data:extend({
	{
		type = "item",
		name = "crushed-copper-ore",
		icon = "__crushing-industry__/graphics/icons/crushed-copper-ore.png",
		pictures = {
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-copper-ore.png", scale=0.5},
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-copper-ore-1.png", scale=0.5},
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-copper-ore-2.png", scale=0.5},
		},
		subgroup = "raw-resource",
		color_hint = { text = "C" },
		order = "f[copper-ore]-c[crushed]",
		inventory_move_sound = item_sounds.resource_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.resource_inventory_move,
		stack_size = 100,
		weight = 2 * kg
	},
	{
		type = "recipe",
		name = "crushed-copper-ore",
		localised_name = {"recipe-name.copper-ore-crushing"},
		icons = CrushingIndustry.make_crushing_icons("copper-ore"),
		categories = {"basic-crushing"},
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = 1.2,
		ingredients = {{type="item", name="copper-ore", amount=1}},
		results = {
			{type="item", name="crushed-copper-ore", amount=1, extra_count_fraction=0.5},
			CrushingIndustry.make_crushing_byproduct("copper-ore"),
		},
		main_product = "crushed-copper-ore"
	},
	{
		type = "recipe",
		name = "crushed-copper-smelting",
		localised_name = {"recipe-name.crushed-smelting", {"item-name.copper-plate"}},
		icons = {
			{icon="__crushing-industry__/graphics/icons/crushed-copper-ore.png", shift={-12, -12}, scale=0.4},
			{icon="__base__/graphics/icons/copper-plate.png", draw_background=true}
		},
		categories = {"smelting"},
		order = "a[smelting]-b[copper-plate]-c[crushed]",
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value == true,
		energy_required = 3.2,
		ingredients = {{type="item", name="crushed-copper-ore", amount=1}},
		results = {{type="item", name="copper-plate", amount=1}},
		main_product = "copper-plate",
	}
})

------------------------------------------------------------------------------- Tungsten

if mods["space-age"] then
	data:extend({
		{
			type = "item",
			name = "crushed-tungsten-ore",
			icon = "__crushing-industry__/graphics/icons/crushed-tungsten-ore.png",
			pictures = {
				{size=64, filename="__crushing-industry__/graphics/icons/crushed-tungsten-ore.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/crushed-tungsten-ore-1.png", scale=0.5},
				{size=64, filename="__crushing-industry__/graphics/icons/crushed-tungsten-ore-2.png", scale=0.5},
			},
			subgroup = "vulcanus-processes",
			color_hint = { text = "T" },
			order = "c[tungsten]-a[tungsten-ore]-c[crushed]",
			inventory_move_sound = item_sounds.resource_inventory_move,
			pick_sound = item_sounds.resource_inventory_pickup,
			drop_sound = item_sounds.resource_inventory_move,
			stack_size = 100,
			default_import_location = "vulcanus",
			weight = 10*kg
		},
		{
			type = "recipe",
			name = "crushed-tungsten-ore",
			localised_name = {"recipe-name.tungsten-ore-crushing"},
			icons = CrushingIndustry.make_crushing_icons("tungsten-ore"),
			categories = {settings.startup["crushing-industry-big-crusher"].value and "crushing" or "basic-crushing"},
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = REMIX and 2.4 or 5,
			ingredients = {{type="item", name="tungsten-ore", amount=1}},
			results = {
				{type="item", name="crushed-tungsten-ore", amount=1, extra_count_fraction=0.5},
				CrushingIndustry.make_crushing_byproduct("tungsten-ore"),
			},
			main_product = "crushed-tungsten-ore"
		},
		{
			type = "recipe",
			name = "crushed-tungsten-carbide",
			localised_name = {"recipe-name.crushed-smelting", {"item-name.tungsten-carbide"}},
			icons = {
				{icon="__crushing-industry__/graphics/icons/crushed-tungsten-ore.png", shift={-12, -12}, scale=0.4},
				{icon="__space-age__/graphics/icons/tungsten-carbide.png", draw_background=true}
			},
			categories = {"crafting-with-fluid"},
			subgroup = "vulcanus-processes",
			order = "c[tungsten]-b[tungsten-carbide]-c[crushed]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 1,
			ingredients = {
				{type="item", name="crushed-tungsten-ore", amount=REMIX and 2 or 3},
				{type="fluid", name="sulfuric-acid", amount=10},
				{type="item", name="carbon", amount=1}
			},
			results = {{type="item", name="tungsten-carbide", amount=1}},
			main_product = "tungsten-carbide"
		}
	})
end

------------------------------------------------------------------------------- Holmium

if mods["space-age"] then
	data:extend({
		{
			type = "item",
			name = "holmium-powder",
			pictures = {
				{size=64, filename="__crushing-industry__/graphics/icons/holmium-powder.png", scale=0.5, mipmap_count=4},
				{size=64, filename="__crushing-industry__/graphics/icons/holmium-powder-1.png", scale=0.5, mipmap_count=4},
			},
			icon = "__crushing-industry__/graphics/icons/holmium-powder.png",
			subgroup = "fulgora-processes",
			order = "b[holmium]-a[holmium-ore]-c[crushed]",
			inventory_move_sound = item_sounds.resource_inventory_move,
			pick_sound = item_sounds.resource_inventory_pickup,
			drop_sound = item_sounds.resource_inventory_move,
			stack_size = 100,
			default_import_location = "fulgora",
			weight = 2 * kg
		},
		{
			type = "recipe",
			name = "holmium-powder",
			localised_name = {"recipe-name.holmium-ore-crushing"},
			icons = CrushingIndustry.make_crushing_icons("holmium-ore"),
			categories = {"basic-crushing"},
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = REMIX and 1.5 or 5,
			ingredients = {{type="item", name="holmium-ore", amount=1}},
			results = {
				{type="item", name="holmium-powder", amount=REMIX and 2 or 1, extra_count_fraction=REMIX and 0 or 0.5},
				CrushingIndustry.make_crushing_byproduct("holmium-ore"),
			},
			main_product = "holmium-powder"
		},
	})
end

------------------------------------------------------------------------------- Molten ore



------------------------------------------------------------------------------- SI: Lithium

if mods["space-age"] and mods["scrap-industry"] then
	data:extend({
		{
			type = "recipe",
			name = "lithium-dust",
			localised_name = {"recipe-name.lithium-crushing"},
			icons = CrushingIndustry.make_crushing_icons("lithium"),
			categories = {"basic-crushing"},
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = REMIX and 1.2 or 2,
			ingredients = {{type="item", name="lithium", amount=1}},
			results = {
				{type="item", name="lithium-dust", amount=REMIX and 2 or 1, extra_count_fraction = REMIX and 0 or 0.5},
				CrushingIndustry.make_crushing_byproduct("lithium"),
			},
			main_product = "lithium-dust"
		}
	})
end

--===========================================================================--

end
