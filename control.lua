local util = require("control-util")

script.on_init(util.check_fluid_mining)

script.on_event(defines.events.on_chunk_generated, util.ore_workaround)
