data:extend({
	{
		type = "sprite",
		name = "wcu-proxy-big-crusher",
		filename = "__crushing-industry__/graphics/icons/big-crusher.png",
		size = 64
	},
	{
		type = "sprite",
		name = "wcu-proxy-glass",
		filename = "__crushing-industry__/graphics/icons/glass.png",
		size = 64
	},
	{
		type = "sprite",
		name = "wcu-proxy-optical-fiber",
		filename = "__crushing-industry__/graphics/icons/optical-fiber.png",
		size = 64
	},
	{
		type = "sprite",
		name = "wcu-proxy-crushed-ores",
		layers = {
			{filename="__crushing-industry__/graphics/icons/crushed-copper-ore.png", shift={-8,-8}, size=64, scale=0.75},
			{filename="__crushing-industry__/graphics/icons/crushed-iron-ore.png", shift={8,8}, size=64, scale=0.75}
		}
	},
	{
		type = "sprite",
		name = "wcu-proxy-productivity",
		layers = {
			{filename="__base__/graphics/icons/electric-furnace.png", size=64},
			{filename="__core__/graphics/icons/technology/effect-constant/effect-constant-recipe-productivity.png", size=64},
		}
	},
	{
		type = "sprite",
		name = "wcu-proxy-crushed-coal",
		filename = "__crushing-industry__/graphics/icons/crushed-coal.png",
		size = 64
	},
	{
		type = "sprite",
		name = "wcu-proxy-concrete-mix",
		filename = "__crushing-industry__/graphics/icons/fluid/concrete-mix.png",
		size = 64
	}
})

if mods["space-age"] then
	data:extend({
		{
			type = "sprite",
			name = "wcu-proxy-quality-crusher",
			layers = {
				{filename="__space-age__/graphics/icons/crusher.png", size=64, scale=0.5},
				{filename="__core__/graphics/icons/any-quality.png", size=64, shift={8,8}, scale=0.25}
			}
		}
	})
end
