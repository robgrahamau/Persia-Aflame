version = "0.78 Beta"
lastupdate = "22 June 2020"
PlayerMap = {}
PlayerRMap = {}
PlayerBMap = {}
SetPlayer = SET_CLIENT:New():FilterStart()
SetPlayerRed = SET_CLIENT:New():FilterCoalitions("red"):FilterStart()
SetPlayerBlue = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()
Scoring = SCORING:New("Scoring")


if os ~= nil then
        nowTable = os.date('*t')
        nowYear = nowTable.year
        nowMonth = nowTable.month
        nowDay = nowTable.day
        nowHour = nowTable.hour
        nowminute = nowTable.min
        nowsec = nowTable.secs
    else
       nowTable = {}
        nowYear = "test"
        nowMonth = "test"
        nowDay = "test"
        nowHour = "test"
        nowminute = "test"
        nowsec = "test"
    end

missionstarttime = nowYear .. "/" .. nowMonth .. "/" .. nowDay .. " @ " .. nowHour .. ":" .. nowminute 
restarthour = nowHour + 6
  if restarthour > 23 then 
    restarthour = restarthour - 24
  end

  restarttime = "" .. restarthour ..":".. nowminute ..""

local function permanentPlayerCheck()
    BASE:E("PPCHECK")
    if os ~= nil then
      do
        nowTable = os.date('*t')
        nowYear = nowTable.year
        nowMonth = nowTable.month
        nowDay = nowTable.day
        nowHour = nowTable.hour
        nowminute = nowTable.min
      end
    else
       nowTable = {}
        nowYear = "test"
        nowMonth = "test"
        nowDay = "test"
        nowHour = "test"
        nowminute = "test"
    end
    currenttime = "H" .. nowHour .. ":" .. nowminute 
      SetPlayerRed:ForEachClient(function(PlayerClient) 
      local PlayerID = PlayerClient.ObjectName
      if PlayerClient:GetGroup() ~= nil then
      end
      if PlayerClient:IsAlive() then
        if PlayerRMap[PlayerID] ~= true then
          PlayerRMap[PlayerID] = true
          MESSAGE:New("Welcome to Persia Aflame By Rob Graham Version: "..version.." \n Last updated:".. lastupdate .." \n POWERED BY MOOSE, MIST, SLMOD, Lots of Pain Killers and Hamsters! \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n Please Be aware This Mission is currently in a ALPHA STATE and may break/Bug out etc. \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n You are on Iran Side, Please be aware this mission is geared towards BLUE side taking down red, Red Slots are to add some spice to that. \n Your goal is to defend Irani Airspace from Coalition Violations.\n  Please Read the DISCORD THIS IS STILL IN TESTING SEE ALT-B for Links \n Supplied by core members of Http://TaskGroupWarrior.Info \n Current Time is: " .. currenttime .. " Server Mission Cycle:" .. restarttime .."",30):ToClient(PlayerClient)
          
        end
      else
        if PlayerRMap[PlayerID] ~= false then
          PlayerRMap[PlayerID] = false
        end
      end
    end)
    SetPlayerBlue:ForEachClient(function(PlayerClient) 
      local PlayerID = PlayerClient.ObjectName
      local group = nil
        if PlayerClient:GetGroup() ~= nil then
          group = PlayerClient:GetGroup()
        end
         if PlayerClient:IsAlive() then
           if PlayerBMap[PlayerID] ~= true then
            PlayerBMap[PlayerID] = true
             MESSAGE:New("Welcome to Persia Aflame by Rob Graham Version: "..version.." \n Last updated:".. lastupdate .." \n POWERED BY MOOSE, MUST, SLMOD, Lots of Pain Killers, Player Donations \n Kosh and Lets not forget.. Server Space Hamsters \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n You are on the Coalition Side, Please read the BRIEFING LALT+B for full Communications and other information. \n your primary goal is the destruction of Iran's IADS, Airfields and it's ability to wage war.\n Current Prediction of Invasion Succeeding: "..  mainmission.invasionchance .. "% \n Blue Airbases offer full resupply, civilian airports only offer fuel/limited resupply. \n Check the F10 Map for Intel Reports \n Please Read the DISCORD THIS IS STILL IN TESTING SEE ALT-B for Links \n Supplied by core members of Http://TaskGroupWarrior.Info \n Current Time is:" .. currenttime .. " Server Mission Cycle:" .. restarttime .."",30):ToClient(PlayerClient)                             
           end    
         else
          if PlayerBMap[PlayerID] ~= false then
                PlayerBMap[PlayerID] = false
          end
       end
    end)
