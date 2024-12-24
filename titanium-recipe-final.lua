local util = require("__bztitanium__.data-util")


-- Set correct number of outputs for recyclers
for i, entity in pairs(data.raw.furnace) do
  if util.contains(entity.crafting_categories, "recycling-or-hand-crafting") then
    if entity.result_inventory_size < #data.raw.recipe["scrap-recycling"].results then
      entity.result_inventory_size = #data.raw.recipe["scrap-recycling"].results
    end
  end
end


