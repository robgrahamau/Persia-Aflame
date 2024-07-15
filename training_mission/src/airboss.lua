airbossCVN = AIRBOSS:New("CVN71", "Rough Rider") -- Carrier
airbossCVN:SetFunkManOn(10042, "127.0.0.1") -- YOUR SERVERBOT PORT / local ip
airbossCVN:SetTACAN(71, "X", "RR")
airbossCVN:SetICLS(1, "LSO")
airbossCVN:SetPatrolAdInfinitum(true)
airbossCVN:SetMPWireCorrection(12) -- mp wire correction
airbossCVN:Start()
function airbossCVN:OnAfterLSOGrade(From, Event, To, playerData, grade)
    local PlayerData = playerData
    local Grade = grade
    local score = tonumber(Grade.points)
    local name = tostring(PlayerData.name)
end