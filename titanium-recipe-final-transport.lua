local util = require("__bztitanium__.data-util");

-- Various vehicle/transport mod changes
if mods["Aircraft"] then
  util.me.steel_to_titanium("gunship")
  util.me.steel_to_titanium("cargo-plane")
  util.me.steel_to_titanium("flying-fortress")
  util.me.add_titanium_ingredient(10, "aircraft-afterburner")

  -- jet doesn't use steel in base aircraft mod, but leave this here just in case that changes
  util.me.steel_to_titanium("jet")
end

if mods["betterCargoPlanes"] then
  util.me.steel_to_titanium("better-cargo-plane")
end

if mods["HelicopterRevival"] or mods["Helicopters"] then
  util.me.steel_to_titanium("heli-recipe")
end

if mods["adamo-chopper"] then
  util.me.steel_to_titanium("chopper-recipe")
end

if mods["jetpack"] then
  util.me.steel_to_titanium("jetpack-1")
end

if mods["Hovercrafts"] or mods["Hovercrafts_Realism"] then
  util.me.steel_to_titanium("hcraft-recipe")
  util.me.add_titanium_prerequisite("hcraft-tech")
end

if mods["Raven"] then
  util.me.add_titanium_ingredient(100, "raven")
end

if mods["Hover-Car"] then
  util.me.steel_to_titanium("hover-car-recipe")
  util.me.steel_to_titanium("hover-car-mk2-recipe")
end

if mods["fast_trans"] then
  for i, item in ipairs({
      "cargo-wagon-immortal-mk3", 
      "fluid-wagon-immortal-mk3", 
      "fast-one-mk2 txt",
      "fast-one-mk3 txt",
    }) do
    util.me.steel_to_titanium(item)
  end
  util.me.add_titanium_prerequisite("fast-one-tech-mk2")
end

-- Just a general compatiblity improvement with py alien life enabled alongside jetpack or other equipment mods
if mods["pyalienlife"] then
  util.remove_prerequisite("modular-armor", "advanced-electronics")
end
