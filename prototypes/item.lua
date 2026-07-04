local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

-------------------------------------------------------------------------- Ore crushing

if settings.startup["crushing-industry-ore"].value then
  data:extend({
    {
      type = "item",
      name = "crushed-iron-ore",
      icon = "__crushing-industry__/graphics/icons/crushed-iron-ore.png",
      pictures = {
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-iron-ore.png", scale=0.5},
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-iron-ore-1.png", scale=0.5},
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-iron-ore-2.png", scale=0.5},
      },
      subgroup = "raw-resource",
      color_hint = { text = "I" },
      order = "e[iron-ore]-c[crushed]",
      inventory_move_sound = item_sounds.resource_inventory_move,
      pick_sound = item_sounds.resource_inventory_pickup,
      drop_sound = item_sounds.resource_inventory_move,
      stack_size = 100,
      weight = 2 * kg
    },
    {
      type = "item",
      name = "crushed-copper-ore",
      icon = "__crushing-industry__/graphics/icons/crushed-copper-ore.png",
      pictures = {
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-copper-ore.png", scale=0.5},
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-copper-ore-1.png", scale=0.5},
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-copper-ore-2.png", scale=0.5},
      },
      subgroup = "raw-resource",
      color_hint = { text = "C" },
      order = "f[copper-ore]-c[crushed]",
      inventory_move_sound = item_sounds.resource_inventory_move,
      pick_sound = item_sounds.resource_inventory_pickup,
      drop_sound = item_sounds.resource_inventory_move,
      stack_size = 100,
      weight = 2 * kg
    }
  })

  if mods["space-age"] then
    data:extend({
      {
        type = "item",
        name = "crushed-tungsten-ore",
        icon = "__crushing-industry__/graphics/icons/crushed-tungsten-ore.png",
        pictures = {
          {size=64, filename="__crushing-industry__/graphics/icons/crushed-tungsten-ore.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/crushed-tungsten-ore-1.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/crushed-tungsten-ore-2.png", scale=0.5},
        },
        subgroup = "vulcanus-processes",
        color_hint = { text = "T" },
        order = "c[tungsten]-a[tungsten-ore]-c[crushed]",
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 100,
        default_import_location = "vulcanus",
        weight = 10*kg
      },
      {
        type = "item",
        name = "holmium-powder",
        pictures = {
          {size=64, filename="__crushing-industry__/graphics/icons/holmium-powder.png", scale=0.5, mipmap_count=4},
          {size=64, filename="__crushing-industry__/graphics/icons/holmium-powder-1.png", scale=0.5, mipmap_count=4},
        },
        icon = "__crushing-industry__/graphics/icons/holmium-powder.png",
        subgroup = "fulgora-processes",
        order = "b[holmium]-a[holmium-ore]-c[crushed]",
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 100,
        default_import_location = "fulgora",
        weight = 2 * kg
      }
    })
  end
end

-------------------------------------------------------------------------- Coal crushing

if settings.startup["crushing-industry-coal"].value then
  data:extend({
    {
      type = "item",
      name = "crushed-coal",
      pictures = {
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-coal.png", scale=0.5, mipmap_count=4},
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-coal-1.png", scale=0.5, mipmap_count=4},
        {size=64, filename="__crushing-industry__/graphics/icons/crushed-coal-2.png", scale=0.5, mipmap_count=4},
      },
      icon = "__crushing-industry__/graphics/icons/crushed-coal.png",
      subgroup = "raw-resource",
      order = "b[coal]-c[crushed]",
      fuel_category = "chemical",
      fuel_value = "3.2MJ",
      inventory_move_sound = item_sounds.resource_inventory_move,
      pick_sound = item_sounds.resource_inventory_pickup,
      drop_sound = item_sounds.resource_inventory_move,
      stack_size = 100,
      weight = 2 * kg,
      random_tint_color = item_tints.yellowing_coal
    }
  })
end

-------------------------------------------------------------------------- BZ Ores

if settings.startup["crushing-industry-ore"].value then
  if mods["bzlead"] then
    data:extend({
      {
        type = "item",
        name = "crushed-lead-ore",
        icon = "__crushing-industry__/graphics/icons/compat/crushed-lead-ore.png",
        pictures = {
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-lead-ore.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-lead-ore-1.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-lead-ore-2.png", scale=0.5},
        },
        subgroup = "raw-resource",
        -- color_hint = { text = "I" },
        order = data.raw.item["lead-ore"].order.."-c[crushed]",
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 100,
        weight = 2 * kg
      }
    })
  end

  if mods["bztin"] then
    data:extend({
      {
        type = "item",
        name = "crushed-tin-ore",
        icon = "__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png",
        pictures = {
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-tin-ore-1.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-tin-ore-2.png", scale=0.5},
        },
        subgroup = "raw-resource",
        -- color_hint = { text = "I" },
        order = data.raw.item["tin-ore"].order.."-c[crushed]",
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 100,
        weight = 2 * kg
      }
    })
  end

  if mods["bztitanium"] then
    data:extend({
      {
        type = "item",
        name = "crushed-titanium-ore",
        icon = "__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png",
        pictures = {
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore-1.png", scale=0.5},
          {size=64, filename="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore-2.png", scale=0.5},
        },
        subgroup = "raw-resource",
        -- color_hint = { text = "I" },
        order = data.raw.item["titanium-ore"].order.."-c[crushed]",
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 100,
        weight = 2 * kg
      }
    })
  end
end

-------------------------------------------------------------------------- Proxy items for settings

data:extend({
  {
    type = "item",
    name = "wci-proxy-big-crusher",
    icon = "__crushing-industry__/graphics/icons/big-crusher.png",
    hidden = true,
    stack_size = 1
  },
  {
    type = "item",
    name = "wci-proxy-glass",
    icon = "__crushing-industry__/graphics/icons/glass.png",
    hidden = true,
    stack_size = 1
  },
  {
    type = "item",
    name = "wci-proxy-optical-fiber",
    icon = "__crushing-industry__/graphics/icons/optical-fiber.png",
    hidden = true,
    stack_size = 1
  },
  {
    type = "item",
    name = "wci-proxy-crushed-ores",
    icons = {
      {icon="__crushing-industry__/graphics/icons/crushed-copper-ore.png", shift={-4,-4}, scale=0.4, draw_background=true},
      {icon="__crushing-industry__/graphics/icons/crushed-iron-ore.png", shift={4,4}, scale=0.4, draw_background=true}
    },
    hidden = true,
    stack_size = 1
  },
  {
    type = "item",
    name = "wci-proxy-productivity",
    icons = {
      {icon="__base__/graphics/icons/electric-furnace.png"},
      {icon="__core__/graphics/icons/technology/effect-constant/effect-constant-recipe-productivity.png"},
    },
    hidden = true,
    stack_size = 1
  },
  {
    type = "item",
    name = "wci-proxy-crushed-coal",
    icon = "__crushing-industry__/graphics/icons/crushed-coal.png",
    hidden = true,
    stack_size = 1
  },
  {
    type = "item",
    name = "wci-proxy-concrete-mix",
    icon = "__crushing-industry__/graphics/icons/fluid/concrete-mix.png",
    hidden = true,
    stack_size = 1
  }
})

if mods["space-age"] then
  data:extend({
    {
      type = "item",
      name = "wci-proxy-quality-crusher",
      icons = {
        {icon="__space-age__/graphics/icons/crusher.png"},
        {icon="__core__/graphics/icons/any-quality.png", shift={8,8}, scale=0.25}
      },
      hidden = true,
      stack_size = 1
    }
  })
end
