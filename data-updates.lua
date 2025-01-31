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

if mods.Asteroid_Mining and not data.raw.item["asteroid-titanium-ore"] then
  util.addtype("titanium-ore", {a = 0,r = 0.65,g = 0.80,b = 0.80})
end

if mods["any-planet-start"] then
  util.set_tech_recipe("titanium-processing", {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
  })
end

util.add_shiftite_recipe("titanium-plate", "beta", 2)
