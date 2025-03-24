local frep = require("__fdsl__.lib.recipe")

if mods["Rocket-Silo-Construction"] and settings.startup["crushing-industry-concrete-mix"].value then
  local rsc2 = data.raw["assembling-machine"]["rsc-silo-stage2"]
  rsc2.fluid_boxes[1].pipe_connections = {
    {flow_direction="input", position={0, -4}, direction=defines.direction.north},
    {flow_direction="input", position={0, 4}, direction=defines.direction.south}
  }
  table.insert(rsc2.fluid_boxes, {
    volume = 1000,
    production_type = "input",
    --pipe_picture = {},
    pipe_covers = pipecoverspictures(),
    base_area = 81,
    base_level = -1,
    pipe_connections = {
      {flow_direction="input", position={-4, 0}, direction=defines.direction.west},
      {flow_direction="input", position={4, 0}, direction=defines.direction.east},
    },
  })

  CrushingIndustry.concrete_recipes["rsc-construction-stage4"] = {ignore=true}
  CrushingIndustry.concrete_recipes["rsc-construction-stage6"] = {ignore=true}
end
