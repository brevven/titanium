-- Titanium recipe & tech changes
--
local util = require("__bztitanium__.data-util");

if (not mods["bobplates"]) then
  util.replace_ingredient("power-armor", "steel-plate", util.me.titanium_plate)
  util.add_prerequisite("power-armor", util.me.titanium_processing)

  -- Generally, steel-based equipment techs require solar panel tech, so only require
  -- titanium processing for that.
  util.add_prerequisite("solar-panel-equipment", util.me.titanium_processing)


  -- All equipment that uses steel now uses titanium. Who wants to carry around steel!
  for name, recipe in pairs(data.raw.recipe) do
    if recipe.result ~= nil and recipe.result:find("equipment") then
      util.replace_ingredient(recipe.name, "steel-plate", util.me.titanium_plate)
    end
  end
end

util.replace_ingredient("low-density-structure", "steel-plate", util.me.titanium_plate)
if mods["modmashsplintergold"] then
  util.replace_ingredient("low-density-structure-with-gold", "steel-plate", util.me.titanium_plate)
end

if not mods["bobrevamp"] then
  util.add_prerequisite("low-density-structure", util.me.titanium_processing)
end


if (not mods["bobplates"]) then
  util.replace_ingredient("flying-robot-frame", "steel-plate", util.me.titanium_plate)
  util.add_prerequisite("robotics", util.me.titanium_processing)
end

if (mods["bobrevamp"] and not mods["bobplates"] and not mods["angelssmelting"]) then
  util.replace_ingredient("flying-robot-frame-2", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("flying-robot-frame-3", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("flying-robot-frame-4", "steel-plate", util.me.titanium_plate)
end

if data.raw.recipe["se-space-pipe"] then
  -- Space Exploration space stuff
  util.replace_ingredient("se-space-pipe", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("se-space-transport-belt", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("se-space-underground-belt", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("se-space-splitter", "steel-plate", util.me.titanium_plate)
  util.replace_ingredient("se-space-rail", "steel-plate", util.me.titanium_plate)
  util.add_ingredient("se-space-platform-scaffold", util.me.titanium_plate, 1)

  -- Space Exploration alternative LDS
  util.replace_ingredient("se-low-density-structure-beryllium", "steel-plate", util.me.titanium_plate)

  -- Space Exploration buildings
  util.add_ingredient("se-condenser-turbine", util.me.titanium_plate, 20)

  -- A couple more deeper tech thematic items to use titanium in.
  util.add_ingredient("se-lattice-pressure-vessel", util.me.titanium_plate, 2)
  util.add_ingredient("se-aeroframe-bulkhead", util.me.titanium_plate, 2)

  util.add_ingredient("se-experimental-alloys-data", util.me.titanium_plate, 1)
  util.add_to_product("se-experimental-alloys-data", "se-experimental-alloys-data", 1)
  util.add_to_product("se-experimental-alloys-data", "se-scrap", 1)
  util.add_to_ingredient("se-experimental-alloys-data", "se-empty-data", 1)

end


-- Also add titanium to some nuclear steam-handling stuff
util.add_ingredient("steam-turbine", util.me.titanium_plate, 20)
if not mods["pyrawores"] then
  util.add_ingredient("heat-exchanger", util.me.titanium_plate, 20)
  util.add_prerequisite("nuclear-power", util.me.titanium_processing)
end

-- Krastorio 2 changes
if mods["Krastorio2"] then
  util.add_prerequisite("kr-electric-mining-drill-mk2", util.me.titanium_processing)
  util.add_prerequisite("kr-quarry-minerals-extraction", util.me.titanium_processing)
end

if mods["Aircraft"] then
  util.add_prerequisite("advanced-aerodynamics", util.me.titanium_processing)
end

if mods["eve-weaponry"] then
  util.replace_ingredient("small-titanium-sabot", "steel-plate", util.me.titanium_plate)
end

if mods["FastFurnaces"] then
  util.add_ingredient("fast-long-handed-inserter", util.me.titanium_plate, 1)
end

if mods["NuclearFurnace"] then
  util.add_ingredient("nuclear-furnace-4", util.me.titanium_plate, 200)
end

-- Useful Equipment
util.replace_ingredient("craft-assistent", "iron-plate", util.me.titanium_plate)
util.replace_ingredient("artificial-organ", "iron-plate", util.me.titanium_plate)

-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.replace_ingredient("memory-unit", "steel-plate", util.me.titanium_plate)
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
  util.add_prerequisite("underwater-pipes", util.me.titanium_processing)

  util.replace_ingredient("underwater-pipe", "steel-plate", util.me.titanium_plate)
end

-- Space extension
if mods.SpaceMod then
  util.replace_ingredient("hull-component", "steel-plate", util.me.titanium_plate)
  util.replace_some_ingredient("fuel-cell", "steel-plate", 80, util.me.titanium_plate, 80)
  util.replace_some_ingredient("habitation", "steel-plate", 80, util.me.titanium_plate, 80)
end


-- For flying roboports, replace steel, and then add titanium if steel didn't exist.
util.replace_ingredient("flying-roboport", "steel-plate", util.me.titanium_plate)
util.add_ingredient("flying-roboport", util.me.titanium_plate, 10)
