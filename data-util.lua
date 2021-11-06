-- WARNING WARNING WARNING
-- This file will be overwritten in mod zipfiles, edit bzlib/data-util.lua
-- WARNING WARNING WARNING

local me = require("me")
local util = {}

util.me = me
util.get_setting = util.me.get_setting

function util.fe_plus(sub)
  if mods["FactorioExtended-Plus-"..sub] then
    return true
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
  local technology = data.raw.technology[technology_name]
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
  local technology = data.raw.technology[technology_name]
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
  local technology = data.raw.technology[technology_name]
  if technology then
    table.insert(technology.effects, effect)
  end
end

-- Set technology ingredients
function util.set_tech_recipe(technology_name, ingredients)
  local technology = data.raw.technology[technology_name]
  if technology then
    technology.unit.ingredients = ingredients
  end
end

-- Add a given quantity of ingredient to a given recipe
function util.add_ingredient(recipe_name, ingredient, quantity)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient] then
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
  if data.raw.recipe[recipe_name] and data.raw.item[product] then
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
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[new] then
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
  if me.bypass[recipe_name] then return end
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
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[new] then
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

-- multiply the cost, energy, and results of a recipe by a multiple
function util.multiply_recipe(recipe_name, multiple)
  if me.bypass[recipe_name] then return end
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

-- Returns true if a recipe has an ingredient
function util.has_ingredient(recipe_name, ingredient)
  return data.raw.recipe[recipe_name] and (
        has_ingredient(data.raw.recipe[recipe_name], ingredient) or
        has_ingredient(data.raw.recipe[recipe_name].normal, ingredient))
end

function has_ingredient(recipe, ingredient)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == ingredient or existing.name == ingredient then
        return true
      end
    end
  end
  return false
end

-- Replace one product with another in a recipe
function util.replace_product(recipe_name, old, new)
  if data.raw.recipe[recipe_name] then
    replace_product(data.raw.recipe[recipe_name], old, new)
    replace_product(data.raw.recipe[recipe_name].normal, old, new)
    replace_product(data.raw.recipe[recipe_name].expensive, old, new)
  end
end

function replace_product(recipe, old, new)
  if recipe ~= nil and recipe.results ~= nil then
    if recipe.result == old then
      recipe.results = new
      return
    end
    for i, result in pairs(recipe.results) do
			if result.name == old then result.name = new end
			if result[1] == old then result[1] = new end
    end
  end
end

-- Remove an element of type t and name from data.raw
function util.remove_raw(t, name)
  if data.raw[t][name] then
    for i, elem in pairs(data.raw[t]) do
      if elem.name == name then 
        data.raw[t][i] = nil
        break
      end
    end
  end
end

-- Multiply energy required
function util.multiply_time(recipe, factor)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    multiply_time(data.raw.recipe[recipe_name], factor)
    multiply_time(data.raw.recipe[recipe_name].normal, factor)
    multiply_time(data.raw.recipe[recipe_name].expensive, factor)
	end
end

function multiply_time(recipe, factor)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * factor
    end
  end
end

-- Set recipe category
function util.set_category(recipe, category)
   if me.bypass[recipe_name] then return end
   if data.raw.recipe[recipe] then
      data.raw.recipe[recipe].category = category
   end
end

-- Set recipe subgroup
function util.set_subgroup(recipe, subgroup)
   if me.bypass[recipe_name] then return end
   if data.raw.recipe[recipe] then
      data.raw.recipe[recipe].subgroup = subgroup
   end
end

function util.set_to_founding(recipe)
  util.set_category(recipe, "founding")
  util.set_subgroup(recipe, "foundry-intermediate")
end

-- Add crafting category to an entity
function util.add_crafting_category(entity_type, entity, category)
   if data.raw[entity_type][entity] then
      for i, existing in pairs(data.raw[entity_type][entity].crafting_categories) do
        if existing == category then
          log(entity.." not adding "..new.." -- duplicate")
          return
        end
      end
      table.insert(data.raw[entity_type][entity].crafting_categories, category)
   end
end

function util.add_to_ingredient(recipe, ingredient, amount)
  if data.raw.recipe[recipe] then
    add_to_ingredient(data.raw.recipe[recipe], ingredient, amount)
    add_to_ingredient(data.raw.recipe[recipe].normal, ingredient, amount)
    add_to_ingredient(data.raw.recipe[recipe].expensive, ingredient, amount)
  end
end

function add_to_ingredient(recipe, it, amount)
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do
			if ingredient.name == it then
        ingredient.amount = ingredient.amount + amount
        return
      end
			if ingredient[1] == it then
        ingredient[2] = ingredients[2] + amount
        return
      end
		end
	end
end

function util.add_to_product(recipe, product, amount)
  if data.raw.recipe[recipe] then
    add_to_product(data.raw.recipe[recipe], product, amount)
    add_to_product(data.raw.recipe[recipe].normal, product, amount)
    add_to_product(data.raw.recipe[recipe].expensive, product, amount)
  end
end

function add_to_product(recipe, product, amount)
  if recipe ~= nil and recipe.results ~= nil then
    if recipe.result == product then
      recipe.result_count = recipe.result_count + amount
      return
    end
    for i, result in pairs(recipe.results) do
			if result.name == product then
        result.amount = result.amount + amount
        return
      end
			if result[1] == product then
        result[2] = result[2] + amount
        return
      end
    end
  end
end

return util
