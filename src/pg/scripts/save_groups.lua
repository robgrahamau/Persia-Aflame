-- Saves Ground Units from a set and Loads them in.
 GroundUnitSave = {
    ClassName = "Handle_Events",
    version = "1.0",
    SetGroup = nil,
    SaveFile = nil,
    SavePath = nil,
    Scheduler = nil,
 }

 -- Instantiate our Unitsave 
 -- needs a Set Group at the minimum.
function GroundUnitSave:New(_setgroup,_savefile,_savepath)
    local self = BASE:Inherit(self,BASE:New())
    self.SetGroup = _setgroup or nil
    self.SaveFile = _savefile or "Unitsavefile.lua"
    self.SavePath = _savepath or lfs.writedir()
    return self
end

function GroundUnitSave:Start(_time)
    if self.SetGroup == nil then
        rlog("Unable to start Ground Unit Save, no set group")
        return false
    end
    local _time = _time or 600
    self:LoadGroups()
    if self.Scheduler ~= nil then
        self:Stop()
    end
    local _msg = string.format("Starting Ground unit scheduler save in 60 seconds recurring every %d seconds",_time)
    rlog(_msg)
    self.Scheduler = SCHEDULER:New(nil,function() 
        self:Save_Groups()
    end,{},60,_time)
end

function GroundUnitSave:Stop()
    if self.Scheduler == nil then
        rlog("Stopping Ground Unit Save Scheduler")
        self.Scheduler:Stop()
    end
end

function GroundUnitSave:SetGroup(_setgroup)
    self.SetGroup = _setgroup or nil
end

function GroundUnitSave:SetSaveFile(_savefile)
    self.SaveFile = _savefile or "Unitsavefile.lua"
end

function GroundUnitSave:SetSaveFile(_savepath)
    self.SavePath = _savepath or lfs.writedir()
end

function GroundUnitSave:LoadGroups()
    local spawncounter = 0
    local groupsavefile = self.SavePath .. "" .. self.SaveFile
    --SCRIPT START
    rlog({"Load Group Start",groupsavefile,self.SavePath,self.SaveFile})
    if RGUTILS.file_exists(self.SaveFile,self.SavePath) then -- We have an existing file
        rlog("Existing database, loading from File.")
        local destroycounter = 0
        if self.SetGroup == nil then
            rlog("Error No Set Group is Set!")
            return false
        end
        self.SetGroup:ForEachGroup(function (_grp)
            destroycounter = destroycounter + 1
            _grp:Destroy()
        end)
        rlog("Destroyed a total of ".. destroycounter .." Groups")
        -- Load in our file
        _LOADFILE(self.SaveFile,self.SavePath,true,5,1)
        local tempTable={}
        local Spawn={}
        --RUN THROUGH THE KEYS IN THE TABLE (GROUPS)
        for k,v in pairs (SaveUnits) do
            local units={}
            --RUN THROUGH THE UNITS IN EACH GROUP
            for i= 1, #(SaveUnits[k]["units"]) do 
                local _cold = math.random(1,100)
                if _cold > 75 then
                    _cold = true
                else
                    _cold = false
                end
	            spawncounter = spawncounter + 1
                tempTable =
                { 
                    ["type"]=SaveUnits[k]["units"][i]["type"],
                    ["transportable"]= {["randomTransportable"] = false,}, 
                    --["unitId"]=9000,used to generate ID's here but no longer doing that since DCS seems to handle it
                    ["skill"]=SaveUnits[k]["units"][i]["skill"],
                    ["y"]=SaveUnits[k]["units"][i]["y"] ,
                    ["x"]=SaveUnits[k]["units"][i]["x"] ,
                    ["name"]=SaveUnits[k]["units"][i]["name"],
                    ["heading"]=SaveUnits[k]["units"][i]["heading"],
                    ["playerCanDrive"]=true,  --hardcoded but easily changed.  
                    ["coldAtStart"] = _cold -- is the unit cold at start uncomment when 2.8 drops to stable.
                }
                table.insert(units,tempTable)
            end --end unit for loop
            local groupData = 
            {
                ["visible"] = false,
	            ["hiddenOnPlanner"] = true,
	            ["hiddenOnMFD"] = true,
                ["tasks"] = {}, -- end of ["tasks"]
                ["uncontrollable"] = false,
                ["task"] = "Ground Nothing",
                ["hidden"] = false,
                ["units"] = units,
                ["y"] = SaveUnits[k]["y"],
                ["x"] = SaveUnits[k]["x"],
                ["name"] = SaveUnits[k]["name"],
            } 
            coalition.addGroup(SaveUnits[k]["CountryID"], SaveUnits[k]["CategoryID"], groupData)
            -- clear our group data just to be certain though because it's a local it should auto clean.
            groupData = {}
        end --end Group for loop
    else --Save File does not exist we start a fresh table, no spawns needed
        rlog("Unable to find save file")
        SaveUnits={} 
    end
    local _msg = string.format("Group Saving - Spawned a total of %d groups, using file %s",spawncounter,groupsavefile)
    rlog(_msg)
