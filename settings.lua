data:extend({
  {
    type = "bool-setting",
    name = "crushing-industry-big-crusher",
    setting_type = "startup",
    default_value = true,
    order = "a[crushers]-b[big]"
  },
  {
    type = "bool-setting",
    name = "crushing-industry-glass",
    setting_type = "startup",
    default_value = true,
    order = "b[resources]-a[glass]"
  },
  {
    type = "bool-setting",
    name = "crushing-industry-ore",
    setting_type = "startup",
    default_value = true,
    order = "b[resources]-b[ore]"
  },
  {
    type = "bool-setting",
    name = "crushing-industry-coal",
    setting_type = "startup",
    default_value = true,
    order = "b[resources]-c[coal]"
  },
  {
    type = "bool-setting",
    name = "crushing-industry-concrete-mix",
    setting_type = "startup",
    default_value = true,
    order = "b[resources]-d[concrete]"
  },
  {
    type = "bool-setting",
    name = "crushing-industry-byproducts",
    setting_type = "startup",
    default_value = true,
    order = "d[details]-b[byproducts]"
  },
  {
    type = "bool-setting",
    name = "crushing-industry-hide-player-crafting",
    setting_type = "startup",
    default_value = false,
    order = "d[details]-h[hide]"
  }
})

if mods["space-age"] then
  data:extend({
    {
      type = "bool-setting",
      name = "crushing-industry-space-crusher",
      setting_type = "startup",
      default_value = true,
      order = "a[crushers]-a[space]"
    }
  })

  if mods["bztin"] then
    data:extend({
      {
        type = "bool-setting",
        name = "crushing-industry-bztin-space",
        setting_type = "startup",
        default_value = true,
        order = "c[compat]-b[tin]"
      }
    })
  end

  if mods["bzcarbon"] then
    data:extend({
      {
        type = "bool-setting",
        name = "crushing-industry-bzcarbon-space",
        setting_type = "startup",
        default_value = true,
        order = "c[compat]-g[graphite]"
      }
    })
  end
end
