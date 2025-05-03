-- Second part of hack for endgame combat

if mods.EndgameCombat and not mods["pyrawores"] and not mods["bobplates"] and not mods["angelssmelting"] then

local util = require("data-util");

local dummy_items = {"cobalt-steel", "nickel", "aluminium"}
if not mods.bztungsten then
  table.insert(dummy_items, "tungsten")
end
for i, dummy in pairs(dummy_items) do
  util.remove_raw("item", dummy)
end

local dummy_techs = {"cobalt-processing", "nickel-processing", "aluminium-processing"}
if not mods.bztungsten then
  table.insert(dummy_techs, "tungsten-processing")
end
for i, dummy in pairs(dummy_techs) do
  util.remove_raw("technology", dummy)
end

util.remove_ingredient("cannon-turret", "cobalt-steel")
util.remove_prerequisite("cannon-turrets", "cobalt-processing")

util.remove_ingredient("shockwave-turret", "nickel")
util.remove_prerequisite("shockwave-turrets", "nickel-processing")

util.remove_ingredient("acid-turret", "aluminium")
util.remove_prerequisite("acid-turrets", "aluminium-processing")

util.remove_ingredient("power-armor-mk3", "copper-tungsten-alloy")
util.remove_prerequisite("power-armor-mk3", "nitinol-processing")

if not mods.bztungsten then
  util.remove_prerequisite("power-armor-mk3", "tungsten-processing")

  util.remove_ingredient("lightning-turret", "tungsten")
  util.remove_prerequisite("lightning-turrets", "tungsten-processing")
  if util.k2() then
    util.remove_raw("recipe", "kr-vc-tungsten")
  end
end

if util.k2() then
  -- remove K2 recipes that are created when our dummy items are detected
  util.remove_raw("recipe", "kr-vc-cobalt-steel")
  util.remove_raw("recipe", "kr-vc-nickel")
  util.remove_raw("recipe", "kr-vc-aluminium")
end
end


