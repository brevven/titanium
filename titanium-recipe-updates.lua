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
