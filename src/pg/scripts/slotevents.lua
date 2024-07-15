--- slotevents.lua
-- Last Updated: 21/01/2022
-- This handles events that run off whom owns what.. so we simply call it slot events.


BASE:E({"Blue stuff"})
do
_USKISH = nil
uskishcount = 0
uskishtotal = math.random(1,3)
_USQESHM = nil
usqeshmcount = 0
usqeshmtotal = math.random(1,3)
shellstopped = false
teddystopped = false

uskish = SPAWN:NewWithAlias("USKISHCAP","94th FS CAP"):InitCleanUp(600):InitRepeatOnEngineShutDown():OnSpawnGroup(function(spawngroup) 
  _USKISH = spawngroup
  uskishcount = uskishcount + 1
  hm("94th FS Cap launching to protect Kish")
end):InitRandomizeRoute(1,5,UTILS.NMToMeters(10),UTILS.FeetToMeters(4000))

usqeshm = SPAWN:NewWithAlias("USQESHMCAP","96th FS CAP"):InitCleanUp(600):InitRepeatOnEngineShutDown():OnSpawnGroup(function(spawngroup) 
  _USQESHM = spawngroup
  usqeshmcount = usqeshmcount + 1
  hm("96th FS Cap launching to protect Qeshm")
end):InitRandomizeRoute(1,5,UTILS.NMToMeters(10),UTILS.FeetToMeters(4000))

function blueqeshmcap()
  local ab  = AIRBASE:FindByName(AIRBASE.PersianGulf.Qeshm_Island)
  if ab:GetCoalition() == 2 then
    if _USQESHM == nil then
      usqeshm:Spawn()
    else
      if (_USQESHM:IsAlive() ~= true or _USQESHM:AllOnGround() == true) and (usqeshmcount < usqeshmtotal) then
        _USQESHM:Destroy()
        usqeshm:Spawn()
      end
    end
  end
end

function bluekishcap()
  local ab  = AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport)
  if ab:GetCoalition() == 2 then
    if _USKISH == nil then
      uskish:Spawn()
    else
      if (_USKISH:IsAlive() ~= true or _USKISH:AllOnGround() == true) and (uskishcount < uskishtotal) then
        _USKISH:Destroy()
        uskish:Spawn()
      end
    end
  end
end

function checkislands()
	local am = AIRBASE:FindByName(AIRBASE.PersianGulf["Abu_Musa_Island_Airport"])
	local si = AIRBASE:FindByName(AIRBASE.PersianGulf["Sirri_Island"])
	local tk = AIRBASE:FindByName(AIRBASE.PersianGulf["Tunb_Kochak"])
	local ta = AIRBASE:FindByName(AIRBASE.PersianGulf["Tunb_Island_AFB"])
	local qs = AIRBASE:FindByName(AIRBASE.PersianGulf["Qeshm_Island"])
	local abna = AIRBASE:FindByName(AIRBASE.PersianGulf["Sir_Abu_Nuayr"])
	
	if tk:GetCoalition() == 2 and ta:GetCoalition() == 2 and si:GetCoalition() == 2 and am:GetCoalition() == 2 then
	  if PeleliuSpawned == false then
		local _Peleliu = GROUP:FindByName("Peleliu"):Activate()
		PeleliuSpawned = true
		MESSAGE:New("USS Peleliu has been activated and is sailing north to Kish",30):ToBlue()
		hm("USS Peleliu is in the AO and activated")
	  end
	  --if qs:GetCoalition() == 2 then
		  if NassauSpawned == false then
			  local _Nassau = GROUP:FindByName("Nassau"):Activate()
			  NassauSpawned = true
			  MESSAGE:New("USS Nassau has been activated and is sailing north to Qeshm",30):ToBlue()
			  hm("USS Nassau is in the AO and activated")
		  end
	  --end
	end
end

SCHEDULER:New(nil,checkislands,{},60,60)



SCHEDULER:New(nil,function() 
  blueqeshmcap()
  bluekishcap()
end,{},(60 * (math.random(15,30) )),(60*60))

end

BASE:E({"RED STUFF"})
do
 BASE:E({"Initalising Sweeps"})
