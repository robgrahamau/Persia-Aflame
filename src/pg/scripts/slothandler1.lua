
env.info("Loading SRS stuff")

STTS = {}
-- FULL Path to the FOLDER containing DCS-SR-ExternalAudio.exe - EDIT TO CORRECT FOLDER
STTS.DIRECTORY = "E:\\DCS-SimpleRadio-Standalone"
STTS.SRS_PORT = 5002 -- LOCAL SRS PORT - DEFAULT IS 5002
-- DONT CHANGE THIS UNLESS YOU KNOW WHAT YOU'RE DOING
STTS.EXECUTABLE = "DCS-SR-ExternalAudio.exe"
spawned = {}

function STTS.TextToSpeech(message,freqs,modulations, volume,name, coalition )

    message = message:gsub("\"","\\\"")

    local cmd = string.format("start \"%s\" \"%s\\%s\" \"%s\" %s %s %s %s \"%s\" %s", STTS.DIRECTORY, STTS.DIRECTORY, STTS.EXECUTABLE, message, freqs, modulations, coalition,STTS.SRS_PORT, name, volume )

    os.execute(cmd)

end

function STTS.PlayMP3(pathToMP3,freqs,modulations, volume,name, coalition )

    local cmd = string.format("start \"%s\" \"%s\\%s\" \"%s\" %s %s %s %s \"%s\" %s", STTS.DIRECTORY, STTS.DIRECTORY, STTS.EXECUTABLE, pathToMP3, freqs, modulations, coalition,STTS.SRS_PORT, name, volume )

    os.execute(cmd)

end

env.info("Loadinged SRS stuff")

BASE:E({"SLOT HANDLER FOR PERSIA AFLAME LOADING"})
trigger.action.setUserFlag("SSB",100)
SEH = EVENTHANDLER:New()
SEH:HandleEvent(EVENTS.BaseCaptured)
stn = UNIT:FindByName("Stennis")
lh2 = UNIT:FindByName("LHA-2")
tdy = UNIT:FindByName("TeddyR")
tar = UNIT:FindByName("Tarawa")
GW = UNIT:FindByName("Washington")
lh3 = UNIT:FindByName("LHA-3")
lh4 = UNIT:FindByName("LHA-4")
bandaractive = false
kishactive = false
allowfobs = true
stn:HandleEvent(EVENTS.Dead)
lh2:HandleEvent(EVENTS.Dead)
tdy:HandleEvent(EVENTS.Dead)
tar:HandleEvent(EVENTS.Dead)
GW:HandleEvent(EVENTS.Dead)
lh3:HandleEvent(EVENTS.Dead)
lh4:HandleEvent(EVENTS.Dead)
am = AIRBASE:FindByName(AIRBASE.PersianGulf.Abu_Musa_Island_Airport)
si = AIRBASE:FindByName(AIRBASE.PersianGulf.Sirri_Island)
tk = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Kochak)
ta = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Island_AFB)


trigger.action.setUserFlag(100,0)
TunbRed = STATIC:FindByName("CTLD Tnub")
TunbBlue = STATIC:FindByName("CTLD Tnub B")

BandarRed = STATIC:FindByName("CTLD BandarFarp")
BandarBlue = STATIC:FindByName("CTLD BandarFarp B")
SirriRed = STATIC:FindByName("CTLD Sirri Island")
SirriBlue = STATIC:FindByName("CTLD Sirri Island B")
LavanRed = STATIC:FindByName("CTLD Lavin")
LavanBlue = STATIC:FindByName("CTLD Lavin B")
KhasabRed = STATIC:FindByName("CTLD AbuFarp B")
KhasabBlue = STATIC:FindByName("CTLD AbuFarp")
LarsRed = STATIC:FindByName("CTLD FLar")
LarsBlue = STATIC:FindByName("CTLD FLar B")
KishBlue = STATIC:FindByName("CTLD Kish B")
KishRed = STATIC:FindByName("CTLD Kish")
QeshmRed = STATIC:FindByName("CTLD Qeshm Island")
QeshmBlue = STATIC:FindByName("CTLD Qeshm Island B")
abunred = STATIC:FindByName("CTLD Abu Nuayr B")
abunblue = STATIC:FindByName("CTLD Abu Nuayr")
havred = STATIC:FindByName("CTLD BandarFarp D")
havblue = STATIC:FindByName("CTLD BandarFarp C")
havmsg = nil
abunmsg = nil
qemsg = nil
kimsg = nil
larmsg = nil
khmsg = nil
lmsg = nil
smsg = nil
banmsg = nil
tmsg = nil
fujmsg = nil
jirmsg = nil
ejaskmsg = nil
shiraz = nil
kerman = nil
blenmsg = nil
DubaiMsg = nil
defenders = {"Defenders","Defenders-1","GM_Infantry","GM_AAA"}
bandarspawn = false
tunbspawn = false
sirrispawn = false
lavanspawn = false
khasabspawn = false
larsspawn = false
kishspawn = false
qeshmspawn = false
abunspawn = false
havspawn = false
fujspawn = false
bandarlspawn = false
spawnnumber = 1
spawner = nil
spawner2 = nil
spawner3 = nil
spawner4 = nil
spawner5 = nil
spawner6 = nil
allowislands = true
allowmain = true

