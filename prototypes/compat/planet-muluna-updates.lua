local frep = require("__fdsl__.lib.recipe")

if mods["planet-muluna"] then
  data.raw["assembling-machine"]["crusher"].localised_name = {"entity-name.space-crusher-n", "1"}
  frep.replace_ingredient("crusher", "quality-module-2", "quality-module")
  
  if data.raw["assembling-machine"]["crusher-2"] then
    frep.scale_ingredient("crusher-2", "aluminum-plate", {amount=5})
    frep.scale_ingredient("crusher-2", "tungsten-plate", {amount=5})
    frep.replace_ingredient("crusher-2", "uranium-238", {type="item", name="quality-module-3", amount=4})
    data.raw["assembling-machine"]["crusher-2"].effect_receiver = {base_effect={quality=2, productivity=0.25}}
    data.raw["assembling-machine"]["crusher-2"].localised_name = {"entity-name.space-crusher-n", "2"}
  end

  if data.raw["technology"]["crusher"] then
    data.raw["technology"]["crusher"].localised_name = {"technology-name.space-crusher-n", "1"}
  end

  if data.raw["technology"]["crusher-2"] then
    data.raw["technology"]["crusher-2"].localised_name = {"technology-name.space-crusher-n", "2"}
  end
end
