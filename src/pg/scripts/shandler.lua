-- Support handler 
-- Goals:
-- To create a sport handler that automatically tracks, returns to base and if required respawns
-- this means that it will track when a unit launched.
-- and how long the unit should be in the air for.
-- after which time it will rtb it, depending on 

-- ToDO:Add the stuff for escorts.

SHANDLER = {
	ClassName = "Support Handler",
	Name = "",
	Group = nil,
	Unit = nil,
	Counter = 0,
	Deaths = 0,
	Limit = 4,
	Sch = nil,
	Handler = nil,
	isTanker = false,
	isJtac = false,
	isAwac = false,
	LastWaypoint = nil,
	startcoord = nil,
	airbase = nil,
	checkalive = false,
	rtbflagged = false,
	debug = true,
    takenoff = false,
	fifty = false,
	twenty = false,
}
---Instanced the Handler
---@param _name any
---@param _limit any
---@param _checkalive any
---@return table|self
function SHANDLER:New(_name,_limit,_checkalive)
	local self = BASE:Inherit(self,BASE:New())
	self.Name = _name
	self.Group = GROUP:FindByName(_name)
	self.Limit = _limit
	self.checkalive = _checkalive or false
	self.Deaths = 0
	local _m = string.format("Creating Support Handler %s",self.Name)
	rlog(_m)
	return self
end

---handles debug msgs
---@param _msg any
function SHANDLER:RDebug(_msg)
	if self.debug == true then
		rlog(_msg)
	end
end


---sets if we are using checkalive or not
---@param _value boolean
function SHANDLER:SetCheckAlive(_value)
	local _value = _value or false
	self.chackalive = _value
end

---sets if this is a jtac
---@param _value boolean
function SHANDLER:IsJtac(_value)
	self.isJtac = _value or false
end

---sets if this is a tanker
---@param _value boolean
function SHANDLER:IsTanker(_value)
	self.isTanker = _value or false
end

---sets if this is an awacs 
---@param _value boolean
function SHANDLER:IsAwac(_value)
	self.isAwac = _value or false
end

---Starts the handler
---@return table self
function SHANDLER:Start()
	local _m = string.format("Starting Support Handler %s",self.Name)
	rlog(_m)
	self:Respawn()
	self.Sch = SCHEDULER:New(nil,function() self:HeartBeat() end,{},30,300)
    return self
end

--- stops the handler
---@return table self
function SHANDLER:Stop()
	local _m = string.format("Stopping Support Handler %s",self.Name)
	rlog(_m)
	self:Despawn()
	self.Sch:Stop()
    return self
end

---Handles checkcount
---@return integer counter
function SHANDLER:checkcount()
	if self.Counter < 0 then
		self.Counter = 0
	end
	return self.Counter
end


---Adds to count
---@param _amount any
---@return integer
function SHANDLER:addcount(_amount)
	local amount = _amount or 1
	if self.Counter < 0 then
		self.Counter = 0
	end
	self.Counter = self.Counter + amount
	return self.Counter
end

---handles adding to deaths
---@return integer
function SHANDLER:add_death()
	self.Deaths = self.Deaths + 1
    return self.Deaths
end

---Handles removing a counter
---@param _amount any
---@return integer
function SHANDLER:remcount(_amount)
	local amount = _amount or 1
	self.Counter = self.Counter - amount
	if self.Counter < 0 then
		self.Counter = 0
	end
	return self.Counter
end

---Unsub
function SHANDLER:USub()
	if self.Unit ~= nil then
		-- unhandle our events
		self.Unit:UnHandleEvent(EVENTS.Dead)
		self.Unit:UnHandleEvent(EVENTS.Land)
		self.Unit:UnHandleEvent(EVENTS.Crash)
		self.Unit:UnHandleEvent(EVENTS.PilotDead)
	end
end

---sub
function SHANDLER:Sub()
    self:E({"sub entered, unit is",self.Unit})
	if self.Unit ~= nil then
        self:E({"subscribing"})
		self.Unit:HandleEvent(EVENTS.Dead,self.EDead)
		self.Unit:HandleEvent(EVENTS.Crash,self.EDead)
		self.Unit:HandleEvent(EVENTS.PilotDead,self.EDead)
		self.Unit:HandleEvent(EVENTS.Land,self.ELand)
	end
end
---event dead
---@param EventData any
function SHANDLER:EDead(EventData)
	if self.Deaths == nil then
		self.Deaths = 0
	end
	self.Deaths = self.Deaths + 1
	local _msg = string.format("%s : Mayday, Mayday, Mayday we're hit!",self.Name)
	self:SendMsg(_msg)
	_msg = string.format("%s has been killed",self.Name)
	hm(_msg)
	return self
end

---event land
---@param EventData any
function SHANDLER:ELand(EventData)
	self:E({"Eland",EventData})
    if self.isJtac == false then
		self:Respawn()
        self:E({"Eland jtac false"})
	else
		-- self:RDebug("Jtac landed do not respawn unless rtb has been flagged they refuel.")
		if self.rtbflagged == true then
			self:Respawn()
		end
	end
	return self
end


---despawn handle
function SHANDLER:Despawn()
	if self.Group ~= nil then
		if self.Group:IsAlive() == true then
			self:remcount()
			self:USub()
			self.Group = self.Group:Respawn()
		end
	end
end

