-- WARNING WARNING WARNING
-- This file will be overwritten in mod zipfiles, edit bzlib/data-util.lua
-- WARNING WARNING WARNING

local futil = require("util")
local me = require("me")
local util = {}

util.me = me
util.get_setting = util.me.get_setting

util.titanium_plate = ""
util.titanium_processing = ""

local item_sounds_helper = [[
local item_sounds = require('__base__.prototypes.item_sounds')

    inventory_move_sound = item_sounds.wire_inventory_move,
    pick_sound = item_sounds.wire_inventory_pickup,
    drop_sound = item_sounds.wire_inventory_move,

    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,

    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,

    inventory_move_sound = item_sounds.brick_inventory_move,
    pick_sound = item_sounds.brick_inventory_pickup,
    drop_sound = item_sounds.brick_inventory_move,

    inventory_move_sound = item_sounds.sulfur_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.sulfur_inventory_move,
]]

util.A = {{"automation-science-pack", 1}}
util.AL = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}}
util.ALC = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}}

if mods["FactorioExtended-Plus-Core"] then
  util.titanium_plate = "titanium-alloy"
else
  util.titanium_plate = "titanium-plate"
end

if mods["pyrawores"] then 
  util.titanium_processing = "titanium-mk01"
else
  util.titanium_processing = "titanium-processing"
end

util.vacuum_icon = { icon="__base__/graphics/icons/fluid/steam.png", tint={r=.1, g=.1, b=.5, a=.5} }
util.vacuum_icon_small = { icon="__base__/graphics/icons/fluid/steam.png", tint={r=.1, g=.1, b=.5, a=.5}, scale=0.25, shift={-8,-8}, }
util.vacuum_vis = {r=.1, g=.1, b=.5}

function util.item(item, quantity, probability)
  if not quantity then
    quantity = 1
  end
  if probability then
    return {type="item", name=item, amount=quantity, probability=probability}
  else
    return {type="item", name=item, amount=quantity}
  end
end

function util.fluid(fluid, quantity)
  if not quantity then
    quantity = 10
  end
  return {type="fluid", name=fluid, amount=quantity}
end

function util.se6()
  return mods["space-exploration"] and mods["space-exploration"] >= "0.6" 
end

function util.k2()
  return mods.Krastorio2 or mods["Krastorio2-spaced-out"]
end

util.cablesg = util.se6() and "electronic" or "cable"

function get_setting(name)
  if settings.startup[name] == nil then
    return nil
  end
  return settings.startup[name].value
end

allbypass = {}
if get_setting("bz-recipe-bypass") then 
  for recipe in string.gmatch(me.get_setting("bz-recipe-bypass"), '[^",%s]+') do
    allbypass[recipe] = true
  end
end

function util.is_foundry()
  return mods.bzfoundry and not me.get_setting("bzfoundry-minimal")
end

function should_force(options)
  return options and options.force
end


function bypass(recipe_name) 
  if me.bypass[recipe_name] then return true end
  if allbypass[recipe_name] then return true end
  if get_setting("bz-tabula-rasa") then return true end
end

function util.fe_plus(sub)
  if mods["FactorioExtended-Plus-"..sub] then
    return true
  end
end

function util.get_stack_size(default)
  if util.k2() and kr_adjust_stack_sizes then
    return tonumber(200)
  end
  return default
end

function util.k2assets() 
  if mods["Krastorio2Assets"] then
    return "__Krastorio2Assets__"
  end
  return "__Krastorio2__/graphics"
end

-- check if a table contains a sought value
function util.contains(table, sought)
  for i, value in pairs(table) do
    if value == sought then
      return true
    end
  end
  return false
end

-- copies a recipe, giving the copy a new name
function util.copy_recipe(recipe_name, new_recipe_name)
  if data.raw.recipe[recipe_name] then
    new_recipe = futil.table.deepcopy(data.raw.recipe[recipe_name])
    new_recipe.name = new_recipe_name
    data:extend({new_recipe})
  end
end

function util.add_shiftite_recipe(item, shiftites, quantity)
  if not mods["janus"] then return end
  if not data.raw.item[item] then return end
  local its = {}
  for _, shiftite in pairs(shiftites) do
    local it = "janus-shiftite-"..shiftite
    if data.raw.item[it] then
      table.insert(its, util.item(it, quantity))
    end
  end
  if its then
    local name = "shiftite-to-"..item
    data:extend({{
      type = "recipe",
      name = name,
      localised_name = {"", {"item-name."..item}, " ← Shiftite"},
      category = "janus-shiftite",
      subgroup = "janus-basic-from-shiftite",
      ingredients = its,
      results = {util.item(item, 5)},
      energy_required = 2.5,
      order = "zzz",
      enabled = false,
      auto_recycle = false,
    }})
    util.add_unlock("janus-time-distorter", name)
  end
end