_DBCAS = nil
dbcascount = 0
dbcastotal = math.random(1,2)
_DBCAP1 = nil
dbcap1count = 0
dbcap1total = math.random(1,3)
_DBCAP2 = nil
dbcap2count = 0
dbcap2total = math.random(1,3)
_DBCAP3 = nil
dbcap3count = 0
dbcap3total = math.random(1,3)
mainlandsead = nil
mainlandescort = nil
mainlandcas = nil
islandsead = nil
islandescort = nil
islandcas = nil


dbcas = SPAWN:NewWithAlias("DB_CAS","DBCAS"):InitCleanUp(600):InitRepeatOnEngineShutDown():OnSpawnGroup(function(spawngroup) 
  _DBCAS = spawngroup
  dbcascount = dbcascount + 1
end):InitRandomizeRoute(1,5,UTILS.NMToMeters(10),UTILS.FeetToMeters(2000))


dbcap1 = SPAWN:NewWithAlias("DB_CAP1","DBC1"):InitCleanUp(600):InitRepeatOnEngineShutDown():OnSpawnGroup(function(spawngroup) 
  _DBCAP1 = spawngroup
  dbcap1count = dbcap1count + 1
end):InitRandomizeRoute(1,5,UTILS.NMToMeters(5),UTILS.FeetToMeters(2000))


dbcap2 = SPAWN:NewWithAlias("DB_CAP2","DBC2"):InitCleanUp(600):InitRepeatOnEngineShutDown():OnSpawnGroup(function(spawngroup) 
  _DBCAP2 = spawngroup
  dbcap2count = dbcap2count + 1
end):InitRandomizeRoute(1,5,UTILS.NMToMeters(5),UTILS.FeetToMeters(2000))


dbcap3 = SPAWN:NewWithAlias("DB_CAP3","DBC3"):InitCleanUp(600):InitRepeatOnEngineShutDown():OnSpawnGroup(function(spawngroup) 
  _DBCAP3 = spawngroup
  dbcap3count = dbcap3count + 1
end):InitRandomizeRoute(1,5,UTILS.NMToMeters(5),UTILS.FeetToMeters(2000))

BASE:E({"Initalising Scheduler"})

