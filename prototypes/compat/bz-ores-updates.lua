local frep = require("__fdsl__.lib.recipe")

if data.raw.furnace["basic-crusher"] then
  data.raw.item["basic-crusher"].hidden = true
  data.raw.recipe["basic-crusher"].hidden = true
  data.raw.furnace["basic-crusher"].hidden = true
end

if mods["bzlead"] and mods["space-age"] then
  data.raw.recipe["alternative-metallic-asteroid-crushing"].hidden = true
  if settings.startup["crushing-industry-byproducts"].value then
    frep.remove_result("metallic-asteroid-crushing", "stone")
    -- frep.remove_result("advanced-metallic-asteroid-crushing", "stone")
  end
  frep.add_result("metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("iron-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 10, true), false, 2)
  -- frep.add_result("advanced-metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("iron-ore", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
end

if mods["bztin"] and mods["cupric-asteroids"] then
  data.raw.recipe["alternative-carbonic-asteroid-crushing"].hidden = true
  if settings.startup["crushing-industry-byproducts"].value then
    frep.remove_result("carbonic-asteroid-crushing", "coal")
    frep.remove_result("advanced-carbonic-asteroid-crushing", "coal")
  end
  frep.add_result("carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("tin-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
  frep.add_result("advanced-carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("tin-ore", CrushingIndustry.COMMON_BYPRODUCT, 3, true), false, 3)
end
