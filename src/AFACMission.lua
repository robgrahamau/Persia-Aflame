function _split(str, sep)
  --BASE:E({str=str, sep=sep})
  local result = {}
  local regex = ("([^%s]+)"):format(sep)
  for each in str:gmatch(regex) do
    table.insert(result, each)
  end
  return result
end


BASE:E({"AFAC START"})
randomstart = math.random(30,60) -- randomly start the F4's after this period of time
Slothandler = EVENTHANDLER:New() -- this sets up our event handler for if people die uses Simple Slot blocker (server side script)
Slothandler:HandleEvent(EVENTS.Crash) -- watch for crash, ejection and pilot dead
Slothandler:HandleEvent(EVENTS.Ejection)
Slothandler:HandleEvent(EVENTS.PilotDead)

-- set up our Command centers so we can easily send Messages out. We aren't making tasking so we won't make COMMAND_CENTER:NEW
BCC = GROUP:FindByName("BlueCommand")
RCC = GROUP:FindByName("RedCommand")

OZCOM = GROUP:FindByName("OZCOM") -- we don't really use this any more.
trigger.action.setUserFlag("SSB",100) -- slot blocker active.
SupportHandler = EVENTHANDLER:New() -- our support handler so we can add/remove stuff etc it's just another even handler

-- these cover the slot blocking mechanics

 ---@param self
  --@param Core.Event#EVENTDATA EventData
function Slothandler:OnEventCrash(EventData)
  BASE:E({"On Event Crash Captured Triggered by unit",EventData.IniGroupName})
  -- Lock that unit out so it can no longer be used.
  -- unless it's BOAR or BOAR 2
  if EventData.IniGroupName == "BOAR2 - AFAC - RESTRICTED" then
    BCC:MessageToAll("Alert AFAC Lost, Slot NOT blocked as it's an Important slot",60,"RIPCORD")
    return
  end
  if EventData.IniGroupName == "BOAR - AFAC - RESTRICTED" then
    BCC:MessageToAll("Alert AFAC Lost, Slot NOT blocked as it's an Important slot",60,"RIPCORD")
    return
  end
  
  trigger.action.setUserFlag(EventData.IniGroupName,100)
  Msgtosend = "Alert, We just detected a crash impact beacon for " .. EventData.IniGroupName .. ", Unit is no longer avalible for use for 1 hour"
  BCC:MessageToAll(Msgtosend,30,"RIPCORD")
  -- Set up a scheduler that 1 hour after this event will unblock the slot.
  SCHEDULER:New(nil,function() 
    Msgtosend = "A replacement for unit " .. EventData.IniGroupName .. " is now avalible" 
    trigger.action.setUserFlag(EventData.IniGroupName,0)
    BCC:MessageToAll(Msgtosend,30,"RIPCORD")
  end,{},(60*60))
end

-- same as above for ejection

function Slothandler:OnEventEjection(EventData)
  BASE:E({"On Event Ejection Captured Triggered by unit",EventData.IniGroupName})
  if EventData.IniGroupName == "BOAR2 - AFAC - RESTRICTED" then
    BCC:MessageToAll("Alert AFAC Lost, Slot NOT blocked as it's an Important slot",60,"RIPCORD")
    return
  end
  if EventData.IniGroupName == "BOAR - AFAC - RESTRICTED" then
    BCC:MessageToAll("Alert AFAC Lost, Slot NOT blocked as it's an Important slot",60,"RIPCORD")
    return
  end
  -- Lock that unit out so it can no longer be used.
  trigger.action.setUserFlag(EventData.IniGroupName,100)
  Msgtosend = "Alert, We just Detected the SAR BEACON of " .. EventData.IniGroupName .. ", Unit is no longer avalible for use for 1 hour"
  BCC:MessageToAll(Msgtosend,30,"RIPCORD")
  SCHEDULER:New(nil,function() 
    Msgtosend = "A replacement for unit " .. EventData.IniGroupName .. " is now avalible" 
    trigger.action.setUserFlag(EventData.IniGroupName,0)
    BCC:MessageToAll(Msgtosend,30,"RIPCORD")
  end,{},(60*60))

end

-- same as above for pilot dead.

