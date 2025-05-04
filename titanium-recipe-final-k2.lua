-- Final Krastorio 2 changes
-- There are other K2 changes throughout

local util = require("__bztitanium__.data-util");
if util.k2() then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.multiply_recipe("kr-advanced-tech-card", 2)
  util.replace_ingredient("kr-advanced-tech-card", "electric-engine-unit", "flying-robot-frame", 5)

  -- Flavor changes
  util.replace_ingredient("kr-electric-mining-drill-mk2", "kr-rare-metals", util.me.titanium_plate)
  util.replace_ingredient("kr-advanced-transport-belt", "kr-rare-metals", util.me.titanium_plate)
  util.replace_ingredient("kr-advanced-loader", "kr-rare-metals", util.me.titanium_plate)
  if mods["deadlock-beltboxes-loaders"] then
    util.replace_ingredient("kr-advanced-transport-belt-beltbox", "kr-rare-metals", util.me.titanium_plate)
    util.replace_ingredient("kr-advanced-transport-belt-loader", "kr-rare-metals", util.me.titanium_plate)
  end

  util.replace_ingredient("kr-quarry-drill", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("kr-singularity-lab", "steel-plate", util.me.titanium_plate)

  util.replace_ingredient("bulk-inserter", "steel-plate", util.me.titanium_plate)

  util.add_ingredient("kr-advanced-steam-turbine", util.me.titanium_plate, 40)

  -- Must be in final fixes
  util.replace_ingredient("kr-se-loader", "steel-plate", util.me.titanium_plate) -- K2 + SE
end
