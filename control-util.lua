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

return util
