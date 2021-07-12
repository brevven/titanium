local util = {}

util.name = "bztitanium"
util.titanium_plate = ""
util.titanium_processing = ""

if mods["FactorioExtended-Plus-Core"] then
  util.titanium_plate = "titanium-alloy"
else
  util.titanium_plate = "titanium-plate"
end

if mods["pyrawores"] then 
  util.titanium_processing = "titanium-mk01"
else
  util.titanium_processing = "titanium-processing"
end

function util.steel_to_titanium(name) 
  util.replace_ingredient(name, "steel-plate", util.titanium_plate)
end

function util.add_titanium_ingredient(amount, name) 
  util.add_ingredient(name, util.titanium_plate, amount)
end

function util.rare_to_titanium(name) 
  util.replace_ingredient(name, "rare-metals", util.titanium_plate)
end

function util.add_titanium_prerequisite(name)
  util.add_prerequisite(name, util.titanium_processing)
end

function util.get_setting(name)
  if settings.startup[name] == nil then
    return nil
  end
  return settings.startup[name].value
end

function util.fluid_amount()
  local amt = util.get_setting("bztitanium-mining-fluid-amount")
  return amt and amt or 3
end
  

local bypass = {}
if util.get_setting(util.name.."-recipe-bypass") then 
  for recipe in string.gmatch(util.get_setting(util.name.."-recipe-bypass"), '[^",%s]+') do
    bypass[recipe] = true
  end
end

function util.get_stack_size(default) 
  if mods["Krastorio2"] then
    size = tonumber(krastorio.general.getSafeSettingValue("kr-stack-size"))
    return size or default
  end
  return default
end

-- check if a table contains a sought value
function util.contains(table, sought)
  for i, value in pairs(table) do
    if value == sought then
      return true
    end
  end
  return false
end

-- Add a prerequisite to a given technology
function util.add_prerequisite(technology_name, prerequisite)
  technology = data.raw.technology[technology_name]
  if technology and data.raw.technology[prerequisite] then
    if technology.prerequisites then
      table.insert(technology.prerequisites, prerequisite)
    else
      technology.prerequisites = {prerequisite}
    end
  end
end

-- Remove a prerequisite from a given technology
function util.remove_prerequisite(technology_name, prerequisite)
  technology = data.raw.technology[technology_name]
  local index = -1
  if technology and data.raw.technology[prerequisite] then
    for i, prereq in pairs(technology.prerequisites) do
      if prereq == prerequisite then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(technology.prerequisites, index)
    end
  end
end

-- Add an effect to a given technology
function util.add_effect(technology_name, effect)
  technology = data.raw.technology[technology_name]
  if technology then
    table.insert(technology.effects, effect)
  end
end

-- Set technology ingredients
function util.set_tech_recipe(technology_name, ingredients)
  technology = data.raw.technology[technology_name]
  if technology then
    technology.unit.ingredients = ingredients
  end
end

-- Add a given quantity of ingredient to a given recipe
function util.add_ingredient(recipe_name, ingredient, quantity)
  if bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    add_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
    add_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity)
    add_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity)
  end
end

function add_ingredient(recipe, ingredient, quantity)
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

-- Add a given quantity of product to a given recipe. 
-- Only works for recipes with multiple products
function util.add_product(recipe_name, product)
  if data.raw.recipe[recipe_name] then
    add_product(data.raw.recipe[recipe_name], product)
    add_product(data.raw.recipe[recipe_name].normal, product)
    add_product(data.raw.recipe[recipe_name].expensive, product)
  end
end

function add_product(recipe, product)
  if recipe ~= nil and recipe.results ~= nil then
    table.insert(recipe.results, product)
  end
end

-- Replace one ingredient with another in a recipe
function util.replace_ingredient(recipe_name, old, new)
  if bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    replace_ingredient(data.raw.recipe[recipe_name], old, new)
    replace_ingredient(data.raw.recipe[recipe_name].normal, old, new)
    replace_ingredient(data.raw.recipe[recipe_name].expensive, old, new)
  end
end

function replace_ingredient(recipe, old, new)
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

-- Remove an ingredient from a recipe
function util.remove_ingredient(recipe_name, old)
  if bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    remove_ingredient(data.raw.recipe[recipe_name], old)
    remove_ingredient(data.raw.recipe[recipe_name].normal, old)
    remove_ingredient(data.raw.recipe[recipe_name].expensive, old)
  end
end

function remove_ingredient(recipe, old)
  index = -1
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do 
      if ingredient.name == old or ingredient[1] == old then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(recipe.ingredients, index)
    end
  end
end


-- Replace an amount of an ingredient in a recipe. Keep at least 1 of old.
function util.replace_some_ingredient(recipe_name, old, old_amount, new, new_amount)
  if bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    replace_some_ingredient(data.raw.recipe[recipe_name], old, old_amount, new, new_amount)
    replace_some_ingredient(data.raw.recipe[recipe_name].normal, old, old_amount, new, new_amount)
    replace_some_ingredient(data.raw.recipe[recipe_name].expensive, old, old_amount, new, new_amount)
  end
end

function replace_some_ingredient(recipe, old, old_amount, new, new_amount)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == new or existing.name == new then
        log("Not adding "..new.." -- duplicate")
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			-- For final fixes
			if ingredient.name == old then
        ingredient.amount = math.max(1, ingredient.amount - old_amount)
      end
			-- For updates
			if ingredient[1] == old then
        ingredient[2] = math.max(1, ingredient[2] - old_amount)
      end
		end
    add_ingredient(recipe, new, new_amount)
	end
end

-- multiply the cost, energy, and results of a recipe by a multiple
function util.multiply_recipe(recipe_name, multiple)
  if bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    multiply_recipe(data.raw.recipe[recipe_name], multiple)
    multiply_recipe(data.raw.recipe[recipe_name].normal, multiple)
    multiply_recipe(data.raw.recipe[recipe_name].expensive, multiple)
	end
end

function multiply_recipe(recipe, multiple)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * multiple
    end
    if recipe.result_count then
      recipe.result_count = recipe.result_count * multiple
    end
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name then
          if result.amount then
            result.amount = result.amount * multiple
          end
          if result.amount_min ~= nil then
            result.amount_min = result.amount_min * multiple
            result.amount_max = result.amount_max * multiple
          end
          if result.catalyst_amount then
            result.catalyst_amount = result.catalyst_amount * multiple
          end
        end
        if result[1] then
          result[2] = result[2] * multiple
        end
      end
    end
    if not recipe.results and not recipe.result_count then
      -- implicit one item result
      recipe.result_count = multiple
    end
    if recipe.ingredients then
      for i, ingredient in pairs(recipe.ingredients) do
        if ingredient.name then
          ingredient.amount = ingredient.amount * multiple
        end
        if ingredient[1] then
          ingredient[2] = ingredient[2] * multiple
        end
      end
    end
  end
end

-- Remove an element of type t and name from data.raw
function util.remove_raw(t, name)
  for i, elem in pairs(data.raw[t]) do
    if elem.name == name then 
      data.raw[t][i] = nil
      break
    end
  end
end

return util
