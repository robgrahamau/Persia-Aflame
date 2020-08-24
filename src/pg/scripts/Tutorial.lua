lastupdated = "6:05pm Saturday 16th Nov 2019"
version = "0.5"
env.info("PG Tutorial Mission")
env.info("Last Updated:" .. lastupdated .. "Version Number" .. version)
-- CONSTANTS --
BASE:E({"Mission Load In Start, Loading Constants"})
REDAIRSPACE = ZONE_POLYGON:New("Red Airspace",GROUP:FindByName("REDAS")) -- Create our Airspace Zone
REDCAP1 = ZONE_POLYGON:New("RED CAP1",GROUP:FindByName("REDCAP1")) -- setup our cap1
REDCAP2 = ZONE_POLYGON:New("RED CAP2",GROUP:FindByName("REDCAP2")) -- setup our cap2
REDTANKER = GROUP:FindByName("RSHELL11")
BLUEAWAC = GROUP:FindByName("Overlord")
BLUEAWACSPAWN = nil
BLUETEXACO = GROUP:FindByName("Texaco11")
BLUETEXACOSPAWN = nil
BLUESHELL = GROUP:FindByName("Shell11")
BLUESHELLSPAWN = nil
BLUEARCO = GROUP:FindByName("Arco11")
BLUEARCOSPAWN = nil
REDAWAC = GROUP:FindByName("RED AWAC Overlord")
IRANCAPMIN = (60*5)
IRANCAPMAX = (60*30)
REDSAMTEMPLATES = {"SAM_TEMPLATE_SA11","SAM_TEMPLATE_SA10","SAM_TEMPLATE_HAWK"}
-- END CONSTANTS --
BASE:E({"Mission Load In Start, RED CAP Air Craft"})


-- RED AI CAP CODE -- 
do
-- Set up Red Dection Groups for AWCS and Radar
REDDetSetGroup = SET_GROUP:New()
REDDetSetGroup:FilterPrefixes({"RED AWAC","RED RADAR"})
REDDetSetGroup:FilterStart()
-- Set up our Detection Area grid for the Dispatcher.

REDDet = DETECTION_AREAS:New(REDDetSetGroup,UTILS.NMToMeters(20))

-- lets created our dispatcher
REDA2ADisp = AI_A2A_DISPATCHER:New(REDDet)

