version = "0.95"
lastupdate = "5 September 2020"
PlayerMap = {}
PlayerRMap = {}
PlayerBMap = {}
SetPlayer = SET_CLIENT:New():FilterStart()
SetPlayerRed = SET_CLIENT:New():FilterCoalitions("red"):FilterStart()
SetPlayerBlue = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()
Scoring = SCORING:New("Scoring")
resethours = 6
hourstoreset = 6
trigger.action.setUserFlag("SSB",100)

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
    -- BASE:E("PPCHECK")
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
          MESSAGE:New("Welcome to Persia Aflame By Rob Graham Version: "..version.." \n Last updated:".. lastupdate .." ".. PlayerClient:GetPlayerName() .."\n  POWERED BY MOOSE, MIST, SLMOD, Player Donations, OverlordBot, Lots of Pain Killers, Kosh Purrs, Midgets and lets not forget the space server Hamsters! \n THE EYES BOO GO FOR THE EYES! \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n You are on Iran Side, Please be aware this mission is geared towards BLUE Coalition Forces attacking Red, Iran is defending by and large. \n Your goal is to defend Irani Airspace from Coalition Violations, use CTLD helicopters to repair defences etc.\n  Please Join the DISCORD SEE ALT-B for Links \n Supplied by core members of Http://TaskGroupWarrior.Info \n Current Time is: " .. currenttime .. " Server Mission Cycle:" .. restarttime .." \n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",30):ToClient(PlayerClient)
          MESSAGE:New("Overlord bot is active on 253.00 UHF, please try and refrain from using it for general communications - Thanks.",60):ToClient(PlayerClient)
		  HypeMan.sendBotMessage("` $SERVERNAME - Ground Crew:` " .. PlayerClient:GetPlayerName() .. " is in the pit, straps are tight, their " ..PlayerClient:GetTypeName() .. " is fueled and ready to go")
		  --STTS.TextToSpeech("Stay a while, " .. PlayerClient:GetPlayerName() .." Stay Forever",253.10,"AM",0.5,"TGW Welcome", 2 )			 			 
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
             MESSAGE:New("Welcome to Persia Aflame by Rob Graham Version: "..version.." \n Last updated:".. lastupdate .." ".. PlayerClient:GetPlayerName() .."\n POWERED BY MOOSE, MIST, SLMOD, Player Donations, OverlordBot, Lots of Pain Killers, Kosh Purrs, Midgets and lets not forget the space server Hamsters! \n THE EYES BOO GO FOR THE EYES! \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n You are on the Coalition Side, Please read the BRIEFING LALT+B for full Communications and other information. \n your primary goal is the destruction of Iran's IADS, Airfields and it's ability to wage war.\n Invading can be done using CTLD and the Player Helicopters \n Blue Airbases offer full resupply, civilian airports only offer fuel/limited resupply. \n Check the F10 Map for Intel Reports \n Please Join the DISCORD SEE ALT-B for Links \n Supplied by core members of Http://TaskGroupWarrior.Info \n Current Time is:" .. currenttime .. " Server Mission Cycle:" .. restarttime .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",30):ToClient(PlayerClient)
			 MESSAGE:New("Overlord bot is active on 253.00 UHF, please try and refrain from using it for general communications - Thanks.",60):ToClient(PlayerClient)
			 HypeMan.sendBotMessage("` $SERVERNAME - Ground Crew:` " .. PlayerClient:GetPlayerName() .. " is in the pit, straps are tight, their " ..PlayerClient:GetTypeName() .. " is fueled and ready to go")
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
  local altitude = UTILS.FeetToMeters(15000)
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
  HypeMan.sendBotMessage("Arco has increased its speed to 260 Knots ground speed to cater to slow A10's")
  C_Arco11:Remove()
  C_Arco12 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for FGTR",C_tanker,Arco11FTR,nil)
end

function Arco11FTR()
  local rf = ZONE:New("rf")
  local altitude = UTILS.FeetToMeters(15000)
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
  HypeMan.sendBotMessage("Arco has increased its speed to 360 knots over the ground for Fighter Refueling")
  C_Arco12:Remove()
  C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)
