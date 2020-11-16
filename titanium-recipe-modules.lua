

recipes = {"titanium-plate"}
if mods["Krastorio2"] then
  recipes = {"titanium-plate", "enriched-titanium-plate", "enriched-titanium"}
end

for i, recipe in pairs(recipes) do
	for j, module in pairs(data.raw.module) do
    if module.effect then
      for effect_name, effect in pairs(module.effect) do
        if effect_name == "productivity" and effect.bonus > 0 and module.limitation and #module.limitation > 0 then
          table.insert(module.limitation, recipe)
        end
      end
    end
  end
end
