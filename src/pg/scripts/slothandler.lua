

--- Rob's new Slot Handler Class
-- Last Update: 1624 19/01/2022
-- This class handles event capture for the bases and slots. 
-- it has extra bits for ctld handling if it detects ctld.
-- it also has a 'user' function that can be called using instance:Userfunction(EventData) that is triggered when 
-- a Base Capture Occures.
-- Things you should be aware of is that this script set expects that you have your UNIT NAME set to however your SSB wants to function so if it uses group
--   then you need to match your UNIT NAMES to your group names.
--   I strongly recommend if it's not already 'default' for ssb to change this line in SSB
--   local _groupName = ssb.getGroupName(_slotID)
--   to
--   local _groupName = ssb.getUnitName(_slotID)

-- create our lua class.
slothandler = {
Classname = "Slot Handler",
airfield = nil,
defaultcoalition = nil,
prefix = nil,
currentcoalition = nil,
ctld = false,
ctldblue = false,
ctldblueheading = 0,
ctldbluedistance = 2000,
ctldbluecountry = 2,
ctldred = false,
ctldredheading = 180,
ctldreddistance = 2000,
ctldredcountry = 32,
coord = nil,
sanity = 300,
_routegroups = false,
routedist = 5000,
scheduler = nil,
db = false,
bluectld = nil,
redctld = nil,
}


--- new fucntion requires the values for airfield by name, the default coalition and the slot prefix so
-- @param #slothandler self
-- @param #string airfield name ie "AIRBASE.PersiaGulf.Al_Minhad_AB" or its DCS string value.
-- @param #number default coalition id, 1 = red, 2 = blue, 0 = neutral.
-- @param #string slot prefix for both sides ie "Minhad"
-- @return #slothandler self 
function slothandler:New(airfield,_coalition,prefix)
  local self = BASE:Inherit(self,BASE:New())
  self.name = airfield
  self.airfield = AIRBASE:FindByName(airfield)
  self.coord = self.airfield:GetCoordinate()
  self.defaultcoalition = _coalition
  self.prefix = prefix
  self.currentcoalition = 0
  self.redslots = SET_CLIENT:New():FilterCoalitions("red"):FilterPrefixes(prefix):FilterOnce()
  -- self.redslots:ForEachClient(function(_client) BASE:E({self.name,"we have a R client",_client:GetName()}) end)
  self.blueslots = SET_CLIENT:New():FilterCoalitions("blue"):FilterPrefixes(prefix):FilterOnce()
  -- self.blueslots:ForEachClient(function(_client) BASE:E({self.name,"we have a B client",_client:GetName()}) end)
  BASE:E({"Slot Handler Initalised",airfield,prefix})
  return self
end

--- starts the slot handler by forcing a change and starting eventhandling.
-- @param self
-- @return self
function slothandler:Start()
  self:HandleEvent(EVENTS.BaseCaptured,self.BaseCaptured)
  self:SlotChange(self.airfield:GetCoalition()) -- this should set it to whatever coalition holds it when we start.
  self.scheduler = SCHEDULER:New(nil,function() self:SanityChecker() end,{},60,self.sanity)
  BASE:E({"Slot Handler Started",self.name})
  return self
end

function slothandler:setroutegroups(_value,dist)
  self._routegroups = _value
  if dist ~= nil then
    self.routedist = dist
  end
end

function slothandler:routegroups(_coord,dist,coalition) 
  local gunits = nil
  if coalition == 1 then
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

function slothandler:Stop()
  if self.scheduler ~= nil then
    self.scheduler:Stop()
  end
  self.UnHandleEvent(EVENTS.BaseCaptured)
  BASE:E({"Slot Handler Stopped",self.name})
  return self
end

--- This goes through every x seconds (default is 120) and just checks what the coalition is for the airbase and
--- cross checks that against the current one.. incase for some reason the base flipped with no event firing
--- which can happen if say red units were destroyed at a base and no blue units were in it and that base was 
--- traditionally blue.
function slothandler:SanityChecker()
  BASE:T({self.name,"Sanity Checker"})
  local _coalition = self.airfield:GetCoalition()
  
  if self.currentcoalition ~= _coalition then
    -- run our slot stuff.
	BASE:E({"Sanity checker",self.name,_coalition,self.currentcoalition})
    self:SlotChange(_coalition)
  end
