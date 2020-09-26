-- Settings, etc.
--
-- Finalize tech tree based on settings and other dependent mods.
local mining_fluid 
if settings.startup["bztitanium-mining-fluid"] then 
  mining_fluid = settings.startup["bztitanium-mining-fluid"].value
end

if mining_fluid == "chlorine" and data.raw.fluid["chlorine"] and mods["Krastorio2"] then
  data.raw.technology["titanium-processing"].prerequisites = {"kr-fluids-chemistry"}
  data.raw.technology["titanium-processing"].unit.ingredients = {
    {"basic-tech-card", 1}, {"automation-science-pack", 1}, {"logistic-science-pack", 1}}
elseif mining_fluid == "sulfuric-acid" then
  data.raw.technology["titanium-processing"].prerequisites = {"sulfur-processing"}
  data.raw.technology["titanium-processing"].unit.ingredients = {
    {"automation-science-pack", 1}, {"logistic-science-pack", 1}}
else
  data.raw.technology["titanium-processing"].prerequisites = {"lubricant"}
end
