

function _split(str, sep)
  BASE:E({str=str, sep=sep})  
  local result = {}
  local regex = ("([^%s]+)"):format(sep)
  for each in str:gmatch(regex) do
    table.insert(result, each)
  end
  return result
end


 
SupportHandler = EVENTHANDLER:New()





local function tankerCooldownHelp(tankername)
  BCC:MessageToCoalition(string.format("Tanker routing is now available again for %s. Use the following marker commands:\n-tanker route %s \n-tanker route %s ,h <0-360>,d <5-100>,a <10-30,000>,s <250-400> \nFor more control",tankername,tankername,tankername), MESSAGE.Type.Information)
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
                BCC:MessageTypeToCoalition(string.format("ARCO Tanker Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60), MESSAGE.Type.Information)
              return
            end
            tanker = Arco11
            if tanker:IsAlive() ~= true then
              BCC:MessageTypeToCoalition("ARCO is currently not avalible for tasking, it's M.I.A",MESSAGE.Type.Information)
              return
            end
            ARC_Timer = currentTime
         elseif text:find("texaco11") or text:find("tex11") then
            local tankername = "TEXACO11"
            tanker = Texaco11
            local cooldown = currentTime - TEX_Timer
              if cooldown < TANKER_COOLDOWN then 
                BCC:MessageTypeToCoalition(string.format("TEXACO11 Tanker Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60), MESSAGE.Type.Information)
              return
            end
            if tanker:IsAlive() ~= true then
              BCC:MessageTypeToCoalition("TEXACO11 is currently not avalible for tasking it's M.I.A",MESSAGE.Type.Information)
              return
            end
            TEX_Timer = currentTime
          elseif text:find("texaco21") or text:find("tex21") then
            local tankername = "TEXACO21"
            tanker = Texaco21
            local cooldown = currentTime - TEX2_Timer
              if cooldown < TANKER_COOLDOWN then 
                BCC:MessageTypeToCoalition(string.format("TEXACO21 Tanker Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60), MESSAGE.Type.Information)
              return
            end
            if tanker:IsAlive() ~= true then
              BCC:MessageTypeToCoalition("TEXACO21 is currently not avalible for tasking it's M.I.A",MESSAGE.Type.Information)
              return
            end
            TEX2_Timer = currentTime
          else
          BCC:MessageTypeToCoalition("No known Tanker was included in the Tanker Route Command, please select ARCO21 or TEXACO21",MESSAGE.Type.Information)
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
        MESSAGE:New( string.format("%s Tanker is re-routed to the player requested destination.\nIt will orbit on a heading of %d for %d nm, Alt: %d Gnd Speed %d.\n%d minutes cooldown starting now", tanker:GetName(),heading,distance,altft,spknt, TANKER_COOLDOWN / 60),20, MESSAGE.Type.Information )      
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
    local currentWindDirection1, currentWindStrength1 = coord:GetWind(500)
    local currentWindDirection2, currentWindStrength2 = coord:GetWind(1000)
    local currentWindDirection5, currentWindStrength5 = coord:GetWind(2000)
    local currentWindDirection10, currentWindStrength10 = coord:GetWind(5000)
    local weatherString = string.format("Requested weather: Wind from %d@%.1fkts, QNH %.2f, Temperature %d", currentWindDirection, UTILS.MpsToKnots(currentWindStrengh), currentPressure * 0.0295299830714, currentTemperature)
    local weatherString1 = string.format("Wind 100ft(possibly Meters): Wind from%d@%.1fkts",currentWindDirection1, UTILS.MpsToKnots(currentWindStrength1))
    local weatherString2 = string.format("Wind 1,000ft(possibly Meters): Wind from%d@%.1fkts",currentWindDirection2, UTILS.MpsToKnots(currentWindStrength2))
    local weatherString5 = string.format("Wind 2,000ft(possibly Meters): Wind from%d@%.1fkts",currentWindDirection5, UTILS.MpsToKnots(currentWindStrength5))
    local weatherString10 = string.format("Wind 5,000ft(possibly Meters): Wind from%d@%.1fkts",currentWindDirection10, UTILS.MpsToKnots(currentWindStrength10))
    if red == false then
    MESSAGE:New(weatherString, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString1, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString2, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString5, 30, MESSAGE.Type.Information):ToBlue()
    MESSAGE:New(weatherString10, 30, MESSAGE.Type.Information):ToBlue()
    else
    MESSAGE:New(weatherString, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString1, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString2, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString5, 30, MESSAGE.Type.Information):ToRed()
    MESSAGE:New(weatherString10, 30, MESSAGE.Type.Information):ToRed()
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
          coord:Explosion(250)
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
        markRemoved(Event,Event.coalition)
    end
end


world.addEventHandler(SupportHandler)

