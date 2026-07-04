local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

-------------------------------------------------------------------------- Electric crusher

data:extend({
	{
		type = "item",
		name = "electric-crusher",
		icon = "__crushing-industry__/graphics/icons/electric-crusher.png",
		subgroup = "extraction-machine",
		order = "a[items]-e[electric-crusher]",
		inventory_move_sound = item_sounds.mechanical_inventory_move,
		pick_sound = item_sounds.mechanical_inventory_pickup,
		drop_sound = item_sounds.mechanical_inventory_move,
		place_result = "electric-crusher",
		random_tint_color = item_tints.iron_rust,
		stack_size = 50,
		weight = 20 * kg
	},
	{
		type = "recipe",
		name = "electric-crusher",
		enabled = false,
		ingredients = {
			{type="item", name="steel-plate", amount=8},
			mods["aai-industry"] and {type="item", name="electric-motor", amount=4} or {type="item", name="engine-unit", amount=4},
			{type="item", name="electronic-circuit", amount=2},
			mods["aai-industry"] and {type="item", name="burner-crusher", amount=1} or {type="item", name="stone-brick", amount=5},
		},
		results = {{type="item", name="electric-crusher", amount=1}}
	}
})
