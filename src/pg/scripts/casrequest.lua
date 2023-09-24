C_CAS = {
    Classname = "CAS FAP",
    clients = nil,
    client = {},
    clientmenus = {},
    maxrange = UTILS.NMToMeters(60),
    minrange = UTILS.NMToMeters(10),
    spawned = false,
    maxtime = 180,
    rspawntemplates = {},
    bspawntemplates = {},
    groupname = nil,
    beattime = 10,
    debug = false,
    redtemplates = {
        fulltable = {'Ural-375 ZU-23','BTR-80','ZSU-23-4 Shilka','Strela-1 9P31','Strela-10M3','BMD-1','BMP-1','BMP-2','BMP-3','BRDM-2','T-55','T-72B','T-80UD','T-90','T-55','Tor 9A331','Osa 9A33 ln','Ural-375','Soldier AK','SA-18 Igla-S manpad','Stinger manpad','Paratrooper RPG-16'},
        mechtable = {'Ural-375 ZU-23','BTR-80','ZSU-23-4 Shilka','Strela-1 9P31','Strela-10M3','BMD-1','BMP-1','BMP-2','BMP-3','BRDM-2','Tor 9A331','Osa 9A33 ln','Ural-375','Soldier AK','SA-18 Igla-S manpad','Stinger manpad','Paratrooper RPG-16'},
        lightmechtable = {'Ural-375 ZU-23','BTR-80','Strela-1 9P31','Strela-10M3','BMD-1','BMP-1','BMP-2','BMP-3','BRDM-2','Osa 9A33 ln','Ural-375','Soldier AK','SA-18 Igla-S manpad','Stinger manpad','Paratrooper RPG-16'},
        armortable = {'Ural-375 ZU-23','BTR-80','ZSU-23-4 Shilka','Strela-1 9P31','Tor 9A331','Strela-10M3','BMD-1','BMP-1','BMP-2','BMP-3','BRDM-2','T-55','T-72B','T-80UD','T-90','T-55','Tor 9A331','Osa 9A33 ln','Ural-375'},
        infantrytable = {'Ural-375','Soldier AK','SA-18 Igla-S manpad','Stinger manpad','Paratrooper RPG-16','Ural-375 ZU-23'},
    },
    redprefix = "cjtf_red_",
    redcountry = country.id.CJTF_RED,
}

function C_CAS:New(_name,_coalition,_prefix)
    self = BASE:Inheret(self,BASE:New())
    self.name = _name
    self.clients = SET_CLIENT:New():FilterCoalitions(_coalition):FilterActive(true):FilterStart()
    self.prefix = _prefix
    return self
end

function C_CAS:MenuCreator()
    BASE:E({"self.name","Menu Creator"})
    self.clients:ForEachClient(function(MooseClient)
      if MooseClient:GetGroup() ~= nil then
        local _group = MooseClient:GetGroup()
        self:CreateMenu(_group,MooseClient,self.topmenu)
      end
    end)
end

  --- Creates out menu for client groups
  --- @param targetgroup GROUP - Our client target group
  --- @param _client CLIENT - Moose CLIENT for the player
function C_CAS:CreateMenu(targetgroup,_client)
    local group = _client:GetGroup()
    local gid = group:GetID()
    if group and gid then
      if not self.menuadded[gid] then
        self.menuadded[gid] = true
        local _rootPath = missionCommands.addSubMenuForGroup(gid,"" .. self.name .. " Mission Requests")
        local _lightspawn = missionCommands.addCommandForGroup(gid,"Light Cas",_rootPath,self.spawncas,self,_client,"l")
        local _mediumspawn = missionCommands.addCommandForGroup(gid,"Medium Cas",_rootPath,self.spawncas,self,_client,"m")
        local _heavyspawn = missionCOmmands.addCommandForGroup(gid,"Heavy SPawn",_rootPath,self.spawncas,self,_client,"h")
      end
    end
end

function C_CAS:Start()
    BASE:E(self.name,"Heartbeat should be starting with a beat time of ",self.beattime)
    if self.scheduler == nil then
      self.scheduler , self.schedulerid = SCHEDULER:New(nil,function() self:heartbeat() end,{},0,self.beattime)
    else
      self.scheduler:Start()
    end
    return self
