if settings.startup["crushing-industry-big-crusher"].value then
	if mods["quality"] then
		-- some recipe categories including metallurgy have recycling disabled (see default_can_recycle)
		local recycling = require("__quality__.prototypes.recycling")
		recycling.generate_recycling_recipe(data.raw.recipe["big-crusher"], function() return true end)
	end
end
