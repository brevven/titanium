-- Titanium recipe & tech changes
--
local util = require("__bztitanium__.data-util");

if (not mods["bobplates"]) then
  util.me.steel_to_titanium("power-armor")
  util.add_prerequisite("power-armor", util.me.titanium_processing)

  -- Generally, steel-based equipment techs require solar panel tech, so only require
  -- titanium processing for that.
  util.add_prerequisite("solar-panel-equipment", util.me.titanium_processing)


  -- All equipment that uses steel now uses titanium. Who wants to carry around steel!
  for name, recipe in pairs(data.raw.recipe) do
    if recipe.result ~= nil and recipe.result:find("equipment") then
      util.me.steel_to_titanium(recipe.name)
    end
  end
end

util.me.steel_to_titanium("low-density-structure")
if mods["modmashsplintergold"] then
  util.me.steel_to_titanium("low-density-structure-with-gold")
end

if not mods["bobrevamp"] then
  util.me.add_titanium_prerequisite("low-density-structure")
end


if (not mods["bobplates"]) then
  util.me.steel_to_titanium("flying-robot-frame")
  util.me.add_titanium_prerequisite("robotics")
end

if (mods["bobrevamp"] and not mods["bobplates"] and not mods["angelssmelting"]) then
  util.me.steel_to_titanium("flying-robot-frame-2")
  util.me.steel_to_titanium("flying-robot-frame-3")
  util.me.steel_to_titanium("flying-robot-frame-4")
end




if data.raw.recipe["se-space-pipe"] then
  -- Space Exploration space stuff
  util.me.steel_to_titanium("se-space-pipe")
  util.me.steel_to_titanium("se-space-transport-belt")
  util.me.steel_to_titanium("se-space-underground-belt")
  util.me.steel_to_titanium("se-space-splitter")
  util.me.steel_to_titanium("se-space-rail")
  util.me.add_titanium_ingredient(1, "se-space-platform-scaffold")

  -- Space Exploration alternative LDS
  util.me.steel_to_titanium("se-low-density-structure-beryllium")

  -- Space Exploration buildings
  util.me.add_titanium_ingredient(20, "se-condenser-turbine")

  -- A couple more deeper tech thematic items to use titanium in.
  util.me.add_titanium_ingredient(2, "se-lattice-pressure-vessel")
  util.me.add_titanium_ingredient(2, "se-aeroframe-bulkhead")

  util.add_ingredient("se-experimental-alloys-data", "titanium-plate", 1)
  util.add_to_product("se-experimental-alloys-data", "se-experimental-alloys-data", 1)
  util.add_to_product("se-experimental-alloys-data", "se-scrap", 1)
  util.add_to_ingredient("se-experimental-alloys-data", "se-empty-data", 1)

end


-- Also add titanium to some nuclear steam-handling stuff
util.me.add_titanium_ingredient(20, "steam-turbine")
if not mods["pyrawores"] then
  util.me.add_titanium_ingredient(20, "heat-exchanger")
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
  util.me.steel_to_titanium("small-titanium-sabot")
end

if mods["FastFurnaces"] then
  util.me.add_titanium_ingredient(1, "fast-long-handed-inserter")
end

if mods["NuclearFurnace"] then
  util.me.add_titanium_ingredient(200, "nuclear-furnace-4")
end

-- Useful Equipment
util.replace_ingredient("craft-assistent", "iron-plate", "titanium-plate")
util.replace_ingredient("artificial-organ", "iron-plate", "titanium-plate")

-- Memory storage changes
if data.raw.item["memory-unit"] then
  util.me.steel_to_titanium("memory-unit")
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
  util.me.add_titanium_prerequisite("underwater-pipes")

  util.me.steel_to_titanium("underwater-pipe")
end

