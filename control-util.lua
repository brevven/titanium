local me = require("me")

local util = {}
util.me = me
local regenerate_command = "bz-regenerate"
local list_command = "bz-list"

function decode(data)
    if type(data) == "string" then return data end
    local str = {}
    for i = 2, #data do
        str[i-1] = decode(data[i])
    end
    return table.concat(str, "")
end

function util.check_fluid_mining()
  if me.fluid_mining then
    for i, force in pairs(game.forces) do
      if (
          (force.technologies["uranium-processing"] and force.technologies["uranium-processing"].researched) or
          (force.technologies["titanium-processing"] and force.technologies["titanium-processing"].researched) or
          false
      ) then
        force.technologies["fluid-mining"].researched = true
      end
    end
  end
end

function get_list()
    local p = prototypes.item[me.name.."-list"]
    if p then
      data = p.localised_description
      return decode(data)
    end
end

function util.force_enable_recipe(event, recipe_name)
  if game.players[event.player_index].force.recipes[recipe_name] then
    game.players[event.player_index].force.recipes[recipe_name].enabled=true      
  end
end

function list(event)
  if event.command and string.lower(event.command) == "bz-list" then
    local player = game.players[event.player_index]
    if player and player.connected then
      local list = get_list()
      if list and #list>0 then
        local filename = util.me.name..".txt"
        helpers.write_file(filename, list, false, event.player_index)
        player.print("Wrote recipes to script-output/"..filename)
      else
        player.print("Please change your mod startup setting for this mod's modified recipes list.")
      end
    end
  end
end

function util.add_list_command_handler()
  script.on_event(defines.events.on_console_command, list)
  
  if not commands.commands[list_command] then
    commands.add_command(list_command, "", function() end)
  end
end


function util.warptorio2_expansion_helper() 
  if script.active_mods["warptorio2_expansion"] then
    function check_container_for_items(container,items)
      local has_all =true
      for k=1,#items do 
        if container.get_item_count(items[k].name)<items[k].count then has_all=false break end
      end
      return has_all 		
    end

    function remove_items_from_container(container,items)
      for k=1,#items do 
        container.remove_item(items[k])
      end	
    end

    script.on_nth_tick(60, function (event)
      if global.done then return end
      local fix_items={
        {name='iron-plate',count=100},
        {name='iron-gear-wheel',count=100},
        {name='repair-pack',count=50},
      }
      local entities = {}
      for i=1,100 do
        if game.surfaces[i] then
          local lentities= game.surfaces[i].find_entities_filtered{area = {{-100, -100}, {100, 100}}, name = "wpe_broken_lab"}
          for j, entity in pairs(lentities) do
            table.insert(entities, entity)
          end
        end
      end
      if #entities == 0 then
        if global.checking then
          -- The lab has already been fixed
          global.done = true
        else
          -- Check that the lab doesn't reappear due to a warp
          global.checking = true
        end
        return
      end
      if check_container_for_items(entities[1],fix_items) then
        remove_items_from_container(entities[1],fix_items)
        local lab = entities[1].surface.create_entity({name='wpe_repaired_lab', position=entities[1].position, force = game.forces.player})
        lab.destructible=false
        lab.minable=false
        entities[1].destroy()
        global.done = true
      end
    end)
  end
end

local usage_regenerate = [[
Recommend saving the game before running this command.
Usage: /bz-regenerate all
or     /bz-regenerate <planet> <resource> [<frequency> <size> <richness>]
    planet must be an internal name like nauvis
    resource must be an internal name like lead-ore or titanium-ore
    frequency, size, and richness are optional, but all or none must be provided, and each should be a number between 0.166 and 6, where 1 is default setting.
Regenerates ore patches. If frequency/size/richness are provided, the planet will use those settings from now on, as well.
  - Separate arguments with spaces, do not use < >, [ ], quotes or other symbols
  - This action can take a while for larger maps!
  - Ores can sometimes overlap on regeneration. This can sometimes hide ore patches. If none seem to be made for a resource, regenerate just that resource and tweak frequency/size. 
]]
function util.add_regenerate_command_handler()
  script.on_event(defines.events.on_console_command, regenerate_ore)
  
  if not commands.commands[regenerate_command] then
    commands.add_command( regenerate_command, usage_regenerate, function() end)
  end
end

