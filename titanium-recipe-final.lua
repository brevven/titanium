-- Titanium recipe & tech changes
-- These are in "final" for compatibility with other mods such as Space Exploration and AAI

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
  util.add_titanium_prerequisite(data.raw.technology["se-space-platform-scaffold"])
end
