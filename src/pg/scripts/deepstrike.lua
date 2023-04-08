DEEPSTRIKE = {
    ClassName = "DeepStrike",
    Name = "",
    Zone = nil,
    Targets = {},
    GroundDefence = {},
    AirDefence = {},
    SpawnedGroups = {},
    GSpawnchance = 75,
    ASpawnchance = 100,
    activated = false,
    left = false,
    activatedtime = 120,
    deactivattime = 0,
    Timer = nil,
    Completed = false,
    coalition = "blue",
    setgroup = nil,
    started = false,
    marker = nil,
    mid = nil,
    coordinate = nil,
    msg = "",
    sendmsg = true,
    randomizeunits = false,
    minu = 50,
    maxu = 1000,
    randomizegroups = false,
    ming = 50,
    maxg = 1000,
    targetsalive = nil,
    debug = false,
}
---Creates our Deepstrike object
---@param _Name string - The name of our deepstrike target1
---@param _Zone string - the name of the trigger zone for the deepstrike target
---@param _coalition string - red or blue which side will trigger this target.
---@return table|self
function DEEPSTRIKE:New(_Name,_Zone,_coalition)
    local self = BASE:Inherit(self,BASE:New())
    self.Name = _Name
    self.Zone = ZONE:FindByName(_Zone)
    self.coalition = _coalition or "blue"
    return self
end


---Sets if ground spawned units should be randomized 
---@param _value boolean - randomize true/false
---@param _min integer minimum radius
---@param _max integer maximum radius
---@return table self
function DEEPSTRIKE:SetRandomizeUnits(_value,_min,_max)
    self.randomizeunits = _value or false
    self.minu = _min or 50
    self.maxu = _max or 1000
    return self
end

---Sets if ground spawned units should be randomized 
---@param _value boolean - randomize true/false
---@param _min integer minimum radius
---@param _max integer maximum radius
---@return table self
function DEEPSTRIKE:SetRandomizeGroup(_value,_min,_max)
    self.randomizegroups = _value or false
    self.ming = _min or 50
    self.maxg = _max or 1000
    return self
end

---Lets us set the msg that will be triggered when the deepstrike is activated
---@param _send boolean true/false do we send the msg?
---@param _msg string the message we are going to send.
function DEEPSTRIKE:SetMsg(_send,_msg)
    self.sendmsg = _send or false
    self.msg = _msg or ""
end

---takes a table of statics and puts them as our target list. Be warned this overwrites all our statics.
---@param _targets table a table of moose objects.
function DEEPSTRIKE:AddTargets(_targets)
    self.Targets = _targets
end

---Adds an individual target to the table by string.
---@param _target string the static name as per ME.
function DEEPSTRIKE:AddTargetStatic(_target)
    local tgstatic = STATIC:FindByName(_target)
    if tgstatic:IsAlive() == true then
        if self.coordinate == nil then
            self.coordinate = tgstatic:GetCoordinate()
        end
        table.insert(self.Targets,tgstatic)
    end
end

---Removes a target from the target list.
---@param _target string the static name as per me
function DEEPSTRIKE:RemoveTargetStatic(_target)
    local ttable = {}
    local found = false
    local tgstatic = STATIC:FindByName(_target)
    for k,st in pairs(self.Targets) do
        if st ~= tgstatic then
            table.insert(ttable,tgstatic)
        else
            rlog("found target static")
            found = true
        end
    end
    if found == true then
        -- update our list.
        tgstatic = ttable
    else
        rlog("No Target found in the list")
    end
end

---Add a Ground Defense Group
---@param _dgroup string The name of the group as in the editor
function DEEPSTRIKE:AddGDefenceGroup(_dgroup)
    table.insert(self.GroundDefence,_dgroup)
end

function DEEPSTRIKE:AddGDefenseGroupByPrefix(_prefix,side)
    local _ts = SET_GROUP:New():FilterCategories({"ground"}):FilterPrefixes(_prefix):FilterCoalitions(_side):FilterOnce()
    _ts:ForEachGroup(function(fgroup) 
        local tempname = fgroup:GetName()
        table.insert(self.GroundDefence,tempname)
    end)
