if settings.startup["crushing-industry-concrete-mix"].value then
  CrushingIndustry.recipes["hazard-concrete"] = {ignore=true}
  CrushingIndustry.recipes["refined-hazard-concrete"] = {ignore=true}
  CrushingIndustry.recipes["reconstituted-concrete-mix"] = {ignore=true}
  CrushingIndustry.crushable_items["concrete"] = {type="fluid", scale=10}
  CrushingIndustry.crushable_items["refined-concrete"] = {type="fluid", scale=50, auto_convert=false}
end
