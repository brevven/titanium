-- Final Krastorio 2 changes
-- There are other K2 changes throughout

local util = require("__bztitanium__.data-util");
if mods["Krastorio2"] then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.replace_ingredient(data.raw.recipe["advanced-tech-card"], "electric-engine-unit", "flying-robot-frame")

  -- Flavor changes
  util.rare_to_titanium(data.raw.recipe["kr-electric-mining-drill-mk2"])
  util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt"])
  util.rare_to_titanium(data.raw.recipe["kr-advanced-loader"])
  if mods["deadlock-beltboxes-loaders"] then
    util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt-beltbox"])
    util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt-loader"])
  end

  util.steel_to_titanium(data.raw.recipe["kr-quarry-drill"])
  util.steel_to_titanium(data.raw.recipe["kr-singularity-lab"])

  util.steel_to_titanium(data.raw.recipe["stack-inserter"])
  util.steel_to_titanium(data.raw.recipe["stack-inserter"].normal)
  util.steel_to_titanium(data.raw.recipe["stack-inserter"].expensive)
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"])
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"].normal)
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"].expensive)

  util.add_titanium_ingredient(40, data.raw.recipe["kr-advanced-steam-turbine"])
end
