local util = require("__bztitanium__.data-util");

if mods["5dim_core"] then

  data.raw.item[util.me.titanium_plate].subgroup = "plates-plates"
  data.raw.recipe[util.me.titanium_plate].subgroup = "plates-plates"
  data.raw.item["titanium-ore"].subgroup = "plates-ore"

  if mods["5dim_resources"] then

    -- Industrial furnace
    data:extend({
      {
        type = "recipe",
        name = "titanium-plate-industrial-ore",
        category = "industrial-furnace",
        subgroup = "plates-industrial-ore",
        order = "ad[titanium-plate]",
        icon = "__bztitanium__/graphics/icons/titanium-plate.png",
        icon_size = 64, icon_mipmaps = 3,
        enabled = false,
        energy_required = 140,
        ingredients = {{"titanium-ore", 425}},
        result = util.me.titanium_plate,
        result_count = 100,
      }
    })
    table.insert(data.raw.technology[util.me.titanium_processing].effects, 
        {type = "unlock-recipe", recipe="titanium-plate-industrial-ore"})


    -- Titanium dust
    data:extend(
      {
          {
              type = "item",
              name = "titanium-dust",
              subgroup = "plates-dust",
              order = "d[titanium-plate]",
              icon = "__bztitanium__/graphics/icons/titanium-powder.png",
              icon_size = 64, icon_mipmaps = 3,
              stack_size = 200
          },
          {
              type = "recipe",
              name = "titanium-plate-dust",
              icon = "__bztitanium__/graphics/icons/titanium-plate.png",
              icon_size = 64, icon_mipmaps = 3,
              subgroup = "plates-plates2",
              order = "d[titanium-plate]",
              category = "smelting",
              energy_required = 8,
              enabled = false,
              ingredients = {
                  {"titanium-dust", 5}
              },
              result = util.me.titanium_plate
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
            icon_size = 64, icon_mipmaps = 3,
            enabled = false,
            energy_required = 140,
            ingredients = {{"titanium-dust", 425}},
            result = util.me.titanium_plate,
            result_count = 100,
          }
    })
    table.insert(data.raw.technology[util.me.titanium_processing].effects, 
        {type = "unlock-recipe", recipe="titanium-dust"})
    table.insert(data.raw.technology[util.me.titanium_processing].effects, 
        {type = "unlock-recipe", recipe="titanium-plate-dust"})
    table.insert(data.raw.technology[util.me.titanium_processing].effects, 
        {type = "unlock-recipe", recipe="titanium-plate-industrial-dust"})
  end

  if mods["5dim_automation"] then 
    for i, name in ipairs(
        {"5d-assembling-machine-07","5d-assembling-machine-08","5d-lab-06","5d-lab-07"}) do
      util.replace_ingredient(name, "steel-plate", util.me.titanium_plate)
    end

  end

  if mods["5dim_nuclear"] then
  for i, name in ipairs(
      {
      "5d-steam-turbine-02",
      "5d-steam-turbine-03",
      "5d-steam-turbine-04",
      "5d-steam-turbine-05",
      "5d-steam-turbine-06",
      "5d-steam-turbine-07",
      "5d-steam-turbine-08",
      "5d-steam-turbine-09",
      "5d-steam-turbine-10"
      }) do
      util.add_ingredient(name, util.me.titanium_plate, 20)
    end
  end

  if mods["5dim_battlefield"] then
      util.replace_ingredient(name, "steel-plate", util.me.titanium_plate)
  end

end
