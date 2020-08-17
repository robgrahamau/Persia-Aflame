-- Simple Group Saving by Pikey May 2019 https://github.com/thebgpikester/SimpleGroupSaving/
-- Usage of this script should credit the following contributors:
 --Pikey, 
 --Speed & Grimes for their work on Serialising tables, included below,
 --FlightControl for MOOSE (Required)
 
 --INTENDED USAGE
 --DCS Server Admins looking to do long term multi session play that will need a server reboot in between and they wish to keep the Ground 
 --Unit positions true from one reload to the next.
 
 --USAGE
 --Ensure LFS and IO are not santitised in missionScripting.lua. This enables writing of files. If you don't know what this does, don't attempt to use this script.
 --Requires versions of MOOSE.lua supporting "SET:ForEachGroupAlive()". Should be good for 6 months or more from date of writing. 
 --MIST not required, but should work OK with it regardless.
 --Edit 'SaveScheduleUnits' below, (line 34) to the number of seconds between saves. Low impact. 10 seconds is a fast schedule.
 --Place Ground Groups wherever you want on the map as normal.
 --Run this script at Mission start
 --The script will create a small file with the list of Groups and Units.
 --At Mission Start it will check for a save file, if not there, create it fresh
 --If the table is there, it loads it and Spawns everything that was saved.
 --The table is updated throughout mission play
 --The next time the mission is loaded it goes through all the Groups again and loads them from the save file.
 
 --LIMITATIONS
 --Only Ground Groups and Units are specified, play with the SET Filter at your own peril. Could be adjusted for just one Coalition or a FilterByName().
 --See line 107 and 168 for the SET.
 --See https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Core.Set.html##(SET_GROUP)
 --Naval Groups not Saved. If Included, there may be issues with spawned objects and Client slots where Ships have slots for aircraft/helo. Possible if not a factor
 --Statics are not included. See 'Simple Static Saving' for a solution
 --Routes are not saved. Uncomment lines 148-153 if you wish to keep them, but they won't activate them on restart. It is impossible to query a group for it's current
 --route, only for the original route it recieved from the Mission Editor. Therefore a DCS limitation.
 -----------------------------------
 --Configurable for user:
local SaveSchedulePersistence=60 --how many seconds between each check of all the statics.
 --AllGroups = SET_GROUP:New():FilterCategories("ground"):FilterPrefixes({"RSAM","RRSUP","REWR","BSAM","BEWR",}):FilterActive(true):FilterStart()
 ctldper = false
 ctldsave = {}
local savefilename = "ctldsave.lua"
 
local savefile = lfs.writedir() .."pg\\" .. savefilename
 -----------------------------------
 --Do not edit below here
 -----------------------------------
 local version = "1.1"
 
 function IntegratedbasicSerialize(s)
    if s == nil then
      return "\"\""
    else
      if ((type(s) == 'number') or (type(s) == 'boolean') or (type(s) == 'function') or (type(s) == 'table') or (type(s) == 'userdata') ) then
        return tostring(s)
      elseif type(s) == 'string' then
        return string.format('%q', s)
      end
    end
  end
  
-- imported slmod.serializeWithCycles (Speed)
  function IntegratedserializeWithCycles(name, value, saved)
    local basicSerialize = function (o)
      if type(o) == "number" then
        return tostring(o)
      elseif type(o) == "boolean" then
        return tostring(o)
      else -- assume it is a string
        return IntegratedbasicSerialize(o)
      end
    end

    local t_str = {}
    saved = saved or {}       -- initial value
    if ((type(value) == 'string') or (type(value) == 'number') or (type(value) == 'table') or (type(value) == 'boolean')) then
      table.insert(t_str, name .. " = ")
      if type(value) == "number" or type(value) == "string" or type(value) == "boolean" then
        table.insert(t_str, basicSerialize(value) ..  "\n")
      else

        if saved[value] then    -- value already saved?
          table.insert(t_str, saved[value] .. "\n")
        else
          saved[value] = name   -- save name for next time
          table.insert(t_str, "{}\n")
          for k,v in pairs(value) do      -- save its fields
            local fieldname = string.format("%s[%s]", name, basicSerialize(k))
            table.insert(t_str, IntegratedserializeWithCycles(fieldname, v, saved))
          end
        end
      end
      return table.concat(t_str)
    else
      return ""
    end
  end

function file_exists(name) --check if the file already exists for writing
    if lfs.attributes(name) then
    BASE:E({"Mission file found"})
    return true
    else
    BASE:E({"Mission file not found"})
    return false end 
end

function writemission(data, file)--Function for saving to file (commonly found)
  File = io.open(file, "w")
  File:write(data)
  File:close()
end

--SCRIPT START
env.info("Loaded RIB SAVE, version " .. version)
if resetall == 0 then
  if file_exists(savefile) then --Script has been run before, so we need to load the save
    dofile(savefile)
    ctld.completeAASystems = ctldsave[1]
    ctld.droppedTroopsRed = ctldsave[2]
    ctld.droppedTroopsBLUE = ctldsave[3]
    ctld.droppedVehiclesRED = ctldsave[4]
    ctld.droppedVehiclesBLUE = ctldsave[5]
    ctld.jtacUnits = ctldsave[6]
    ctld.jtacGeneratedLaserCodes = ctldsave[7] -- keeps track of generated codes, cycles when they run out
    ctld.jtacLaserPointCodes = ctldsave[8]
    env.info("Main Mission: Existing database, loading from File.")
    BASE:E({ctldsave})
    ctldper = true
  else
    env.info("Main Mission: We couldn't find an existing Database to load from file")
  end
else
  if resetall == 1 then
    env.info("Main Mission: PersistedStore.resetall was 1")
    ctldper = false
  end
end


function savectldpersistence()
   BASE:E("saving ctld items")
   ctldsave = { ctld.completeAASystems, ctld.droppedTroopsRED, ctld.droppedTroopsBLUE, ctld.droppedVehiclesRED,ctld.droppedVehiclesBLUE, ctld.jtacUnits, ctld.jtacGeneratedLaserCodes,ctld.jtacLaserPointCodes}
end


--THE SAVING SCHEDULE
SCHEDULER:New( nil, function()
if init == true then
  savectldpersistence()
  newMissionStr = IntegratedserializeWithCycles("ctldsave",ctldsave) --save the Table as a serialised type with key SaveUnits
  writemission(newMissionStr, savefile)--write the file from the above to SaveUnits.lua
  env.info("Data saved.")
  ctldsave = {} -- clean out the table for next time.
else
  env.info("init was not true not saving")
end
end, {}, 1, SaveSchedulePersistence)