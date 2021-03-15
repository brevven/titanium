local util = require("__bztitanium__.data-util");

-- Various vehicle/transport mod changes
if mods["Aircraft"] then
  util.steel_to_titanium("gunship")
  util.steel_to_titanium("cargo-plane")
  util.steel_to_titanium("flying-fortress")
  util.add_titanium_ingredient(10, "aircraft-afterburner")

  -- jet doesn't use steel in base aircraft mod, but leave this here just in case that changes
  util.steel_to_titanium("jet")
end

if mods["betterCargoPlanes"] then
  util.steel_to_titanium("better-cargo-plane")
end

if mods["HelicopterRevival"] or mods["Helicopters"] then
  util.steel_to_titanium("heli-recipe")
end

if mods["adamo-chopper"] then
  util.steel_to_titanium("chopper-recipe")
end

if mods["jetpack"] then
  util.steel_to_titanium("jetpack-1")
end

if mods["Hovercrafts"] or mods["Hovercrafts_Realism"] then
  util.steel_to_titanium("hcraft-recipe")
  util.add_titanium_prerequisite("hcraft-tech")
end

if mods["Raven"] then
  util.add_titanium_ingredient(100, "raven")
end

if mods["Hover-Car"] then
  util.steel_to_titanium("hover-car-recipe")
  util.steel_to_titanium("hover-car-mk2-recipe")
end

-- Just a general compatiblity improvement with py alien life enabled alongside jetpack or other equipment mods
if mods["pyalienlife"] then
  util.remove_prerequisite("modular-armor", "advanced-electronics")
end
