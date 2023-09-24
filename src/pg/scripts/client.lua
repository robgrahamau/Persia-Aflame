
PlayerMap = {}
PlayerRMap = {}
PlayerBMap = {}
SetPlayer = SET_CLIENT:New():FilterStart()

resethours = 12
hourstoreset = 12
trigger.action.setUserFlag("SSB",100)
newyears = false
fireworksdone = false

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
function fireworks(coord)
	coord:FlareGreen(20)
	coord:FlareGreen(60)
	coord:FlareGreen(80)
	coord:FlareRed(10)
	coord:FlareRed(30)
	coord:FlareRed(70)
	coord:FlareYellow(40)
	coord:FlareYellow(45)
	coord:FlareYellow(90)
end
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

	if nowDay == 1 and nowMonth == 1 and nowHour == 0 and nowminute == 0 then
		if newyears == false then
			MESSAGE:New("Happy New Year from the TGW Crew to all of you!",120):ToAll()
      STTS.TextToSpeech("Happy New Year from the TGW Crew to all of you!", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
			newyears = true
		end
	end
	if nowHour == (serverrestart - 1) then
		if nowminute == 0 then
			if hrleft ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 1 hour",15):ToAll()
				grpctts("" .. serverrestart .. ":00 Server Restart in 1 hour",253,"all")
				-- STTS.TextToSpeech("The Server will restart in 1 hour", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
			end
		elseif nowminute == 30 then
			if left30 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 30 Minutes",15):ToAll()
				grpctts("" .. serverrestart .. ":00 Server Restart in 30 Minutes",253,"all")
				-- STTS.TextToSpeech("The Server will restart in 30 Minutes", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
				left30 = true
			end
		elseif nowminute == 45 then
			if left45 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 15 Minutes",15):ToAll()
        grpctts("" .. serverrestart .. ":00 Server Restart in 15 Minutes",253,"all")
				--STTS.TextToSpeech("The Server will restart in 15 Minutes", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
				left45 = true
			end
		elseif nowminute == 50 then
			if left50 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 10 Minutes",15):ToAll()
				grpctts("" .. serverrestart .. ":00 Server Restart in 10 Minutes",253,"all")
        left50 = true
			end
		elseif nowminute == 55 then
			if left55 ~= true then
				MESSAGE:New("" .. serverrestart .. ":00 Server Restart in 5 Minutes Forced Save has occured.",15):ToAll()
        grpctts("" .. serverrestart .. ":00 Server Restart in about 5 Minutes",253,"all")
				-- STTS.TextToSpeech("The Server will restart in 5 Minutes", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
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
				grpctts("" .. serverrestart .. ":00 Server Restart in 1 Minutes",253,"all")
        -- STTS.TextToSpeech("The Server will restart in 1 Minute", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
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
	    local mission = activeareairan
      if Coalition == 2 then
        col = "Coalition Forces"
		mission = activearea
      end
      local PlayerName = PlayerClient:GetPlayerName()
      if PlayerClient:IsAlive() then
		if newyears == true then
			if fireworksdone == false then
				local coord = PlayerClient:GetCoordinate()
				fireworks(coord)
				SCHEDULER:New(nil,fireworks,coord,5)
				SCHEDULER:New(nil,fireworks,coord,25)
			end
		end
        if PlayerMap[PlayerID] ~= true then
          PlayerMap[PlayerID] = true
          local MessageText = "Welcome to Persia Aflame by Rob Graham Version: "..version.." Last update:"..lastupdate.." ".. PlayerName .. "\n Powered By Moose, Player Donations, OverlordBot, Lots of Pain Killers, and lets not forget the space server Hamsters! \n THE EYES BOO GO FOR THE EYES! \n DCS Server Version: Open Beta \n Current Active Tasking is: " .. mission .. "\n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n, You are on " ..col..", Please be aware this mission is geared towards Coalition Forces attacking Iran is defending by and large. Please check the mission brief for more information ALT+B \n Please Join the DISCORD SEE ALT+B for Links \n Supplied by core members of Http://TaskGroupWarrior.Info \n Current Time is: " .. currenttime .. " Server Mission Cycle:" .. restarttime .." \n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n you can check the leaderboard on discord at: https://discord.gg/F6amrC4PkA \n UNICOM is 122.80 VHF, use for ATC please."
          MESSAGE:New(MessageText,15,"Server Info",false):ToClient(PlayerClient)
          hm(">` $SERVERNAME - Ground Crew:` " .. PlayerClient:GetPlayerName() .. " is in the pit, straps are tight, their " ..PlayerClient:GetTypeName() .. " belonging to " .. col .. " is fueled and ready to go \n > Good Luck Out there")
		  SCHEDULER:New(nil,function() 
			local msgtext = "Current Active Tasking is: \n" .. mission .. ""
			MESSAGE:New(msgtext,120,"Mission Tasking Info",false):ToClient(PlayerClient)
		  end,nil,120)
        end
      else
        if PlayerMap[PlayerID] ~= false then
          PlayerMap[PlayerID] = false
        end      
      end      
     end) 
	if newyears == true and fireworksdone == false then
		fireworksdone = true
		BASE:E({"Fireworks should be over"})
	end
	 
end
C_Arco12 = nil

function Arco11A10()
  local __ARCO11 = GROUP:FindByName("Arco 11")
  local rf = ZONE:New("rf")
  local altitude = UTILS.FeetToMeters(15000)
  local speed = UTILS.KnotsToMps(260) 
  local heading = 210
  local distance = 50
  local coord = rf:GetCoordinate()
  local endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
  __ARCO11:ClearTasks()
  local routeTask = __ARCO11:TaskOrbit(coord,altitude,speed,endcoord)
  __ARCO11:SetTask(routeTask,2)
  local tankerTask = __ARCO11:EnRouteTaskTanker()
  __ARCO11:PushTask(tankerTask,4)
  MESSAGE:New("ARCO11 is now reducing speed to 260 Knots Ground and moving to Anchor point for A10 Refueling",15):ToBlue()
  hm("Arco has increased its speed to 260 Knots ground speed to cater to slow A10's")
  C_Arco11:Remove()
  C_Arco12 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for FGTR",C_tanker,Arco11FTR,nil)
end

function Arco11FTR()
  local __ARCO11 = GROUP:FindByName("Arco 11")
  local rf = ZONE:New("rf")
  local altitude = UTILS.FeetToMeters(15000)
  local speed = UTILS.KnotsToMps(360) 
  local heading = 210
  local distance = 50
  local coord = rf:GetCoordinate()
  local endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
  __ARCO11:ClearTasks()
  local routeTask = __ARCO11:TaskOrbit(coord,altitude,speed,endcoord)
  __ARCO11:SetTask(routeTask,2)
  local tankerTask = __ARCO11:EnRouteTaskTanker()
  __ARCO11:PushTask(tankerTask,4)
  MESSAGE:New("ARCO11 is now increasing speed to 360 Knots Ground and moving to Anchor point for FGTR Refueling",15):ToBlue()
  hm("Arco has increased its speed to 360 knots over the ground for Fighter Refueling")
  C_Arco12:Remove()
  C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)
end

function TnkerBroadcast()
  trigger.action.setUserFlag("tnkerbrd",1) 
  MESSAGE:New("Western Tankers Pinging their Tacan's for 5 minutes, 80x & 81x",5,"TANKER INFO"):ToBlue()
end

C_menu = MENU_COALITION:New(coalition.side.BLUE,"AI CONTROL")
C_tanker = MENU_COALITION:New(coalition.side.BLUE,"Tanker Control",C_menu)
C_Arco11 = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Change ARCO11 Speed for A10",C_tanker,Arco11A10,nil)
C_TACANS = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Request TCN Pulse",C_tanker,TnkerBroadcast,nil)

function irancurrenttask()
  MESSAGE:New("Updated Tasking from HQ \n " .. activeareairan .. " \n Repel the Infidels",60):ToRed()
end

function bluecurrenttask()
  MESSAGE:New("Updated Tasking from HQ \n " .. activearea .. " \n",60):ToBlue()

end

redtask = MENU_COALITION_COMMAND:New(coalition.side.RED,"Current Mission Task",nil,irancurrenttask,nil)
bluetask = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Current Mission Task",nil,bluecurrenttask,nil)


SCHEDULER:New(nil,permanentPlayerCheck,{},1,2)
function nextreset()
  resettime()
end



function resettime()
  SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  -- STTS.TextToSpeech("SERVER RESTART WILL HAPPEN IN ".. hourstoreset .. " HOURS", "253", "AM", "1", "Testing", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
  grpctts("SERVER RESTART WILL HAPPEN IN ".. hourstoreset .. " HOURS",253,"all")
  hm("` $SERVERNAME - Server Info: ` SERVER RESTART WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
  local msgtext = "Current Active Tasking is: " .. activearea .. ""
	MESSAGE:New(msgtext,60,"Mission Tasking Info",false):ToAll()
  hourstoreset = hourstoreset - 1
  if hourstoreset < resethours then
    nextreset()
  end
  end,{},60*60)
end
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  hm("` $SERVERNAME - Server Info` SERVER RESTART WILL HAPPEN IN ".. hourstoreset .. " HOURS \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
  hourstoreset = hourstoreset - 1
  nextreset() 
end,{},1)

SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN 1 HOUR \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard",60):ToAll()
  -- STTS.TextToSpeech("SERVER RESTART WILL HAPPEN IN 1 HOUR", "253", "AM", "1", "TGW STTS Server Alert", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
  hm("` $SERVERNAME - Server Info ` SERVER RESTART WILL HAPPEN IN 1 HOUR \n Current Server time is: ".. nowHour .. ":" .. nowminute .."\n A Reset will always happen at " .. serverrestart .. ":00  Sydney Australia time. \n remember to visit our website at http://taskgroupwarrior.info \n and check your leadboard spot http://taskgroupwarrior.info:8080/leaderBoard")
end,{},((60*60) * (resethours - 1)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 45 Minutes",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 45 Minutes")
end,{},(((60*60) *(resethours)) - (60*45)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 30 Minutes",10):ToAll()
  --STTS.TextToSpeech("SERVER RESTART WILL HAPPEN IN 30 Minutes", "253", "AM", "1", "TGW STTS Server Alert", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 30 Minutes")
end,{},(((60*60) *(resethours)) - (60*30)))
SCHEDULER:New(nil,function() 
      MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 15 Minutes",10):ToAll()
    hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 15 Minutes")
end,{},(((60*60) *(resethours)) - (60*15)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 10 Minute",10):ToAll()
    STTS.TextToSpeech("SERVER RESTART WILL HAPPEN IN 10 MINUTES", "253", "AM", "1", "TGW STTS Server Alert", "2", nil, 1, "female", "en-US", "Microsoft Zira Desktop", false)
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 10 Minutes")
end,{},(((60*60) *(resethours)) - (60*10)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 5 Minutes",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 5 Minutes")
end,{},(((60*60) *(resethours)) - (60*5)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 4 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 4 Minutes")
end,{},(((60*60) *(resethours)) - (60*1)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 3 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 3 Minutes")
end,{},(((60*60) *(resethours)) - (60*3)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 2 Minute \n Persistance Data is now being saved, Nothing beyond this point will save until restart has happened.",10):ToAll()
  hm("2 minutes")
  updatevalues()
  save()
  MainSave:Save_Groups()
  Csave:SaveData()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 2 Minutes \n - Persistance Data is now being saved, Nothing beyond this point will save until restart has happened.")
end,{},(((60*60) *(resethours)) - (60*2)))
SCHEDULER:New(nil,function() 
  MESSAGE:New("SERVER RESTART WILL HAPPEN IN Aprox 1 Minute",10):ToAll()
  hm("` $SERVERNAME - Server Info:` Mission Cycle will happen in 1 Minutes")
end,{},(((60*60) *(resethours)) - (60*1)))

SCHEDULER:New(nil,function() 
MESSAGE:New("Server Restart HAPPENING",30):ToAll()
hm("` $SERVERNAME - Server Info:` Server is now restarting")
trigger.action.setUserFlag(100,1)
end,{},((60*60)*resethours))