defaultlogisticUnits = {
    "Tarawa",
	"TeddyR",
	"Peleliu",
    "Nassau",
	"Saipan",
	"Tawaractld",
	"Saipanctld",
}


 --Configurable for user:
local SaveSchedulePersistence=60 --how many seconds between each check of all the statics.
 --AllGroups = SET_GROUP:New():FilterCategories("ground"):FilterPrefixes({"RSAM","RRSUP","REWR","BSAM","BEWR",}):FilterActive(true):FilterStart()
 ctldper = false
 ctldsave = {}
local savefilename = "ctldsave.lua"
 
ctldsavefile = lfs.writedir() .."pg\\" .. savefilename
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
  if file_exists(ctldsavefile) then --Script has been run before, so we need to load the save
    dofile(ctldsavefile)
	if ctldsave[1] ~= nil then
		ctld.completeAASystems = ctldsave[1]
	else
		ctld.completeAASystems = {}
	end
    if ctldsave[2] ~= nil then
		ctld.droppedTroopsRED = ctldsave[2]
	else
		ctld.droppedTroopsRED = {}
	end
	if ctldsave[3] ~= nil then
		ctld.droppedTroopsBLUE = ctldsave[3]
	else
		ctld.droppedTroopsBLUE = {}
	end
    if ctldsave[4] ~= nil then
		ctld.droppedVehiclesRED = ctldsave[4]
	else
		ctld.droppedVehiclesRED = {}
	end
	if ctldsave[5] ~= nil then
		ctld.droppedVehiclesBLUE = ctldsave[5]
	else
		ctld.droppedVehiclesBLUE = {}
	end
    if ctldsave[6] ~= nil then
		ctld.jtacUnits = ctldsave[6]
		local _jtacGroupName = nil
		local _jtacUnit = nil
		for _jtacGroupName, _jtacDetails in pairs(ctld.jtacUnits) do
			print("_jtacGroupName is:" .. _jtacGroupName .. "Units we don't care about")
			local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
            --put to the end
            table.insert(ctld.jtacGeneratedLaserCodes, _code)
            ctld.JTACAutoLase(_jtacGroupName, _code) --(_jtacGroupName, 
		end
		
		
	else
		ctld.jtacUnits = {}
	end
    if ctldsave[7] ~= nil then
		--ctld.builtFOBS = ctldsave[7]
	else
		--ctld.builtFOBS = {}
	end
	if ctldsave[8] ~= nil then
		--ctld.logisticUnits = ctldsave[8]
	else
		--BASE:E({"WARNING CTLD SAVE TABLE 8 WAS EMPTY!!!! GENERATING FROM DEFAULT VALUES"})
		--ctld.logisticUnits = defaultlogisticUnits
    end
	if ctldsave[9] ~= nil then
		ctld.extractableGroups = ctldsave[9]
	else
		ctld.extractableGroups = {}
	end

	--ctld.jtacGeneratedLaserCodes = ctldsave[10]
	--ctld.jtacLaserPointCodes = ctldsave[11]
	ctld.nextUnitId = ctldsave[12]
	ctld.nextGroupId = ctldsave[13]
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
   ctldsave[1] = ctld.completeAASystems
   ctldsave[2] = ctld.droppedTroopsRED
   ctldsave[3] = ctld.droppedTroopsBLUE
   ctldsave[4] = ctld.droppedVehiclesRED
   ctldsave[5] = ctld.droppedVehiclesBLUE
   ctldsave[6] = ctld.jtacUnits
   ctldsave[7] = ctld.builtFOBS
   ctldsave[8] = ctld.logisticUnits
   ctldsave[9] = ctld.extractableGroups
   ctldsave[10] = ctld.jtacGeneratedLaserCodes
   ctldsave[11] = ctld.jtacLaserPointCodes
   ctldsave[12] = ctld.nextUnitId
   ctldsave[13] = ctld.nextGroupId
end

function ctldsavedata()
  savectldpersistence()
  newMissionStr = IntegratedserializeWithCycles("ctldsave",ctldsave) --save the Table as a serialised type with key SaveUnits
  writemission(newMissionStr, ctldsavefile)--write the file from the above to SaveUnits.lua
  env.info("Data saved.")
  ctldsave = {} -- clean out the table for next time.
end
--THE SAVING SCHEDULE
SCHEDULER:New( nil, function()
if init == true then
  ctldsavedata()
else
  env.info("init was not true not saving")
end
end, {}, 1, SaveSchedulePersistence)