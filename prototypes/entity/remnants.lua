data:extend({
  {
    type = "corpse",
    name = "burner-crusher-remnants",
    icon = "__crushing-industry__/graphics/icons/burner-crusher.png",
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "production-machine-remnants",
    order = "a-a-a",
    selection_box = {{-1, -1}, {1, 1}},
    tile_width = 2,
    tile_height = 2,
    selectable_in_game = false,
    time_before_removed = 15 * minute,
    expires = false,
    final_render_layer = "remnants",
    animation = make_rotated_animation_variations_from_sheet (3, {
      filename = "__crushing-industry__/graphics/entity/burner-crusher/remnants/burner-crusher-remnants.png",
      line_length = 1,
      width = 219,
      height = 188,
      direction_count = 1,
      shift = util.by_pixel(0, 6.5),
      scale = 0.5
    })
  },
  {
    type = "corpse",
    name = "electric-crusher-remnants",
    icon = "__crushing-industry__/graphics/icons/electric-crusher.png",
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "production-machine-remnants",
    order = "a-a-a",
    selection_box = {{-1, -1}, {1, 1}},
    tile_width = 2,
    tile_height = 2,
    selectable_in_game = false,
    time_before_removed = 15 * minute,
    expires = false,
    final_render_layer = "remnants",
    animation = make_rotated_animation_variations_from_sheet (3, {
      filename = "__crushing-industry__/graphics/entity/electric-crusher/remnants/electric-crusher-remnants.png",
      line_length = 1,
      width = 219,
      height = 188,
      direction_count = 1,
      shift = util.by_pixel(0, 6.5),
      scale = 0.5
    })
  },
  {
    type = "corpse",
    name = "big-crusher-remnants",
    icon = "__crushing-industry__/graphics/icons/big-crusher.png",
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "production-machine-remnants",
    order = "a-a-a",
    selection_box = {{-1, -1}, {1, 1}},
    tile_width = 2,
    tile_height = 2,
    selectable_in_game = false,
    time_before_removed = 15 * minute,
    expires = false,
    final_render_layer = "remnants",
    animation = make_rotated_animation_variations_from_sheet (3, {
      filename = "__crushing-industry__/graphics/entity/big-crusher/remnants/big-crusher-remnants.png",
      line_length = 1,
      width = 328,
      height = 282,
      direction_count = 1,
      shift = util.by_pixel(0, 6.5),
      scale = 2/3
    })
  }
})
