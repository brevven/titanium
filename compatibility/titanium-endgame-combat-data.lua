-- First part of hack for endgame combat
if mods["EndgameCombat"] and not mods["pyrawores"] and not mods["bobplates"] and not mods["angelssmelting"] then

local dummy_items = {"cobalt-steel", "nickel", "aluminium"}
if not mods.bztungsten then
  table.insert(dummy_items, "tungsten")
end
for i, dummy in pairs(dummy_items) do
  if not data.raw.item[dummy] then
    data:extend({{
      type = "item",
      name = dummy,
      icon = "__bztitanium__/graphics/icons/titanium-plate.png",
      icon_size = 64, icon_mipmaps = 3,
      subgroup = "raw-material",
      order = "zzzz-dummy",
      stack_size = 100,
    }})
  end
end
local dummy_techs = {"cobalt-processing", "nickel-processing", "aluminium-processing", "tungsten-processing"}
for i, dummy in pairs(dummy_techs) do
  if not data.raw.technology[dummy] then
    data:extend({{
    type = "technology",
    name = dummy,
    icon_size = 256, icon_mipmaps = 4,
    icon = "__bztitanium__/graphics/technology/titanium-processing.png",
    effects = nil,
    unit =
    {
      count = 1,
      ingredients = {{"automation-science-pack", 1}},
      time = 1
    },
    order = "zzzz-dummy",
    }})
  end
end

end
