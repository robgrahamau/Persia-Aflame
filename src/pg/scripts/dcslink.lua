----------------------------------------
----- BASED ON THE DCSTCP Link by DDCS.
-- Heavily Modified by Rob Graham.
-- for use on Red Iberia.
---------------------------------------

do
    -- lets start commenting some of this shit.
    local PORT = 3009 -- our port
    local DATA_TIMEOUT_SEC = 600 -- How often we send data.
  
    package.path = package.path..";.\\LuaSocket\\?.lua"
    package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
 
    if os ~= nil then
        nowTime = os.time()
    else
        nowTime = 000000000
    end
    
    local socket = require("socket") -- load in socket
    local JSON = loadfile("Scripts\\JSON.lua")() -- load in json.
    -- require = nil -- really need to delete this i don't like it unseting shit on me will fix later
  
    local function log(msg)
        env.info("DCS-TCP Link (t=" .. timer.getTime() .. "): " .. msg)
    end
	fobs = true
    -- make the stuff that doesn't need to be run 'every' time.
    local clientset = SET_CLIENT:New():FilterActive(true):FilterStart()
    local redclients = clientset:FilterCoalitions("red")
    local blueclients = clientset:FilterCoalitions("blue")
    local _map = UTILS.GetDCSMap()
    local _missiondate = UTILS.GetDCSMissionDate()
    local _magdec = UTILS.GetMagneticDeclination()
    local redbulls =  coalition.getMainRefPoint(1)
    local bluebulls = coalition.getMainRefPoint(2)
    local rlat,rlon,ralt = coord.LOtoLL(redbulls)
    local blat,blon,balt = coord.LOtoLL(bluebulls)
    log("DCS-TCP Link Started on Port:".. PORT .. " Time out is:" .. DATA_TIMEOUT_SEC)    
    log("Grabbing Mission Data Mission is now")
    log("Map:".._map)
    log("Mission Date:" .. _missiondate)
    log("Map Mag Dec:" .. _magdec)
    log("Red Bullseye, Lat:" .. rlat .. "/Lon:" .. rlon)
    log("Blue Bullseye, Lat:" .. blat .. "/Lon:" .. blon)
    local cacheDB = {} -- our cachedb, this stores the data below, so if we loose a connection we need to reset this 
  -- this builds our packet.
    local function getDataMessage()
      local totalunits = 0;
      local payload = {} -- This is our actual 'packet' itself the data message
      payload.units = {} -- all the units in the packet
      payload.airbases = {} -- updates all our airbases
      payload.missiondata = {} -- updates our mission data 
      payload.ewintel = {}
      payload.sams = {}
      payload.scud = {}
      payload.iran = {}
      payload.markers = {}
      -- gets our current in game mission time.
      -- we are doing this here because.. weird things happened when i did it as one big string.
      -- or used the moose item.
      mabs = timer.getAbsTime()
      mabshours = mabs/3600
      mabshours = math.floor(mabshours)
      mabsmins = mabs/60 - (mabshours*60)
      mabsmins = math.floor(mabsmins)
      mabssec = mabs - mabshours*3600 - mabsmins * 60
      mabssec = math.floor(mabssec)
      mabsday = mabs/86400
      local ctime = string.format("%02.f:%02.f:%02.f + %d",mabshours,mabsmins,mabssec,mabsday)
      -- Make our packet.
      local curmisdata = {
         abstime = mabs,
         map = _map,
         magdec = _magdec,
         missiondate = _missiondate,
         formattime = ctime,
         clientcount = clientset:Count(),
         blueclients = blueclients:Count(),
         redclients = redclients:Count(),
         rlat = rlat,
         rlon = rlon,
         blat = blat,
         blon = blon,
         ntime = nowTime
      }
      payload.missiondata = curmisdata -- update our data.
      local function updatemarkers()
		local makers = world.getMarkPanels()
		for k, v in pairs(makers) do
		local lat,lon,alt = coord.LOtoLL(v.pos)
		latlonmarker = {
			["coalition"]= v.coalition,
			["idx"] = v.idx,
			["time"] = v.time,
			["author"] = v.author,
			["text"] = v.text,
			["groupID"] = v.groupID,
			["lat"] = lat,
			["lon"] = lon,
			["alt"] = alt,
		}
		table.insert(payload.markers,latlonmarker)
		end
	  end
	  updatemarkers()
      local function updateintel(g,type)
        local co = g:GetCoordinate()
        local lat, lon, alt = coord.LOtoLL(co:GetVec3())
        local intel = {
         lat = lat,
         lon = lon,
         alt = alt,
         groupname = g:GetName(),
         type = type,
         lupdate = nowTime,
        }
        return intel
      end
      
      if RED_EW_SET ~= nil then
        RED_EW_SET:ForEachGroupAlive(function(g) 
          table.insert(payload.ewintel,updateintel(g,"ew"))
        end)
      end
      
      if RED_SAM_SET ~= nil then
        RED_SAM_SET:ForEachGroupAlive(function(g)
            table.insert(payload.sams,updateintel(g,"sam"))
        end)
      end
      
      if RED_SCUD_SET ~= nil then
        RED_SCUD_SET:ForEachGroupAlive(function(g)  
          table.insert(payload.scud,updateintel(g,"scud"))
        end)      
      end
      
      if RED_I_SET ~= nil then
        RED_I_SET:ForEachStatic(function(g) 
          if g:IsAlive() == true then
            table.insert(payload.iran,updateintel(g,"struc"))
          end
        end)
      end
      
      -- runs through and collects information for the airbases.
      local function updateairbase(airbasename)
        local cab = AIRBASE:FindByName(airbasename)
        local ac = cab:GetCoordinate()
        local currentWindDirection, currentWindStrengh = ac:GetWind()
        local currentPressure = ac:GetPressure()
        local currentTemperature = ac:GetTemperature()
        local weathertext = string.format("Wind from %d@%.1fkts, QNH %.2f, Temperature %d", currentWindDirection, UTILS.MpsToKnots(currentWindStrengh), currentPressure * 0.0295299830714, currentTemperature)
        
        local position = cab:GetPosition()
        local lat, lon, alt = coord.LOtoLL(position.p)
        local c = cab:GetCoalition()
        local curairbase = {
          airbasename = airbasename,
          coalition = c,
          lat = lat,
          lon = lon,
          pressure = currentPressure,
          winddirection = currentWindDirection,
          windstrength = currentWindStrengh,
          temp = currentTemperature,
          weatherstring = weathertext
        }
        table.insert(payload.airbases,curairbase)
      end
      
      local function airbaserunthrough()
        env.info("Test")
        if _map == "Caucasus" then
          for i,item in pairs(AIRBASE.Caucasus) do 
            updateairbase(item)
          end
        elseif _map == "Nevada" then
          for i,item in pairs(AIRBASE.Nevada) do
            updateairbase(item)
          end
        elseif _map == "Normandy" then
          for i,item in pairs(AIRBASE.Normandy) do
            updateairbase(item)
          end
        elseif _map == "PersianGulf" then
          for i,item in pairs(AIRBASE.PersianGulf) do
            updateairbase(item)
          end
        end
        if fobs == true then
          if AIRBASE_STATICS ~= nil then
             AIRBASE_STATICS:ForEach(function (stat)
                local _name = stat:GetName()
                if AIRBASE:FindByName(_name) ~= nil then
                  updateairbase(_name)
                end
              end)
          end
        end
      end
      airbaserunthrough()
      
      local checkDead = {} -- creates the dead table
      -- basically runs a function to add a unit into the cache or update it.
      local function addUnit(unit, unitID, coalition, lat, lon, alt, action)
      -- stores dcs data.
      
      local curUnit = {
        action = action,
        unitID = unitID
      }
      -- far as i can work out here, action c is create action u is update.
      if action == "C" or action == "U" then
        -- make a entry or find the entry in cachedb with the unit id. then build it
        cacheDB[unitID] = {}
        
        local mooseunit = UNIT:Find(unit) -- this needs to be here moron so that the units actually ALIVE when we request it
        cacheDB[unitID].lat = lat
        cacheDB[unitID].lon = lon
        cacheDB[unitID].alt = alt
        cacheDB[unitID].speed = mooseunit:GetVelocityKNOTS()
        cacheDB[unitID].heading = mooseunit:GetHeading()
        curUnit.lat = lat
        curUnit.lon = lon
        curUnit.alt = alt
        curUnit.heading = mooseunit:GetHeading()
        curUnit.speed = mooseunit:GetVelocityKNOTS()
        -- if we create shit then we get the types and the names and store it 
        -- we aren't doing this atm 
        --if action == "C" then
          curUnit.type = unit:getTypeName()
          curUnit.coalition = coalition
          local unitdesc = unit:getDesc()
          tempcategory = unitdesc.category
          if tempcategory == Unit.Category.GROUND_UNIT then
            curUnit.category = "Ground"
          elseif tempcategory == Unit.Category.AIRPLANE then
            curUnit.category = "Air"
          elseif tempcategory == Unit.Category.HELICOPTER then
            curUnit.category = "Heli"
          elseif tempcategory == Unit.Category.SHIP then
            curUnit.category = "Ship"
          else
            curUnit.category = "Other"
          end
          curUnit.missionname = unit:getName()
          local unitdisplayname = unitdesc.displayName
          if unitdisplayname ~= nil then
            curUnit.displayname = unitdisplayname
          else
            curUnit.displayname = ""
          end
          local PlayerName = unit:getPlayerName()
          if PlayerName ~= nil then
             curUnit.playername = PlayerName
          else
             curUnit.playername = ""
          end
       -- end
     end
      -- insert the unit into the payload table..
            table.insert(payload.units, curUnit)
        end
    
    -- entire group run through
        local function addGroups(groups, coalition)
            for groupIndex = 1, #groups do
                local group = groups[groupIndex]
                local units = group:getUnits()
                for unitIndex = 1, #units do
                    local unit = units[unitIndex]
                    local unitID = tonumber(unit:getID())
                    local unitPosition = unit:getPosition()
                    local lat, lon, alt = coord.LOtoLL(unitPosition.p)
                    --check against cache table (keep tabs on if unit is new to table, if table has unit that no longer exists or if unit moved
                     if Unit.isExist(unit) and Unit.isActive(unit) then
                         totalunits = totalunits + 1
                         if cacheDB[unitID] ~= nil then
                             --env.info('cachelat: '..cacheDB[unitID].lat..' reg lat: '..lat..' cachelon: '..cacheDB[unitID].lon..' reg lon: '..lon)
                                 addUnit(unit, unitID, coalition, lat, lon, alt, "U")
                         else
                             addUnit(unit, unitID, coalition, lat, lon, alt, "C")
                         end
                         checkDead[unitID] = 1
                    end
                end
            end
        end
    
        local redGroups = coalition.getGroups(coalition.side.RED)
        addGroups(redGroups, 1)
        local blueGroups = coalition.getGroups(coalition.side.BLUE)
        addGroups(blueGroups, 2)

        --check dead, send delete action to server if dead detected
        local unitCnt = 0
        for k, v in pairs( cacheDB ) do
            if checkDead[k] == nil then
                addUnit(0, k, 0, 0, 0, 0, "D")
            end
            unitCnt = unitCnt + 1
        end
        -- store the unit count
        payload.unitCount = unitCnt
        -- env.info("Unit Count by Dump is:" .. totalunits)
        -- env.info("Unit Count by payload is:" .. payload.unitCount)
        return payload -- return the payload.
    end

    
  
   -------------------------------- want a clear spacer here ---------------------------------
   -- need it for my brain ------------------------------------------
   --------------------------------------------------------
   --------------------------------------------------------
  
    log("Starting DCS unit data server")
    
    
    local tcp = socket.tcp() -- create a tcp socket.
    local bound, error = tcp:bind('*', PORT) -- bind the tcp socket to the port but all addresses.
    
    -- if we can't bind the port we need to say so.
    if not bound then
        log("Could not bind: " .. error)
        return
    end
    
    log("Port " .. PORT .. " bound") -- dump out a message 
  -- start the server by opening listen if it returns an error spit it out else well just say.
    local serverStarted, error = tcp:listen(1) 
    if not serverStarted then
        log("Could not start server: " .. error)
        return
    end
    log("Server started")

  -- starts a client, 
    local client
    local function step()

        if not client then
            tcp:settimeout(0.001)
            client = tcp:accept()

            if client then
                tcp:settimeout(0)
                log("Connection established")
            end
        end

 
        if client then
            local msg = JSON:encode(getDataMessage()).."\n"
            --env.info(msg)
            local bytes, status, lastbyte = client:send(msg)
            if not bytes then
                log("Connection lost")
        cacheDB = {} -- clean out the cache we'll need to resend it because chances are the servers reset.
                client = nil
            end
        end
    end

    timer.scheduleFunction(function(arg, time)
        local success, error = pcall(step)
        if not success then
            log("Error: " .. error)
        end
        return timer.getTime() + DATA_TIMEOUT_SEC
    end, nil, timer.getTime() + DATA_TIMEOUT_SEC)
end
