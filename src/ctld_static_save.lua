-- SIMPLE STATICS SAVING by Pikey, May 2019
  
 -- Usage of this script should credit the following contributors:
 --Pikey 
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
--I experienced issues Spawning Statics and Destroying statics in some configurations, so I'm exploding them and not deleting them like SGS. 

  --Configurable for user:
local SaveScheduleStatics=60 --how many seconds between each check of all the statics.

--- THIS IS NOT WORKING CORRECTLY AT THE MOMENT. NEED TO CODE OUT A BETTER MEANS.
-- 
local savefilename = "ctldstaticsave.lua"
local savefile = lfs.writedir() .."pg\\" .. savefilename
CTLDStatics = SET_STATIC:New():FilterPrefixes({"CTLD","ctld"}):FilterStart()
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
    return true
    else
    return false end 
end

function writemission(data, file)--Function for saving to file (commonly found)
  File = io.open(file, "w")
  File:write(data)
  File:close()
end

function Alive(grp)
if grp:IsAlive() then return false else return true end
end

function rngsmokes(coordinate)
smokes={coordinate:BigSmokeMedium(0.1),coordinate:BigSmokeMedium(0.2),coordinate:BigSmokeMedium(0.3),coordinate:BigSmokeMedium(0.2), coordinate:BigSmokeMedium(0.5), coordinate:BigSmokeMedium(0.8),coordinate:BigSmokeLarge(0.1),coordinate:BigSmokeHuge(0.1),}
local roll = math.random(1,100)
if roll > 95 then
smoke = smokes[math.random(1,#smokes)]
--env.info("smoker")
end
--env.info("no smoker")
end

--SCRIPT START
env.info("Loaded Simple Statics Saving, by Pikey, 2018, (updated Dec 2019) version " .. version)

if file_exists(savefile) then
  env.info("Script loading existing database")
  dofile(savefile)
  BASE:E({"CTLD static do file done",CTLDSaveStatics})
  --This version uses Destroy()

  BASE:E({"for each entered",grp,grp:GetName()})
  for k, v in pairs(CTLDSaveStatics) do
      BASE:E({"Found a CTLD Static Item is",v})
  end
else --Save File does not exist we start a fresh table
  SaveStatics={}
end

--THE SAVING SCHEDULE
SCHEDULER:New( nil, function()
CTLDStatics:ForEach(function (grp)

CTLDSaveStatics[grp:GetName()] =

-- In case destroying silently and spawning is fixed I'm leaving it to be used to spawn statics in the
-- format required for coalition.addStaticObject(SaveStatics[k]["Country"], staticData) .

{
 -- ["heading"] = grp:GetHeading(),
  --["groupId"] =grp:GetID(),
 -- ["shape_name"] = "stolovaya",
   ["type"] = grp:GetTypeName(),
  --["unitId"] = grp:GetID(),
 -- ["rate"] = 100,
  ["name"] = grp:GetName(),
  --["category"] = "Fortifications",
  ["y"] = grp:GetVec2().y, 
  ["x"] = grp:GetVec2().x, 
  ["dead"] = Alive(grp),
  ["Country"] = grp:GetCountry()
}

end)--end of the for each groupAlive iteration

local newMissionStr = IntegratedserializeWithCycles("CTLDSaveStatics",CTLDSaveStatics)
writemission(newMissionStr, savefile)
SaveStatics={} --flatten this between iterations to prevent accumulations
--env.info("Data saved.")
end, {}, 1, SaveScheduleStatics)
