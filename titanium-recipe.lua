-- Titanium smelting
data:extend(
{
  {
    type = "recipe",
    name = "titanium-plate",
    category = "smelting",
     normal =
     {
       enabled = false,
       energy_required = 8,
       ingredients = {{"titanium-ore", 5}},
       result = "titanium-plate"
     },
     expensive =
     {
       enabled = false,
       energy_required = 16,
       ingredients = {{"titanium-ore", 10}},
       result = "titanium-plate"
     }
  },
  {
    type = "item",
    name = "titanium-plate",
    icon = "__bztitanium__/graphics/icons/titanium-plate.png",
    icon_size = 32,
    subgroup = "raw-material",
    order = "b[titanium-plate]",
    stack_size = 100
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
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    prerequisites = {"lubricant"},
    order = "b-b"
  },
}
)


