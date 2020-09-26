local util = require("__bztitanium__.data-util");

-- Various vehicle/transport mod changes
if mods["Aircraft"] then
  util.steel_to_titanium(data.raw.recipe["gunship"])
  util.steel_to_titanium(data.raw.recipe["gunship"].normal)
  util.steel_to_titanium(data.raw.recipe["gunship"].expensive)
  util.steel_to_titanium(data.raw.recipe["cargo-plane"])
  util.steel_to_titanium(data.raw.recipe["cargo-plane"].normal)
  util.steel_to_titanium(data.raw.recipe["cargo-plane"].expensive)
  util.steel_to_titanium(data.raw.recipe["flying-fortress"])
  util.steel_to_titanium(data.raw.recipe["flying-fortress"].normal)
  util.steel_to_titanium(data.raw.recipe["flying-fortress"].expensive)
  util.add_titanium_ingredient(10, data.raw.recipe["aircraft-afterburner"])
  util.add_titanium_ingredient(10, data.raw.recipe["aircraft-afterburner"].normal)
  util.add_titanium_ingredient(20, data.raw.recipe["aircraft-afterburner"].expensive)

  -- jet doesn't use steel in base aircraft mod, but leave this here just in case that changes
  util.steel_to_titanium(data.raw.recipe["jet"])
  util.steel_to_titanium(data.raw.recipe["jet"].normal)
  util.steel_to_titanium(data.raw.recipe["jet"].expensive)
end

if mods["betterCargoPlanes"] then
  util.steel_to_titanium(data.raw.recipe["better-cargo-plane"])
  util.steel_to_titanium(data.raw.recipe["better-cargo-plane"].normal)
  util.steel_to_titanium(data.raw.recipe["better-cargo-plane"].expensive)
end

if mods["HelicopterRevival"] or mods["Helicopters"] then
  util.steel_to_titanium(data.raw.recipe["heli-recipe"])
  util.steel_to_titanium(data.raw.recipe["heli-recipe"].normal)
  util.steel_to_titanium(data.raw.recipe["heli-recipe"].expensive)
end

if mods["adamo-chopper"] then
  util.steel_to_titanium(data.raw.recipe["chopper-recipe"])
  util.steel_to_titanium(data.raw.recipe["chopper-recipe"].normal)
  util.steel_to_titanium(data.raw.recipe["chopper-recipe"].expensive)
end

if mods["jetpack"] then
  util.steel_to_titanium(data.raw.recipe["jetpack-1"])
  util.steel_to_titanium(data.raw.recipe["jetpack-1"].normal)
  util.steel_to_titanium(data.raw.recipe["jetpack-1"].expensive)
end

if mods["Hovercrafts"] then
  util.steel_to_titanium(data.raw.recipe["hcraft-recipe"])
  util.steel_to_titanium(data.raw.recipe["hcraft-recipe"].normal)
  util.steel_to_titanium(data.raw.recipe["hcraft-recipe"].expensive)
end

if mods["Raven"] then
  util.add_titanium_ingredient(100, data.raw.recipe["raven"])
  util.add_titanium_ingredient(100, data.raw.recipe["raven"].normal)
  util.add_titanium_ingredient(100, data.raw.recipe["raven"].expensive)
end

