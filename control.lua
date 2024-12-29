local util = require("control-util")

script.on_init(util.check_fluid_mining)
script.on_configuration_changed(util.ore_fix)
util.add_regenerate_command_handler()
