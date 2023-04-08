

Arco11 = GROUP:FindByName("Arco 11")
arcocount = 0
arcolimit = 4

Texaco11 = GROUP:FindByName("Texaco 11")
texacocount = 0
texacol1imit = 4

Texaco21 = GROUP:FindByName("Texaco 21")
texaco2count = 0
texaco2limit = 4


Overlord = GROUP:FindByName("USEW Overlord")
Ounit = UNIT:FindByName("USEW Overlord")
Overlordcount = 0
Overlordlimit = 4


USMagic = GROUP:FindByName("USEW Magic")
Munit = UNIT:FindByName("USEW Magic")
Magiccount = 0
Magiclimit = 4

Shell21 = GROUP:FindByName("Shell21")

SkyEye1 = GROUP:FindByName("SKYEYE1")
skyeyecount = 0
skyeyelimit = 5

SkyEye2 = GROUP:FindByName("SKYEYE2-1")
skyeye2count = 0

do
	USMagicSpawn = SPAWN:NewWithAlias("USEW Magic","USEW Magic11"):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
		USMagic = spawngroup
		Magiccount = Magiccount + 1
		Munit = trawac:GetUnit(1)
		Munit:HandleEvent( EVENTS.Dead,MagicDead )
		MESSAGE:New("Magic is warming up for Take off",15):ToBlue()
		BASE:E({"respawned USMagic unit name is:",tunit:GetName()})
		hm("> Magic Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
	end,{}):InitRepeatOnLanding():InitCleanUp(600)
	
	function MagicDead(EventData)
		MESSAGE:New("Magic is Down",30):ToBlue()
		hm("> Coalition: Magic11 Was shot down ")
		Munit:UnHandleEvent(EVENTS.Dead)
	end
	
	OverlordSpawn = SPAWN:NewWithAlias("USEW Overlord","USEW Overlord 11"):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
		Overlord = spawngroup
		Overlordcount = Overlordcount + 1
		Ounit = spawngroup:GetUnit(1)
		Ounit:HandleEvent( EVENTS.Dead,OverlordDead )
		MESSAGE:New("Overlord is warming up for Take off",15):ToBlue()
		BASE:E({"respawned Overlord unit name is:",tunit:GetName()})
		hm("> Overlord Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	function OverlordDead(EventData)
		MESSAGE:New("Overlord is Down, I repeat Overlord is down",30):ToBlue()
		hm("> Coalition: Overlord11 Was shot down ")
		Ounit:UnHandleEvent(EVENTS.Dead)
	end
	
	Texaco11Spawn = SPAWN:NewWithAlias("Texaco 11","Texaco11"):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
		Texaco11 = spawngroup
		texacocount = texacocount + 1
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	
	Texaco21Spawn = SPAWN:NewWithAlias("Texaco 21","Texaco21"):InitKeepUnitNames(true):InitLimit(1,3):OnSpawnGroup(function(spawngroup) 
		Texaco21 = spawngroup
		texaco2count = texaco2count + 1
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	Arco11Spawn = SPAWN:NewWithAlias("Arco 11","Arco11"):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
		Arco11 = spawngroup
		arcocount = arcocount + 1
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	SkyEye1Spawn = SPAWN:NewWithAlias("SKYEYE1","Skyeye1"):InitKeepUnitNames(true):InitLimit(1,5):OnSpawnGroup(function(spawngroup)
		SkyEye1 = spawngroup
		skyeyecount = skyeyecount + 1
		MESSAGE:New("New Predator Scout Active, AI AFAC is on 133 UHF, CTLD FAC Activated.",30):ToBlue()
		local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
		--put to the end
		table.insert(ctld.jtacGeneratedLaserCodes, _code)
		ctld.JTACAutoLase(SkyEye1:GetName(), _code) 
	end,{}):InitCleanUp(600):InitRepeatOnLanding()

	SkyEye2Spawn = SPAWN:NewWithAlias("SKYEYE2-1","Skyeye2"):InitKeepUnitNames():InitLimit(1,5):OnSpawnGroup(function(spawngroup)
		SkyEye2 = spawngroup
		skyeye2count = skyeye2count + 1
		MESSAGE:New("New Reaper Scout Active, AI AFAC is on 266 UHF, CTLD FAC Activated.",30):ToBlue()
		local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
		--put to the end
		table.insert(ctld.jtacGeneratedLaserCodes, _code)
		ctld.JTACAutoLase(SkyEye2:GetName(), _code) 
	end,{}):InitCleanUp(600)



	function checktankers()
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB)
		ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB)
		if ab:GetCoalition() == 2 then
			if Texaco21:IsAlive() ~= true and texaco2count < texaco2limit then
				Texaco21Spawn:Spawn()
			end
			if (Texaco11:IsAlive() ~= true) and (texacocount < texacol1imit) then
				Texaco11Spawn:Spawn()
			end
			if Arco11:IsAlive() ~= true and arcocount < arcolimit then
				Arco11Spawn:Spawn()
			end
		else
			BASE:E({"Al Dhafra not friendly"})
		end
	end

	function checkawacs()
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB)
		if ab:GetCoalition() == 2 then
			if Overlord:IsAlive() ~= true and Overlordcount < Overlordlimit then
				OverlordSpawn:Spawn()
			end
			if USMagic:IsAlive() ~= true and Magiccount < Magiclimit then
				USMagicSpawn:Spawn()
			end
		else
			BASE:E({"Al Dhafra not friendly"})
		end
	end
	
	function checkskyeye()
		local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB)
		if ab:GetCoalition() == 2 then
			if SkyEye1:IsAlive() ~= true and skyeyecount < skyeyelimit then
				SkyEye1Spawn:Spawn()
			end
			if SkyEye2:IsAlive() ~= true and skyeye2count < skyeyelimit then
				SkyEye2Spawn:Spawn()
			end
		else
			BASE:E({"Al Dhafra not friendly"})
		end
	end





