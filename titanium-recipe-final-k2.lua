-- Final Krastorio 2 changes
-- There are other K2 changes throughout

local util = require("__bztitanium__.data-util");
if mods["Krastorio2"] then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.replace_ingredient("advanced-tech-card", "electric-engine-unit", "flying-robot-frame")

  -- Flavor changes
  util.me.rare_to_titanium("kr-electric-mining-drill-mk2")
  util.me.rare_to_titanium("kr-advanced-transport-belt")
  util.me.rare_to_titanium("kr-advanced-loader")
  if mods["deadlock-beltboxes-loaders"] then
    util.me.rare_to_titanium("kr-advanced-transport-belt-beltbox")
    util.me.rare_to_titanium("kr-advanced-transport-belt-loader")
  end

  util.replace_ingredient("kr-quarry-drill", "steel-plate", "titanium-plate")
  util.replace_ingredient("kr-singularity-lab", "steel-plate", "titanium-plate")

  util.replace_ingredient("stack-inserter", "steel-plate", "titanium-plate")
  util.replace_ingredient("stack-filter-inserter", "steel-plate", "titanium-plate")

  util.me.add_titanium_ingredient(40, "kr-advanced-steam-turbine")
end
