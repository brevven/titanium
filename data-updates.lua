require("titanium-recipe-updates")
require("titanium-recipe-updates-transport")
require("titanium-matter")
require("omni")
require("map-gen-preset-updates")
require("strange-matter")
require("compatibility/248k")
require("compatibility/crafting-efficiency")

local util = require("data-util")
util.redo_recycling()

if mods["any-planet-start"] then
  util.set_tech_recipe("titanium-processing", {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
  })
end
