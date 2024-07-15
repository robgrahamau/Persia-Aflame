--[[
Here is a simple example to use with lotatcMissionServer
]]--

env.info("initializing My LotAtc Link example...")
local LCallbacks = {}
--------------------------------------------------------------
-- LotAtc Link mission script example file
-- Copyright RBorn Software
-- Author: DArt - LotAtc
-- You can modify and adapt it
--------------------------------------------------------------
LCallbacks.command_status = function(env, msg)
    env.info("LotAtcLink: have version ".. msg.version)
    local _s = string.format("trigger.action.outText('LotAtcLink is connected with LotAtc %s', 10 )", msg.version)
    local f, error_msg = loadstring(_s, "LotAtcLink")
    if f then
        setfenv(f, lotatcLink.mission_env)
        local success, result = pcall(f)
        if success then 
            env.info("LotAtcLink: success")
        else
            env.info("LotAtcLink: failed")
            env.info( error_msg )
            env.info( result )
        end
    end
end
--------------------------------------------------------------
LCallbacks.command_order_props = function(env, order)
    if order then
        env.info("LotAtcLink: receive props order")
        env.info("------ Treat props")
        -- lotatcLink.debugTable(order, 0, 3)
        local _group = nil
        if order.group_name then
            env.info("   o " .. order.group_name)
            env.info("   o " .. order.unit_name)
            _group = GROUP:FindByName(order.group_name)
        end
        if _group and (_group:GetPlayerCount() == 0) then
            loe_order(env, order, _group)
        end
    end
end
--------------------------------------------------------------
LCallbacks.command_order_delete = function(env, order)
    if order then
        env.info("LotAtcLink: receive delete order")
        env.info("------ Treat delete")
        -- lotatcLink.debugTable(order, 0, 3)
        local _group = nil
        if order.group_name then
            env.info("   o " .. order.group_name)
            env.info("   o " .. order.unit_name)
            _group = GROUP:FindByName(order.group_name)
        end
        if _group and (_group:GetPlayerCount() == 0) then
            env.info( "Found!" )
            env.info("   o delete")
            _group:Destroy(true)
        end
    end
end
--------------------------------------------------------------
LCallbacks.command_order_command = function(env, order)
    if order then
        env.info("LotAtcLink: receive command order")
        env.info("------ Treat command")
        -- lotatcLink.debugTable(order, 0, 3)
        local _group = nil
        if order.group_name then
            env.info("   o " .. order.group_name)
            env.info("   o " .. order.unit_name)
            _group = GROUP:FindByName(order.group_name)
        end
        if _group and (_group:GetPlayerCount() == 0) then
            loe_command(env, order, _group)
        end
    end
end


--------------------------------------------------------------
loe_order = function(env, order, _group)
    env.info("   o " .. order.property )
    
    if order.property == "headingDeg" then
        loe_order_headingDeg(env, order, _group)
    elseif order.property == "altitude" then
        loe_order_altitude(env, order, _group)
    elseif order.property == "position" then
        loe_order_position(env, order, _group)
    elseif order.property == "groundSpeed" then
        loe_order_groundSpeed(env, order, _group)
    else
        env.info("-- Not yet supported --")
    end
end