end

function C_CAS:Stop()
    BASE:E(self.name,"Heartbeat should be stopping")
    if self.scheduler ~= nil then
      self.scheduler:Stop()
    else
      BASE:E({self.name,"Unable to stop as we don't have a scheduler to stop! Are we started?"})  
    end
    return self
end

function C_CAS:heartbeat()
    -- Logging information
    if self.debug == true then
      self:E({self.name,"Heart Beat"})
    end
    -- Run our menu commands.
    self:MenuCreator()
    -- run our convoy checker
    self:CheckSpawns()
    if self.debug == true then
      self:E({self.name,"Heart Beat Complete"})
    end
end

function C_CAS:spawncas(_client,_size)

    local cid = _client.ObjectName
    local temptable = {}
    if self.spawned == false then
        temptable.client = _client
        temptable.clientcoordinate = _client:GetCoordinate()
        temptable.clientcoordinateVec = _client:GetPointVec2()
        temptable.spawnlocation = nil
        local breakout = 0
        local validcoord = false
        repeat 
            breakout = breakout + 1
            temptable.spawnlocation = temptable.clientcoordinate:GetRandomCoordinateInRadius(self.maxrange,self.minrange)
        until (land.getSurfaceType(temptable.spawnlocation) == land.SurfaceType.LAND) or (breakout > 60)
            if breakout > 60 then 
                validcoord = false
            else
                validcoord = true
            end
        if validcoord == false then
            MESSAGE:New("No insurgents were detected within 60nm. Maybe try again when over more land?",10):ToClient(_client)
            return false
        end
        if _size == "l" then


        end
    else
        local _g = GROUP:FindByName(self.groupname)
        local _mgrs = _g:GetCoordinate()
        _mgrs = _mgrs:G
        local _msg = 
    end
end