end

---Adds an entire table of ground defense groups
---@param _dgroup table a table of group names 
function DEEPSTRIKE:AddGDefenceGroupTable(_dgroup)
    self.GroundDefence = _dgroup
end

---Add air Defense Group
---@param _dgroup string The name of the group as in the editor
function DEEPSTRIKE:AddAirDefenceGroup(_dgroup)
    table.insert(self.AirDefence,_dgroup)
end

---Add air Defense Group by table
---@param _dgroup table a table of group names 
function DEEPSTRIKE:AddAirDefenceGroupTable(_dgroup)
    self.AirDefence = _dgroup
end

---Sets our ground spawn chance
---@param _chance integer 1-100 defaults to 75 if not supplied.
function DEEPSTRIKE:SetGSpawnChance(_chance)
    self.GSpawnchance = _chance or 75
end

---sets our air spawn chance
---@param _chance integer 1-100 defaults to 100 if not supplied.
function DEEPSTRIKE:SetASpawnChance(_chance)
    self.ASpawnchance = _chance or 100
end

---Starts our scheduler
---@return table self
function DEEPSTRIKE:Start()
    if self.started == true then
        self:Stop()
    end

    rlog(string.format("Starting Monitor for Deep Strike %s",self.Name))
    self.Timer = SCHEDULER:New(nil,function() self:HeartBeat() end,{},30,30)
    self.started = true
    return self
end

---Checks the zone and returns if the coalition is inside it
---@return boolean
function DEEPSTRIKE:CheckZone()
    local _c = 2
    if self.coalition:lower() == "red" then
        _c = 1
    end
    self:Debug({"Check Zone",self.coalition:lower(),_c})
    self.Zone:Scan({Object.Category.Unit},{Unit.Category.AIRPLANE,Unit.Category.HELICOPTER})
    local isattacked = self.Zone:IsSomeInZoneOfCoalition(_c)
    self:Debug({"Check Zone isattacked",isattacked})
    return isattacked
end

function DEEPSTRIKE:Debug(_msg)
    if self.debug == true then
        local _sender = string.format("Deepstrike Debug for %s:",self.Name)
        rlog({sender,_msg})
    end
end
---Checks our target list and depending on what is going on marks them as alive or not if its the first time that this has run
---it will also set up markers.
function DEEPSTRIKE:CheckTargets()
    self:Debug({"checking targets"})
    local targetsalive = false
    local targetcount = 0
    for k,v in pairs(self.Targets) do
        self:Debug({"static alive check",v:GetName(),v:IsAlive()})
        if v:IsAlive() then
            targetsalive = true
            targetcount = targetcount + 1
        end
    end
    self:Debug({"static targetcount",targetsalive,targetcount})
    if targetsalive == true then
        if self.marker == nil then
            self.targetsalive = targetcount
            self.marker = "alive"
            local _msg = string.format("Deep Strike Target: %s total targets %d Status:Alive",self.Name,targetcount)
            self.mid = self.coordinate:MarkToAll(_msg,true)
            self:Debug({"deepstrike marker has been placed, marker id is:",self.mid,self.marker})
        elseif (self.marker == "alive") and (self.targetsalive ~= targetcount) then
            self.coordinate:RemoveMark(self.mid)
            local _msg = string.format("Deep Strike Target: %s total targets %d Status:Alive",self.Name,targetcount)
            self.mid = self.coordinate:MarkToAll(_msg,true)
            self:Debug({"deepstrike marker has been updated, marker id is:",self.mid,self.marker})
        else
            self:Debug({"Everythings alive and nothings changed",self.marker,self.mid})
        end
    else
        if self.Completed ~= true then
            self.Completed = true
       
            if self.marker ~= nil then
                if self.marker == "Alive" then
                    self.coordinate:RemoveMark(self.mid)
                    self:Debug({"deepstrike marker has been removed, marker id is:",self.mid,self.marker})
                    self.mid = self.coordinate:MarkToAll("Target Destroyed",true)
                    self:Debug({"deepstrike marker has been created, marker id is:",self.mid,self.marker})
                    self.marker = "Dead"
                    self:Debug({"deepstrike marker has been set to Dead, marker is:",self.marker,})
                end
            end
        end
    end
