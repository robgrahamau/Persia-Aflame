
BASE:E({"Rob's Fob dynamic script, Handles the capturing and changes of Fobs and Farps."})

fob = {
  ClassName = "FOB Handler",
  fobname = nil,
  fobunit = nil,
  coalition = 1,
  redspawn = nil,
  bluespawn = nil,
  group = nil,
  bluestaticlist = { },
  redstaticlist = { },
  blueslots = {},
  redslots = {},
}

function fob:New(name,redspawn,bluespawn,coalition,heading)
  local self = BASE:Inherit(self,BASE:New())
  self.fobname = name
  self.heading = heading
  self.fobunit = STATIC:FindByName(name)
  self.fobcoordinate = self.fobunit:GetCoordinate()
  self.coalition = coalition
  self.lastcoalition = coalition
  self.group = nil
  self.redspawn = SPAWN:New(redspawn):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
    local redgroup = GROUP:FindByName(redspawn)
    self:spawnctld(self.fobcoordinate,redgroup:GetCountry(),heading,distance)
  end)
  self.bluespawn = SPAWN:New(bluespawn):InitKeepUnitNames(true):OnSpawnGroup(function(spawngroup) 
    local bluegroup = GROUP:FindByName(bluespawn)
    self:spawnctld(self.fobcoordinate,bluegroup:GetCountry(),heading,distance)
  end)
  self.marker = nil
  self:AddBlueSlots(name)
  self:AddRedSlots(name)
  BASE:E({self.fobname,"Created",self.coalition})
  return self
end

function fob:spawnctld(_coordinate,_country,heading,distance)
  if heading == nil then
      heading = math.random(0,359)
  else 
    local minh = heading - 5 
    if minh < 0 then minh = minh + 360 end
      local maxh = heading + 5
    if maxh > 360 then maxh = maxh - 360 end
    heading = math.random(minh, maxh)
  end
  if distance == nil then
    distance = math.random(200,750)
  end
  local co = _coordinate
  local nco = co:Translate(distance,heading,false,false)
  local vec3 = nco:GetVec3()
  local _unitId = ctld.getNextUnitId()
  local _name = "ctld Deployed FOB #" .. _unitId
  local _fob = nil
  _fob = ctld.spawnFOB(_country, 211, vec3, _name)
  table.insert(ctld.logisticUnits, _fob:getName())
  if ctld.troopPickupAtFOB == true then
    table.insert(ctld.builtFOBS, _fob:getName())
  end
end

function fob:AddRedSlots(prefix)
  local redslots = SET_CLIENT:New():FilterCoalitions("red"):FilterPrefixes(prefix):FilterOnce()
  redslots:ForEachClient((function(_client)
    local clientname = _client:GetName()
    table.insert(self.redslots,clientname)
   end))
end

function fob:AddBlueSlots(prefix)
  local redslots = SET_CLIENT:New():FilterCoalitions("blue"):FilterPrefixes(prefix):FilterOnce()
  redslots:ForEachClient((function(_client)
    local clientname = _client:GetName()
    table.insert(self.blueslots,clientname)
   end))

end

function fob:SetCTLD(ctldvalue,zone)
  self.ctld = ctldvalue
  self.zone = zone
end

function fob:FlipRed()
  BASE:E({self.fobname,"Flip Red"})
  for k,v in pairs(self.redslots) do 
      trigger.action.setUserFlag(v,00)
      BASE:E({self.fobname,"Slot 00",v})
  end
  for k,v in pairs(self.blueslots) do 
      trigger.action.setUserFlag(v,100)
      BASE:E({self.fobname,"Slot 100",v})
  end
  if self.group ~= nil then
  if self.group:IsAlive() == true then
    self.group:Destroy()
  end
  end
 SCHEDULER:New(nil,function() 
  self:spawnred() 
   end,{},60)
  self.coalition = 1
  self.lastcoalition = 2

end

function fob:spawnred()
  self.group = self.redspawn:Spawn()
end

function fob:spawnblue()
  self.group = self.bluespawn:Spawn()
end

function fob:FlipBlue()
  BASE:E({self.fobname,"Flip Blue"})
  for k,v in pairs(self.redslots) do
      BASE:E({self.fobname,"Slot 100",v}) 
      trigger.action.setUserFlag(v,100)
  end
  for k,v in pairs(self.blueslots) do 
      BASE:E({self.fobname,"Slot 00",v})
      trigger.action.setUserFlag(v,00)
  end
  if self.group ~= nil then
  if self.group:IsAlive() == true then
    self.group:Destroy()
  end
  end
  SCHEDULER:New(nil,function() 
  self:spawnblue() 
   end,{},60)
  self.coalition = 2
  self.lastcoalition = 1
end

function fob:AddBlueStatics(statics)
  self.bluestaticlist = statics
end

function fob:AddRedStatics(statics)
  self.redstaticlist = statics
end

function fob:Start()
  BASE:E({self.fobname,"Starting up"})
  local col = "Iran"
  if self.coalition == 1 then
    self:FlipRed()
  else
    self:FlipBlue()
    col = "Coalition"
	self.coalition = 2
  end  
  self:HandleEvent(EVENTS.BaseCaptured) 
  local co = self.fobunit:GetCoordinate()
end


function fob:IsBlue()
  if self.fobunit.coalition == 2 then
    return true
  else
    return false
  end
end


-- self contained routegroups
function fob:routegroups(_coord,dist,coalition) 
  local gunits = nil
  if coalition:lower() == "blue" then
    gunits = SET_GROUP:New():FilterCoalitions("blue"):FilterCategoryGround():FilterActive(true):FilterOnce()
  else
    gunits = SET_GROUP:New():FilterCoalitions("red"):FilterCategoryGround():FilterActive(true):FilterOnce()
  end
  if gunits ~= nil then
    gunits:ForEach(function(g)  
      if g:IsAlive() == true then
        local _group = GROUP:FindByName(g:GetName())
        gc = _group:GetCoordinate()
        if gc == nil then
          BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
        else
          local d = gc:Get2DDistance(_coord)
          if d < dist then
            local rcoord = _coord:GetRandomCoordinateInRadius(500,100)
            g:RouteGroundTo(rcoord,math.random(10,20),randomform(),5)
          end
        end
      end
    end)
  end
end


--- Fob Event Base Capture.
function fob:OnEventBaseCaptured(EventData)
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
 local _coord = ABItem:GetCoordinate()
 if AirbaseName == self.fobname then
  if coalition == 2 and self.coalition ~= 2 then
    if self:IsBlue() ~= true then
      self:FlipBlue()
      local col = "Coalition" 
      local co = self.fobunit:GetCoordinate()
      self:routegroups(_coord,15000,"red")
    end
  elseif coalition == 1 and self.coalition ~= 1 then
    if self:IsBlue() == true then
      self:FlipRed()
      local col = "Coalition"
      local co = self.fobunit:GetCoordinate()
      self:routegroups(_coord,15000,"blue")
    end
  end
 end
end