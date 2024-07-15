BFMClients = SET_CLIENT:New():FilterPrefixes("Pontiac"):FilterActive():FilterStart()
WW2Clients = SET_CLIENT:New():FilterPrefixes("WH"):FilterActive():FilterStart()
notinzoneb = {}
notinzonew = {}
KOB_RED = nil

function CHECKZONE()
    BFMClients:ForEachClientNotInZone(Z_R446,function(_client)  
    local _clientgroup = _client:GetClientGroupName()
    local _clientname = _client:GetPlayerName()
    if notinzoneb[_clientgroup] == nil then
        local msg = string.format("Warning %s you are not in R446, you have 1 minute to return to R446 or you will be destroyed",_clientname)
        MESSAGE:New(msg,20):ToClient(_client)
        notinzoneb[_clientgroup] = "warned"
    else
        local msg = string.format("%s you are not in R446, you were warned to return to R446 learn to follow the rules",_clientname)
        MESSAGE:New(msg,20):ToAll()
        _client:Destroy()
        notinzoneb[_clientgroup] = nil
    end

    end)

    WW2Clients:ForEachClientNotInZone(Z_WISKA,function(_client) 
        local _clientgroup = _client:GetClientGroupName()
        local _clientname = _client:GetPlayerName()
        if notinzonew[_clientgroup] == nil then
            local msg = string.format("Warning %s you are not in the WISKA Training Area, you have 1 minute to return to WISKA or you will be destroyed",_clientname)
            MESSAGE:New(msg,20):ToClient(_client)
            notinzonew[_clientgroup] = "warned"
        else
            local msg = string.format("%s you are not in WISKA while occupying a WW2 Aircraft. \n you were warned to return to WISKA, WW2 Aircraft must remain in Wiska at all times. \n Learn to follow the rules",_clientname)
            MESSAGE:New(msg,10):ToAll()
            _client:Destroy()
            notinzonew[_clientgroup] = nil
        end

    end)
    -- Commented out at the moment as its throwing an error will debug later.
    --[[local REDNEARKOB = Z_KOBDEF:IsSomeInZoneOfCoalition(1)
    if REDNEARKOB == true then
        if KOB_RED == false then
            AI_KOB_DEF_PAT:OptionAlarmStateRed()
            AI_KOB_DEF_PAT:OptionROEOpenFireWeaponFree()
            AI_KOB_DEF_CRAM:OptionAlarmStateRed()
            AI_KOB_DEF_CRAM:OptionROEOpenFireWeaponFree()
            AI_KOB_DEF_NASAM:OptionAlarmStateRed()
            AI_KOB_DEF_NASAM:OptionROEOpenFireWeaponFree()
            KOB_RED = true
            local msg = string.format("Warning a RED Coalition aircraft has Entered within 20nm of Kobuleti, Blue Air Defenses are now active.")
            MESSAGE:New(msg,10):ToAll()
        end
    else
        if KOB_RED == true or KOB_RED == nil then
            AI_KOB_DEF_PAT:OptionAlarmStateGreen()
            AI_KOB_DEF_PAT:OptionROEHoldFire()
            AI_KOB_DEF_CRAM:OptionAlarmStateGreen()
            AI_KOB_DEF_CRAM:OptionROEHoldFire()
            AI_KOB_DEF_NASAM:OptionAlarmStateGreen()
            AI_KOB_DEF_NASAM:OptionROEHoldFire()
            KOB_RED = false
        end
    end
    ]]
end

R446CHECK = SCHEDULER:New(nil,function() 
CHECKZONE()
end,{},60,60)