function Slothandler:OnEventPilotDead(EventData)
  BASE:E({"On Event Pilot Dead Captured Triggered by unit",EventData.IniGroupName})
  if EventData.IniGroupName == "BOAR2 - AFAC - RESTRICTED" then
    BCC:MessageToAll("Alert AFAC Lost, Slot NOT blocked as it's an Important slot",60,"RIPCORD")
    return
  end
  if EventData.IniGroupName == "BOAR - AFAC - RESTRICTED" then
    BCC:MessageToAll("Alert AFAC Lost, Slot NOT blocked as it's an Important slot",60,"RIPCORD")
    return
  end
  -- Lock that unit out so it can no longer be used.
  trigger.action.setUserFlag(EventData.IniGroupName,100)
  Msgtosend = "Alert, Comm activity detects that " .. EventData.IniGroupName .. "'s pilot was just killed, Unit is no longer avalible for use for 1 hour"
  BCC:MessageToAll(Msgtosend,30,"RIPCORD")
  SCHEDULER:New(nil,function() 
    Msgtosend = "A replacement for unit " .. EventData.IniGroupName .. " is now avalible" 
    trigger.action.setUserFlag(EventData.IniGroupName,0)
    BCC:MessageToAll(Msgtosend,30,"RIPCORD")
  end,{},(60*60))

end

-- set up the scheduler to start our F-4 group