function spawnislands()
  if shiraz == false then
  if allowislands == true then
    spawnnumber = spawnnumber + 1
    if spawner == nil then
      spawner = SPAWN:NewWithAlias("IslandSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
	  hm("> DB1 SEDFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
    else
      if spawner:IsAlive() ~= true then
        spawner = SPAWN:NewWithAlias("IslandSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
		hm("> DB1 SEDFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
      end
    end
    if spawner2 == nil then
      spawner2 = SPAWN:NewWithAlias("IslandCAS","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):Spawn()
	  hm("> DB1 CASFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
    else
      if spawner2:IsAlive() ~= true then
        spawner2 = SPAWN:NewWithAlias("IslandCAS","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):Spawn()
		hm("> DB1 CASFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
      end
    end
    if spawner3 == nil then
      spawner3 = SPAWN:NewWithAlias("IslandCAP","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
	  hm("> DB1 CAPFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
    else
      if spawner3:IsAlive() ~= true then
        spawner3 = SPAWN:NewWithAlias("IslandCAP","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
		hm("> DB1 CAPFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
      end
    end
    allowislands = false
      SCHEDULER:New(nil,function() allowislands = true end,{},math.random(300,600))
  end
  end
end

function spawnmainland()
  if shiraz == false then
  if allowmain == true then
    spawnnumber = spawnnumber + 1
    if spawner4 == nil then
    spawner4 = SPAWN:NewWithAlias("QeshmSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
	hm("> DB2 SEADFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
  else
    if spawner4:IsAlive() ~= true then
      spawner4 = SPAWN:NewWithAlias("QeshmSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
	  hm("> DB2 SEADFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
    end
  end
  if spawner5 == nil then
    spawner5 = SPAWN:NewWithAlias("mainlandcap","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
	hm("> DB2 CAPFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
  
  else
    if spawner5:IsAlive() ~= true then
      spawner5 = SPAWN:NewWithAlias("mainlandcap","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):Spawn()
	  hm("> DB2 CAPFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")	
    end
  end
    if spawner6 == nil then
    spawner6 = SPAWN:NewWithAlias("ManlandCas","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()    
	hm("> DB2 CASFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
  else
    if spawner6:IsAlive() ~= true then
      spawner6 = SPAWN:NewWithAlias("ManlandCas","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()    
	  hm("> DB2 CASFLIGHT" .. spawnnumber .. " is prepping to take back from the invaders")
    end
  end
  end
  allowmain = false
  SCHEDULER:New(nil,function() allowmain = true end,{},math.random(300,600))
  end
end


spawned = {}
function spawndefenders(groupname)
  BASE:E({"SPAWNING DEFENDERS IF Loading == False",Loading,groupname})
  local canspawn = false
	if Loading == false then
		if groupname == "sirrispawn" and sirrispawn ~= true then
			canspawn = true
			sirrispawn = true
		end
		if groupname == "kishspawn" and kishspawn ~= true then
			canspawn = true
			kishspawn = true
		end
		if groupname == "qeshmspawn" and qeshmspawn ~= true then
			canspawn = true
			qeshmspawn = true
		end
		if groupname == "bandarspawn" and bandarspawn ~= true then
			canspawn = true
			bandarspawn = true
		end
		if groupname == "larspawn" and larsspawn ~= true then
			canspawn = true
			larsspawn = true
		end
		if groupname == "havspawn" and havspawn ~= true then
			canspawn = true
			havspawn = true
		end
		if groupname == "bandarlspawn" and bandarlspawn ~= true then
			canspawn = true
			bandarlspawn = true
		end
		if canspawn == true then
			local dspawner = SPAWN:NewWithAlias(groupname,"IAA defenders_" .. spawnnumber ..""):InitRandomizeTemplate(defenders):Spawn()
			spawnnumber = spawnnumber + 1
		end
	end
end


function randomform()
  local rndnum = math.random(1,7)
  BASE:E({"Random Form number is",rndnum})
  if rndnum == 1 then
    return "Off road"
  elseif rndnum == 2 then
    return "Line abreast"
  elseif rndnum == 3 then
    return "Cone"
  elseif rndnum == 4 then
    return "Vee"
  elseif rndnum == 5 then
    return "Diamond"
  elseif rndnum == 6 then
    return "Echelon Left"
  elseif rndnum == 7 then
    return "Echelon Right"
  else
    return "Off road"   
  end  
  -- return "Off road" -- try and fix the @$@ routing issues of late.
end
rbg = SET_GROUP:New():FilterCoalitions("red"):FilterActive(true):FilterStart()
abg = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterStart()

function routegroups(_coord,dist,coalition)
	if coalition == "blue" or coalition == "Blue" or coalition == "BLUE" then
		local gunits = abg:FilterCategoryGround():FilterActive(true):FilterOnce()
		gunits:ForEach(function(g)  
			if g:IsAlive() == true then
				local _group = GROUP:FindByName(g:GetName())
				gc = _group:GetCoordinate()
				if gc == nil then
					BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
				else
					local d = gc:Get2DDistance(_coord)
					if d < dist then
						local rcoord = _coord:GetRandomCoordinateInRadius(500,100)
						g:RouteGroundTo(rcoord,math.random(10,20),randomform(),5)
					end
				end
			end
		end)
	else
		local gunits = rbg:FilterCategoryGround():FilterActive(true):FilterOnce()
		gunits:ForEach(function(g)
			if g:IsAlive() == true then
				local _group = GROUP:FindByName(g:GetName())
				gc = _group:GetCoordinate()
				if gc == nil then
					BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
				else
					local d = gc:Get2DDistance(_coord)
					if d < dist then
						local rcoord = _coord:GetRandomCoordinateInRadius(500,100)
						g:RouteGroundTo(rcoord,math.random(10,20),randomform(),5)
					end
				end
			else
				BASE:E({"Group is dead",g:GetName()})
			end
		end)
	end
end

function spawnctld(airbase,country,heading,distance)
	if heading == nil then
		heading = math.random(0,359)
	else 
	local minh = heading - 5 
	if minh < 0 then minh = minh + 360 end
	local maxh = heading + 5
	if maxh > 360 then maxh = maxh - 360 end
		heading = math.random(minh, maxh)
	end
	if distance == nil then
		distance = math.random(200,750)
	end
	local ab = AIRBASE:FindByName(airbase)
	local co = ab:GetCoordinate()
	co:Translate(distance,heading,false,true)
	local vec3 = co:GetVec3()
	local _unitId = ctld.getNextUnitId()
	local _name = "ctld Deployed FOB #" .. _unitId
	local _fob = nil
	_fob = ctld.spawnFOB(country, 211, vec3, _name)
	table.insert(ctld.logisticUnits, _fob:getName())
	if ctld.troopPickupAtFOB == true then
		table.insert(ctld.builtFOBS, _fob:getName())
	end
end

function slot_tunb(coalition)
    BASE:E({"SLOTS RUNNING FOR TUNB",coalition})
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Island_AFB)
	local _coord = ab:GetCoordinate()
    if coalition == 1 then
		if tmsg ~= false then
		routegroups(_coord,15000,"blue")
		trigger.action.setUserFlag("Tunb_Hind",0)
		trigger.action.setUserFlag("Tunb_Hind-1",0)
		trigger.action.setUserFlag("Tunb_Hind-2",100)
		trigger.action.setUserFlag("Tunb_Hind-3",100)
		trigger.action.setUserFlag("Tunb UH1 #001",0)
		trigger.action.setUserFlag("Tunb UH1",0)
		trigger.action.setUserFlag("Tunb MI8",0)
		trigger.action.setUserFlag("Tunb MI8 #001",0)
		trigger.action.setUserFlag("Tunb KA50",0)
		trigger.action.setUserFlag("Tunb KA50 #001",0)
		trigger.action.setUserFlag("Tunb US UH1",100)
		trigger.action.setUserFlag("Tunb US UH1 #001",100)
		trigger.action.setUserFlag("Tunb Georgia KA50",100)
		trigger.action.setUserFlag("Tunb Georgia KA50 #001",100)
		trigger.action.setUserFlag("Tunb Georgia MI8",100)
		trigger.action.setUserFlag("Tunb Georgia MI8 #001",100)
		ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Island", 4)
		MESSAGE:New("Iran has Retaken Tunb from the Coalition Invaders!",30):ToAll()
      --STTS.TextToSpeech("Tunb has been retaken by Irani Forces",253.00,"AM",0.75,"TGW Command", 1 )
--      STTS.TextToSpeech("We have lost Tunb to Irani Forces",253.00,"AM",0.75,"TGW Command", 2 )
		hm("> Tunb has been taken by Iran ")
		tmsg = false
		spawnctld(AIRBASE.PersianGulf.Tunb_Island_AFB,34,270,100)
		end
    else
      TunbRed:Destroy()
      if TunbBlue:IsAlive() ~= true then
        TunbBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Tnub B"):Spawn()
      end
        if tmsg ~= true then
		  routegroups(_coord,15000,"red")
          trigger.action.setUserFlag("Tunb UH1 #001",100)
          trigger.action.setUserFlag("Tunb UH1",100)
          trigger.action.setUserFlag("Tunb MI8",100)
          trigger.action.setUserFlag("Tunb MI8 #001",100)
          trigger.action.setUserFlag("Tunb KA50",100)
          trigger.action.setUserFlag("Tunb KA50 #001",100)
          trigger.action.setUserFlag("Tunb US UH1",0)
          trigger.action.setUserFlag("Tunb US UH1 #001",0)
          trigger.action.setUserFlag("Tunb Georgia KA50",0)
          trigger.action.setUserFlag("Tunb Georgia KA50 #001",0)
          trigger.action.setUserFlag("Tunb Georgia MI8",0)
          trigger.action.setUserFlag("Tunb Georgia MI8 #001",0)
		  trigger.action.setUserFlag("Tunb_Hind",100)
			trigger.action.setUserFlag("Tunb_Hind-1",100)
			trigger.action.setUserFlag("Tunb_Hind-2",00)
			trigger.action.setUserFlag("Tunb_Hind-3",00)
          ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Island", 4)
          MESSAGE:New("Coalition forces have liberated Tunb from Iran",30):ToAll()
         -- STTS.TextToSpeech("Tunb has fallen to the capitalist infidels",253.00,"AM",0.75,"TGW Command", 1 )
        -- STTS.TextToSpeech("We have liberated Tunb from Irani Forces",253.00,"AM",0.75,"TGW Command", 2 )
          hm("> Tunb has been taken by the Coalition ")
          tmsg = true
          SCHEDULER:New(nil,spawnislands,{},math.random(5,1200))
		  spawnctld(AIRBASE.PersianGulf.Tunb_Island_AFB,2,280,100)
        end 
    end
end

function slot_sirri(coalition)
	BASE:E({"Slots Sirri"})
  ctld.changeRemainingGroupsForPickupZone("CTLD Sirri Island",3)
  if coalition == 1 then
    SirriBlue:Destroy()
    if SirriRed:IsAlive() ~= true then
      SirriRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Sirri Island"):Spawn()
    BASE:E({"LETS GET Sirri Red's name",SirriRed:GetName()})
    end
	if smsg ~= false then
	    local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Sirri_Island)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,15000,"blue")
		trigger.action.setUserFlag("Sirri US Island MI8", 100)
		trigger.action.setUserFlag("Sirri US Island MI8 #001", 100)
		trigger.action.setUserFlag("Sirri US Island KA50", 100)
		trigger.action.setUserFlag("Sirri US Island KA50 #001", 100)
		trigger.action.setUserFlag("Sirri US Island UH1", 100)
		trigger.action.setUserFlag("Sirri US Island UH1 #001", 100)
		trigger.action.setUserFlag("Sirri_Hind", 00)
		trigger.action.setUserFlag("Sirri_Hind-1", 100)
		MESSAGE:New("Iran has Retaken Sirri Island from the Coalition Invaders!",30):ToAll()
		-- STTS.TextToSpeech("Sirri Island has been retaken from the US led scum",253.00,"AM",0.75,"TGW Command", 1 )
		-- STTS.TextToSpeech("We have lost Sirri Island to Iran!",253.00,"AM",0.75,"TGW Command", 2 )
		hm("> Siri Island has been taken by Iran ")
		smsg = false
		sirrispawn = false
		spawnctld(AIRBASE.PersianGulf.Sirri_Island,34,0,250)
    end
  else
    SirriRed:Destroy()
    if SirriBlue:IsAlive() ~= true then
		SirriBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Sirri Island B"):Spawn()
		BASE:E({"LETS GET Sirri Blue's name",SirriBlue:GetName()})
    end
	if smsg ~= true then
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Sirri_Island)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,15000,"red")
		trigger.action.setUserFlag("Sirri US Island MI8", 0)
		trigger.action.setUserFlag("Sirri US Island MI8 #001", 0)
		trigger.action.setUserFlag("Sirri US Island KA50", 0)
		trigger.action.setUserFlag("Sirri US Island KA50 #001", 0)
		trigger.action.setUserFlag("Sirri US Island UH1", 0)
		trigger.action.setUserFlag("Sirri US Island UH1 #001", 0)
		trigger.action.setUserFlag("Sirri_Hind", 100)
		trigger.action.setUserFlag("Sirri_Hind-1", 00)
		MESSAGE:New("Coalition Forces have liberated Sirri Island from Iran",30):ToAll()
		--STTS.TextToSpeech("Sirri Island has been lost to the western invaders",253.00,"AM",0.75,"TGW Command", 1 )
		--STTS.TextToSpeech("We liberated Sirri Island from Iran!",253.00,"AM",0.75,"TGW Command", 2 )
		hm("> Siri Island has been taken by Coalition Forces  ")
		SCHEDULER:New(nil,spawnislands,{},math.random(60,1200))
		if init ~= true then
		SCHEDULER:New(nil,function() 
			BASE:E({"Spawning Defenders - SIRRI"})
			spawndefenders("sirrispawn")
		end,{},math.random(60,300))
		end
		smsg = true
		spawnctld(AIRBASE.PersianGulf.Sirri_Island,2,30,250)
  end
  end
end

function slot_lavan(coalition)
	BASE:E({"Slots Lavan"})
  ctld.changeRemainingGroupsForPickupZone("CTLD Lavin Island",3)
  if coalition == 1 then
	LavanBlue:Destroy()
    if LavanRed:IsAlive() ~= true then
      LavanRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Lavin"):Spawn()
    end
  if lmsg ~= false then
    local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Lavan_Island_Airport)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"blue")
    trigger.action.setUserFlag("Lavin Island UH1", 0)
    trigger.action.setUserFlag("Lavin Island UH1 #001", 0)
    trigger.action.setUserFlag("Lavin Island KA50", 0)
    trigger.action.setUserFlag("Lavin Island KA50 #001", 0)
    trigger.action.setUserFlag("Lavin Island MI8", 0)
    trigger.action.setUserFlag("Lavin Island MI8 #001", 0)
	trigger.action.setUserFlag("ASJ37 - Lavan 1-1", 0)
	trigger.action.setUserFlag("ASJ37 - Lavan 1-2", 0)
    trigger.action.setUserFlag("Lavin Island US UH1", 100)
    trigger.action.setUserFlag("Lavin Island US UH1 #001", 100)
    trigger.action.setUserFlag("Lavin Island US KA50", 100)
    trigger.action.setUserFlag("Lavin Island US KA50 #001", 100)
    trigger.action.setUserFlag("Lavin Island US MI8", 100)
    trigger.action.setUserFlag("Lavin Island US MI8 #001", 100)
    MESSAGE:New("Iran has retaken Lavan Island from the US Backed Infidels",30):ToAll()
    --STTS.TextToSpeech("Lavan Island is once more back in Irani Hands",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("We have lost our foothold on Lavan Island!",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Lavan Island has been taken by Iran")
    lmsg = false
	lavanspawn = false
	spawnctld(AIRBASE.PersianGulf.Lavan_Island_Airport,34,20,70)
  end
  else
	if allowfobs == true then
		LavanRed:Destroy()
		if LavanBlue:IsAlive() ~= true then
			LavanBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Lavin B"):Spawn()
		end
	end
  if lmsg ~= true then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Lavan_Island_Airport)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"red")
    trigger.action.setUserFlag("Lavin Island UH1", 100)
    trigger.action.setUserFlag("Lavin Island UH1 #001", 100)
    trigger.action.setUserFlag("Lavin Island KA50", 100)
    trigger.action.setUserFlag("Lavin Island KA50 #001", 100)
    trigger.action.setUserFlag("Lavin Island MI8", 100)
    trigger.action.setUserFlag("Lavin Island MI8 #001", 100)
	trigger.action.setUserFlag("ASJ37 - Lavan 1-1", 100)
	trigger.action.setUserFlag("ASJ37 - Lavan 1-2", 100)
    trigger.action.setUserFlag("Lavin Island US UH1", 00)
    trigger.action.setUserFlag("Lavin Island US UH1 #001", 00)
    trigger.action.setUserFlag("Lavin Island US KA50", 00)
    trigger.action.setUserFlag("Lavin Island US KA50 #001", 00)
    trigger.action.setUserFlag("Lavin Island US MI8", 00)
    trigger.action.setUserFlag("Lavin Island US MI8 #001", 00)
    MESSAGE:New("The US Led Coalition has liberated Lavan Island from Irani dictatorship",30):ToAll()
    --STTS.TextToSpeech("Lavan Island has fallen",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("We have gained a foothold on Lavan Island!",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Lavan Island has been taken by Coalition Forces")
    SCHEDULER:New(nil,spawnislands,{},math.random(5,1200))
    if init == true then
		SCHEDULER:New(nil,function() 
			spawndefenders("lavanspawn")
		end,{},math.random(60,300))
	end
    lmsg = true
	spawnctld(AIRBASE.PersianGulf.Lavan_Island_Airport,2,20,70)
  end
  end
end

function slot_kish(coalition)
	BASE:E({"Slots Kish"})
  ctld.changeRemainingGroupsForPickupZone("CTLD Kish Island",3)
  if coalition == 1 then
	if KishBlue ~= nil then
		KishBlue:Destroy()
	end
	if KishRed ~= nil then
		if KishRed:IsAlive() ~= true then
			KishRed:ReSpawn() --= SPAWNSTATIC:NewFromStatic("CTLD Kish"):Spawn()
		end
	else
		KishRed = SPAWNSTATIC:NewFromStatic("CTLD Kish"):Spawn()		
	end
  if kimsg ~= false then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"blue")
    trigger.action.setUserFlag("Kish UH1", 0)
	trigger.action.setUserFlag("Kish_Hind", 0)
	trigger.action.setUserFlag("Kish_Hind-1", 0)
	trigger.action.setUserFlag("Kish_Hind-2", 100)
	trigger.action.setUserFlag("Kish_Hind-3", 100)
    trigger.action.setUserFlag("Kish UH1 #001", 0)
    trigger.action.setUserFlag("Kish Mi8", 0)
    trigger.action.setUserFlag("Kish Mi8 #001", 0)
    trigger.action.setUserFlag("Kish KA50", 0)
    trigger.action.setUserFlag("Kish KA50 #001", 0)
    trigger.action.setUserFlag("Frogfoot 21", 0)
    trigger.action.setUserFlag("Frogfoot 22", 0)
    trigger.action.setUserFlag("Frogfoot 23", 0)
    trigger.action.setUserFlag("Frogfoot 24", 0)
    trigger.action.setUserFlag("IRAF91-1", 0)
    trigger.action.setUserFlag("IRAF91-2", 0)
    trigger.action.setUserFlag("IRAF91-3", 0)
    trigger.action.setUserFlag("IRAF91-4", 0)
    trigger.action.setUserFlag("KishBoar -1",100)
    trigger.action.setUserFlag("KishBoar -2",100)
    trigger.action.setUserFlag("KishBoar -3",100)
    trigger.action.setUserFlag("KishBoar -4",100)
    trigger.action.setUserFlag("Kish US UH1", 100)
    trigger.action.setUserFlag("Kish US UH1 #001", 100)
    trigger.action.setUserFlag("Kish US KA50", 100)
    trigger.action.setUserFlag("Kish US KA50 #001", 100)
    if usenew == false then
      ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},2)
      ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},2)  
    else
      SCHEDULER:New(nil,function() 
      if i91st:GetSqnCount() == 0 then
        i91st:SetSqnCount(4)
      end
      i91st:Start()
  
      
       end,{},math.random(120,600))
      --intercept
        if i91st_1:GetSqnCount() == 0 then
          i91st_1:SetSqnCount(4)
        end
        i91st_1:Start()    
    end
    MESSAGE:New("Kish Island is once more under Irani Control",30):ToAll()
    --STTS.TextToSpeech("Kish Island has been retaken",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("We have lost our foothold on Lavan Island!",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Kish Island has been taken by Iran")
    kimsg = false
	kishspawn = false
	spawnctld(AIRBASE.PersianGulf.Kish_International_Airport,34,20,200)
  end
  else
	if allowfobs == true then
		KishRed:Destroy()
		if KishBlue ~= nil then
			if KishBlue:IsAlive() ~= true then
				KishBlue = SPAWNSTATIC:NewFromStatic("CTLD Kish B"):Spawn()
			end 
		else
			KishBlue = SPAWNSTATIC:NewFromStatic("CTLD Kish B"):Spawn()
		end
	end
  if kimsg ~= true then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"red")
     trigger.action.setUserFlag("Kish UH1", 100)
    trigger.action.setUserFlag("Kish UH1 #001", 100)
    trigger.action.setUserFlag("Kish Mi8", 100)
    trigger.action.setUserFlag("Kish Mi8 #001", 100)
    trigger.action.setUserFlag("Kish KA50", 100)
    trigger.action.setUserFlag("Kish KA50 #001", 100)
    trigger.action.setUserFlag("Frogfoot 21", 100)
    trigger.action.setUserFlag("Frogfoot 22", 100)
    trigger.action.setUserFlag("Frogfoot 23", 100)
    trigger.action.setUserFlag("Frogfoot 24", 100)
    trigger.action.setUserFlag("IRAF91-1", 100)
    trigger.action.setUserFlag("IRAF91-2", 100)
    trigger.action.setUserFlag("IRAF91-3", 100)
    trigger.action.setUserFlag("IRAF91-4", 100)
    trigger.action.setUserFlag("Kish US UH1", 0)
    trigger.action.setUserFlag("Kish US UH1 #001", 0)
    trigger.action.setUserFlag("Kish US KA50", 0)
    trigger.action.setUserFlag("Kish US KA50 #001", 0)
    trigger.action.setUserFlag("KishBoar -1",00)
    trigger.action.setUserFlag("KishBoar -2",00)
    trigger.action.setUserFlag("KishBoar -3",00)
    trigger.action.setUserFlag("KishBoar -4",00)	
	trigger.action.setUserFlag("Kish_Hind", 100)
	trigger.action.setUserFlag("Kish_Hind-1", 100)
	trigger.action.setUserFlag("Kish_Hind-2", 00)
	trigger.action.setUserFlag("Kish_Hind-3", 00)
    if usenew == false then
      ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},-99)
      ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},-99)    
    else
	 BASE:E({"Kish Should be 0"})
      i91st:SetSqnCount(0)
      i91st:Stop()
      --intercept
      i91st_1:SetSqnCount(0)
	  i91st_1:Stop()
    end
    MESSAGE:New("Kish Island has been taken by the coalition forces",30):ToAll()
    --STTS.TextToSpeech("Kish Island has fallen",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("We have gained a foothold on Kish Island!",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Kish Island has been taken by Coalition Forces")
    kimsg = true
    SCHEDULER:New(nil,spawnislands,{},math.random(5,1200))
    if init == true then
		SCHEDULER:New(nil,function() 
			spawndefenders("kishspawn")
		end,{},math.random(60,300))
	end
	spawnctld(AIRBASE.PersianGulf.Kish_International_Airport,2,10,200)
  end
  end
end

function slot_qeshm(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Qeshm Island",4)
  if coalition == 1 then
	QeshmBlue:Destroy()
    if QeshmRed:IsAlive() ~= true then
      QeshmRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Qeshm Island"):Spawn()
    end
  if qemsg ~= false then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Qeshm_Island)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"blue")
    trigger.action.setUserFlag("Qeshm Island US UH1", 100)
    trigger.action.setUserFlag("Qeshm Island US UH1 #001", 100)
    trigger.action.setUserFlag("Qeshm Island US KA50", 100)
    trigger.action.setUserFlag("Qeshm Island US KA50 #001", 100)
	trigger.action.setUserFlag("Qeshm_hind",100)
	trigger.action.setUserFlag("Qeshm_hind-1",100)
	trigger.action.setUserFlag("Qeshm_hind-2",00)
	trigger.action.setUserFlag("Qeshm_hind-3",00)
    trigger.action.setUserFlag("Qeshm F14-1",00)
    trigger.action.setUserFlag("Qeshm F14",00)
    trigger.action.setUserFlag("Qeshm F16-1",00)
    trigger.action.setUserFlag("Qeshm F16",00)
    trigger.action.setUserFlag("Qeshm JF17-1",00)
    trigger.action.setUserFlag("Qeshm JF17",00)
    trigger.action.setUserFlag("Qeshm SU-33-1",00)
    trigger.action.setUserFlag("Qeshm SU-33",00)
    trigger.action.setUserFlag("Bandar SU-1-1",00)
    trigger.action.setUserFlag("Qeshm Island IRAN KA50-1",00)
    trigger.action.setUserFlag("Qeshm Island IRAN KA50-2",00)
    trigger.action.setUserFlag("Qeshm Island IRAN UH-1-2",00)
    trigger.action.setUserFlag("Qeshm Island IRAN UH-1",00)
    MESSAGE:New("Qeshm Island has been Liberated from the Coalition invaders and Infidels",30):ToAll()
    --STTS.TextToSpeech("Qeshm Island is once more ours, we must continue to push back the infidels",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("We have lost Qeshm Island, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Qeshm Island has been taken by Iran")
    qeshmspawn = false
	qemsg = false
	spawnctld(AIRBASE.PersianGulf.Qeshm_Island,34,320,100)
  end
  else
    if allowfobs == true then
		QeshmRed:Destroy()
	    if QeshmBlue:IsAlive() ~= true then
			QeshmBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Qeshm Island B"):Spawn()
        end
	end
  if qemsg ~= true then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Qeshm_Island)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,25000,"red")
    trigger.action.setUserFlag("Qeshm Island US UH1", 00)
    trigger.action.setUserFlag("Qeshm Island US UH1 #001", 00)
    trigger.action.setUserFlag("Qeshm Island US KA50", 00)
    trigger.action.setUserFlag("Qeshm Island US KA50 #001", 00)
	trigger.action.setUserFlag("Qeshm_hind",00)
	trigger.action.setUserFlag("Qeshm_hind-1",00)
	trigger.action.setUserFlag("Qeshm_hind-2",100)
	trigger.action.setUserFlag("Qeshm_hind-3",100)
    trigger.action.setUserFlag("Qeshm F14-1",100)
    trigger.action.setUserFlag("Qeshm F14",100)
    trigger.action.setUserFlag("Qeshm F16-1",100)
    trigger.action.setUserFlag("Qeshm F16",100)
    trigger.action.setUserFlag("Qeshm JF17-1",100)
    trigger.action.setUserFlag("Qeshm JF17",100)
    trigger.action.setUserFlag("Qeshm SU-33-1",100)
    trigger.action.setUserFlag("Qeshm SU-33",100)
    trigger.action.setUserFlag("Bandar SU-1-1",100)
    trigger.action.setUserFlag("Qeshm Island IRAN KA50-1",100)
    trigger.action.setUserFlag("Qeshm Island IRAN KA50-2",100)
    trigger.action.setUserFlag("Qeshm Island IRAN UH-1-2",100)
    trigger.action.setUserFlag("Qeshm Island IRAN UH-1",100)
    MESSAGE:New("Qesh Island has been occuiped, Coalition forces are one step closer to taking Iran!",30):ToAll()
    --STTS.TextToSpeech("Qeshm Island has falledn to the infidels! We must retake it before they gain a foothold",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("Qeshm Island is now ours, we have a base on Bandar's doorstep.",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Qeshm Island has been taken by Iran")
    qemsg = true
    SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    if init == false then
	SCHEDULER:New(nil,function() 
      spawndefenders("qeshmspawn")
    end,{},math.random(60,300))
	end
	spawnctld(AIRBASE.PersianGulf.Qeshm_Island,2,330,150)
  end
  end
end

function slot_khasab(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Khasab",4)
  if coalition == 1 then
	KhasabBlue:Destroy()
	if KhasabRed:IsAlive() ~= true then
			KhasabRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD AbuFarp B"):Spawn()
	end
	
  if khmsg ~= false then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"blue")
    MESSAGE:New("Iran Forces have captured Khasab in the Omani Republic! And began to Steal US Aircraft!",30):ToAll()
    hm("> Khasab Island has been taken by Iran US AIRCRAFT BEING STOLEN")
    trigger.action.setUserFlag("Khasab_Hind", 00)
	trigger.action.setUserFlag("Khasab_Hind-1", 00)
	trigger.action.setUserFlag("Khasab_Hind-2", 100)
	trigger.action.setUserFlag("Khasab_Hind-3", 100)
	trigger.action.setUserFlag("RED KA50 Khasab", 00)
    trigger.action.setUserFlag("RED KA50 Khasab #001", 00)
    trigger.action.setUserFlag("RED UH1 Khasab", 00)
    trigger.action.setUserFlag("RED UH1 Khasab #001", 00)
    trigger.action.setUserFlag("SA342Mini #001", 100)
    trigger.action.setUserFlag("SA342Mini", 100)
    trigger.action.setUserFlag("UH1-Khasab 3", 100)
    trigger.action.setUserFlag("UH1-Khasab 2", 100)
    trigger.action.setUserFlag("UH1-Khasab 1", 100)
    trigger.action.setUserFlag("UH1-Khasab", 100)
    trigger.action.setUserFlag("KA50",100)
    trigger.action.setUserFlag("KA50 #001",100)
    trigger.action.setUserFlag("SA342Mist",100)
    trigger.action.setUserFlag("SA342Mist #001",100)
    trigger.action.setUserFlag("SA342M",100)
    trigger.action.setUserFlag("SA342M #001",100)
    trigger.action.setUserFlag("MI8-1",100)
    trigger.action.setUserFlag("MI8-2",100)
    trigger.action.setUserFlag("A10C_HAWG3_99",100)
    trigger.action.setUserFlag("A10C_HAWG3_100",100)
    trigger.action.setUserFlag("A10C_HAWG3_101",100)
    trigger.action.setUserFlag("A10C_HAWG3_102",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG6_910",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG9_913",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG8_912",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG7_911",100)
    trigger.action.setUserFlag("COLT5-54",100)
    trigger.action.setUserFlag("COLT5-55",100)
    trigger.action.setUserFlag("COLT5-56",100)
    trigger.action.setUserFlag("COLT5-57",100)
    local AN = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Lengeh)
    if AN:GetCoalition() == 1 then
      trigger.action.setUserFlag("F15_Bandar_Lengeh_Khasab",00)
      trigger.action.setUserFlag("F18_Bandar_Lengeh_Khasab",00)
      MESSAGE:New("F18 and F15's Unlocked to Iran at Bandar Lengeh",30):ToAll()
      hm("> **F18 and F15's Unlocked to Iran at Bandar Lengeh**  ")
    end
    AN = AIRBASE:FindByName(AIRBASE.PersianGulf.Havadarya)
    if AN:GetCoalition() == 1 then    
      trigger.action.setUserFlag("F18 Havadarya_Khasab",00)
      trigger.action.setUserFlag("F18 Havadarya_Khasab-1",00)
      trigger.action.setUserFlag("F15 Havadarya_Khasab",00)
      trigger.action.setUserFlag("F15 Havadarya_Khasab-1",00)
      trigger.action.setUserFlag("A10CII Havadarya_Khasab",00)
      trigger.action.setUserFlag("A10CII Havadarya_Khasab-1",00)
      trigger.action.setUserFlag("AV8 Havadarya_Khasab",00)
      trigger.action.setUserFlag("AV8 Havadarya_Khasab-1",00)
      MESSAGE:New("F18, F15, A10CII and AV8's Unlocked to Iran at Havadarya",30):ToAll()
      hm("> **F18, F15, A10CII and AV8's  Unlocked to Iran at Havadarya**")
    end
    khmsg = false
	khasabspawn = false
	spawnctld(AIRBASE.PersianGulf.Khasab,34,345,500)
  end
  else
	KhasabRed:Destroy()
    if KhasabBlue:IsAlive() ~= true then
      KhasabBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD AbuFarp"):Spawn()
    end
  
  if khmsg ~= true then
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,15000,"red")
    trigger.action.setUserFlag("RED KA50 Khasab", 100)
    trigger.action.setUserFlag("RED KA50 Khasab #001", 100)
    trigger.action.setUserFlag("RED UH1 Khasab", 100)
    trigger.action.setUserFlag("RED UH1 Khasab #001", 100)
    trigger.action.setUserFlag("F15_Bandar_Lengeh_Khasab",100)
    trigger.action.setUserFlag("F18_Bandar_Lengeh_Khasab",100)
    trigger.action.setUserFlag("F18 Havadarya_Khasab",100)
    trigger.action.setUserFlag("F18 Havadarya_Khasab-1",100)
    trigger.action.setUserFlag("F15 Havadarya_Khasab",100)
    trigger.action.setUserFlag("F15 Havadarya_Khasab-1",100)
    trigger.action.setUserFlag("A10CII Havadarya_Khasab",100)
    trigger.action.setUserFlag("A10CII Havadarya_Khasab-1",100)
    trigger.action.setUserFlag("AV8 Havadarya_Khasab",100)
    trigger.action.setUserFlag("AV8 Havadarya_Khasab-1",100)
    trigger.action.setUserFlag("SA342Mini #001", 00)
    trigger.action.setUserFlag("SA342Mini", 00)
    trigger.action.setUserFlag("UH1-Khasab 3", 00)
    trigger.action.setUserFlag("UH1-Khasab 2", 00)
    trigger.action.setUserFlag("UH1-Khasab 1", 00)
    trigger.action.setUserFlag("UH1-Khasab", 00)
    trigger.action.setUserFlag("KA50",00)
    trigger.action.setUserFlag("KA50 #001",00)
    trigger.action.setUserFlag("SA342Mist",00)
    trigger.action.setUserFlag("SA342Mist #001",00)
    trigger.action.setUserFlag("SA342M",00)
    trigger.action.setUserFlag("SA342M #001",00)
    trigger.action.setUserFlag("MI8-1",00)
    trigger.action.setUserFlag("MI8-2",00)
    trigger.action.setUserFlag("A10C_HAWG3_99",00)
    trigger.action.setUserFlag("A10C_HAWG3_100",00)
    trigger.action.setUserFlag("A10C_HAWG3_101",00)
    trigger.action.setUserFlag("A10C_HAWG3_102",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG6_910",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG9_913",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG8_912",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG7_911",00)
    trigger.action.setUserFlag("COLT5-54",00)
    trigger.action.setUserFlag("COLT5-55",00)
    trigger.action.setUserFlag("COLT5-56",00)
    trigger.action.setUserFlag("COLT5-57",00)
    MESSAGE:New("The Omani People rest easier knowing that the Coalition has retaken Khasab",30):ToAll()
    --STTS.TextToSpeech("Khasab has been lost to us, we must recover from this blow quickly.",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("Khasab is once more in the rightful hands of the Omani people.",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Khasab Island has been taken by Coalition Forces")
    khmsg = true
	spawnctld(AIRBASE.PersianGulf.Khasab,2,345,500)
  end
  end

end


function slot_bandar(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Bandar Abbas",4)
  if coalition == 1 then
    if banmsg ~= true then
      BandarBlue:Destroy()
      if BandarRed:IsAlive() ~= true then
        BandarRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD BandarFarp"):Spawn()
      end
	  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,11000,"blue")
      trigger.action.setUserFlag("Bandar MI8", 00)
    trigger.action.setUserFlag("Bandar MI8 #001", 00)
    trigger.action.setUserFlag("Bandar UH1", 00)
    trigger.action.setUserFlag("Bandar UH1 #001", 00)
    trigger.action.setUserFlag("Bandar KA50", 00)
    trigger.action.setUserFlag("Bandar KA50 #001", 00)
    trigger.action.setUserFlag("Bandar KA50 #002", 00)
    trigger.action.setUserFlag("Bandar KA50 #003", 00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR", 00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr", 00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr #001",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR #001",00)
    trigger.action.setUserFlag("Bandar_Mig-29 422",00)
    trigger.action.setUserFlag("Bandar_Mig-29",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #001",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #002",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #003",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #003",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #004",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #002",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #001",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #002",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #003",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #001",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #001",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #002",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #003",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #001",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #002",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #003",00)
    trigger.action.setUserFlag("Pak-F16-Bandar",00)
    trigger.action.setUserFlag("Pak-F16-Bandar #001",00)
    trigger.action.setUserFlag("Pak-F16-Bandar #002",00)
    trigger.action.setUserFlag("Pak-F16-Bandar #003",00)
    trigger.action.setUserFlag("IRAF31th",00)
    trigger.action.setUserFlag("IRAF31th #001",00)
    trigger.action.setUserFlag("Bandar SU-33",00)
    trigger.action.setUserFlag("Bandar SU-33-1",00)
    trigger.action.setUserFlag("Bandar_J11",00)
    trigger.action.setUserFlag("Bandar_J11-1",00)
	trigger.action.setUserFlag("bandar_hind",00)
	trigger.action.setUserFlag("bandar_hind-1",00)
      if usenew == false then
        ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},4)
        ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},4)
      else
        SCHEDULER:New(nil,function() 
        i31st:Start()
         end,{},math.random(1,600))
        SCHEDULER:New(nil,function() i32nd:Start() 
        
        end,{},math.random(1,600))
        SCHEDULER:New(nil,function() i33rd:Start() 
        
        end,{},math.random(1,600))
        if i31st:GetSqnCount() == 0 then
          i31st:SetSqnCount(6)
        end
        if i32nd:GetSqnCount() == 0 then
          i32nd:SetSqnCount(6)
        end
        if i33rd:GetSqnCount() == 0 then
          i33rd:SetSqnCount(6)
        end
        if i33rd_2:GetSqnCount() == 0 then
          i33rd_2:SetSqnCount(4)
        end
        i33rd_2:Start()
        
      end
      MESSAGE:New("Iran has liberated Bandar Abbas from the oppressors and it is once more in our hands!",30):ToAll()
     -- STTS.TextToSpeech("Bandar is once more ours, we must continue to push back the infidels",253.00,"AM",0.75,"TGW Command", 1 )
     -- STTS.TextToSpeech("We have lost Bandar Abbas, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      hm("> Bandar Abbas has been taken by Iran this is a Glorious Day!")
      banmsg = true
	  bandarspawn = false
	  spawnctld(AIRBASE.PersianGulf.Bandar_Abbas_Intl,34,0,1000)
    end
  else
    
  if banmsg ~= false then
    BandarRed:Destroy()
	if allowfobs == true then
		if BandarBlue:IsAlive() ~= true then
			BandarBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD BandarFarp B"):Spawn()
		end
	end
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl)
	local _coord = ab:GetCoordinate()
	routegroups(_coord,20000,"red")
    trigger.action.setUserFlag("Bandar MI8", 100)
    trigger.action.setUserFlag("Bandar MI8 #001", 100)
    trigger.action.setUserFlag("Bandar UH1", 100)
    trigger.action.setUserFlag("Bandar UH1 #001", 100)
    trigger.action.setUserFlag("Bandar KA50", 100)
    trigger.action.setUserFlag("Bandar KA50 #001", 100)
    trigger.action.setUserFlag("Bandar KA50 #002", 100)
    trigger.action.setUserFlag("Bandar KA50 #003", 100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR", 100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr", 100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr #001",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR #001",100)
    trigger.action.setUserFlag("Bandar_Mig-29 422",100)
    trigger.action.setUserFlag("Bandar_Mig-29",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #001",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #002",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #003",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #003",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #004",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #002",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #001",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #002",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #003",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #001",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #001",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #002",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #003",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #001",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #002",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #003",100)
    trigger.action.setUserFlag("Pak-F16-Bandar",100)
    trigger.action.setUserFlag("Pak-F16-Bandar #001",100)
    trigger.action.setUserFlag("Pak-F16-Bandar #002",100)
    trigger.action.setUserFlag("Pak-F16-Bandar #003",100)
    trigger.action.setUserFlag("IRAF31th",100)
    trigger.action.setUserFlag("IRAF31th #001",100)
    trigger.action.setUserFlag("Bandar SU-33",100)
    trigger.action.setUserFlag("Bandar SU-33-1",100)
    trigger.action.setUserFlag("Bandar_J11",100)
    trigger.action.setUserFlag("Bandar_J11-1",100)
	trigger.action.setUserFlag("bandar_hind",00)
	trigger.action.setUserFlag("bandar_hind-1",00)
    if usenew == false then
      ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},0)
      ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},0)
    else
      i31st:SetSqnCount(0)
      i32nd:SetSqnCount(0)
      i33rd:SetSqnCount(0)
      i33rd_2:SetSqnCount(0)
      i31st:Stop()
      i32nd:Stop()
      i33rd:Stop()
      i33rd_2:Stop()
    end
    MESSAGE:New("Coalition forces have occupied Bandar! We have crossed the Strait!",30):ToAll()
    --STTS.TextToSpeech("We have lost Bandar Abbas! This can not stand we must retake that airfield at all costs.",253.00,"AM",0.75,"TGW Command", 1 )
    --STTS.TextToSpeech("Bandar Abbas is now ours, we have crossed the straight of Hormoz",253.00,"AM",0.75,"TGW Command", 2 )
    hm("> Bandar Abbas has been taken by Coalition Forces, The Coalition has Crossed the Straight of Hormoz.")
    SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    if init == true then
	SCHEDULER:New(nil,function() 
      spawndefenders("bandarspawn")
    end,{},math.random(60,300))
	end
    banmsg = false
	spawnctld(AIRBASE.PersianGulf.Bandar_Abbas_Intl,2,0,1000)
  end
  end

end

function slot_lars(coalition)
  BASE:E({"LARS SLOT",coalition,larmsg})
  ctld.changeRemainingGroupsForPickupZone("CTLD Lar AFB",4)
  if coalition == 1 then
	BASE:E({"LARS SLOT Coalition 1 running",coalition,larmsg})
    if larmsg ~= false then
        LarsBlue:Destroy()
		if LarsRed:IsAlive() ~= true then
			LarsRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD FLar B"):Spawn()
		end
		 local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Lar_Airbase)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"blue")
		BASE:E({"Lars shuld be locked to Blue"})
		trigger.action.setUserFlag("Lar_hind", 00)
		trigger.action.setUserFlag("Lar_hind-1", 00)
		trigger.action.setUserFlag("Lar_hind-2", 100)
		trigger.action.setUserFlag("Lar_hind-3", 100)
		trigger.action.setUserFlag("LarsK -1", 100)
		trigger.action.setUserFlag("LarsK -2", 100)
		trigger.action.setUserFlag("LarsK -3", 100)
		trigger.action.setUserFlag("LarsK -4", 100)
		trigger.action.setUserFlag("LarsU -1", 100)
		trigger.action.setUserFlag("LarsU -2", 100)
		trigger.action.setUserFlag("LarsU -3", 100)
		trigger.action.setUserFlag("LarsU -4", 100)
		trigger.action.setUserFlag("LarsK -5", 00)
		trigger.action.setUserFlag("LarsK -6", 00)
		trigger.action.setUserFlag("LarsK -7", 00)
		trigger.action.setUserFlag("LarsK -8", 00)
		trigger.action.setUserFlag("LarsU -5", 00)
		trigger.action.setUserFlag("LarsU -6", 00)
		trigger.action.setUserFlag("LarsU -7", 00)
		trigger.action.setUserFlag("LarsU -8", 00)
		trigger.action.setUserFlag("LARS_JF-17_Springfield7", 00)
		trigger.action.setUserFlag("LARS_JF-17_Springfield7 #001", 00)
		trigger.action.setUserFlag("Pak-F16-Lar",00)
		trigger.action.setUserFlag("Pak-F16-Lar #001",00)
		trigger.action.setUserFlag("Pak-F16-Lar #002",00)
		if usenew == false then
			ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},2)
			ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},2)
		end
		MESSAGE:New("Lar is once more back in Irani Control",30):ToAll()
		larmsg = false
		larspawn = false
		-- STTS.TextToSpeech("Lars Airbase is once more ours.",253.00,"AM",0.75,"TGW Command", 1 )
		-- STTS.TextToSpeech("We have Lars Airbase, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
		hm("> Lar Airbase has been taken by Iran  ")
		spawnctld(AIRBASE.PersianGulf.Lar_Airbase,34,10,500)
		BASE:E({"LARS SLOT Coalition 1 running done",coalition,larmsg})
	end
  else
	BASE:E({"LARS SLOT Coalition 2 running",coalition,larmsg})
	if larmsg ~= true then
		LarsRed:Destroy()
		if allowfobs == true then
			if LarsBlue:IsAlive() ~= true then
				LarsBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD FLar"):Spawn()
			end   
		end
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Lar_Airbase)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"red")
		BASE:E({"Lars shuld be locked to Red"})
		trigger.action.setUserFlag("LarsK -1", 00)
		trigger.action.setUserFlag("LarsK -2", 00)
		trigger.action.setUserFlag("LarsK -3", 00)
		trigger.action.setUserFlag("LarsK -4", 00)
		trigger.action.setUserFlag("LarsU -1", 00)
		trigger.action.setUserFlag("LarsU -2", 00)
		trigger.action.setUserFlag("LarsU -3", 00)
		trigger.action.setUserFlag("LarsU -4", 00)
		trigger.action.setUserFlag("Lar_hind", 100)
		trigger.action.setUserFlag("Lar_hind-1", 100)
		trigger.action.setUserFlag("Lar_hind-2", 00)
		trigger.action.setUserFlag("Lar_hind-3", 00)
		trigger.action.setUserFlag("LARS_JF-17_Springfield7", 100)
		trigger.action.setUserFlag("LARS_JF-17_Springfield7 #001", 100)
		trigger.action.setUserFlag("Pak-F16-Lar",100)
		trigger.action.setUserFlag("Pak-F16-Lar #001",100)
		trigger.action.setUserFlag("Pak-F16-Lar #002",100)
		trigger.action.setUserFlag("LarsK -5", 100)
		trigger.action.setUserFlag("LarsK -6", 100)
		trigger.action.setUserFlag("LarsK -7", 100)
		trigger.action.setUserFlag("LarsK -8", 100)
		trigger.action.setUserFlag("LarsU -5", 100)
		trigger.action.setUserFlag("LarsU -6", 100)
		trigger.action.setUserFlag("LarsU -7", 100)
		trigger.action.setUserFlag("LarsU -8", 100)
		if usenew == false then
			ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},0)
			ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},0)
		end
		MESSAGE:New("Lar Airbase has fallen to coalition forces",30):ToAll()
		-- STTS.TextToSpeech("Lars Airbase is now under our control.",253.00,"AM",0.75,"TGW Command", 2 )
		-- STTS.TextToSpeech("We have lost Lars Airbase, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 1 )
		hm("> Lar Airbase has been taken by Coalition Forces  ")
		SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
		if init == true then
			SCHEDULER:New(nil,function() 
				spawndefenders("larspawn")
			end,{},math.random(60,300))
		end
		larmsg = true
		spawnctld(AIRBASE.PersianGulf.Lar_Airbase,2,10,500)
		BASE:E({"LARS SLOT Coalition 2 running",coalition,larmsg})
		end
	end
	BASE:E({"LARS SLOT DONE running",coalition,larmsg})
end


function slot_abun(coalition)
  if coalition == 1 then
    if abunmsg ~= false then
      abunblue:Destroy()
      if abunred:IsAlive() ~= true then
        abunred:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Abu Nuayr B"):Spawn()
      end
      MESSAGE:New("Iran has taken Abu Nuayr!",30):ToAll()
     -- STTS.TextToSpeech("We have liberated Abu Nuayr from the Coalition.",253.00,"AM",0.75,"TGW Command", 1 )
     -- STTS.TextToSpeech("We have lost Abu Nuayr, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      abunmsg = false
      hm("> Abu Nuayr has been taken by Iran ")
	  spawnctld(AIRBASE.PersianGulf.Sir_Abu_Nuayr,34,320,500)
    end
  else
  if abunmsg ~= true then
    abunred:Destroy()
    if abunblue:IsAlive() ~= true then
      abunblue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Abu Nuayr"):Spawn()
    end
    MESSAGE:New("Coalition Forces have retaken Abu Nuayr",30):ToAll()
   -- STTS.TextToSpeech("We have liberated Abu Nuayr from the Irani forces.",253.00,"AM",0.75,"TGW Command", 2 )
   -- STTS.TextToSpeech("We have lost Abu Nuayr, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 1 )
    abunmsg = true
    hm("> Abu Nuayr has been taken by Coalition Forces  ")
	spawnctld(AIRBASE.PersianGulf.Sir_Abu_Nuayr,2,320,500)
    end
  end

end
function slot_ejask(coalition)
	if coalition == 1 then
		if (ejaskmsg == nil) or (ejaskmsg == false) then
			MESSAGE:New("Bandar E-Jask Has been reataken by Iran",30):ToAll()
			hm("> Bandar-E-Jask Taken by Iran, Slots open")
			ejaskmsg = true
			spawnctld(AIRBASE.PersianGulf.Bandar_e_Jask_airfield,34,50,500)
		end
		trigger.action.setUserFlag("JF17 - Bandar-e-jask 1-1",00)
		trigger.action.setUserFlag("JF17 - Bandar-e-jask 1-2",00)
		trigger.action.setUserFlag("Hind_e_jask",00)
		trigger.action.setUserFlag("Hind_e_jask-1",00)
		trigger.action.setUserFlag("Hind_e_jask-2",100)
		trigger.action.setUserFlag("Hind_e_jask-3",100)
		trigger.action.setUserFlag("UH1_e_jask-1",100)
		trigger.action.setUserFlag("UH1_e_jask-2",100)
		trigger.action.setUserFlag("UH1_e_jask-3",00)
		trigger.action.setUserFlag("UH1_e_jask-4",00)
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,15000,"blue")
	else
		if (ejaskmsg == nil) or (ejaskmsg == true) then
			MESSAGE:New("Bandar E-Jask Has been taken by the Coalition",30):ToAll()
			ejaskmsg = false
			hm("> Bandar-E-Jask Taken by Iran, Slots closed")
			spawnctld(AIRBASE.PersianGulf.Bandar_e_Jask_airfield,2,50,500)
		end
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"red")
		trigger.action.setUserFlag("JF17 - Bandar-e-jask 1-1",100)
		trigger.action.setUserFlag("JF17 - Bandar-e-jask 1-2",100)
		trigger.action.setUserFlag("Hind_e_jask",100)
		trigger.action.setUserFlag("Hind_e_jask-1",100)
		trigger.action.setUserFlag("Hind_e_jask-2",00)
		trigger.action.setUserFlag("Hind_e_jask-3",00)
		trigger.action.setUserFlag("UH1_e_jask-1",00)
		trigger.action.setUserFlag("UH1_e_jask-2",00)
		trigger.action.setUserFlag("UH1_e_jask-3",100)
		trigger.action.setUserFlag("UH1_e_jask-4",100)
	end
end
function slot_havadarya(coalition)
  if coalition == 1 then
    if havmsg ~= false then
       havblue:Destroy()
      if havred:IsAlive() ~= true then
        havred:ReSpawn() 
      end
	  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Havadarya)
	  local _coord = ab:GetCoordinate()
	  routegroups(_coord,11000,"blue")
      trigger.action.setUserFlag("Frogfoot 31", 00)
      trigger.action.setUserFlag("Frogfoot 32", 00)
      trigger.action.setUserFlag("Frogfoot 33", 00)
      trigger.action.setUserFlag("Frogfoot 34", 00)
	  trigger.action.setUserFlag("Hav_hind", 100)
	  trigger.action.setUserFlag("Hav_hind-1", 100)
      trigger.action.setUserFlag("Hav US UH1", 100)
      trigger.action.setUserFlag("Hav US UH1 #001", 100)
      trigger.action.setUserFlag("Hav US UH1 #002", 100)
      trigger.action.setUserFlag("Hav US UH1 #003", 100)
      trigger.action.setUserFlag("Hav US KA50", 100)
      trigger.action.setUserFlag("Hav US KA50 #001", 100)
      trigger.action.setUserFlag("Hav US KA50 #002", 100)
      trigger.action.setUserFlag("Hav US KA50 #003", 100)
      local AN = AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab)
      if AN:GetCoalition() == 1 then
	  hm("> Havadarya has Western Slots Open due to Iran holding Khasab. ")
      trigger.action.setUserFlag("F18 Havadarya_Khasab",00)
      trigger.action.setUserFlag("F18 Havadarya_Khasab-1",00)
      trigger.action.setUserFlag("F15 Havadarya_Khasab",00)
      trigger.action.setUserFlag("F15 Havadarya_Khasab-1",00)
      trigger.action.setUserFlag("A10CII Havadarya_Khasab",00)
      trigger.action.setUserFlag("A10CII Havadarya_Khasab-1",00)
      trigger.action.setUserFlag("AV8 Havadarya_Khasab",00)
      trigger.action.setUserFlag("AV8 Havadarya_Khasab-1",00)
      end
      if usenew == false then
        ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},4)
      else
        i33rd_1:Start()
        if i33rd_1:GetSqnCount() == 0 then
          i33rd_1:SetSqnCount(4)
        end
      end
      MESSAGE:New("Havadarya has been retaken by the Irani People!",30):ToAll()
     -- STTS.TextToSpeech("We have liberated Havadarya from the Coalition.",253.00,"AM",0.75,"TGW Command", 1 )
    -- STTS.TextToSpeech("We have lost Havadarya to the Irani forces we must regroup and retake it.",253.00,"AM",0.75,"TGW Command", 2 )
      hm("> Havadarya has been taken by Iran ")
	  havspawn = false
      havmsg = false
	  spawnctld(AIRBASE.PersianGulf.Havadarya,34,0,500)
    end
  else
    if havmsg ~= true then
      havred:Destroy()
    if allowfobs == true then
		if havblue:IsAlive() ~= true then
			havblue:ReSpawn() 
		end
	end
	  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Havadarya)
	  local _coord = ab:GetCoordinate()
	  routegroups(_coord,8000,"red")
      trigger.action.setUserFlag("Frogfoot 31", 100)
      trigger.action.setUserFlag("Frogfoot 32", 100)
      trigger.action.setUserFlag("Frogfoot 33", 100)
      trigger.action.setUserFlag("Frogfoot 34", 100)
      trigger.action.setUserFlag("F18 Havadarya_Khasab",100)
      trigger.action.setUserFlag("F18 Havadarya_Khasab-1",100)
      trigger.action.setUserFlag("F15 Havadarya_Khasab",100)
      trigger.action.setUserFlag("F15 Havadarya_Khasab-1",100)
      trigger.action.setUserFlag("A10CII Havadarya_Khasab",100)
      trigger.action.setUserFlag("A10CII Havadarya_Khasab-1",100)
      trigger.action.setUserFlag("AV8 Havadarya_Khasab",100)
      trigger.action.setUserFlag("AV8 Havadarya_Khasab-1",100)
      trigger.action.setUserFlag("Hav US UH1", 00)
      trigger.action.setUserFlag("Hav US UH1 #001", 00)
      trigger.action.setUserFlag("Hav US UH1 #002", 00)
      trigger.action.setUserFlag("Hav US UH1 #003", 00)
      trigger.action.setUserFlag("Hav US KA50", 00)
      trigger.action.setUserFlag("Hav US KA50 #001", 00)
      trigger.action.setUserFlag("Hav US KA50 #002", 00)
      trigger.action.setUserFlag("Hav US KA50 #003", 00)
	  trigger.action.setUserFlag("Hav_hind", 00)
	  trigger.action.setUserFlag("Hav_hind-1", 00)
      if usenew == false then
        ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},0)      
      else
        i33rd_1:SetSqnCount(0)
        i33rd_1:Stop()
      end
      MESSAGE:New("Coalition forces have taken Havadarya!",30):ToAll()
    --  STTS.TextToSpeech("We have taken Havadarya, now we must hold it for the Irani Army will not be pleased",253.00,"AM",0.75,"TGW Command", 2 )
     -- STTS.TextToSpeech("We have lost Havadarya to the infidel invaders, we must respond immediately!.",253.00,"AM",0.75,"TGW Command", 1 )
      hm("> Havadarya has been taken by Coalition Forces")
      havmsg = true 
      SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
		if init == true then
		SCHEDULER:New(nil,function() 
			spawndefenders("havspawn")
		end,{},math.random(60,300))
		end
		spawnctld(AIRBASE.PersianGulf.Havadarya,2,010,500)
    end
  end
