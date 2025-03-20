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

if mods["space-age"] and settings.startup["crushing-industry-space-crusher"].value and not mods["planet-muluna"] then
  data:extend({
    {
      type = "technology",
      name = "space-crushing",
      icon = "__crushing-industry__/graphics/technology/space-crushing.png",
      icon_size = 256,
      effects = {
        {type="unlock-recipe", recipe="crusher"}
      },
      prerequisites = {"space-science-pack", "production-science-pack", "quality-module-2"},
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
