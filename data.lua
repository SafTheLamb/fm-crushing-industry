require("api")

require("prototypes.category.recipe-categories")

require("prototypes.sand")
require("prototypes.glass")
require("prototypes.optical-fiber")
require("prototypes.concrete-mix")
require("prototypes.crushed-ore")
require("prototypes.crushed-coal")

require("prototypes.entity.burner-crusher")
require("prototypes.entity.electric-crusher")
require("prototypes.entity.big-crusher")

require("prototypes.fluid")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")

require("base-data-updates")

require("prototypes.compat.any-planet-start")
require("prototypes.compat.base")
require("prototypes.compat.space-age")
require("prototypes.compat.molten-tungsten")
require("prototypes.compat.bz-ores")
require("prototypes.compat.cerys")

-- NOTE: short term fix that will be obsolete with the new API
CrushingIndustry.concrete_recipes["nuclear-science-pack"] = {ignore=true}
CrushingIndustry.concrete_recipes["nuclear-science-pack-from-plutonium"] = {ignore=true}
