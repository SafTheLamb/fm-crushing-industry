local frep = require("__fdsl__.lib.recipe")

local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local REMIX = settings.startup["crushing-industry-recipe-mode"].value == "remix"

--===========================================================================--

if settings.startup["crushing-industry-coal"].value then

-------------------------------------------------------------------------------

data:extend({
	{
		type = "item",
		name = "crushed-coal",
		pictures = {
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-coal.png", scale=0.5, mipmap_count=4},
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-coal-1.png", scale=0.5, mipmap_count=4},
			{size=64, filename="__crushing-industry__/graphics/icons/crushed-coal-2.png", scale=0.5, mipmap_count=4},
		},
		icon = "__crushing-industry__/graphics/icons/crushed-coal.png",
		subgroup = "raw-resource",
		order = "b[coal]-c[crushed]",
		fuel_category = "chemical",
		fuel_value = "3.2MJ",
		inventory_move_sound = item_sounds.resource_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.resource_inventory_move,
		stack_size = 100,
		weight = 2 * kg,
		random_tint_color = item_tints.yellowing_coal
	},
	{
		type = "recipe",
		name = "crushed-coal",
		localised_name = {"recipe-name.coal-crushing"},
		icons = CrushingIndustry.make_crushing_icons("coal"),
		categories = {"basic-crushing"},
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = 1.2,
		ingredients = {{type="item", name="coal", amount=1}},
		results = {
			{type="item", name="crushed-coal", amount=1, extra_count_fraction=0.5},
			CrushingIndustry.make_crushing_byproduct("coal"),
		},
		main_product = "crushed-coal"
	}
})

-------------------------------------------------------------------------------

end