end
function slot_bandarlengeh(coalition)
  if coalition == 1 then
    
    if blenmsg ~= false then
      local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Lengeh)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"blue")
	  trigger.action.setUserFlag("Lengeh_JF11",00)
      trigger.action.setUserFlag("Lengeh_F14",00)
      trigger.action.setUserFlag("Lengeh_MiG29",00)
    
      local AN = AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab)
      if AN:GetCoalition() == 1 then
        trigger.action.setUserFlag("F15_Bandar_Lengeh_Khasab",00)
        trigger.action.setUserFlag("F18_Bandar_Lengeh_Khasab",00)
		hm("> F18 and F15 unlocked at Bandar Lengeh as Iran Holds Khasab.")
      end
    
      MESSAGE:New("Bandar Lengeh has been retaken from the coalition forces",30):ToAll()
  --   STTS.TextToSpeech("Bandar Lengeh is now under our control.",253.00,"AM",0.75,"TGW Command", 1 )
  --    STTS.TextToSpeech("We have lost Bandar Lengeh, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      hm("> Bandar Lengeh has been taken by Iran  ")
      blenmsg = false
	  bandarlspawn = false
	  spawnctld(AIRBASE.PersianGulf.Bandar_Lengeh,34,0,500)
    end
  else
    if blenmsg ~= true then
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Lengeh)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"red")
      trigger.action.setUserFlag("Lengeh_JF11",100)
      trigger.action.setUserFlag("Lengeh_F14",100)
      trigger.action.setUserFlag("Lengeh_MiG29",100)
      trigger.action.setUserFlag("F15_Bandar_Lengeh_Khasab",100)
      trigger.action.setUserFlag("F18_Bandar_Lengeh_Khasab",100)
      MESSAGE:New("Bandar Lengeh has been taken from the Irani People",30):ToAll()
  --    STTS.TextToSpeech("Bandar Lengeh has been lost",253.00,"AM",0.75,"TGW Command", 1 )
  --    STTS.TextToSpeech("We have taken Bandar Lengeh",253.00,"AM",0.75,"TGW Command", 2 )
      hm("> Bandar Lengeh has been taken by Coalition forces")
      SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
      if init == true then
	  SCHEDULER:New(nil,function() 
        spawndefenders("bandarlspawn")
      end,{},math.random(60,300))
	  end
      blenmsg = true
	  spawnctld(AIRBASE.PersianGulf.Bandar_Lengeh,2,0,500)
    end
  end

