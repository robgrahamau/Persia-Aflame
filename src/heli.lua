-- Helicopter Spawning Script -- 
chinv = nil
chinv2 = nil
invade = false
IAH1 = SPAWN:New("IranAH1"):InitRandomizeRoute(1,11,10000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
IAH1_2 = SPAWN:New("IranAH1-2"):InitRandomizeRoute(1,11,10000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
IAH1_3 = SPAWN:New("IranAH1-3"):InitRandomizeRoute(1,11,10000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
IAH1_4 = SPAWN:New("IranAH1-4"):InitRandomizeRoute(1,11,10000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
ICH47 = SPAWN:New("Invasion"):OnSpawnGroup(function(SpawnGroup) 
  if chinv == nil then
    chinv = SpawnGroup
    invade = false 
  else
    if chinv:IsAlive() ~= true then
      chinv:Destroy()
      chinv = SpawnGroup
      if invade == true then
        invade = false
      end
    else
      chinv2 = SpawnGroup
        if invade == true then
          invade = false
        end
    end
  end
end):InitRandomizeRoute(1,4):InitLimit(4,2):InitCleanUp(600):SpawnScheduled(1200,0.5)

invaders1 = SPAWN:NewWithAlias("invasion_1","IA Invaders")
invaders2 = SPAWN:NewWithAlias("invasion_2","IA Invaders 2")
invaders2 = SPAWN:NewWithAlias("invasion_3","IA Invaders 3")

function invadetime()
  local rnd = math.random(1,3)
  if rnd == 1 then
    invadeg = invaders1:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
  elseif rnd == 2 then
    invadeg = invaders2:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
  elseif rnd == 3 then
    invadeg = invaders3:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
  end
  invade = true
  BASE:E({"Invasion has happened invade is now true"})
end