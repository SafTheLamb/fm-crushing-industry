local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

-------------------------------------------------------------------------- Basic crushers

if mods["aai-industry"] then
  ftech.add_unlock("burner-mechanics", "burner-crusher")
elseif not mods["alloy-smelting"] then
  ftech.add_unlock("steam-power", "burner-crusher")
  ftech.add_unlock("steam-power", "sand")
end

if settings.startup["crushing-industry-ore"].value then
  ftech.add_unlock("ore-crushing", "electric-crusher")
else
  ftech.add_unlock("engine", "electric-crusher")
end

-------------------------------------------------------------------------- Big crusher

if settings.startup["crushing-industry-big-crusher"].value then
  if mods["space-age"] then
    ftech.add_unlock("tungsten-steel", "big-crusher")
  else
    ftech.add_unlock("advanced-material-processing-2", "big-crusher")
  end
end

-------------------------------------------------------------------------- Space crusher

if mods["space-age"] then
  -- always rename it to avoid confusion
  data.raw["assembling-machine"]["crusher"].localised_name = {"entity-name.space-crusher"}
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing")
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing-or-crafting")
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing-or-hand-crafting")
  
  -- upgrade SA's Crusher to the Space Crusher
  if settings.startup["crushing-industry-space-crusher"].value then
    data.raw["assembling-machine"]["crusher"].crafting_speed = 2
    data.raw["assembling-machine"]["crusher"].module_slots = 4
    data.raw["assembling-machine"]["crusher"].effect_receiver = {base_effect={quality=1.25, productivity=0.25}}
    data.raw["assembling-machine"]["crusher"].energy_usage = "1080kW"

    frep.add_ingredient("crusher", {type="item", name="quality-module-2", amount=4})

    if not mods["planet-muluna"] then
      ftech.remove_unlock("space-platform", "crusher")
      ftech.add_prereq("asteroid-reprocessing", "space-crushing")
      ftech.add_cost_ingredient("asteroid-reprocessing", "production-science-pack")
      ftech.add_prereq("advanced-asteroid-processing", "space-crushing")
    end
  end
end

-------------------------------------------------------------------------- Sand & glass

if mods["aai-industry"] or mods["Glass"] then
  data.raw.recipe["sand"].category = "basic-crushing-or-hand-crafting"
end

