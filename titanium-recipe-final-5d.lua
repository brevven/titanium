local util = require("__bztitanium__.data-util");

if mods["5dim_core"] then

  data.raw.item["titanium-plate"].subgroup = "plates-plates"
  data.raw.recipe["titanium-plate"].subgroup = "plates-plates"

  -- Industrial furnace
  data:extend({
    {
      type = "recipe",
      name = "titanium-plate-industrial-ore",
      category = "industrial-furnace",
      subgroup = "plates-industrial-ore",
      order = "ad[titanium-plate]",
      icon = "__bztitanium__/graphics/icons/titanium-plate.png",
      icon_size = 64,
      enabled = false,
      energy_required = 140,
      ingredients = {{"titanium-ore", 425}},
      result = util.titanium_plate,
      result_count = 100,
    }
  })
  table.insert(data.raw.technology["titanium-processing"].effects, 
      {type = "unlock-recipe", recipe="titanium-plate-industrial-ore"})


  -- Titanium dust
  data:extend(
    {
        {
            type = "item",
            name = "titanium-dust",
            icon_size = 32,
            subgroup = "plates-dust",
            order = "d[titanium-plate]",
            icon = "__bztitanium__/graphics/icons/titanium-powder.png",
            icon_size = 64,
            stack_size = 200
        },
        {
            type = "recipe",
            name = "titanium-plate-dust",
            icon = "__bztitanium__/graphics/icons/titanium-plate.png",
            icon_size = 64,
            subgroup = "plates-plates2",
            order = "d[titanium-plate]",
            category = "smelting",
            energy_required = 8,
            enabled = false,
            ingredients = {
                {"titanium-dust", 5}
            },
            result = util.titanium_plate
        },
        {
            type = "recipe",
            name = "titanium-dust",
            category = "mashering",
            order = "d[titanium-plate]",
            energy_required = 3.2,
            enabled = false,
            ingredients = {
                {"titanium-ore", 1}
            },
            result = "titanium-dust",
            result_count = 2
        },
        {
          type = "recipe",
          name = "titanium-plate-industrial-dust",
          category = "industrial-furnace",
          subgroup = "plates-industrial-dust",
          order = "ad[titanium-plate]",
          icon = "__bztitanium__/graphics/icons/titanium-plate.png",
          icon_size = 64,
          enabled = false,
          energy_required = 140,
          ingredients = {{"titanium-dust", 425}},
          result = util.titanium_plate,
          result_count = 100,
        }
  })
  table.insert(data.raw.technology["titanium-processing"].effects, 
      {type = "unlock-recipe", recipe="titanium-dust"})
  table.insert(data.raw.technology["titanium-processing"].effects, 
      {type = "unlock-recipe", recipe="titanium-plate-dust"})
  table.insert(data.raw.technology["titanium-processing"].effects, 
      {type = "unlock-recipe", recipe="titanium-plate-industrial-dust"})


  -- Vehicles
  if mods["5dim_vehicle"] then
    util.steel_to_titanium(data.raw.recipe["5d-air-plane"])
    util.steel_to_titanium(data.raw.recipe["5d-air-plane"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-air-plane"].expensive)
    util.steel_to_titanium(data.raw.recipe["5d-boat"])
    util.steel_to_titanium(data.raw.recipe["5d-boat"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-boat"].expensive)
  end

  if mods["5dim_transport"] then
    util.steel_to_titanium(data.raw.recipe["5d-mk5-transport-belt"])
    util.steel_to_titanium(data.raw.recipe["5d-mk5-transport-belt"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-mk5-transport-belt"].expensive)
  end


end
