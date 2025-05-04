data:extend({
  {
		type = "string-setting",
		name = "bztitanium-recipe-bypass",
		setting_type = "startup",
		default_value = "",
    allow_blank = true,
	},
  {
		type = "string-setting",
		name = "bztitanium-mining-fluid",
		setting_type = "startup",
		default_value = "lubricant",
    allowed_values = ((mods.Krastorio or mods["Krastorio-spaced-out"]) and {"lubricant", "sulfuric-acid", "kr-chlorine"} or {"lubricant", "sulfuric-acid"}),
	},
  {
		type = "int-setting",
		name = "bztitanium-mining-fluid-amount",
		setting_type = "startup",
		default_value = 3,
    minimum_value = 1,
    maximum_value = 1000,
	},
  {
    type = "double-setting",
    name = "bztitanium-ore-workaround-probability",
    hidden = true, -- deprecated
    setting_type = "runtime-global",
    default_value = .01,
    minimum_value = .00001,
    maximum_value = .1,
	},
})
