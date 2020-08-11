-- Helicopter Spawning Script -- 
chinv = nil
chinv2 = nil
invade = false
IAH1 = SPAWN:New("IranAH1"):InitRandomizeRoute(1,11,10000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
IAH1_2 = SPAWN:New("IranAH1-2"):InitRandomizeRoute(1,11,5000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
IAH1_3 = SPAWN:New("IranAH1-3"):InitRandomizeRoute(1,11,5000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
IAH1_4 = SPAWN:New("IranAH1-4"):InitRandomizeRoute(1,11,5000,300):InitLimit(2,3):InitRepeatOnLanding():InitCleanUp(300):SpawnScheduled(1200,0.5)
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
end):InitRandomizeRoute(1,5,2000,100):InitLimit(4,2):InitCleanUp(600):SpawnScheduled(1200,0.5)

invaders1 = SPAWN:NewWithAlias("invasion_1","IA Invaders")
invaders2 = SPAWN:NewWithAlias("invasion_2","IA Invaders 2")
invaders2 = SPAWN:NewWithAlias("invasion_3","IA Invaders 3")
invadeg = nil
invadeg2 = nil
invadeg3 = nil
mcc1 = nil
mcc2 = nil
mcc3 = nil
function invadetime()
  local rnd = math.random(1,5)
  if rnd == 1 then
    invadeg = invaders1:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
    cc = invadeg:GetCoordinate()
    if mcc1 == nil then
      mcc1 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here, moving towards Ras Al Khaimah \n mark will update every 30 Minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc1)
      mcc1 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here, moving towards Ras Al Khaimah \n mark will update every 30 Minutes",true,"Irani Troop Drop")
    end
  elseif rnd == 2 then
    invadeg2 = invaders2:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
    cc = invadeg:GetCoordinate()
    if mcc2 == nil then
      mcc2 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take the Infidel's air base at AL-Minhad \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc2)
      mcc2 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take the Infidel's air base at AL-Minhad \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    end
  elseif rnd == 3 then
    invadeg3 = invaders3:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
    if mcc3 == nil then
      mcc3 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take Sharjah Airport \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc3)
      mcc3 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take Sharjah Airport \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    end
  elseif rnd == 4 then
    invadeg = invaders1:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
    cc = invadeg:GetCoordinate()
    if mcc1 == nil then
      mcc1 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here, moving towards Ras Al Khaimah \n mark will update every 30 Minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc1)
      mcc1 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here, moving towards Ras Al Khaimah \n mark will update every 30 Minutes",true,"Irani Troop Drop")
    end
    invadeg2 = invaders2:Spawn()
    MESSAGE:New("Iran Invaders Detected in the UAE!",30):ToAll()
    cc = invadeg:GetCoordinate()
    if mcc2 == nil then
      mcc2 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take the Infidel's air base at AL-Minhad \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc2)
      mcc2 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take the Infidel's air base at AL-Minhad \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    end
    
  end
  invade = true
  BASE:E({"Invasion has happened invade is now true"})
end

SCHEDULER:New(nil,function() 
  if mcc1 ~= nil and invadeg ~= nil then
    if invadeg:IsAlive() == true then
      cc = invadeg:GetCoordinate()
      COORDINATE:RemoveMark(mcc1)
      mcc1 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here, moving towards Ras Al Khaimah \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc1)
      mcc1 = nil
    end
  end
  if mcc2 ~= nil and invadeg2 ~= nil then
    if invadeg2:IsAlive() == true then
      cc = invadeg2:GetCoordinate()
      COORDINATE:RemoveMark(mcc2)
      mcc2 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take the Infidel's air base at AL-Minhad \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc2)
      mcc2 = nil
    end
  end
  if mcc3 ~= nil and invadeg3 ~= nil then
    if invadeg2:IsAlive() == true then
      cc = invadeg3:GetCoordinate()
      COORDINATE:RemoveMark(mcc3)
      mcc3 = cc:MarkToAll("Citizens Report Irani Troops Dropped by Helo here overheard that they are pushing SW to take the Sharjah Airport \n Mark will update every 30 minutes",true,"Irani Troop Drop")
    else
      COORDINATE:RemoveMark(mcc3)
      mcc3 = nil
    end
  end
 end,{},60,1800)