function regenerate_ore(event)
  if event.command == regenerate_command then
    local params = {}
    for w in event.parameters:gmatch("%S+") do table.insert(params, w) end
    if #params == 1 and params[1] == "all" then
      for _, resource in pairs(me.resources) do
        if prototypes.entity[resource] then
          game.print("Regenerating "..resource)
          game.regenerate_entity(resource)
        end
      end
      return
    end
    if not (#params == 2 or #params == 5) then
      game.print(usage_regenerate)
      return
    end
    local planet = params[1]
    for _, resource in pairs(me.resources) do
      if not game.surfaces[planet] then
        game.print("Could not find surface for "..planet..". May not exist, or may not yet be explored.")
        return
      end
      if resource == params[2] then
        if #params == 5 then
          local settings = {frequency=params[3], size=params[4], richness=params[5]}
          local map_gen_settings = game.surfaces[planet].map_gen_settings
          map_gen_settings.autoplace_controls[resource] = settings
          map_gen_settings.autoplace_settings.entity.settings[resource] = settings
          game.surfaces[planet].map_gen_settings = map_gen_settings
          game.print("Set "..resource.." on "..planet.." to "..serpent.line(settings))
        end
        game.print("Regenerating "..resource)
        game.surfaces[planet].regenerate_entity(resource)
      end
    end
  end
end

function util.ore_fix()
  ore_fix("nauvis")
  if game.surfaces.tenebris then
    ore_fix("tenebris")
  end
end

function ore_fix(surface_name)
  for _, resource in pairs(me.resources) do
    local map_gen_settings = game.surfaces[surface_name].map_gen_settings
    if map_gen_settings.autoplace_controls[resource] == nil then
      map_gen_settings.autoplace_controls[resource] = {}
    end
    if map_gen_settings.autoplace_settings.entity.settings[resource] == nil then
      map_gen_settings.autoplace_settings.entity.settings[resource] = {}
    end
    game.surfaces[surface_name].map_gen_settings = map_gen_settings
  end
end


-- A workaround for generating ores until this bug is fixed:
-- https://forums.factorio.com/viewtopic.php?f=7&t=124996&p=655013#p655013
function util.ore_workaround(event)
  for i, ore in pairs(util.me.ores_for_workaround) do
    if (
        event.surface and
        event.surface.map_gen_settings and
        event.surface.map_gen_settings.autoplace_controls and
        event.surface.map_gen_settings.autoplace_controls["titanium-ore"]
    ) then
      return
    end
    if event.surface.name ~= "nauvis" then return end
    if math.random() < settings.global[util.me.name.."-ore-workaround-probability"].value then
      util.generate_ore(event, ore.name, ore.amount, ore.tiles)
    end
  end
end

-- The majority of this function was written by Eradicator, see https://forums.factorio.com/viewtopic.php?t=72723
function util.generate_ore(event, name, amount, tiles)
  local biases = {[0] = {[0] = 1}}
  local t = 1

  repeat 
    t = t + util.grow(biases,t,tiles)
    until t >= tiles

  local pos = {x=event.position.x*32, y=event.position.y*32}
  local multiplier = math.max(math.abs(event.position.x), math.abs(event.position.y))
  if multiplier < 10 then return end  -- don't generate too close to start
  local total_bias = 0
  for x,_  in pairs(biases) do for y,bias in pairs(_) do
    total_bias = total_bias + bias
    end end

  for x,_  in pairs(biases) do for y,bias in pairs(_) do
      local entity = {
        name = name,
        amount = amount * (bias/total_bias) * multiplier,
        force = 'neutral',
        position = {pos.x+x,pos.y+y},
        }
      if event.surface.can_place_entity(entity) then
        event.surface.create_entity(entity)
      end
    end end
  
end

-- The majority of this function was written by Eradicator, see https://forums.factorio.com/viewtopic.php?t=72723
function util.grow(grid,t,tiles)
  local w_max = 256
  local h_max = 256
  local abs = math.abs
  local old = {}
  local new_count = 0
  for x,_  in pairs(grid) do for y,__ in pairs(_) do
    table.insert(old,{x,y})
    end end
  for _,pos in pairs(old) do
    local x,y = pos[1],pos[2]
    local bias = grid[x][y]
    for dx=-1,1,1 do for dy=-1,1,1 do
      local a,b = x+dx, y+dy
      if (math.random() > 0.9) and (abs(a) < w_max) and (abs(b) < h_max) then
        grid[a] = grid[a] or {}
        if not grid[a][b] then
          grid[a][b] = 1 - (t/tiles)
          new_count = new_count + 1
          if (new_count+t) == tiles then return new_count end
          end
        end
      end end
    end
  return new_count
  end



return util
