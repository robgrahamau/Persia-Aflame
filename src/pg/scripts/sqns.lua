Loading = true
usenew = true
BASE:E({"USE NEW CODE?",usenew})
BASE:E("Rob's Squadron Class Start")
--- Sqadron Functoin
-- Creates a squadron and automates its respawning etc.
-- @type sqns
-- @field string sqnname
-- @field string sqnunit
-- @field Core.GROUP spawnedgroup

sqn = {
ClassName = "sqns",
sqnname = nil,
sqnunit = nil,
sqncol = 0,
spawnedunit = nil,
sqnamount = 0,
sqnspawner = nil,
sqncleanup = 300,
sqntime = (60*15),
sqntimer = nil,
startroute = 2,
endroute = 5,
offsetroute = 15,
altitude = 5000,
takeoff = false,
cooldown = (5) * 60,
timer = 0,
}

--- Create New Squadron
-- @param sqnname string what you want the spawned group to be
-- @param sqnunit string of the ME group
-- @param sqncleanup cleanup time in seconds
-- @param sqnamount total sqn size
-- @param flightsize how many units in a flight
-- @param sqntime how often to check.
function sqn:New(sqnname,sqnunit,sqncleanup,sqnamount,flightsize,sqntime,airbase)
  local self = BASE:Inherit(self,BASE:New())
  self.sqnname = sqnname
  self.sqnunit = sqnunit
  self.airbase = airbase
  if GROUP:FindByName(sqnunit) == nil then
    BASE:E("WAS Unable to find SQNUNIT for SQN:" .. sqnunit .."")
	return false
  end
  local grp = GROUP:FindByName(sqnunit)
  self.sqncol = grp:GetCoalition()
  self.sqncleanup = sqncleanup
  self.sqntime = sqntime
  self.flightsize = flightsize
  self.srunning = false
  return self
end

function sqn:Spawn()
	BASE:E({"Attempting to spawn for Sqn:",self.sqnname,self.sqnunit,self.sqnamount})
	local ab = AIRBASE:FindByName self.airbase
	local col = ab:GetCoalition()
	if self.sqncol == col then
		self.sqnspawner = SPAWN:NewWithAlias(self.sqnunit,self.sqnname)
			:InitCleanUp(self.sqncleanup)
			:InitAirbase(self.airbase,SPAWN.Takeoff.Air)
			:InitGrouping(self.flightsize)
			:InitRepeatOnLanding()
			:OnSpawnGroup(function(spawngroup) 
				self.sqnamount = self.sqnamount - self.flightsize
				self.spawnedunit = spawngroup
			end)
			:InitRandomizeRoute(self.startroute,self.endroute,UTILS.NMToMeters(self.offsetroute),UTILS.FeetToMeters(self.altitude))
			
		if self.spawnedunit == nil then
			if self.sqnamount > 0 then
				self.takeoff = false
				self.sqnspawner:Spawn()
			end
		else
			if self.spawnedunit:IsAlive() ~= true then
				self.takeoff = false
				self.sqnspawner:Spawn()
			else
				BASE:E({self.sqnname,"Unable to spawn because unit is still alive"})
			end
		end
	else
		BASE:E({self.sqnname,"Unable to spawn because airbase was not ours."})
	
	end
end

