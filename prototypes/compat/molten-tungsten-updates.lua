local frep = require("__fdsl__.lib.recipe")

if mods["molten-tungsten"] then
	if settings.startup["crushing-industry-ore"].value then
		frep.replace_ingredient("molten-tungsten", "tungsten-ore", "crushed-tungsten-ore")
		frep.scale_ingredient("molten-tungsten", "crushed-tungsten-ore", {amount=1.5})
	end
end
