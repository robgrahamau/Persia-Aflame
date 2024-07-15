PLAYERMAP = {}
PLAYERMAPLASTSEND = {}
PLAYERSEND = {}
FIRSTCLIENTRUN = true
CLIENTS = SET_CLIENT:New():FilterStart()

mission = "Training Server"



local function permanentPlayerCheck()
    
    CLIENTS:ForEachClient(function(_CLIENT) 
        local PlayerID = _CLIENT.ObjectName
        local Coalition = _CLIENT:GetCoalition()
        local col = "Red"
        local PlayerName = _CLIENT:GetPlayerName()
        if FIRSTCLIENTRUN == true then
            PLAYERMAP[PlayerID] = false
        end
        if _CLIENT:IsAlive() then
            if PLAYERMAP[PlayerID] ~= true or PLAYERMAP[PlayerID] == nil then
                PLAYERMAP[PlayerID] = true
                PLAYERMAPLASTSEND[PlayerID] = timer.getTime() 
                local MessageText = string.format("Welcome to the Task Group Warrior Training Server, %s please remember that blue on blue is not allowed \n this server is supplied by the TGW Core Members using it is a privillage not a right, Your expected to Communicate on SRS on the Correct Freq or USE TEXT please refer to the mission Briefing ALT+B for more information. \n Remember that we are on discord:  https://discord.gg/F6amrC4PkA \n AI ATC For Kobuleti, Senaki and Kutusi are Muted.",PlayerName)
                MESSAGE:New(MessageText,30):ToClient(_CLIENT)
            end
        else
            if PLAYERMAP[PlayerID] ~= false then
                local _time = timer.getTime()
                if _time - PLAYERMAPLASTSEND[PlayerID] > 600 then
                    PLAYERMAP[PlayerID] = false
                end
            end
        end
    end)

    FIRSTCLIENTRUN = false
end

SCHEDULER:New(nil,permanentPlayerCheck,{},1,1)