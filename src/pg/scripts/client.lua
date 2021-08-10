version = "1.41.0"
lastupdate = "10/08/2021"
PlayerMap = {}
PlayerRMap = {}
PlayerBMap = {}
SetPlayer = SET_CLIENT:New():FilterStart()

resethours = 8
hourstoreset = 8
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
restarthour = nowHour + resethours
serverrestart = 19
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
	if nowHour == (serverrestart - 1) then
		if nowminute == 0 then
			if hrleft ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 1 hour",15):ToAll()
				hrleft = true
			end
		elseif nowminute == 30 then
			if left30 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 30 Minutes",15):ToAll()
				left30 = true
			end
		elseif nowminute == 45 then
			if left45 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 15 Minutes",15):ToAll()
				left45 = true
			end
		elseif nowminute == 50 then
			if left50 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 10 Minutes",15):ToAll()
				left50 = true
			end
		elseif nowminute == 55 then
			if left55 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 5 Minutes Forced Save has occured.",15):ToAll()
				updatevalues()
				save()
				ctldsavedata()
				saveadmingroups()
				save_groups()
				left55 = true
			end
		elseif nowminute == 59 then
			if left59 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 1 Minute All items now saved",15):ToAll()
				updatevalues()
				save()
				ctldsavedata()
				saveadmingroups()
				save_groups()
				left59 = true
			end
		end
	end
    SetPlayer:ForEachClient(function(PlayerClient)
      local PlayerID = PlayerClient.ObjectName
      local Coalition = PlayerClient:GetCoalition()
      local col = "Irani Defenders"
      if Coalition == 2 then
        col = "Coalition Forces"
      end
      local PlayerName = PlayerClient:GetPlayerName()
      if PlayerClient:IsAlive() then
        if PlayerMap[PlayerID] ~= true then
          PlayerMap[PlayerID] = true
          local MessageText = "Welcome to Persia Aflame by Rob Graham Version: "..version.." Last update:"..lastupdate.." ".. PlayerName .. "\n Powered By Moose, Player Donations, OverlordBot, Lots of Pain Killers, Kosh Purrs, Midgets and lets not forget the space server Hamsters! \n THE EYES BOO GO FOR THE EYES! \n Be aware you will need to check F10 map stores limits as DCS in game Rearm/Refuel counts are broken. \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n, You are on " ..col..", Please be aware this mission is geared towards Coalition Forces attacking Iran is defending by and large. Please check the mission brief for more information ALT+B \n Please Join the DISCORD SEE ALT+B for Links \n Supplied by core members of Http://TaskGroupWarrior.Info \n Current Time is: " .. currenttime .. " Server Mission Cycle:" .. restarttime .." \n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard \n UNICOM is 122.80 VHF, use for ATC please."
          MESSAGE:New(MessageText,15,"Server Info",true):ToClient(PlayerClient)
          hm(">` $SERVERNAME - Ground Crew:` " .. PlayerClient:GetPlayerName() .. " is in the pit, straps are tight, their " ..PlayerClient:GetTypeName() .. " belonging to " .. col .. " is fueled and ready to go \n > Good Luck Out there")
        end
      else
        if PlayerMap[PlayerID] ~= false then
          PlayerMap[PlayerID] = false
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
  hm("Arco has increased its speed to 260 Knots ground speed to cater to slow A10's")
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
  hm("Arco has increased its speed to 360 knots over the ground for Fighter Refueling")
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
C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)



SCHEDULER:New(nil,permanentPlayerCheck,{},1,2)
function nextreset()
  resettime()
end



function resettime()
  SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  hm("` $SERVERNAME - Server Info: ` MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
  hourstoreset = hourstoreset - 1
  if hourstoreset < resethours then
    nextreset()
  end
  end,{},60*60)
end
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  hm("` $SERVERNAME - Server Info` MISSION CYLE WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
  hourstoreset = hourstoreset - 1
  nextreset() 
end,{},1)

SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN 1 HOUR \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  hm("` $SERVERNAME - Server Info ` MISSION CYLE WILL HAPPEN IN 1 HOUR \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
end,{},((60*60) * (resethours - 1)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 45 Minutes",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 45 Minutes")
end,{},(((60*60) *(resethours)) - (60*45)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 30 Minutes",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 30 Minutes")
end,{},(((60*60) *(resethours)) - (60*30)))
SCHEDULER:New(nil,function() 
      MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 15 Minutes",10):ToAll()
    hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 15 Minutes")
end,{},(((60*60) *(resethours)) - (60*15)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 10 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 10 Minutes")
end,{},(((60*60) *(resethours)) - (60*10)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 5 Minutes",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 5 Minutes")
end,{},(((60*60) *(resethours)) - (60*5)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 4 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 4 Minutes")
end,{},(((60*60) *(resethours)) - (60*1)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 3 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 3 Minutes")
end,{},(((60*60) *(resethours)) - (60*3)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 2 Minute \n Persistance Data is now being saved, Nothing beyond this point will save until restart has happened.",10):ToAll()
  updatevalues()
  save()
  ctldsavedata()
  saveadmingroups()
  save_groups()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 2 Minutes \n - Persistance Data is now being saved, Nothing beyond this point will save until restart has happened.")
end,{},(((60*60) *(resethours)) - (60*2)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("MISSION CYLE WILL HAPPEN IN Aprox 1 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 1 Minutes")
end,{},(((60*60) *(resethours)) - (60*1)))

SCHEDULER:New(nil,function() 
MESSAGE:New("MISSION CYCLE HAPPENING",30):ToAll()
hm("` $SERVERNAME - Server Info:` Server is now restarting")
trigger.action.setUserFlag(100,1)
end,{},((60*60)*resethours))