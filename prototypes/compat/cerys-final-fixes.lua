if mods["Cerys-Moon-of-Fulgora"] then
	PlanetsLib.remove_surface_condition(data.raw.recipe["carbonic-asteroid-crushing"], "cerys-ambient-radiation")
	PlanetsLib.remove_surface_condition(data.raw.recipe["advanced-carbonic-asteroid-crushing"], "cerys-ambient-radiation")
	if settings.startup["crushing-industry-ore"].value then
		PlanetsLib.remove_surface_condition(data.raw.recipe["crushed-tungsten-ore"], "cerys-ambient-radiation")
	end
end