function spawnmainland()
  if _spawnnumber ~= _maxislandmainlandspawns then
  _spawnnumber = _spawnnumber + 1
  local _shiraz = AIRBASE:FindByName(AIRBASE.PersianGulf.Shiraz_Intl)
  local _kerman = AIRBASE:FindByName(AIRBASE.PersianGulf.Kerman)
  if _shiraz:GetCoalition() == 1 then
    if mainlandsead == nil then
      mainlandsead = SPAWN:NewWithAlias("MainlandSead","MSF_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
    else
      if mainlandsead:IsAlive() ~= true or mainlandsead:AllOnGround() == true then
        mainlandsead:Destroy()
        mainlandsead = SPAWN:NewWithAlias("MainlandSead","MSF_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
      end
    end
    if mainlandcas == nil then
      mainlandcas = SPAWN:NewWithAlias("MainlandCas","MCG_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
    else
    if mainlandcas:IsAlive() ~= true or mainlandcas:AllOnGround() == true then
      mainlandcas:Destroy()
      mainlandcas = SPAWN:NewWithAlias("MainlandCas","MCG_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
    end
  end
  if _kerman:GetCoalition() == 1 then
    if mainlandescort == nil then
      mainlandescort = SPAWN:NewWithAlias("MainLandCap","MCF_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
    else
      if mainlandescort:IsAlive() ~= true or mainlandescort:AllOnGround() == true then
        mainlandescort:Destroy()
        mainlandescort = SPAWN:NewWithAlias("MainLandCap","MCF_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
      end
    end
  end
  end
end

function spawnislands()
  if _spawnnumber ~= _maxislandmainlandspawns then
    local _shiraz = AIRBASE:FindByName(AIRBASE.PersianGulf.Shiraz_Intl)
    local _kerman = AIRBASE:FindByName(AIRBASE.PersianGulf.Kerman)
  _spawnnumber = _spawnnumber + 1
  if _shiraz:GetCoalition() == 1 then
    if islandsead == nil then
      islandsead = SPAWN:NewWithAlias("IslandSead","ISF_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
    else
      if islandsead:IsAlive() ~= true or islandsead:AllOnGround() == true then
        islandsead:Destroy()
        islandsead = SPAWN:NewWithAlias("IslandSead","ISF_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
      end
    end
    if islandcas == nil then
      islandcas = SPAWN:NewWithAlias("IslandCAS","ISC_" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):Spawn()
    else
      if islandcas:IsAlive() ~= true or islandcas:AllOnGround() == true then
        islandcas = SPAWN:NewWithAlias("IslandCAS","ISF" .. _spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):Spawn()
      end
    end
    if islandescort == nil then
      islandescort = SPAWN:NewWithAlias("IslandCAP","ISE_" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
    else
      if islandescort:IsAlive() ~= true or islandescort:AllOnGround() == true then
        islandescort = SPAWN:NewWithAlias("IslandCAP","CAPFLIGHT" .. _spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
      end
    end
  end
  end
end

SCHEDULER:New(nil,function() 
  BASE:E({"DB RED UNIT CHECKS"})
  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Island_AFB)
  if ab:GetCoalition() == 1 then
    if _DBCAS == nil then
      BASE:E({"_DBCAS was nil spawning"})
      dbcas:Spawn()
    else
      if ( _DBCAS:IsAlive() ~= true or _DBCAS:AllOnGround() == true) and (dbcascount < dbcastotal) then
        BASE:E({"DBCAS was not nil or all on ground",_DBCAS:IsAlive(),_DBCAS:AllOnGround(),dbcascount})
        _DBCAS:Destroy()
        dbcas:Spawn()
      end  
    end
  end

  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Qeshm_Island)
  if ab:GetCoalition() == 1 then
    if _DBCAP1 == nil then
      BASE:E({"_DBCAp1 was nil spawning"})
      dbcap1:Spawn()
    else
      if ( _DBCAP1:IsAlive() ~= true or _DBCAP1:AllOnGround() == true) and (dbcap1count < dbcap1total) then
        BASE:E({"DBCap1 was not nil or all on ground",_DBCAP1:IsAlive(),_DBCAP1:AllOnGround(),dbcap1count})
        _DBCAP1:Destroy()
        dbcap1:Spawn()
      end  
    end
  end

  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Ain_International_Airport)
  if ab:GetCoalition() == 1 then
    if _DBCAP2 == nil then
      BASE:E({"_DBCAP2 was nil spawning"})
      dbcap2:Spawn()
    else
      if ( _DBCAP2:IsAlive() ~= true or _DBCAP2:AllOnGround() == true) and (dbcap2count < dbcap2total) then
        BASE:E({"DBCAP2 was not nil or all on ground",_DBCAP2:IsAlive(),_DBCAP2:AllOnGround(),dbcap2count})
        _DBCAP2:Destroy()
        dbcap2:Spawn()
      end  
    end
    
    if _DBCAP3 == nil then
      BASE:E({"_DBCAP2 was nil spawning"})
      dbcap3:Spawn()
    else
      if ( _DBCAP3:IsAlive() ~= true or _DBCAP3:AllOnGround() == true) and (dbcap3count < dbcap3total) then
        BASE:E({"DBCAP3 was not nil or all on ground",_DBCAP3:IsAlive(),_DBCAP3:AllOnGround(),dbcap3count})
        _DBCAP3:Destroy()
        dbcap3:Spawn()
      end  
    end
  end
  local iss = math.random(1,100)
  local lowerchance = 25
  local upperchance = 50
  local chance_island = math.random(lowerchance,upperchance)
  BASE:E({"Checking for a sweep of the islands",iss,lowerchance,upperchance,chance_island})

  if iss > chance_island then
    spawnislands()
  end
  iss = math.random(1,100)
  iss = math.random(1,100)
  local lowerchance = 50
  local upperchance = 75
  local chance_mainland = math.random(lowerchance,upperchance)
  BASE:E({"Checking for a sweep of the mainland",iss,lowerchance,upperchance,chance_mainland})
  if iss > chance_mainland then
  spawnmainland()
  end
 end,{},(60*(math.random(15,60))),(60*60),0.75)

end





end