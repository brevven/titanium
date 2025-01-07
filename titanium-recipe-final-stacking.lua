-- Deadlock stacking recipes

local util = require("__bztitanium__.data-util");

if deadlock and deadlock["add_stack"] then
  deadlock.add_stack("titanium-ore",  "__bztitanium__/graphics/icons/stacked/titanium-ore-stacked.png", "deadlock-stacking-2", 64)
  deadlock.add_stack(util.me.titanium_plate, "__bztitanium__/graphics/icons/stacked/titanium-plate-stacked.png" , "deadlock-stacking-2", 64)
  if mods["Krastorio2"] then
    deadlock.add_stack("enriched-titanium", "__bztitanium__/graphics/icons/stacked/enriched-titanium-stacked.png" , "deadlock-stacking-2", 64)
  end
  if data.raw.item["titanium-ingot"] then
    deadlock.add_stack("titanium-ingot", nil, "deadlock-stacking-2", nil)
  end
end

-- Deadlock crating recipes
if deadlock_crating then
  deadlock_crating.add_crate("titanium-ore", "deadlock-crating-2")
  deadlock_crating.add_crate(util.me.titanium_plate, "deadlock-crating-2")
  if mods["Krastorio2"] then
    deadlock_crating.add_crate("enriched-titanium", "deadlock-crating-2")
  end
  if data.raw.item["titanium-ingot"] then
    deadlock_crating.add_crate("titanium-ingot", "deadlock-crating-2")
  end
end

