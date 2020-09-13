-- Enriched Titanium for Krastorio2
if mods["Krastorio2"] then
data:extend(
{
  {
    type = "item",
    name = "enriched-titanium",
    icon_size = 64,
    icon = "__bztitanium__/graphics/icons/enriched-titanium.png",
    subgroup = "raw-material",
    order = "e05-a[enriched-ores]-a1[enriched-titanium]",
    stack_size = 200
  },
  {
    type = "recipe",
    name = "enriched-titanium",
    icon = "__bztitanium__/graphics/icons/enriched-titanium.png",
    icon_size = 64,
    category = "chemistry",
    energy_required = 3,
    enabled = false,
    always_show_made_in = true,
    always_show_products = true,
    allow_productivity = true,
    ingredients =
    {
      {type = "fluid", name = "hydrogen-chloride", amount = 10},
      {type = "fluid", name = "water", amount = 25, catalyst_amount = 25},
      {type = "item",  name = "titanium-ore", amount = 9}
    },
    results =
    { 
      {type = "item",  name = "enriched-titanium", amount = 6},
      {type = "fluid", name = "dirty-water", amount = 25, catalyst_amount = 25}
    },
    crafting_machine_tint =
    {
      primary = {r = 0.721, g = 0.525, b = 0.043, a = 0.000},
      secondary = {r = 0.200, g = 0.680, b = 0.300, a = 0.357},
      tertiary = {r = 0.690, g = 0.768, b = 0.870, a = 0.000}, 
      quaternary = {r = 0.0, g = 0.980, b = 0.603, a = 0.900}
    },
    subgroup = "raw-material",
    order = "e03[enriched-titanium]"
  },
  {
      type = "recipe",
      name = "enriched-titanium-plate",
      icons =
      {
        { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 32 },
        { icon = "__bztitanium__/graphics/icons/enriched-titanium.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
      },
      category = "smelting",
      energy_required = 16,
      enabled = false,
      always_show_made_in = true,
      always_show_products = true,
      allow_productivity = true,
      ingredients = 
      {
        {"enriched-titanium", 10}
      },
      result = "titanium-plate",
      result_count = 5,
      order = "b[titanium-plate]-b[enriched-titanium-plate]"
  },	
  {
      type = "technology",
      name = "enriched-titanium",
      icon = "__bztitanium__/graphics/icons/enriched-titanium.png",
      icon_size = 64,
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "enriched-titanium"
        },
        {
          type = "unlock-recipe",
          recipe = "enriched-titanium-plate"
        }
      },
      prerequisites = {"kr-enriched-ores", "titanium-processing"},
      unit =
      {
        count = 150,
        ingredients = 
        {
                  {"automation-science-pack", 1},
                  {"logistic-science-pack", 1},
                  {"chemical-science-pack", 1}
        },
        time = 30
      }
  }
}
)
end
