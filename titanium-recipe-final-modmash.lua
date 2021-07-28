local util = require("__bztitanium__.data-util");

if mods["modmashsplinter"] then
  if mods["modmashsplinterresources"] then
    util.remove_raw("recipe", "titanium-extraction-process")

    data.raw.recipe["alien-enrichment-process-to-titanium-ore"].icons = {
      { icon = "__modmashsplinterresources__/graphics/icons/alien-ooze.png", icon_size = 64},
      { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {8, 8}},
    }

    if mods["modmashsplinterenrichment"] then
      data.raw.recipe["ore-enrichment-process-titanium-ore"].icons = {
        { icon = "__base__/graphics/icons/fluid/steam.png", icon_size = 64},
        { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {8, 8}},
      }
    end
  end
  if mods["modmashsplinterrefinement"] then 
    local recipe = data.raw.recipe["titanium-ore-refined_to_plate"]
    if recipe and recipe.ingredients then
      for i, ingredient in ipairs(recipe.ingredients) do
        if ingredient[1] and ingredient[1] == "titanium-ore-refined" then
          ingredient[2] = 5
        end
      end
    end
    if recipe and recipe.normal and recipe.normal.ingredients then
      for i, ingredient in ipairs(recipe.normal.ingredients) do
        if ingredient[1] and ingredient[1] == "titanium-ore-refined" then
          ingredient[2] = 5
        end
      end
    end
    if recipe and recipe.expensive and recipe.expensive.ingredients then
      for i, ingredient in ipairs(recipe.expensive.ingredients) do
        if ingredient[1] and ingredient[1] == "titanium-ore-refined" then
          ingredient[2] =10 
        end
      end
    end
  end

  if mods["modmashsplinterlogistics"] then 
    util.replace_ingredient("regenerative-transport-belt", "steel-plate", "titanium-plate")
    util.replace_ingredient("regenerative-splitter", "steel-plate", "titanium-plate")
    util.replace_ingredient("regenerative-underground-belt-structure", "steel-plate", "titanium-plate")
    util.replace_ingredient("regenerative-mini-loader", "steel-plate", "titanium-plate")
  end

end
