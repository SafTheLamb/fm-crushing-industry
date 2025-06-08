local frep = require("__fdsl__.lib.recipe")

-------------------------------------------------------------------------- Space crusher

if mods["space-age"] then
  -- always rename it to avoid confusion
  data.raw["assembling-machine"]["crusher"].localised_name = {"entity-name.space-crusher"}
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing")
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing-or-crafting")
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "basic-crushing-or-hand-crafting")
  table.insert(data.raw["assembling-machine"]["crusher"].crafting_categories, "crushing-or-crafting")
  table.insert(data.raw["assembling-machine"]["assembling-machine-2"].crafting_categories, "crushing-or-crafting")
  table.insert(data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories, "crushing-or-crafting")
  table.insert(data.raw.character.character.crafting_categories, "basic-crushing-or-hand-crafting")
  
  -- upgrade SA's Crusher to the Space Crusher
  if settings.startup["crushing-industry-space-crusher"].value then
    data.raw["assembling-machine"]["crusher"].crafting_speed = 1.5
    data.raw["assembling-machine"]["crusher"].module_slots = 4
    data.raw["assembling-machine"]["crusher"].effect_receiver = {base_effect={quality=1.25, productivity=0.25}}
    data.raw["assembling-machine"]["crusher"].energy_usage = "1080kW"

    frep.add_ingredient("crusher", {type="item", name="quality-module-2", amount=4})
  end
end

-------------------------------------------------------------------------- Sand & glass

if mods["aai-industry"] or mods["Glass"] then
  data.raw.recipe["sand"].category = "basic-crushing-or-hand-crafting"
  frep.add_category("sand", "basic-crushing")
end

if settings.startup["crushing-industry-byproducts"].value then
  frep.add_result("sand", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.FLAVOR_BYPRODUCT), false)
end

if mods["space-age"] then
  frep.replace_ingredient("holmium-solution", "stone", {type="item", name="sand", amount=2})
  frep.replace_ingredient("electrolyte", "stone", {type="item", name="sand", amount=3})
end

if settings.startup["crushing-industry-glass"].value then
  frep.add_ingredient("lab", {type="item", name="glass", amount=10})
  frep.replace_ingredient("chemical-plant", "iron-gear-wheel", {type="item", name="glass", amount=10})
  frep.add_ingredient("solar-panel", {type="item", name="glass", amount=10})
  frep.add_ingredient("night-vision-equipment", {type="item", name="glass", amount=2})
  frep.add_ingredient("display-panel", {type="item", name="glass", amount=2})
  frep.add_ingredient("small-lamp", {type="item", name="glass", amount=2})
  frep.add_ingredient("laser-turret", {type="item", name="glass", amount=20})
  frep.add_ingredient("rail-signal", {type="item", name="glass", amount=1})
  frep.add_ingredient("rail-chain-signal", {type="item", name="glass", amount=1})
  
  if mods["space-age"] then
    frep.add_ingredient("biochamber", {type="item", name="glass", amount=50})
    frep.add_ingredient("agricultural-tower", {type="item", name="glass", amount=20})
    frep.add_ingredient("cryogenic-plant", {type="item", name="glass", amount=50})

    if settings.startup["crushing-industry-byproducts"].value and not mods["science-bottles"] then
      frep.add_ingredient("space-science-pack", {type="item", name="glass", amount=1})
    end
  end
end

-------------------------------------------------------------------------- Ore crushing

if settings.startup["crushing-industry-ore"].value then
  frep.replace_ingredient("concrete", "iron-ore", "crushed-iron-ore")
  if settings.startup["crushing-industry-concrete-mix"].value then
    frep.replace_ingredient("concrete-mix", "iron-ore", "crushed-iron-ore")
  end

  if settings.startup["crushing-industry-byproducts"].value then
    frep.add_result("crushed-iron-ore", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
    frep.add_result("crushed-copper-ore", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
  end

  if mods["space-age"] then
    frep.replace_ingredient("molten-iron", "iron-ore", "crushed-iron-ore")
    frep.scale_ingredient("molten-iron", "crushed-iron-ore", {amount=1.5})
    frep.replace_ingredient("molten-copper", "copper-ore", "crushed-copper-ore")
    frep.scale_ingredient("molten-copper", "crushed-copper-ore", {amount=1.5})

    frep.replace_ingredient("advanced-thruster-oxidizer", "iron-ore", "crushed-iron-ore")
    frep.scale_ingredient("advanced-thruster-oxidizer", "crushed-iron-ore", {amount=2})

    frep.replace_ingredient("tungsten-plate", "tungsten-ore", "crushed-tungsten-ore")
    frep.scale_ingredient("tungsten-plate", "crushed-tungsten-ore", {amount=2})

    frep.replace_ingredient("holmium-solution", "holmium-ore", {type="item", name="holmium-powder", amount=3})

    if settings.startup["crushing-industry-byproducts"].value then
      frep.add_result("crushed-tungsten-ore", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.FLAVOR_BYPRODUCT), false)
      if settings.startup["crushing-industry-big-crusher"].value then
        frep.add_result("crushed-tungsten-ore", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FLAVOR_BYPRODUCT), false)
      end
      frep.add_result("holmium-powder", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FLAVOR_BYPRODUCT), false)
    end

    if mods["scrap-industry"] and mods["scrap-industry"] >= "0.8.0" then
      frep.replace_ingredient("fluoroketone", "lithium", "lithium-dust")
      frep.scale_ingredient("fluoroketone", "lithium-dust", {amount=2})
    end

    if mods["molten-tungsten"] then
      frep.replace_ingredient("molten-tungsten", "tungsten-ore", "crushed-tungsten-ore")
      frep.scale_ingredient("molten-tungsten", "crushed-tungsten-ore", {amount=1.5})
    end
  end
