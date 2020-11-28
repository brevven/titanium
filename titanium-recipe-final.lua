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

-- Krastorio 2 changes
if mods["Krastorio2"] then
  -- Titanium modifies flying robot frames, so use them in a reasonable tech card in Krastorio 2
  util.replace_ingredient(data.raw.recipe["advanced-tech-card"], "electric-engine-unit", "flying-robot-frame")

  -- Flavor changes
  util.rare_to_titanium(data.raw.recipe["kr-electric-mining-drill-mk2"])
  util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt"])
  util.rare_to_titanium(data.raw.recipe["kr-advanced-loader"])
  if mods["deadlock-beltboxes-loaders"] then
    util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt-beltbox"])
    util.rare_to_titanium(data.raw.recipe["kr-advanced-transport-belt-loader"])
  end

  util.steel_to_titanium(data.raw.recipe["kr-quarry-drill"])
  util.steel_to_titanium(data.raw.recipe["kr-singularity-lab"])

  util.steel_to_titanium(data.raw.recipe["stack-inserter"])
  util.steel_to_titanium(data.raw.recipe["stack-inserter"].normal)
  util.steel_to_titanium(data.raw.recipe["stack-inserter"].expensive)
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"])
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"].normal)
  util.steel_to_titanium(data.raw.recipe["stack-filter-inserter"].expensive)

  util.add_titanium_ingredient(40, data.raw.recipe["kr-advanced-steam-turbine"])
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

