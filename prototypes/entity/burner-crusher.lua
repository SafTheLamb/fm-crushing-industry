local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

data:extend({
	{
		type = "item",
		name = "burner-crusher",
		icon = "__crushing-industry__/graphics/icons/burner-crusher.png",
		subgroup = "extraction-machine",
		order = "a[items]-d[burner-crusher]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		place_result = "burner-crusher",
		random_tint_color = item_tints.iron_rust,
		stack_size = 50,
		weight = 20 * kg
	},
	{
		type = "recipe",
		name = "burner-crusher",
		enabled = false,
		ingredients = {
			{type="item", name="iron-plate", amount=6},
			{type="item", name="stone-brick", amount=5},
			mods["aai-industry"] and {type="item", name="motor", amount=4} or {type="item", name="iron-gear-wheel", amount=4}
		},
		results = {{type="item", name="burner-crusher", amount=1}}
	},
})
