-- Titanium smelting

local util = require("__bztitanium__.data-util");

if mods["FactorioExtended-Plus-Core"] then
  util.remove_raw("recipe", "titanium-ore")
  util.remove_raw("item", "titanium-alloy")
  util.remove_raw("recipe", "titanium-alloy")
  util.remove_raw("technology", "titanium-processing")
end

data:extend(
{
  {
    type = "recipe",
    name = "titanium-plate",
    category = "smelting",
    order = "d[titanium-plate]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 32 },
          { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 32, scale=0.5, shift= {-8, -8}},
        } or nil),
    normal = (mods["Krastorio2"] and
        {
          enabled = false,
          energy_required = 16,
          ingredients = {{"titanium-ore", 10}},
          results = {{type="item", name= util.titanium_plate, amount_min=2, amount_max=3}},
        } or
        {
          enabled = false,
          energy_required = 8,
          ingredients = {{"titanium-ore", 5}},
          result = util.titanium_plate
        }),
    expensive =
    {
      enabled = false,
      energy_required = 16,
      ingredients = {{"titanium-ore", 10}},
      result = util.titanium_plate
    }
  },
  {
    type = "item",
    name = util.titanium_plate,
    icon = "__bztitanium__/graphics/icons/titanium-plate.png",
    icon_size = 32,
    subgroup = "raw-material",
    order = "b[titanium-plate]",
    stack_size = (mods["Krastorio2"] and 200 or 100)
  },
  {
    type = "technology",
    name = "titanium-processing",
    icon_size = 128,
    icon = "__bztitanium__/graphics/icons/titanium-processing.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "titanium-plate"
      }
    },
    unit =
    {
      count = 75,
      ingredients = (mods["Pre0-17-60Oil"] and
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
          } or
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1}
          }),
      time = 30
    },
    prerequisites = {"lubricant"},
    order = "b-b"
  },
}
)