end

-------------------------------------------------------------------------- Concrete mix

if settings.startup["crushing-industry-concrete-mix"].value then
  if mods["quality"] then
    local recycling_lib = require("__quality__.prototypes.recycling")
    -- Generate recycling recipe before replacing the ingredients with concrete
    recycling_lib.generate_recycling_recipe(data.raw.recipe["concrete"])
    -- Override stone brick recycling to yield sand instead
    recycling_lib.generate_self_recycling_recipe(data.raw.item["stone-brick"])
    frep.replace_result("stone-brick-recycling", "stone-brick", {type="item", name="sand", amount=1, ignored_by_stats=1})
  end

  data.raw.recipe["concrete"].ingredients = {{type="fluid", name="concrete-mix", amount=100}}
  data.raw.recipe["concrete"].auto_recycle = false
  frep.remove_ingredient("refined-concrete", "water")

  if mods["space-age"] then
    data.raw.recipe["concrete-from-molten-iron"].hidden = true
    data.raw.recipe["concrete"].category = "metallurgy-or-assembling"
  end
end

-------------------------------------------------------------------------- Coal crushing


if settings.startup["crushing-industry-coal"].value then
  local function replace_coal_ingredient(recipe_name, scale)
    frep.replace_ingredient(recipe_name, "coal", "crushed-coal")
    frep.scale_ingredient(recipe_name, "crushed-coal", scale or {amount=2})
  end

  replace_coal_ingredient("coal-liquefaction", {amount=mods["space-age"] and 2.5 or 1.5})
  replace_coal_ingredient("explosives", {amount=2})
  replace_coal_ingredient("plastic-bar", {amount=2})
  if not (mods["alloy-smelting"] and settings.startup["alloy-smelting-coke"].value) then
    replace_coal_ingredient("carbon")
  end
  replace_coal_ingredient("poison-capsule")
  replace_coal_ingredient("slowdown-capsule")

  if settings.startup["crushing-industry-byproducts"].value then
    frep.add_result("crushed-coal", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FLAVOR_BYPRODUCT), false)
  end
end

-------------------------------------------------------------------------- Asteroid crushing

if mods["space-age"] then
  -- byproducts from asteroid crushing
  if settings.startup["crushing-industry-byproducts"].value then
    frep.add_result("metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
    frep.add_result("carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.FREQUENT_BYPRODUCT, 2, true), false, 2)
    frep.add_result("oxide-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)

    frep.add_result("advanced-metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
    frep.add_result("advanced-carbonic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("coal", CrushingIndustry.COMMON_BYPRODUCT, 2, true), false, 3)
    frep.add_result("advanced-oxide-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("sand", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
  
    if mods["cupric-asteroids"] then
      frep.add_result("cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.FREQUENT_BYPRODUCT, 5, true), false, 2)
      frep.add_result("advanced-cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("stone", CrushingIndustry.COMMON_BYPRODUCT, 5, true), false, 3)
    end

    if settings.startup["crushing-industry-ore"].value then
      frep.add_result("advanced-metallic-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("crushed-iron-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 3, true), false, 2)
      if mods["cupric-asteroids"] then
        frep.add_result("advanced-cupric-asteroid-crushing", CrushingIndustry.make_crushing_byproduct("crushed-copper-ore", CrushingIndustry.FREQUENT_BYPRODUCT, 2, true), false, 2)
      end
    end
  end

  -- Modify basic asteroid crushing to be craftable in the basic crusher
  data.raw.recipe["metallic-asteroid-crushing"].category = "basic-crushing"
  data.raw.recipe["carbonic-asteroid-crushing"].category = "basic-crushing"
  data.raw.recipe["oxide-asteroid-crushing"].category = "basic-crushing"
  if mods["cupric-asteroids"] then
    data.raw.recipe["cupric-asteroid-crushing"].category = "basic-crushing"
  end
end
