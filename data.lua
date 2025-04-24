require("api")

require("prototypes.category.recipe-categories")

require("prototypes.entity.entities")
require("prototypes.entity.remnants")

require("prototypes.fluid")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")

require("base-data-updates")

require("prototypes.compat.any-planet-start")
require("prototypes.compat.base")
require("prototypes.compat.space-age")
require("prototypes.compat.bz-ores")

-- NOTE: short term fix that will be obsolete with the new API
CrushingIndustry.concrete_recipes["nuclear-science-pack"] = {ignore=true}
CrushingIndustry.concrete_recipes["nuclear-science-pack-from-plutonium"] = {ignore=true}
