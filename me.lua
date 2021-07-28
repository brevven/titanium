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

function me.add_titanium_ingredient(amount, name) 
  add_ingredient(name, me.titanium_plate, amount)
end

function me.rare_to_titanium(name) 
  replace_ingredient(name, "rare-metals", me.titanium_plate)
end

function me.add_titanium_prerequisite(name)
  add_prerequisite(name, me.titanium_processing)
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


--
-- TODO These helpers are all duplicates, remove them
--
function replace_ingredient(recipe_name, old, new)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[new] then
    xreplace_ingredient(data.raw.recipe[recipe_name], old, new)
    xreplace_ingredient(data.raw.recipe[recipe_name].normal, old, new)
    xreplace_ingredient(data.raw.recipe[recipe_name].expensive, old, new)
  end
end

function xreplace_ingredient(recipe, old, new)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == new or existing.name == new then
        log("Not adding "..new.." -- duplicate")
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then ingredient.name = new end
			if ingredient[1] == old then ingredient[1] = new end
		end
	end
end

function add_prerequisite(technology_name, prerequisite)
  technology = data.raw.technology[technology_name]
  if technology and data.raw.technology[prerequisite] then
    if technology.prerequisites then
      table.insert(technology.prerequisites, prerequisite)
    else
      technology.prerequisites = {prerequisite}
    end
  end
end

function add_ingredient(recipe_name, ingredient, quantity)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient] then
    xadd_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
    xadd_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity)
    xadd_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity)
  end
end

function xadd_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == ingredient or existing.name == ingredient then
        log("Not adding "..ingredient.." -- duplicate")
        return
      end
    end
    table.insert(recipe.ingredients, {ingredient, quantity})
  end
end
--
-- End duplicates
--

return me
