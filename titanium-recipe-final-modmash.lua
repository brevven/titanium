if mods["modmashsplinter"] then
  if mods["modmashsplinterresources"] then
    util.remove_raw("recipe", "titanium-extraction-process")

    data.raw.recipe["alien-enrichment-process-to-titanium-ore"].icons = {
      { icon = "__modmashsplinterresources__/graphics/icons/alien-ooze.png", icon_size = 64},
      { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 32, scale=0.5, shift= {8, 8}},
    }

    if mods["modmashsplinterenrichment"] then
      data.raw.recipe["ore-enrichment-process-titanium-ore"].icons = {
        { icon = "__base__/graphics/icons/fluid/steam.png", icon_size = 64},
        { icon = "__bztitanium__/graphics/icons/titanium-ore.png", icon_size = 32, scale=0.5, shift= {8, 8}},
      }
    end
  end

  if mods["modmashsplinterlogistics"] then 
    util.steel_to_titanium(data.raw.recipe["regenerative-transport-belt"])
    util.steel_to_titanium(data.raw.recipe["regenerative-transport-belt"].normal)
    util.steel_to_titanium(data.raw.recipe["regenerative-transport-belt"].expensive)
    util.steel_to_titanium(data.raw.recipe["regenerative-splitter"])
    util.steel_to_titanium(data.raw.recipe["regenerative-splitter"].normal)
    util.steel_to_titanium(data.raw.recipe["regenerative-splitter"].expensive)
    util.steel_to_titanium(data.raw.recipe["regenerative-underground-belt-structure"])
    util.steel_to_titanium(data.raw.recipe["regenerative-underground-belt-structure"].normal)
    util.steel_to_titanium(data.raw.recipe["regenerative-underground-belt-structure"].expensive)
    util.steel_to_titanium(data.raw.recipe["regenerative-mini-loader"])
    util.steel_to_titanium(data.raw.recipe["regenerative-mini-loader"].normal)
    util.steel_to_titanium(data.raw.recipe["regenerative-mini-loader"].expensive)
  end

end
