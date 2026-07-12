require("api")

require("prototypes.category.recipe-categories")

require("prototypes.technology")

require("prototypes.sand")
require("prototypes.glass")
require("prototypes.optical-fiber")
require("prototypes.concrete-mix")
require("prototypes.crushed-ores")
require("prototypes.crushed-coal")
require("prototypes.proxy-sprites")

require("prototypes.entity.burner-crusher")
require("prototypes.entity.electric-crusher")
require("prototypes.entity.big-crusher")

require("prototypes.entity.entities")
require("prototypes.entity.remnants")

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
