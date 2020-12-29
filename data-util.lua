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


-- Remove an element of type t and name from data.raw
function data_util.remove_raw(t, name)
  for i, elem in pairs(data.raw[t]) do
    if elem.name == name then 
      data.raw[t][i] = nil
      break
    end
  end
end

function data_util.check_for_ingredient(recipe, name)
    if recipe ~= nil and recipe.ingredients ~= nil then
    log(serpent.dump(recipe))
      for i, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == name then
          return true
        end
      end
    end
    return false
end

--- Add a given quantity of titanium plates to a given recipe
function data_util.add_titanium_ingredient(quantity, recipe)
  if recipe ~= nil and recipe.ingredients ~= nil then
    if data_util.check_for_ingredient(recipe, data_util.titanium_plate) then
      return
    end
    table.insert(recipe.ingredients, {data_util.titanium_plate, quantity})
  end
end

--- Add titanium processing as a prerequisite to a given technology
function data_util.add_titanium_prerequisite(technology)
  if mods["pyrawores"] then
    return
  end
	table.insert(technology.prerequisites, data_util.titanium_processing)
end

--- Change all occurances of steel plates to titanium plates in a given recipe
function data_util.steel_to_titanium(recipe)
	data_util.replace_ingredient(recipe, "steel-plate", data_util.titanium_plate)
end

--- Change all occurances of rare metals to titanium plates in a given recipe
function data_util.rare_to_titanium(recipe)
	data_util.replace_ingredient(recipe, "rare-metals", data_util.titanium_plate)
end

function data_util.replace_ingredient(recipe, old, new)
	if recipe ~= nil and recipe.ingredients ~= nil then
    if data_util.check_for_ingredient(recipe, new) then
      return
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			-- For final fixes
			if ingredient.name == old then ingredient.name = new end
			-- For updates
			if ingredient[1] == old then ingredient[1] = new end
		end
	end
end

return data_util
