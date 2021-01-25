if mods["Rich-Rocks-Requiem"] then

  if data.raw.recipe["rrr-stone-processing"] then
    table.insert(data.raw.recipe["rrr-stone-processing"].results,
      {name = "titanium-ore", probability = 0.05, amount = 1}
    )
  end

  if data.raw.recipe["rrr-raw-ores-processing"] then
    table.insert(data.raw.recipe["rrr-raw-ores-processing"].results,
      {name = "titanium-ore", probability = 0.50, amount = 5}
    )
  end

end