function C_CAS:createredfor(unitSpawnPoint,_type,_groupSize,_spread,_m,_spawninf,countryid)
    BASE:E({"Debug-Createredfor",unitSpawnPoint,_type,_groupSize,_spread,_m})
    local _countryid = countryid or self.redcountry
    local spread = _spread or 150
    local groupSize = _groupSize or 16
    local minspread = 30
    local spawninf = _spawninf or self.autospawninf
    BASE:E({"createredfor: Spawning New Group"})
    local unitType
    local _coord = unitSpawnPoint
    local unitPosition = _coord
    local _mark = _m or self.usemarks
    BASE:E({"Debug-Createredfor1",_countryid,spread,groupSize,_mark})
    if land.getSurfaceType(unitSpawnPoint) ~= land.SurfaceType.LAND then
        BASE:E({"createredfor error: Land Value was not a valid spawn type"})
        return nil
    end
    local units = {}
    local i = 1
    if spread < (groupSize * 3) then
        spread = groupSize * 3
    end
    if minspread < (groupSize /2 ) then
        minspread = groupSize /2
    end
    BASE:E({"MAIN GROUP"})
    for i = 1, groupSize do --Insert a random number (min 1, max 5)of random (selection 14 possible) vehicles into table units{}
        unitType = self:randomredunit(_type,self.redtemplates)
        BASE:E({{"Debug:",type,i,groupSize}})
        y = 1
        repeat --Place every unit within a 150m radius circle from the spot previously randomly chosen
            unitPosition = _coord:GetRandomCoordinateInRadius(spread,minspread)
            y = y + 1
            if y == 60 then
                BASE:E({"We hit 60... we shouldn't do this, setting unitposition to coord"})
                unitPosition = _coord
            end
        until (land.getSurfaceType(unitPosition) == land.SurfaceType.LAND) or (y > 60)
        table.insert(units,
            {
                ["x"] = unitPosition.x,
                ["y"] = unitPosition.z,
                ["type"] = unitType,
                ["name"] = self.redprefix .. '_' .. RedSpawn..'_' .. i,
                ["heading"] = math.random(0,359),
                ["skill"] = "Random",
                ["playerCanDrive"]=true,  --hardcoded but easily changed.  
        })            
    end
    if spawninf == true then
        BASE:E({"INF GROUP"})
        local manpad = 0
        local infantryGroupSize = math.random(0,groupSize)
        local passinf = infantryGroupSize
        for i = 1, infantryGroupSize do --Insert three times as many infantry soldiers as there are vehicles in the group into the table units{}
            local randomNumber = math.random(10)
            
            unitType = self:randomredunit("inf",self.redtemplates)

            repeat --Place every unit within a 100m radius circle from the spot previously randomly chosen
                unitPosition = _coord:GetRandomCoordinateInRadius(spread,minspread)
            until land.getSurfaceType(unitPosition) == land.SurfaceType.LAND
            table.insert(units,
        {
                ["x"] = unitPosition.x,
                ["y"] = unitPosition.z,
                ["type"] = unitType,
                ["name"] = self.redprefix .. '_' .. RedSpawn .. '_i_' .. i,
                ["heading"] = math.random(0,359),
                ["skill"] = "Random",
                ["playerCanDrive"]=true,
                ["transportable"]= {["randomTransportable"] = true,}, 
            })
        end
    end
    BASE:E({"SPAWNGROUP units should be",units})
    local grouppoint = _coord:GetVec2()
    local groupData = 
    {
        ["visible"] = true,
        ["tasks"] = {}, -- end of ["tasks"]
        ["uncontrollable"] = false,
        ["task"] = "Ground Nothing",
        ["route"] = {},
        ["hidden"] = false,
        ["units"] = units,
        ["y"] = grouppoint.z,
        ["x"] = grouppoint.x,
        ["name"] = 'Insurgent_Group#' .. RedSpawn,
    }
    BASE:E({"Should be making a new Insurgent Group called ",'Insurgent_Group#' .. RedSpawn,})
    BASE:E({"Scheduled Spawn of group now happening.... "})
    coalition.addGroup(_countryid,Unit.Category['GROUND_UNIT'],groupData) 
    local _offsetcoord = _coord:GetRandomCoordinateInRadius(2000,100)
    if _mark == false then
        MESSAGE:New(string.format("Intel is reporting sightings of insurgents near %s , investigate with caution",_offsetcoord:ToStringMGRS()),30,"INTEL"):ToBlue()
    else
        local newmark = _offsetcoord:MarkToAll("Intelligence Reports insurgent group near this location",false)
        MESSAGE:New(string.format("Intel is reporting sightings of insurgents near %s , investigate with caution",_offsetcoord:ToStringMGRS()),30,"INTEL"):ToBlue()
    end

    local tempgroup = GROUP:FindByName(groupData.name)
    RedSpawn = RedSpawn + 1
    return tempgroup
end

function C_CAS:randomblueunit(tablevalue)
    local unitType
    local fulltable = {}
    local mechtable = {}
    local marinetable = {}
    local armortable = {}
    local infantrytable = {}
    if tablevalue == "full" then
        unitType = fulltable[math.random(#fulltable)]
    elseif tablevalue == "mech" then
        unitType = mechtable[math.random(#mechtable)]
    elseif tablevalue == "marine" then
        unitType = marinetable[math.random(#lightmechtable)]
    elseif tablevalue == "armor" then
        unitType = armortable[math.random(#armortable)]
    else
        unitType = infantrytable[math.random(#infantrytable)]
    end
    return unitType
end

function C_CAS:randomredunit(tablevalue,lookup)
    local unitType = nil  
    if tablevalue == "full" then
        local fulltable = lookup.fulltable
        unitType = fulltable[math.random(#fulltable)]
    elseif tablevalue == "mech" then
        local mechtable = lookup.mech
        unitType = mechtable[math.random(#mechtable)]
    elseif tablevalue == "lightmech" then
        local lightmechtable = lookup.lightmechtable
        unitType = lightmechtable[math.random(#lightmechtable)]
    elseif tablevalue == "armor" then
        local armortable = lookup.armortable
        unitType = armortable[math.random(#armortable)]
    else
        local infantrytable = lookup.infantrytable
        unitType = infantrytable[math.random(#infantrytable)]
    end
    BASE:E({"randomredunit",unitType})
    return unitType
end

function C_CAS:randomtype()
    local _r math.random(1,10)
    if _r == 1 then
        return "full"
    elseif _r == 2 then
        return "mech"
    elseif _r == 3 then
        return "lightmech"
    elseif _r == 4 then
        return "armour"
    else
        return "inf"
    end
end