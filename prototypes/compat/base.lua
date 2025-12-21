CrushingIndustry.concrete_recipes["hazard-concrete"] = {ignore=true}
CrushingIndustry.concrete_recipes["refined-hazard-concrete"] = {ignore=true}
CrushingIndustry.concrete_recipes["reconstituted-concrete-mix"] = {ignore=true}
CrushingIndustry.concrete_items["concrete"] = {scalar=10}
CrushingIndustry.concrete_items["refined-concrete"] = {scalar=50, auto_convert=false}

if settings.startup["crushing-industry-ore"].value then
	CrushingIndustry.add_smelting_productivity("crushed-iron-smelting")
	CrushingIndustry.add_smelting_productivity("crushed-copper-smelting")
end
