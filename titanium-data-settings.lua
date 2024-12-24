-- Settings, etc.
--
-- Finalize tech tree based on settings and other dependent mods.
local util = require("__bztitanium__.data-util");

local mining_fluid 
if settings.startup["bztitanium-mining-fluid"] then 
  mining_fluid = settings.startup["bztitanium-mining-fluid"].value
end

if mining_fluid == "chlorine" and data.raw.fluid["chlorine"] and mods["Krastorio2"] then
  data.raw.technology[util.me.titanium_processing].prerequisites = {"kr-fluids-chemistry"}
  data.raw.technology[util.me.titanium_processing].unit.ingredients = util.ALC
else
end
