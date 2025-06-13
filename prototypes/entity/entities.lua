local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local allowed_effects = {"speed", "consumption", "productivity", "pollution"}
if not (mods["space-age"] and settings.startup["crushing-industry-space-crusher"].value) then
  table.insert(allowed_effects, "quality")
end

data:extend({
  {
    type = "furnace",
    name = "burner-crusher",
    fast_replaceable_group = "electric-crusher",
    next_upgrade = "electric-crusher",
    icon = "__crushing-industry__/graphics/icons/burner-crusher.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "burner-crusher"},
    max_health = 150,
    corpse = "burner-crusher-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    surface_conditions = data.raw.furnace["stone-furnace"].surface_conditions,
    resistances = {{type="fire", percent=70}},
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector(universal_connector_template,{
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true},
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true},
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true},
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true}
    }),
    icon_draw_specification = {scale = 0.66, shift = {0, -0.1}},
    crafting_categories = {"basic-crushing", "basic-crushing-or-crafting", "basic-crushing-or-hand-crafting"},
    crafting_speed = 0.75,
    energy_source = {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = { pollution = 2 },
      light_flicker = {
        color = {0,0,0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
      smoke = {
        {
          name = "smoke",
          deviation = {0.2, 0.7},
          frequency = 5,
          position = {0.0, -0.2},
          starting_vertical_speed = 0.04,
          starting_frame_deviation = 60
        }
      }
    },
    energy_usage = "60kW",
    source_inventory_size = 1,
    result_inventory_size = 3,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    allowed_effects = {"speed", "consumption", "pollution"},
    effect_receiver = {uses_module_effects=false, uses_beacon_effects=false, uses_surface_effects=true},
    impact_category = "metal",
    working_sound = {
      sound = {filename="__crushing-industry__/sound/entity/crusher/crusher-loop.ogg", volume=0.6},
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      max_sounds_per_type = 3
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__crushing-industry__/graphics/entity/burner-crusher/burner-crusher-base.png",
            priority="high",
            width = 143,
            height = 151,
            repeat_count = 48,
            shift = util.by_pixel(0, 2),
            scale = 0.5
          },
          util.sprite_load("__crushing-industry__/graphics/entity/burner-crusher/burner-crusher-animation", {
            animation_speed = 0.5,
            frame_count = 48,
            shift = {0.05,-0.26},
            scale = 0.44
          }),
          {
            filename = "__crushing-industry__/graphics/entity/electric-crusher/electric-crusher-shadow.png",
            priority="high",
            width = 148,
            height = 110,
            repeat_count = 48,
            draw_as_shadow = true,
            shift = util.by_pixel(8.5, 5),
            scale = 0.5
          }
        }
      },
      working_visualisations = {
        {
          fadeout = true,
          effect = "flicker",
          animation = {
            layers = {
              util.sprite_load("__crushing-industry__/graphics/entity/burner-crusher/burner-crusher-fire", {
                frame_count = 64,
                draw_as_glow = true,
                shift = util.by_pixel(0, 19),
                scale = 1/3
              }),
              {
                filename = "__crushing-industry__/graphics/entity/burner-crusher/burner-crusher-light.png",
                blend_mode = "additive",
                width = 100,
                height = 87,
                repeat_count = 64,
                draw_as_glow = true,
                shift = util.by_pixel(-1, 20.5),
                scale = 1/3
              }
            }
          }
        }
      }
    }
  },
  {
    type = "furnace",
    name = "electric-crusher",
    fast_replaceable_group = "electric-crusher",
    icon = "__crushing-industry__/graphics/icons/electric-crusher.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "electric-crusher"},
    max_health = 250,
    corpse = "electric-crusher-remnants",
    dying_explosion = "assembling-machine-2-explosion",
    resistances = {{type="fire", percent=70}},
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector(universal_connector_template,{
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true},
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true},
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true},
      {variation=18, main_offset=util.by_pixel(16, 16), shadow_offset=util.by_pixel(24, 20), show_shadow=true}
    }),
    icon_draw_specification = {scale = 0.66, shift = {0, -0.1}},
    crafting_categories = {"basic-crushing", "basic-crushing-or-crafting", "basic-crushing-or-hand-crafting"},
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=1}
    },
    energy_usage = "125kW",
    source_inventory_size = 1,
    result_inventory_size = 3,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    allowed_effects = allowed_effects,
    module_slots = 2,
    effect_receiver = {uses_module_effects=true, uses_beacon_effects=true, uses_surface_effects=true},
    impact_category = "metal",
    working_sound = {
      sound = {filename="__crushing-industry__/sound/entity/crusher/crusher-loop.ogg", volume=0.6},
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      max_sounds_per_type = 3
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__crushing-industry__/graphics/entity/electric-crusher/electric-crusher-base.png",
            priority="high",
            width = 143,
            height = 151,
            repeat_count = 48,
            shift = util.by_pixel(0, 2),
            scale = 0.5
          },
          util.sprite_load("__crushing-industry__/graphics/entity/electric-crusher/electric-crusher-animation", {
            animation_speed = 0.5,
            frame_count = 48,
            shift = {0.05,-0.26},
            scale = 0.44
          }),
          {
            filename = "__crushing-industry__/graphics/entity/electric-crusher/electric-crusher-shadow.png",
            priority="high",
            width = 148,
            height = 110,
            repeat_count = 48,
            draw_as_shadow = true,
            shift = util.by_pixel(8.5, 5),
            scale = 0.5
          }
        }
      }
    }
  }
})

