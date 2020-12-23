-- Titanium recipe & tech changes
--
local util = require("__bztitanium__.data-util");

util.steel_to_titanium(data.raw.recipe["power-armor"])
util.add_titanium_prerequisite(data.raw.technology["power-armor"])

-- All equipment that uses steel now uses titanium. Who wants to carry around steel!
for name, recipe in pairs(data.raw.recipe) do
	if recipe.result ~= nil and recipe.result:find("equipment") then
		util.steel_to_titanium(recipe)
	end
end
-- Generally, steel-based equipment techs require solar panel tech, so only require
-- titanium processing for that.
util.add_titanium_prerequisite(data.raw.technology["solar-panel-equipment"])


-- Also add titanium to steam turbines
util.add_titanium_ingredient(20, data.raw.recipe["steam-turbine"])
util.add_titanium_ingredient(20, data.raw.recipe["heat-exchanger"])
util.add_titanium_prerequisite(data.raw.technology["nuclear-power"])

-- Krastorio 2 changes
if mods["Krastorio2"] then
  util.add_titanium_prerequisite(data.raw.technology["kr-electric-mining-drill-mk2"])
  util.add_titanium_prerequisite(data.raw.technology["kr-quarry-minerals-extraction"])
end

if mods["Aircraft"] then
  util.add_titanium_prerequisite(data.raw.technology["advanced-aerodynamics"])
end
