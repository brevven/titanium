-- Titanium smelting

local util = require("__bztitanium__.data-util");
local item_sounds = require('__base__.prototypes.item_sounds')

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
    main_product = util.me.titanium_plate,
    category = "smelting",
    order = "d[titanium-plate]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, icon_mipmaps = 3,},
          { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {-8, -8}},
        } or nil),
    enabled = false,
    allow_productivity = true,
    energy_required = mods.Krastorio2 and 16 or 8,
    ingredients = {util.item("titanium-ore", mods.Krastorio2 and 10 or (mods["space-age"] and 10 or 5))},
    results = {mods.Krastorio2 and {type="item", name= util.me.titanium_plate, amount_min=2, amount_max=3} or util.item(util.me.titanium_plate)},
    -- expensive =
    -- {
    --   energy_required = 16,
    --   ingredients = {{"titanium-ore", 10}},
    --   result = util.me.titanium_plate
    -- }
  },
  {
    type = "item",
    name = util.me.titanium_plate,
    icon = "__bztitanium__/graphics/icons/titanium-plate.png",
    icon_size = 64, icon_mipmaps = 3,
    subgroup = "raw-material",
    order = "b[titanium-plate]",
    stack_size = util.get_stack_size(100),
    weight = 1*kg,
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
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
    research_trigger = {type="mine-entity", entity="titanium-ore"},
    prerequisites = {"lubricant", "uranium-mining"},
    order = "b-b"
  },
--   mods["TheBigFurnace"] and {
--     type = "recipe",
--     name = "big-titanium-plate",
--     category = "big-smelting",
--     order = "d[titanium-plate]",
--     normal =
--     {
--       enabled = false,
--       energy_required = 8.75,
--       ingredients = {{"titanium-ore", 50}},
--       result = util.me.titanium_plate,
--       result_count = 10,
--     },
--     expensive =
--     {
--       enabled = false,
--       energy_required = 16,
--       ingredients = {{"titanium-ore", 100}},
--       result = util.me.titanium_plate,
--       result_count = 10,
--     }
--   } or nil,
})
if mods["space-age"] then
util.add_vacuum()
data:extend({
  {
    type = "recipe",
    name = "titanium-ore-from-stone",
    main_product = "titanium-ore",
    category = "chemistry",
    subgroup = "vulcanus-processes",
    order = "d[titanium-ore]",
    icons = {
          { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3},
          { icon = "__base__/graphics/icons/stone.png", icon_size = 64, scale = 0.25, shift = {-8, -8}},
        },
    enabled = false,
    allow_productivity = true,
    energy_required = 1,
    ingredients = {util.item("stone", 3), util.fluid("sulfuric-acid", 10)},
    results = {util.item("titanium-ore")},
  },
  {
    type = "recipe",
    name = "titanium-sublimation",
    main_product = "vacuum",
    category = "chemistry",
    subgroup = "vulcanus-processes",
    order = "d[titanium-sublimation]",
    icons = {
          util.vacuum_icon,
          { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, scale=0.25, icon_mipmaps = 3, shift = {-8, -8}},
        },
    enabled = false,
    allow_productivity = true,
    energy_required = 5, 
    ingredients = {util.item("titanium-plate")},
    results = {
      util.fluid("vacuum", 100),
      util.item("stone", 1),
    },
    show_amount_in_title = false,
  },
  {
    type = "recipe",
    name = "titanium-in-foundry",
    main_product = util.me.titanium_plate,
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "d[titanium-ore]",
    icons = {
          { icon = "__bztitanium__/graphics/icons/titanium-plate.png", icon_size = 64, icon_mipmaps = 3},
          util.vacuum_icon_small,
        },
    enabled = false,
    allow_productivity = true,
    energy_required = 2, 
    ingredients = {
      util.item("titanium-ore", 2),
      util.fluid("vacuum"),
    },
    results = {util.item("titanium-plate")},
  },
  {
    type = "recipe",
    name = "titanium-extraction",
    category = "organic-or-hand-crafting",
    icons = {
          { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, scale = 0.5, icon_mipmaps = 3, shift = {6,8}},
          { icon = "__space-age__/graphics/icons/jellynut.png", icon_size = 64, scale = 0.5, shift = {-6, -8}},
        },
    surface_conditions =
    {
      {
        property = "pressure",
        min = 2000,
        max = 2000
      }
    },
    subgroup = "agriculture-processes",
    order = "e[bacteria]-a[bacteria]-b[titanium]",
    enabled = false,
    allow_productivity = true,
    energy_required = 6,
    ingredients =
    {
      {type = "item", name = "jellynut", amount = 1},
      {type = "item", name = "spoilage", amount = 9},
    },
    results =
    {
      {type = "item", name = "titanium-ore", amount = 5},
      {type = "item", name = "jellynut-seed", amount = 1, probability = 0.02},
      {type = "item", name = "spoilage", amount = 10}
    },
    crafting_machine_tint =
    {
      primary = {r = 0.1, g = 0.5, b = 0.5, a = 1},
      secondary = {r = 0.1, g = 0.2, b = 0.3, a = 1},
    }
  },
  })
end
end
