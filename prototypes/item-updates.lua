if settings.startup["crushing-industry-concrete-mix"].value then
  local concrete_mix_barrel = data.raw.item["concrete-mix-barrel"]
  if concrete_mix_barrel then
    concrete_mix_barrel.spoil_ticks = 0.76*hour
    concrete_mix_barrel.spoil_result = "concrete"
  end
end
