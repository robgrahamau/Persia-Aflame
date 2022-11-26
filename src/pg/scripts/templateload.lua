local thisunitname = "templateload.lua"
env.info(thisunitname .. " Started")

-- To use this unit just extract the file called "mission" from the .miz file, call it what you want, and then call 
-- missionspawn('myfilename', country.id.CJTF_RED)   
-- Change countryID to Blue if required. Will only spawn units for coalition specified. do
--
-- WARNING: This does NOT work correctly with Trains or Static objects at this point in time
    
-- For randomization of groups, include the name RNDx in the Group name. (Where x is 1..9 of the 10-90% chance of spawning)

function file_exists(name) --check if the file already exists for writing
    if lfs.attributes(name) then
    return true
    else
    return false end 
end






function tablespawn(tbl, _country, _cat)

--dumpinfo(tbl)

    for k, v in pairs(tbl) do
--        BASE:E({k, v})
        
        local spawnit = true
        local _subcat = _cat


        -- Detects if type is train - for some reason fails to still spawn in trains!
        if v.units ~= nil then
           if v.units[1] ~= nil then
               if v.units[1].type == "Train" then
                   _subcat = Group.Category.TRAIN
               end
           end
       end

        local _name = string.upper(v.name)
        if string.match(_name, "RND") then
          local i1, i2 = string.find(_name, 'RND')
          local s2 = string.sub(_name, i2+1, i2+1)
          if s2 == '1' or s2 == '2' or s2 == '3' or s2 =='4' or s2=='5' or s2=='6' or s2=='7' or s2=='8' or s2=='9' then
            local rn = tostring(s2) * 10
            if math.random(100) > rn then 
                spawnit = false
            end    
          end  
        end

        if spawnit == true then
            if _cat == Group.Category.STRUCTURE then
                coalition.addStaticObject(_country, v)
            else
                coalition.addGroup(_country, _subcat, v)
            end
        end
    end
end

function multitablespawn(tbl, _country)
    for i = 1, #tbl do
        if tbl[i].helicopter ~= nil then
            if tbl[i].helicopter.group ~= nil then
                tablespawn(tbl[i].helicopter.group, _country, Group.Category.HELICOPTER)
            end
        end
        if tbl[i].vehicle ~= nil then
            if tbl[i].vehicle.group ~= nil then

                local istrain = false

                local grps = tbl[i].vehicle.group
                for j = 1, #grps do

                if tbl[i].vehicle.group[j].units ~= nil then
                    if #tbl[i].vehicle.group[j].units > 0 then
                        local grpunits  = tbl[i].vehicle.group[j].units
                        for k = 1, #grpunits do 

                        if tbl[i].vehicle.group[1].units[1].type == "Train" then
                            istrain = true
                        end
                        end
                    end
                end
            end

                if istrain then
                    tablespawn(tbl[i].vehicle.group, _country, Group.Category.TRAIN)
                else
                    tablespawn(tbl[i].vehicle.group, _country, Group.Category.GROUND)
                end
            end
        end
        if tbl[i].plane ~= nil then
            if tbl[i].plane.group ~= nil then
                tablespawn(tbl[i].plane.group, _country, Group.Category.AIRPLANE)
            end
        end
        if tbl[i].ship ~= nil then
            if tbl[i].ship.group ~= nil then
                tablespawn(tbl[i].ship.group, _country, Group.Category.SHIP)
            end
        end
--        if tbl[i].static ~= nil then
--            if tbl[i].static.group ~= nil then
--                DEBUGMESSAGE('Static group found!'..tbl[i].static.group[1].name)
--                tablespawn(tbl[i].static.group, _country, Group.Category.STRUCTURE)
--            end
--        end

        
        if tbl[i].static ~= nil then
            if tbl[i].static.group ~= nil then
                local grps = tbl[i].static.group
                for j = 1, #grps do
                   if grps[i].units ~= nil then 
                         local grpunits = grps[j].units
                         --for k = 1, #grpunits do
--                           DEBUGMESSAGE('Static group found! '.. grpunits[k].name)
                           --dumpinfo(grpunits[i])
                           --tablespawn(grpunits[i], _country, Group.Category.STRUCTURE)
                      --end
                      DEBUGMESSAGE('Static group found!')
                      --(grpunits)
                      tablespawn(grpunits, _country, Group.Category.STRUCTURE)
                   end 
                end   
            end    
        end    
    end
end


function missionspawn(_missionfile, _coalition)
   mission = nil 

   local minizip				= require("minizip")  -- Note - _G['require'] = nil must be DESANITISED in missionscripts.lua for this to work!!!
   local TempMizPath = 'C:\\dcstemp'
   local TemplateFile = missionpath.._missionfile
   lfs.mkdir(TempMizPath)	
   if file_exists(TempMizPath..'\\mission') then
	os.remove(TempMizPath..'\\mission')	
   end
   DEBUGMESSAGE('LOADING FILE '.. TemplateFile .. ' to '..TempMizPath)

   local zipFile = minizip.unzOpen(TemplateFile,TempMizPath)

   while true do --scompattalo e passa al prossimo
      local filename = zipFile:unzGetCurrentFileName()
      if filename == 'mission' then
        local fullpath = TempMizPath..'\\'..filename
        DEBUGMESSAGE(" unzipping " .. tostring(filename))
        zipFile:unzUnpackCurrentFile(fullpath) 
      end

       if not zipFile:unzGoToNextFile() then 
         break
       end  
   end

   dofile(TempMizPath..'/mission')


   if mission == nil then
     MESSAGE:New("Admin Error: No misison template", 15):ToAll()
   else
     local tbl = ''
     local ctrl = ''

    if _coalition == nil then
        missionspawn(_missionfile, coalition.side.RED)
        missionspawn(_missionfile, coalition.side.BLUE)
        missionspawn(_missionfile, coalition.side.NEUTRAL)
        return
    end

     if _coalition == coalition.side.RED then
        tbl = mission.coalition.red.country  
        ctry = country.id.CJTF_RED
     end
     if _coalition == coalition.side.BLUE then
          tbl = mission.coalition.blue.country  
          ctry = country.id.CJTF_BLUE
     end
     if _coalition == coalition.side.NEUTRAL then
         tbl = mission.coalition.neutrals.country  
         ctry = country.id.UN_PEACEKEEPERS
     end


     if tbl == nil then
         DEBUGMESSAGE("Error... file "..missionpath.._missionfile..' failed to load in table!')
     else
         multitablespawn(tbl, ctry)
     end
  end

end

env.info(thisunitname .. " End")
