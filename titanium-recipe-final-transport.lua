local util = require("__bztitanium__.data-util");

-- Various vehicle/transport mod changes
if mods["Aircraft"] then
  util.replace_ingredient("gunship", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("cargo-plane", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("flying-fortress", "steel-plate", util.me.titanium_plate)
  util.add_ingredient("aircraft-afterburner", util.me.titanium_plate, 10)

  -- jet doesn't use steel in base aircraft mod, but leave this here just in case that changes
  util.replace_ingredient("jet", "steel-plate", util.me.titanium_plate)
end

if mods["betterCargoPlanes"] then
  util.replace_ingredient("better-cargo-plane", "steel-plate", util.me.titanium_plate)
end

if mods["HelicopterRevival"] or mods["Helicopters"] then
  util.replace_ingredient("heli-recipe", "steel-plate", util.me.titanium_plate)
end

if mods["adamo-chopper"] then
  util.replace_ingredient("chopper-recipe", "steel-plate", util.me.titanium_plate)
end

if mods["jetpack"] then
  util.replace_ingredient("jetpack-1", "steel-plate", util.me.titanium_plate)
end

if mods["Hovercrafts"] or mods["Hovercrafts_Realism"] then
  util.replace_ingredient("hcraft-recipe", "steel-plate", util.me.titanium_plate)
  util.add_prerequisite("hcraft-tech", util.me.titanium_processing)
end

if mods["Raven"] then
  util.add_ingredient("raven", util.me.titanium_plate, 100)
end

if mods["Hover-Car"] then
  util.replace_ingredient("hover-car-recipe", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("hover-car-mk2-recipe", "steel-plate", util.me.titanium_plate)
end

if mods["fast_trans"] then
  for i, item in ipairs({
      "cargo-wagon-immortal-mk3", 
      "fluid-wagon-immortal-mk3", 
      "fast-one-mk2 txt",
      "fast-one-mk3 txt",
    }) do
    util.replace_ingredient(item, "steel-plate", util.me.titanium_plate)
  end
  util.add_prerequisite("fast-one-tech-mk2", util.me.titanium_processing)
end

-- Just a general compatiblity improvement with py alien life enabled alongside jetpack or other equipment mods
if mods["pyalienlife"] then
  util.remove_prerequisite("modular-armor", "advanced-electronics")
end
