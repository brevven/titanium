local util = require("data-util");

if mods["248k"] then
  local ti2 = "fi_materials_titan"

  -- Swap out all 248k titanium for BZ titanium_plate
  for i, recipe in pairs(data.raw.recipe) do
    util.replace_ingredient(recipe.name, ti2, util.titanium_plate)
    util.replace_product(recipe.name, ti2, util.titanium_plate)
  end

  if mods.LootingRemnants and data.raw.recipe.gr_white_hole_cycle_fi_materials_titan_recipe~=nil then
    data.raw.recipe.gr_white_hole_cycle_fi_materials_titan_recipe.exception_mods = {"Deconstruction", "LootingRemnants"}
  end

  -- Remove 248k titanium plate
  util.remove_raw("item", ti2)
end