-- Lets create our Settings and Zones for Dispatcher
REDA2ADisp:SetBorderZone(REDAIRSPACE)
REDA2ADisp:SetEngageRadius(UTILS.NMToMeters(50))
REDA2ADisp:SetDefaultDamageThreshold(0.4)
REDA2ADisp:SetDefaultFuelThreshold(0.4)
REDA2ADisp:SetDefaultTanker(REDTANKER:GetName())
REDA2ADisp:SetDefaultGrouping(2)
REDA2ADisp:SetDefaultLandingAtRunway()
REDA2ADisp:SetDefaultTakeoffFromRunway()
-- Western Defence Sqn Setup
REDA2ADisp:SetSquadron("Western Defence Sqn",AIRBASE.PersianGulf.Shiraz_International_Airport,{"IRAN_F14_TEMPLATE","IRAN_MIG29A_TEMPLATE"},14)
REDA2ADisp:SetSquadronCap("Western Defence Sqn",REDCAP1,UTILS.FeetToMeters(18000),UTILS.FeetToMeters(32000),UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437),UTILS.KnotsToKmph(400),UTILS.KnotsToKmph(600),"BARO")
REDA2ADisp:SetSquadronCapInterval("Western Defence Sqn",2,IRANCAPMIN ,IRANCAPMAX,1.0)
REDA2ADisp:SetSquadronOverhead("Western Defence Sqn",1.5)
-- Northern Defence Sqn Setup
REDA2ADisp:SetSquadron("Northern Defence Sqn",AIRBASE.PersianGulf.Kerman_Airport,{"IRAN_F14_TEMPLATE","IRAN_MIG29A_TEMPLATE","IRAN_MIG29A_TEMPLATE_2","IRAN_F4_TEMPLATE"},14)
REDA2ADisp:SetSquadronCap("Northern Defence Sqn",REDCAP2,UTILS.FeetToMeters(18000),UTILS.FeetToMeters(32000),UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437),UTILS.KnotsToKmph(400),UTILS.KnotsToKmph(600),"BARO")
REDA2ADisp:SetSquadronCapInterval("Northern Defence Sqn",2,IRANCAPMIN ,IRANCAPMAX,1.0)
REDA2ADisp:SetSquadronOverhead("Northern Defence Sqn",1.5)
-- BANDAR SQN Setup
REDA2ADisp:SetSquadron("BANDAR Defence Sqn",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"IRAN_MIG29A_TEMPLATE","IRAN_MIG29A_TEMPLATE_2"},12)
REDA2ADisp:SetSquadronCap("BANDAR Defence Sqn",REDCAP1,UTILS.FeetToMeters(18000),UTILS.FeetToMeters(32000),UTILS.KnotsToKmph(409),UTILS.KnotsToKmph(437),UTILS.KnotsToKmph(400),UTILS.KnotsToKmph(600),"BARO")
REDA2ADisp:SetSquadronCapInterval("BANDAR Defence Sqn",2,IRANCAPMIN ,IRANCAPMAX,1.0)
REDA2ADisp:SetSquadronOverhead("BANDAR Defence Sqn",1.5)
REDA2ADisp:SetSquadronVisible("BANDAR Defence Sqn")
-- BANDAR SQN GCI
REDA2ADisp:SetGciRadius(UTILS.NMToMeters(80))
REDA2ADisp:SetSquadronGci("BANDAR Defence Sqn",UTILS.KnotsToKmph(400),UTILS.KnotsToKmph(600))
-- Khasab
REDA2ADisp:SetSquadron("Khasab Rapid",AIRBASE.PersianGulf.Khasab,{"IRAN_MIG29A_TEMPLATE","IRAN_MIG29A_TEMPLATE_2"},6)
REDA2ADisp:SetSquadronOverhead("Khasab Rapid",1.0)
REDA2ADisp:SetSquadronGci("Khasab Rapid",UTILS.KnotsToKmph(400),UTILS.KnotsToKmph(600))
REDA2ADisp:SetSquadronTakeoffFromParkingHot("Khasab Rapid")
REDA2ADisp:SetSquadronLandingAtEngineShutdown("Khasab Rapid")
REDA2ADisp:SetSquadronVisible("Khasab Rapid")
end

BASE:E({"Mission Load In Start, Done With RED CAP"})
-- Supports Spawning
do
BAWACSPAWN = SPAWN:New("Overlord"):InitCleanUp(300):InitRepeatOnEngineShutDown():OnSpawnGroup(function(SpawnGroup) 
  if BLUEAWAC:IsAlive() == true then
    BLUEAWAC:Destroy()
  end
  BLUEAWAC = SpawnGroup
  SpawnGroup:HandleEvent(EVENTS.Hit)
  SpawnGroup:HandleEvent(EVENTS.Dead)
  SpawnGroup:HandleEvent(EVENTS.Land)
  ---@param self
  -- @param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventDead(EventData)
    EventData.IniGroup:MessageToAll("Mayday, Mayday, Mayday Overlord is going down",15,"Going Down")
    respawnGROUP(BAWACSPAWN)
  end
  
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventLand(EventData)
    EventData.IniGroup:MessageToAll("Landed",10,"Landed")
  end
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventHit(EventData)
    EventData.IniGroup:MessageToBlue("Mayday, Mayday, Mayday, Overlord is underfire",15,"Under Fire")
  end
  
  BLUEAWAC:MessageToBlue("Overlord is Rolling from Home Plate",15,"Taking off")
 end)
 
-- function that calls a spawn object 5 seconds after function call.
function respawnGROUP(ourgroup)
  SCHEDULER:New(nil,function() 
    ourgroup:Spawn()
  end,{},5)
