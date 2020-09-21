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
end

-- Aircraft changes
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

-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.steel_to_titanium(data.raw.recipe["memory-unit"])
  util.steel_to_titanium(data.raw.recipe["memory-unit"].normal)
  util.steel_to_titanium(data.raw.recipe["memory-unit"].expensive)
end



