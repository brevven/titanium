-- Titanium recipe & tech changes
-- These are in "final" for compatibility with other mods such as Space Exploration, AAI and Krastorio 2

local util = require("__bztitanium__.data-util");

util.steel_to_titanium(data.raw.recipe["low-density-structure"])
util.steel_to_titanium(data.raw.recipe["low-density-structure"].normal)
util.steel_to_titanium(data.raw.recipe["low-density-structure"].expensive)
util.add_titanium_prerequisite(data.raw.technology["low-density-structure"])

util.steel_to_titanium(data.raw.recipe["flying-robot-frame"])
util.steel_to_titanium(data.raw.recipe["flying-robot-frame"].normal)
util.steel_to_titanium(data.raw.recipe["flying-robot-frame"].expensive)

util.add_titanium_prerequisite(data.raw.technology["robotics"])

-- Additions for Space Exploration mod.
if data.raw.recipe["se-space-pipe"] then
  util.steel_to_titanium(data.raw.recipe["se-space-pipe"])
  util.steel_to_titanium(data.raw.recipe["se-space-pipe"].normal)
  util.steel_to_titanium(data.raw.recipe["se-space-pipe"].expensive)
  util.steel_to_titanium(data.raw.recipe["se-space-transport-belt"])
  util.steel_to_titanium(data.raw.recipe["se-space-transport-belt"].normal)
  util.steel_to_titanium(data.raw.recipe["se-space-transport-belt"].expensive)
  util.steel_to_titanium(data.raw.recipe["se-space-underground-belt"])
  util.steel_to_titanium(data.raw.recipe["se-space-underground-belt"].normal)
  util.steel_to_titanium(data.raw.recipe["se-space-underground-belt"].expensive)
  util.steel_to_titanium(data.raw.recipe["se-space-splitter"])
  util.steel_to_titanium(data.raw.recipe["se-space-splitter"].normal)
  util.steel_to_titanium(data.raw.recipe["se-space-splitter"].expensive)
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"])
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"].normal)
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"].expensive)
  util.add_titanium_prerequisite(data.raw.technology["se-space-platform-scaffold"])
end


-- Krastorio 2 changes
if mods["Krastorio2"] then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.replace_ingredient(data.raw.recipe["advanced-tech-card"], "electric-engine-unit", "flying-robot-frame")

  -- Flavor changes
  util.rare_to_titanium(data.raw.recipe["kr-electric-mining-drill-mk2"])
  util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt"])
  util.rare_to_titanium(data.raw.recipe["kr-advanced-loader"])

  util.steel_to_titanium(data.raw.recipe["kr-quarry-drill"])
  util.steel_to_titanium(data.raw.recipe["kr-singularity-lab"])

  util.steel_to_titanium(data.raw.recipe["stack-inserter"])
  util.steel_to_titanium(data.raw.recipe["stack-inserter"].normal)
  util.steel_to_titanium(data.raw.recipe["stack-inserter"].expensive)
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"])
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"].normal)
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"].expensive)

  util.add_titanium_ingredient(40, "kr-advanced-steam-turbine")
end

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

-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.steel_to_titanium(data.raw.recipe["memory-unit"])
  util.steel_to_titanium(data.raw.recipe["memory-unit"].normal)
  util.steel_to_titanium(data.raw.recipe["memory-unit"].expensive)
end


-- Settings, etc.
--
-- Finalize tech tree based on settings and other dependent mods.
local mining_fluid 
if settings.startup["bztitanium-mining-fluid"] then 
  mining_fluid = settings.startup["bztitanium-mining-fluid"].value
end

if mining_fluid == "chlorine" and data.raw.fluid["chlorine"] and mods["Krastorio2"] then
  data.raw.technology["titanium-processing"].prerequisites = {"kr-fluids-chemistry"}
  data.raw.technology["titanium-processing"].unit.ingredients = {
    {"basic-tech-card", 1}, {"automation-science-pack", 1}, {"logistic-science-pack", 1}}
elseif mining_fluid == "sulfuric-acid" then
  data.raw.technology["titanium-processing"].prerequisites = {"sulfur-processing"}
  data.raw.technology["titanium-processing"].unit.ingredients = {
    {"automation-science-pack", 1}, {"logistic-science-pack", 1}}
else
  data.raw.technology["titanium-processing"].prerequisites = {"lubricant"}
end