end

---GetSkill just returns a randomized skill0
---@return string
function DEEPSTRIKE:GetSkill()
    local t = math.random(1,5)
    if t == 1 then
        return "Average"
    elseif t == 2 then
        return "Good"
    elseif t == 3 then 
        return "High" 
    elseif t == 4 then
        return "Excellent"
    else
        return "Random"
    end
end

---Spawns our groups by chance
function DEEPSTRIKE:SpawnAllGroup()
    self:Debug({"Spawn Groups"})
    self:Debug({"Ground Groups"})
    for k,g in pairs(self.GroundDefence) do 
        local chance = math.random(1,100)
        if g:lower():find("#always") then
            chance = 100
        end
        self:Debug({"Chance",chance,self.GSpawnchance})
        if chance <= self.GSpawnchance then
            local _ru = false
            local _rg = false
            -- look at our unit name to see if there allowed to be randomized or not.
            if self.randomizegroups == true then
                if g:lower():find("#dsrndg") == true then
                    _rg = true
                end
                if g:lower():find("#dsrndgu") == true then
                    _rg = true
                end
            end
            if self.randomizeunits == true then
                if g:lower():find("#dsrndu") == true then
                    _ru = true
                end
                if g:lower():find("#dsrndgu") == true then
                    _ru = true
                end
            end
            local _groupname = string.format("%s_%s",self.Name,g)
            self:Debug({"random unit",_ru,"randomgroup",_rg,"groupname",_groupname})
            local spawnedgroup = SPAWN:NewWithAlias(g,_groupname):InitSkill(self:GetSkill()):InitRandomizePosition(_rg, self.maxg, self.ming):InitRandomizeUnits(_ru,self.maxu,self.minu):Spawn()
            table.insert(self.SpawnedGroups,spawnedgroup)
        end
    end
    self:Debug({"Air Groups"})
    for k,g in pairs(self.AirDefence) do
        local chance = math.random(1,100)
        self:Debug({"Chance",chance,self.ASpawnchance})
        if chance <= self.ASpawnchance then
            local _groupname = string.format("%s_%s",self.Name,g)
            local spawnedgroup = SPAWN:NewWithAlias(g,_groupname):InitSkill(self:GetSkill()):Spawn()
            table.insert(self.SpawnedGroups,spawnedgroup)
        end
    end
end

---activates the zone.
function DEEPSTRIKE:Activate()
    self:Debug({"Activate Called"})
    -- we need to spawn our groups in.
    self:SpawnAllGroups()
    self.activated = true
    self.left = false
    if self.sendmsg == true then
        RGUTILS:MessageAll(self.msg,15)
    end
end

---despawns all active groups.
function DEEPSTRIKE:DespawnAll()
    self:Debug({"Despawn Called"})
    for k,v in pairs(self.SpawnedGroups) do
        if v:IsAlive() == true then
            v:Destroy()
        end
    end
    rlog(self.SpawnedGroups)
    self.SpawnedGroups = {} -- clear our spawned group list
end

---deactivates our strike
function DEEPSTRIKE:Deactivate()
    self:Debug({"DeActivate Called"})
    self:DespawnAll()
    self.left = false
    self.activated = false
end

---Our heartbeat, this runs every time the scheudler is called.
function DEEPSTRIKE:HeartBeat()
    self:Debug({"HeartBeat"})
    if self:CheckZone() then
        if self.activated == false then
            if self.Completed == false then
                self:Activate()
            end
        end
    else
        if self.activated == true then
            if self.left == false then
                self.left = true
                self.deactivattime = 0
            else
                if self.deactivattime == self.activatedtime then
                    self:Deactivate()
                else
                    self.deactivattime = self.deactivattime + 1
                end
            end
        end
    end
end

---Stops our deepstrike object's scheduler
---@return table self
function DEEPSTRIKE:Stop()
    self:Debug({"Stop called"})
    if self.started == true then
        self.Timer:Stop()
        self:Deactivate()
    end
    return self
end