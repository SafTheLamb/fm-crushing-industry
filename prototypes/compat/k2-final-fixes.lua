local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

-- Krastorio 2 adds its own glass... 
if mods["Krastorio2"] or mods["Krastorio2-spaced-out"] then
	if settings.startup["crushing-industry-k2"].value then
		data.raw.item["kr-sand"].hidden = true
		data.raw.recipe["kr-sand"].hidden = true
		for _,recipe in pairs(data.raw.recipe) do
			frep.replace_ingredient(recipe.name, "kr-sand", "sand")
			frep.replace_result(recipe.name, "kr-sand", "sand")
			if recipe.main_product == "kr-sand" then
				recipe.main_product = "sand"
			end
		end

		ftech.replace_unlock("kr-stone-processing", "kr-sand", "sand")
		ftech.remove_unlock("steam-power", "sand")

		if settings.startup["crushing-industry-glass"].value then
			data.raw.item["kr-glass"].hidden = true
			data.raw.recipe["kr-glass"].hidden = true
			for _,recipe in pairs(data.raw.recipe) do
				frep.replace_ingredient(recipe.name, "kr-glass", "glass")
				frep.replace_result(recipe.name, "kr-glass", "glass")
				if recipe.main_product == "kr-glass" then
					recipe.main_product = "glass"
				end
			end

			ftech.replace_unlock("kr-stone-processing", "kr-glass", "glass")
			ftech.remove_unlock("electronics", "glass")
		end
	end
end
