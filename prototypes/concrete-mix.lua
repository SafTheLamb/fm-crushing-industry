local frep = require("__fdsl__.lib.recipe")

local REMIX = settings.startup["crushing-industry-recipe-mode"].value == "remix"

--===========================================================================--

if settings.startup["crushing-industry-concrete-mix"].value then

------------------------------------------------------------------------------- Base

data:extend({
	{
		type = "fluid",
		name = "concrete-mix",
		icon = "__crushing-industry__/graphics/icons/fluid/concrete-mix.png",
		subgroup = "fluid",
		order = "a[fluid]-c[concrete]",
		default_temperature = 25,
		base_color = {0.25, 0.25, 0.25},
		flow_color = {0.45, 0.45, 0.45},
	},
	{
		type = "recipe",
		name = "concrete-mix",
		categories = {"crafting-with-fluid"},
		subgroup = "fluid-recipes",
		order = "d[other-chemistry]-C[concrete-mix]",
		enabled = false,
		allow_productivity = true,
		allow_decomposition = false,
		energy_required = 2,
		ingredients = {
			{type="item", name="iron-ore", amount=1},
			{type="item", name="sand", amount=REMIX and 20 or 10},
			{type="fluid", name="water", amount=100}
		},
		results = {{type="fluid", name="concrete-mix", amount=100}}
	},
	{
		type = "recipe",
		name = "reconstituted-concrete-mix",
		icon = "__crushing-industry__/graphics/icons/reconstituted-concrete-mix.png",
		categories = {"crafting-with-fluid"},
		subgroup = "fluid-recipes",
		order = "d[other-chemistry]-C[concrete-mix]b",
		enabled = false,
		allow_productivity = false,
		allow_decomposition = false,
		hide_from_signal_gui = false,
		auto_recycle = false,
		energy_required = 5,
		ingredients = {
			{type="item", name="concrete", amount=10},
			{type="fluid", name="water", amount=25}
		},
		results = {{type="fluid", name="concrete-mix", amount=25}}
	}
})

if REMIX then
	frep.scale_time("concrete", 0.5)
end

frep.remove_ingredient("refined-concrete", "water")

------------------------------------------------------------------------------- Space Age

if mods["space-age"] then
	data:extend({
		{
			type = "recipe",
			name = "concrete-mix-from-lava",
			icon = "__crushing-industry__/graphics/icons/fluid/concrete-mix-from-lava.png",
			categories = {"metallurgy"},
			subgroup = "vulcanus-processes",
			order = "a[melting]-a[lava-c]",
			enabled = false,
			allow_productivity = true,
			allow_decomposition = false,
			hide_from_signal_gui = false,
			energy_required = REMIX and 10 or 8,
			ingredients = {
				{type="fluid", name="lava", amount=500},
				{type="item", name="sand", amount=REMIX and 75 or 25},
				{type="fluid", name="water", amount=250}
			},
			results = {{type="fluid", name="concrete-mix", amount=250}}
		},
		{
			type = "recipe",
			name = "concrete-mix-from-molten-iron",
			icon = "__crushing-industry__/graphics/icons/fluid/concrete-mix-from-molten-iron.png",
			categories = {"metallurgy"},
			subgroup = "vulcanus-processes",
			order = "a[melting]-e[concrete-mix]",
			enabled = false,
			allow_productivity = true,
			allow_decomposition = false,
			hide_from_signal_gui = false,
			energy_required = REMIX and 30 or 16,
			ingredients = {
				{type="fluid", name="molten-iron", amount=50},
				{type="item", name="sand", amount=REMIX and 150 or 50},
				{type="fluid", name="water", amount=500}
			},
			results = {{type="fluid", name="concrete-mix", amount=500}}
		}
	})

	data.raw.recipe["concrete-from-molten-iron"].hidden = true
	frep.add_category("concrete", "metallurgy")
end

--===========================================================================--

end