end
function slot_jir(coalition)
  if coalition == 1 then
    if jirmsg ~= false then
      trigger.action.setUserFlag("Pak-F16-Jiroft", 00)
      trigger.action.setUserFlag("Pak-F16-Jiroft #001", 00)
      trigger.action.setUserFlag("Pak-F16-Jiroft #002", 00)
	  trigger.action.setUserFlag("PINTO14-4",00)
      MESSAGE:New("Jiroft has been retaken from the coalition forces",30):ToAll()
 --     STTS.TextToSpeech("Jiroft is now under our control.",253.00,"AM",0.75,"TGW Command", 1 )
 --     STTS.TextToSpeech("We have lost Jiroft, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      hm("> Jiroft has been taken by Iran")
      jirmsg = false
	  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Jiroft_Airport)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"blue")
	  spawnctld(AIRBASE.PersianGulf.Jiroft_Airport,34,40,500)
    end
  else
    if jirmsg ~= false then
      trigger.action.setUserFlag("Pak-F16-Jiroft", 100)
      trigger.action.setUserFlag("Pak-F16-Jiroft #001", 100)
      trigger.action.setUserFlag("Pak-F16-Jiroft #002", 100)
	  trigger.action.setUserFlag("PINTO14-4",100)
      MESSAGE:New("Jiroft has fallen to coalition forces",30):ToAll()
 --    STTS.TextToSpeech("Jiroft is now under our control.",253.00,"AM",0.75,"TGW Command", 2 )
 --     STTS.TextToSpeech("We have lost Jiroft, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 1 )
      hm("> Havadarya has been taken by Coalition Forces  ")
      jirmsg = true
      SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
	  local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Jiroft_Airport)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"red")
	  spawnctld(AIRBASE.PersianGulf.Jiroft_Airport,34,40,500)
	  spawnctld(AIRBASE.PersianGulf.Jiroft_Airport,2,40,500)
    end
  end
