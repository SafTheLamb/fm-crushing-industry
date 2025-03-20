local function make_crushing_icons(item_name)
  return {
    {icon=data.raw.item[item_name].icon, shift={0, -3}, scale=0.4},
    {icon="__crushing-industry__/graphics/icons/generic-crushing.png"}
  } or nil
end

-------------------------------------------------------------------------- Crushers

data:extend({
  {
    type = "recipe",
    name = "burner-crusher",
    enabled = false,
    ingredients = {
      {type="item", name="iron-plate", amount=6},
      {type="item", name="stone-brick", amount=5},
      {type="item", name="iron-gear-wheel", amount=4}
    },
    results = {{type="item", name="burner-crusher", amount=1}}
  },
  {
    type = "recipe",
    name = "electric-crusher",
    enabled = false,
    ingredients = {
      {type="item", name="steel-plate", amount=8},
      {type="item", name="engine-unit", amount=4},
      {type="item", name="electronic-circuit", amount=2},
      {type="item", name="stone-brick", amount=5},
    },
    results = {{type="item", name="electric-crusher", amount=1}}
  }
})

if settings.startup["crushing-industry-big-crusher"].value then
  data:extend({
    {
      type = "recipe",
      name = "big-crusher",
      enabled = false,
      ingredients = mods["space-age"] and {
        {type="item", name="electric-crusher", amount=1},
        {type="item", name="advanced-circuit", amount=5},
        {type="item", name="electric-engine-unit", amount=10},
        {type="item", name="tungsten-carbide", amount=20}
      } or {
        {type="item", name="steel-plate", amount=50},
        {type="item", name="processing-unit", amount=10},
        {type="item", name="electric-engine-unit", amount=10},
        {type="item", name="productivity-module", amount=4}
      },
      results = {{type="item", name="big-crusher", amount=1}}
    }
  })
end

-------------------------------------------------------------------------- Sand & glass

data:extend({
  {
    type = "recipe",
    name = "sand",
    icons = make_crushing_icons("stone"),
    category = "basic-crushing-or-hand-crafting",
    enabled = false,
    allow_productivity = true,
    auto_recycle = false,
    energy_required = 0.96,
    ingredients = {{type="item", name="stone", amount=1}},
    results = {{type="item", name="sand", amount=2}},
    main_product = "sand"
  }
})

if settings.startup["crushing-industry-glass"].value then
  data:extend({
    {
      type = "recipe",
      name = "glass",
      category = "smelting",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      energy_required = 6.4,
      ingredients = {{type="item", name="sand", amount=5}},
      results = {{type="item", name="glass", amount=2}}
    }
  })
  
  if mods["space-age"] then
    data:extend({
      {
        type = "recipe",
        name = "molten-glass",
        category = "metallurgy",
        subgroup = "vulcanus-processes",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = 32,
        ingredients = {
          {type="item", name="sand", amount=50},
          {type="item", name="calcite", amount=1}
        },
        results = {{type="fluid", name="molten-glass", amount=200}},
        main_product = "molten-glass"
      },
      {
        type = "recipe",
        name = "casting-glass",
        icon = "__crushing-industry__/graphics/icons/casting-glass.png",
        category = "metallurgy",
        subgroup = "vulcanus-processes",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        allow_decomposition = false,
        energy_required = 3.2,
        ingredients = {{type="fluid", name="molten-glass", amount=20, fluidbox_multiplier=10}},
        results = {{type="item", name="glass", amount=2}}
      }
    })
  end
end

-------------------------------------------------------------------------- Ore crushing

