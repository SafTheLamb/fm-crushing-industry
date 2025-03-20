local frep = require("__fdsl__.lib.recipe")


if mods["planet-muluna"] then
    
    

    
    if data.raw["assembling-machine"]["crusher-2"] then
        frep.scale_ingredient("crusher-2", "aluminum-plate", {amount=5})
        frep.scale_ingredient("crusher-2", "tungsten-plate", {amount=5})
        frep.replace_ingredient("crusher-2", "uranium-238", {type="item", name="quality-module-3", amount=4})
        data.raw["assembling-machine"]["crusher"].effect_receiver = {base_effect={quality=2, productivity=0.25}}

        data.raw["assembling-machine"]["crusher-2"].localised_name = {"entity-name.crusher-n","2"}
        data.raw["item"]["crusher-2"].localised_name = {"entity-name.crusher-n","2"}
        data.raw["recipe"]["crusher-2"].localised_name = {"entity-name.crusher-n","2"}
        --data.raw["assembling-machine"]["crusher"].surface_conditions = muluna_space_restriction
    end

    if data.raw["technology"]["crusher"] then
        data.raw["technology"]["crusher"].localised_name = {"entity-name.space-crusher"}
        
    end
    if data.raw["technology"]["crusher-2"] then
        data.raw["technology"]["crusher-2"].localised_name = {"entity-name.crusher-n","2"}
    end
end

