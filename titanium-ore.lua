local resource_autoplace = require('resource-autoplace');
local util = require("__bztitanium__.data-util");
local item_sounds = require('__base__.prototypes.item_sounds')

if mods["FactorioExtended-Plus-Core"] then
  util.remove_raw("item", "titanium-ore")
end
data.raw.planet.nauvis.map_gen_settings.autoplace_controls["titanium-ore"] = {}
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["titanium-ore"] = {}

if mods.tenebris then
  data.raw.planet.tenebris.map_gen_settings.autoplace_controls["titanium-ore"] = {}
  data.raw.planet.tenebris.map_gen_settings.autoplace_settings.entity.settings["titanium-ore"] = {}
end

if (not mods["pyrawores"]) then
data:extend({
	{
    type = "autoplace-control",
    category = "resource",
    name = "titanium-ore",
    richness = true,
    order = "a-t"
	},
	--{
  --  type = "noise-layer",
  --  name = "titanium-ore"
	--},
	{
    type = "resource",
    icon_size = 64, icon_mipmaps = 3,
    name = "titanium-ore",
    icon = "__bztitanium__/graphics/icons/titanium-ore.png",
    flags = {"placeable-neutral"},
    order="a-b-a",
    map_color = {r=0.65, g=0.80, b=0.80},
    minable =
    {
      hardness = 1,
      mining_particle = "titanium-ore-particle",
      mining_time = 2,
      fluid_amount = util.me.fluid_amount(),
      required_fluid=(settings.startup["bztitanium-mining-fluid"] and settings.startup["bztitanium-mining-fluid"].value or "lubricant"),
      result = "titanium-ore"
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},

    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "titanium-ore",
      order = "a-t",
      base_density = mods["space-age"] and 5 or 3,
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 0.8
    },

    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
        stages =
        {
          sheet =
          {
        filename = "__bztitanium__/graphics/entity/ores/hr-titanium-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
          }
    },
  },
  {
      type = "item",
      name = "titanium-ore",
      icon_size = 64, icon_mipmaps = 3,
      icon = "__bztitanium__/graphics/icons/titanium-ore.png",
      inventory_move_sound = item_sounds.resource_inventory_move,
      pick_sound = item_sounds.resource_inventory_pickup,
      drop_sound = item_sounds.resource_inventory_move,
      pictures = {
        {filename="__bztitanium__/graphics/icons/titanium-ore.png", size=64, scale=0.5},
        {filename="__bztitanium__/graphics/icons/titanium-ore-2.png", size=64, scale=0.5},
        {filename="__bztitanium__/graphics/icons/titanium-ore-3.png", size=64, scale=0.5},
        {filename="__bztitanium__/graphics/icons/titanium-ore-4.png", size=64, scale=0.5},
      },
      subgroup = "raw-resource",
      order = "t-c-a",
      stack_size = util.get_stack_size(50)
  },
})
end