SCHEDULER:New(nil,function()
	checktankers()
	checkawacs()
	checkskyeye()
  end,{},60,1800)

end


function afacCooldownHelp(afacname)
	MESSAGE:New(string.format("AFAC routing is now available again. Use the following marker commands:\n-afac route %s \nor \n-afac route=%s,h=<0-360>,d=<0-25>,a=<1-20,000>,s=<90-150> \nFor more control",afacname,afacname,afacname),30, MESSAGE.Type.Information):ToBlue()
end


function handleAfacRequest(text, coord)
	local currentTime = os.time()
	if text:find("route") then
	  local keywords=_split(text, ",")
	  local heading = nil
	  local distance = nil
	  local endcoord = nil
	  local endpoint = false
	  local altitude = nil
	  local altft = nil
	  local spknt = nil
	  local speed = nil
	  local afacname = ""
	  BASE:E({keywords=keywords})
	  for _,keyphrase in pairs(keywords) do
		local str=_split(keyphrase, "=")
		local key=str[1]
		local val=str[2]
		BASE:E(string.format("%s, keyphrase = %s, key = %s, val = %s", "route", tostring(keyphrase), tostring(key), tostring(val)))
		  if key:lower():find("h") then
			heading = tonumber(val)
			-- BASE:E({"AFAC Movement we have heading",heading})
		  end
		  if key:lower():find("d") then
			distance = tonumber(val)
			-- BASE:E({"AFAC Movement we have distance",distance})
		  end
		  if key:lower():find("a") then
			altitude = tonumber(val)
			-- BASE:E({"AFAC Movement we have altitude ",altitude})
		  end
		  if key:lower():find("s") then
			speed = tonumber(val)
			-- BASE:E({"AFAC Movement we have speed",speed})
		  end
	  end
	  local _afac = nil
	  -- find our afac
	  if text:find("Skyeye1") or text:find("skyeye1") then
		local afacname = "SkyEye1"
		_afac = SkyEye1
		local cooldown = currentTime - FAC1_Timer
		if cooldown < FAC1_COOLDOWN then
		  MESSAGE:New(string.format("%s Requests are not available at this time.\nRequests will be available again in %d minutes", afacname, (FAC1_COOLDOWN - cooldown) / 60), MESSAGE.Type.Information):ToBlue()
		  return
		end
		if _afac:IsAlive() ~= true then
			if skyeyecount < skyeyelimit then
				checkskyeye()
				MESSAGE:New(string.format("%s is currently not avalible for tasking, but is being launched. Please wait until airborn from Al Dhafra and try again",afacname),25,MESSAGE.Type.Information):ToBlue()
				return
			else
		  		MESSAGE:New(string.format("%s is currently not avalible for tasking it's M.I.A", afacname),25,MESSAGE.Type.Information):ToBlue()
			end
		  return
		end
		FAC1_Timer = currentTime
	  else
		MESSAGE:New("No known AFAC was included in the Route Command, please use Skyeye1",25,MESSAGE.Type.Information):ToBlue()
		return
	  end
	  if altitude == nil then
		altft = 9000
		altitude = UTILS.FeetToMeters(19000)
	  else
		if altitude > 20000 then
		  altitude = 20000
		elseif altitude < 1000 then
		  altitude = 1000
		end
		altft = altitude
		altitude = UTILS.FeetToMeters(altitude)
	  end
	  if speed == nil then
		spknt = 120
		speed = UTILS.KnotsToMps(120)
	  else
		if speed > 150 then
		  speed = 150
		elseif speed < 90 then
		  speed = 90
		end
	  spknt = speed
	  speed = UTILS.KnotsToMps(speed)
	  end  
	  if heading ~= nil then 
		if heading < 0 then
		  heading = 0
		elseif heading > 360 then
		  heading = 360
		end
		if distance ~= nil then
		  if distance > 25 then
			distance = 25
		  end
		  if distance < 0 then
			distance = 0
		  end
		endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
		else
		  endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
		  distance = 0
		end
	  else
		heading = math.random(0,360)
		endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
		distance = 0
	  end
	  _afac:ClearTasks()
	  local routeTask = _afac:TaskOrbit(coord,altitude,speed)
	  if distance ~= 0 then
		 routeTask = _afac:TaskOrbit(coord,altitude,speed,endcoord)
	  end
	  _afac:SetTask(routeTask, 2)
  
	  local afacTask = _afac:EnRouteTaskFAC(UTILS.NMToMeters(10),1)
	  _afac:PushTask(afacTask, 4)
	  MESSAGE:New( string.format("%s AFAC is re-routed to the player requested destination.\nIt will orbit on a heading of %d for %d nm, Alt: %d Gnd Speed %d.\n%d minutes cooldown starting now",afacname,heading,distance,altft,spknt, FAC1_COOLDOWN / 60), 15, MESSAGE.Type.Information ):ToBlue()
	  SCHEDULER:New(nil, afacCooldownHelp, {afacname}, FAC1_COOLDOWN)
   	end
end