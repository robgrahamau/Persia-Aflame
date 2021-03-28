

 function AI_A2A_DISPATCHER:GetSquadronAmount(SquadronName)
    DefenderSquadron = self:GetSquadron( SquadronName )
        self:F( { Squadron = SquadronName, SquadronResourceCount = DefenderSquadron.ResourceCount, SquadronDetails = DefenderSquadron } )
    return DefenderSquadron.ResourceCount 
  end

RAWACS2 = SPAWN:New("AWAC Overlord21"):InitKeepUnitNames(true):InitLimit(1,4):InitCleanUp(600):OnSpawnGroup(function(spawngroup) 
trawac = spawngroup 
tunit = trawac:GetUnit(1)
BASE:E({"respawned RAWACS2 unit name is:",tunit:GetName()})
hm("> Darkstar Stalin's Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
end,{}):InitRepeatOnLanding():SpawnScheduled(1800,0.5)

RAWACS = SPAWN:New("AWAC Overlord11"):InitKeepUnitNames(true):InitLimit(1,4):InitCleanUp(600):OnSpawnGroup(function(spawngroup) 
trawac = spawngroup 
tunit = trawac:GetUnit(1)
BASE:E({"respawned RAWACS unit name is:",tunit:GetName()})
hm("> Overlord Stalin's Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
end,{}):InitRepeatOnLanding():SpawnScheduled(1800,0.5)
TANKER = SPAWN:New("Texaco11"):InitLimit(1,4):InitCleanUp(600):InitRepeatOnLanding():SpawnScheduled(1800,0.5)
rlooksee = SET_GROUP:New():FilterPrefixes({"REW","RSAM","RAWAC"}):FilterCoalitions("red"):FilterActive():FilterStart()
do
capzone1 = ZONE_POLYGON:New("CAP1",GROUP:FindByName("CAP1"))
capzone2 = ZONE_POLYGON:New("CAP2",GROUP:FindByName("CAP2")) 
capzone3 = ZONE_POLYGON:New("CAP3",GROUP:FindByName("CAP3")) 
capzone4 = ZONE_POLYGON:New("CAP4",GROUP:FindByName("CAP4")) 
capzone5 = ZONE_POLYGON:New("CAP5",GROUP:FindByName("CAP5"))
capzone6 = ZONE_POLYGON:New("CAP6",GROUP:FindByName("CAP6")) 
capzone7 = ZONE_POLYGON:New("CAP7",GROUP:FindByName("CAP7"))
capzonecow = ZONE_POLYGON:NewFromGroupName("Cow_AS")
end
if usenew == true then
  BASE:E({"ADS Using New Scripts"})
else
  do 
  BASE:E({"New Scripts was false using A2ADispatcher"})
  RAS = ZONE_POLYGON:New("RAS",GROUP:FindByName("RAS"))
  rdet = DETECTION_AREAS:New(rlooksee,45000)
  ra2disp = AI_A2A_DISPATCHER:New(rdet)
  ra2disp:SetBorderZone(RAS)
  ra2disp:SetDefaultFuelThreshold(0.4)
  ra2disp:SetDefaultGrouping(2)
  ra2disp:SetDefaultOverhead(0.5)
  ra2disp:SetSquadron("Shiraz",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},16)
  ra2disp:SetSquadron("Shiraz1",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},16)
  ra2disp:SetSquadron("Shiraz2",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F5_2","MIG29_2"},16)
  ra2disp:SetSquadron("Shiraz INT",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F4_2"},12)
  ra2disp:SetSquadron("Kerman",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},16)
  ra2disp:SetSquadron("Kerman1",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},16)
  ra2disp:SetSquadron("Kerman2",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","M2000_1"},16)
  ra2disp:SetSquadron("Kerman INT",AIRBASE.PersianGulf.Kerman_Airport,{"MIG21_1","MIG21_2"},12)
  ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},16)
  ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},16)
  ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},12)
  ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},8)
  ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},8)
  ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},12)
  ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},24)
  ra2disp:SetSquadron("Kuznetsov INT","Kuznetsov",{"SU33_1","SU33_2"},24)
  ra2disp:SetSquadronOverhead("Kish",0.75)
  ra2disp:SetSquadronOverhead("Lar",1.0)
  ra2disp:SetSquadronOverhead("Lar Int",0.5)
  ra2disp:SetSquadronOverhead("Shiraz INT",1.0)
  ra2disp:SetSquadronOverhead("Bandar Abbas INT",1.0)
  ra2disp:SetDefaultTanker("Texaco11")
  ra2disp:SetEngageRadius(UTILS.NMToMeters(100))
  ra2disp:SetDisengageRadius(UTILS.NMToMeters(250))
  ra2disp:SetGciRadius(UTILS.NMToMeters(120))
  ra2disp:SetDefaultTakeoffFromParkingHot()
  ra2disp:SetDefaultLandingAtEngineShutdown()
  ra2disp:SetSquadronTakeoffFromRunway("Kuznetsov INT")
  ra2disp:SetSquadronLandingAtRunway("Kuznetsov INT")
  ra2disp:SetSquadronLanguage("Kuznetsov INT","RU")
  ra2disp:SetSquadronGci("Kuznetsov INT",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ra2disp:SetSquadronCap("Shiraz",capzone1,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(33000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Shiraz",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronCap("Shiraz1",capzone4,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(33000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Shiraz",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronCap("Shiraz2",capzone2,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(33000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Shiraz2",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronGci("Shiraz INT",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ra2disp:SetSquadronGci("Lar Int",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ra2disp:SetSquadronCap("Kerman",capzone2,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(33000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Kerman",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronCap("Kerman1",capzone3,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(33000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Kerman1",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronCap("Kerman2",capzone6,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(33000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(500),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Kerman2",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronLandingAtRunway("Kerman")
  ra2disp:SetSquadronLandingAtRunway("Kerman INT")
  ra2disp:SetSquadronLandingAtRunway("Kerman2")
  ra2disp:SetSquadronGci("Kerman INT",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  
  ra2disp:SetSquadronCap("Kish",capzone5,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(32000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(450),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronGci("Kish INT",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ra2disp:SetSquadronCapInterval("Kish",1,(60*1),(60*15),1.0)
  
  ra2disp:SetSquadronCap("Bandar Abbas",capzone7,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(32000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(450),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Bandar Abbas",1,(60*1),(60*15),1.0)
  ra2disp:SetSquadronCap("Bandar Abbas 2",capzone6,UTILS.FeetToMeters(15000),UTILS.FeetToMeters(32000),UTILS.KnotsToKmph(350),UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(450),UTILS.KnotsToKmph(750),"BARO")
  ra2disp:SetSquadronCapInterval("Bandar Abbas 2",1,(60*1),(60*15),1.0)
  
  ra2disp:SetSquadronGci("Bandar Abbas INT",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))
  ra2disp:SetSquadronGci("Lar",UTILS.KnotsToKmph(550),UTILS.KnotsToKmph(800))

  ra2disp:__Start(30)
  
 end
   

end