end
-- AWAC DONE
BTEXACOSPAWN = SPAWN:New("Texaco11"):InitCleanUp(300):InitRepeatOnEngineShutDown():OnSpawnGroup(function(SpawnGroup) 
  if BLUETEXACO:IsAlive() == true then
   BLUETEXACO:Destroy()
  end
  BLUETEXACO = SpawnGroup
  SpawnGroup:HandleEvent(EVENTS.Hit)
  SpawnGroup:HandleEvent(EVENTS.Dead)
  SpawnGroup:HandleEvent(EVENTS.Land)
  ---@param self
  -- @param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventDead(EventData)
    EventData.IniGroup:MessageToAll("Mayday, Mayday, Mayday Texaco11 is going down",15,"Going Down")
    respawnGROUP(BTEXACOSPAWN)
  end
  
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventLand(EventData)
    EventData.IniGroup:MessageToAll("Landed",10,"Landed")
  end
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventHit(EventData)
    EventData.IniGroup:MessageToBlue("Mayday, Mayday, Mayday, Texaco11 is underfire",15,"Under Fire")
  end
  
  BLUETEXACO:MessageToBlue("Texaco11 is Rolling from Home Plate",15,"Taking off")
 end)
 
 BARCOSPAWN = SPAWN:New("Arco11"):InitCleanUp(300):InitRepeatOnEngineShutDown():OnSpawnGroup(function(SpawnGroup) 
  if BLUEARCO:IsAlive() == true then
   BLUEARCO:Destroy()
  end
  BLUEARCO = SpawnGroup
  SpawnGroup:HandleEvent(EVENTS.Hit)
  SpawnGroup:HandleEvent(EVENTS.Dead)
  SpawnGroup:HandleEvent(EVENTS.Land)
  ---@param self
  -- @param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventDead(EventData)
    EventData.IniGroup:MessageToAll("Mayday, Mayday, Mayday ARCO11 is going down",15,"Going Down")
    respawnGROUP(BARCOSPAWN)
  end
  
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventLand(EventData)
    EventData.IniGroup:MessageToAll("Landed",10,"Landed")
  end
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventHit(EventData)
    EventData.IniGroup:MessageToBlue("Mayday, Mayday, Mayday, ARCO11 is underfire",15,"Under Fire")
  end
  
  SpawnGroup:MessageToBlue("ARCO11 is Rolling from Home Plate",15,"Taking off")
 end)
 
 BSHELLSPAWN = SPAWN:New("Shell11"):InitCleanUp(300):InitRepeatOnEngineShutDown():OnSpawnGroup(function(SpawnGroup) 
  if BLUESHELL:IsAlive() == true then
   BLUESHELL:Destroy()
  end
  BLUESHELL = SpawnGroup
  SpawnGroup:HandleEvent(EVENTS.Hit)
  SpawnGroup:HandleEvent(EVENTS.Dead)
  SpawnGroup:HandleEvent(EVENTS.Land)
  ---@param self
  -- @param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventDead(EventData)
    EventData.IniGroup:MessageToAll("Mayday, Mayday, Mayday SHELL11 is going down",15,"Going Down")
    respawnGROUP(BSHELLSPAWN)
  end
  
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventLand(EventData)
    EventData.IniGroup:MessageToAll("Landed",10,"Landed")
  end
  ---@param self
  --@param Core.Event#EVENTDATA EventData
  function SpawnGroup:OnEventHit(EventData)
    EventData.IniGroup:MessageToBlue("Mayday, Mayday, Mayday, SHELL11 is underfire",15,"Under Fire")
  end
  
  SpawnGroup:MessageToBlue("SHELL11 is Rolling from Home Plate",15,"Taking off")
 end)
 
 BASE:E("SPAWNING SUPPORTS")
 BAWACSPAWN:Spawn()
 BARCOSPAWN:Spawn()
 BTEXACOSPAWN:Spawn()
 BSHELLSPAWN:Spawn()
 
end
-- RED SAM SPAWNING
do
  REDSAM1 = SPAWN:New("RSAM_SPAWN1"):InitRandomizeTemplatePrefixes(REDSAMTEMPLATES):InitRandomizeUnits(true,1000,50):Spawn()
  REDSAM2 = SPAWN:New("RSAM_SPAWN2"):InitRandomizeTemplatePrefixes(REDSAMTEMPLATES):InitRandomizeUnits(true,1000,50):Spawn()
  REDSAM3 = SPAWN:New("RSAM_SPAWN3"):InitRandomizeTemplatePrefixes(REDSAMTEMPLATES):InitRandomizeUnits(true,1000,50):Spawn()
  REDSAM4 = SPAWN:New("RSAM_SPAWN4"):InitRandomizeTemplatePrefixes(REDSAMTEMPLATES):InitRandomizeUnits(true,1000,50):Spawn()
  REDSAM5 = SPAWN:New("RSAM_SPAWN5"):InitRandomizeTemplatePrefixes(REDSAMTEMPLATES):InitRandomizeUnits(true,1000,50):Spawn()
  REDSAM6 = SPAWN:New("RSAM_SPAWN6"):InitRandomizeTemplatePrefixes(REDSAMTEMPLATES):InitRandomizeUnits(true,1000,50):Spawn()
  
