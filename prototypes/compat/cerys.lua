if mods["Cerys-Moon-of-Fulgora"] then
	local fulgoran_crusher = data.raw["assembling-machine"]["cerys-fulgoran-crusher"]
	if fulgoran_crusher then
		if settings.startup["crushing-industry-space-crusher"].value then
			fulgoran_crusher.crafting_speed = 1.5 * fulgoran_crusher.crafting_speed
			fulgoran_crusher.effect_receiver = {base_effect={quality=1.25, productivity=0.25}}
			fulgoran_crusher.energy_usage = "1.86MW"
		end
	end
end
