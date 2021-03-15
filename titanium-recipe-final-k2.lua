-- Final Krastorio 2 changes
-- There are other K2 changes throughout

local util = require("__bztitanium__.data-util");
if mods["Krastorio2"] then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.replace_ingredient("advanced-tech-card", "electric-engine-unit", "flying-robot-frame")

  -- Flavor changes
  util.rare_to_titanium("kr-electric-mining-drill-mk2")
  util.rare_to_titanium("kr-advanced-transport-belt")
  util.rare_to_titanium("kr-advanced-loader")
  if mods["deadlock-beltboxes-loaders"] then
    util.rare_to_titanium("kr-advanced-transport-belt-beltbox")
    util.rare_to_titanium("kr-advanced-transport-belt-loader")
  end

  util.steel_to_titanium("kr-quarry-drill")
  util.steel_to_titanium("kr-singularity-lab")

  util.steel_to_titanium("stack-inserter")
  util.steel_to_titanium("stack-filter-inserter")

  util.add_titanium_ingredient(40, "kr-advanced-steam-turbine")
end
