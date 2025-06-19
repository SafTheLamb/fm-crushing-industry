local multispoil = require("__multispoil__.api")

if settings.startup["crushing-industry-concrete-mix"].value and settings.startup["crushing-industry-concrete-spoil-amount"].value > 0 then
	local concrete_mix_barrel = data.raw.item["concrete-mix-barrel"]
	if concrete_mix_barrel then
		concrete_mix_barrel.spoil_ticks = 0.26*hour
		concrete_mix_barrel.spoil_result = "concrete"
		if settings.startup["crushing-industry-concrete-spoil-amount"].value > 1 then
			concrete_mix_barrel.spoil_to_trigger_result = multispoil.create_spoil_trigger({["concrete"] = settings.startup["crushing-industry-concrete-spoil-amount"].value - 1})
		end
	end
end