--------------------------------------------------------------
loe_order_headingDeg = function( env, order, _group )
    env.info( "change heading to " .. order.value )
    local FromCoord = _group:GetCoordinate()
    local h = _group:GetHeading()
    local gs = _group:GetVelocityKMH()
    -- Use  a  first point for better turn
    FromCoord = FromCoord:Translate( gs/3600.*15, h )
    local ToCoord = FromCoord:Translate( gs*2*1000, tonumber(order.value) )
    
    local RoutePoints = {}
    if _group:IsAir() then
        RoutePoints[#RoutePoints+1] = FromCoord:WaypointAirFlyOverPoint( "BARO", gs)
        RoutePoints[#RoutePoints+1] = ToCoord:WaypointAirFlyOverPoint( "BARO", gs)
        local RouteTask = _group:TaskRoute( RoutePoints )
        _group:SetTask(RouteTask, 1 )
    else
        RoutePoints[#RoutePoints+1] = FromCoord:WaypointGround(gs)
        RoutePoints[#RoutePoints+1] = ToCoord:WaypointGround(gs)
        _group:Route( RoutePoints, 1 )
    end
end

--------------------------------------------------------------
loe_order_altitude = function( env, order, _group )
    if _group:IsAir() then
        env.info( "change altitude to " .. order.value )
        local alt = tonumber(order.value)
        local h = _group:GetHeading()
        local FromCoord = _group:GetCoordinate()

        -- Use midpoint for better transition
        FromCoord = FromCoord:Translate( 500, h )
        local MidCoord = FromCoord:Translate( 5000, h )
        local ToCoord = FromCoord:Translate( 1000000, h )
        
        -- Ensure new altitude
        FromCoord:SetAltitude(alt, true)
        MidCoord:SetAltitude(alt, true)
        ToCoord:SetAltitude(alt, true)

        local RoutePoints = {}
        RoutePoints[#RoutePoints+1] = FromCoord:WaypointAirFlyOverPoint( "BARO", _group:GetVelocityKMH())
        RoutePoints[#RoutePoints+1] = MidCoord:WaypointAirFlyOverPoint( "BARO", _group:GetVelocityKMH())
        RoutePoints[#RoutePoints+1] = ToCoord:WaypointAirFlyOverPoint( "BARO", _group:GetVelocityKMH())
        local RouteTask = _group:TaskRoute( RoutePoints )
        _group:SetTask(RouteTask, 1 )
    end
end

--------------------------------------------------------------
loe_order_groundSpeed = function( env, order, _group )
    env.info( "change groundspeed to " .. order.value )
    local FromCoord = _group:GetCoordinate()
    local n_gs = tonumber(order.value)
    local h = _group:GetHeading()
    
    env.info( "move it from " .. n_gs*2 )
    -- Use midpoint for better transition
    local ToCoord = FromCoord:Translate( n_gs*2*1000, h )
    
    local RoutePoints = {}
    if _group:IsAir() then
        RoutePoints[#RoutePoints+1] = FromCoord:WaypointAirFlyOverPoint( "BARO", n_gs)
        RoutePoints[#RoutePoints+1] = ToCoord:WaypointAirFlyOverPoint( "BARO", n_gs)
        local RouteTask = _group:TaskRoute( RoutePoints )
        _group:SetTask(RouteTask, 1 )
    else
        RoutePoints[#RoutePoints+1] = FromCoord:WaypointGround( n_gs)
        RoutePoints[#RoutePoints+1] = ToCoord:WaypointGround( n_gs)
        _group:Route( RoutePoints, 1 )
    end
end

--------------------------------------------------------------
loe_order_position = function( env, order, _group )
    env.info( "   --> change position " .. order.coord.latitude .. " " .. order.coord.longitude )
    local FromCoord = _group:GetCoordinate()
    -- env.info( FromCoord )
    local _pos = COORDINATE:NewFromLLDD(order.coord.latitude, order.coord.longitude)--, FromCoord:GetPointVec2():GetAlt())
    local _name = _group.GroupName
    _group:Destroy(true)
    _newgroup = SPAWN:New(_name):SpawnFromVec3(_pos:GetVec3())
    env.info( "   --> change position ok" )
end

--------------------------------------------------------------
loe_command = function(env, order, _group)
    env.info("   o " .. order.property )
    
    if order.property == "rtb" then
        loe_command_rtb(env, order, _group)
    elseif order.property == "cap" then
        loe_command_cap(env, order, _group)
    elseif order.property == "orbit" then
        loe_command_orbit(env, order, _group)
    elseif order.property == "hold" then
        loe_command_hold(env, order, _group)
    else
        env.info("-- Not yet supported --")
    end
end

--------------------------------------------------------------
loe_command_rtb = function( env, order, _group )
    env.info( "RTB on" .. order.value )
    local _airbase = AIRBASE:FindByName(order.value)
    if _airbase then
        FromCoord = _group:GetCoordinate()
        
        local AirbasePointVec2 = _airbase:GetPointVec2()
        local AirbaseAirPoint = AirbasePointVec2:WaypointAir(
          POINT_VEC3.RoutePointAltType.BARO,
          "Land",
          "Landing", 
          _group:GetUnit(1):GetDesc().speedMax
        )
        
        AirbaseAirPoint["airdromeId"] = _airbase:GetID()
        AirbaseAirPoint["speed_locked"] = true

        RoutePoints = {}
        RoutePoints[#RoutePoints+1] = FromCoord:WaypointAirFlyOverPoint( "BARO", _group:GetVelocityKMH())
        RoutePoints[#RoutePoints+1] = AirbaseAirPoint
        RouteTask = _group:TaskRoute( RoutePoints )
        _group:SetTask(RouteTask, 1 )
    end
end

--------------------------------------------------------------
loe_command_cap = function( env, order, _group )
    env.info( "CAP on")
    ZoneA = ZONE_RADIUS:New( "Zone A".. _group.GroupName, _group:GetVec2(), 30000 )
    AICapZone = AI_CAP_ZONE:New( ZoneA, 500, 1000, 500, 600 )
    AICapZone:SetControllable( _group )
    AICapZone:SetEngageZone( ZoneA ) -- Set the Engage Zone. The AI will only engage when the bogeys are within the CapEngageZone.

    AICapZone:__Start( 1 ) -- They should statup, and start patrolling in the PatrolZone.
end

--------------------------------------------------------------
loe_command_orbit = function( env, order, _group )
    env.info( "Orbit here")
    local FromCoord = _group:GetCoordinate()
    local gs = _group:GetVelocityMPS()
    local h = _group:GetHeading()
    local alt = _group:GetUnit(1):GetAltitude()
    
    -- Use midpoint for better transition
    local ToCoord = FromCoord:Translate( gs*30, h )
    ToCoord:SetAltitude(alt)
    
    local Task = _group:TaskOrbitCircle( alt, gs, ToCoord )
    _group:SetTask(Task)
end

--------------------------------------------------------------
loe_command_hold = function( env, order, _group )
    env.info( "Hold here")
    local Task = {}
    if _group:IsAir() then
        Task = _group:TaskHoldPosition()
    else
        Task = _group:TaskHold()
    end
    _group:SetTask(Task)
end
--------------------------------------------------------------
lotatcLink.registerCallbacks( LCallbacks )
env.info("My LotAtc Link initialized")
