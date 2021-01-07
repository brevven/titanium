-- Additions for Space Exploration mod.
local util = require("__bztitanium__.data-util");

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
  util.add_titanium_ingredient(1, data.raw.recipe["se-space-platform-scaffold"])
  util.add_titanium_ingredient(1, data.raw.recipe["se-space-platform-scaffold"].normal)
  util.add_titanium_ingredient(1, data.raw.recipe["se-space-platform-scaffold"].expensive)

  -- Space Exploration alternative LDS
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"])
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"].normal)
  util.steel_to_titanium(data.raw.recipe["se-low-density-structure-beryllium"].expensive)

  -- Space Exploration buildings
  util.add_titanium_ingredient(20, data.raw.recipe["se-condenser-turbine"])
  util.add_titanium_ingredient(20, data.raw.recipe["se-condenser-turbine"].normal)
  util.add_titanium_ingredient(20, data.raw.recipe["se-condenser-turbine"].expensive)

  -- A couple more deeper tech thematic items to use titanium in.
  util.add_titanium_ingredient(2, data.raw.recipe["se-lattice-pressure-vessel"])
  util.add_titanium_ingredient(2, data.raw.recipe["se-lattice-pressure-vessel"].normal)
  util.add_titanium_ingredient(2, data.raw.recipe["se-lattice-pressure-vessel"].expensive)
  util.add_titanium_ingredient(2, data.raw.recipe["se-aeroframe-bulkhead"])
  util.add_titanium_ingredient(2, data.raw.recipe["se-aeroframe-bulkhead"].normal)
  util.add_titanium_ingredient(2, data.raw.recipe["se-aeroframe-bulkhead"].expensive)

  -- Organization
  data.raw.item["titanium-plate"].subgroup = "plates"

  -- deadlock loaders for SE -- mods["deadlock-beltboxes-loaders"]
  if mods["Deadlock-SE-bridge"] then
    util.steel_to_titanium(data.raw.recipe["se-space-transport-belt-loader"])
    util.steel_to_titanium(data.raw.recipe["se-space-transport-belt-loader"].normal)
    util.steel_to_titanium(data.raw.recipe["se-space-transport-belt-loader"].expensive)
    if data.raw.recipe["se-space-transport-belt-beltbox"] then
      util.steel_to_titanium(data.raw.recipe["se-space-transport-belt-beltbox"])
      util.steel_to_titanium(data.raw.recipe["se-space-transport-belt-beltbox"].normal)
      util.steel_to_titanium(data.raw.recipe["se-space-transport-belt-beltbox"].expensive)
    end
  end
end
