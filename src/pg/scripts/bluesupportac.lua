TANKER_COOLDOWN = (1)*60
TEX_Timer = 0
TEX2_Timer = 0
ARC_Timer = 0
ARC2_Timer = 0
 function AI_A2A_DISPATCHER:GetSquadronAmount(SquadronName)
    DefenderSquadron = self:GetSquadron( SquadronName )
        self:F( { Squadron = SquadronName, SquadronResourceCount = DefenderSquadron.ResourceCount, SquadronDetails = DefenderSquadron } )
    return DefenderSquadron.ResourceCount 
  end
do
Texaco11 = GROUP:FindByName("Texaco 11")
texacocount = 0
texacol1imit = 3
Texaco11Spawn = SPAWN:New("Texaco 11"):OnSpawnGroup(function(spawngroup) 
  Texaco11 = spawngroup
  texacocount = texacocount + 1
end,{}):InitRepeatOnLanding():InitCleanUp(600)

Texaco21 = GROUP:FindByName("Texaco 21")
Texaco21Spawn = SPAWN:New("Texaco 21"):InitLimit(1,3):OnSpawnGroup(function(spawngroup) 
  Texaco21 = spawngroup
end,{}):InitRepeatOnLanding():InitCleanUp(600):SpawnScheduled(1800,0.5)

Arco11 = GROUP:FindByName("Arco 11")
arcocount = 0
arcolimit = 4

Arco11Spawn = SPAWN:New("Arco 11"):OnSpawnGroup(function(spawngroup) 
  Arco11 = spawngroup
  arcocount = arcocount + 1
end,{}):InitRepeatOnLanding():InitCleanUp(600)

Shell21 = GROUP:FindByName("Shell21")


SkyEye1 = GROUP:FindByName("SKYEYE1")
SkyEye1Spawn = SPAWN:New("SKYEYE1"):InitLimit(1,5):OnSpawnGroup(function(spawngroup)
	SkyEye1 = spawngroup
	MESSAGE:New("New Predator Scout Active, AI AFAC is on 133 UHF, CTLD FAC Activated.",30):ToBlue()
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase(SkyEye1:GetName(), _code) 
end,{}):InitCleanUp(600):SpawnScheduled(3600,0.5)


SkyEye2 = GROUP:FindByName("SKYEYE2-1")
SkyEye2Spawn = SPAWN:New("SKYEYE2-1"):InitLimit(1,5):OnSpawnGroup(function(spawngroup)
	SkyEye2 = spawngroup
	MESSAGE:New("New Reaper Scout Active, AI AFAC is on 266 UHF, CTLD FAC Activated.",30):ToBlue()
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase(SkyEye2:GetName(), _code) 
end,{}):InitCleanUp(600):SpawnScheduled(3600,0.5)

function checktankers()
	local ab = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB)
	if ab:GetCoalition() == 2 then
	if Texaco11:IsAlive() ~= true then
		if minmsg == true then
			if texacocount < texacol1imit then
				Texaco11Spawn:Spawn()
			end
		end
	end
	if Arco11:IsAlive() ~= true then
		if minmsg == true then
			if arcocount < arcolimit then
				Arco11Spawn:Spawn()
			end
		end
	end
	else
		BASE:E({"Minhad not friendly"})
	end
end

SCHEDULER:New(nil,function()
	checktankers()
  end,{},60,1800)


function OverlordDead(EventData)
	MESSAGE:New("Overlord is Down, I repeat Overlord is down",30):ToBlue()
	hm("> Coalition: Overlord11 Was shot down ")
end

function MagicDead(EventData)
	MESSAGE:New("Magic is Down",30):ToBlue()
	hm("> Coalition: Magic11 Was shot down ")
end


Overlord = GROUP:FindByName("USEW Overlord")

OverlordSpawn = SPAWN:NewWithAlias("USEW Overlord","USEW Overlord11"):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
  Overlord = spawngroup
  trawac = spawngroup 
  tunit = trawac:GetUnit(1)
  tunit = trawac:GetUnit(1)
  tunit:HandleEvent( EVENTS.Dead,OverlordDead )
  MESSAGE:New("Overlord is warming up for Take off",15):ToBlue()
  BASE:E({"respawned Overlord unit name is:",tunit:GetName()})
  hm("> Overlord Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
end,{}):InitRepeatOnLanding():InitLimit(1,4):InitCleanUp(600):SpawnScheduled(1800,0.5)

USMagic = GROUP:FindByName("USEW Overlord")
USMagicSpawn = SPAWN:NewWithAlias("USEW Magic","USEW Magic11"):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
  USMagic = spawngroup
  trawac = spawngroup 
  tunit = trawac:GetUnit(1)
  tunit:HandleEvent( EVENTS.Dead,MagicDead )
  MESSAGE:New("Magic is warming up for Take off",15):ToBlue()
  BASE:E({"respawned USMagic unit name is:",tunit:GetName()})
  hm("> Magic Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
end,{}):InitRepeatOnLanding():InitLimit(1,4):InitCleanUp(600):SpawnScheduled(1800,0.5)

CV_1_CAP = nil
CV_2_CAP = nil
T_CAP = nil
end
usenew = true

BAS = ZONE_POLYGON:NewFromGroupName("AS1")
CV1_CAP = ZONE_POLYGON:NewFromGroupName("CV1_CAP")
CV2_CAP = ZONE_POLYGON:NewFromGroupName("CV2_CAP")
T_CAP = ZONE_POLYGON:NewFromGroupName("T_CAP") 
BCarrierTEMP = {"T_Hornet1","T_Hornet2"}
BLandTemp = {"T_F15","T_F16"}
