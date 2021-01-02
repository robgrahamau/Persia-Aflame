

function _split(str, sep)
  BASE:E({str=str, sep=sep})  
  local result = {}
  local regex = ("([^%s]+)"):format(sep)
  for each in str:gmatch(regex) do
    table.insert(result, each)
  end
  return result
end

admin = false
password = "tgw2020"
adminspawned = {} 
SupportHandler = EVENTHANDLER:New()





local function tankerCooldownHelp(tankername)
  MESSAGE:New(string.format("Tanker routing is now available again for %s. Use the following marker commands:\n-tanker route %s \n-tanker route %s ,h <0-360>,d <5-100>,a <10-30,000>,s <250-400> \nFor more control",tankername,tankername,tankername), MESSAGE.Type.Information):ToBlue()
end

local function handleBlueTankerRequest(text,coord)
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
        local tankername = ""
        BASE:E({keywords=keywords})
        for _,keyphrase in pairs(keywords) do
          local str=_split(keyphrase, " ")
          local key=str[1]
          local val=str[2]
          -- BASE:E(string.format("%s, keyphrase = %s, key = %s, val = %s", "route", tostring(keyphrase), tostring(key), tostring(val)))
          if key:lower():find("h") then
            heading = tonumber(val)
            -- BASE:E({"Tanker Movement we have heading",heading})
          end
          if key:lower():find("d") then
            distance = tonumber(val)
            -- BASE:E({"Tanker Movement we have distance",distance})
          end
          if key:lower():find("a") then
            altitude = tonumber(val)
            -- BASE:E({"Tanker Movement we have altitude ",altitude})
          end
          if key:lower():find("s") then
            speed = tonumber(val)
            -- BASE:E({"Tanker Movement we have speed",speed})
          end
        end
        local tanker = nil
        -- find our tanker
        if text:find("arco11") or text:find("arc11") then
            local tankername = "ARCO"
            local cooldown = currentTime - ARC_Timer
              if cooldown < TANKER_COOLDOWN then 
                MESSAGE:New(string.format("ARCO Tanker Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60),30, MESSAGE.Type.Information):ToBlue()
              return
            end
            tanker = Arco11
            if tanker:IsAlive() ~= true then
              MESSAGE:New("ARCO is currently not avalible for tasking, it's M.I.A",30,MESSAGE.Type.Information):ToBlue()
              return
            end
            ARC_Timer = currentTime
         elseif text:find("texaco11") or text:find("tex11") then
            local tankername = "TEXACO11"
            tanker = Texaco11
            local cooldown = currentTime - TEX_Timer
              if cooldown < TANKER_COOLDOWN then 
                MESSAGE:New(string.format("TEXACO11 Tanker Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60),30, MESSAGE.Type.Information):ToBlue()
              return
            end
            if tanker:IsAlive() ~= true then
              MESSAGE:New("TEXACO11 is currently not avalible for tasking it's M.I.A",30,MESSAGE.Type.Information):ToBlue()
              return
            end
            TEX_Timer = currentTime
          elseif text:find("texaco21") or text:find("tex21") then
            local tankername = "TEXACO21"
            tanker = Texaco21
            local cooldown = currentTime - TEX2_Timer
              if cooldown < TANKER_COOLDOWN then 
                MESSAGE:New(string.format("TEXACO21 Tanker Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60),30, MESSAGE.Type.Information):ToBlue()
              return
            end
            if tanker:IsAlive() ~= true then
              MESSAGE:New("TEXACO21 is currently not avalible for tasking it's M.I.A",30,MESSAGE.Type.Information):ToBlue()
              return
            end
            TEX2_Timer = currentTime
          else
          MESSAGE:New("No known Tanker was included in the Tanker Route Command, please select ARCO21 or TEXACO21",30,MESSAGE.Type.Information):ToBlue()
          return
        end
        if altitude == nil then
           altft = 19000
           altitude = UTILS.FeetToMeters(19000)
        else
           if altitude > 30000 then
             altitude = 30000
           elseif altitude < 10000 then
             altitude = 10000
           end
           altft = altitude
           altitude = UTILS.FeetToMeters(altitude)
         end
         if speed == nil then
            spknt = 370
            speed = UTILS.KnotsToMps(370)
         else
            if speed > 450 then
              speed = 450
            elseif speed < 250 then
              speed = 250
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
            if distance > 100 then
              distance = 100
            end
            if distance < 5 then
              distance = 5
            end
            endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
          else
            endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
            distance = 25
          end
        else
          heading = math.random(0,360)
          endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
          distance = 25
        end
        tanker:ClearTasks()
        local routeTask = tanker:TaskOrbit( coord, altitude,  speed, endcoord )
        tanker:SetTask(routeTask, 2)
        local tankerTask = tanker:EnRouteTaskTanker()
        tanker:PushTask(tankerTask, 4)
        MESSAGE:New( string.format("%s Tanker is re-routed to the player requested destination.\nIt will orbit on a heading of %d for %d nm, Alt: %d Gnd Speed %d.\n%d minutes cooldown starting now", tanker:GetName(),heading,distance,altft,spknt, TANKER_COOLDOWN / 60),20, MESSAGE.Type.Information ):ToBlue()      
        SCHEDULER:New(nil, tankerCooldownHelp, {tankername}, TANKER_COOLDOWN)
    end
end
local function handleRedTankerRequest(text,coord)
  MESSAGE:New("Tanker Routing Commands are Currently Not Supported",30,"Info"):ToRed()
end






local function handleWeatherRequest(text, coord, red)
    local currentPressure = coord:GetPressure(0)
    local currentTemperature = coord:GetTemperature()
    local currentWindDirection, currentWindStrengh = coord:GetWind()
	local currentWindDirection1a, currentWindStrength1a = coord:GetWind(UTILS.FeetToMeters(500))
    local currentWindDirection1, currentWindStrength1 = coord:GetWind(UTILS.FeetToMeters(1000))
    local currentWindDirection2, currentWindStrength2 = coord:GetWind(UTILS.FeetToMeters(2000))
    local currentWindDirection5, currentWindStrength5 = coord:GetWind(UTILS.FeetToMeters(5000))
    local currentWindDirection10, currentWindStrength10 = coord:GetWind(UTILS.FeetToMeters(10000))
    local weatherString = string.format("Requested weather: Wind from %d@%.1fkts, QNH %.2f, Temperature %d", currentWindDirection, UTILS.MpsToKnots(currentWindStrengh), currentPressure * 0.0295299830714, currentTemperature)
    local weatherString1 = string.format("Wind 500ft MSL: Wind from%d@%.1fkts",currentWindDirection1, UTILS.MpsToKnots(currentWindStrength1a))
    local weatherString2a = string.format("Wind 1,000ft MSL: Wind from%d@%.1fkts",currentWindDirection2, UTILS.MpsToKnots(currentWindStrength1))
	local weatherString2 = string.format("Wind 2,000ft MSL: Wind from%d@%.1fkts",currentWindDirection2, UTILS.MpsToKnots(currentWindStrength2))
    local weatherString5 = string.format("Wind 5,000ft MSL: Wind from%d@%.1fkts",currentWindDirection5, UTILS.MpsToKnots(currentWindStrength5))
    local weatherString10 = string.format("Wind 10,000ft MSL: Wind from%d@%.1fkts",currentWindDirection10, UTILS.MpsToKnots(currentWindStrength10))
    if red == false then
    MESSAGE:New(weatherString, 30, MESSAGE.Type.Information):ToBlue()
	MESSAGE:New(weatherString2a, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString1, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString2, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString5, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString10, 30, MESSAGE.Type.Information):ToBlue()
	HypeMan.sendBotMessage('$SERVERNAME - Weather Requested \n ' .. weatherString .. '\n' .. weatherString1 .. '\n' .. weatherString2 .. '\n' .. weatherString5 .. '\n' .. weatherString10 .. '\n')
    else
    MESSAGE:New(weatherString, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString1, 30, MESSAGE.Type.Information):ToRed()
	MESSAGE:New(weatherString2a, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString2, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString5, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString10, 30, MESSAGE.Type.Information):ToRed()
	HypeMan.sendBotMessage('$SERVERNAME - Weather Requested \n ' .. weatherString .. '\n' .. weatherString1 .. '\n' .. weatherString2 .. '\n' .. weatherString5 .. '\n' .. weatherString10 .. '\n')
    end
end

local function handleeadmin(text)
  local keywords=_split(text, ",")
   BASE:E({keywords=keywords})
   for _,keyphrase in pairs(keywords) do
    if keyphrase == password then
      if admin == false then
        admin = true
      else
        admin = false
      end
    end
   end
   if admin == true then
     MESSAGE:New("Admin Commands are Now Enabled",15):ToAll()
   else
     MESSAGE:New("Admin Commands are Disabled",15):ToAll()
   end
end


local function rhandleeadmin(text)
  local keywords=_split(text, ",")
   BASE:E({keywords=keywords})
   for _,keyphrase in pairs(keywords) do
    if keyphrase == password then
      if admin == false then
        admin = true
      else
        admin = false
      end
    end
   end
   if admin == true then
     BASE:E({"ADMIN ENABLED"})
	 --MESSAGE:New("Admin Commands are Now Enabled",15):ToAll()
   else
	BASE:E({"ADMIN DISABLED"})
     --MESSAGE:New("Admin Commands are Disabled",15):ToAll()
   end
end

local function handlespawn(text,coord)
  BASE:E({"Spawn Request",text,coord})
  local keywords=_split(text, ",")
  local unit = nil
  local name = nil
  local heading = nil
  local random = false
  for _,keyphrase in pairs(keywords) do
    local str=_split(keyphrase, " ")
    local key=str[1]
    local val=str[2]
    -- BASE:E(string.format("%s, keyphrase = %s, key = %s, val = %s", "route", tostring(keyphrase), tostring(key), tostring(val)))
    if key:lower():find("u") then
      unit = val
    elseif key:lower():find("n") then
      name = val
    elseif key:lower():find("h") then
      heading = tonumber(val)
    elseif key:lower():find("r") then
      if val:lower() == "true" then
        random = true
      else
        random = false
      end  
    end
  end

  
  if unit == "rarmour" then
    local su = SPAWN:NewWithAlias("GM_Tanks","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rarmour1" then
    local su = SPAWN:NewWithAlias("GM_Tanks-1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rarmour2" then
    local su = SPAWN:NewWithAlias("GM_Tanks-2","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rflak" then
    local su = SPAWN:NewWithAlias("GM_FLAK_RED","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rflak1" then
    local su = SPAWN:NewWithAlias("GM_BO_RED","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rinf" then
    local su = SPAWN:NewWithAlias("GM_Infantry","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rinf1" then
    local su = SPAWN:NewWithAlias("GM_Infantry-1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "raaa" then
    local su = SPAWN:NewWithAlias("GM_AAA","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rmpad" then
    local su = SPAWN:NewWithAlias("GM_AAA-1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
  elseif unit == "rsam" then
    local su = SPAWN:NewWithAlias("GM_SA10","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rgrad" then
    local su = SPAWN:NewWithAlias("GM_GRAD","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rroad" then
    local su = SPAWN:NewWithAlias("GM_ROAD","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bbase" then
    local su = SPAWN:NewWithAlias("GM_BBASE","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rbase" then
    local su = SPAWN:NewWithAlias("GM_BASE","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsa2" then
    local su = SPAWN:NewWithAlias("GM_SA2","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rrap" then
    local su = SPAWN:NewWithAlias("GM_RRAP","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rew" then
    local su = SPAWN:NewWithAlias("GM_REW","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "brap" then
    local su = SPAWN:NewWithAlias("GM_BRAP","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bhawk" then
    local su = SPAWN:NewWithAlias("GM_HAWK","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bart1" then
    local su = SPAWN:NewWithAlias("GM_BART1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bart2" then
    local su = SPAWN:NewWithAlias("GM_BART2","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bart3" then
    local su = SPAWN:NewWithAlias("GM_BART3","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rart1" then
    local su = SPAWN:NewWithAlias("GM_RART","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rhawk" then
    local su = SPAWN:NewWithAlias("GM_HAWKR","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bpat" then
    local su = SPAWN:NewWithAlias("GM_PAT","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bah64" then
    local su = SPAWN:NewWithAlias("GM_AH64","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
	elseif unit == "bjtac" then
    local su = SPAWN:NewWithAlias("GM_JTAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  	elseif unit == "bfac" then
    local su = SPAWN:NewWithAlias("GM_BFAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bsup" then
    local su = SPAWN:NewWithAlias("GM_BSUP","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rsup" then
    local su = SPAWN:NewWithAlias("GM_RSUP","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rah1" then
    local su = SPAWN:NewWithAlias("GM_AH1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rscud" then
    local su = SPAWN:NewWithAlias("GM_SCUD","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,200)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsa6" then
    local su = SPAWN:NewWithAlias("GM_SA6","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)  
  elseif unit == "barmour" then
    local su = SPAWN:NewWithAlias("GM_BArmor","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "barmour1" then
    local su = SPAWN:NewWithAlias("GM_BArmor-1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
elseif unit == "barmour2" then
    local su = SPAWN:NewWithAlias("GM_BArmor-2","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "binf" then
    local su = SPAWN:NewWithAlias("GM_BInf","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "binf1" then
    local su = SPAWN:NewWithAlias("GM_BInf-1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "uh60" then
    local su = SPAWN:NewWithAlias("GM_BH","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "mi8" then
    local su = SPAWN:NewWithAlias("GM_MI8","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "baaa" then
    local su = SPAWN:NewWithAlias("GM_BAAA","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu25t" then
    local su = SPAWN:NewWithAlias("GM_SU25T","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu24m2" then
    local su = SPAWN:NewWithAlias("GM_SU24M2","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu24m1" then
    local su = SPAWN:NewWithAlias("GM_SU24M1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu24m" then
    local su = SPAWN:NewWithAlias("GM_SU24M","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rmig29" then
    local su = SPAWN:NewWithAlias("GM_MIG29","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rf14" then
    local su = SPAWN:NewWithAlias("GM_F14","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
  elseif unit == "ba10" then
    local su = SPAWN:NewWithAlias("GM_A10","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bf15" then
    local su = SPAWN:NewWithAlias("GM_F15C","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bf15e" then
    local su = SPAWN:NewWithAlias("GM_F15E","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "afac" then
    local su = SPAWN:NewWithAlias("GM_AFAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rafac" then
    local su = SPAWN:NewWithAlias("GM_AFAC-1","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "afac2" then
    local su = SPAWN:NewWithAlias("GM_AFAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase("GM_USAA " .. name, _code) 
  elseif unit == "rafac2" then
    local su = SPAWN:NewWithAlias("GM_AFAC","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase("GM_IAA " .. name, _code) 
  elseif unit == "bjtac1" then
    local su = SPAWN:NewWithAlias("GM_BJTAC","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase("GM_USAA " .. name, _code) 
  elseif unit == "rjtac" then
    local su = SPAWN:NewWithAlias("GM_RJTAC","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase("GM_IAA " .. name, _code) 
  elseif unit == "hvt" then
    local su = SPAWN:NewWithAlias("GM_HVT","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "b52" then
    local su = SPAWN:NewWithAlias("GM_B52","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "b1" then
    local su = SPAWN:NewWithAlias("GM_B1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "c17" then
    local su = SPAWN:NewWithAlias("GM_C17A","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bc130" then
    local su = SPAWN:NewWithAlias("GM_BC130","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rc130" then
    local su = SPAWN:NewWithAlias("GM_RC130","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
	elseif unit == "il74" then
    local su = SPAWN:NewWithAlias("GM_IL76","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)	
	
	
  else
    MESSAGE:New("Banner: I tried Tony, I really tried...",10):ToAll()
  end
end



local function newhandlespawn(text,coord)
  BASE:E({"Spawn Request",text,coord})
  local keywords=_split(text, ",")
  local unit = nil
  local name = nil
  local heading = nil
  local random = false
  for _,keyphrase in pairs(keywords) do
    local str=_split(keyphrase, " ")
    local key=str[1]
    local val=str[2]
    -- BASE:E(string.format("%s, keyphrase = %s, key = %s, val = %s", "route", tostring(keyphrase), tostring(key), tostring(val)))
    if key:lower():find("u") then
      unit = val
    elseif key:lower():find("n") then
      name = val
    elseif key:lower():find("h") then
      heading = tonumber(val)
    elseif key:lower():find("r") then
      if val:lower() == "true" then
        random = true
      else
        random = false
      end  
    end
  end
  if unit ~= nil and name ~= nil  then
	local su = SPAWN:NewWithAlias(unit, "GM_USAA " .. name)
	if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
	if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  else
    MESSAGE:New("Banner: I tried Tony, I really tried...",10):ToAll()
  end
end
local function handledespawn(text)
  BASE:E({"DeSpawn Request",text})
  local keywords=_split(text, ",")
  local unit = nil
  BASE:E({"DESPAWN", keywords=keywords})
  unit = keywords[2]
  local mgroup = nil
  mgroup = GROUP:FindByName(unit)
  if mgroup == nil then
    BASE:E({"Despawn error no group found"})
    MESSAGE:New("Admin Command Error, group not found.")
  else
    if mgroup:IsAlive() == true then
      mgroup:Destroy()
    end
    BASE:E({"Despawning Unit",unit})
    MESSAGE:New("And with a finger snap " .. unit .. " has become dust in the wind",10):ToAll()
  end
end
function markRemoved(Event,EC)
    if Event.text~=nil and Event.text:lower():find("-") then 
        local text = Event.text:lower()
        local text2 = Event.text
        local vec3={y=Event.pos.y, x=Event.pos.x, z=Event.pos.z}
        local coord = COORDINATE:NewFromVec3(vec3)
        coord.y = coord:GetLandHeight()
        if Event.text:lower():find("-weather") then
            if EC == 2 then
              handleWeatherRequest(text, coord,false)
            else
              handleWeatherRequest(text, coord,true)
            end
        elseif Event.text:lower():find("-tanker") then
           if EC == 2 then
            handleBlueTankerRequest(text,coord)        
           else
            handleRedTankerRequest(text,coord)
           end
        elseif Event.text:lower():find("-smokered") then
          coord:SmokeRed()
        elseif Event.text:lower():find("-smokeblue") then
          coord:SmokeBlue()
        elseif Event.text:lower():find("-smokegreen") then
          coord:SmokeGreen()
        elseif Event.text:lower():find("-smokeorange") then
          coord:SmokeOrange()
        elseif Event.text:lower():find("-smoke") then
          coord:SmokeWhite()
        elseif Event.text:lower():find("-flare") then
          coord:FlareRed(math.random(0,360))
          SCHEDULER:New(nil,function() 
            coord:FlareRed(math.random(0,20))
          end,{},30)
        elseif Event.text:lower():find("-light") then
          coord:IlluminationBomb(100000)
        elseif Event.text:lower():find("-explode") then
          if admin == true then
            coord:Explosion(250)
            local rnd = math.random(1,5)
            if rnd == 1 then
              MESSAGE:New("Have you ever seen what happens to a toad that's struck by lightening?",15):ToAll()            
            elseif rnd == 2 then
              MESSAGE:New("Oh Boy.. that's not gonna buff out",15):ToAll()            
            elseif rnd == 3 then
              MESSAGE:New("Nuke it from orbit, it's the only way to be sure",15):ToAll()            
            elseif rnd == 4 then
              MESSAGE:New("This marker will self destruct in 5...4...3..2...1... Good Bye",15):ToAll()            
            elseif rnd == 5 then
              MESSAGE:New("Xenos Filth detected, Exterminatus in effect",15):ToAll()            
            else
              MESSAGE:New("If this plays something screwed up and well Something just went boom.",15):ToAll()            
            end
          else
            MESSAGE:New("Admin Commands need to be active to cause explosions from Unhigh",15):ToAll()
          end
        elseif Event.text:lower():find("-admin") then
          handleeadmin(text)
		elseif Event.text:lower():find("-radmin") then
          rhandleeadmin(text)
        elseif Event.text:lower():find("-spawn") then
          if admin == true then
            handlespawn(text,coord)
          else
            MESSAGE:New("Admin Commands need to be active to spawn new units",15):ToAll()
          end
		elseif Event.text:lower():find("-rspawn") then
          if admin == true then
            newhandlespawn(text,coord)
          else
            MESSAGE:New("Admin Commands need to be active to spawn new units",15):ToAll()
          end
		elseif Event.text:lower():find("-load") then
          if admin == true then
            dofile(lfs.writedir() .."pg\\input.lua")
          else
            MESSAGE:New("Admin Commands need to be active to input a file",15):ToAll()
          end
       elseif Event.text:lower():find("-despawn") then
          if admin == true then
            handledespawn(text2)
          else
            MESSAGE:New("Admin Commands need to be active to despawn units",15):ToAll()
          end
        end
    end
end

function SupportHandler:onEvent(Event)
    if Event.id == world.event.S_EVENT_MARK_ADDED then
        env.info(string.format("RIB: Support got event ADDED id %s idx %s coalition %s group %s text %s", Event.id, Event.idx, Event.coalition, Event.groupID, Event.text))
    elseif Event.id == world.event.S_EVENT_MARK_CHANGE then
        -- nothing atm
    elseif Event.id == world.event.S_EVENT_MARK_REMOVED then
         env.info(string.format("RIB: Support got event ADDED id %s idx %s coalition %s group %s text %s", Event.id, Event.idx, Event.coalition, Event.groupID, Event.text))
         env.info(Event)
        markRemoved(Event,Event.coalition)
    end
end


world.addEventHandler(SupportHandler)

