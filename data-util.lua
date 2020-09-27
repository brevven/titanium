local data_util = {}

data_util.titanium_plate = ""

if mods["FactorioExtended-Plus-Core"] then
  data_util.titanium_plate = "titanium-alloy"
else
  data_util.titanium_plate = "titanium-plate"
end

-- Remove an element of type t and name from data.raw
function data_util.remove_raw(t, name)
  local index = -1
  for i, elem in pairs(data.raw) do
    if elem.type == t and elem.name == name then
      index = i
      break
    end
  end
  if index > -1 then
    table.remove(data.raw, index)
  end
end


--- Add a given quantity of titanium plates to a given recipe
function data_util.add_titanium_ingredient(quantity, recipe)
  if recipe ~= nil and recipe.ingredients ~= nil then
    table.insert(recipe.ingredients, {data_util.titanium_plate, quantity})
  end
end

--- Add titanium processing as a prerequisite to a given technology
function data_util.add_titanium_prerequisite(technology)
	table.insert(technology.prerequisites, "titanium-processing")
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
		for i, ingredient in pairs(recipe.ingredients) do 
			-- For final fixes
			if ingredient.name == old then ingredient.name = new end
			-- For updates
			if ingredient[1] == old then ingredient[1] = new end
		end
	end
end

return data_util
