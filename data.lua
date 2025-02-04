require("titanium-ore")
require("titanium-ore-particle")
require("titanium-recipe")
require("titanium-enriched")   -- Enriched Ti for Krastorio 2
require("titanium-recipe-se")  -- Space Exploration special recipes (depends on K2 if present)
require("titanium-compressed")
require("titanium-data-settings")
require("compatibility.data.hot-metals")

-- First part of hack for endgame combat
require("compatibility/titanium-endgame-combat-data")

local util = require("data-util")
util.prepare_recycling_helper()