end


function slot_fuj(coalition)
  if coalition == 1 then    
    if fujmsg ~= false then
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Fujairah_Intl)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,25000,"blue")
		trigger.action.setUserFlag("Fujairah_Hind",00)
		trigger.action.setUserFlag("Fujairah_Hind-1",00)
		trigger.action.setUserFlag("Fujairah_Hind-2",100)
		trigger.action.setUserFlag("Fujairah_Hind-3",100)
		trigger.action.setUserFlag("MI8_Fujairah_02-2",00)
		trigger.action.setUserFlag("MI8_Fujairah_02-1",00)
		trigger.action.setUserFlag("UH1_Fujairah_02-1",00)
		trigger.action.setUserFlag("UH1_Fujairah_02-2",00)
		trigger.action.setUserFlag("KA50_Fujairah_02-1",00)
		trigger.action.setUserFlag("KA50_Fujairah_02-2",00)
		trigger.action.setUserFlag("MI8_Fujairah_01-2",100)
		trigger.action.setUserFlag("MI8_Fujairah_01-1",100)
		trigger.action.setUserFlag("UH1_Fujairah_01-1",100)
		trigger.action.setUserFlag("UH1_Fujairah_01-2",100)
		trigger.action.setUserFlag("KA50_Fujairah_01-1",100)
		trigger.action.setUserFlag("KA50_Fujairah_01-2",100)
		trigger.action.setUserFlag("AV8_Fujairah_01-2",100)
		trigger.action.setUserFlag("AV8_Fujairah_01-1",100)
		trigger.action.setUserFlag("A10II_Fujairah_01-1",100)
		trigger.action.setUserFlag("A10II_Fujairah_01-2",100)
		MESSAGE:New("Fujairah has been retaken from the coalition forces",30):ToAll()
        hm("> Fujairah has been taken by Iran  ")
		fujmsg = false
		fujspawn = false
		spawnctld(AIRBASE.PersianGulf.Fujairah_Intl,34,180,500)
    end
  else
    if fujmsg ~= true then
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Fujairah_Intl)
		local _coord = ab:GetCoordinate()
		routegroups(_coord,15000,"red")
		trigger.action.setUserFlag("Fujairah_Hind",100)
		trigger.action.setUserFlag("Fujairah_Hind-1",100)
		trigger.action.setUserFlag("Fujairah_Hind-2",00)
		trigger.action.setUserFlag("Fujairah_Hind-3",00)
		trigger.action.setUserFlag("MI8_Fujairah_02-2",100)
		trigger.action.setUserFlag("MI8_Fujairah_02-1",100)
		trigger.action.setUserFlag("UH1_Fujairah_02-1",100)
		trigger.action.setUserFlag("UH1_Fujairah_02-2",100)
		trigger.action.setUserFlag("KA50_Fujairah_02-1",100)
		trigger.action.setUserFlag("KA50_Fujairah_02-2",100)
		trigger.action.setUserFlag("MI8_Fujairah_01-2",000)
		trigger.action.setUserFlag("MI8_Fujairah_01-1",000)
		trigger.action.setUserFlag("UH1_Fujairah_01-1",000)
		trigger.action.setUserFlag("UH1_Fujairah_01-2",000)
		trigger.action.setUserFlag("KA50_Fujairah_01-1",000)
		trigger.action.setUserFlag("KA50_Fujairah_01-2",000)
		trigger.action.setUserFlag("AV8_Fujairah_01-2",000)
		trigger.action.setUserFlag("AV8_Fujairah_01-1",000)
		trigger.action.setUserFlag("A10II_Fujairah_01-1",000)
		trigger.action.setUserFlag("A10II_Fujairah_01-2",000)
		MESSAGE:New("Fujairah has been taken from the Irani People",30):ToAll()
        hm("> Fujairah has been taken by Coalition forces")
		SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
		fujmsg = true
		spawnctld(AIRBASE.PersianGulf.Fujairah_Intl,2,180,500)
    end
  end
