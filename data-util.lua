local data_util = {}

data_util.titanium_plate = ""
data_util.titanium_processing = ""

if mods["FactorioExtended-Plus-Core"] then
  data_util.titanium_plate = "titanium-alloy"
else
  data_util.titanium_plate = "titanium-plate"
end

if mods["pyrawores"] then 
  data_util.titanium_processing = "titanium-mk01"
else
  data_util.titanium_processing = "titanium-processing"
end


function data_util.get_stack_size(default) 
  if mods["Krastorio2"] then
    size = tonumber(krastorio.general.getSafeSettingValue("kr-stack-size"))
    return size or default
  end
  return default
end

function data_util.steel_to_titanium(name) 
  data_util.replace_ingredient(name, "steel-plate", "titanium-plate")
end

function data_util.add_titanium_ingredient(amount, name) 
  data_util.add_ingredient(name, "titanium-plate", amount)
end

function data_util.rare_to_titanium(name) 
  data_util.replace_ingredient(name, "rare-metals", "titanium-plate")
end

function data_util.add_titanium_prerequisite(name)
  data_util.add_prerequisite(name, data_util.titanium_processing)
end


-- Remove an element of type t and name from data.raw
function data_util.remove_raw(t, name)
  for i, elem in pairs(data.raw[t]) do
    if elem.name == name then 
      data.raw[t][i] = nil
      break
    end
  end
end

-- Add a prerequisite to a given technology
function data_util.add_prerequisite(technology_name, prerequisite)
  technology = data.raw.technology[technology_name]
  if technology then
    table.insert(technology.prerequisites, prerequisite)
  end
end

--- removes a prerequisite tech
function data_util.remove_prerequisite(tech, prereq)
  if data.raw.technology[tech] then
    for i, prerequisite in pairs(data.raw.technology[tech].prerequisites) do
      if data.raw.technology[tech].prerequisites[i] == prereq then
        table.remove(data.raw.technology[tech].prerequisites, i)
        break
      end
    end
  end
end

-- Add a given quantity of ingredient to a given recipe
function data_util.add_ingredient(recipe_name, ingredient, quantity)
  if data.raw.recipe[recipe_name] then
    add_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
    add_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity)
    add_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity)
  end
end

function add_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for _, existing in ipairs(recipe.ingredients) do 
      if ingredient == existing.name or ingredient == existing[1] then
        return
      end
    end
    table.insert(recipe.ingredients, {ingredient, quantity})
  end
end

-- Replace one ingredien with another in a recipe
function data_util.replace_ingredient(recipe_name, old, new)
  if data.raw.recipe[recipe_name] then
   replace_ingredient(data.raw.recipe[recipe_name], old, new)
   replace_ingredient(data.raw.recipe[recipe_name].normal, old, new)
   replace_ingredient(data.raw.recipe[recipe_name].expensive, old, new)
  end
end

function replace_ingredient(recipe, old, new)
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do 
			-- For final fixes
			if ingredient.name == old then ingredient.name = new end
			-- For updates
			if ingredient[1] == old then ingredient[1] = new end
		end
	end
end

-- Remove an ingredient from a recipe
function data_util.remove_ingredient(recipe_name, old)
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
function data_util.replace_some_ingredient(recipe_name, old, old_amount, new, new_amount)
  replace_some_ingredient(data.raw.recipe[recipe_name], old, old_amount, new, new_amount)
  replace_some_ingredient(data.raw.recipe[recipe_name].normal, old, old_amount, new, new_amount)
  replace_some_ingredient(data.raw.recipe[recipe_name].expensive, old, old_amount, new, new_amount)
end

function replace_some_ingredient(recipe, old, old_amount, new, new_amount)
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then
        ingredient.amount = math.max(1, ingredient.amount - old_amount)
      end
			if ingredient[1] == old then
        ingredient[2] = math.max(1, ingredient[2] - old_amount)
      end
		end
    add_ingredient(recipe, new, new_amount)
	end
end

-- Add an effect to a given technology
function data_util.add_effect(technology_name, effect)
  technology = data.raw.technology[technology_name]
  if technology then
    table.insert(technology.effects, effect)
  end
end

-- check if a table contains a sought value
function data_util.contains(table, sought)
  for i, value in pairs(table) do
    if value == sought then
      return true
    end
  end
  return false
end


-- multiply the cost, energy, and results of a recipe by a multiple
function data_util.multiply_recipe(recipe_name, multiple)
  multiply_recipe(data.raw.recipe[recipe_name], multiple)
  multiply_recipe(data.raw.recipe[recipe_name].normal, multiple)
  multiply_recipe(data.raw.recipe[recipe_name].expensive, multiple)
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

return data_util
