local me = {}

me.name = "bztitanium"
me.titanium_plate = ""
me.titanium_processing = ""

if mods["FactorioExtended-Plus-Core"] then
  me.titanium_plate = "titanium-alloy"
else
  me.titanium_plate = "titanium-plate"
end

if mods["pyrawores"] then 
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

return me