end



--- Sets Autocapture off and forces base to the coalition returns self
-- @param number coalition
-- @returns self
function slothandler:SetCapture(_coalition)
  self.airfield:SetAutoCaptureOFF()
  self.airfield:SetCoalition(_coalition)
  return self

end

--- Sets Autocapture on/off 
-- @param boolean on/off 
-- returns self
function slothandler:SetAutoCapture(_true)
  local _true = _true or true
  if _true == false then
    self.airfield:SetAutoCaptureOFF()
  else
    self.airfield:SetAutoCaptureON()
  end
end
--- sets up the blue Ctld handlers
-- @param number heading in degree's from the Airfield Coordinate for the CTLD spawn
-- @param number Distance in meters from the airfield coordinate for the CTLD spawn
-- @param boolean if CTLD is active for this side
-- @param number _country country id for the CTLD Spawn.
function slothandler:SetBlueCTLD(heading,distance,active,_country)
  if heading ~= nil then
    self.ctldblueheading = heading
  else
    return nil
  end
  if distance ~= nil then
    self.ctldbluedistance = distance
  else
    return nil
  end
  self.ctldbluecountry = _country
  self.ctldblue = active
  return self
end
--- sets up the red Ctld handlers
-- @param number heading in degree's from the Airfield Coordinate for the CTLD spawn
-- @param number Distance in meters from the airfield coordinate for the CTLD spawn
-- @param boolean if CTLD is active for this side
-- @param number _country country id for the CTLD Spawn.
function slothandler:SetRedCTLD(heading,distance,active,_country)
  if heading ~= nil then
    self.ctldredheading = heading
  else
    return nil
  end
  if distance ~= nil then
    self.ctldreddistance = distance
  else
    return nil
  end
  self.ctldredcountry = _country
  self.ctldred = active
  return self
end

--- Activates CTLD for this handler
-- @param self
-- @return self
function slothandler:ActivateCTLD()
  self.ctld = true
  return self
end

--- Deactivates CTLD for this handler
-- @param self
-- @return self
function slothandler:DeactivateCTLD()
  self.ctld = false
  return self
end

--- Handles the Spawning of CTLD FOBs 
-- @param self
-- @param number coalition to spawn for.
-- @return boolean Returns true if a spawn happened, false otherwise.
function slothandler:SpawnCTLD(_coalition) 
  if ctld ~= nil then -- do we have ctld on the server?
    local _cdist = self.ctldreddistance
    local _chead = self.ctldredheading
    local _ccount = self.ctldredcountry
    -- check if for whatever reason we do not want to be here.
    if self.ctldred == false and _coalition == 1 then
      return false
    elseif self.ctldblue == false and _coalition == 2 then
      return false
    end
    if self.currentcoalition ~= _coalition then
      BASE:E({string.format("%s was unable to spawn ctld items because current coalition %d and requested coalition %d do not match",self.name,self.currentcoalition,_coalition),self.name,self.currentcoalition,_coalition})
      return false
    end
    -- are we blue? Then update values
    if self.ctldblue == true and _coalition == 2 then
      _cdist = self.ctldbluedistance
      _chead = self.ctldblueheading
      _ccount = self.ctldbluecountry
    end 
    local nco = self.coord:Translate(_cdist,_chead,false,false)
    local vec3 = nco:GetVec3()
    local _unitID = ctld.getNextUnitId()
    local _name = "ctld Deployed FOB #" .. _unitID
    local _fob = nil
	--[[
	if _coalition == 1 then
		if self.redctld ~= nil then
			if self.redctld:IsAlive() == true then
				--MESSAGE:New("CTLD Logistics building should still be alive, not respawning if it is not report on discord",30):ToRed()
				hm("CTLD Logistics building should still be alive, not respawning")
			return false
			end
		end
	elseif _coalition == 2 then 
		if self.bluectld ~= nil then
			if self.bluectld:IsAlive() == true then
				--MESSAGE:New("CTLD Logistics building should still be alive, not respawning if it is not report on discord",30):ToBlue()
				hm("CTLD Logistics building should still be alive, not respawning")
				return false
			end
		end
	elseif _coalition == 3 or _coalition == 0 then
		hm("CTLD Logistics building not built coalition was 3 or 0")
	end
	]]
    _fob = ctld.spawnFOB(_ccount,211,vec3,_name)
    table.insert(ctld.logisticUnits, _fob:getName())
    if ctld.troopPickupAtFOB == true then
      table.insert(ctld.builtFOBS, _fob:getName())
    end
	local _mstatic = STATIC:FindByName(_fob:getName())
	if _coalition == 1 then
		self.redctld = _mstatic
	else
		self.bluectld = _mstatic
	end
	hm("CTLD Logistics building built")
    return true
  end
  return false
