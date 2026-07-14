local frep = require("__fdsl__.lib.recipe")

local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local REMIX = settings.startup["crushing-industry-recipe-mode"].value == "remix"

--===========================================================================--

if settings.startup["crushing-industry-glass"].value then

------------------------------------------------------------------------------- Glass

data:extend({
	{
		type = "item",
		name = "glass",
		icon = "__crushing-industry__/graphics/icons/glass.png",
		subgroup = "raw-material",
		order = "a[smelting]-d[glass]",
		stack_size = 100,
		weight = 1 * kg,
		random_tint_color = {0.85, 1, 0.85, 0.85}
	},
	{
		type = "recipe",
		name = "glass",
		categories = {"smelting"},
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = REMIX and 3.2 or 6.4,
		ingredients = {{type="item", name="sand", amount=5}},
		results = {{type="item", name="glass", amount=2}}
	}
})

frep.add_ingredient("lab", {type="item", name="glass", amount=10})
frep.replace_ingredient("chemical-plant", "iron-gear-wheel", {type="item", name="glass", amount=10})
frep.add_ingredient("solar-panel", {type="item", name="glass", amount=10})
frep.add_ingredient("night-vision-equipment", {type="item", name="glass", amount=2})
frep.add_ingredient("display-panel", {type="item", name="glass", amount=2})
frep.add_ingredient("small-lamp", {type="item", name="glass", amount=2})
frep.add_ingredient("laser-turret", {type="item", name="glass", amount=20})
frep.add_ingredient("rail-signal", {type="item", name="glass", amount=1})
frep.add_ingredient("rail-chain-signal", {type="item", name="glass", amount=1})

if mods["space-age"] then
	data:extend({
		{
			type = "fluid",
			name = "molten-glass",
			icon = "__crushing-industry__/graphics/icons/fluid/molten-glass.png",
			subgroup = "fluid",
			order = "b[new-fluid]-b[vulcanus]-g[molten-glass]",
			default_temperature = 1500,
			max_temperature = 2000,
			heat_capacity = "0.01kJ",
			base_color = {0.4, 0.6, 0.83},
			flow_color = {0.5, 0.78, 0.93},
			auto_barrel = false
		},
		{
			type = "recipe",
			name = "molten-glass",
			icon = "__crushing-industry__/graphics/icons/sand-melting.png",
			categories = {"metallurgy"},
			subgroup = "vulcanus-processes",
			order = "a[melting]-d[molten-glass]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			energy_required = 32,
			ingredients = {
				{type="item", name="sand", amount=REMIX and 150 or 75},
				{type="item", name="calcite", amount=1}
			},
			results = {{type="fluid", name="molten-glass", amount=500}},
			main_product = "molten-glass"
		},
		{
			type = "recipe",
			name = "casting-glass",
			icon = "__crushing-industry__/graphics/icons/casting-glass.png",
			categories = {"metallurgy"},
			subgroup = "vulcanus-processes",
			order = "b[casting]-c[x-glass]",
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
			allow_decomposition = false,
			energy_required = REMIX and 3.2 or 6.4,
			ingredients = {{type="fluid", name="molten-glass", amount=REMIX and 30 or 20, fluidbox_multiplier=10}},
			results = {{type="item", name="glass", amount=2}}
		}
	})

	frep.replace_ingredient("holmium-solution", "stone", {type="item", name="sand", amount=2})
	frep.replace_ingredient("electrolyte", "stone", {type="item", name="sand", amount=3})
	frep.add_ingredient("biochamber", {type="item", name="glass", amount=50})
	frep.add_ingredient("agricultural-tower", {type="item", name="glass", amount=20})
	frep.add_ingredient("cryogenic-plant", {type="item", name="glass", amount=50})

	if settings.startup["crushing-industry-byproducts"].value and not mods["science-bottles"] then
		frep.add_ingredient("space-science-pack", {type="item", name="glass", amount=1})
	end
end

--===========================================================================--

end
