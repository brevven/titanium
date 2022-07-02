-- Additional recipes if Space Exploration mod is enabled
local util = require("data-util");

if mods["space-exploration"] then
  se_delivery_cannon_recipes["titanium-ore"] = {name= "titanium-ore"}
  se_delivery_cannon_recipes[util.me.titanium_plate] = {name= util.me.titanium_plate}
  data:extend({
  {
    type = "recipe",
    icons = {
      { icon = "__base__/graphics/icons/landfill.png", icon_size = 64, icon_mipmaps = 3 },
      { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, scale = 0.25},
    },
    name = "landfill-titanium-ore",
    category = "hard-recycling",
    order = "z-b-titanium",
    subgroup = "terrain",
    result = "landfill",
    ingredients = {{"titanium-ore", 50}},
  }
  })

if string.sub(mods["space-exploration"], 1, 3) == "0.6" then
  data:extend({
  {
    type = "item-subgroup",
    name = "titanium",
    group = "resources",
    order = "a-h-z-a",
  }
  })
  util.set_item_subgroup(util.titanium_plate, "titanium")
  data:extend({
  {
    type = "item",
    name = "titanium-ingot",
    icons = {{icon = "__bztitanium__/graphics/icons/titanium-ingot.png", icon_size = 128}},
    order = "b-b",
    stack_size = 50,
    subgroup = "titanium",
  },
  {
    type = "fluid",
    name = "molten-titanium",
    default_temperature = 1668,
    max_temperature = 1668,
    base_color = {r=191, g=219, b=233},
    flow_color = {r=191, g=219, b=233},
    icons = {{icon = "__bztitanium__/graphics/icons/molten-titanium.png", icon_size = 128}},
    order = "a[molten]-a",
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.59,
    auto_barrel = false,
    subgroup = "fluid",
  },
  {
    type = "recipe",
    category = "smelting",
    name = "molten-titanium",
    subgroup = "titanium",
    results = {
      {type = "fluid", name = "molten-titanium", amount = mods.Krastorio2 and 750 or 900},
    },
    energy_required = 60,
    ingredients = {
      {name = mods.Krastorio2 and "enriched-titanium" or "titanium-ore", amount = 24},
      {type = "fluid", name = "se-pyroflux", amount = 10},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
    order = "a-a"
  },
  {
    type = "recipe",
    name = "titanium-ingot",
    category = "casting",
    results = {{"titanium-ingot", 1}},
    energy_required = 100,
    ingredients = {
      {type = "fluid", name = "molten-titanium", amount = 500},
    },
    enabled = false,
    always_show_made_in = true,
    allow_as_intermediate = false,
  },
  {
    type = "recipe",
    category = "crafting",
    name = "titanium-ingot-to-plate",

    icons = {
      {icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, icon_mipmaps = 3},
      {icon = "__bztitanium__/graphics/icons/titanium-ingot.png", icon_size = 128, scale = 0.125, shift = {-8, -8}},
    },
    results = {
      {name = "titanium-plate", amount = 10},
    },
    energy_required = 5,
    ingredients = {
      {name = "titanium-ingot", amount = 1}
    },
    enabled = false,
    always_show_made_in = true,
    allow_decomposition = false,
    order = "a-c-b"
  },
  })
  util.add_effect("se-pyroflux-smelting", {type = "unlock-recipe", recipe= "molten-titanium"})
  util.add_effect("se-pyroflux-smelting", {type = "unlock-recipe", recipe= "titanium-ingot"})
  util.add_effect("se-pyroflux-smelting", {type = "unlock-recipe", recipe= "titanium-ingot-to-plate"})
  util.add_effect("se-vulcanite-smelting", {type = "unlock-recipe", recipe= "molten-titanium"})
  util.add_effect("se-vulcanite-smelting", {type = "unlock-recipe", recipe= "titanium-ingot"})
  util.add_effect("se-vulcanite-smelting", {type = "unlock-recipe", recipe= "titanium-ingot-to-plate"})
  util.add_prerequisite(data.raw.technology["se-processing-vulcanite"], util.me.titanium_processing)
  if mods["Krastorio2"] then
    util.set_item_subgroup("enriched-titanium", "titanium")
    data.raw.recipe["enriched-titanium-plate"].order= "d[titanium-plate]"
    se_delivery_cannon_recipes["enriched-titanium"] = {name= "enriched-titanium"}
  end
else
  data.raw.item[util.me.titanium_plate].subgroup = "plates"
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
        {name = util.me.titanium_plate, amount = 6},
      },
      icons =
      {
        { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, icon_mipmaps = 3 },
        { icon = "__space-exploration-graphics__/graphics/icons/vulcanite-block.png", icon_size = 64, scale=0.25, shift= {-10, -10}},
      },
    },
    })
    table.insert(data.raw.technology["se-processing-vulcanite"].effects, 
        {type = "unlock-recipe", recipe= "enriched-titanium-smelting-vulcanite"})
    table.insert(data.raw.technology["se-processing-vulcanite"].prerequisites, "enriched-titanium")
    data.raw.recipe["enriched-titanium-plate"].order= "d[titanium-plate]"
    se_delivery_cannon_recipes["enriched-titanium"] = {name= "enriched-titanium"}
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
        {name = util.me.titanium_plate, amount = 6},
      },
      icons =
      {
        { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, icon_mipmaps = 3,},
        { icon = "__space-exploration-graphics__/graphics/icons/vulcanite-block.png", icon_size = 64, scale=0.25, shift= {-10, -10}},
      },
    },
    })
    table.insert(data.raw.technology["se-processing-vulcanite"].effects, 
        {type = "unlock-recipe", recipe= "titanium-smelting-vulcanite"})
    util.add_prerequisite(data.raw.technology["se-processing-vulcanite"], util.me.titanium_processing)
  end
end
end
