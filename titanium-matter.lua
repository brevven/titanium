-- Matter recipes for Krastorio2
if mods["Krastorio2"] then
local util = require("__bztitanium__.data-util");

data:extend(
{
  {
    type = "technology",
    name = "titanium-matter-processing",
    icons =
    {
      {
        icon =   util.k2assets().."/technologies/matter-stone.png",
        icon_size = 256,
      },
      {
        icon = "__bztitanium__/graphics/icons/titanium-ore.png",
        icon_size = 64, icon_mipmaps = 3,
        scale = 1.5,
      }
    },
    effects = {},
    prerequisites = {"kr-matter-processing"},
    unit =
  	{
      count = 350,
      ingredients =
      {
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"kr-matter-tech-card", 1}
      },
      time = 45
    }
  },
})

util.k2matter({
	k2matter = {
    material = {
      name = "titanium-ore",
      type = "item",
      amount = 10,
    },
    matter_count = 8,
    energy_required = 1,
    needs_stabilizer = false,
    allow_productivity = true,
    unlocked_by = "titanium-matter-processing"
	}
})

util.k2matter({
	k2matter = {
    material = {
      name = "titanium-plate",
      type = "item",
      amount = 10,
    },
    matter_count = 14,
    energy_required = 2,
    needs_stabilizer = true,
    allow_productivity = true,
    only_deconversion = true,
    unlocked_by = "titanium-matter-processing"
	}
})

end