end

--- handles the actual slot change, takes the coalition and then runs through a client set for each and sets the userflag as required.
-- @param self
-- @param number Coalition
function slothandler:SlotChange(_coalition)
    -- we need to run through the client slots and set them to be active for red and deactive for blue
    BASE:E(string.format("%s,slot handler,slot change coalition %d",self.name,_coalition))
	-- lets do another sanity check just incase
	if self.currentcoalition ~= _coalition then
    local bflag = 0
    local rflag = 0
     bmsg = "Airfield " .. self.name .. " was captured, slots open"
		rmsg = "Airfield " .. self.name .. " was captured, slots open"
    if _coalition == 1 then
      bflag = 100
    bmsg = "Airfield " .. self.name .. " was lost slots are now locked"
    elseif _coalition == 2 then
      rflag = 100
    rmsg = "Airfield " .. self.name .. " was lost slots are now locked"
    else 
      bflag = 100
      rflag = 100
    bmsg = "Airfield " .. self.name .. " was lost slots are now locked"
    rmsg = "Airfield " .. self.name .. " was lost slots are now locked"
    
    end
   
    self.redslots:ForEachClient(function(_client)
		local clientname = _client:GetName()
		local groupname = _client:GetClientGroupName()
		BASE:T({self.name,"cn",clientname,rflag,"gn",groupname})
		trigger.action.setUserFlag(clientname,rflag)
		BASE:T({self.name,"cn",clientname,rflag,trigger.misc.getUserFlag(clientname)})
    end)
    
    -- blue slots
    self.blueslots:ForEachClient(function(_client)
    local clientname = _client:GetName()
    BASE:T({self.name,"cn",clientname,bflag})
    trigger.action.setUserFlag(clientname,bflag)
    BASE:T({self.name,trigger.misc.getUserFlag(clientname)})
    end)
    -- ctld if active
    if self.ctld == true then
      SCHEDULER:New(nil,function()
        self:SpawnCTLD(_coalition)
      end,{},60)
    end

    if self.routegroups == true then
      self:routegroups(self.coord,self.routedist,_coalition)
    
    end
    MESSAGE:New(bmsg,30):ToBlue()
    MESSAGE:New(rmsg,30):ToRed()
    self.currentcoalition = _coalition
	else
		BASE:E({self.name,"Slot change, self.currentcoalition and _coalition matched!",self.currentcoalition,_coalition})
	end
    return self
end
--- Allows for user event handling.
function slothandler:Userfunction(EventData)
  -- blank handler function this gets called after slot change and allows a user to run stuff on slot change.
  -- by overriding it.

end

--- Base capture event handler.
-- @param #slothandler self
-- @param EventData
-- @return self
function slothandler:BaseCaptured(EventData)
  -- store the Event Placename
  local abn = EventData.PlaceName
  -- cross check the Event Placename against the Handler just incase, we don't want shit to run that we don't need.
  if abn == self.name then
    -- this is a sanity check it's here incase what is blow doesn't work, just uncomment these two lines
    -- and comment out the one below   
    --local abitem = AIRBASE:FindByName(abn)
    --local _coalition = abitem:GetCoalition()
    
    local _coalition = self.airfield:GetCoalition()
    BASE:E({_coalition,self.currentcoalition})
    if self.currentcoalition ~= _coalition then
      -- run our slot stuff.
      self:SlotChange(_coalition)
      self:Userfunction(EventData)
    end
  end
end