-- Add the gleba rock. If it exists, still add resource to mine from it
local gleba_tint = {.6, .8, 1}
function util.add_gleba_rock(resource, amount_min, amount_max)
  if (not data.raw.planet.gleba or
      not data.raw.planet.gleba.map_gen_settings or -- attempted compatibility fixes
      not data.raw.planet.gleba.map_gen_settings.autoplace_settings or
      not data.raw.planet.gleba.map_gen_settings.autoplace_settings.entity or
      not data.raw.planet.gleba.map_gen_settings.autoplace_settings.entity.settings
  ) then return end
  if not data.raw["simple-entity"]["gleba-rock"] then
    local autoplace_utils = require("autoplace_utils")
    local hit_effects = require ("__base__.prototypes.entity.hit-effects")
    local sounds = require ("__base__.prototypes.entity.sounds")
    local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")
    data.raw.planet.gleba.map_gen_settings.autoplace_settings.entity.settings["gleba-rock"] = {}
    data:extend({
    {
      type = "simple-entity",
      name = "gleba-rock",
      localised_name = {"entity-name.big-rock"},
      flags = {"placeable-neutral", "placeable-off-grid"},
      icons = {{icon = "__base__/graphics/icons/big-sand-rock.png", tint=gleba_tint}},
      subgroup = "grass",
      order = "b[decorative]-l[rock]-a[big]",
      deconstruction_alternative = "big-rock",
      collision_box = {{-0.75, -0.75}, {0.75, 0.75}},
      selection_box = {{-1.0, -1.0}, {1.0, 0.75}},
      damaged_trigger_effect = hit_effects.rock(),
      render_layer = "object",
      max_health = 500,
      autoplace = {
        control = "gleba_plants",
        order = "z[gleba]-a[rock]-b[big]",
        probability_expression = "max(main_probability, invasion_tall_probability)",
        richness_expression = "random_penalty_at(3, 1)",
        tile_restriction = {
          "highland-yellow-rock", 
          "highland-dark-rock", 
          "highland-dark-rock-2", 
        },
        local_expressions = {
          main_box = "gleba_select(gleba_moisture, 0, 0.25, 0.01, -10, 1) - 1",
          main_probability = "min(0.08, 0.15 * (main_box + gleba_plants_noise_b - 0.45) * control:gleba_plants:size)", -- bigger patches, denser
          invasion_tall_box = "gleba_select(gleba_moisture, 0, 0.35, 0.01, -10, 1) - 1",
          invasion_tall_probability = "min(0.05, 0.15 * (invasion_tall_box + gleba_plants_noise_b - 0.4) * control:gleba_plants:size)", -- smaller patches, sparser
        }
      },

      dying_trigger_effect = decorative_trigger_effects.big_rock(),
      minable =
      {
        mining_particle = "stone-particle",
        mining_time = 2,
        results = {
          {type = "item", name = "stone", amount_min = 5, amount_max = 10},
        }
      },
      resistances =
      {
        {
          type = "fire",
          percent = 100
        }
      },
      map_color = {129, 105, 78},
      count_as_rock_for_filtered_deconstruction = true,
      mined_sound = sounds.deconstruct_bricks(1.0),
      impact_category = "stone",
      pictures =
      {
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-01.png",
          tint = gleba_tint,
          width = 209,
          height = 138,
          shift = {0.304688, -0.4},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-02.png",
          tint = gleba_tint,
          width = 165,
          height = 129,
          shift = {0.0, 0.0390625},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-03.png",
          tint = gleba_tint,
          width = 151,
          height = 139,
          shift = {0.151562, 0.0},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-04.png",
          tint = gleba_tint,
          width = 216,
          height = 110,
          shift = {0.390625, 0.0},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-05.png",
          tint = gleba_tint,
          width = 154,
          height = 147,
          shift = {0.328125, 0.0703125},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-06.png",
          tint = gleba_tint,
          width = 154,
          height = 132,
          shift = {0.16875, -0.1},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-07.png",
          tint = gleba_tint,
          width = 193,
          height = 130,
          shift = {0.3, -0.2},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-08.png",
          tint = gleba_tint,
          width = 136,
          height = 117,
          shift = {0.0, 0.0},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-09.png",
          tint = gleba_tint,
          width = 157,
          height = 115,
          shift = {0.1, 0.0},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-10.png",
          tint = gleba_tint,
          width = 198,
          height = 153,
          shift = {0.325, -0.1},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-11.png",
          tint = gleba_tint,
          width = 190,
          height = 115,
          shift = {0.453125, 0.0},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-12.png",
          tint = gleba_tint,
          width = 229,
          height = 126,
          shift = {0.539062, -0.015625},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-13.png",
          tint = gleba_tint,
          width = 151,
          height = 125,
          shift = {0.0703125, 0.179688},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-14.png",
          tint = gleba_tint,
          width = 137,
          height = 117,
          shift = {0.160938, 0.0},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-15.png",
          tint = gleba_tint,
          width = 201,
          height = 141,
          shift = {0.242188, -0.195312},
          scale = 0.5
        },
        {
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-16.png",
          tint = gleba_tint,
          width = 209,
          height = 154,
          shift = {0.351562, -0.1},
          scale = 0.5
        }
      }
    },
    })
    local probability = data.raw["simple-entity"]["gleba-rock"].autoplace.probability_expression  
    -- A lot more common near starting point when aps gleba
    local factor = (mods["any-planet-start"] and me.get_setting("aps-planet") == "gleba" and 20) or 1
    data.raw["simple-entity"]["gleba-rock"].autoplace.probability_expression = probability..[[*
    if(distance_from_nearest_point{x = x, y = y, points = starting_positions} < 200, ]]..factor..[[,
       if(distance_from_nearest_point{x = x, y = y, points = starting_positions} < 700,
          100/(distance_from_nearest_point{x = x, y = y, points = starting_positions} - 100), 0.17))
    ]]

  end
  if data.raw.item[resource] then
    amount_min = (amount_min or 10) * ((mods["any-planet-start"] and me.get_setting("aps-planet") == "gleba" and 4) or 1)
    amount_max = (amount_max or 20) * ((mods["any-planet-start"] and me.get_setting("aps-planet") == "gleba" and 4) or 1)
    util.add_minable_result(
        "simple-entity", "gleba-rock",
        {type="item", name=resource, amount_min=amount_min, amount_max=amount_max})
  end
end

-- Replace 'uranium-mining' tech with 'fluid-mining', defaulting to same costs
function util.add_fluid_mining()
  if data.raw.technology["fluid-mining"] then return end
  data:extend({
  {
    type = "technology",
    name = "fluid-mining",
    icon = "__"..util.me.name.."__/graphics/technology/fluid-mining.png",
    icon_size = 256,
    effects =
    {
      {
        type = "mining-with-fluid",
        modifier = true
      }
    },
    prerequisites = {"chemical-science-pack", "concrete"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30,
    }
  }
  })
end

-- Final fix to make sure nothing uses "uranium-mining"
function util.use_fluid_mining_final()
  for i, tech in pairs(data.raw.technology) do 
    if tech.prerequisites then
      for j, pre in pairs(tech.prerequisites) do
        if pre == "uranium-mining" then
          util.add_prerequisite(tech.name, "fluid-mining")
          util.remove_prerequisite(tech.name, "uranium-mining")
          break
        end
      end
    end
  end
  util.remove_raw("technology", "uranium-mining")
end


-- Add vacuum if it hasn't been added yet
function util.add_vacuum()
  if not data.raw.fluid.vacuum then
    data:extend({
      {
        type = "fluid",
        name = "vacuum",
        icons = { util.vacuum_icon, },
        visualization_color = util.vacuum_vis,
        subgroup = "fluid",
        order = "d[vacuum]",
        default_temperature = 1500,
        max_temperature = 2000,
        gas_temperature = 0,
        heat_capacity = "0.01kJ",
        base_color = {0.9, 0.9, 0.9},
        flow_color = {0.8, 0.8, 0.9},
        auto_barrel = false,
      },
    })
  end
end

-- If Hot metals mod is enabled, mark these metals as hot
function util.add_hot_metals(metals)
  if HotMetals and HotMetals.items then
    for _, metal in pairs(metals) do
      if data.raw.item[metal] or (metal.name and data.raw.item[metal.name]) then
        table.insert(HotMetals.items, metal)
      end
    end
  end
end


-- se landfill
-- params: ore, icon_size
function util.se_landfill(params)
  if mods["space-exploration"] then
    if not params.icon_size then params.icon_size = 64 end
    local lname="landfill-"..params.ore
    data:extend({
      {
        type = "recipe",
        icons = {
          { icon = "__base__/graphics/icons/landfill.png", icon_size = 64, icon_mipmaps = 3 },
          { icon = "__"..me.name.."__/graphics/icons/"..params.ore..".png", icon_size = params.icon_size, scale = 0.33*64/params.icon_size},
        },
        energy_required = 1,
        enabled=false,
        name = lname,
        category = "hard-recycling",
        order = "z-b-"..params.ore,
        subgroup = "terrain",
        results = {
          {type = "item", name = "landfill", amount = 1},
        },
        ingredients = {
          {type = "item", name = params.ore, amount = 50},
        },
      }
    })
    util.add_unlock("se-recycling-facility", lname)
  end
end


-- k2 matter 
-- params: {k2matter}, k2baseicon , {icon}
function util.k2matter(params)
  local matter
  if mods.Krastorio2 then
    matter = require("__Krastorio2__/prototypes/libraries/matter")
  else
    matter = require("__Krastorio2-spaced-out__/prototypes/libraries/matter")
  end
  if mods["space-exploration"] then 
    params.k2matter.needs_stabilizer = true
  end
  if not data.raw.technology[params.k2matter.unlocked_by] then
    local icon = ""
    if params.k2baseicon then
      icon = util.k2assets().."/technologies/matter-"..params.k2baseicon..".png"
    else
      icon = util.k2assets().."/technologies/backgrounds/matter.png"
    end
    
    data:extend(
        {
          {
            type = "technology",
            name = params.k2matter.unlocked_by,
            icons =
            {
              {
                icon = icon,
                icon_size = 256,
              },
              params.icon,
            },
            prerequisites = {"kr-matter-processing"},
            unit =
            {
              count = 350,
              ingredients = mods["space-exploration"] and 
              {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"se-astronomic-science-pack-4", 1},
                {"se-energy-science-pack-4", 1},
                {"se-material-science-pack-4", 1},
                {"se-deep-space-science-pack-2", 1},
                {"se-kr-matter-science-pack-2", 1},
              } or
              {
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"kr-matter-tech-card", 1}
              },
              time = 45,
            },
            effects = {}
            -- (ignore for now) localised_name = {"technology-name.k2-conversion", {"item-name."..params.k2matter.item_name}},
          },
        })
  end
  if params.k2matter.only_deconversion then
    matter.make_deconversion_recipe(params.k2matter)
  else
    matter.make_recipes(params.k2matter)
  end