if settings.startup["crushing-industry-byproducts"].value then
  frep.add_result("sand", {type="item", name="stone", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
  frep.add_result("sand", {type="item", name="coal", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
end

if mods["space-age"] then
  frep.replace_ingredient("holmium-solution", "stone", {type="item", name="sand", amount=1})
  frep.replace_ingredient("electrolyte", "stone", {type="item", name="sand", amount=1})
end

if settings.startup["crushing-industry-glass"].value then
  frep.add_ingredient("lab", {type="item", name="glass", amount=10})
  frep.replace_ingredient("chemical-plant", "iron-gear-wheel", {type="item", name="glass", amount=10})
  frep.add_ingredient("solar-panel", {type="item", name="glass", amount=10})
  frep.add_ingredient("display-panel", {type="item", name="glass", amount=2})
  frep.add_ingredient("small-lamp", {type="item", name="glass", amount=2})
  frep.add_ingredient("laser-turret", {type="item", name="glass", amount=20})
  
  frep.add_ingredient("biochamber", {type="item", name="glass", amount=50})
  frep.add_ingredient("agricultural-tower", {type="item", name="glass", amount=20})
  frep.add_ingredient("cryogenic-plant", {type="item", name="glass", amount=50})

  if not mods["aai-industry"] then
    ftech.add_unlock("electronics", "glass")
  end

  if mods["space-age"] then
    ftech.add_unlock("foundry", "molten-glass")
    ftech.add_unlock("foundry", "casting-glass")
  end
end

-------------------------------------------------------------------------- Ore crushing

if settings.startup["crushing-industry-ore"].value then
  frep.replace_ingredient("concrete", "iron-ore", "crushed-iron-ore")
  frep.scale_ingredient("molten-iron", "crushed-iron-ore", {amount=2})

  if settings.startup["crushing-industry-byproducts"].value then
    frep.add_result("crushed-iron-ore", {type="item", name="iron-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
    frep.add_result("crushed-iron-ore", {type="item", name="sand", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
    frep.add_result("crushed-copper-ore", {type="item", name="copper-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
    frep.add_result("crushed-copper-ore", {type="item", name="sand", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
  end
  
  if mods["space-age"] then
    frep.replace_ingredient("molten-iron", "iron-ore", "crushed-iron-ore")
    frep.scale_ingredient("molten-iron", "crushed-iron-ore", {amount=1.5})
    frep.replace_ingredient("molten-copper", "copper-ore", "crushed-copper-ore")
    frep.scale_ingredient("molten-copper", "crushed-copper-ore", {amount=1.5})

    frep.replace_ingredient("advanced-thruster-oxidizer", "iron-ore", "crushed-iron-ore")
    frep.scale_ingredient("advanced-thruster-oxidizer", "crushed-iron-ore", {amount=2.5})
    
    ftech.add_unlock("tungsten-steel", "crushed-tungsten-ore")
    frep.replace_ingredient("tungsten-plate", "tungsten-ore", "crushed-tungsten-ore")
    frep.scale_ingredient("tungsten-plate", "crushed-tungsten-ore", {amount=2.5})

    ftech.add_unlock("holmium-processing", "holmium-powder")
    frep.replace_ingredient("holmium-solution", "holmium-ore", "holmium-powder")

    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-tungsten-ore", {type="item", name="tungsten-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
      frep.add_result("crushed-tungsten-ore", {type="item", name=settings.startup["crushing-industry-coal"].value and "crushed-coal" or "coal", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
      if settings.startup["crushing-industry-big-crusher"].value then
        frep.add_result("crushed-tungsten-ore", {type="item", name="stone", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
      end
      frep.add_result("holmium-powder", {type="item", name="holmium-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
      frep.add_result("holmium-powder", {type="item", name="sand", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
    end
  end
end

-------------------------------------------------------------------------- Coal crushing


if settings.startup["crushing-industry-coal"].value then
  local function replace_coal_ingredient(recipe_name, scale)
    frep.replace_ingredient(recipe_name, "coal", "crushed-coal")
    frep.scale_ingredient(recipe_name, "crushed-coal", scale or {amount=2})
  end

  replace_coal_ingredient("coal-liquefaction", {amount=2.5})
  replace_coal_ingredient("explosives", {amount=3})
  replace_coal_ingredient("plastic-bar", {amount=3})
  if not (mods["alloy-smelting"] and settings.startup["alloy-smelting-coke"].value) then
    replace_coal_ingredient("carbon")
  end
  replace_coal_ingredient("poison-capsule")
  replace_coal_ingredient("slowdown-capsule")

  ftech.add_unlock("oil-processing", "crushed-coal")
  ftech.add_unlock("oil-processing", "crushed-grenade")

  if settings.startup["crushing-industry-byproducts"].value then
    frep.add_result("crushed-coal", {type="item", name="coal", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
    frep.add_result("crushed-coal", {type="item", name="stone", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
  end
end

-------------------------------------------------------------------------- Asteroid crushing

if mods["space-age"] then
  if mods["Rocky-Asteroids"] and not settings.startup["crushing-industry-byproducts"].value then
    data.raw["furnace"]["electric-crusher"].result_inventory_size = 3
  end

  -- byproducts from asteroid crushing
  if settings.startup["crushing-industry-byproducts"].value and not mods["Rocky-Asteroids"] then
    frep.add_result("metallic-asteroid-crushing", {type="item", name="stone", amount=5, probability=0.33, show_details_in_recipe_tooltip=false})
    frep.add_result("carbonic-asteroid-crushing", {type="item", name="coal", amount=5, probability=0.33, show_details_in_recipe_tooltip=false})
    frep.add_result("oxide-asteroid-crushing", {type="item", name="sand", amount=5, probability=0.33, show_details_in_recipe_tooltip=false})

    if settings.startup["crushing-industry-ore"].value and not mods["cupric-astroids"] then
      frep.add_result("advanced-metallic-asteroid-crushing", {type="item", name="crushed-iron-ore", amount=5, probability=0.15, show_details_in_recipe_tooltip=false})
      frep.add_result("advanced-metallic-asteroid-crushing", {type="item", name="crushed-copper-ore", amount=2, probability=0.15, show_details_in_recipe_tooltip=false})
    else
      frep.add_result("advanced-metallic-asteroid-crushing", {type="item", name="sand", amount=5, probability=0.15, show_details_in_recipe_tooltip=false})
      frep.add_result("advanced-metallic-asteroid-crushing", {type="item", name="stone", amount=2, probability=0.15, show_details_in_recipe_tooltip=false})
    end
    frep.add_result("advanced-carbonic-asteroid-crushing", {type="item", name=settings.startup["crushing-industry-coal"].value and "crushed-coal" or "coal", amount=5, probability=0.15, show_details_in_recipe_tooltip=false})
    frep.add_result("advanced-carbonic-asteroid-crushing", {type="item", name=settings.startup["crushing-industry-coal"].value and "coal" or "stone", amount=2, probability=0.15, show_details_in_recipe_tooltip=false})

    if mods["cupric-asteroids"] then
      frep.add_result("cupric-asteroid-crushing", {type="item", name="stone", amount=5, probability=0.15, show_details_in_recipe_tooltip=false})
      frep.add_result("advanced-cupric-asteroid-crushing", {type="item", name="sand", amount=5, probability=0.15, show_details_in_recipe_tooltip=false})
      frep.add_result("advanced-cupric-asteroid-crushing", {type="item", name="stone", amount=2, probability=0.15, show_details_in_recipe_tooltip=false})
    end
  end

  if settings.startup["crushing-industry-glass"].value then
    if settings.startup["crushing-industry-byproducts"].value or mods["Rocky-Asteroids"] then
      frep.add_ingredient("space-science-pack", {type="item", name="glass", amount=1})
    end
  end

  -- Update basic asteroid crushing to be craftable in the basic crusher
  data.raw.recipe["metallic-asteroid-crushing"].category = "basic-crushing"
  data.raw.recipe["carbonic-asteroid-crushing"].category = "basic-crushing"
  data.raw.recipe["oxide-asteroid-crushing"].category = "basic-crushing"
  if mods["cupric-asteroids"] then
    data.raw.recipe["cupric-asteroid-crushing"].category = "basic-crushing"
  end
end

-------------------------------------------------------------------------- BZ Ores

if settings.startup["crushing-industry-ore"].value then
  if mods["bzlead"] then
    ftech.add_unlock("ore-crushing", "crushed-lead-ore")
    ftech.add_unlock("ore-crushing", "crushed-lead-smelting")

    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-lead-ore", {type="item", name="lead-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
    end

    if mods["space-age"] then
      if data.raw.recipe["alternative-metallic-asteroid-crushing"] then
        data.raw.recipe["alternative-metallic-asteroid-crushing"].category = "basic-crushing"
      end
      data.raw["furnace"]["electric-crusher"].result_inventory_size = 3
      frep.replace_ingredient("molten-lead", "lead-ore", "crushed-lead-ore")
      frep.replace_result("molten-lead", "copper-ore", "crushed-copper-ore")
    end
  end

  if mods["bztin"] then
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

  if mods["bztitanium"] then
    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-titanium-ore", {type="item", name="titanium-ore", amount=1, probability=0.05, show_details_in_recipe_tooltip=false})
      frep.add_result("crushed-titanium-ore", {type="item", name="iron-ore", amount=1, probability=0.02, show_details_in_recipe_tooltip=false})
    end
    
    if mods["space-age"] then
      frep.replace_ingredient("titanium-in-foundry", "titanium-ore", "crushed-titanium-ore")
      ftech.add_unlock("tungsten-steel", "crushed-titanium-ore")
    else
      ftech.add_unlock("titanium-processing", "crushed-titanium-ore")
      ftech.add_unlock("titanium-processing", "crushed-titanium-smelting")
    end
  end
end