--[[
Add the following to DCS World/Scripts/ScriptingSystem.lua after dofile('Scripts/ScriptingSystem.lua'):
dofile(lfs.writedir().."Mods\services\LotAtc\lua utils\lotatcMissionServer.lua")
]]--

lotatcLink = {}

--do
    env.info("initializing LotAtcLink...")
 local require = require
local loadfile = loadfile

-- Customization
lotatcLink.scheduled = false
lotatcLink.mission_env = {}
lotatcLink.host = "localhost"
lotatcLink.port = 8081
lotatcLink.interval = 1


-- Internals
lotatcLink.scheduled = false
lotatcLink.version = ""
lotatcLink.callbacks = nil
lotatcLink.userFlags = {}

-- Loading
package.path = package.path..";.\\LuaSocket\\?.lua"
package.cpath = package.cpath..";.\\LuaSocket\\?.dll"

local JSON = loadfile("Scripts\\JSON.lua")()
lotatcLink.JSON = JSON
local socket = require("socket")

-----------------------------------------
-- Public API 

-- Register our callbacks
lotatcLink.registerCallbacks = function( cbk )
    env.info("LotAtcLink: register callbacks")
    lotatcLink.callbacks = cbk
end

-- Initialize lotAtc Link
lotatcLink.init = function(_me)
	if not lotatcLink.scheduled then
		lotatcLink.mission_env = _me
		lotatcLink.conn = socket.tcp()
		lotatcLink.conn:settimeout(.0001)
		lotatcLink.conn:connect(lotatcLink.host, lotatcLink.port)
		
		timer.scheduleFunction(function(arg, time)
				local bool, err = pcall(lotatcLink.step)
				if not bool then
					env.info("lotatcLink.step() failed: "..err)
				end
				
				return timer.getTime() + lotatcLink.interval -- <<< update interval
			end, nil, timer.getTime() + lotatcLink.interval)
			
		lotatcLink.scheduled = true
		env.info("LotAtcLink: init scheduler ")
	end
end

-- Register an user flag to be accessible on LotAtc Advanced
lotatcLink.registerUserFlag = function( _n, _title, _description )
	local f = {}
	f.number = _n
	f.title = _title
	f.description = _description
    f.value = trigger.misc.getUserFlag(f.number)
    env.info("Register " .. f.number )
	lotatcLink.userFlags[#lotatcLink.userFlags+1] = f
end

-----------------------------------------
----------- INTERNALS
function JSON:assert(message)
   env.info("Internal Error: invalid JSON data " .. message)
end

lotatcLink.get_user_flags = function()
	for i, f in pairs(lotatcLink.userFlags) do
		-- update status
		f.value = trigger.misc.getUserFlag(f.number)
	end
	return lotatcLink.userFlags
end

lotatcLink.step = function(arg, time)
	local command = { }
	command.command = "order"

	-- Fill data as a string
	local data = {}
	data.user_flags = lotatcLink.get_user_flags()
	command.data = JSON:encode(data)

	-- Send update
    local tosend = JSON:encode(command) 
	-- env.info("LotAtcLink: send " .. tosend)
	local ret1, ret2, ret3 = lotatcLink.conn:send(tosend)

	--env.info("LotAtcLink: send error: ".. ret1)
	if ret1 then
		bytes_sent = ret1
	else
		--env.info("could not send witchcraft: "..ret2)
		if ret3 == 0 then
			if ret2 == "closed" then
				lotatcLink.conn = socket.tcp()
				lotatcLink.conn:settimeout(.0001)
				env.info("LotAtcLink: socket was closed")
			end
			env.info("LotAtcLink: reconnecting to "..tostring(lotatcLink.host)..":"..tostring(lotatcLink.port))
			lotatcLink.conn:connect(lotatcLink.host, lotatcLink.port)
			return
		end
		bytes_sent = ret3
	end
	local line, err = lotatcLink.conn:receive()
	if err then
		env.info("LotAtcLink: read error: "..err)
	else
		--env.info("LotAtcLink: received data: ".. line)
		msg = JSON:decode(line)
		if msg then 
			if msg.command == "status" then
				if lotatcLink.callbacks and lotatcLink.callbacks.command_status then
					lotatcLink.callbacks.command_status(env, msg)
				else
					env.info("LotAtcLink: no callback for command_status (use LotAtcLink.registerCallbacks)")
				end
			elseif msg.command == "order" then
				-- Check for flag changes
				-- no group in this cases
				for i, order in pairs(msg.orders) do
					if order.order_name == "flag" then
						-- env.info("Set flag " .. order.number .. " to ")
						-- if order.value then
						-- 	env.info("--> True")
						-- else
						-- 	env.info("--> False")
						-- end
						trigger.action.setUserFlag( order.number, order.value)
					end
				end

				-- Call custom if any
				if lotatcLink.callbacks and lotatcLink.callbacks.command_order then
					lotatcLink.callbacks.command_order(env, msg)
				else
					env.info("LotAtcLink: no callback for command_order (use LotAtcLink.registerCallbacks)")
				end
			end
		end
	end
end

-----------------------------------------

-----------------------------------------


    env.info("LotAtcLink initialized")
--end
