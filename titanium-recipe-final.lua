-- Titanium recipe & tech changes
-- These are in "final" for compatibility with other mods such as Space Exploration, AAI and Krastorio 2

local util = require("__bztitanium__.data-util");

util.steel_to_titanium(data.raw.recipe["low-density-structure"])
util.steel_to_titanium(data.raw.recipe["low-density-structure"].normal)
util.steel_to_titanium(data.raw.recipe["low-density-structure"].expensive)
util.add_titanium_prerequisite(data.raw.technology["low-density-structure"])

if (not mods["bobplates"] and not mods["angelssmelting"]) then
  util.steel_to_titanium(data.raw.recipe["flying-robot-frame"])
  util.steel_to_titanium(data.raw.recipe["flying-robot-frame"].normal)
  util.steel_to_titanium(data.raw.recipe["flying-robot-frame"].expensive)
  util.add_titanium_prerequisite(data.raw.technology["robotics"])
end


-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.steel_to_titanium(data.raw.recipe["memory-unit"])
  util.steel_to_titanium(data.raw.recipe["memory-unit"].normal)
  util.steel_to_titanium(data.raw.recipe["memory-unit"].expensive)
end

-- Underwater pipes changes
if data.raw.item["underwater-pipe"] then
  if data.raw.technology["underwater-pipes"] then
    local index = -1
    for i, elem in pairs(data.raw.technology["underwater-pipes"].prerequisites) do 
      if elem == "steel-processing" then
        index = i
      end
    end
    if index > -1 then
      table.remove(data.raw.technology["underwater-pipes"].prerequisites, index)
    end
  end
  util.add_titanium_prerequisite(data.raw.technology["underwater-pipes"])

  util.steel_to_titanium(data.raw.recipe["underwater-pipe"])
  util.steel_to_titanium(data.raw.recipe["underwater-pipe"].normal)
  util.steel_to_titanium(data.raw.recipe["underwater-pipe"].expensive)
end