end


function locklhab()
  trigger.action.setUserFlag("LHA3-AV8",100)
  trigger.action.setUserFlag("LHA3-AV8 #001",100)
  trigger.action.setUserFlag("LHA3-AV8 #002",100)
  trigger.action.setUserFlag("LHA3-AV8 #003",100)
  trigger.action.setUserFlag("LHA3-KA50",100)
  trigger.action.setUserFlag("LHA3-KA50 #001",100)
  trigger.action.setUserFlag("LHA3-UH1",100)
  trigger.action.setUserFlag("LHA3-UH1 #001",100)
  trigger.action.setUserFlag("LHA3-UH1 #002",100)
  trigger.action.setUserFlag("LHA3-UH1 #003",100) 
  hm("> LHA3 Slots are now De-Active")
end

function locklha4()
  trigger.action.setUserFlag("LHA4-Hind",100)
  trigger.action.setUserFlag("LHA4-UH1",100)  
  trigger.action.setUserFlag("LHA4-UH1 #001",100)
  trigger.action.setUserFlag("LHA4-UH1 #002",100)
  trigger.action.setUserFlag("LHA4-UH1 #003",100)
  trigger.action.setUserFlag("LHA4-KA50",100)
  trigger.action.setUserFlag("LHA4-KA50 #001",100)
  trigger.action.setUserFlag("LHA4-AV8",100)
  trigger.action.setUserFlag("LHA4-AV8 #001",100)
  trigger.action.setUserFlag("LHA4-AV8 #002",100)
  trigger.action.setUserFlag("LHA4-AV8 #003",100)
  hm("> LHA4 Slots are now De-Active")
end

function checkislands()
  if (tk:GetCoalition() == 2) and (ta:GetCoalition() == 2) then
	if bandaractive == false then
	BASE:E({"Blue holds the Tunb Islands Activating Bandar LHA"})
    local acti = GROUP:FindByName("LHA_BANDAR"):Activate()
    bandaractive = true
    MESSAGE:New("Marine Forces are moving up to the Bandar Coast Slots now Open",30):ToBlue()
    hm("> LHA3 Slots are now Active")
    trigger.action.setUserFlag("LHA3-AV8",00)
    trigger.action.setUserFlag("LHA3-AV8 #001",00)
    trigger.action.setUserFlag("LHA3-AV8 #002",00)
    trigger.action.setUserFlag("LHA3-AV8 #003",00)
    trigger.action.setUserFlag("LHA3-KA50",00)
    trigger.action.setUserFlag("LHA3-KA50 #001",00)
    trigger.action.setUserFlag("LHA3-UH1",00)
    trigger.action.setUserFlag("LHA3-UH1 #001",00)
    trigger.action.setUserFlag("LHA3-UH1 #002",00)
    trigger.action.setUserFlag("LHA3-UH1 #003",00)  
	trigger.action.setUserFlag("IRAF91-1",00)  
  end
 end
 if am == nil then
	am = AIRBASE:FindByName(AIRBASE.PersianGulf.Abu_Musa_Island_Airport)
 end
 if (am:GetCoalition() == 2) and (si:GetCoalition() == 2) then
  if kishactive == false then
	BASE:E({"Blue holds the Tunb Islands Activating Bandar LHA"})
    local acti = GROUP:FindByName("LHA_KISH"):Activate()
    kishactive = true
    MESSAGE:New("Marine Forces are moving up towards Kish Island, Slots now Open",30):ToBlue()
    hm("> LHA4 Slots are now Active")
    trigger.action.setUserFlag("LHA4-Hind",00)
	trigger.action.setUserFlag("LHA4-UH1",00)
    trigger.action.setUserFlag("LHA4-UH1 #001",00)
    trigger.action.setUserFlag("LHA4-UH1 #002",00)
    trigger.action.setUserFlag("LHA4-UH1 #003",00)
    trigger.action.setUserFlag("LHA4-KA50",00)
    trigger.action.setUserFlag("LHA4-KA50 #001",00)
    trigger.action.setUserFlag("LHA4-AV8",00)
    trigger.action.setUserFlag("LHA4-AV8 #001",00)
    trigger.action.setUserFlag("LHA4-AV8 #002",00)
    trigger.action.setUserFlag("LHA4-AV8 #003",00)
  end
 end
end

