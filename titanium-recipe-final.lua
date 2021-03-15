-- Titanium recipe & tech changes
-- These are in "final" for compatibility with other mods such as Space Exploration, AAI and Krastorio 2

local util = require("__bztitanium__.data-util");

util.steel_to_titanium("low-density-structure")
if not mods["bobrevamp"] then
  util.add_titanium_prerequisite("low-density-structure")
end

if (not mods["bobplates"] and not mods["angelssmelting"]) then
  util.steel_to_titanium("flying-robot-frame")
  util.add_titanium_prerequisite("robotics")
end

if (mods["bobrevamp"] and not mods["bobplates"] and not mods["angelssmelting"]) then
  util.steel_to_titanium("flying-robot-frame-2")
  util.steel_to_titanium("flying-robot-frame-3")
  util.steel_to_titanium("flying-robot-frame-4")
end



-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.steel_to_titanium("memory-unit")
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
  util.add_titanium_prerequisite("underwater-pipes")

  util.steel_to_titanium("underwater-pipe")
end

