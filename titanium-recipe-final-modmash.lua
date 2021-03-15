local util = require("__bztitanium__.data-util");

if mods["modmashsplinter"] then
  if mods["modmashsplinterresources"] then
    util.remove_raw("recipe", "titanium-extraction-process")

    data.raw.recipe["alien-enrichment-process-to-titanium-ore"].icons = {
      { icon = "__modmashsplinterresources__/graphics/icons/alien-ooze.png", icon_size = 64},
      { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {8, 8}},
    }

    if mods["modmashsplinterenrichment"] then
      data.raw.recipe["ore-enrichment-process-titanium-ore"].icons = {
        { icon = "__base__/graphics/icons/fluid/steam.png", icon_size = 64},
        { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {8, 8}},
      }
    end
  end

  if mods["modmashsplinterlogistics"] then 
    util.steel_to_titanium("regenerative-transport-belt")
    util.steel_to_titanium("regenerative-splitter")
    util.steel_to_titanium("regenerative-underground-belt-structure")
    util.steel_to_titanium("regenerative-mini-loader")
  end

end
