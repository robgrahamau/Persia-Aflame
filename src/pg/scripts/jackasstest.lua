-- Curt of Hoggit repo.


badAmmoStrings = {
 ['RN-24'] = true,
 ['weapons.bombs.RN-24'] = true,
 ['RN-28'] = true,
 ['weapons.bombs.RN-28'] = true,

}

if jackass == true then
 function checkForJackass()
    for ind, data in pairs(mist.DBs.humansById) do
        if Unit.getByName(data.unitName) then
            local pObj = Unit.getByName(data.unitName)
            if pObj:getLife() and pObj:getLife() > 0 and pObj:inAir() == false then
                local ammo = pObj:getAmmo()
                local nukes = 0
                if ammo and #ammo > 0 then
                    for i = 1, #ammo do
                        local a = ammo[i]
                        if a and a.desc and (badAmmoStrings[a.desc.displayName] or badAmmoStrings[a.desc.typeName]) then
                            nukes = nukes + a.count
                        end
                    end
                
                end
                if nukes > 0 and  slmod and slmod.missionAdminAction then
                    slmod.missionAdminAction(data.unitId, 'kick')
					MESSAGE:New("Oh Look " .. pObj:getPlayerName() .. " in a MIG-21 was being a Jackass, NO NUKES",30):ToAll()
					hm("Oh Look " .. pObj:getPlayerName() .. " in a MIG-21 was being a Jackass, NO NUKES")
                end
				
            end
        
        end
    
    end


end
mist.scheduleFunction(checkForJackass, {}, timer.getTime() + 30, 30)
end