end
C_Arco12 = nil

function Arco11A10()
  local rf = ZONE:New("rf")
  local altitude = 15000
  local speed = UTILS.KnotsToMps(260) 
  local heading = 210
  local distance = 50
  local coord = rf:GetCoordinate()
  local endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
  Arco11:ClearTasks()
  local routeTask = Arco11:TaskOrbit(coord,altitude,speed,endcoord)
  Arco11:SetTask(routeTask,2)
  local tankerTask = Arco11:EnRouteTaskTanker()
  Arco11:PushTask(tankerTask,4)
  MESSAGE:New("ARCO11 is now reducing speed to 260 Knots Ground and moving to Anchor point for A10 Refueling",15):ToBlue()
  C_Arco11:Remove()
  C_Arco12 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for FGTR",C_tanker,Arco11FTR,nil)
end

function Arco11FTR()
  local rf = ZONE:New("rf")
  local altitude = 15000
  local speed = UTILS.KnotsToMps(360) 
  local heading = 210
  local distance = 50
  local coord = rf:GetCoordinate()
  local endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
  Arco11:ClearTasks()
  local routeTask = Arco11:TaskOrbit(coord,altitude,speed,endcoord)
  Arco11:SetTask(routeTask,2)
  local tankerTask = Arco11:EnRouteTaskTanker()
  Arco11:PushTask(tankerTask,4)
  MESSAGE:New("ARCO11 is now increasing speed to 360 Knots Ground and moving to Anchor point for FGTR Refueling",15):ToBlue()
  C_Arco12:Remove()
  C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)
end

--M_menu = MENU_MISSION:New("Debug Commands - Admin Use Only")
--M_menu1 = MENU_MISSION_COMMAND:New("IADS DEBUG TOGGLE",M_menu,IADSDB)
C_menu = MENU_COALITION:New(coalition.side.BLUE,"AI CONTROL")
C_tanker = MENU_COALITION:New(coalition.side.BLUE,"Tanker Control",C_menu)
C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)


trigger.action.setUserFlag(100,0)
SCHEDULER:New(nil,permanentPlayerCheck,{},1,1)

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 12 HOURS",30):ToAll()
end,{},1)

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 11 HOURS",10):ToAll()
end,{},((60*60) * 1))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 10 HOURS",10):ToAll()
end,{},((60*60) * 2))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 9 HOURS",10):ToAll()
end,{},((60*60) * 3))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 8 HOURS",10):ToAll()
end,{},((60*60) * 4))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 7 HOURS",10):ToAll()
end,{},((60*60) * 5))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 6 HOURS",10):ToAll()
end,{},((60*60) * 6))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 5 HOURS",10):ToAll()
end,{},((60*60) * 7))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 4 HOURS",10):ToAll()
end,{},((60*60) * 8))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 3 HOURS",10):ToAll()
end,{},((60*60) * 9))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 2 HOURS",10):ToAll()
end,{},((60*60) * 10))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYLE WILL HAPPEN IN 1 HOUR",11):ToAll()
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN 30 Minutes",10):ToAll()
    SCHEDULER:New(nil,function() 
      MESSAGE:New("MISSION CYLE WILL HAPPEN IN 15 Minutes",10):ToAll()
      SCHEDULER:New(nil,function() 
        MESSAGE:New("MISSION CYLE WILL HAPPEN IN 5 Minutes",10):ToAll()
          SCHEDULER:New(nil,function() 
            MESSAGE:New("MISSION CYLE WILL HAPPEN IN 1 Minute",10):ToAll()
            end,{},((1*60)))
        end,{},((5*60)))      
      end,{},((15*60)))
  end,{},((30*60)))

end,{},((60*60) * 11))


SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYCLE HAPPENING",30):ToAll()
trigger.action.setUserFlag(100,1)
end,{},((60*60)*12))
