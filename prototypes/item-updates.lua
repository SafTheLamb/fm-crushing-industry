if settings.startup["crushing-industry-concrete-mix"].value then
  local concrete_mix_barrel = data.raw.item["concete-mix-barrel"]
  if concrete_mix_barrel then
    concrete_mix_barrel.spoil_time = 0.8*hour -- 345600 / 2
    concrete_mix_barrel.spoil_result = "concrete"
  end
end
