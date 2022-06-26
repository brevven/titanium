-- Titanium smelting

local util = require("__bztitanium__.data-util");

if mods["FactorioExtended-Plus-Core"] then
  util.remove_raw("recipe", "titanium-ore")
  util.remove_raw("item", "titanium-alloy")
  util.remove_raw("recipe", "titanium-alloy")
  util.remove_raw("technology", "titanium-processing")
end

if mods["modmashsplinterresources"] then
  util.remove_raw("item", "titanium-plate")
  util.remove_raw("recipe", "titanium-extraction-process")
end

if (mods["bobrevamp"] and not mods["bobores"]) then
  util.remove_raw("technology", "titanium-processing")
end

if (not mods["pyrawores"] and not mods["bobplates"]) then
data:extend({
  {
    type = "recipe",
    name = util.me.titanium_plate,
    category = "smelting",
    order = "d[titanium-plate]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, icon_mipmaps = 3,},
          { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {-8, -8}},
        } or nil),
    normal = (mods["Krastorio2"] and
        {
          enabled = false,
          energy_required = 16,
          ingredients = {{"titanium-ore", 10}},
          results = {{type="item", name= util.me.titanium_plate, amount_min=2, amount_max=3}},
        } or
        {
          enabled = false,
          energy_required = 8,
          ingredients = {{"titanium-ore", 5}},
          result = util.me.titanium_plate
        }),
    expensive =
    {
      enabled = false,
      energy_required = 16,
      ingredients = {{"titanium-ore", 10}},
      result = util.me.titanium_plate
    }
  },
  {
    type = "item",
    name = util.me.titanium_plate,
    icon = "__bztitanium__/graphics/icons/titanium-plate.png",
    icon_size = 64, icon_mipmaps = 3,
    subgroup = "raw-material",
    order = "b[titanium-plate]",
    stack_size = util.get_stack_size(100)
  },
  {
    type = "technology",
    name = "titanium-processing",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__bztitanium__/graphics/technology/titanium-processing.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = util.me.titanium_plate
      },
      mods["TheBigFurnace"] and {
        type = "unlock-recipe",
        recipe = "big-titanium-plate",
      } or nil,
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
  mods["TheBigFurnace"] and {
    type = "recipe",
    name = "big-titanium-plate",
    category = "big-smelting",
    order = "d[titanium-plate]",
    normal =
    {
      enabled = false,
      energy_required = 8.75,
      ingredients = {{"titanium-ore", 50}},
      result = util.me.titanium_plate,
      result_count = 10,
    },
    expensive =
    {
      enabled = false,
      energy_required = 16,
      ingredients = {{"titanium-ore", 100}},
      result = util.me.titanium_plate,
      result_count = 10,
    }
  } or nil,
})
end