function sqn:Check()
	BASE:E({"sqn check",self.sqnname})
	-- if we are running
	if self.srunning == true then
		-- schedule to self ourself again.
		self.sqntimer = SCHEDULER:New(nil,function() 
			self:Check()
		end,{},math.random((self.sqntime /2),self.sqntime))
		-- if we are not nil.
		if self.spawnedunit ~= nil then
			BASE:E({"SQN CHECK START:",self.sqnname,self.spawnedunit:IsAirborne(),self.takeoff,self.spawnedunit:IsAlive()})
			-- if we are not in the air and we have taken off 
			if (self.spawnedunit:IsAirborne() ~= true) and (self.takeoff == true)  then
				-- if we are alive
				if self.spawnedunit:IsAlive() == true then
					-- return each unit to the table.
					for _,units in pairs(self.spawnedunit:GetUnits()) do
						if units:IsAlive() == true then
							self.sqnamount = self.sqnamount + 1
						end
					end   
					-- destroy and set us to false.
					self.spawnedunit:Destroy()
					self.takeoff = false
					-- set the spawned unit to nil.
					self.spawnedunit = nil
				end
			elseif (self.spawnedunit:IsAirborne() == true) and (self.takeoff == false ) then
				-- if we are in the air and take off is false set to true.
				self.takeoff = true
			elseif self.spawnedunit:IsAlive() ~= true then
				-- if we aren't alive then yeah set false and nil.
				self.takeoff = false
				self.spawnedunit = nil
			else
				BASE:E({"SQN CHECK: Is in air",self.sqnname})
			end
			if self.spawnedunit ~= nil then
				BASE:E({"SQN CHECK END:",self.sqnname,self.spawnedunit:IsAirborne(),self.takeoff})
			else
				BASE:E({"SQN CHECK END:",self.sqnname,"Destroyed, now Nil",self.takeoff})
			end
		else
			if self.sqnamount > 0 then
					self:Spawn() 
			end
		end  
	else
		BASE:E({self.sqnname,"Was Stopped so check was not carried out"})
	end
end

function sqn:moveroute(_coord,_speed,_heading,_altitude,_distance,_engage,_roe,_task)
	local endcoord = _coord:Translate(UTILS.NMToMeters(distance),heading)
	local task = ""
	local routetask = nil
    local ertask = BAICAP:EnRouteTaskEngageTargets(UTILS.NMToMeters(engage),{"Air","Missile"},1)
	if _task == "route" then
		if _distance == 0 then
			routetask = self.spawnedunit:TaskOrbit(_coord,_altidue,_speed)
			task = "CAP, Move and Hold at assigned location"
		else
			routetask = self.spawnedunit:TaskOrbit(_coord,_altidue,_speed,endcoord)
			task = "CAP, Move and Hold in racetrack at assigned location"
		end
		
	end
	
end

function sqn:SetRouteStart(route)
	self.startroute = route
end

function sqn:SetRouteEnd(route)
	self.endroute = route
end

function sqn:SetOffset(offset)
	self.offsetroute = offset
end

function sqn:setaltitude(altitude)
	self.altitude = altitude
end

function sqn:GetSqnCount()
	return self.sqnamount
end

function sqn:SetSqnCount(count)
	self.sqnamount = count
end

function sqn:Start()
	BASE:E({"Starting Cap Script for Sqn",self.sqnname,self.sqntime})
	self.srunning = true
	self.sqntimer = SCHEDULER:New(nil,function() 
		self:Check()
	end,{},self.sqntime)
end

function sqn:Stop()
	BASE:E({"Stopping Cap Script for Sqn",self.sqnname})
	if self.srunning == true then
		self.srunning = false
	end
	if self.sqntimer ~= nil then
		self.sqntimer:Stop()
	end
end

function sqn:GetStarted()
	return self.srunning
end


intercept = {
	ClassName = "sqns",
	sqnname = nil,
	sqnunit = nil,
	spawnedunit = nil,
	sqnamount = 0,
	sqncol = 0,
	sqnspawner = nil,
	sqncleanup = 300,
	sqntime = (60*15),
	sqntimer = nil,
	startroute = 2,
	endroute = 5,
	offsetroute = 15,
	altitude = 5000,
	zoneunit = nil,
	zoneradius = 148160,
	zoneobject = nil,
	zonecoalition = 1,
}

