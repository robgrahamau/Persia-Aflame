--[[
Here is a simple example to use with lotatcMissionServer
]]--

env.info("initializing My LotAtc Link example...")
local LCallbacks = {}
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
-----------------------------------------
LCallbacks.command_order = function(env, msg)
    if msg.orders then
        env.info("LotAtcLink: receive order")
        for i, order in pairs(msg.orders) do
            env.info("------ Treat order")
            env.info("   o" .. order.order_name )
            local _group = nil
            if order.group_name then
                env.info("   o" .. order.group_name )
                env.info("   o" .. order.unit_name )
                _group = GROUP:FindByName( order.group_name )
            end
            if _group then
                --env.info( "Found!" )
                if order.order_name == "object" then
                    loe_order(env,order, _group )
                elseif order.order_name == "delete" then
                    env.info("   o delete")
                    _group:Destroy(true)
                end
            end
        end
    end
end

-----------------------------------------
loe_order = function(env, order, _group)
    env.info("   o" .. order.property )
    env.info("   o" .. order.value )
    -- Altitude
    if order.property == "headingDeg" then
        loe_order_headingDeg(env, order, _group)
    elseif order.property == "altitude" then
        loe_order_altitude(env, order, _group)
    end
end

loe_order_headingDeg = function( env, order, _group )
    env.info( "change heading to " .. order.value )
    FromCoord = _group:GetCoordinate()
    ToCoord = FromCoord:Translate( 1000000, tonumber(order.value) )
    RoutePoints = {}
    RoutePoints[#RoutePoints+1] = FromCoord:WaypointAirFlyOverPoint( "BARO", _group:GetVelocityKMH())
    RoutePoints[#RoutePoints+1] = ToCoord:WaypointAirFlyOverPoint( "BARO", _group:GetVelocityKMH())
    RouteTask = _group:TaskRoute( RoutePoints )
    _group:SetTask(RouteTask, 1 )
end

loe_order_altitude = function( env, order, _group )
    env.info( "change altitude to " .. order.value )
    Route = _group:CopyRoute()
    for i, w in pairs(Route) do
        w.alt = tonumber(order.value)
    end
    _group:Route(Route)
end
-----------------------------------------
lotatcLink.registerCallbacks( LCallbacks )
-----------------------------------------
env.info("My LotAtc Link initialized")