if settings.startup["crushing-industry-ore"].value then
  data:extend({
    {
      type = "recipe",
      name = "crushed-iron-ore",
      icons = make_crushing_icons("iron-ore"),
      localised_name = {"recipe-name.iron-ore-crushing"},
      category = "basic-crushing",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      energy_required = 1.2,
      ingredients = {{type="item", name="iron-ore", amount=1}},
      results = {{type="item", name="crushed-iron-ore", amount=1, extra_count_fraction=0.5}},
      main_product = "crushed-iron-ore"
    },
    {
      type = "recipe",
      name = "crushed-iron-smelting",
      localised_name = {"recipe-name.crushed-smelting", {"item-name.iron-plate"}},
      icons = {
        {icon="__crushing-industry__/graphics/icons/crushed-iron-ore.png", shift={-12, -12}, scale=0.4},
        {icon="__base__/graphics/icons/iron-plate.png", draw_background=true}
      },
      category = "smelting",
      order = "a[smelting]-a[iron-plate]-c[crushed]",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      hide_from_player_crafting = true,
      energy_required = 3.2,
      ingredients = {{type="item", name="crushed-iron-ore", amount=1}},
      results = {{type="item", name="iron-plate", amount=1}},
      main_product = "iron-plate",
    },
    {
      type = "recipe",
      name = "crushed-copper-ore",
      localised_name = {"recipe-name.copper-ore-crushing"},
      icons = make_crushing_icons("copper-ore"),
      category = "basic-crushing",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      energy_required = 1.2,
      ingredients = {{type="item", name="copper-ore", amount=1}},
      results = {{type="item", name="crushed-copper-ore", amount=1, extra_count_fraction=0.5}},
      main_product = "crushed-copper-ore"
    },
    {
      type = "recipe",
      name = "crushed-copper-smelting",
      localised_name = {"recipe-name.crushed-smelting", {"item-name.copper-plate"}},
      icons = {
        {icon="__crushing-industry__/graphics/icons/crushed-copper-ore.png", shift={-12, -12}, scale=0.4},
        {icon="__base__/graphics/icons/copper-plate.png", draw_background=true}
      },
      category = "smelting",
      order = "a[smelting]-b[copper-plate]-c[crushed]",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      hide_from_player_crafting = true,
      energy_required = 3.2,
      ingredients = {{type="item", name="crushed-copper-ore", amount=1}},
      results = {{type="item", name="copper-plate", amount=1}},
      main_product = "copper-plate",
    }
  })
  if mods["space-age"] then
    data:extend({
      {
        type = "recipe",
        name = "holmium-powder",
        localised_name = {"recipe-name.holmium-ore-crushing"},
        icons = make_crushing_icons("holmium-ore"),
        category = "basic-crushing",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = 5,
        ingredients = {{type="item", name="holmium-ore", amount=1}},
        results = {{type="item", name="holmium-powder", amount=1, extra_count_fraction=0.25}},
        main_product = "holmium-powder"
      },
      {
        type = "recipe",
        name = "crushed-tungsten-ore",
        localised_name = {"recipe-name.tungsten-ore-crushing"},
        icons = make_crushing_icons("tungsten-ore"),
        category = settings.startup["crushing-industry-big-crusher"].value and "crushing" or "basic-crushing",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = 5,
        ingredients = {{type="item", name="tungsten-ore", amount=1}},
        results = {{type="item", name="crushed-tungsten-ore", amount=1, extra_count_fraction=0.25}},
        main_product = "crushed-tungsten-ore"
      }
    })
  end
end

-------------------------------------------------------------------------- Coal crushing

if settings.startup["crushing-industry-coal"].value then
  data:extend({
    {
      type = "recipe",
      name = "crushed-coal",
      localised_name = {"recipe-name.coal-crushing"},
      icons = make_crushing_icons("coal"),
      category = "basic-crushing",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      energy_required = 1,
      ingredients = {{type="item", name="coal", amount=1}},
      results = {{type="item", name="crushed-coal", amount=1, extra_count_fraction=0.5}},
      main_product = "crushed-coal"
    }
  })
end

-------------------------------------------------------------------------- BZ Ores

