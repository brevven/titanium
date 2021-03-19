if (not mods["pyrawores"] and not mods["bobplates"] and not mods["angelssmelting"]) then
if omni and omni.matter then
  omni.matter.add_resource("titanium-ore", omni.matter.get_ore_tier("uranium-ore"))
end
end

