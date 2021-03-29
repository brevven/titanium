-- Deadlock stacking recipes

local util = require("__bztitanium__.data-util");

if deadlock then
  deadlock.add_stack("titanium-ore",  "__bztitanium__/graphics/icons/stacked/titanium-ore-stacked.png", "deadlock-stacking-2", 64)
  deadlock.add_stack(util.titanium_plate, "__bztitanium__/graphics/icons/stacked/titanium-plate-stacked.png" , "deadlock-stacking-2", 64)
  if mods["Krastorio2"] then
    deadlock.add_stack("enriched-titanium", "__bztitanium__/graphics/icons/stacked/enriched-titanium-stacked.png" , "deadlock-stacking-2", 64)
  end
end

-- Deadlock crating recipes
if deadlock_crating then
  deadlock_crating.add_crate("titanium-ore", "deadlock-crating-2")
  deadlock_crating.add_crate(util.titanium_plate, "deadlock-crating-2")
  if mods["Krastorio2"] then
    deadlock_crating.add_crate("enriched-titanium", "deadlock-crating-2")
  end
end

