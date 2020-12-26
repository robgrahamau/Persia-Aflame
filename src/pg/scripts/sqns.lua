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
  end
  self.sqncleanup = sqncleanup
  self.sqntime = sqntime
  self.flightsize = flightsize
  self.srunning = false
  return self
end

function sqn:Spawn()
  BASE:E({"Attempting to spawn for Sqn:",self.sqnname,self.sqnunit,self.sqnamount})
  self.sqnspawner = SPAWN:NewWithAlias(self.sqnunit,self.sqnname)
    :InitCleanUp(self.sqncleanup)
    :InitAirbase(self.airbase,SPAWN.Takeoff.Cold)
    :InitGrouping(self.flightsize)
    :OnSpawnGroup(function(spawngroup) 
      self.sqnamount = self.sqnamount - self.flightsize
      self.spawnedunit = spawngroup
    end):InitRandomizeRoute(self.startroute,self.endroute,UTILS.NMToMeters(self.offsetroute),UTILS.FeetToMeters(self.altitude))
    
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
end

function sqn:Check()
  if self.srunning == true then
    self.sqntimer = SCHEDULER:New(nil,function() 
      self:Check()
    end,{},math.random((self.sqntime /2),self.sqntime))
    if self.spawnedunit ~= nil then
      BASE:E({"SQN CHECK START:",self.sqnname,self.spawnedunit:IsAirborne(),self.takeoff})
      if (self.spawnedunit:IsAirborne(true) ~= true) and (self.takeoff == true)  then
        if self.spawnedunit:IsAlive() == true then
          for _,units in pairs(self.spawnedunit:GetUnits()) do
            if units:IsAlive() == true then
              self.sqnamount = self.sqnamount + 1
            end
          end
        end
        self.spawnedunit:Destroy()
        self.takeoff = false
      elseif (self.spawnedunit:IsAirborne() == true) and (self.takeoff == false ) then
        self.takeoff = true
      elseif self.spawnedunit:IsAlive() ~= true then
        self.takeoff = false
      end
      BASE:E({"SQN CHECK END:",self.sqnname,self.spawnedunit:IsAirborne(),self.takeoff})
    end
    if self.sqnamount > 0 then
      if self.spawnedunit ~= nil then
        if self.spawnedunit:IsAlive() ~= true then
          self.spawnedunit:Destroy()
          self:Spawn()
        end
      else
        self:Spawn()
      end
    end
  else
    BASE:E({self.sqnname,"Was Stopped so check was not carried out"})
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
  BASE:E({"Starting Cap Script for Sqn",self.sqnname})
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