locklhab()
locklha4()
slot_tunb(1)
slot_sirri(1)
slot_lavan(1)
slot_kish(1)
slot_qeshm(1)
slot_khasab(2)
slot_bandar(1)
slot_lars(1)
slot_abun(2)
slot_havadarya(1)
slot_ejask(1)
slot_fuj(2)
airbases = {}
function SEH:OnEventBaseCaptured(EventData)
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
  -- local coalition = EventData.getCoalition()
 BASE:E({"Main Slot Controller BASE Captured Detected" .. AirbaseName,coalition})  
 if AirbaseName == AIRBASE.PersianGulf.Lar_Airbase then
    BASE:E({"Lars Slot Change"})
    slot_lars(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Sir_Abu_Nuayr then
    ctld.changeRemainingGroupsForPickupZone("CTLD Abu Nuayr", 3)
    slot_abun(coalition)    
 elseif AirbaseName == AIRBASE.PersianGulf.Sirri_Island then
    slot_sirri(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Abu_Musa_Island_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Abu Musa",3)
 elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Kochak then
    ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Kochak", 3)
 elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Island_AFB then
    slot_tunb(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Lavan_Island_Airport then
    slot_lavan(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Kish_International_Airport then
    slot_kish(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Qeshm_Island then
    slot_qeshm(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Khasab then
    slot_khasab(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl then
    slot_bandar(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Jiroft_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Jiroft", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Shiraz_International_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Shiraz", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Kerman_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Kerman", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Havadarya then
    slot_havadarya(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Bandar_Lengeh then
    slot_bandarlengeh(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Bandar_e_Jask_airfield then
	slot_ejask(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Fujairah_Intl then
	slot_fuj(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Kerman_Airport then
    if coalition == 1 then
      if kerman == true then
        kerman = false
      end
    else
      if kerman == false then
        kerman = true
      end
    end
  elseif AirbaseName == AIRBASE.PersianGulf.Shiraz_International_Airport then
    if coalition == 1 then
      if shiraz == true then
        shiraz = false
      end
    else
      if shiraz == false then
        shiraz = true
      end
    end
 
 else
  local col = "Coalition"
  if coalition == 1 then
    col = "Iran"
    else
    col = "Coalition"
    end
	if airbases[AirbaseName] ~= coalition then
		BASE:E({"Warning Airbase: ".. AirbaseName .." was lost to .. " ..col.. ""})
		MESSAGE:New("Warning Airbase: ".. AirbaseName .." was lost to .. " ..col.. "",30):ToAll()
		hm("> **Warning Airbase: ".. AirbaseName .." was lost to .. " ..col.. "**")
		airbases[AirbaseName] = coalition
		if coalition == 2 then
			SCHEDULER:New(nil,spawnislands,{},math.random(60,1200))
			SCHEDULER:New(nil,spawnmainland,{},math.random(60,1200))
			local ABItem = AIRBASE:FindByName(AirbaseName)
			local coalition = ABItem:GetCoalition()
			local _coord = ABItem:GetCoordinate()
			routegroups(_coord,15000,"red")
		else
			local ABItem = AIRBASE:FindByName(AirbaseName)
			local coalition = ABItem:GetCoalition()
			local _coord = ABItem:GetCoordinate()
			routegroups(_coord,15000,"blue")
		end
  end
 end
 
 -- Do a check for all 4 red islands if there blue we want to switch on the 2 tarawa's and their slots
 checkislands()
end



function lh3:OnEventDead(EventData)
  BASE:E({"LHA3 end"})
  trigger.action.setUserFlag("LHA3-AV8",100)
  trigger.action.setUserFlag("LHA3-AV8 #001",100)
  trigger.action.setUserFlag("LHA3-AV8 #002",100)
  trigger.action.setUserFlag("LHA3-AV8 #003",100)
  trigger.action.setUserFlag("LHA3-KA50",100)
  trigger.action.setUserFlag("LHA3-KA50 #001",100)
  trigger.action.setUserFlag("LHA3-UH1",100)
  trigger.action.setUserFlag("LHA3-UH1 #001",100)
  trigger.action.setUserFlag("LHA3-UH1 #002",100)
  trigger.action.setUserFlag("LHA3-UH1 #003",100) 
  hm("> *LHA3 DESTROYED!* Slots are now locked  ")
end

function lh4:OnEventDead(EventData)
  BASE:E({"LHA4 end"})
  trigger.action.setUserFlag("LHA4-UH1",100)
  trigger.action.setUserFlag("LHA4-UH1 #001",100)
  trigger.action.setUserFlag("LHA4-UH1 #002",100)
  trigger.action.setUserFlag("LHA4-UH1 #003",100)
  trigger.action.setUserFlag("LHA4-KA50",100)
  trigger.action.setUserFlag("LHA4-KA50 #001",100)
  trigger.action.setUserFlag("LHA4-AV8",100)
  trigger.action.setUserFlag("LHA4-AV8 #001",100)
  trigger.action.setUserFlag("LHA4-AV8 #002",100)
  trigger.action.setUserFlag("LHA4-AV8 #003",100)
  hm("> **LHA4 DESTROYED!** ")
end
function slot_wash()
	if GW:IsAlive() ~= true then
		trigger.action.setUserFlag("GW_450",100)
		trigger.action.setUserFlag("GW_451",100)
		trigger.action.setUserFlag("GW_452",100)
		trigger.action.setUserFlag("GW_454",100)
		trigger.action.setUserFlag("GW_221",100)
		trigger.action.setUserFlag("GW_222",100)
		trigger.action.setUserFlag("GW_223",100)
		trigger.action.setUserFlag("GW_224",100)
		hm("> **USS George Washington DESTROYED!** Slots are now locked")
	else
		trigger.action.setUserFlag("GW_450",00)
		trigger.action.setUserFlag("GW_451",00)
		trigger.action.setUserFlag("GW_452",00)
		trigger.action.setUserFlag("GW_454",00)
		trigger.action.setUserFlag("GW_221",00)
		trigger.action.setUserFlag("GW_222",00)
		trigger.action.setUserFlag("GW_223",00)
		trigger.action.setUserFlag("GW_224",00)
		hm("> **USS George Washington returns** Slots are now ulocked")
	end
end

function GW:OnEventDead(EventData)
  slot_wash()
end

function slot_stennis()
  if stn:IsAlive() ~= true then
    trigger.action.setUserFlag("STN_141",100)
    trigger.action.setUserFlag("STN_142",100)
    trigger.action.setUserFlag("STN_143",100)
    trigger.action.setUserFlag("STN_144",100)
    trigger.action.setUserFlag("STN_440",100)
    trigger.action.setUserFlag("STN_441",100)
    trigger.action.setUserFlag("STN_442",100)
    trigger.action.setUserFlag("STN_443",100)
    trigger.action.setUserFlag("STN_444",100)
	hm("> **USS Stennis DESTROYED!** Slots are now locked")
  else
	trigger.action.setUserFlag("STN_141",00)
	trigger.action.setUserFlag("STN_142",00)
	trigger.action.setUserFlag("STN_143",00)
	trigger.action.setUserFlag("STN_144",00)
	trigger.action.setUserFlag("STN_440",00)
	trigger.action.setUserFlag("STN_441",00)
	trigger.action.setUserFlag("STN_442",00)
	trigger.action.setUserFlag("STN_443",00)
	trigger.action.setUserFlag("STN_444",00)
	hm("> **USS Stennis returned Slots are now unlocked")
  end

end
function stn:OnEventDead(EventData)
  slot_stennis()
end

function lh2slot()
	if lh2:IsAlive() ~= true then
		trigger.action.setUserFlag("STN-LHA2-Huey333",100)
		trigger.action.setUserFlag("STN-LHA2-Huey334",100)
		trigger.action.setUserFlag("STN-LHA2-Huey335",100)
		trigger.action.setUserFlag("STN-LHA2-Huey336",100)
		trigger.action.setUserFlag("STN-TAR-490",100)
		trigger.action.setUserFlag("STN-TAR-491",100)
		trigger.action.setUserFlag("STN-TAR-492",100)
		trigger.action.setUserFlag("STN-TAR-493",100)
		trigger.action.setUserFlag("STN-TAR-494",100)
		hm("> **LHA2 in the Stennis Battlegroup DESTROYED!** Slots are now locked")
	else
		
			trigger.action.setUserFlag("STN-LHA2-Huey333",00)
			trigger.action.setUserFlag("STN-LHA2-Huey334",00)
			trigger.action.setUserFlag("STN-LHA2-Huey335",00)
			trigger.action.setUserFlag("STN-LHA2-Huey336",00)
			trigger.action.setUserFlag("STN-TAR-490",00)
			trigger.action.setUserFlag("STN-TAR-491",00)
			trigger.action.setUserFlag("STN-TAR-492",00)
			trigger.action.setUserFlag("STN-TAR-493",00)
			trigger.action.setUserFlag("STN-TAR-494",00)
			hm("> **LHA2 in the Stennis Battlegroup BACK!** Slots are now unlocked")
	end
end

function lh2:OnEventDead(EventData)
  lh2slot()
end

function tdyslot()
	if tdy:IsAlive() ~= true then
		trigger.action.setUserFlag("TDY_101",100)
		trigger.action.setUserFlag("TDY_102",100)
		trigger.action.setUserFlag("TDY_103",100)
		trigger.action.setUserFlag("TDY_104",100)
		trigger.action.setUserFlag("TDY_105",100)
		trigger.action.setUserFlag("TDY_106",100)
		trigger.action.setUserFlag("TDY_107",100)
		trigger.action.setUserFlag("TDY_108",100)
		trigger.action.setUserFlag("TDY_401",100)
		trigger.action.setUserFlag("TDY_402",100)
		trigger.action.setUserFlag("TDY_403",100)
		trigger.action.setUserFlag("TDY_404",100)
		trigger.action.setUserFlag("TDY_405",100)
		trigger.action.setUserFlag("TDY_406",100)
		trigger.action.setUserFlag("TDY_407",100)
		trigger.action.setUserFlag("TDY_408",100)
		trigger.action.setUserFlag("TDY_409",100)
		trigger.action.setUserFlag("TDY_410",100)
		trigger.action.setUserFlag("TDY_411",100)
		trigger.action.setUserFlag("TDY_412",100)
		hm("> **USS Theodore Rosevolt DESTROYED!** Slots are now locked")
	else
		trigger.action.setUserFlag("TDY_101",00)
		trigger.action.setUserFlag("TDY_102",00)
		trigger.action.setUserFlag("TDY_103",00)
		trigger.action.setUserFlag("TDY_104",00)
		trigger.action.setUserFlag("TDY_105",00)
		trigger.action.setUserFlag("TDY_106",00)
		trigger.action.setUserFlag("TDY_107",00)
		trigger.action.setUserFlag("TDY_108",00)
		trigger.action.setUserFlag("TDY_401",00)
		trigger.action.setUserFlag("TDY_402",00)
		trigger.action.setUserFlag("TDY_403",00)
		trigger.action.setUserFlag("TDY_404",00)
		trigger.action.setUserFlag("TDY_405",00)
		trigger.action.setUserFlag("TDY_406",00)
		trigger.action.setUserFlag("TDY_407",00)
		trigger.action.setUserFlag("TDY_408",00)
		trigger.action.setUserFlag("TDY_409",00)
		trigger.action.setUserFlag("TDY_410",00)
		trigger.action.setUserFlag("TDY_411",00)
		trigger.action.setUserFlag("TDY_412",00)
		hm("> **USS Theodore Rosevolt BACK** Slots are now unlocked")
	end
end
function tdy:OnEventDead(EventData)
  tdyslot()
end

function tar_slot()
	if tar:IsAlive() ~= true then
    trigger.action.setUserFlag("TDY-TAR-480",100)
    trigger.action.setUserFlag("TDY-TAR-481",100)
    trigger.action.setUserFlag("TDY-TAR-482",100)
    trigger.action.setUserFlag("TDY-TAR-484",100)
    trigger.action.setUserFlag("TDY-TAR-Huey-303",100)
    trigger.action.setUserFlag("TDY-TAR-Huey314",100)
    trigger.action.setUserFlag("TDY-TAR-Huey319",100)
    trigger.action.setUserFlag("TDY-TAR-Huey444",100)
    trigger.action.setUserFlag("TED-TAR-KA50-21",100)
    trigger.action.setUserFlag("TED-TAR-KA50-22",100)
    trigger.action.setUserFlag("TED-TAR-KA50-23",100)
    trigger.action.setUserFlag("TED-TAR-KA50-24",100)
    trigger.action.setUserFlag("TED-TAR-Mi8-55",100)
    trigger.action.setUserFlag("TED-TAR-Mi8-56",100)
    trigger.action.setUserFlag("TED-TAR-SA342L-44",100)
    trigger.action.setUserFlag("TED-TAR-SA342L-45",100)
    trigger.action.setUserFlag("TED-TAR-SA342Min-222",100)
    trigger.action.setUserFlag("TED-TAR-SA342Min-223",100)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-111",100)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-112",100)
    trigger.action.setUserFlag("TED-TAR-SA342m-66",100)
    trigger.action.setUserFlag("TED-TAR-SA342m-67",100)
	hm("> **USS TARAWA Destroyed!** Slots are now locked")
	else
		
    trigger.action.setUserFlag("TDY-TAR-480",00)
    trigger.action.setUserFlag("TDY-TAR-481",00)
    trigger.action.setUserFlag("TDY-TAR-482",00)
    trigger.action.setUserFlag("TDY-TAR-484",00)
    trigger.action.setUserFlag("TDY-TAR-Huey-303",00)
    trigger.action.setUserFlag("TDY-TAR-Huey314",00)
    trigger.action.setUserFlag("TDY-TAR-Huey319",00)
    trigger.action.setUserFlag("TDY-TAR-Huey444",00)
    trigger.action.setUserFlag("TED-TAR-KA50-21",00)
    trigger.action.setUserFlag("TED-TAR-KA50-22",00)
    trigger.action.setUserFlag("TED-TAR-KA50-23",00)
    trigger.action.setUserFlag("TED-TAR-KA50-24",00)
    trigger.action.setUserFlag("TED-TAR-Mi8-55",00)
    trigger.action.setUserFlag("TED-TAR-Mi8-56",00)
    trigger.action.setUserFlag("TED-TAR-SA342L-44",00)
    trigger.action.setUserFlag("TED-TAR-SA342L-45",00)
    trigger.action.setUserFlag("TED-TAR-SA342Min-222",00)
    trigger.action.setUserFlag("TED-TAR-SA342Min-223",00)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-111",00)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-112",00)
    trigger.action.setUserFlag("TED-TAR-SA342m-66",00)
    trigger.action.setUserFlag("TED-TAR-SA342m-67",00)
	hm("> **USS TARAWA BACK!** Slots are now unlocked")
	
  end

end

function tar:OnEventDead(EventData)
  tar_slot()
end


world.addEventHandler(SEH)

BASE:E({"SLOT HANDLER FOR PERSIA AFLAME LOADED"})


BASE:E({"Rob's Fob dynamic script, Handles the capturing and changes of Fobs and Farps."})

fob = {
ClassName = "FOBS",
fobname = nil,
fobunit = nil,
coalition = 1,
redspawn = nil,
bluespawn = nil,
group = nil,
bluestaticlist = { },
redstaticlist = { },
blueslots = {},
redslots = {},
}

function fob:New(name,redspawn,bluespawn,coalition,heading)
  local self = BASE:Inherit(self,BASE:New())
  self.fobname = name
  self.heading = heading
  self.fobunit = STATIC:FindByName(name)
  self.coalition = coalition
  self.lastcoalition = coalition
  self.group = nil
  self.redspawn = redspawn:InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
		local co = spawngroup:GetCoordinate()
		local plus = math.random(1,2)
		local movement = math.random(0,10)
		if plus == 1 then
			heading = heading + movement
		else
			heading = heading - movement
		end
		if heading > 360 then heading = heading - 360 end
		if heading < 0 then heading = heading + 360 end
		co:Translate(100,heading,false,true)
		local vec3 = co:GetVec3()
		local _unitId = ctld.getNextUnitId()
		local _name = "ctld Deployed FOB #" .. _unitId
		local _fob = nil
		_fob = ctld.spawnFOB(34, 211, vec3, _name)
		table.insert(ctld.logisticUnits, _fob:getName())
		if ctld.troopPickupAtFOB == true then
			table.insert(ctld.builtFOBS, _fob:getName())
		end
  end)
  self.bluespawn = bluespawn:InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
		local plus = math.random(1,2)
		local movement = math.random(0,10)
		if plus == 1 then
			heading = heading + movement
		else
			heading = heading - movement
		end
		if heading > 360 then heading = heading - 360 end
		if heading < 0 then heading = heading + 360 end
		local co = spawngroup:GetCoordinate()
		co:Translate(100,heading,false,true)
		local vec3 = co:GetVec3()
		local _unitId = ctld.getNextUnitId()
		local _name = "ctld Deployed FOB #" .. _unitId
		local _fob = nil
		_fob = ctld.spawnFOB(2, 211, vec3, _name)
		table.insert(ctld.logisticUnits, _fob:getName())
		if ctld.troopPickupAtFOB == true then
			table.insert(ctld.builtFOBS, _fob:getName())
		end
  end)
  self.marker = nil
  BASE:E({self.fobname,"Created",self.coalition})
  return self
end

function fob:AddRedSlots(slotlist)
  self.redslots = slotlist
end

function fob:AddBlueSlots(slotlist)
  self.blueslots = slotlist
end

function fob:SetCTLD(ctldvalue,zone)
  self.ctld = ctldvalue
  self.zone = zone
end

function fob:FlipRed()
  BASE:E({self.fobname,"Flip Red"})
  for k,v in pairs(self.redslots) do 
      trigger.action.setUserFlag(v,00)
      BASE:E({self.fobname,"Slot 00",v})
  end
  for k,v in pairs(self.blueslots) do 
      trigger.action.setUserFlag(v,100)
      BASE:E({self.fobname,"Slot 100",v})
  end
  if self.group ~= nil then
	if self.group:IsAlive() == true then
		self.group:Destroy()
	end
  end
 SCHEDULER:New(nil,function() 
	self:spawnred() 
   end,{},60)
  self.coalition = 1
  self.lastcoalition = 2

end

function fob:spawnred()
  self.group = self.redspawn:Spawn()
end

function fob:spawnblue()
  self.group = self.bluespawn:Spawn()
end

function fob:FlipBlue()
  BASE:E({self.fobname,"Flip Blue"})
  for k,v in pairs(self.redslots) do
      BASE:E({self.fobname,"Slot 100",v}) 
      trigger.action.setUserFlag(v,100)
  end
  for k,v in pairs(self.blueslots) do 
      BASE:E({self.fobname,"Slot 00",v})
      trigger.action.setUserFlag(v,00)
  end
  if self.group ~= nil then
	if self.group:IsAlive() == true then
		self.group:Destroy()
	end
  end
  SCHEDULER:New(nil,function() 
	self:spawnblue() 
   end,{},60)
  self.coalition = 2
  self.lastcoalition = 1
end

function fob:AddBlueStatics(statics)
  self.bluestaticlist = statics
end
function fob:AddRedStatics(statics)
  self.redstaticlist = statics
end

function fob:Startup()
  BASE:E({self.fobname,"Starting up"})
  local col = "Iran"
  if self.coalition == 1 then
    self:FlipRed()
  else
    self:FlipBlue()
    col = "Coalition"
	self.coalition = 2
  end  
  self:HandleEvent(EVENTS.BaseCaptured) 
  local co = self.fobunit:GetCoordinate()
  --elf.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
end


function fob:IsBlue()
  if self.fobunit.coalition == 2 then
    return true
  else
    return false
  end
end

function fob:OnEventBaseCaptured(EventData)
 --BASE:E({self.fobname,"Base capture"})
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
 local _coord = ABItem:GetCoordinate()
 --BASE:E({self.fobname,"Base capture",coalition})
 if AirbaseName == self.fobname then
  if coalition == 2 and self.coalition ~= 2 then
      if self:IsBlue() ~= true then
        self:FlipBlue()
        local col = "Coalition"
        --COORDINATE:RemoveMark(self.marker)
		local co = self.fobunit:GetCoordinate()
		routegroups(_coord,15000,"red")
        --self.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
      end
  elseif coalition == 1 and self.coalition ~= 1 then
      if self:IsBlue() == true then
        self:FlipRed()
        local col = "Coalition"
        --COORDINATE:RemoveMark(self.marker)
		local co = self.fobunit:GetCoordinate()
		routegroups(_coord,15000,"blue")
        --self.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
      end
  end
 end
end

staticactive = false

EP = fob:New("EP",SPAWN:New("red_ep"),SPAWN:New("blue_ep"),1,0)
EP:AddRedStatics({"EPLOG"})
EP:AddBlueStatics({"EPBLOG"})
EP:AddRedSlots({"EPUH2","EPUH2-1","EPKA50-2","EPKA50-3","EPMI8-2","EPMI8-3"})
EP:AddBlueSlots({"EPUH1","EPUH1-1","EPKA50","EPKA50-1","EPMI8","EPMI8-1"})
EP:Startup()

EQ = fob:New("EQ",SPAWN:New("red_EQ"),SPAWN:New("blue_EQ"),1,280)
EQ:AddRedStatics({"EQRLOG"})
EQ:AddBlueStatics({"EQBLOG"})
EQ:AddRedSlots({"EQUH2","EQUH2-1"})
EQ:AddBlueSlots({"EQUH1","EQUH1-1"})
EQ:Startup()

ER = fob:New("ER",SPAWN:New("red_ER"),SPAWN:New("blue_ER"),1,90)
ER:AddRedStatics({"ERRLOG"})
ER:AddBlueStatics({"ERBLOG"})
ER:AddRedSlots({"ERUH2","ERUH2-1"})
ER:AddBlueSlots({"ERUH1","ERUH1-1"})
ER:Startup()

FR = fob:New("FR",SPAWN:New("red_FR"),SPAWN:New("blue_FR"),1,0)
FR:AddRedStatics({"FRRLOG"})
FR:AddBlueStatics({"FRBLOG"})
FR:AddRedSlots({"FRUH2","FRUH2-1"})
FR:AddBlueSlots({"FRUH1","FRUH1-1"})
FR:Startup()

FDR = fob:New("farp fdr35",SPAWN:New("farp_resup"),SPAWN:New("farp_resupb"),1,0)
FDR:AddRedStatics({"CTLD FDR35"})
FDR:AddBlueStatics({"CTLD FDR35 B"})
FDR:AddRedSlots({"BFARP KA50","BFARP KA50 #001","BFARP UH1","BFARP MI8","BFARP UH1-1","BFARP MI8-1"})
FDR:AddBlueSlots({"BFARP UH1-2","BFARP UH1-3","BFARP KA501-1","BFARP KA501","BFARP MI81","BFARP MI81-1",})
FDR:Startup()

CR = fob:New("CR",SPAWN:New("red_CR"),SPAWN:New("blue_CR"),1,90)
CR:AddRedStatics({"CRRLOG"})
CR:AddBlueStatics({"CRBLOG"})
CR:AddRedSlots({"CRUH2-1","CRUH2","CRKA502","CRKA502-1"})
CR:AddBlueSlots({"CRUH1","CRUH1-1","CRKA501","CRKA501-1"})
CR:Startup()

BQ = fob:New("BQ",SPAWN:New("red_BQ"),SPAWN:New("blue_BQ"),1,90)
BQ:AddRedStatics({"BQRLOG"})
BQ:AddBlueStatics({"BQBLOG"})
BQ:AddRedSlots({"BQUH2","BQUH2-1","BQKA502","BQKA502-1"})
BQ:AddBlueSlots({"BQUH1","BQUH1-1","BQKA501","BQKA501-1"})
BQ:Startup()




CQ = fob:New("CQ",SPAWN:New("red_CQ"),SPAWN:New("blue_CQ"),1,0)
CQ:AddRedStatics({"CQRLOG"})
CQ:AddBlueStatics({"CQBLOG"})
CQ:AddRedSlots({"CQUH2","CQUH2-1","CQKA50","BQKA502-1"})
CQ:AddBlueSlots({"CQUH1","CQUH1-1","CQKA502","CQKA502-1"})
CQ:Startup()

BR = fob:New("BR",SPAWN:New("red_BR"),SPAWN:New("blue_BR"),1,0)
BR:AddRedStatics({"BRRLOG"})
BR:AddBlueStatics({"BRBLOG"})
BR:AddRedSlots({"BRUH2","BRUH2-1"})
BR:AddBlueSlots({"BRUH1","BRUH1-1"})
BR:Startup()

BS = fob:New("BS",SPAWN:New("red_BS"),SPAWN:New("blue_BS"),1,135)
BS:AddRedStatics({"BSRLOG"})
BS:AddBlueStatics({"BSBLOG"})
BS:AddRedSlots({"BSUH2","BSUH2-1","BSKA50-2","BSKA50-3"})
BS:AddBlueSlots({"BSUH1","BSUH1-1","BSKA50","BSKA50-1"})
BS:Startup()

YN = fob:New("YN",SPAWN:New("red_YN"),SPAWN:New("blue_YN"),1,0)
YN:AddRedStatics({"YNRLOG"})
YN:AddBlueStatics({"YNBLOG"})
YN:AddRedSlots({"YNUH2","YNUH2-1","BSKA502","BSKA502-1"})
YN:AddBlueSlots({"YNUH1","YNUH1-1","YNKA501","YNKA501-1"})
YN:Startup()

DS = fob:New("DS",SPAWN:New("red_DS"),SPAWN:New("blue_DS"),1,0)
DS:AddRedStatics({"DSRLOG"})
DS:AddBlueStatics({"DSBLOG"})
DS:AddRedSlots({"DSUH2","DSUH2-1","DSKA502","DSKA502-1"})
DS:AddBlueSlots({"DSUH1","DSUH1-1","DSKA50-1","DSKA50"})
DS:Startup()

CT = fob:New("CT",SPAWN:New("red_CT"),SPAWN:New("blue_CT"),1,0)
CT:AddRedStatics({"CTRLOG"})
CT:AddBlueStatics({"CTBLOG"})
CT:AddRedSlots({"CTUH2","CTUH2-1","CTKA502","CTKA502-1"})
CT:AddBlueSlots({"CTUH1","CTUH1-1","CTKA501","CTKA501-1"})
CT:Startup()

DU = fob:New("DU",SPAWN:New("red_DU"),SPAWN:New("blue_DU"),1,0)
DU:AddRedStatics({"DURLOG"})
DU:AddBlueStatics({"DUBLOG"})
DU:AddRedSlots({"DUUH2","DUUH2-1","DUKA502","DUKA502-1"})
DU:AddBlueSlots({"DUUH1","DUUH1-1","DUKA501","DUKA501-1"})
DU:Startup()

BQ51 = fob:New("BQ51",SPAWN:New("red_BQ51"),SPAWN:New("blue_BQ51"),1,0)
BQ51:AddRedStatics({"BQRLOG51"})
BQ51:AddBlueStatics({"BQBLOG51"})
BQ51:AddRedSlots({"BQ51UH2-1","BQ51UH2"})
BQ51:AddBlueSlots({"BQ51UH1","BQ51UH1-2"})
BQ51:Startup()

YK = fob:New("YK",SPAWN:New("red_YK"),SPAWN:New("blue_YK"),1,0)
YK:AddRedStatics({"YKRLOG"})
YK:AddBlueStatics({"YKBLOG"})
YK:AddBlueSlots({"YKUH1","YKUH1-2"})
YK:AddRedSlots({"YKUH2-1","YKUH2-2"})
YK:Startup()
BASE:E({"FOB HANDLER DONE"})

SCHEDULER:New(nil,function()
BASE:E({"Loading is now false"})
Loading = false
 end,{},240)
 
SCHEDULER:New(nil,function()
 spawnislands()
 end,{},math.random(240,600))
 
SCHEDULER:New(nil,function()
 spawnmainland()
 end,{},math.random(600,600))
 
 
 -- hm("Statics for FOB Active is set to : `" ..staticactive .. " ` if false you will ALWAYS require the taking of FOB crates to the FARP bases")