local frep = require("__fdsl__.lib.recipe")

-------------------------------------------------------------------------- Basic crusher

-- Make sure all basic crushers can craft all basic crushing recipes
-- Use the electric crusher as the golden standard for all basic crushing categories
local basic_crushing_categories = {}
for _,category in pairs(data.raw.furnace["electric-crusher"].crafting_categories) do
	basic_crushing_categories[category] = true
end

local basic_crushing_max_results = 0
for _,recipe in pairs(data.raw.recipe) do
	if recipe.results ~= nil then
		if frep.has_any_category(recipe, basic_crushing_categories) then
			basic_crushing_max_results = math.max(basic_crushing_max_results, #recipe.results)
		end
	end
end

-- Update all basic crushers with the new result inventory size
for _,furnace in pairs(data.raw.furnace) do
	for _,category in pairs(furnace.crafting_categories) do
		if basic_crushing_categories[category] then
			if basic_crushing_max_results > furnace.result_inventory_size then
				furnace.result_inventory_size = basic_crushing_max_results
			end
			break
		end
	end
end

-------------------------------------------------------------------------- Asteroid reprocessing

if mods["space-age"] then
	-- Modify asteroid reprocessing recipes to invalidate all productivity bonuses
	local function string_ends_with(str, ending)
		local len = string.len(str)
		return str.sub(str, len - string.len(ending) + 1, len) == ending
	end

	for _,recipe in pairs(data.raw.recipe) do
		if recipe.results and string_ends_with(recipe.name, "-asteroid-reprocessing") then
			for _,result in pairs(recipe.results) do
				result.ignored_by_productivity = 1
			end
		end
	end
end
