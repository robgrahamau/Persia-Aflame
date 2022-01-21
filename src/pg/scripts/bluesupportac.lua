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
skyeyelimit = 3

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
	
	Texaco11Spawn = SPAWN:New("Texaco 11"):OnSpawnGroup(function(spawngroup) 
		Texaco11 = spawngroup
		texacocount = texacocount + 1
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	
	Texaco21Spawn = SPAWN:New("Texaco 21"):InitLimit(1,3):OnSpawnGroup(function(spawngroup) 
		Texaco21 = spawngroup
		texaco2count = texaco2count + 1
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	Arco11Spawn = SPAWN:New("Arco 11"):OnSpawnGroup(function(spawngroup) 
		Arco11 = spawngroup
		arcocount = arcocount + 1
	end,{}):InitRepeatOnLanding():InitCleanUp(600)

	SkyEye1Spawn = SPAWN:New("SKYEYE1"):InitLimit(1,5):OnSpawnGroup(function(spawngroup)
		SkyEye1 = spawngroup
		skyeyecount = skyeyecount + 1
		MESSAGE:New("New Predator Scout Active, AI AFAC is on 133 UHF, CTLD FAC Activated.",30):ToBlue()
		local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
		--put to the end
		table.insert(ctld.jtacGeneratedLaserCodes, _code)
		ctld.JTACAutoLase(SkyEye1:GetName(), _code) 
	end,{}):InitCleanUp(600)

	SkyEye2Spawn = SPAWN:New("SKYEYE2-1"):InitLimit(1,5):OnSpawnGroup(function(spawngroup)
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
		if ab:GetCoalition() == 2 then
			if (Texaco11:IsAlive() ~= true) and (texacocount < texacol1imit) then
					Texaco11Spawn:Spawn()
			end
			if Arco11:IsAlive() ~= true and arcocount < arcolimit then
					Arco11Spawn:Spawn()
			end
		else
			BASE:E({"Minhad not friendly"})
		end
		ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB)
		if ab:GetCoalition() == 2 then
			if Texaco21:IsAlive() ~= true and texaco2count < texaco2limit then
				Texaco21Spawn:Spawn()
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
  end,{},60,1800)

end



