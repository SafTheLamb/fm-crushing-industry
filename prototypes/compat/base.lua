if settings.startup["crushing-industry-ore"].value then
  CrushingIndustry.crushable_items["iron-ore"] = {type="item", name="iron-ore", scale=1.5}
  CrushingIndustry.crushable_items["copper-ore"] = {type="item", name="iron-ore", scale=1.5}
end

if settings.startup["crushing-industry-concrete-mix"].value then
  CrushingIndustry.crushable_items["concrete"] = {type="fluid", name="concrete-mix", scale=10}
  CrushingIndustry.crushable_items["refined-concrete"] = {type="fluid", name="concrete-mix", scale=50, auto_convert=false}
  CrushingIndustry.recipes["hazard-concrete"] = {ignore=true}
  CrushingIndustry.recipes["refined-hazard-concrete"] = {ignore=true}
  CrushingIndustry.recipes["reconstituted-concrete-mix"] = {ignore=true}
end
