BASE:E({"Loading Sleep Cycle"})
SLEEPCYCLE = (30*60) -- Every 30 minutes run the cycle.
AAASLEEP = 70
MPADSLEEP = 60
SHORADSLEEP = 90
MEDRADSLEEP = 95
aaaunitsasleep = {}
mpadshavingadump = {}
shoradsasleep = {}
medradsmoko = {}

function wakeupunits(_table)
	BASE:E({"Wake Units"})
    for k,_group in pairs(_table) do
		BASE:E({_group:GetName(),"Is Now awake"})
        _group:OptionAlarmStateAuto()
    end
end

function containsgroup(_table,_lgroup)
    for k,_group in pairs(_table) do
        if _group == _lgroup then
            return true
        end
    end
    return false
end

function cycleroe()
	BASE:E({"We are scanning our units"})
    -- wake up any units asleep
    wakeupunits(aaaunitsasleep)
    wakeupunits(mpadshavingadump)
    wakeupunits(shoradsasleep)
    wakeupunits(medradsmoko)
    local _aaa = {}
    local _mpads = {}
    local _shorad = {}
    local _medrad = {}

    local rgunits = rbg:FilterCategoryGround():FilterOnce()
    rgunits:ForEachGroupAlive(function(_group)
        local _rand = math.random(1,100)
        local _gattributes = _group:GetAttribute()
        local _gthreat = _group:GetThreatLevel()
        local _gunits = _group:GetUnits()
        if _gthreat == 6 then
            -- check if the group is already in the list
            if containsgroup(aaaunitsasleep,_group) == false then
                if _rand > AAASLEEP then
                    _group:OptionAlarmStateGreen()
                    table.insert(_aaa,_group)
                    BASE:E({"AAA unit now asleep",_group:GetName()})
                end
            end
        elseif _gthreat == 7 then
            if containsgroup(mpadshavingadump,_group) == false then
                if _rand > MPADSLEEP then
                    _group:OptionAlarmStateGreen()
                    BASE:E({"MPAD unit now asleep",_group:GetName()})
                    table.insert(_mpads,_group)
                end
            end
        elseif _gthreat == 8 then
            if containsgroup(shoradsasleep,_group) == false then
                if _rand > SHORADSLEEP then
                    _group:OptionAlarmStateGreen()
                    BASE:E({"SHORAD unit now asleep",_group:GetName()})
                    table.insert(_shorad,_group)
                end
            end
        elseif _gthreat == 9 then
            if containsgroup(medradsmoko,_group) == false then
                if _rand > MEDRADSLEEP then
                    _group:OptionAlarmStateGreen()
                    BASE:E({"MEDRAD unit now asleep",_group:GetName()})
                    table.insert(_medrad,_group)
                end
            end
        end
    end)
	BASE:E({"Copying Tables"})
    aaaunitsasleep = _aaa
    mpadshavingadump = _mpads
    shoradsasleep = _shorad
    medradsmoko = _medrad
	BASE:E({"Sleep Cycle Completed"})
end

SCHEDULER:New(nil,function() cycleroe()  end,{},31,SLEEPCYCLE)