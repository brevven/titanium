local util = require("data-util");

local ti2 = "fi_materials_titan"

-- Swap out all 248k titanium for BZ titanium_plate
for i, recipe in pairs(data.raw.recipe) do
  util.replace_ingredient(recipe.name, ti2, util.titanium_plate)
  util.replace_product(recipe.name, ti2, util.titanium_plate)
end

-- Remove 248k titanium plate
util.remove_raw("item", ti2)
