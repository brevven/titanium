local me = {}

me.name = "bztitanium"
me.resources = {{"titanium-ore", "nauvis"}}
me.fluid_mining = true
me.titanium_plate = ""
me.titanium_processing = ""
me.ores_for_workaround = {{name="titanium-ore", amount=100000, tiles=300}}

if mods and mods["FactorioExtended-Plus-Core"] then
  me.titanium_plate = "titanium-alloy"
else
  me.titanium_plate = "titanium-plate"
end

me.recipes = {me.titanium_plate, 
              "enriched-titanium-plate",
              "enriched-titanium",
              "titanium-smelting-vulcanite",
              "molten-titanium",
              "enriched-titanium-smelting-vulcanite"}

if mods and mods["pyrawores"] then 
  me.titanium_processing = "titanium-mk01"
else
  me.titanium_processing = "titanium-processing"
end

function me.get_setting(name)
  if settings.startup[name] == nil then
    return nil
  end
  return settings.startup[name].value
end

function me.fluid_amount()
  local amt = me.get_setting("bztitanium-mining-fluid-amount")
  return amt and amt or 3
end
  
me.bypass = {}
if me.get_setting(me.name.."-recipe-bypass") then 
  for recipe in string.gmatch(me.get_setting(me.name.."-recipe-bypass"), '[^",%s]+') do
    me.bypass[recipe] = true
  end
end

function me.add_modified(name) 
  if me.get_setting(me.name.."-list") then 
    table.insert(me.list, name)
  end
end

return me
