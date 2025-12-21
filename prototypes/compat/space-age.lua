if mods["space-age"] then
	CrushingIndustry.concrete_recipes["recycler"] = {ignore=true}
	CrushingIndustry.concrete_recipes["rail-ramp"] = {convert=true}
	CrushingIndustry.concrete_recipes["rail-support"] = {convert=true}

	if settings.startup["crushing-industry-ore"].value then
		CrushingIndustry.add_smelting_productivity("crushed-tungsten-carbide")
		CrushingIndustry.add_smelting_productivity("tungsten-plate")
		CrushingIndustry.add_molten_productivity("molten-iron")
		CrushingIndustry.add_molten_productivity("molten-copper")
	end

	if settings.startup["crushing-industry-glass"].value then
		CrushingIndustry.add_molten_productivity("molten-glass")
	end
end
