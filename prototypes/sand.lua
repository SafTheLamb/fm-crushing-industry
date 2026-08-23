local frep = require("__fdsl__.lib.recipe")

local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local REMIX = false --settings.startup["crushing-industry-recipe-mode"].value == "remix"

data:extend({
	{
		type = "item",
		name = "sand",
		icon = "__crushing-industry__/graphics/icons/sand.png",
		pictures = {
			{size=64, filename="__crushing-industry__/graphics/icons/sand.png", scale=0.5, mipmap_count=4},
			{size=64, filename="__crushing-industry__/graphics/icons/sand-1.png", scale=0.5, mipmap_count=4},
			{size=64, filename="__crushing-industry__/graphics/icons/sand-2.png", scale=0.5, mipmap_count=4},
		},
		subgroup = "raw-resource",
		order = "d[stone]-c[crushed]",
		inventory_move_sound = item_sounds.resource_inventory_move,
		pick_sound = item_sounds.resource_inventory_pickup,
		drop_sound = item_sounds.resource_inventory_move,
		stack_size = 200,
		weight = 1 * kg
	},
	{
		type = "recipe",
		name = "sand",
		icons = CrushingIndustry.make_crushing_icons("stone"),
		categories = {"basic-crushing", "hand-crafting"},
		enabled = false,
		allow_productivity = true,
		auto_recycle = false,
		energy_required = REMIX and 1.2 or 0.96,
		ingredients = {{type="item", name="stone", amount=1}},
		results = {
			{type="item", name="sand", amount=2},
			CrushingIndustry.make_crushing_byproduct("stone"),
		},
		main_product = "sand"
	}
})

if settings.startup["crushing-industry-sandfill"].value then
	if not (mods["Krastorio2"] or mods["Krastorio2-spaced-out"]) then
		data:extend({
			{
				type = "recipe",
				name = "sandfill",
				icon = "__crushing-industry__/graphics/icons/sandfill.png",
				-- icons = {
				-- 	{icon="__base__/graphics/icons/landfill.png"},
				-- 	{icon="__crushing-industry__/graphics/icons/sand.png", scale=0.25, shift={-8, -8}, draw_background=true}
				-- },
				categories = {"crafting-with-fluid"},
				enabled = false,
				auto_recycle = false,
				energy_required = 0.5,
				ingredients = {
					{type="item", name="sand", amount=50 },
					{type="fluid", name="water", amount=50 },
				},
				results = {{type="item", name="landfill", amount=1}},
				allow_as_intermediate = false,
			}
		})
	end
end

if mods["aai-industry"] then
	frep.replace_category("sand", "crafting", "hand-crafting")
	frep.add_category("sand", "basic-crushing")
end

if mods["recycler"] then
	local recycling_lib = require("__recycler__.recycling")
	-- Override stone brick recycling to yield sand instead
	recycling_lib.generate_self_recycling_recipe(data.raw.item["stone-brick"])
	frep.replace_result("stone-brick-recycling", "stone-brick", {type="item", name="sand", amount=1, ignored_by_stats=1})
end