end


-- se matter
-- params: ore, energy_required, quant_out, quant_in, icon_size, stream_out
function util.se_matter(params)
  if mods["space-exploration"] > "0.6" then
    if not params.quant_in then params.quant_in = params.quant_out end
    if not params.icon_size then params.icon_size = 64 end
    
    
    
    local fname = "matter-fusion-"..params.ore
    local sedata = util.k2() and "se-kr-matter-synthesis-data" or "se-fusion-test-data"
    local sejunk = util.k2() and "se-broken-data" or "se-junk-data"
    data:extend({
      {
        type = "recipe",
        name = fname,
        localised_name = {"recipe-name.se-matter-fusion-to", {"item-name."..params.ore}},
        category = "space-materialisation",
        subgroup = "materialisation",
        order = "a-b-z",
        icons = {
          {icon = "__space-exploration-graphics__/graphics/blank.png",
           icon_size = 64, scale = 0.5},
          {icon = "__space-exploration-graphics__/graphics/icons/fluid/particle-stream.png",
           icon_size = 64,  scale = 0.33, shift = {8,-8}},
          {icon = "__"..util.me.name.."__/graphics/icons/"..params.ore..".png",
           icon_size = params.icon_size, scale = 0.33 * 64/params.icon_size, shift={-8, 8}},
          {icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png",
           icon_size = 64, scale = 0.5},
        },
        energy_required = params.energy_required,
        enabled = false,
        ingredients = {
          {type="item", name=sedata, amount=1},
          {type="fluid", name="se-particle-stream", amount=50},
          {type="fluid", name="se-space-coolant-supercooled", amount=25},
        },
        results = {
          {type="item", name=params.ore, amount=params.quant_out},
          {type="item", name="se-contaminated-scrap", amount=1},
          {type="item", name=sedata, amount=1, probability=.99},
          {type="item", name=sejunk, amount=1, probability=.01},
          {type="fluid", name="se-space-coolant-hot", amount=25, ignored_by_stats=25, ignored_by_productivity=25},
        }
      }
    })
    util.add_unlock("se-space-matter-fusion", fname) 

    if util.k2() then
      local lname = params.ore.."-to-particle-stream"
      data:extend({
        enabled = false,
        {
          type = "recipe",
          name = lname,
          localised_name = {"recipe-name.se-kr-matter-liberation", {"item-name."..params.ore}},
          category = "space-materialisation",
          subgroup = "advanced-particle-stream",
          order = "a-b-z",
          icons = {
            {icon = "__space-exploration-graphics__/graphics/blank.png",
             icon_size = 64, scale = 0.5},
            {icon = "__space-exploration-graphics__/graphics/icons/fluid/particle-stream.png",
             icon_size = 64,  scale = 0.33, shift = {-8,8}},
            {icon = "__"..util.me.name.."__/graphics/icons/"..params.ore..".png",
             icon_size = params.icon_size, scale = 0.33 * 64/params.icon_size, shift={8, -8}},
            {icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png",
             icon_size = 64, scale = 0.5},
          },
          energy_required = 30,
          enabled = false,
          ingredients = {
            {type="item", name="se-kr-matter-liberation-data", amount=1},
            {type="item", name=params.ore, amount=params.quant_in},
            {type="fluid", name="se-particle-stream", amount=50},
          },
          results = {
            {type="item", name="se-kr-matter-liberation-data", amount=1, probability=.99},
            {type="item", name=sejunk, amount=1, probability=.01},
            {type="fluid", name="se-particle-stream", amount=params.stream_out, ignored_by_stats=50, ignored_by_productivity=50},
          }
        }
      })
      if not data.raw.technology["bz-advanced-stream-production"] then
        data:extend({
          {
            type = "technology",
            name ="bz-advanced-stream-production",
            localised_name = {"", {"technology-name.se-kr-advanced-stream-production"}, " 2"},
            icon = "__space-exploration-graphics__/graphics/technology/material-fabricator.png",
            icon_size = 128,
            effects = {},
            unit = {
              count = 100,
              time = 15,
              ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"se-rocket-science-pack", 1},
                {"space-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"se-astronomic-science-pack-4", 1},
                {"se-energy-science-pack-4", 1},
                {"se-material-science-pack-4", 1},
                {"kr-matter-tech-card", 1},
                {"se-deep-space-science-pack-1", 1},
              }
              
            },
            prerequisites = {"se-kr-advanced-stream-production"},
          },
        })
      end
      util.add_unlock("bz-advanced-stream-production", lname) 
    end
  end
end

-- deprecated
-- Get the normal prototype for a recipe -- either .normal or the recipe itself
function util.get_normal(recipe_name)
  if data.raw.recipe[recipe_name] then
    recipe = data.raw.recipe[recipe_name]
    return recipe
  end
end

-- Set/override a technology's prerequisites
function util.set_prerequisite(technology_name, prerequisites)
  local technology = data.raw.technology[technology_name]
  if technology then
    technology.prerequisites = {}
    for i, prerequisite in pairs(prerequisites) do
      if data.raw.technology[prerequisite] then
        table.insert(technology.prerequisites, prerequisite)
      end
    end
  end
end

-- Add a prerequisite to a given technology
function util.add_prerequisite(technology_name, prerequisite)
  local technology = data.raw.technology[technology_name]
  if technology and data.raw.technology[prerequisite] then
    if technology.prerequisites then
      for i, pre in pairs(technology.prerequisites) do
        if pre == prerequisite then return end
      end
      table.insert(technology.prerequisites, prerequisite)
    else
      technology.prerequisites = {prerequisite}
    end
  end
end

-- Remove a prerequisite from a given technology
function util.remove_prerequisite(technology_name, prerequisite)
  local technology = data.raw.technology[technology_name]
  local index = -1
  if technology then
    for i, prereq in pairs(technology.prerequisites) do
      if prereq == prerequisite then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(technology.prerequisites, index)
    end
  end
end


-- Add an effect to a given technology
function util.add_effect(technology_name, effect)
  local technology = data.raw.technology[technology_name]
  if technology then
    if not technology.effects then technology.effects = {} end
    if effect and effect.type == "unlock-recipe" then
      if not data.raw.recipe[effect.recipe] then
        return
      end
    end
    table.insert(technology.effects, effect)
  end
end

-- Make a technology boost productivity for a recipe
function util.add_to_productivity_research(technology_name, recipe_name, amount)
  if not amount then amount = 0.1 end
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    util.add_effect(technology_name, { type = "change-recipe-productivity", recipe = recipe_name, change = amount})
  end
end

-- Add an effect to a given technology to unlock recipe
function util.add_unlock(technology_name, recipe)
  util.add_effect(technology_name, {type="unlock-recipe", recipe=recipe})
