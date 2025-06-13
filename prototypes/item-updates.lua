if settings.startup["crushing-industry-concrete-mix"].value and settings.startup["crushing-industry-concrete-spoil-amount"].value > 0 then
  local concrete_mix_barrel = data.raw.item["concrete-mix-barrel"]
  if feature_flags["spoiling"] then
    if concrete_mix_barrel then
      concrete_mix_barrel.spoil_ticks = 0.26*hour
      concrete_mix_barrel.spoil_result = "concrete"
      if settings.startup["crushing-industry-concrete-spoil-amount"].value == 1 then
        concrete_mix_barrel.spoil_result = "concrete"
      else
        concrete_mix_barrel.spoil_to_trigger_result = {
          items_per_trigger = 1,
          trigger = {
            type = "direct",
            action_delivery = {
              type = "instant",
              target_effects = {
                type = "script",
                effect_id = "ci-concrete-mix-barrel-spoiled"
              }
            }
          }
        }
      end
    end
  end
end
