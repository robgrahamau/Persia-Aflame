TANKER_COOLDOWN = (15)*60
TEX_Timer = 0
TEX2_Timer = 0
ARC_Timer = 0
ARC2_Timer = 0
 function AI_A2A_DISPATCHER:GetSquadronAmount(SquadronName)
    DefenderSquadron = self:GetSquadron( SquadronName )
        self:E( { Squadron = SquadronName, SquadronResourceCount = DefenderSquadron.ResourceCount, SquadronDetails = DefenderSquadron } )
    return DefenderSquadron.ResourceCount 
  end
  
  
BAS = ZONE_POLYGON:NewFromGroupName("AS1")
CV1_CAP = ZONE_POLYGON:NewFromGroupName("CV1_CAP")
CV2_CAP = ZONE_POLYGON:NewFromGroupName("CV2_CAP")
T_CAP = ZONE_POLYGON:NewFromGroupName("T_CAP") 
BZ1 = ZONE:New("BZ1")
BZ2 = ZONE:New("BZ2")
BZ3 = ZONE:New("BZ3")
BZ4 = ZONE:New("BZ4")
TX = ZONE:New("TexacoAnchor")
TC = TX:GetCoordinate()
ar = ZONE:New("rf")
ac = ar:GetCoordinate()

tddy = UNIT:FindByName("TeddyR")



do
--[[Texaco11 = GROUP:FindByName("Texaco 11")
Texaco11Spawn = SPAWN:New("Texaco 11"):InitLimit(1,18):OnSpawnGroup(function(spawngroup) 
  Texaco = spawngroup
end,{}):InitRepeatOnLanding():InitCleanUp(600):SpawnScheduled(600,0.5)
Texaco21 = GROUP:FindByName("Texaco 21")
Texaco21Spawn = SPAWN:New("Texaco 21"):InitLimit(1,18):OnSpawnGroup(function(spawngroup) 
  Texaco21 = spawngroup
end,{}):InitRepeatOnLanding():InitCleanUp(600):SpawnScheduled(600,0.5)
Arco11 = GROUP:FindByName("Arco 11")
Arco11Spawn = SPAWN:New("Arco 11"):InitLimit(1,18):OnSpawnGroup(function(spawngroup) 
  Arco11 = spawngroup
end,{}):InitRepeatOnLanding():InitCleanUp(600):SpawnScheduled(600,0.5)
Shell21 = GROUP:FindByName("Shell21")
]]

Overlord = GROUP:FindByName("USEW Overlord")
OverlordSpawn = SPAWN:NewWithAlias("USEW Overlord","USEW Overlord11"):OnSpawnGroup(function(spawngroup) 
  Overlord = spawngroup
end,{}):InitRepeatOnLanding():InitLimit(1,18):InitCleanUp(600):SpawnScheduled(600,0.5)

end

ARW100 = SQUADRON:New("Texaco 11",4,"100th ARW")
ARW100:SetSkill(AI.Skill.EXCELLENT)
ARW100:SetRadio(261)
ARW100:SetCallsign(CALLSIGN.Tanker.Texaco,1)
ARW100:AddMissonCapability({AUFTRAG.Type.TANKER},100)
ARW100:SetEngagementRange(400)

ARW101 = SQUADRON:New("Arco 11",4,"101th ARW")
ARW101:SetSkill(AI.Skill.EXCELLENT)
ARW101:SetRadio(263)
ARW101:SetCallsign(CALLSIGN.Tanker.Arco,1)
ARW101:AddMissonCapability({AUFTRAG.Type.TANKER},100)
ARW101:SetEngagementRange(400)

ARW102 = SQUADRON:New("Texaco 21",4,"102th ARW")
ARW102:SetSkill(AI.Skill.EXCELLENT)
ARW102:SetRadio(267)
ARW102:SetCallsign(CALLSIGN.Tanker.Texaco,2)
ARW102:AddMissonCapability({AUFTRAG.Type.TANKER},100)
ARW102:SetEngagementRange(400)

U106 = SQUADRON:New("Israeli 106th",24,"Israeli 106th Sqn") -- F15
U106:SetSkill(AI.Skill.HIGH)
U106:SetRadio(251)
U106:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
U106:AddMissonCapability({AUFTRAG.Type.CAP},100)
U106:SetEngagementRange(200)

U251 = SQUADRON:New("US VFMA251",24,"US VFMA251") -- f18
U251:SetSkill(AI.Skill.HIGH)
U251:SetRadio(251)
U251:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
U251:AddMissonCapability({AUFTRAG.Type.CAP},100)
U251:SetEngagementRange(200)

U22 = SQUADRON:New("US 22nd",24,"US 22nd") -- f18
U22:SetSkill(AI.Skill.HIGH)
U22:SetRadio(251)
U22:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
U22:AddMissonCapability({AUFTRAG.Type.CAP},100)
U22:SetEngagementRange(200)

