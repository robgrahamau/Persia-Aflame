-- Saves Ground Units from a set and Loads them in.
IADSMonitor = {
    ClassName = "IADSMonitor",
    version = "0.05",
    name = "",
    SetGroup = nil,
    addedtoiads = {},
    coalition = "",
    timer = nil,
    iads = nil,
    awacsupdate = 10,
 }
 function IADSMonitor:AddAwacs(_names)

 end
 function IADSMonitor:New(_name,_setgroup,_coalition)
    local self = BASE:Inherit(self,BASE:New())
    if SkynetIADS == nil then
        BASE:E({"Error SkynetIADS not found"})
        return false
    end
    self.SetGroup = _setgroup or nil
    if _name == nil then
        BASE:E({"ERROR NO NAME GIVEN"})
        return nil
    end
    self.name = _name
    self.coalition = _coalition or "red"
    self.iads = SkynetIADS:create(_coalition)
    return self
 end

 function IADSMonitor:Start()
    self:E({"activating IADS"})
    self.iads:activate()
    self.timer = SCHEDULER:New(nil,function() 
        self:UpdateIADSNET()
    end,{},10,60)
 end

 function IADSMonitor:Stop()
    self:E({"Stopping IADS"})
    self.iads:deactivate()
    self.timer:Stop()
 end
 
function IADSMonitor:UpdateIADSNET()
    if self.coalition:lower() == "red" then
        if self.awacsupdate == 10 then
            self.iads:addEarlyWarningRadarsByPrefix('AWACS')
            self.awacsupdate = 0
        end
        self.awacsupdate = self.awacsupdate + 1
    end
    self.SetGroup:FilterOnce()
    self.SetGroup:ForEachGroup(function(_group)
        local _at = _group:GetAttribute()
        local _name = _group:GetName()
        if _at == "Ground_EWR" or _at=="Ground_SAM" then
            if self.addedtoiads[_name] ~= true then
                if _at == "Ground_EWR" then
                    local _units = _group:GetUnits()
                    for k,v in pairs(_units) do
                        local _ew = self.iads:addEarlyWarningRadar(v:GetName())    
                        if _ew ~= nil then
                            self.addedtoiads[_name] = true
                        end
                    end
                elseif _at == "Ground_SAM" then
                    local _sam = self.iads:addSAMSite(_name)
                    self.addedtoiads[_name] = true
                    if _sam ~= nil then
                        if _sam:getNatoName("SA-10") or _sam:getNatoName("SA-2") or _sam:getNatoName("Patriot") or _sam:getNatoName("Hawk") or _sam:GetName("SA-5") then
                            _sam:setActAsEW(true)
                        end
                        _sam:setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DCS_AI)
                        _sam:setCanEngageAirWeapons(true)
                    end
                end
            end
        end
    end)
    self:E({"IADS Network updated"})
 end
