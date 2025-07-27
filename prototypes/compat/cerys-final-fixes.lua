if mods["Cerys-Moon-of-Fulgora"] then
	local fulgoran_crusher = data.raw["assembling-machine"]["cerys-fulgoran-crusher"]
	if fulgoran_crusher then
		table.insert(fulgoran_crusher.crafting_categories, "basic-crushing")
		table.insert(fulgoran_crusher.crafting_categories, "basic-crushing-or-crafting")
		table.insert(fulgoran_crusher.crafting_categories, "basic-crushing-or-hand-crafting")
		table.insert(fulgoran_crusher.crafting_categories, "crushing-or-crafting")
	end
	PlanetsLib.remove_surface_condition(data.raw.recipe["carbonic-asteroid-crushing"], "cerys-ambient-radiation")
	PlanetsLib.remove_surface_condition(data.raw.recipe["advanced-carbonic-asteroid-crushing"], "cerys-ambient-radiation")
	if settings.startup["crushing-industry-ore"].value then
		PlanetsLib.remove_surface_condition(data.raw.recipe["crushed-tungsten-ore"], "cerys-ambient-radiation")
	end
end
