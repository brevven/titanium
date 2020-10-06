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
  -- Space Exploration space stuff
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
  util.steel_to_titanium(data.raw.recipe["se-space-rail"])
  util.steel_to_titanium(data.raw.recipe["se-space-rail"].normal)
  util.steel_to_titanium(data.raw.recipe["se-space-rail"].expensive)

  -- Space Exploration alternative LDS
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"])
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"].normal)
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"].expensive)
  util.add_titanium_prerequisite(data.raw.technology["se-space-platform-scaffold"])

  -- Space Exploration buildings
  util.add_titanium_ingredient(20, data.raw.recipe["se-condenser-turbine"])
  util.add_titanium_ingredient(20, data.raw.recipe["se-condenser-turbine"].normal)
  util.add_titanium_ingredient(20, data.raw.recipe["se-condenser-turbine"].expensive)
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

-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.steel_to_titanium(data.raw.recipe["memory-unit"])
  util.steel_to_titanium(data.raw.recipe["memory-unit"].normal)
  util.steel_to_titanium(data.raw.recipe["memory-unit"].expensive)
end
