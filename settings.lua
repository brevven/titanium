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
    allowed_values = (mods["Krastorio2"] and {"lubricant", "sulfuric-acid", "chlorine"} or {"lubricant", "sulfuric-acid"}),
	},
  {
		type = "int-setting",
		name = "bztitanium-mining-fluid-amount",
		setting_type = "startup",
		default_value = 3,
    minimum_value = 1,
    maximum_value = 1000,
	},
})
