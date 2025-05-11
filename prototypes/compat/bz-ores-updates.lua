local frep = require("__fdsl__.lib.recipe")

if data.raw.furnace["basic-crusher"] then
  data.raw.item["basic-crusher"].hidden = true
  data.raw.recipe["basic-crusher"].hidden = true
  data.raw.furnace["basic-crusher"].hidden = true
end

-------------------------------------------------------------------------- BZ Lead

if mods["bzlead"] and mods["space-age"] then
  if data.raw.recipe["alternative-metallic-asteroid-crushing"] then
    data.raw.recipe["alternative-metallic-asteroid-crushing"].hidden = true
  end

  frep.reorder_result("advanced-metallic-asteroid-crushing", "lead-ore", 1)
  if settings.startup["crushing-industry-byproducts"].value then
    frep.remove_result("metallic-asteroid-crushing", "stone")
    if settings.startup["crushing-industry-ore"].value then
      frep.replace_result("advanced-metallic-asteroid-crushing", "crushed-iron-ore", "crushed-lead-ore")
      frep.reorder_result("advanced-metallic-asteroid-crushing", "crushed-lead-ore", 2)
    end
  end
  frep.add_result("metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("iron-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 10, true), false, 2)
  -- frep.add_result("advanced-metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("iron-ore", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
end

-------------------------------------------------------------------------- BZ Tin

if mods["bztin"] and mods["space-age"] then
  -- Prefer adding tin to cupric asteroids
  if mods["cupric-asteroids"] then
    if data.raw.recipe["cupric-asteroid-crushing-tin"] then
      data.raw.recipe["cupric-asteroid-crushing-tin"].hidden = true
    end

    if settings.startup["crushing-industry-byproducts"].value then
      frep.remove_result("cupric-asteroid-crushing", "stone")
      frep.remove_result("advanced-cupric-asteroid-crushing", "stone")
    end
    frep.add_result("cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("tin-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
    frep.add_result("advanced-cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("tin-ore", CrushingIndustry.COMMON_BYPRODUCT, 3, true), false, 3)
  else
    -- Otherwise add to carbonic asteroids
    if settings.startup["crushing-industry-byproducts"].value then
      frep.remove_result("carbonic-asteroid-crushing", "stone")
      frep.remove_result("advanced-carbonic-asteroid-crushing", "stone")
    end
    frep.add_result("carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("tin-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
    frep.add_result("advanced-carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("tin-ore", CrushingIndustry.COMMON_BYPRODUCT, 3, true), false, 3)
  end
end

-------------------------------------------------------------------------- BZ Carbon

if mods["bzcarbon"] and mods["space-age"] then
  if data.raw.recipe["alternative-carbonic-asteroid-crushing"] then
    data.raw.recipe["alternative-carbonic-asteroid-crushing"].hidden = true
  end

  if settings.startup["bzcarbon-enable-flake-graphite"].value == "yes" then
    if settings.startup["crushing-industry-byproducts"].value then
      frep.remove_result("carbonic-asteroid-crushing", "coal")
      frep.replace_result("advanced-carbonic-asteroid-crushing", "coal", "flake-graphite")
    end
    frep.add_result("carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("flake-graphite", CrushingIndustry.FREQUENT_BYPRODUCT, 10, true), false, 2)
  else
    frep.modify_result("carbonic-asteroid-crushing", "coal", {amount=10})
  end
  frep.add_result("advanced-carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("rough-diamond", CrushingIndustry.FREQUENT_BYPRODUCT, 3, true), false, 3)
end

-------------------------------------------------------------------------- Fixups

if data.raw.recipe["carbonic-asteroid-crushing"] then
  local num_results = #data.raw.recipe["carbonic-asteroid-crushing"].results
  if num_results > data.raw.furnace["electric-crusher"].result_inventory_size then
    data.raw.furnace["electric-crusher"].result_inventory_size = num_results
  end
end