SCHEDULER:New(nil,function() 

-- we are using actual BASE DCS scripting here, trigger is a API from DCS documentation here: https://wiki.hoggitworld.com/view/Simulator_Scripting_Engine_Documentation
trigger.action.pushAITask(Group.getByName("F4GROUP"),1) -- push the first AI Push task to start (4th tab on the mission editor on the group i believe
trigger.action.pushAITask(Group.getByName("F4GROUP1"),1)
BASE:E({"F4 PUSH TASK SHOULD HAVE JUST HAPPENED LETS SEE HOW PPL REACT NO?"}) -- drop out a log msg
RCC:MessageToRed("F4's are out to give the players a .... Scare",60,"IRANI C3") -- if some ones some how on red they'll see this.
end,{},(60*randomstart))


function smokegroup()
  local rangerteam = GROUP:FindByName("US Ranger Team") -- store our ranger team
  local rangerteamcoord = rangerteam:GetCoordinate() -- get our coord
  rangerteamcoord:SmokeGreen() -- trigger our smoke.

end

-- create our menus
smokemenu = MENU_COALITION:New(coalition.side.BLUE,"AFAC CONTROL WINDOW") -- set up our AFAC Control Window
smokemenusmokegreen = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Request Smoke On Group",smokemenu,smokegroup)

-- start our arty stuff
scorpion = ARTY:New(GROUP:FindByName("SCORPION")) -- set up our main group
scorpion:SetRearmingGroup(GROUP:FindByName("SCORPION AMMO TRUCK")) -- our ammo truck
scorpion:SetMaxFiringRange(20) -- 20km max range.
scorpion:SetSmokeShells(100,SMOKECOLOR.Green)
scorpion:SetSmokeShells(100,SMOKECOLOR.Red)
scorpion:SetSmokeShells(100,SMOKECOLOR.Blue)
scorpion:Start()
-- Handles our Admin 'Tools' 


local function handleRespawnRequest(text,coord)
  BASE:E({"ReSpawn Request",text,coord})
 BASE:E({"Spawn Request",text,coord})
  local currentTime = os.time()
  local keywords=_split(text, ",")
  local unit = nil
  BASE:E({keywords=keywords})
  unit = keywords[2]
  local mgroup = nil
  mgroup = GROUP:FindByName(unit)
  if mgroup == nil then
    BASE:E({"Respawn error, No group found"})
    BCC:MessageToAll("TGW ADMIN Error:No Group Found")
  else
    if mgroup:IsAlive() == true then
      mgroup:Destroy()
    end
    BASE:E({"Respawning unit/coord:",unit,coord})
    mspawner = SPAWN:New(unit):SpawnFromCoordinate(coord)
    BCC:MessageToAll("TGW ADMIN COMMAND COMPLETED")
  end
end

local function handleDestroyRequest(text,coord)
  BASE:E({"Destroy Request",text,coord})
  local currentTime = os.time()
  local keywords=_split(text, ",")
  local unit = nil
  BASE:E({keywords=keywords})
  unit = keywords[2]
  local mgroup = nil
  mgroup = GROUP:FindByName(unit)
  if mgroup == nil then
    BASE:E({"Respawn error, No group found",unit})
    BCC:MessageToAll("TGW ADMIN Error:No Group Found")
  else
    if mgroup:IsAlive() == true then
       BASE:E({"Destroying Unit:",unit,coord})
      mgroup:Destroy()
      BCC:MessageToAll("TGW ADMIN COMMAND COMPLETED")
    end
  end
end

function findbyid(id)
  local setclient = SET_CLIENT:New():FilterActive(true):FilterOnce()
  setclient:ForEach(function(setgroup) 
    BASE:E({"Our Active Set Clients are:",setgroup:GetName(),setgroup:GetID()})
    mobject = setgroup:GetDCSObject()
    BASE:E(mobject.id_)
    BASE:E({"ID is",id.id_})
    mgroup = setgroup:GetDCSGroup()
    if mobject.id_ == id.id_ then
      BCC:MessageToAll("We got an ID Match Unit Id was ".. id.id_ .. " Name was " .. setgroup:GetName(),30,"Tester")
      BASE:E({"MATCH ON ID",mobject.id_,id.id_,setgroup:GetDCSObject(),setgroup:GetName()})
    end
    BASE:E({"Mobject",mobject})
    BASE:E({"MGroup",mgroup})
    if setgroup:GetID() == id then
      BCC:MessageToAll("We got an ID Match Unit Id was ".. id .. " Name was " .. setgroup:GetName(),30,"Tester")
    end
  end,{})
  local tempset = SET_GROUP:New():FilterActive(true):FilterOnce()
  BASE:E({"FILTER ACTIVE, Current Group Count is",tempset:Count()})
  tempset:ForEach(function(setgroup) 
    BASE:E({"Our Active groups are Group Name, GroupId:",setgroup:GetName(),setgroup:GetID()})
    if setgroup:GetID() == id then
      BCC:MessageToAll("We got an ID match unit Group Id was".. id .. "Group Name was" .. setgroup:GetName(),30,"Tester")
    end
  end,{})
end

function handleLLRequest(text,coord)
  do
      _SETTINGS:SetImperial()
  end
  if text:find("dms") then
    local coordinates = coord:ToStringLLDMS()
    BCC:MessageToAll("Lat Long Request Recived for DMS LL is: ",30,"GPS UNIT")
    BCC:MessageToAll(coordinates,30,"GPS UNIT")
  elseif text:find("mgrs") then
    local coordinates = coord:ToStringMGRS()
    BCC:MessageToAll("Lat Long Request Recived for MGRS LL is: ".. coordinates,30,"GPS UNIT")
  elseif text:find("dd") then
    local coordinates = coord:ToStringLLDDM()
    BCC:MessageToAll("Lat Long Request Recived for DDM LL is: ".. coordinates,30,"GPS UNIT")
  elseif text:find("be") then
    local bullscoord = coalition.getMainRefPoint(coalition.side.BLUE)
    BASE:E({bullscoord})
    local bullscoord = coord:NewFromVec3(bullscoord)
    local coordinates = coord:ToStringBULLS(coalition.side.BLUE,_SETTINGS)
    BCC:MessageToAll("Lat Long Request Recived for BE POSIT is: ".. coordinates,30,"GPS UNIT")
  else
    local coordinates = coord:ToStringLLDMS(_SETTINGS)
    BCC:MessageToAll("LL Position Request, No type given Giving ALL",30,"GPS UNIT")
    BCC:MessageToAll("Lat Long Request Recived for DMS LL is: ".. coordinates,30,"GPS UNIT")
    coordinates = coord:ToStringMGRS(_SETTINGS)
    BCC:MessageToAll("Lat Long Request Recived for MGRS LL is: ".. coordinates,30,"GPS UNIT")
    coordinates = coord:ToStringLLDDM(_SETTINGS)
    BCC:MessageToAll("Lat Long Request Recived for DDM LL is: ".. coordinates,30,"GPS UNIT")
    coordinates = coord:ToStringBULLS(coalition.side.BLUE,_SETTINGS)
    BCC:MessageToAll("Lat Long Request Recived for BE POSIT is: ".. coordinates,30,"GPS UNIT")
  end

end
function handle9lrequest(text,coord)
  local keywords=_split(text, ",")
  BASE:E({keywords=keywords})
  linenumber = 0
  line10 = ""
   do
      _SETTINGS:SetImperial()
  end
  line6 = "Target Location: \n DMS: " .. coord:ToStringLLDMS() .. "\n DDLL: " ..coord:ToStringLLDDM() .. "\n MGRS: " .. coord:ToStringMGRS()
  line4 = "Target elevaton: " .. coord:GetLandHeight() .. "Meters | " .. UTILS.MetersToFeet(coord:GetLandHeight()) .. "FT MSL"
  for _,keyphrase in pairs(keywords) do
    if linenumber == 1 then
      line0 = "Callsign: " .. keyphrase 
    elseif linenumber == 2 then
      line1 = "IP/BP: " .. keyphrase
    elseif linenumber == 3 then
      line2 = "Heading: " .. keyphrase
    elseif linenumber == 4 then
      line3 = "Distance: " .. keyphrase .. "NM"
    elseif linenumber == 5 then
      line5 = "Target Description ".. keyphrase
    elseif linenumber == 6 then  
      line7 = "Mark: " .. keyphrase
    elseif linenumber == 7 then 
      line7 = line7 .. " Code: " .. keyphrase
    elseif linenumber == 8 then 
      line8 = "Friendlies: ".. keyphrase
    elseif linenumber == 9 then
      line9 = "Egress: " .. keyphrase
    elseif linenumber == 10 then
      line10 = "Comments: " .. keyphrase
    else
      line10 = line10 .. "\n" .. keyphrase
    end
    linenumber = linenumber + 1
  end
  BCC:MessageToBlue("JTAC DATA DUMP",60,"DATANET")
  BCC:MessageToBlue(line0 .. "\n 1." .. line1 .. "\n 2." .. line2 .. "\n 3." .. line3 .. "\n 4." .. line4 .. "\n 5." .. line5 .. "\n 6." .. line6 .. "\n 7." .. line7 .. "\n 8.".. line8 .. "\n 9." ..line9 .."\n Remarks: ".. line10,120,"DATANET")
  BASE:E("JTAC DUMP")
  BASE:E({line0,line1,line2,line3,line4,line5,line6,line7,line8,line9,line10})
end

--- @param #EVENT self
-- @param #EVENTDATA Event
function RmarkRemoved(Event,EC)
    if Event.text~=nil and Event.text:lower():find("-") then 
      
        local text = Event.text:lower()
        local text2 = Event.text
        local vec3={y=Event.pos.y, x=Event.pos.x, z=Event.pos.z}
        local coord = COORDINATE:NewFromVec3(vec3)
        coord.y = coord:GetLandHeight()
        if Event.text:lower():find("-weather") then
            if EC == 2 then
              handleWeatherRequest(text, coord,false)
            else
              handleWeatherRequest(text, coord,true)
            end
        elseif Event.text:lower():find("-respawn") then
          handleRespawnRequest(text2,coord)
        elseif Event.text:lower():find("-destroy") then
          handleDestroyRequest(text2,coord)
        elseif Event.text:lower():find("-ll") then
          -- findbyid(Event.initiator)
          handleLLRequest(text,coord)
        elseif Event.text:lower():find("-9l") then
         handle9lrequest(text,coord)
        end
    end
   
end


function SupportHandler:onEvent(Event)
    if Event.id == world.event.S_EVENT_MARK_ADDED then
        env.info(string.format("Support got event ADDED id %s idx %s coalition %s group %s text %s",Event.id, Event.idx, Event.coalition, Event.groupID, Event.text))
    elseif Event.id == world.event.S_EVENT_MARK_CHANGE then
        -- nothing atm
    elseif Event.id == world.event.S_EVENT_MARK_REMOVED then
         env.info(string.format("Support got event ADDED id %s idx %s coalition %s group %s text %s", Event.id, Event.idx, Event.coalition, Event.groupID, Event.text))
        RmarkRemoved(Event,Event.coalition)
    end
end

world.addEventHandler(SupportHandler)