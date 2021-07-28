-- Additions for Space Exploration mod.
local util = require("__bztitanium__.data-util");


if data.raw.recipe["se-space-pipe"] then
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
