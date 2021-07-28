-- Additions for Space Exploration mod.
local util = require("__bztitanium__.data-util");


if data.raw.recipe["se-space-pipe"] then
  -- Organization
  data.raw.item[util.me.titanium_plate].subgroup = "plates"

  -- deadlock loaders for SE -- mods["deadlock-beltboxes-loaders"]
  if mods["Deadlock-SE-bridge"] then
    if data.raw.recipe["se-space-transport-belt-loader"] then
      util.replace_ingredient("se-space-transport-belt-loader", "steel-plate", util.me.titanium_plate)
    end
    if data.raw.recipe["se-space-transport-belt-beltbox"] then
      util.replace_ingredient("se-space-transport-belt-beltbox", "steel-plate", util.me.titanium_plate)
    end
  end
end