if settings.startup["crushing-industry-big-crusher"].value then
  data:extend({
    {
      type = "assembling-machine",
      name = "big-crusher",
      icon = "__crushing-industry__/graphics/icons/big-crusher.png",
      flags = {"placeable-neutral", "placeable-player", "player-creation"},
      minable = {mining_time = 0.2, result = "big-crusher"},
      max_health = 250,
      corpse = "big-crusher-remnants",
      dying_explosion = mods["space-age"] and "big-mining-drill-explosion" or "assembling-machine-3-explosion",
      resistances = {{type="fire", percent=70}},
      collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
      selection_box = {{-2.0, -2.0}, {2.0, 2.0}},
      damaged_trigger_effect = hit_effects.entity(),
      circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
      circuit_connector = circuit_connector_definitions.create_vector(universal_connector_template,{
        {variation=25, main_offset=util.by_pixel(-55.5, 29.5), shadow_offset=util.by_pixel(-41.5, 49.5), show_shadow=true},
        {variation=25, main_offset=util.by_pixel(-55.5, 29.5), shadow_offset=util.by_pixel(-41.5, 49.5), show_shadow=true},
        {variation=25, main_offset=util.by_pixel(-55.5, 29.5), shadow_offset=util.by_pixel(-41.5, 49.5), show_shadow=true},
        {variation=25, main_offset=util.by_pixel(-55.5, 29.5), shadow_offset=util.by_pixel(-41.5, 49.5), show_shadow=true}
      }),
	  icon_draw_specification = {shift = {0, -0.25}},
      icons_positioning = {
        {inventory_index = defines.inventory.assembling_machine_modules, shift = {0, 1}}
      },
      crafting_categories = mods["space-age"] and data.raw["assembling-machine"]["crusher"].crafting_categories or {"basic-crushing", "basic-crushing-or-crafting", "basic-crushing-or-hand-crafting"},
      crafting_speed = 2.5,
      energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = {pollution=1}
      },
      energy_usage = "750kW",
      open_sound = sounds.mech_large_open,
      close_sound = sounds.mech_large_close,
      allowed_effects = allowed_effects,
      module_slots = 4,
      effect_receiver = {base_effect={productivity=0.5}},
      impact_category = "metal",
      working_sound = {
        sound = {filename="__crushing-industry__/sound/entity/crusher/crusher-loop.ogg", volume=0.6},
        audible_distance_modifier = 0.5,
        fade_in_ticks = 4,
        fade_out_ticks = 20,
        max_sounds_per_type = 3
      },
      perceived_performance = {minimum = 0.25, maximum = 10},
      graphics_set = {
        animation = {
          layers = {
            {
              filename = "__crushing-industry__/graphics/entity/big-crusher/big-crusher-still.png",
              priority = "high",
              width = 259,
              height = 259,
              repeat_count = 48,
              shift = util.by_pixel(0, -9.6),
              scale = 0.5
            },
            {
              filename = "__crushing-industry__/graphics/entity/big-crusher/big-crusher-base.png",
              priority = "high",
              width = 214,
              height = 237,
              repeat_count = 48,
              shift = util.by_pixel(0, 1),
              scale = 2/3
            },
            util.sprite_load("__crushing-industry__/graphics/entity/big-crusher/big-crusher-animation", {
              animation_speed = 0.5,
              frame_count = 48,
              shift = util.by_pixel(3, -17),
              scale = 0.44*4/3
            }),
            {
              filename = "__crushing-industry__/graphics/entity/big-crusher/big-crusher-front.png",
              priority = "high",
              width = 258,
              height = 141,
              repeat_count = 48,
              shift = util.by_pixel(0, 25),
              scale = 0.5
            },
            {
              filename = "__crushing-industry__/graphics/entity/big-crusher/big-crusher-shadow.png",
              priority="high",
              width = 320,
              height = 220,
              repeat_count = 48,
              draw_as_shadow = true,
              shift = util.by_pixel(17, 8),
              scale = 0.5
            },
            {
              filename = "__crushing-industry__/graphics/entity/big-crusher/big-crusher-shadow-2.png",
              priority="high",
              width = 320,
              height = 260,
              repeat_count = 48,
              draw_as_shadow = true,
              shift = util.by_pixel(16, 1),
              scale = 0.5
            }
          }
        }
      },
      integration_patch = {
        filename = "__crushing-industry__/graphics/entity/big-crusher/big-crusher-integration.png",
        priority = "high",
        width = 296,
        height = 295,
        shift = util.by_pixel(0, 5),
        scale = 0.5
      }
    }
  })
end
