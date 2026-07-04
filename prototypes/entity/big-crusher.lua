local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

if settings.startup["crushing-industry-big-crusher"].value then
	data:extend({
		{
			type = "item",
			name = "big-crusher",
			icon = "__crushing-industry__/graphics/icons/big-crusher.png",
			subgroup = "extraction-machine",
			order = "a[items]-f[big-crusher]",
			hidden = not settings.startup["crushing-industry-big-crusher"].value,
			inventory_move_sound = item_sounds.mechanical_large_inventory_move,
			pick_sound = item_sounds.mechanical_large_inventory_move,
			drop_sound = item_sounds.mechanical_large_inventory_move,
			place_result = "big-crusher",
			stack_size = 20,
			default_import_location = mods["space-age"] and "vulcanus" or nil,
			weight = 100 * kg
		},
		{
			type = "recipe",
			name = "big-crusher",
			surface_conditions = mods["space-age"] and {{property="pressure", min=4000, max=4000}} or nil,
			enabled = false,
			categories = {mods["space-age"] and "metallurgy" or "crafting"},
			energy_required = 30,
			ingredients = mods["space-age"] and {
				{type="item", name="electric-crusher", amount=1},
				{type="fluid", name="molten-iron", amount=200},
				{type="item", name="tungsten-carbide", amount=50},
				{type="item", name="electric-engine-unit", amount=8},
				{type="item", name="advanced-circuit", amount=5},
			} or {
				{type="item", name="electric-crusher", amount=1},
				{type="item", name="steel-plate", amount=50},
				{type="item", name="processing-unit", amount=10},
				{type="item", name="electric-engine-unit", amount=10},
				{type="item", name="productivity-module", amount=4}
			},
			results = {{type="item", name="big-crusher", amount=1}}
		}
	})
end
