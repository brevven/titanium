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
        { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64 },
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
      icons =
      {
        {
          icon =   "__Krastorio2__/graphics/technologies/enriched-ores.png",
          icon_size = 128,
          tint = { a=1.0, b=0.75, r=0.75, g=0.75 }
        },
        {
          icon = "__bztitanium__/graphics/icons/enriched-titanium.png",
          icon_size = 64,
          scale = 1,
          shift = {32, 32}
        }
      },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "enriched-titanium"
        },
        {
          type = "unlock-recipe",
          recipe = "enriched-titanium-plate"
        },
        {
          type = "unlock-recipe",
          recipe = "dirty-water-filtration-titanium",
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
  },
	{
		type = "recipe",
		name = "dirty-water-filtration-titanium",
		category = "fluid-filtration",
		icons =
		{
			{
				icon = data.raw.fluid["dirty-water"].icon,
				icon_size = data.raw.fluid["dirty-water"].icon_size
			},
			{
				icon = data.raw.item["titanium-ore"].icon,
				icon_size =	data.raw.item["titanium-ore"].icon_size,
				scale = 0.20 * (data.raw.fluid["dirty-water"].icon_size/data.raw.item["titanium-ore"].icon_size),
				shift = {0, 4}
			}
		},
		icon_size = data.raw.fluid["dirty-water"].icon_size,
		energy_required = 2,
		enabled = false,
		allow_as_intermediate = false,
		always_show_made_in = true,
		always_show_products = true,
		ingredients =
		{
			{type = "fluid", name = "dirty-water", amount = 100, catalyst_amount = 100},
		},
		results =
		{
			{type = "fluid", name = "water", amount = 100, catalyst_amount = 100},
			{type = "item",  name = "stone", probability = 0.30, amount = 1},
			{type = "item",  name = "titanium-ore", probability = 0.05, amount = 1}
		},
		crafting_machine_tint =
		{
			primary = {r = 0.60, g = 0.20, b = 0, a = 0.6},
			secondary = {r = 1.0, g = 0.843, b = 0.0, a = 0.9}
		},
		subgroup = "raw-material",
		order = "w013[dirty-water-filtration-titanium]"
	}
}
)
end
