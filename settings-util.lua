-- WARNING WARNING WARNING
-- This file will be overwritten in mod zipfiles, edit bzlib/settings-util.lua
-- WARNING WARNING WARNING

local util = {}

function util.set_default_value(t, name, default)
  if data.raw[t] and data.raw[t][name] then
    data.raw[t][name].default_value = default
  end
end

return util
