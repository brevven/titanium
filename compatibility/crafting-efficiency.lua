local util = require("data-util");

if mods["crafting-efficiency-2"] then

  local eff_data = {
  }

  for i, recipe in pairs(util.me.recipes) do
    -- add remaining recipes with direct items to find the icons
    if data.raw.recipe[recipe] and data.raw.item[recipe] and not eff_data[recipe] and util.get_result_count(recipe) == 1 then
      eff_data[recipe] = {
        max = 15,
        icon =  data.raw.item[recipe].icon,
        crafting = { efficiency = 10 },
        research = { level = 6 },
      }
    end
  end
  for recipe, d in pairs(eff_data) do 
    log("Adding "..recipe.." crafting efficiency")
    d.name = recipe:gsub("^%l", string.upper).." efficiency"
    CE_Add_Recipe(d, recipe)
  end
end
