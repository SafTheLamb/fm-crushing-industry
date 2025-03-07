local compat = require("compat-list")

if not compat.glass and settings.startup["early-crushing-glass"].value and mods["space-age"] then
  data:extend({
    {
      type = "fluid",
      name = "molten-glass",
      icon = "__early-crushing__/graphics/icons/fluids/molten-glass.png",
      subgroup = "fluid",
      order = "b[new-fluid]-b[vulcanus]-g[molten-glass]",
      default_temperature = 1500,
      max_temperature = 2000,
      heat_capacity = "0.01kJ",
      base_color = {0.4, 0.6, 0.83},
      flow_color = {0.5, 0.78, 0.93},
      auto_barrel = false
    },
  })
end
