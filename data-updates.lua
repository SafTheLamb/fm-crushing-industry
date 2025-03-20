local frep = require("__fdsl__.lib.recipe")

if mods["planet-muluna"] and data.raw["assembling-machine"]["crusher-2"] then
  frep.scale_ingredient("crusher-2", "aluminum-plate", {amount=5})
  frep.scale_ingredient("crusher-2", "tungsten-plate", {amount=5})
  frep.replace_ingredient("crusher-2", "uranium-238", {type="item", name="quality-module-3", amount=4})
  data.raw["assembling-machine"]["crusher"].effect_receiver = {base_effect={quality=2, productivity=0.25}}
end
