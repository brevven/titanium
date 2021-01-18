-- Additional recipes if Space Exploration mod is enabled
local util = require("__bztitanium__.data-util");

if mods["space-exploration"] then
  if mods["Krastorio2"] then
    data:extend({
    {
      type = "recipe",
      name = "enriched-titanium-smelting-vulcanite",
      category = "smelting",
      order = "d[titanium-plate]",
      energy_required = 24,
      enabled = false,
      always_show_made_in = true,
      allow_as_intermediate = false,
      ingredients = {
        {name = "enriched-titanium", amount = 8},
        {name = "se-vulcanite-block", amount = 1},
      },
      results = {
        {name = util.titanium_plate, amount = 6},
      },
      icons =
      {
        { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64 },
        { icon = "__space-exploration-graphics__/graphics/icons/vulcanite-block.png", icon_size = 64, scale=0.25, shift= {-10, -10}},
      },
      
    },
    })
    table.insert(data.raw.technology["se-processing-vulcanite"].effects, 
        {type = "unlock-recipe", recipe= "enriched-titanium-smelting-vulcanite"})
    table.insert(data.raw.technology["se-processing-vulcanite"].prerequisites, "enriched-titanium")
    data.raw.recipe["enriched-titanium-plate"].order= "d[titanium-plate]"
  else
    data:extend({
    {
      type = "recipe",
      name = "titanium-smelting-vulcanite",
      category = "smelting",
      order = "d[titanium-plate]",
      energy_required = 48,
      enabled = false,
      always_show_made_in = true,
      allow_as_intermediate = false,
      ingredients = {
        {name = "titanium-ore", amount = 20},
        {name = "se-vulcanite-block", amount = 1},
      },
      results = {
        {name = util.titanium_plate, amount = 6},
      },
      icons =
      {
        { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64 },
        { icon = "__space-exploration-graphics__/graphics/icons/vulcanite-block.png", icon_size = 64, scale=0.25, shift= {-10, -10}},
      },
    },
    })
    table.insert(data.raw.technology["se-processing-vulcanite"].effects, 
        {type = "unlock-recipe", recipe= "titanium-smelting-vulcanite"})
    util.add_titanium_prerequisite(data.raw.technology["se-processing-vulcanite"])
  end
end
