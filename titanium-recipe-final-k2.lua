-- Final Krastorio 2 changes
-- There are other K2 changes throughout

local util = require("__bztitanium__.data-util");
if mods["Krastorio2"] then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.replace_ingredient("advanced-tech-card", "electric-engine-unit", "flying-robot-frame")

  -- Flavor changes
  util.replace_ingredient("kr-electric-mining-drill-mk2", "rare-metals", util.me.titanium_plate)
  util.replace_ingredient("kr-advanced-transport-belt", "rare-metals", util.me.titanium_plate)
  util.replace_ingredient("kr-advanced-loader", "rare-metals", util.me.titanium_plate)
  if mods["deadlock-beltboxes-loaders"] then
    util.replace_ingredient("kr-advanced-transport-belt-beltbox", "rare-metals", util.me.titanium_plate)
    util.replace_ingredient("kr-advanced-transport-belt-loader", "rare-metals", util.me.titanium_plate)
  end

  util.replace_ingredient("kr-quarry-drill", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("kr-singularity-lab", "steel-plate", util.me.titanium_plate)

  util.replace_ingredient("stack-inserter", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("stack-filter-inserter", "steel-plate", util.me.titanium_plate)

  util.add_ingredient("kr-advanced-steam-turbine", util.me.titanium_plate, 40)

  -- Must be in final fixes
  util.replace_ingredient("kr-se-loader", "steel-plate", util.me.titanium_plate) -- K2 + SE
end
