local ftech = require("__fdsl__.lib.technology")

local starting_planet = mods["any-planet-start"] and settings.startup["aps-planet"].value or "nauvis"

-------------------------------------------------------------------------- Basic crushers

if mods["aai-industry"] then
  ftech.add_unlock("burner-mechanics", "burner-crusher")
elseif not mods["alloy-smelting"] then
  local crushing_tech = (starting_planet == "vulcanus" and "steel-processing") or (starting_planet == "fulgora" and "automation") or "steam-power"
  if not mods["lignumis"] then
    ftech.add_unlock(crushing_tech, "burner-crusher")
  end
  ftech.add_unlock(crushing_tech, "sand")
end

ftech.add_unlock("engine", "electric-crusher")

-------------------------------------------------------------------------- Big crusher

if settings.startup["crushing-industry-big-crusher"].value then
  if mods["space-age"] then
    ftech.add_unlock("tungsten-steel", "big-crusher")
  else
    ftech.add_unlock("advanced-material-processing-2", "big-crusher")
  end
end

-------------------------------------------------------------------------- Space crusher

if mods["space-age"] and settings.startup["crushing-industry-space-crusher"].value then
  -- Don't modify technologies if Muluna is present
  if not mods["planet-muluna"] then
    ftech.remove_unlock("space-platform", "crusher")
    ftech.add_prereq("asteroid-reprocessing", "space-crushing")
    ftech.add_cost_ingredient("asteroid-reprocessing", "production-science-pack")
    ftech.add_prereq("advanced-asteroid-processing", "space-crushing")
  end
end

-------------------------------------------------------------------------- Glass

if settings.startup["crushing-industry-glass"].value then
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
  ftech.add_unlock("concrete", "crushed-iron-ore")

  if mods["space-age"] then
    ftech.add_unlock("tungsten-steel", "crushed-tungsten-ore")
    ftech.add_unlock("tungsten-steel", "crushed-tungsten-carbide")
    ftech.add_unlock("holmium-processing", "holmium-powder")

    if mods["scrap-industry"] and mods["scrap-industry"] >= "0.8.0" then
      ftech.add_unlock("lithium-processing", "lithium-dust")
    end
  end
end

-------------------------------------------------------------------------- Concrete mix

if settings.startup["crushing-industry-concrete-mix"].value then
  ftech.add_unlock("concrete", "concrete-mix")
  ftech.add_unlock("concrete", "reconstituted-concrete-mix")

  if mods["space-age"] then
    ftech.add_unlock("foundry", "concrete-mix-from-lava")
    ftech.add_unlock("foundry", "concrete-mix-from-molten-iron")
  end
end

-------------------------------------------------------------------------- Coal crushing

if settings.startup["crushing-industry-coal"].value then
  if starting_planet == "vulcanus" then
    ftech.add_unlock("oil-processing", "crushed-coal")
  elseif starting_planet == "fulgora" then
    ftech.add_unlock("explosives", "crushed-coal")
  elseif starting_planet == "gleba" then
    ftech.add_unlock("sulfur-processing", "crushed-coal")
  else
    ftech.add_unlock("oil-processing", "crushed-coal")
  end
end
