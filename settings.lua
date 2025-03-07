local compat = require("compat-list")

data:extend({
  {
    type = "bool-setting",
    name = "early-crushing-big-crusher",
    setting_type = "startup",
    default_value = true,
    order = "a[crushers]-b[big]"
  },
  {
    type = "bool-setting",
    name = "early-crushing-ore",
    setting_type = "startup",
    default_value = true,
    order = "b[resources]-b[ore]"
  },
  {
    type = "bool-setting",
    name = "early-crushing-coal",
    setting_type = "startup",
    default_value = true,
    order = "b[resources]-c[coal]"
  },
  {
    type = "bool-setting",
    name = "early-crushing-byproducts",
    setting_type = "startup",
    default_value = true,
    order = "m[misc]-b[byproducts]"
  }
})

if mods["space-age"] then
  data:extend({
    {
      type = "bool-setting",
      name = "early-crushing-space-crusher",
      setting_type = "startup",
      default_value = true,
      order = "a[crushers]-a[space]"
    }
  })
end

if not compat.glass then
  data:extend({
    {
      type = "bool-setting",
      name = "early-crushing-glass",
      setting_type = "startup",
      default_value = true,
      order = "b[resources]-a[glass]"
    }
  })
end