intercept = {
ClassName = "sqns",
sqnname = nil,
sqnunit = nil,
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
  if GROUP:FindByName("sqnunit") == nil then
  BASE:E("WAS Unable to find SQNUNIT for Intercept:" .. sqnunit .."")
  end
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



cap1 = sqn:New("Eagle CAP","USCAP1",300,math.random(2,16),2,(60*15),AIRBASE.PersianGulf.Al_Dhafra_AB)
cap2 = sqn:New("Mirage CAP","USCAP2",300,math.random(2,16),2,(60*15),AIRBASE.PersianGulf.Al_Dhafra_AB)
cap3 = sqn:New("Viper CAP","USCAP3",300,math.random(2,16),2,(60*15),AIRBASE.PersianGulf.Al_Dhafra_AB)
cap4 = sqn:New("Hornet CAP","USCAP4",300,math.random(2,16),2,(60*15),AIRBASE.PersianGulf.Al_Dhafra_AB)
cap5 = sqn:New("CAG 5 CAP","USCAP5",300,math.random(2,14),2,(60*15),"TeddyR")
cap6 = sqn:New("CAG 6 CAP","USCAP6",300,math.random(2,14),2,(60*15),"Washington")
cv5alert = sqn:New("CAG 5 CAP 2","USCAP5",300,math.random(2,14),2,(60*15),"TeddyR")
--intercept:New("CAG 5 Alert","USALERT1",300,12,2,(60*1),nil)
cv6alert = sqn:New("CAG 6 CAP 2","USCAP6",300,math.random(2,14),2,(60*15),"Washington") 
--intercept:New("CAG 6 Alert","USALERT2",300,12,2,(60*1),nil)
--cv5alert:SetZone("Carrier Group 5",148160,1)
--cv6alert:SetZone("Carrier Group 6",111120,1)
--shiraz
i30th = sqn:New("30th Squadron CAP 1","IRAF30th",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport)
i30th_1 = sqn:New("30th Squadron CAP 2","IRAF30th-1",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport)
i30th_2 = sqn:New("30th Squadron CAP 3","IRAF30th-2",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport)
i25th = sqn:New("25th Squadron CAP 1","IRAF25TH",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport)
i25th_1 = sqn:New("25th Squadron CAP 2","IRAF25TH-1",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport)
i26th = sqn:New("26th Squadron CAP 1","IRAF26TH",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport)
--kerman
i01st = sqn:New("1st Squadron CAP 1","IRAF01",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Kerman_Airport)
i02nd = sqn:New("2nd Squadron CAP 1","IRAF02",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Kerman_Airport)
i03rd = sqn:New("3rd Squadron CAP 1","IRAF03",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Kerman_Airport)
--bandar
i31st = sqn:New("31st Squadron CAP 1","IRAF31th",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Bandar_Abbas_Intl)
i32nd = sqn:New("32nd Squadron CAP 1","IRAF32nd",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Bandar_Abbas_Intl)
i33rd = sqn:New("33rd Squadron CAP 1","IRAF33rd",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Bandar_Abbas_Intl)
i33rd_2 = sqn:New("33rd Alert2","IRAF33rd",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Bandar_Abbas_Intl)
--i33rd_2 = intercept:New("33rd Alert2","IRAF33rd",300,6,2,(60*2),ZONE:New("BAI"))

--hav
i33rd_1 = sqn:New("33rd Alert Hav","IRAF33rd-1",300,math.random(0,6),2,(60*15),AIRBASE.PersianGulf.Havadarya)
--intercept:New("33rd Alert","IRAF33rd-1",300,6,2,(60*2),ZONE:New("BAI-1"))

--kish
i91st = sqn:New("91st Squadron CAP 1","IRAF91",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Kish_International_Airport)
i91st_1 = sqn:New("91st Squadron CAP 2","IRAF91",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Kish_International_Airport)
--i91st_1 = intercept:New("91st Alert","IRAF91",300,6,2,(60*2),ZONE:New("KAI"))


function startblue()
-- blue units
SCHEDULER:New(nil,function() cap1:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() cap2:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() cap3:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() cap4:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() cap5:Start() end,{},math.random(60,240))
SCHEDULER:New(nil,function() cap6:Start() end,{},math.random(60,240))

cv5alert:Start()
cv6alert:Start()
end

function startred()
-- iran units
-- IRAF01,IRAF02,IRAF03,IRAF31th,IRAF32nd,IRAF33rd,IRAF33rd-1,IRAF91
-- Shiraz Units
SCHEDULER:New(nil,function() i30th:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i30th_1:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i30th_2:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i25th:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i25th_1:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i26th:Start() end,{},math.random(1,60))
-- Kerman Units
SCHEDULER:New(nil,function() i01st:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i02nd:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i03rd:Start() end,{},math.random(1,60))
-- Bandar Units
SCHEDULER:New(nil,function() i31st:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i32nd:Start() end,{},math.random(1,60))
SCHEDULER:New(nil,function() i33rd:Start() end,{},math.random(1,60))
-- Bandar Intercept.
i33rd_2:Start()
-- Havadaria Intercept
i33rd_1:Start()

--kish
SCHEDULER:New(nil,function() i91st:Start() end,{},math.random(1,60))
--intercept
i91st_1:Start()
end


SCHEDULER:New(nil,function() 
  if usenew == true and init == true then
    startblue()
    startred()
  end
end,{},120)

