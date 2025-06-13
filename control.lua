local function get_entity_inventory(entity)
  local bot_cargo = entity.get_inventory(defines.inventory.robot_cargo)
  if bot_cargo then
    return bot_cargo
  end
  local machine_dump = entity.get_inventory(defines.inventory.assembling_machine_dump)
  if machine_dump then
    return machine_dump
  end
  return entity
end

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ci-concrete-mix-barrel-spoiled" then
    return
  end
  local entity = event.target_entity or event.source_entity
  local position = event.source_position or event.target_position or {0, 0}
  -- spoil result is still respected, so subtract 1 per item
  local amount = settings.startup["crushing-industry-concrete-spoil-amount"].value - 1
  if entity then
    if entity.type == "inserter" then
      if entity.held_stack.set_stack({name="concrete", count=amount, quality=event.quality}) then
        amount = 0
      end
    end
    if amount > 0 then
      local inventory = get_entity_inventory(entity)
      amount = amount - inventory.insert({name="concrete", count=amount, quality=event.quality})
    end
  end
  if amount > 0 then
    local surface = game.get_surface(event.surface_index)
    if surface then
      surface.spill_item_stack{position=position, stack={name="concrete", count=amount, quality=event.quality}}
    end
  end
end

if settings.startup["crushing-industry-concrete-mix"].value and settings.startup["crushing-industry-concrete-spoil-amount"].value > 1 then
  script.on_event(defines.events.on_script_trigger_effect, on_script_trigger_effect)
end
