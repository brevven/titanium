-- Additions for Space Exploration mod.
local util = require("__bztitanium__.data-util");

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

  -- Organization
  data.raw.item["titanium-plate"].subgroup = "plates"

  -- deadlock loaders for SE -- mods["deadlock-beltboxes-loaders"]
  if mods["Deadlock-SE-bridge"] then
    if data.raw.recipe["se-space-transport-belt-loader"] then
      util.me.steel_to_titanium("se-space-transport-belt-loader")
    end
    if data.raw.recipe["se-space-transport-belt-beltbox"] then
      util.me.steel_to_titanium("se-space-transport-belt-beltbox")
    end
  end
end