if settings.startup["crushing-industry-ore"].value then
  if mods["bzlead"] then
    data:extend({
      {
        type = "recipe",
        name = "crushed-lead-ore",
        localised_name = {"recipe-name.lead-ore-crushing"},
        icons = make_crushing_icons("lead-ore"),
        category = "basic-crushing",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = 1,
        ingredients = {{type="item", name="lead-ore", amount=1}},
        results = {
          {type="item", name="crushed-lead-ore", amount=1, extra_count_fraction=0.25, probability=5/6},
          {type="item", name="crushed-copper-ore", amount=1, probability=1/6}
        },
        main_product = "crushed-lead-ore"
      },
      {
        type = "recipe",
        name = "crushed-lead-smelting",
        localised_name = {"recipe-name.crushed-smelting", {"item-name.lead-plate"}},
        icons = {
          {icon="__crushing-industry__/graphics/icons/compat/crushed-lead-ore.png", shift={-12, -12}, scale=0.4},
          {icon="__bzlead__/graphics/icons/lead-plate.png", draw_background=true}
        },
        category = "smelting",
        order = data.raw.recipe["lead-plate"].order.."-c[crushed]",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        hide_from_player_crafting = true,
        energy_required = 3.2,
        ingredients = {{type="item", name="crushed-lead-ore", amount=1}},
        results = {{type="item", name="lead-plate", amount=1}},
        main_product = "lead-plate",
      }
    })
  end

  if mods["bztin"] then
    data:extend({
      {
        type = "recipe",
        name = "crushed-tin-ore",
        localised_name = {"recipe-name.tin-ore-crushing"},
        icons = make_crushing_icons("tin-ore"),
        category = "basic-crushing",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = 1,
        ingredients = {{type="item", name="tin-ore", amount=1}},
        results = {
          {type="item", name="crushed-tin-ore", amount=1, extra_count_fraction=0.25}
        },
        main_product = "crushed-tin-ore"
      },
      {
        type = "recipe",
        name = "crushed-tin-smelting",
        localised_name = {"recipe-name.crushed-smelting", {"item-name.tin-plate"}},
        icons = {
          {icon="__crushing-industry__/graphics/icons/compat/crushed-tin-ore.png", shift={-12, -12}, scale=0.4},
          {icon="__bztin__/graphics/icons/tin-plate.png", icon_size=128, scale=0.25, draw_background=true}
        },
        category = "smelting",
        order = data.raw.recipe["tin-plate"].order.."-c[crushed]",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        hide_from_player_crafting = true,
        energy_required = 3.2,
        ingredients = {{type="item", name="crushed-tin-ore", amount=1}},
        results = {{type="item", name="tin-plate", amount=1}},
        main_product = "tin-plate",
      }
    })
  end

  if mods["bztitanium"] then
    data:extend({
      {
        type = "recipe",
        name = "crushed-titanium-ore",
        localised_name = {"recipe-name.titanium-ore-crushing"},
        icons = make_crushing_icons("titanium-ore"),
        category = (mods["space-age"] and settings.startup["crushing-industry-big-crusher"].value) and "crushing" or "basic-crushing",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = mods["space-age"] and 5 or 2,
        ingredients = {{type="item", name="titanium-ore", amount=1}},
        results = {
          {type="item", name="crushed-titanium-ore", amount=1, extra_count_fraction=0.25}
        },
        main_product = "crushed-titanium-ore"
      }
    })
    if not mods["space-age"] then
      data:extend({
        {
          type = "recipe",
          name = "crushed-titanium-smelting",
          localised_name = {"recipe-name.crushed-smelting", {"item-name.titanium-plate"}},
          icons = {
            {icon="__crushing-industry__/graphics/icons/compat/crushed-titanium-ore.png", shift={-12, -12}, scale=0.4},
            {icon="__bztitanium__/graphics/icons/titanium-plate.png", draw_background=true}
          },
          category = "smelting",
          order = data.raw.recipe["titanium-plate"].order.."-c[crushed]",
          enabled = false,
          allow_productivity = true,
          auto_recycle = false,
          hide_from_player_crafting = true,
          energy_required = 3.2,
          ingredients = {{type="item", name="crushed-titanium-ore", amount=1}},
          results = {{type="item", name="titanium-plate", amount=1}},
          main_product = "titanium-plate",
        }
      })
    end
  end
end
