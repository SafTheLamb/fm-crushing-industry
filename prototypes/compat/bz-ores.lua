local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

if mods["bzlead"] then
  if settings.startup["crushing-industry-ore"].value then
    ftech.add_unlock("ore-crushing", "crushed-lead-ore")
    ftech.add_unlock("ore-crushing", "crushed-lead-smelting")

    if mods["space-age"] then
      if data.raw.recipe["alternative-metallic-asteroid-crushing"] then
        data.raw.recipe["alternative-metallic-asteroid-crushing"].category = "crushing-or-crafting"
      end
      data.raw["furnace"]["electric-crusher"].result_inventory_size = 3
      frep.replace_ingredient("molten-lead", "lead-ore", "crushed-lead-ore")
      frep.scale_ingredient("molten-lead", "crushed-lead-ore", {amount=1.5})
      frep.replace_result("molten-lead", "copper-ore", "crushed-copper-ore")
    end
  end
end

if mods["bztin"] then
  if settings.startup["crushing-industry-ore"].value then
    ftech.add_unlock("ore-crushing", "crushed-tin-ore")
    ftech.add_unlock("ore-crushing", "crushed-tin-smelting")

    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-tin-ore", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
    end

    if mods["space-age"] then
      frep.replace_ingredient("molten-tin", "tin-ore", "crushed-tin-ore")
      frep.scale_ingredient("molten-lead", "crushed-tin-ore", {amount=1.25})
    end
  end
end

if mods["bztitanium"] then
  if settings.startup["crushing-industry-ore"].value then
    if mods["space-age"] then
      frep.replace_ingredient("titanium-in-foundry", "titanium-ore", "crushed-titanium-ore")
      frep.scale_ingredient("titanium-in-foundry", "crushed-titanium-ore", {amount=2})
      ftech.add_unlock("tungsten-steel", "crushed-titanium-ore")
    else
      ftech.add_unlock("titanium-processing", "crushed-titanium-ore")
      ftech.add_unlock("titanium-processing", "crushed-titanium-smelting")
    end

    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-titanium-ore", CrushingIndustry.make_crushing_byproduct("iron-ore", CrushingIndustry.FLAVOR_BYPRODUCT), false)
    end
  end
end