U113 = SQUADRON:New("US VF113",24,"US VF113") -- f18
U113:SetSkill(AI.Skill.HIGH)
U113:SetRadio(251)
U113:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
U113:AddMissonCapability({AUFTRAG.Type.CAP},100)
U113:SetEngagementRange(200)

U122 = SQUADRON:New("US VFA122",24,"US VFA122") -- f18
U122:SetSkill(AI.Skill.HIGH)
U122:SetRadio(251)
U122:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
U122:AddMissonCapability({AUFTRAG.Type.CAP},100)
U122:SetEngagementRange(200)



AlD = AIRWING:New("Al Dhafra Warehouse","Al Dhafra Warehouse")
AlM = AIRWING:New("Al Minhad Warehouse","Al Minhad Warehouse")
Tdy = AIRWING:New("TeddyR","Carrier Group 5")
Wsh = AIRWING:New("Washington","Carrier Group 6")
AlD:SetReportOff()
AlM:SetReportOff()
Tdy:SetReportOff()
Wsh:SetReportOff()
AlM:AddSquadron(ARW100)
AlM:AddSquadron(ARW101)
AlD:AddSquadron(ARW102)
AlD:AddSquadron(U106)
AlD:AddSquadron(U251)
AlD:AddSquadron(U22)
Tdy:AddSquadron(U113)
Wsh:AddSquadron(U122)
AlD:NewPayload("T_F15",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
AlD:NewPayload("T_F16",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
AlD:NewPayload("T_Hornet1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
Tdy:NewPayload("T_Hornet1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
Wsh:NewPayload("T_Hornet2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
AlM:Start()
AlD:Start()
Tdy:Start()
Wsh:Start()

BCarrierTEMP = {"T_Hornet1","T_Hornet2"}
BLandTemp = {"T_F15","T_F16"}

 BASE:E({"New Scripts was false using A2ADispatcher"})
  BAS = ZONE_POLYGON:New("RAS",GROUP:FindByName("RAS"))
  blooksee = SET_GROUP:New():FilterCoalitions("blue"):FilterActive():FilterStart()
  local BlueAgentSet = blooksee
  local CIA = INTEL:New(BlueAgentSet,coalition.side.BLUE)
  local TdyInt = INTEL:New(BlueAgentSet,coalition.side.BLUE)
  local WshInt = INTEL:New(BlueAgentSet,coalition.side.BLUE)
  TdyInt:AddAcceptZone(BZ4)
  WshInt:AddAcceptZone(BZ3)
  CIA:AddAcceptZone(BAS)
  CIA:Start()
  TdyInt:Start()
  WshInt:Start()
  
  
  
  

function tankerc(lz,heading,altitude,speed,leg,refuel,airgroup,tcn,text,repeats,rdo,escort,escortab)
  BASE:E({"TANKER FRAG START FOR BLUE"})
  local tnkrfrag = AUFTRAG:NewTANKER(lz,altitude,speed,heading,leg,refuel)
  tnkrfrag:SetRadio(rdo)
  tnkrfrag:SetTACAN(tcn,text)
  airgroup:AddMission(tnkrfrag)
  function tnkrfrag:OnAfterStarted(From,Event,To)
    if escort == true then
      for _,flightgroup in pairs(tnkrfrag:GetOpsGroups()) do
        local escort = AUFTRAG:NewESCORT(flightgroup:GetGroup(), {x=500, y=0, z=-50},UTILS.NMToMeters(40),{"Air"})
        escort:SetEngageRange(40)
        escortab:AddMission(escort)  
      end
    end
  end
  return tnkrfrag
end  
  

SCHEDULER:New(nil,function() 
BASE:E({"Should be running scheduler for AWACS etc"})
  tanker1 = tankerc(TC,270,16000,370,50,1,AlM,4,"TX1",4,261,true,AlD)
  tanker2 = tankerc(ac,270,16000,370,50,0,AlM,8,"ARC",4,263,true,Wsh)
  tanker3 = tankerc(tddy:GetCoordinate(),tddy:GetHeading(),16000,370,25,1,AlD,17,"TKR",4,267,true,AlD)  
end,{},30,10800)  

SCHEDULER:New(nil,function()
    BASE:E({"CAP FRAG START FOR BLUE"})
    local capzone = T_CAP
    local ccz = BZ1
    uscapfrag1 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    uscapfrag1:SetRequiredAssets(math.random(1,2))
    uscapfrag1:SetEngageAltitude(math.random(10000,25000))
    AlD:AddMission(uscapfrag1)
end,{},30,3600,0.25)

SCHEDULER:New(nil,function()
    BASE:E({"CAP FRAG START FOR BLUE"})
    local capzone = T_CAP
    local ccz = BZ2
    uscapfrag2 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    uscapfrag2:SetRequiredAssets(math.random(1,2))
    uscapfrag2:SetEngageAltitude(math.random(10000,25000))
    AlD:AddMission(uscapfrag2)
end,{},30,3600,0.25)

function TdyInt:OnAfterNewContact(From, Event, To, Contact)
  local contact=Contact --Ops.Intelligence#INTEL.Contact
  local target = GROUP:FindByName(contact.groupname)
  if (contact.attribute == "Air_Bomber") or (contact.attribute == "Air_Fighter") or (contact.attribute == GROUP.Attribute.AIR_AWACS) or (contact.attribute == "Air_Other") or (contact.attribute == "Air_OtherAir") then
    -- we need to work out what airbase is the closest to the contact so we can vector the correct intercept group
    local frag = AUFTRAG:NewINTERCEPT(target)
    Tdy:AddMission(frag)
  end  

end

function WshInt:OnAfterNewContact(From, Event, To, Contact)
  local contact=Contact --Ops.Intelligence#INTEL.Contact
  local target = GROUP:FindByName(contact.groupname)
    if (contact.attribute == "Air_Bomber") or (contact.attribute == "Air_Fighter") or (contact.attribute == GROUP.Attribute.AIR_AWACS) or (contact.attribute == "Air_Other") or (contact.attribute == "Air_OtherAir") then
    -- we need to work out what airbase is the closest to the contact so we can vector the correct intercept group
    local frag = AUFTRAG:NewINTERCEPT(target)
    Wsh:AddMission(frag)
  end  
  
end
  

function CIA:OnAfterNewContact(From, Event, To, Contact)
  BASE:E({"Contact Detected"})
  local contact=Contact --Ops.Intelligence#INTEL.Contact
  local target = GROUP:FindByName(contact.groupname)
  if (contact.attribute == "Air_Bomber") or (contact.attribute == "Air_Fighter") or (contact.attribute == GROUP.Attribute.AIR_AWACS) or (contact.attribute == "Air_Other") or (contact.attribute == "Air_OtherAir") then
    -- we need to work out what airbase is the closest to the contact so we can vector the correct intercept group
    local frag = AUFTRAG:NewINTERCEPT(target)
    AlD:AddMission(frag)
  end  
end --end OnAfterNew


--[[
ADZZONES = SET_ZONE:New()
ADZZONES:AddZone(Z_SADZ)
ADZZONES:AddZone(Z_KADZ)
MADZ:SetAcceptZones(ADZZONES)
IAA:AddAcceptZone(Z_RAS)
IAA:Start()
MADZ:Start()
  ba2disp = AI_A2A_DISPATCHER:New(bdet)
  ba2disp:SetBorderZone(BAS)
  ba2disp:SetDefaultFuelThreshold(0.4)
  ba2disp:SetDefaultGrouping(2)
  ba2disp:SetDefaultOverhead(1.0)
  ba2disp:SetSquadron("Stennis","Washington",BCarrierTEMP,12)
  ba2disp:SetSquadron("TeddyR","TeddyR",BCarrierTEMP,12)
  ba2disp:SetSquadronTakeoffFromParkingCold("TeddyR")
  ba2disp:SetSquadronLandingAtRunway("TeddyR")
  ba2disp:SetSquadron("Al Draf",AIRBASE.PersianGulf.Al_Dhafra_AB,BLandTemp,32)
  ba2disp:SetEngageRadius(UTILS.NMToMeters(60))
  ba2disp:SetDisengageRadius(UTILS.NMToMeters(120))
  ba2disp:SetGciRadius(UTILS.NMToMeters(60))
  ba2disp:SetDefaultTakeoffFromParkingHot()
  ba2disp:SetDefaultLandingAtEngineShutdown()
  ba2disp:SetSquadronCap("Stennis",CV2_CAP,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(40000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ba2disp:SetSquadronCapInterval("Stennis",1,(60*15),(60*45),1.0)
  ba2disp:SetSquadronLandingAtRunway("Stennis")
  ba2disp:SetSquadronTakeoffFromRunway("Stennis")
  ba2disp:SetSquadronGci("Stennis",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ba2disp:SetSquadronCap("TeddyR",CV1_CAP,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(40000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ba2disp:SetSquadronCapInterval("TeddyR",1,(60*15),(60*45),1.0)
  ba2disp:SetSquadronGci("TeddyR",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ba2disp:SetSquadronCap("Al Draf",T_CAP,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(40000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ba2disp:SetSquadronCapInterval("Al Draf",2,(60*15),(60*45),1.0)
  ba2disp:SetSquadronGci("Al Draf",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ba2disp:__Start(30)
 ]]