--- Create New Squadron
-- @param sqnname string what you want the spawned group to be
-- @param sqnunit string of the ME group
-- @param sqncleanup cleanup time in seconds
-- @param sqnamount total sqn size
-- @param flightsize how many units in a flight
-- @param sqntime how often to check.
function intercept:New(sqnname,sqnunit,sqncleanup,sqnamount,flightsize,sqntime,zone)
	local self = BASE:Inherit(self,BASE:New())
	self.sqnname = sqnname
	if GROUP:FindByName(sqnunit) == nil then
		BASE:E("WAS Unable to find SQNUNIT for SQN:" .. sqnunit .."")
		return false
	end
	local grp = GROUP:FindByName(sqnunit)
	self.sqncol = grp:GetCoalition()
	self.sqnunit = sqnunit
	self.sqncleanup = sqncleanup
	self.sqntime = sqntime
	self.flightsize = flightsize
	self.zone = zone
	self.zoneobject = nil
	return self
end

function intercept:SetZone(ZoneGroup,ZoneRadius,ZoneCol)
	if ZoneGroup == nil then
		return false
	else
		self.zoneunit = GROUP:FindByName(ZoneGroup)
	end
	if ZoneRadius ~= nil then
		self.zoneradius = ZoneRadius
	end
	if ZoneCol ~= nil then
		self.zonecoalition = ZoneCol
	end
	self.zoneobject = ZONE_GROUP:New(self.sqnname,self.zoneunit,self.zoneradius)
end

function intercept:SetZonePos(ZonePos,ZoneRadius,ZoneCol)
	if ZonePos == nil then
		return false
	end  
	self.zoneradius = ZoneRadius
	if ZoneCol ~= nil then
		self.zonecoalition = ZoneCol
	end
	self.zoneobject = ZONE_RADIUS:New(self.sqnname,ZonePos,self.zoneradius)
end

function intercept:Spawn()
	BASE:E({"Attempting to spawn for Sqn:",self.sqnname,self.sqnunit})
	local ab = AIRBASE:FindByName self.airbase
	local col = ab:GetCoalition()
	if self.sqncol == col then
		self.sqnspawner = SPAWN:NewWithAlias(self.sqnunit,self.sqnname)
		:InitCleanUp(self.sqncleanup)
		:OnSpawnGroup(function(spawngroup) 
			self.sqnamount = self.sqnamount - self.flightsize
			self.spawnedunit = spawngroup
			self.spawnedunit:HandleEvent(EVENTS.EngineShutdown)
			function self.spawnedunit:OnEventEngineShutdown(EventData)
				for i = 1, self.flightsize do
					local u = self.spawnedunit:GetUnit(i)
					if u:IsAlive() == true then
						self.sqnamount = self.sqnamount + 1
					end
				end
				self.spawnedunit:Destroy()
			end
		end)  
		if self.spawnedunit == nil then
			if self.sqnamount > 0 then
				self.sqnspawner:Spawn()
			end
		else
			if self.spawnedunit:IsAlive() ~= true then
				self.sqnspawner:Spawn()
			else
				BASE:E({self.sqnname,"Unable to spawn because unit is still alive"})
			end
		end
	else
		BASE:E({self.sqnname,"Unable to spawn because Airbase is not ours."})
	end
end

function intercept:Check()
  BASE:E({"intercept check",self.sqnname})
  if self.zoneobject == nil then
    BASE:E({"Unable to check zone as returning as a nil object",self.sqnname,self.zoneobject})
    return
  end
  if self.sqnamount > 0 then
    if self.zoneobject:IsSomeInZoneOfCoalition(self.zonecoalition) then
      if self.spawnedunit ~= nil then
        if self.spawnedunit:IsAlive() ~= true then
          self:Spawn()
        end
      else
        self:Spawn()
      end
    end
  end
end

function intercept:GetSqnCount()
  return self.sqnamount
end

function intercept:SetSqnCount(count)
  self.sqnamount = count
end

function intercept:Start()
  if self.sqntime == nil then
    BASE:E({"Starting Intercept Script for Sqn",self.sqnname})
    self.sqntimer = SCHEDULER:New(nil,function() 
      self:Check()
    end,{},60,self.sqntime)
  else
    self.sqntimer:Start()
  end
end

function intercept:Stop()
  BASE:E({"Stopping Intercept Script for Sqn",self.sqnname})
  if self.sqntimer ~= nil then
    self.sqntimer:Stop()
  end
end


