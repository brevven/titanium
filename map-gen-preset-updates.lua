local base_ore = "iron-ore"
if mods["angelssmelting"] then
  base_ore = "angels-ore1"
end
if (not mods["pyrawores"] and not mods["bobplates"]) then
if data.raw["map-gen-presets"] and data.raw["map-gen-presets"].default then
  for name, preset in pairs(data.raw["map-gen-presets"].default) do 
    if type(preset) == "table" and 
      preset.basic_settings and 
      preset.basic_settings.autoplace_controls and 
      preset.basic_settings.autoplace_controls[base_ore] then
        preset.basic_settings.autoplace_controls["titanium-ore"] = preset.basic_settings.autoplace_controls[base_ore]
    end
  end
end
end
