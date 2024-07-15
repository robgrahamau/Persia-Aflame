 function AI_A2A_DISPATCHER:GetSquadronAmount(SquadronName)
    DefenderSquadron = self:GetSquadron( SquadronName )
        self:F( { Squadron = SquadronName, SquadronResourceCount = DefenderSquadron.ResourceCount, SquadronDetails = DefenderSquadron } )
    return DefenderSquadron.ResourceCount 
  end

tunit = nil
tunit2 = nil

RAWACS2 = SPAWN:NewWithAlias("AWAC Overlord21","AWAC Overlord2"):InitKeepUnitNames(true):InitLimit(1,3):InitCleanUp(600):OnSpawnGroup(function(spawngroup) 
trawac2 = spawngroup 
tunit2 = trawac2:GetUnit(1)
BASE:E({"respawned RAWACS2 unit name is:",tunit2:GetName()})
hm("> Darkstar Stalin's Crew has arrived at Aircraft: ".. tunit2:GetName() .." ")
end,{}):InitRepeatOnLanding():SpawnScheduled(1800,0.25)

RAWACS = SPAWN:NewWithAlias("AWAC Overlord11","AWAC Overlord1"):InitKeepUnitNames(true):InitLimit(1,3):InitCleanUp(600):OnSpawnGroup(function(spawngroup) 
trawac = spawngroup 
tunit = trawac:GetUnit(1)
BASE:E({"respawned RAWACS unit name is:",tunit:GetName()})
hm("> Overlord Stalin's Crew has arrived at Aircraft: ".. tunit:GetName() .." ")
end,{}):InitRepeatOnLanding():SpawnScheduled(1800,0.25)

--TANKER = SPAWN:New("Texaco11"):InitLimit(1,2):InitCleanUp(600):InitRepeatOnLanding():SpawnScheduled(1800,0.25)

-- rlooksee = SET_GROUP:New():FilterPrefixes({"REW","RSAM","RAWAC"}):FilterCoalitions("red"):FilterActive():FilterStart()
