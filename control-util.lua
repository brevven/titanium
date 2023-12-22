local me = require("me")

local util = {}
util.me = me

function decode(data)
    if type(data) == "string" then return data end
    local str = {}
    for i = 2, #data do
        str[i-1] = decode(data[i])
    end
    return table.concat(str, "")
end

function util.get_list()
    local p = game.item_prototypes[me.name.."-list"]
    if p then
      data = p.localised_description
      return decode(data)
    end
end

function util.force_enable_recipe(event, recipe_name)
  if game.players[event.player_index].force.recipes[recipe_name] then
    game.players[event.player_index].force.recipes[recipe_name].enabled=true      
  end
end

return util
