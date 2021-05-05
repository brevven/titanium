-- Settings, etc.
--
-- Finalize tech tree based on settings and other dependent mods.
local util = require("__bztitanium__.data-util");

local mining_fluid 
if settings.startup["bztitanium-mining-fluid"] then 
  mining_fluid = settings.startup["bztitanium-mining-fluid"].value
end

if mining_fluid == "chlorine" and data.raw.fluid["chlorine"] and mods["Krastorio2"] then
  data.raw.technology[util.titanium_processing].prerequisites = {"kr-fluids-chemistry"}
  data.raw.technology[util.titanium_processing].unit.ingredients = {
    {"basic-tech-card", 1}, {"automation-science-pack", 1}, {"logistic-science-pack", 1}}
elseif mining_fluid == "sulfuric-acid" then
  data.raw.technology[util.titanium_processing].prerequisites = {"sulfur-processing"}
  data.raw.technology[util.titanium_processing].unit.ingredients = {
    {"automation-science-pack", 1}, {"logistic-science-pack", 1}}
else
  if data.raw.technology["titanium-processing"] then
    data.raw.technology["titanium-processing"].prerequisites = {"lubricant"}
  end
  if not mods["Pre0-17-60Oil"] then
    util.set_tech_recipe("solar-panel-equipment", {
      {"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}})
    util.set_tech_recipe("belt-immunity-equipment", {
      {"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}})
    util.set_tech_recipe("night-vision-equipment", {
      {"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}})
  end
end
