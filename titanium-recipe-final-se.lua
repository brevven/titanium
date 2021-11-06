-- Additions for Space Exploration mod.
local util = require("__bztitanium__.data-util");


if data.raw.recipe["se-space-pipe"] then
  -- Organization
  data.raw.item[util.me.titanium_plate].subgroup = "plates"

  -- core mining balancing
  util.add_to_product("se-core-fragment-omni", "titanium-ore", -2)

  -- deadlock loaders for SE -- mods["deadlock-beltboxes-loaders"]
  if mods["Deadlock-SE-bridge"] then
    if data.raw.recipe["se-space-transport-belt-loader"] then
      util.replace_ingredient("se-space-transport-belt-loader", "steel-plate", util.me.titanium_plate)
    end
    if data.raw.recipe["se-space-transport-belt-beltbox"] then
      util.replace_ingredient("se-space-transport-belt-beltbox", "steel-plate", util.me.titanium_plate)
    end
  end
  util.remove_ingredient("low-density-structure", "steel-plate")
end
