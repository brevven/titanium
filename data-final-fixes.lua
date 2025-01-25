-- Space Exploration compatibility and flavor tweaks
require("titanium-recipe-final-se")

-- Krastorio 2 final fixes
require("titanium-recipe-final-k2")

-- Rich Rocks Requiem for Krastorio 2 final fixes
require("titanium-recipe-final-rrr")

-- Deadlock's stacking and crating
require("titanium-recipe-final-stacking")

-- 5Dim's final fixes
require("titanium-recipe-final-5d")

-- Modmash final fixes
require("titanium-recipe-final-modmash")

require("compatibility/248k-final")

-- Second part of hack for endgame combat
require("compatibility/titanium-endgame-combat-final")

-- Hack for AutoTrainDepot
require("compatibility/titanium-auto-train-depot-final")


local util = require("__bztitanium__.data-util");

util.redo_recycling()
util.size_recycler_output()
util.use_fluid_mining_final()