end


do
IRAN9THARMORED = GROUP:FindByName("9th Armored Division")
IRAN9THARMORED1 = GROUP:FindByName("9th Armored Division #002")
IRANINF = GROUP:FindByName("3rd Infantry")
USRANGERVEHICLES = GROUP:FindByName("US Ranger")
EventHandler = EVENTHANDLER:New()
EventHandler:HandleEvent(EVENTS.Dead)
EventHandler:HandleEvent(EVENTS.BaseCaptured)

function checkninthalive()
  BASE:E({"Ninth CHECKER"})
  if IRAN9THARMORED1:IsAlive() ~= true then
      BASE:E({"Iran 9th 1 is dead"})
      local movetozone = ZONE:New("moveinftozone")
      local coord = movetozone:GetCoordinate()
      IRANINF:RouteGroundTo(coord,6,"Vee",30)
      movetozone = ZONE:New("rangerwaypoint1")
      coord = movetozone:GetCoordinate()
      USRANGERVEHICLES:RouteGroundOnRoad(coord,30,60,"Off Road")
      USRANGERVEHICLES:MessageToBlue("Ranger Ground Team is moving to Romeo Hold point",15,"Ranger Team One")
    end
end

function checkninthalive1()
  BASE:E({"IRAN 9th Second one cehcker"})
  if IRAN9THARMORED:IsAlive() ~= true then
    tigger.action.PushAITask(Group.getByName(RangerLift),1) -- pushes the first AI Push task to start.
    BCC:MessageToBlue("Ranger Strike Team is Starting up",15,"Coalition Command")
  end
end

 ---@param self
  --@param Core.Event#EVENTDATA EventData
function EventHandler:OnEventDead(EventData)
  BASE:E({"EVENT HANDLER WAS CALLED EVENT IniUnitName, IniGroupName",EventData.IniUnitName,EventData.IniGroupName})
  -- check what is sending the Event.
  BASE:E({"Iran 9th 1 event - IRAN9thArmored is alive",IRAN9THARMORED1:IsAlive()})
  if EventData.IniGroupName == IRAN9THARMORED1:GetName() then
    BASE:E({"Iran 9th 1 event - IRAN9thArmored is alive",IRAN9THARMORED1:IsAlive()})
    if IRAN9THARMORED1:IsAlive() == true then
      SCHEDULER:New(nil,checkninthalive,{},5)
    end
  end
  if EventData.IniGroupName == IRAN9THARMORED:GetName() then
    if IRAN9THARMORED:IsAlive() == true then
      SCHEDULER:New(nil,checkninthalive1,{},5)
    end
  end
  
end

 ---@param self
  --@param Core.Event#EVENTDATA EventData
function EventHandler:OnEventBaseCaptured(EventData)
  BASE:E({"Event For Base Capture has occured."})
  local AirbaseName = EventData.PlaceName -- get our airbase that was captured.
  local ABItem = AIRBASE:FindByName(AirbaseName) -- get our name.
  local coal = ABItem:GetCoalition() -- get us which coalition now controls the base.
  BASE:E({"BASE EVENT:",AirbaseName,ABItem,coal})
  if AirbaseName == AIRBASE.PersianGulf.Khasab then
    BASE:E({"BASE EVENT: Khasab"})
    -- if blue holds the airbase.
    if coal == 2 then
    BASE:E({"BASE EVENT: Khasab, Coalition 2 now holds, killing squadron"})   
      REDA2ADisp:SetSquadron("Khasab Rapid",AIRBASE.PersianGulf.Khasab,{"IRAN_MIG29A_TEMPLATE","IRAN_MIG29A_TEMPLATE_2"},0) -- kill the group by setting it to 0.
    end
  
  end

end

SCHEDULER:New(nil,function() 
  temp = GROUP:FindByName("Test unit")
  temp:Activate()
end,{},30)

end