end

-- Check if a tech unlocks a recipe
function util.check_unlock(technology_name, recipe_name)
  local technology = data.raw.technology[technology_name]
  if technology and technology.effects then
    for i, effect in pairs(technology.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
        return true
      end
    end
  end
  return false
end



-- remove recipe unlock effect from a given technology, multiple times if necessary
function util.remove_recipe_effect(technology_name, recipe_name)
    local technology = data.raw.technology[technology_name]
    local index = -1
    local cnt = 0
    if technology and technology.effects then
        for i, effect in pairs(technology.effects) do
            if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
                index = i
                cnt = cnt + 1
            end
        end
        if index > -1 then
            table.remove(technology.effects, index)
            if cnt > 1 then -- not over yet, do it again
                util.remove_recipe_effect(technology_name, recipe_name)
            end
        end
    end
end

-- Set technology ingredients
function util.set_tech_recipe(technology_name, ingredients)
  local technology = data.raw.technology[technology_name]
  if technology then
    if not technology.unit then
      -- set a sane unit just in case
      technology.unit = {time = 30, count = 50}
    end
    technology.unit.ingredients = ingredients
    technology.research_trigger = nil
  end
end

-- Set technology trigger
function util.set_tech_trigger(technology_name, trigger)
  local technology = data.raw.technology[technology_name]
  if technology then
    technology.unit = nil
    technology.research_trigger = trigger
  end
end

function util.set_enabled(recipe_name, enabled)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].enabled = enabled
  end
end

function util.set_hidden(recipe_name)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].hidden = true
  end
end

-- adds a crafting category if it doesn't exist, also optionally allowing handcrafting 
function util.add_new_crafting_category(category, by_hand)
  if not data.raw["recipe-category"][category] then
    data:extend({{
      type="recipe-category",
      name=category,
    }})
  end
  if by_hand then
    for i, character in pairs(data.raw.character) do
      if character.crafting_categories then
        table.insert(character.crafting_categories, category)
      end
    end
  end
end


