-- Deadlock stacking recipes
if deadlock then
  deadlock.add_stack("titanium-ore",  "__bztitanium__/graphics/icons/titanium-ore-stacked.png", "deadlock-stacking-2", 32)
  deadlock.add_stack("titanium-plate", "__bztitanium__/graphics/icons/titanium-plate-stacked.png" , "deadlock-stacking-2", 32)
end

-- Deadlock crating recipes
if deadlock_crating then
  deadlock_crating.add_crate("titanium-ore", "deadlock-crating-2")
  deadlock_crating.add_crate("titanium-plate", "deadlock-crating-2")
end

