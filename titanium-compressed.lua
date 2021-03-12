if simpleCompress then
  if simpleCompress.ores then
    simpleCompress.currentSubgroup = "intermediate-product"
    if data.raw.item["titanium-ore"] then
      SimpleCompress_AddTintedItem("titanium-ore", "ore4-titanium", "ore", {r=0.85, g=0.85, b=0.70})
      SimpleCompress_UnlockOreTechAndRecipe("titanium-ore")
    end
  end
  if simpleCompress.plates then
    simpleCompress.currentSubgroup = "intermediate-product"
    if data.raw.item["titanium-plate"] then
      SimpleCompress_AddTintedItem("titanium-plate", "plates4-titanium", "plate3", {r=0.85, g=0.85, b=0.70})
      SimpleCompress_UnlockPlateTechAndRecipe("titanium-plate")
    end
    local titaniumRecipe = data.raw.recipe["decompress-titanium-plate"]
    titaniumRecipe.order = "d[titanium-plate]"
  end
  if simpleCompress.smelting then
    if data.raw.item["titanium-plate"] and data.raw.item["titanium-plate"] then
      SimpleCompress_AddSmeltingRecipe("titanium-ore", "titanium-plate")
      SimpleCompress_UnlockOreSmeltingTech("titanium-ore")
      local titaniumRecipe = data.raw.recipe["smelt-compressed-titanium-ore"]
      titaniumRecipe.ingredients = {{"compressed-titanium-ore", 5}}
      titaniumRecipe.order = "d[titanium-plate]"
    end
  end
end


