local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

if mods["bzlead"] then
  if settings.startup["crushing-industry-ore"].value then
    ftech.add_unlock("ore-crushing", "crushed-lead-ore")
    ftech.add_unlock("ore-crushing", "crushed-lead-smelting")

    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-lead-ore", {type="item", name="lead-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
    end

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
      frep.add_result("crushed-tin-ore", {type="item", name="tin-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
      frep.add_result("crushed-tin-ore", {type="item", name="sand", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
    end

    if mods["space-age"] then
      frep.replace_ingredient("molten-tin", "tin-ore", "crushed-tin-ore")
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
      frep.add_result("crushed-titanium-ore", {type="item", name="titanium-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
      frep.add_result("crushed-titanium-ore", {type="item", name="iron-ore", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
    end
  end
end