-- Add a given quantity of ingredient to a given recipe
function util.add_or_add_to_ingredient(recipe_name, ingredient, quantity, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and util.get_item(ingredient) then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    add_or_add_to_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
  end
end

function add_or_add_to_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient then
        add_to_ingredient(recipe, ingredient, quantity)
        return
      end
    end
    table.insert(recipe.ingredients, util.item(ingredient, quantity))
  end
end

function util.get_item(name)
  if data.raw.item[name] then return data.raw.item[name] end
  if data.raw.armor[name] then return data.raw.armor[name] end
  if data.raw.fluid[name] then return data.raw.fluid[name] end
  if data.raw.capsule[name] then return data.raw.capsule[name] end
  if data.raw["space-platform-starter-pack"] and data.raw["space-platform-starter-pack"][name] then return data.raw["space-platform-starter-pack"][name] end
  -- TODO add more subtypes of item here
  return nil
end

-- Add a given quantity of ingredient to a given recipe
function util.add_ingredient(recipe_name, ingredient, quantity, options)
  if not should_force(options) and bypass(recipe_name) then return end
  local is_fluid = not not data.raw.fluid[ingredient]
  if data.raw.recipe[recipe_name] and (util.get_item(ingredient) or is_fluid) then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    add_ingredient(data.raw.recipe[recipe_name], ingredient, quantity, is_fluid)
  end
end

function add_ingredient(recipe, ingredient, quantity, is_fluid)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient then
        return
      end
    end
    if is_fluid then
      table.insert(recipe.ingredients, {type="fluid", name=ingredient, amount=quantity})
    else
      table.insert(recipe.ingredients, {type="item", name=ingredient, amount=quantity})
    end
  end
end

-- Add a given ingredient prototype to a given recipe
function util.add_ingredient_raw(recipe_name, ingredient, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient.name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    add_ingredient_raw(data.raw.recipe[recipe_name], ingredient)
  end
end

function add_ingredient_raw(recipe, ingredient)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient.name then
        return
      end
    end
    table.insert(recipe.ingredients, ingredient)
  end
end

-- Set an ingredient to a given quantity
function util.set_ingredient(recipe_name, ingredient, quantity, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    set_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
  end
end

function set_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient then
        existing.amount = quantity
        existing.amount_min = nil
        existing.amount_max = nil
        return
      end
    end
    table.insert(recipe.ingredients, {ingredient, quantity})
  end
end
-- Add a given quantity of product to a given recipe. 
-- Only works for recipes with multiple products
function util.add_product(recipe_name, product, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and 
  (data.raw.item[product.name] or data.raw.fluid[product.name]
  ) then
    add_product(data.raw.recipe[recipe_name], product)
  end
end

function add_product(recipe, product)
  if recipe ~= nil then
    if product.name and data.raw[product.type][product.name] then
      if recipe.results == nil then
        recipe.results = {}
      end
      for _, old in pairs(recipe.results) do
        if old.name == product.name then
          return
        end
      end
      recipe.result = nil
      recipe.result_count = nil
      table.insert(recipe.results, product)
    end
  end
end

-- Get the amount of the ingredient
function util.get_ingredient_amount(recipe_name, ingredient_name)
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.ingredients then
      for i, ingredient in pairs(recipe.ingredients) do
        if ingredient.name == ingredient_name then return ingredient.amount end
      end
    end
    return 0
  end
  return 0
end

-- Get the amount of the result (currently ignores probability)
function util.get_amount(recipe_name, product)
  if not product then product = recipe_name end
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name == product then
          if result.amount then
            return result.amount
          elseif result.amount_min then
            return (result.amount_min + result.amount_max) / 2
          end
        end
      end
    end
    return 0
  end
  return 0
end

-- Get the count of results
function util.get_result_count(recipe_name, product)
  if not product then product = recipe_name end
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.results then
      return #(recipe.results)
    end
    return 1
  end
  return 0
end

-- Replace one ingredient with another in a recipe
--    Use amount to set an amount. If that amount is a multiplier instead of an exact amount, set multiply true.
function util.replace_ingredient(recipe_name, old, new, amount, multiply, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or data.raw.fluid[new]) and (data.raw.item[old] or data.raw.fluid[old]) then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    replace_ingredient(data.raw.recipe[recipe_name], old, new, amount, multiply)
  end
end

function replace_ingredient(recipe, old, new, amount, multiply)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == new then
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then 
        ingredient.name = new 
        if amount then
          if multiply then
            ingredient.amount = amount * ingredient.amount
          else
            ingredient.amount = amount
          end
        end
      end
		end
	end
end

-- Remove an ingredient from a recipe
function util.remove_ingredient(recipe_name, old, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    remove_ingredient(data.raw.recipe[recipe_name], old)
  end
end

function remove_ingredient(recipe, old)
  index = -1
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do 
      if ingredient.name == old then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(recipe.ingredients, index)
    end
  end
end

-- Replace an amount of a product, leaving at least 1 of old
function util.replace_some_product(recipe_name, old, old_amount, new, new_amount, options)
  if not should_force(options) and bypass(recipe_name) then return end
  local is_fluid = not not data.raw.fluid[new]  -- NOTE CURRENTLY UNUSUED
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or is_fluid) then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    replace_some_product(data.raw.recipe[recipe_name], old, old_amount, new, new_amount, is_fluid)
  end
end

function replace_some_product(recipe, old, old_amount, new, new_amount)
	if recipe ~= nil then
    if recipe.result == new then return end
    if recipe.results then
      for i, existing in pairs(recipe.results) do
        if existing.name == new then
          return
        end
      end
    end
    add_product(recipe, util.item(new, new_amount))
		for i, product in pairs(recipe.results) do 
			if product.name == old then
        product.amount = math.max(1, product.amount - old_amount)
      end
		end
	end
end

-- Replace an amount of an ingredient in a recipe. Keep at least 1 of old.
function util.replace_some_ingredient(recipe_name, old, old_amount, new, new_amount, options)
  if not should_force(options) and bypass(recipe_name) then return end
  local is_fluid = not not data.raw.fluid[new]
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or is_fluid) then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    replace_some_ingredient(data.raw.recipe[recipe_name], old, old_amount, new, new_amount, is_fluid)
  end
end

function replace_some_ingredient(recipe, old, old_amount, new, new_amount, is_fluid)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == new then
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then
        ingredient.amount = math.max(1, ingredient.amount - old_amount)
      end
		end
    add_ingredient(recipe, new, new_amount, is_fluid)
	end
end

-- set the probability of a product. 
function util.set_product_probability(recipe_name, product, probability, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    set_product_probability(data.raw.recipe[recipe_name], product, probability)
	end
end

function set_product_probability(recipe, product, probability)
  if recipe then
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name == product then
          result.probability = probability
        end
      end
    end
  end
end

-- set the amount of a product. 
function util.set_product_amount(recipe_name, product, amount, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    set_product_amount(data.raw.recipe[recipe_name], product, amount)
	end
end

function set_product_amount(recipe, product, amount)
  if recipe then
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name == product then
          if result.amount then
            result.amount = amount
          end
          if result.amount_min ~= nil then
            result.amount_min =  nil
            result.amount_max =  nil
            result.amount = amount
          end
        end
      end
    end
    if not recipe.results and not recipe.result_count then
      -- implicit one item result
      recipe.result_count = amount
    end
  end
end

-- multiply the cost, energy, and results of a recipe by a multiple
function util.multiply_recipe(recipe_name, multiple, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    multiply_recipe(data.raw.recipe[recipe_name], multiple)
	end
end

function multiply_recipe(recipe, multiple)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * multiple
    else
      recipe.energy_required = 0.5 * multiple  -- 0.5 is factorio default
    end
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name then
          if result.amount then
            result.amount = result.amount * multiple
          end
          if result.amount_min ~= nil then
            result.amount_min = result.amount_min * multiple
            result.amount_max = result.amount_max * multiple
          end
          if result.ignored_by_stats then
            result.ignored_by_stats = result.ignored_by_stats * multiple
          end
          if result.ignored_by_productivity then
            result.ignored_by_productivity = result.ignored_by_productivity * multiple
          end
        end
      end
    end
    multiply_ingredients(recipe, multiple)
  end
end

-- multiply the ingredient cost of a recipe
function util.multiply_ingredients(recipe_name, multiple, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    multiply_ingredients(data.raw.recipe[recipe_name], multiple)
	end
end

function multiply_ingredients(recipe, multiple)
  if recipe then
    if recipe.ingredients then
      for i, ingredient in pairs(recipe.ingredients) do
        if ingredient.name then
          ingredient.amount = ingredient.amount * multiple
        end
      end
    end
  end
end

-- Returns true if a recipe has an ingredient
function util.has_ingredient(recipe_name, ingredient)
  return data.raw.recipe[recipe_name] and 
        has_ingredient(data.raw.recipe[recipe_name], ingredient)
end

function has_ingredient(recipe, ingredient)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == ingredient then
        return true
      end
    end
  end
  return false
end

-- Remove a product from a recipe, WILL NOT remove the only product
function util.remove_product(recipe_name, old, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    remove_product(data.raw.recipe[recipe_name], old)
  end
end

function remove_product(recipe, old)
  index = -1
	if recipe ~= nil and recipe.results ~= nil then
		for i, result in pairs(recipe.results) do 
      if result.name == old then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(recipe.results, index)
    end
  end
end

function util.set_main_product(recipe_name, product, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    set_main_product(data.raw.recipe[recipe_name], product)
  end
end

function set_main_product(recipe, product)
  if recipe then
    recipe.main_product = product
  end
end

-- Replace one product with another in a recipe
function util.replace_product(recipe_name, old, new, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or data.raw.fluid[new]) then
    replace_product(data.raw.recipe[recipe_name], old, new, options)
  end
end

function replace_product(recipe, old, new, options)
  if recipe then
    if recipe.main_product == old then
      recipe.main_product = new
    end
    if recipe.result == old then
      recipe.result = new
      return
    end
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name == old then result.name = new end
      end
    end
  end
end

-- Remove an element of type t and name from data.raw
function util.remove_raw(t, name)
  if not data.raw[t] then 
    log(t.." not found in data.raw")
    return
  end
  if data.raw[t][name] then
    for i, elem in pairs(data.raw[t]) do
      if elem.name == name then 
        data.raw[t][i] = nil
        break
      end
    end
  end
end

-- Set energy required
function util.set_recipe_time(recipe_name, time, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    set_recipe_time(data.raw.recipe[recipe_name], time)
	end
end

function set_recipe_time(recipe, time)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = time
    end
  end
end

-- Multiply energy required
function util.multiply_time(recipe_name, factor, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    multiply_time(data.raw.recipe[recipe_name], factor)
	end
end

function multiply_time(recipe, factor)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * factor
    end
  end
end

-- Add to energy required
function util.add_time(recipe_name, amount, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    add_time(data.raw.recipe[recipe_name], amount)
	end
end

function add_time(recipe, amount)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required + amount
    end
  end
end

-- Set localised name
function util.set_localised_name(recipe_name, localised_name)
  if data.raw.recipe[recipe_name] then
    data.raw.recipe[recipe_name].localised_name = localised_name
  end
end

-- Set recipe category
function util.set_category(recipe_name, category, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and data.raw["recipe-category"][category] then
    me.add_modified(recipe_name)
    prepare_redo_recycling(recipe_name)
    data.raw.recipe[recipe_name].category = category
  end
end

-- Set recipe subgroup
function util.set_subgroup(recipe_name, subgroup, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] and data.raw["item-subgroup"][subgroup] then
    me.add_modified(recipe_name)
    data.raw.recipe[recipe_name].subgroup = subgroup
  end
end

-- Set item subgroup
function util.set_item_subgroup(item, subgroup, options)
  if not should_force(options) and bypass(item) then return end -- imperfect, close enough for now?
  if data.raw.item[item] and data.raw["item-subgroup"][subgroup] then
    data.raw.item[item].subgroup = subgroup
  end
end

function util.add_icon(recipe_name, icon, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    if not (data.raw.recipe[recipe_name].icons and #(data.raw.recipe[recipe_name].icons) > 0) then
      if data.raw.recipe[recipe_name].icon then
        data.raw.recipe[recipe_name].icons = {{
          icon=data.raw.recipe[recipe_name].icon,
          icon_size=data.raw.recipe[recipe_name].icon_size,
          icon_mipmaps=data.raw.recipe[recipe_name].icon_mipmaps,
        }}
      elseif data.raw.item[data.raw.recipe[recipe_name].main_product] then
        data.raw.recipe[recipe_name].icons = {{
          icon=data.raw.item[data.raw.recipe[recipe_name].main_product].icon,
          icon_size=data.raw.item[data.raw.recipe[recipe_name].main_product].icon_size,
          icon_mipmaps=data.raw.item[data.raw.recipe[recipe_name].main_product].icon_mipmaps,
        }}
      elseif data.raw.item[data.raw.recipe[recipe_name].result] then
        data.raw.recipe[recipe_name].icons = {{
          icon=data.raw.item[data.raw.recipe[recipe_name].result].icon,
          icon_size=data.raw.item[data.raw.recipe[recipe_name].result].icon_size,
          icon_mipmaps=data.raw.item[data.raw.recipe[recipe_name].result].icon_mipmaps,
        }}
      end
      data.raw.recipe[recipe_name].icon = nil
      data.raw.recipe[recipe_name].icon_size = nil
    end
    table.insert(data.raw.recipe[recipe_name].icons, icon)
  end
end

-- Set recipe icons
function util.set_icons(recipe_name, icons, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    data.raw.recipe[recipe_name].icons = icons
    data.raw.recipe[recipe_name].icon = nil
    data.raw.recipe[recipe_name].icon_size = nil
  end
end

-- Set tech icons
function util.set_tech_icons(technology, icons, options)
  if not should_force(options) and bypass(technology) then return end
  if data.raw.technology[technology] then
    me.add_modified(technology)
    data.raw.technology[technology].icons = icons
    data.raw.technology[technology].icon = nil
    data.raw.technology[technology].icon_size = nil
  end
end

-- Set recipe icons
function util.set_item_icons(item_name, icons)
  if data.raw.item[item_name] then
    data.raw.item[item_name].icons = icons
    data.raw.item[item_name].icon = nil
    data.raw.item[item_name].icon_size = nil
  end
end

-- Gets an item or fluid icon
function util.get_item_or_fluid_icon(name)
  icon = ""
  if data.raw.item[name] then 
    icon = data.raw.item[name].icon 
    if not icon then icon = data.raw.item[name].icons[1].icon end
  elseif data.raw.fluid[name] then
    icon = data.raw.fluid[name].icon 
    if not icon then icon = data.raw.fluid[name].icons[1].icon end
  end
  return icon
end

function util.set_to_founding(recipe, options)
  util.set_category(recipe, "founding", options)
  util.set_subgroup(recipe, "foundry-intermediate", options)
end

function util.add_asteroid_to_planet(planet, spawn_def)
  if data.raw.planet[planet] and data.raw[spawn_def.type][spawn_def.asteroid] then
    table.insert(data.raw.planet[planet].asteroid_spawn_definitions, spawn_def)
  end
end

-- Add crafting category to an entity
function util.add_crafting_category(entity_type, entity, category)
   if data.raw[entity_type][entity] and data.raw["recipe-category"][category] then
      for i, existing in pairs(data.raw[entity_type][entity].crafting_categories) do
        if existing == category then
          return
        end
      end
      table.insert(data.raw[entity_type][entity].crafting_categories, category)
   end
end

-- Add crafting category to all entities that have another category
function util.add_crafting_category_if(entity_type, category, other_category)
  if data.raw[entity_type] and data.raw["recipe-category"][category] and data.raw["recipe-category"][other_category] then
    for _, entity in pairs(data.raw[entity_type]) do
      local found_good = false
      local found_bad = false
      for _, existing in pairs(entity.crafting_categories) do
        if existing == other_category then
          found_good = true
        end
        if existing == category then
          found_bad = true
        end
      end
      if found_good and not found_bad then
        table.insert(entity.crafting_categories, category)
      end
    end
  end
end


function util.add_to_ingredient(recipe, ingredient, amount, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe] then
    add_to_ingredient(data.raw.recipe[recipe], ingredient, amount)
  end
end

function add_to_ingredient(recipe, it, amount)
	if recipe and recipe.ingredients then
		for i, ingredient in pairs(recipe.ingredients) do
			if ingredient.name == it then
        ingredient.amount = ingredient.amount + amount
        return
      end
		end
	end
end

function util.add_to_product(recipe_name, product, amount, options)
  if not should_force(options) and bypass(recipe_name) then return end
  if data.raw.recipe[recipe_name] then
    add_to_product(data.raw.recipe[recipe_name], product, amount)
  end
end

function add_to_product(recipe, product, amount)
  if recipe ~= nil and recipe.results ~= nil then
    if recipe.result == product then
      recipe.result_count = recipe.result_count + amount
      return
    end
    for i, result in pairs(recipe.results) do
			if result.name == product then
        result.amount = result.amount + amount
        return
      end
    end
  end
end

-- Adds a result to a mineable type
function util.add_minable_result(t, name, result)
  if data.raw[t] and data.raw[t][name] and data.raw[t][name].minable and data.raw.item[result.name] then
    if data.raw[t][name].minable.result and not data.raw[t][name].minable.results then
      data.raw[t][name].minable.results = {
        util.item(data.raw[t][name].minable.result ,data.raw[t][name].minable.count)}
      data.raw[t][name].minable.result = nil
      data.raw[t][name].minable.result_count = nil
    end
    if data.raw[t][name].minable.results then
      for _, other in pairs(data.raw[t][name].minable.results) do
        if other.name == result.name then return end -- don't add if already present
      end
      table.insert(data.raw[t][name].minable.results, result)
    else
      data.raw[t][name].minable.results = {result}
    end
  end
end

function util.set_surface_property(surface, condition, value)
  if not data.raw["surface-property"][condition] then return end
  if data.raw.surface[surface] then
    data.raw.surface[surface].surface_properties[condition] = value
  end
  if data.raw.planet[surface] then
    data.raw.planet[surface].surface_properties[condition] = value
  end
end


local function insert(nodes, node, value)
    table.insert(node, value) -- store as parameter
    if 21 == #node then
        node = {""}
        table.insert(nodes, node)
    end
    return node
end

local function encode(data)
    local node = {""}
    local root = {node}
    local n = string.len(data)
    for i = 1,n,200 do
        local value = string.sub(data, i, i+199)
        node = insert(root, node, value)
    end
    while #root > 20 do
        local nodes,node = {},{""}
        for _, value in ipairs(root) do
            node = insert(nodes, node, value)
        end
        root = nodes
    end
    if #root == 1 then root = root[1] else
        table.insert(root, 1, "") -- no locale template
    end
    return #root < 3 and (root[2] or "") or root
end

function decode(data)
    if type(data) == "string" then return data end
    local str = {}
    for i = 2, #data do
        str[i-1] = decode(data[i])
    end
    return table.concat(str, "")
end

function util.create_list()
  if #me.list>0 then
    if not data.raw.item[me.name.."-list"] then
      data:extend({{
        type="item",
        name=me.name.."-list",
        localised_description = "",
        enabled=false,
        icon = "__core__/graphics/empty.png",
        icon_size = 1,
        stack_size = 1,
        hidden = true,
        hidden_in_factoriopedia = true,
        flags = {"hide-from-bonus-gui"}
      }})
    end

    local have = {}
    local list = {}
    for i, recipe in pairs(me.list) do
      if not have[recipe] then
        have[recipe] = true
        table.insert(list, recipe)
      end
    end

    if #list>0 then
      data.raw.item[me.name.."-list"].localised_description = 
        encode(decode(data.raw.item[me.name.."-list"].localised_description).."\n"..table.concat(list, "\n"))
    end
  end
end

function util.remove_prior_unlocks(tech, recipe)
  if data.raw.technology[tech].prerequisites then
    for i, prerequisite in pairs(data.raw.technology[tech].prerequisites) do
      remove_prior_unlocks(prerequisite, recipe, {})
    end
  end
end

function remove_prior_unlocks(tech, recipe, processed)
  if processed[tech] then
    print("Already processed ".. tech .. " returning")
    return
  end
  processed[tech] = true
  local technology = data.raw.technology[tech]
  if technology then
    log("Removing prior unlocks for ".. tech)
    util.remove_recipe_effect(tech, recipe)
    if technology.prerequisites then
      for i, prerequisite in pairs(technology.prerequisites) do
        if string.sub(prerequisite, 1, 3) ~= 'ei_' then
          -- log("BZZZ removing prior unlocks for " .. recipe .. " from " .. tech ..", checking " .. prerequisite) -- Handy Debug :|
          remove_prior_unlocks(prerequisite, recipe, processed)
        end
      end
    end
  end
end

function util.replace_ingredients_prior_to(tech, old, new, multiplier)
  if not data.raw.technology[tech] then
    log("Not replacing ingredient "..old.." with "..new.." because tech "..tech.." was not found")
    return
  end
  util.remove_prior_unlocks(tech, old)
  for i, recipe in pairs(data.raw.recipe) do
    if (recipe.enabled and recipe.enabled ~= 'false')
      and (not recipe.hidden or recipe.hidden == 'true') -- probably don't want to change hidden recipes
      and string.sub(recipe.name, 1, 3) ~= 'se-' -- have to exlude SE in general :(
    then
      -- log("BZZZ due to 'enabled' replacing " .. old .. " with " .. new .." in " .. recipe.name) -- Handy Debug :|
      util.replace_ingredient(recipe.name, old, new, multiplier, true)
    end
  end
  if data.raw.technology[tech].prerequisites then
    for i, prerequisite in pairs(data.raw.technology[tech].prerequisites) do
      replace_ingredients_prior_to(prerequisite, old, new, multiplier, {})
    end
  end
end

function replace_ingredients_prior_to(tech, old, new, multiplier, processed)
  if processed[tech] then
    print("Already processed ".. tech .. " returning")
    return
  end
  processed[tech] = true
  log("Replacing for tech "..tech)
  local technology = data.raw.technology[tech]
  if technology then
    if technology.effects then
      for i, effect in pairs(technology.effects) do
        if effect.type == "unlock-recipe" then
          -- log("BZZZ replacing " .. old .. " with " .. new .." in " .. effect.recipe) -- Handy Debug :|
          util.replace_ingredient(effect.recipe, old, new, multiplier, true)
        end
      end
    end
    if technology.prerequisites then
      for i, prerequisite in pairs(technology.prerequisites) do
        -- log("BZZZ checking " .. prerequisite) -- Handy Debug :|
        if string.sub(prerequisite, 1, 3) ~= 'ei_' then
          replace_ingredients_prior_to(prerequisite, old, new, multiplier, processed)
        end
      end
    end
  end
end

function util.remove_all_recipe_effects(recipe_name)
    for name, _ in pairs(data.raw.technology) do
        util.remove_recipe_effect(name, recipe_name)
    end
end

function util.add_unlock_force(technology_name, recipe)
    util.set_enabled(recipe, false)
    util.remove_all_recipe_effects(recipe)
    util.add_unlock(technology_name, recipe)
end

-- sum the products of a recipe 
function util.sum_products(recipe_name)
  -- this is going to end up approximate in some cases, integer division is probs fine
  if data.raw.recipe[recipe_name] then
    local recipe = data.raw.recipe[recipe_name]
    if not recipe.results then return recipe.result_count end
    local sum = 0
    for i, result in pairs(recipe.results) do
      local amt = 0
      if result[2] then amt = result[2]
      elseif result.amount then amt = result.amount
      elseif result.amount_min then amt = (result.amount_min + result.amount_max)/2
      end
      if result.probability then amt = amt * result.probability end
      sum = sum + amt
    end
    return sum
  end
  return 0
end

function util.set_vtk_dcm_ingredients()
  if mods["vtk-deep-core-mining"] then
    local sum = util.sum_products("vtk-deepcore-mining-ore-chunk-refining")
    log("setting vtk deepcore based on " .. serpent.dump(sum) .. " to " ..serpent.dump(sum*0.8))
    util.set_ingredient("vtk-deepcore-mining-ore-chunk-refining", "vtk-deepcore-mining-ore-chunk", sum * 0.8)
    local sum = 1+util.sum_products("vtk-deepcore-mining-ore-chunk-refining-no-uranium")
    log("setting vtk deepcore no uranium to " .. serpent.dump(sum))
    util.set_ingredient("vtk-deepcore-mining-ore-chunk-refining-no-uranium", "vtk-deepcore-mining-ore-chunk", sum)
  end
end

-- Set correct number of outputs for recyclers
function util.size_recycler_output()
  if data.raw.recipe["scrap-recycling"] and data.raw.recipe["scrap-recycling"].results then
    for i, entity in pairs(data.raw.furnace) do
      if util.contains(entity.crafting_categories, "recycling-or-hand-crafting") then
        if entity.result_inventory_size < #data.raw.recipe["scrap-recycling"].results then
          entity.result_inventory_size = #data.raw.recipe["scrap-recycling"].results
        end
      end
    end
  else
    local most = 0
    for i, recipe in pairs(data.raw.recipe) do
      if data.raw.recipe.ingredients and #data.raw.recipe.ingredients > most then
        most = #data.raw.recipe.ingredients
      end
    end
    for i, entity in pairs(data.raw.furnace) do
      if util.contains(entity.crafting_categories, "recycling-or-hand-crafting") then
        if entity.result_inventory_size < most then
          entity.result_inventory_size = most
        end
      end
    end
  end
end


-- Save recycling metadata that is later removed by quality mod. Call near end of data.lua
function util.prepare_recycling_helper()
  -- DEPRECATED
end

-- Recalculate recycling recipes, call near end of data-updates.lua, after calling
-- util.prepare_recycling_helper from data.lua
function util.redo_recycling()
  if mods.quality then
    local recycling = require("__quality__.prototypes.recycling")
    for _, recipe in pairs(data.raw.recipe) do
      if recipe.redo_recycling then
        recycling.generate_recycling_recipe(recipe)
      end
    end
    -- Find all recycling recipes that result in armor and make sure not to output more than 1
    for _, recipe in pairs(data.raw.recipe) do
      if recipe.name:find("recycling") then
        if recipe.results then
          for _, product in pairs(recipe.results) do
            if data.raw.armor[product.name] then
              if product.amount then
                if product.amount > .99 then
                  product.amount = 1
                  product.extra_count_fraction = nil
                end
              end
            end
          end
        end
      end
    end
  end
end

-- Preps the recipe to have recycling recalculated. Expects the recipe exists.
function prepare_redo_recycling(recipe_name)
  data.raw.recipe[recipe_name].redo_recycling = true
end

-- Change furnace output count
function util.set_minimum_furnace_outputs(category, count)
  for i, entity in pairs(data.raw.furnace) do
    if entity.result_inventory_size ~= nil and entity.result_inventory_size < count and util.contains(entity.crafting_categories, category) then
      entity.result_inventory_size = count
    end
  end
end


-- According to https://mods.factorio.com/mod/Asteroid_Mining, the
-- following function is under this MIT license (similar license, different author):
--
-- Copyright (c) 2021 Silari
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
function util.addtype(name,atint,desc) --,pictures)
  require("__Asteroid_Mining__/scripts/icons.lua") -- Has generateicons function

  local allowprod = settings.startup["astmine-allowprod"].value
  local useminer = settings.startup["astmine-enableminer"].value
  local hiderec = not settings.startup["astmine-hiderecipes"].value
  local recenabled = false

  local chunkstacksize = 1000
  if mods["space-exploration"] then
      chunkstacksize = 200
  end

  --Adds given recipe to prod modules allowed list
  function addmodules(name)
      if useminer then -- Only add these if we're actually enabled.
          table.insert(data.raw.module["productivity-module"].limitation, name)
          table.insert(data.raw.module["productivity-module-2"].limitation, name)
          table.insert(data.raw.module["productivity-module-3"].limitation, name)
      end
  end

  --Result for processing resource specific chunks
  local normal = { -- Gives 4000 chunks on average
      {
        amount_min = 3,
        amount_max = 5,
        probability = 1
      }
  }
  local chunkamount = 1000

  -- Space age makes rockets cost 1/20th as much. Give less materials, same ratio.
  if mods["space-age"] then 
      chunkamount = 50
  end

  --ITEM: Miner-module, which is what we send into space to get the asteroid-mixed item
  local minermodule = {
      icon = "__Asteroid_Mining__/graphics/mining-sat.png",
      icon_mipmaps = 4,
      icon_size = 64,
      name = "miner-module",
      localised_name = {"item-name.miner-module", "Mixed"},
      localised_description = {"item-description.miner-module", "mixed"},
      order = "n[miner-module]",
      rocket_launch_products = {{
          name="asteroid-mixed",
          amount=chunkamount,
          type="item"
      }},
      send_to_orbit_mode = "automated",
      stack_size = 1,
      subgroup = subminer,
      type = "item"
  }
  --Make a new item with the given name+"-chunk" and recipe to turn into name
  --eg addtype('iron-ore') makes iron-ore-chunk and recipe for iron-ore-chunk->100 iron-ore
  --log("Making new items for " .. name)
  --ITEM Resource chunk for this item
      
  local suffix = "-chunk"
  -- Sometimes we need to override the default suffix because the item name already exists.
  -- TODO - change this so it automatically detects name-chunk item exists and change suffix - BUT
  --  that would cause issues if 'name' is in more than one module - eg angels/bobs overlap, bob+bzlead, etc.
  --  Maybe add in something that tracks what 'name's have been added and skip it if it has.
  if string.find(name,"angels-ore",1,true) then
      suffix = "-chunk-am"
  end
  --log(name .. " name:suffix " .. suffix)
  
  local reschunk = {
    icons = {
      {
        icon = "__Asteroid_Mining__/graphics/resource-chunk.png",
        icon_mipmaps = 4,
        icon_size = 64
      },
      {
        icon = "__Asteroid_Mining__/graphics/resource-chunk-mask.png",
        icon_mipmaps = 4,
        icon_size = 64,
        tint = atint
      }
    },
    name = name .. suffix,
    localised_name = {"item-name.resource-chunk", {"item-name." .. name}},
    localised_description = {"item-description.resource-chunk", {"item-name." .. name}},
    order = "d[asteroidchunk-" .. name .. "]",
    stack_size = 25,
    subgroup = subchunk,
    type = "item"
  }
  
  --RECIPE Turn resource chunk into 24 of item
  local procreschunk = {
    allow_decomposition = false,
    always_show_products = true,
    category = reccategory,
    enabled = hiderec,
    energy_required = 5,
    ingredients = {
      {
        name=name .. suffix,
        amount=1,
        type="item"
      }
    },
    name = name .. suffix,
    order = "d[asteroidchunk-" .. name .. "]",
    localised_name = {"recipe-name.resource-chunk", {"item-name." .. name}},
    localised_description = {"recipe-description.resource-chunk", {"item-name." .. name}},
    results = {{name=name,amount=24,type="item"}},
    type = "recipe"
  }
  if desc == nil then
      desc = ""
  end
  
  --ITEM Resource specific asteroid chunk.
  local newasteroid = {
    icons = {
      {
        icon = "__Asteroid_Mining__/graphics/asteroid-chunk.png",
        icon_mipmaps = 4,
        icon_size = 64
      },
      {
        icon = "__Asteroid_Mining__/graphics/asteroid-chunk-mask.png",
        icon_mipmaps = 4,
        icon_size = 64,
        tint = atint
      }
    },
    name = "asteroid-" .. name,
    localised_name = {"item-name.asteroid-chunk", {"item-name." .. name}},
    localised_description = {"item-description.asteroid-chunk", {"item-name." .. name}, desc},
    order = "k[zasteroid-" .. name .. "]",
    stack_size = chunkstacksize,
    subgroup = subchunk,
    type = "item"        
  }
  --log(serpent.block(newasteroid))
  --We need to set the result name to the name of our resource chunk
  mynormal = table.deepcopy(normal)
  mynormal[1].name = name .. suffix
  mynormal[1].type = "item"
  --Expensive mode is gone.
  --myexpensive = table.deepcopy(expensive)
  --myexpensive[1].name = name .. suffix
  
  --RECIPE: Processing the asteroid chunks into resource chunks
  local processasteroid = {
    allow_decomposition = false,
    category = reccategory,
    name = "asteroid-" .. name,
    localised_name = {"recipe-name.asteroid-chunk", {"item-name." .. name}},
    localised_description = {"recipe-description.asteroid-chunk", {"item-name." .. name}},
    order = "k[zasteroid-" .. name .. "]",
    ingredients = {{name="asteroid-" .. name,amount=1,type="item"}},
    results = mynormal,
    always_show_products = true,
    enabled = hiderec,
    energy_required = 10,
    --subgroup = subchunk,
    type = "recipe"
  }

  --ITEM Miner module to get resource specific asteroids.
  local minerres = table.deepcopy(minermodule)
  minerres.name = "miner-module-" .. name
  minerres.rocket_launch_products = {{
      name="asteroid-" .. name,
      amount=chunkamount,
      type="item"
  }}
  minerres.order = "n[miner-module" .. name .. "]"
  minerres.icons = generateicons(name,atint) --Generate icon layers using given item
  minerres.localised_name = {"item-name.miner-module", {"item-name." .. name}}
  minerres.localised_description = {"item-description.miner-module", {"item-name." .. name}}
  
  --RECIPE: Recipe to make miner module to get resource specific asteroids. Always the default category
  local newminer = {
      enabled = recenabled,
      ingredients = {
          {
            name="electric-mining-drill",
            amount=5,
            type="item"
          },
          {
            name="radar",
            amount=5,
            type="item"
          },
          {
            name=name,
            amount=5,
            type="item"
          }
      },
      name = "miner-module-" .. name,
      results = {{name="miner-module-" .. name,amount=1,type="item"}},
      type = "recipe"        
  }
  data:extend{reschunk,procreschunk,newasteroid,processasteroid}
  if useminer then -- Disabled in 1.0 for the new generation system, once in place.
      data:extend{minerres,newminer}
      --This makes the miner module available when rocket silo is researched
      table.insert(data.raw.technology["rocket-silo"].effects, {type = "unlock-recipe", recipe = "miner-module-" .. name})
      if not hiderec then
          table.insert(data.raw.technology["rocket-silo"].effects, {type = "unlock-recipe", recipe = "asteroid-" .. name})
          table.insert(data.raw.technology["rocket-silo"].effects, {type = "unlock-recipe", recipe = name .. suffix})
      end
  end
  if allowprod then -- Setting to enable prod module usage in asteroid processing
      addmodules(processasteroid.name)
  end
end
-- END of alternate licenscing

return util
