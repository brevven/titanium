local util = require("__bztitanium__.data-util");

if mods["5dim_core"] then

  data.raw.item["titanium-plate"].subgroup = "plates-plates"
  data.raw.recipe["titanium-plate"].subgroup = "plates-plates"
  data.raw.item["titanium-ore"].subgroup = "plates-ore"

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
  table.insert(data.raw.technology[util.titanium_processing].effects, 
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
  table.insert(data.raw.technology[util.titanium_processing].effects, 
      {type = "unlock-recipe", recipe="titanium-dust"})
  table.insert(data.raw.technology[util.titanium_processing].effects, 
      {type = "unlock-recipe", recipe="titanium-plate-dust"})
  table.insert(data.raw.technology[util.titanium_processing].effects, 
      {type = "unlock-recipe", recipe="titanium-plate-industrial-dust"})

  if mods["5dim_automation"] then
    util.steel_to_titanium(data.raw.recipe["5d-assembling-machine-07"])
    util.steel_to_titanium(data.raw.recipe["5d-assembling-machine-07"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-assembling-machine-07"].expensive)
    util.steel_to_titanium(data.raw.recipe["5d-assembling-machine-08"])
    util.steel_to_titanium(data.raw.recipe["5d-assembling-machine-08"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-assembling-machine-08"].expensive)
    util.steel_to_titanium(data.raw.recipe["5d-lab-06"])
    util.steel_to_titanium(data.raw.recipe["5d-lab-06"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-lab-06"].expensive)
    util.steel_to_titanium(data.raw.recipe["5d-lab-07"])
    util.steel_to_titanium(data.raw.recipe["5d-lab-07"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-lab-07"].expensive)
  end

  if mods["5dim_nuclear"] then
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-02"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-02"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-02"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-03"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-03"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-03"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-04"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-04"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-04"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-05"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-05"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-05"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-06"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-06"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-06"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-07"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-07"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-07"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-08"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-08"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-08"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-09"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-09"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-09"].expensive)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-10"])
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-10"].normal)
    util.add_titanium_ingredient(20, data.raw.recipe["5d-steam-turbine-10"].expensive)
  end

  if mods["5dim_battlefield"] then
    util.steel_to_titanium(data.raw.recipe["5d-stone-wall-09"])
    util.steel_to_titanium(data.raw.recipe["5d-stone-wall-09"].normal)
    util.steel_to_titanium(data.raw.recipe["5d-stone-wall-09"].expensive)
  end


end
