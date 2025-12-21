if settings.startup["crushing-industry-ore"].value then
  data:extend({
    {
      type = "technology",
      name = "ore-crushing",
      icon = "__crushing-industry__/graphics/technology/ore-crushing.png",
      icon_size = 256,
      effects = {
        {type="unlock-recipe", recipe="crushed-iron-ore"},
        {type="unlock-recipe", recipe="crushed-iron-smelting"},
        {type="unlock-recipe", recipe="crushed-copper-ore"},
        {type="unlock-recipe", recipe="crushed-copper-smelting"},
      },
      prerequisites = {"advanced-material-processing", "engine"},
      unit = {
        count = 125,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1}
        },
        time = 15
      }
    }
  })
  
end

if settings.startup["crushing-industry-smelting-productivity"].value then
  if settings.startup["crushing-industry-ore"].value then
    data:extend({
      {
        type = "technology",
        name = "crushed-ore-smelting-productivity-1",
        icons = util.technology_icon_constant_recipe_productivity("__crushing-industry__/graphics/technology/crushed-ore-smelting-productivity.png"),
        icon_size = 256,
        effects = {
          -- Filled in with CrushingIndustry.add_crushed_smelting_productivity
        },
        prerequisites = {"ore-crushing", "advanced-circuit"},
        unit = {
          count = 500,
          ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
          },
          time = 60
        },
        upgrade = true
      },
      {
        type = "technology",
        name = "crushed-ore-smelting-productivity-2",
        icons = util.technology_icon_constant_recipe_productivity("__crushing-industry__/graphics/technology/crushed-ore-smelting-productivity.png"),
        icon_size = 256,
        effects = {
          -- Filled in with CrushingIndustry.add_crushed_smelting_productivity
        },
        prerequisites = {"crushed-ore-smelting-productivity-1", "advanced-material-processing-2"},
        unit = {
          count = 1000,
          ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
          },
          time = 60
        },
        upgrade = true
      },
      {
        type = "technology",
        name = "crushed-ore-smelting-productivity-3",
        icons = util.technology_icon_constant_recipe_productivity("__crushing-industry__/graphics/technology/crushed-ore-smelting-productivity.png"),
        icon_size = 256,
        effects = {
          -- Filled in with CrushingIndustry.add_crushed_smelting_productivity
        },
        prerequisites = {"crushed-ore-smelting-productivity-2", "production-science-pack"},
        unit = {
          count_formula = "1.5^(L-2)*1000",
          ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
          },
          time = 60
        },
        upgrade = true,
        max_level = mods["space-age"] and 5 or "infinite"
      }
    })
    if mods["space-age"] then
      data:extend({
        {
          type = "technology",
          name = "molten-crushed-ore-productivity",
          icons = util.technology_icon_constant_recipe_productivity("__crushing-industry__/graphics/technology/molten-crushed-ore-productivity.png"),
          iicon_size = 256,
          effects = {
            -- Filled in with CrushingIndustry.add_molten_ore_productivity
          },
          prerequisites = {"crushed-ore-smelting-productivity-3", "metallurgic-science-pack"},
          unit = {
            count_formula = "1.5^L*1000",
            ingredients = {
              {"automation-science-pack", 1},
              {"logistic-science-pack", 1},
              {"chemical-science-pack", 1},
              {"production-science-pack", 1},
              {"metallurgic-science-pack", 1},
            },
            time = 60
          },
          upgrade = true,
          max_level = "infinite"
        }
      })
    end
  end
end

if mods["space-age"] and settings.startup["crushing-industry-space-crusher"].value and not mods["planet-muluna"] then
  local space_crusher_prereqs = {"space-science-pack", "production-science-pack" }

  if settings.startup["crushing-industry-space-crusher-quality"].value then
      table.insert(space_crusher_prereqs, "quality-module-2")
  end

  data:extend({
    {
      type = "technology",
      name = "space-crushing",
      icon = "__crushing-industry__/graphics/technology/space-crushing.png",
      icon_size = 256,
      effects = {
        {type="unlock-recipe", recipe="crusher"}
      },
      prerequisites = space_crusher_prereqs,
      unit = {
        count = 500,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"space-science-pack", 1},
        },
        time = 60
      }
    }
  })
end