end

function GroundUnitSave:Save_Groups()
    SaveUnits = {} -- empty our table
    if self.SetGroup == nil then
        rlog("Error No Set Group is Set!")
        return false
    end
    self.SetGroup:ForEachGroupAlive(function(_grp)
        local _unittable = {}
        local DCSgroup = Group.getByName(_grp:GetName())
        local size = DCSgroup:getSize()
        local _units = _grp:GetUnits()
        for _key,_un in pairs(_units) do
            local _unit = UNIT:FindByName(_un.UnitName)
            if _unit:IsAlive() == true then
                local skill = "Average"
                local skillr = math.random(1,10)
                if skillr == 5 or skillr == 6 then
                    skill = "Good"
                elseif skillr == 7 or skillr == 8 then
                    skill = "High"
                elseif skillr == 9 or skillr == 10 then
                    skill = "Excellent"
                end
                local _h = UTILS.ToRadian(_unit:GetHeading())
                local tmpTable =
                {   
                    ["type"]=_unit:GetTypeName(),
                    ["transportable"]=true,
                    ["unitID"]=_unit:GetID(),
                    ["skill"]=skill,
                    ["y"]=_unit:GetVec2().y,
                    ["x"]=_unit:GetVec2().x,
                    ["name"]=_unit:GetName(),
                    ["playerCanDrive"]=true,
                    ["heading"]=_h,
                }
                table.insert(_unittable,tmpTable) --add units to a temporary table
            end
        end
        SaveUnits[_grp:GetName()] =
        {
            ["CountryID"]=_grp:GetCountry(),
            ["SpawnCoalitionID"]=_grp:GetCountry(),
            ["tasks"]={}, --grp:GetTaskMission(), --wrong gives the whole thing
            ["CategoryID"]=_grp:GetCategory(),
            ["task"]="Ground Nothing",
            ["route"]={}, -- grp:GetTaskRoute(),
            ["groupId"]=_grp:GetID(),
            --["SpawnCategoryID"]=grp:GetCategory(),
            ["units"]= _unittable,
            ["y"]=_grp:GetVec2().y, 
            ["x"]=_grp:GetVec2().x,
            ["name"]=_grp:GetName(),
            ["start_time"]=0,
            ["CoalitionID"]=_grp:GetCoalition(),
            ["SpawnCountryID"]=_grp:GetCoalition(),
        }
    end)
    local newMissionStr = RGUTILS.IntegratedserializeWithCycles("SaveUnits",SaveUnits) --save the Table as a serialised type with key SaveUnits
    RGUTILS.writefile(newMissionStr,self.SaveFile,self.SavePath)--write the file
    SaveUnits={}--clear the table for a new write.
    rlog("Data saved.")
end