---respawn handle
function SHANDLER:Respawn()
	if self.rtbflagged == true then
		self.rtbflagged = false
		self:E("rtbflagged reset")
	end
    self.takenoff = false
	self.fifty = false
	self.twenty = false
	if self.Group ~= nil then
		if self.Group:IsAlive() == true then
			self:remcount()
			self:USub()
			self.Group = self.Group:Respawn()
			self:E("Group was alive and active so we unsubbed and added a unit back to the limit then respawned.")
		end
		-- check if we can actually spawn
		if self.Counter < self.Limit then
			self:USub() -- unsub just incase.
            self.Group = GROUP:FindByName(self.Name):Respawn()
			self.Group:Activate() -- activate our group 
			self:RDebug("Activating our group as it should be late activated")
			if self.startcoord == nil then
				self.startcoord = self.Group:GetCoordinate()
			end
			if self.airbase == nil then
				self.airbase = self.startcoord:GetClosestAirbase()
				self:RDebug("Storing Airbase")
			end	
			self.Unit = self.Group:GetUnit(1)
			self:RDebug("Getting unit 1")
			-- subscribe to our events.
			self:Sub()
			
			self:addcount()
			self:RDebug("Added Count")
			if self.IsJtac == true then
				self:AddJtac()
				self:RDebug("Added Jtac")
			end
			self:RDebug("End Respawn")
		else
			local _msg = string.format("Unable to spawn in %s as limit: %d was reached Counter is:%d",self.Name,self.Limit,self.Counter)
			self:RDebug(_msg)
		end
	else
		local _msg = string.format("ERROR We were unable to respawn %n as the group is NIL! This should not be",self.Name)
		rlog(_msg)
	end
end

---addjtac
function SHANDLER:AddJtac()
	self:RDebug("Add Jtac")
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
	--put to the end
	table.insert(ctld.jtacGeneratedLaserCodes, _code)
	ctld.JTACAutoLase(self.Group:GetName(), _code) 
end

---send a msg
---@param _msg any
function SHANDLER:SendMsg(_msg)
	self:RDebug({"Send Msg",msg})
	if _msg == nil then
		_msg = " "
	end
	if self.Group:GetCoalition() == 1 then
		RGUTILS.MessageRed(_msg,15,false)
	else
		RGUTILS.MessageBlue(_msg,15,false)
	end
end

---handle rtb command
function SHANDLER:RTB()
	if self.rtbflagged == false then
		if self.Group:IsAlive() == true then -- add a check for is alive.. because this might trigger if its not alive.
			local currentcoord = self.Group:GetCoordinate()
			if currentcoord == nil then
				return false -- we can't do any of this if the coord is not valid so we exit.
			end
			local headingto = currentcoord:HeadingTo(self.startcoord)
			local distanceto = currentcoord:Get2DDistance(self.startcoord)
			local descentpoint = distanceto - UTILS.NMToMeters(5)
			local wp1 = currentcoord:Translate(descentpoint,headingto)
			wp1 = wp1:SetAltitude(UTILS.FeetToMeters(25000),true)
			local wp = {}
			local waypoints = {}
			wp[1] = wp1:WaypointAirTurningPoint("BARO",UTILS.KnotsToKmph(RGUTILS.CalculateTAS(25000,300)),nil,"Home")
			wp[2] = self.startcoord:WaypointAirLanding(UTILS.KnotsToMps(200),self.airbase,nil,"Landing")
			for i,p in ipairs(wp) do
				table.insert(waypoints,i,wp[i])
			end
			if self.isTanker == true then
				self:SendMsg(string.format("%s : Will be returning to home in 120 seconds",self.Name))
				self.Group:Route(waypoints,120)
			else
				self.Group:Route(waypoints,20)
			end
			self.rtbflagged = true
		end
	end
end

---handler heartbeat
function SHANDLER:HeartBeat()
	-- Ok we want to do some checks using the unit data
	-- is our fuel getting below 20%? because if it is we will want to let people know
	if self.Group:IsAlive() == true then
        local fuellevel = self.Unit:GetFuel()
		self:E({"Fuel level for aircraft is:",self.Name,fuellevel})
		if fuellevel == nil then
			self:E({"We had nil in get fuel"})
			fuellevel = self.Group:GetFuel()
			if fuellevel == nil then
				self:E({"Fuel was still nil we are setting to 0.2 for this pass"})
				fuellevel = 0.2
			end
		end
	    if fuellevel < 0.5 and self.fifty == false then
			self:SendMsg(string.format("%s to all, Heads up we are at 50%% fuel remaining",self.Name))
			self.fifty = true
		end
		if fuellevel < 0.2 and self.twenty == false then
			self.twenty = true
		   	self:SendMsg(string.format("%s to all, Heads up my fuel level is at 20%%, I will RTB at 15%%",self.Name))
	    end
	    if fuellevel < 0.15 then
	    	if self.rtbflagged == false then
		    	self:RTB()
		   	end
	    end
		
    end
    	-- do i want to do a check for alive in here just incase the events don't fire? ??? coding it but setting a flag for it
   	if self.checkalive == true then
	    if self.Group:IsAlive() ~= true then
   			self:Respawn()
	    end
    end
    if self.checkifonground == true then
        local currentspeed = self.Group:GetAirspeedTrue()
        if currentspeed < 100 then
            if self.takenoff == true then
                BASE:E({"we have taken off and yet now our TAS is dead slow, this suggests we have landed and not respawned, respawning"})
                self:Respawn()
            end
        else
            if self.takenoff == false then
                self.takenoff = true
            end
        end
    end



end