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
local SaveScheduleStatics=120 --how many seconds between each check of all the statics.

--- THIS IS NOT WORKING CORRECTLY AT THE MOMENT. NEED TO CODE OUT A BETTER MEANS.
-- 
local savefilename = "ctldstaticsave.lua"
local savefile = lfs.writedir() .."pg\\" .. savefilename
CTLDStatics = SET_STATIC:New()
local function ctldsave_no_farps()
  CTLDStatics:Clear()
  Allstatics1:ForEach(function (stat)
    local _name = stat:GetName()
    if AIRBASE:FindByName(_name) ~= nil then
      --env.info(_name.." is a type of airbase, farp or oil rig")
      --avoid these types of static, they are really airbases
    else
		local prefix = "CTLD"
		local b = _name:find(prefix) == 1
		local a = stat:IsAlive()
		if (b == true and a == true) then
			CTLDStatics:AddStatic(stat)
		end
		prefix = "ctld"
		local b = _name:find(prefix) == 1
		if (b == true and a == true) then
			CTLDStatics:AddStatic(stat)
		end
	end
  end)
end
no_farps()
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
	local ts= STATIC:FindByName(grp:GetName())
	if ts:IsAlive() then return false else return true end
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
env.info("Loaded CTLD STATICS SAVE, version " .. version)

if file_exists(savefile) then
  env.info("Script loading existing database")
  dofile(savefile)
  BASE:E({"CTLD static do file done",CTLDCTLDSaveStatics})
  --This version uses Destroy()
	ctldsave_no_farps()
  for k, v in pairs(CTLDSaveStatics) do
      BASE:E({"Found a CTLD Static Item is",v})
      if STATIC:FindByName(v.name,false) ~= nil then
        BASE:E({"We have ctld item in game"})
        local static = STATIC:FindByName(v.name)
        if v.dead == true then
          local c = static:GetCoordinate()
		  c:Explode(500)
		  BASE:E({"Exploded the Static"})
        end
      else
        BASE:E({"We have a ctld item but it's NOT in the game yet."})
        if v.dead ~= true then
          if v.type ~= "container_cargo" then
            local item = {
              ["category"] = "Fortifications",
              ["type"] = v.type,
              ["y"] = v.y,
              ["x"] = v.x,
              ["name"] = v.name,
              ["heading"] = 0,
              ["country"] = v.Country,
            }
          mist.dynAddStatic(item)
          else
          BASE:E({"Type Was cargo Container"})
          end
        end
      end
  end
else --Save File does not exist we start a fresh table
  CTLDSaveStatics={}
end

--THE SAVING SCHEDULE
SCHEDULER:New( nil, function()
ctldsave_no_farps()
CTLDStatics:ForEach(function (grp)
	local tempstatic = STATIC:FindByName(grp:GetName())
	if tempstatic:IsAlive() == true then
		--BASE:E({"We are dumping some info here for CTLDStatics We got TRUE on IsAlive()"})
		--BASE:E({"grp",grp})
		--BASE:E({"tempstatic",tempstatic})
		--BASE:E({"tempstatic Get Coordinate",tempstatic:GetCoordinate()})
		--BASE:E({"tempstatic Get Vec2",tempstatic:GetVec2()})
		local tvec2 = tempstatic:GetVec2()
		CTLDSaveStatics[grp:GetName()] = 
		{
			["type"] = grp:GetTypeName(),
			["name"] = grp:GetName(),
			["y"] = tvec2.y, 
			["x"] = tvec2.x,
			["dead"] = Alive(grp),
			["Country"] = tempstatic:GetCountry()
		}
	else
		--BASE:E({"We are dumping some info here for CTLDStatics We got NOT TRUE on IsAlive()"})
		--BASE:E({"grp",grp})
		--BASE:E({"tempstatic",tempstatic})
		CTLDSaveStatics[grp:GetName()] = 
		{
			["type"] = grp:GetTypeName(),
			["name"] = grp:GetName(),
			["y"] = 0, 
			["x"] = 0,
			["dead"] = Alive(grp),
			["Country"] = tempstatic:GetCountry()
		}
	end
	--[[
  if Alive(grp) == true then
	
	BASE:E({"staticdump",tempstatic})
	local pos = tempstatic:GetCoordinate()
	BASE:E({"Coordinate Dump",pos})
	CTLDSaveStatics[grp:GetName()] =
	-- In case destroying silently and spawning is fixed I'm leaving it to be used to spawn statics in the
	-- format required for coalition.addStaticObject(CTLDSaveStatics[k]["Country"], staticData) .
	{
		-- ["heading"] = grp:GetHeading(),
		--["groupId"] =grp:GetID(),
		-- ["shape_name"] = "stolovaya",
		["type"] = grp:GetTypeName(),
		--["unitId"] = grp:GetID(),
		-- ["rate"] = 100,
		["name"] = grp:GetName(),
		--["category"] = "Fortifications",
		["y"] = tempstatic:GetVec2().y, 
		["x"] = tempstatic:GetVec2().x, 
		["dead"] = Alive(grp),
		["Country"] = tempstatic:GetCountry()
	}
  else
	CTLDSaveStatics[grp:GetName()] ={
		-- ["heading"] = grp:GetHeading(),
		--["groupId"] =grp:GetID(),
		-- ["shape_name"] = "stolovaya",
		["type"] = grp:GetTypeName(),
		--["unitId"] = grp:GetID(),
		-- ["rate"] = 100,
		["name"] = grp:GetName(),
		--["category"] = "Fortifications",
		["y"] = 0, 
		["x"] = 0, 
		["dead"] = Alive(grp),
		["Country"] = grp:GetCountry()
	}
  end
]]
end)--end of the for each groupAlive iteration

local newMissionStr = IntegratedserializeWithCycles("CTLDSaveStatics",CTLDSaveStatics)
writemission(newMissionStr, savefile)
CTLDSaveStatics={} --flatten this between iterations to prevent accumulations
env.info(" CTLD Statics - Data saved.")
end, {}, 1, SaveScheduleStatics)
