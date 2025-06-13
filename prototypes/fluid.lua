data:extend({
  {
    type = "fluid",
    name = "concrete-mix",
    icon = "__crushing-industry__/graphics/icons/fluid/concrete-mix.png",
    subgroup = "fluid",
    hidden = not settings.startup["crushing-industry-concrete-mix"].value,
    auto_barrel = settings.startup["crushing-industry-concrete-mix"].value,
    order = "a[fluid]-c[concrete]",
    default_temperature = 25,
    base_color = {0.25, 0.25, 0.25},
    flow_color = {0.45, 0.45, 0.45},
  }
})

if mods["space-age"] and settings.startup["crushing-industry-glass"].value then
  data:extend({
    {
      type = "fluid",
      name = "molten-glass",
      icon = "__crushing-industry__/graphics/icons/fluid/molten-glass.png",
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
