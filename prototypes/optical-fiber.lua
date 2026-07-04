local frep = require("__fdsl__.lib.recipe")

local item_sounds = require("__base__.prototypes.item_sounds")

------------------------------------------------------------------------------- Optical fiber

if settings.startup["crushing-industry-glass"].value then
	if settings.startup["crushing-industry-optical-fiber"].value then
		data:extend({
			{
				type = "item",
				name = "optical-fiber",
				icon = "__crushing-industry__/graphics/icons/optical-fiber.png",
				subgroup = "intermediate-product",
				order = "a[basic-intermediates]-c[copper-cable]b",
				stack_size = 100,
				weight = 1 * kg,
			},
			{
				type = "recipe",
				name = "optical-fiber",
				categories = mods["space-age"] and {"electromagnetics", "crafting"} or {"crafting"},
				enabled = false,
				allow_productivity = true,
				energy_required = 2,
				ingredients = {
					{type="item", name="plastic-bar", amount=1},
					{type="item", name="copper-plate", amount=2},
					{type="item", name="glass", amount=2}
				},
				results = {{type="item", name="optical-fiber", amount=4}}
			}
		})

		local advanced_circuit_item = data.raw.item["advanced-circuit"]
		if advanced_circuit_item then
			advanced_circuit_item.weight = 1*kg
		end
		frep.replace_ingredient("advanced-circuit", "copper-cable", "optical-fiber")
		frep.scale_ingredient("advanced-circuit", "plastic-bar", {amount=0.5})
		frep.add_ingredient("processing-unit", {type="item", name="optical-fiber", amount=5})
		frep.scale_ingredient("processing-unit", "electronic-circuit", {amount=0.75})
		frep.add_ingredient("selector-combinator", {type="item", name="optical-fiber", amount=5})
		frep.add_ingredient("roboport", {type="item", name="optical-fiber", amount=45})
		frep.add_ingredient("personal-roboport-equipment", {type="item", name="optical-fiber", amount=10})
		frep.replace_ingredient("beacon", "copper-cable", "optical-fiber")
	end
end
