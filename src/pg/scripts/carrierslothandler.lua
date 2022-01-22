--- Rob's new Carrier Slot Handler Class
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
carrierslothandler = {
Classname = "Carrier Slot Handler",
name = nil,
carrier = nil,
prefix = nil,
currentcoalition = 2,
sanity = 60,
scheduler = nil,
currentstate = nil,
}


--- new function requires the values for airfield by name, the default coalition and the slot prefix so
-- @param #Carrierslothandler self
-- @param #string airfield name ie "AIRBASE.PersiaGulf.Al_Minhad_AB" or its DCS string value.
-- @param #number default coalition id, 1 = red, 2 = blue, 0 = neutral.
-- @param #string slot prefix for both sides ie "Minhad"
-- @return #slothandler self 
function carrierslothandler:New(carrier,prefix)
  local self = BASE:Inherit(self,BASE:New())
  self.name = carrier
  self.carrier = UNIT:FindByName(carrier)
  if self.carrier == nil then
    BASE:E({"ERROR unable to find unit " .. carrier ..  " Unable to continue"})
    return false
  end
  self.prefix = prefix
  self.currentcoalition = self.carrier:GetCoalition()
  if self.currentcoalition == 1 then
    self.slots = SET_CLIENT:New():FilterCoalitions("red"):FilterPrefixes(prefix):FilterOnce()
    -- self.redslots:ForEachClient(function(_client) BASE:E({"we have a R client",_client:GetName()}) end)
  else
    self.slots = SET_CLIENT:New():FilterCoalitions("blue"):FilterPrefixes(prefix):FilterOnce()
    -- self.blueslots:ForEachClient(function(_client) BASE:E({"we have a B client",_client:GetName()}) end)
  end
  BASE:E({"Slot Handler Initalised",airfield,prefix})
  return self
end

--- starts the slot handler by forcing a change and starting eventhandling.
-- @param self
-- @return self
function carrierslothandler:Start()
  self.carrier:HandleEvent(EVENTS.Dead,self.SlotChange)
  self.carrier:HandleEvent(EVENTS.RemoveUnit,self.SlotChange)
  self:SlotChange(true) -- this should set it to whatever coalition holds it when we start.
  self.scheduler = SCHEDULER:New(nil,function() self:SanityChecker() end,{},60,self.sanity)
  BASE:E({"Slot Handler Started",self.name})
  return self
end

function carrierslothandler:Stop()
  if self.scheduler ~= nil then
    self.scheduler:Stop()
  end
  self.carrier:UnHandleEvent(EVENTS.Dead)
  self.carrier:UnHandleEvent(EVENTS.RemoveUnit)
  BASE:E({"Slot Handler Stopped",self.name})
  return self
end

--- This goes through every x seconds (default is 120) and just checks what the coalition is for the airbase and
--- cross checks that against the current one.. incase for some reason the base flipped with no event firing
--- which can happen if say red units were destroyed at a base and no blue units were in it and that base was 
--- traditionally blue.
function carrierslothandler:SanityChecker()
  BASE:T({self.name,"Sanity Checker"})
  BASE:T({self.carrier:IsAlive(),self.currentstate})
  if self.carrier:IsAlive() ~= self.currentstate then
    self:SlotChange()
  end
end


--- handles the actual slot change, takes the coalition and then runs through a client set for each and sets the userflag as required.
-- @param self
-- @param number Coalition
function carrierslothandler:SlotChange()
    -- we need to run through the client slots and set them to be active for red and deactive for blue
    local flag = 0
    local _msg = "Carrier " .. self.name .. " was destroyed, slots locked"
    local _isalive = self.carrier:IsAlive()
    if self.currentstate ~= _isalive then
      self:Userfunction()
      if _isalive ~= true then
        flag = 100
        self.slots:ForEachClient(function(_client)
          local clientname = _client:GetName()
          BASE:T({"cn",clientname,flag})
          trigger.action.setUserFlag(clientname,flag)
          BASE:T({trigger.misc.getUserFlag(clientname)})
        end)
        if self.coalition == 1 then
          MESSAGE:New(_msg,30):ToRed()
        else
          MESSAGE:New(_msg,30):ToBlue()
        end 
      else
        self.slots:ForEachClient(function(_client)
          local clientname = _client:GetName()
          BASE:T({"cn",clientname,flag})
          trigger.action.setUserFlag(clientname,flag)
          BASE:T({trigger.misc.getUserFlag(clientname)})
        end)
         _msg = "Carrier " .. self.name .. " is on station, slots unlocked"
         if self.coalition == 1 then
          MESSAGE:New(_msg,30):ToRed()
        else
          MESSAGE:New(_msg,30):ToBlue()
        end 
      end
       self.currentstate = _isalive      
    end   
    BASE:E({self.name,"Slothandler","Slot Change",_isalive})
    return self
end
--- Allows for user event handling.

function carrierslothandler:Userfunction(EventData)
  -- blank handler function this gets called after slot change and allows a user to run stuff on slot change.
  -- by overriding it.

end