end
--[[
function tdy_wind()
	BASE:E({"tdy_wind request"})
    if CV_TDY:IsTurning() or CV_TDY:IsSteamingIntoWind() then
      MESSAGE:New("Teddy Rose: Unable, We are already in Recovery/Launch Ops",15):ToBlue()
    else
      MESSAGE:New("Alert, Launch/Recovery Ops starting in 1 minute for the Teddy Rose for 60 minutes.",15):ToBlue()
      local timenow=timer.getAbsTime( )
      local timestart=timenow+60
      local timeend=timenow+60*60
      local timerecovery_start = UTILS.SecondsToClock(timestart,true)
      timerecovery_end = UTILS.SecondsToClock(timeend,true)
      CV_TDY:AddTurnIntoWind(timerecovery_start,timerecovery_end,25,false,0)
    end
end

function CV_TDY:OnAfterTurnIntoWind(From,Event,To,Into,Duration,Speed,Uturn,IntoWind)
  MESSAGE:New("Teddy has turned into the wind for 60",15):ToBlue()
end

function CV_TDY:OnAfterTurnIntoWindOver(From,Event,To,Duration,Speed,Uturn)
  MESSAGE:New("Teddy completed Recovery Ops",15):ToBlue()
end
]]
--M_menu = MENU_MISSION:New("Debug Commands - Admin Use Only")
--M_menu1 = MENU_MISSION_COMMAND:New("IADS DEBUG TOGGLE",M_menu,IADSDB)
C_menu = MENU_COALITION:New(coalition.side.BLUE,"AI CONTROL")
--C_TDY = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Request Teddy Turn into Wind",C_menu,tdy_wind,{})
C_tanker = MENU_COALITION:New(coalition.side.BLUE,"Tanker Control",C_menu)
--C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)



SCHEDULER:New(nil,permanentPlayerCheck,{},1,2)
function nextreset()
	resettime()
end

function resettime()
	SCHEDULER:New(nil,function() 
	MESSAGE:New("MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
	HypeMan.sendBotMessage("` $SERVERNAME - Server Info: ` MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
	hourstoreset = hourstoreset - 1
	if hourstoreset < resethours then
		nextreset()
	end
	end,{},60*60)
end
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  HypeMan.sendBotMessage("` $SERVERNAME - Server Info` MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
  hourstoreset = hourstoreset - 1
  nextreset()	
end,{},1)

SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN 1 HOUR \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  HypeMan.sendBotMessage("` $SERVERNAME - Server Info ` MISSION CYLE WILL HAPPEN IN 1 HOUR \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at 20:00 Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
end,{},((60*60) * (resethours - 1)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN 30 Minutes",10):ToAll()
  HypeMan.sendBotMessage("` $SERVERNAME - Server Info:` Mission Cycle will happen in 30 Minutes")
end,{},(((60*60) *(resethours)) - (60*30)))
SCHEDULER:New(nil,function() 
      MESSAGE:New("MISSION CYLE WILL HAPPEN IN 15 Minutes",10):ToAll()
	  HypeMan.sendBotMessage("` $SERVERNAME - Server Info:` Mission Cycle will happen in 15 Minutes")
end,{},(((60*60) *(resethours)) - (60*15)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN 5 Minutes",10):ToAll()
  HypeMan.sendBotMessage("` $SERVERNAME - Server Info:` Mission Cycle will happen in 5 Minutes")
end,{},(((60*60) *(resethours)) - (60*5)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN 1 Minute",10):ToAll()
  HypeMan.sendBotMessage("` $SERVERNAME - Server Info:` Mission Cycle will happen in 1 Minutes")
end,{},(((60*60) *(resethours)) - (60*1)))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYCLE HAPPENING",30):ToAll()
HypeMan.sendBotMessage("` $SERVERNAME - Server Info:` Server is now restarting")
trigger.action.setUserFlag(100,1)
end,{},((60*60)*resethours))





