--- This script currently not used.. need to really fuck it off and redo it.

bgroup = {
ClassName= "Bomber Group",}

function bgroup:create(name,isgroup)
  local self = BASE:Inherit(self,BASE:New())
  if isgroup == nil then
    isgroup = false
  end
  if isgroup == false then
    self.group = GROUP:FindByName(name)
    self.name = name
    self.original = name
  else
    self.group = name
    self.name = self.group:GetName()
    self.original = self.name
  end
  self.active = false
  self.alive = true
  self.takeoff = false
  self.air = false
  self.regenerating = false
  return self
end

function bgroup:spawn()
  BASE:E({"Starting Spawner for", self.name,self.original})
  if self.group:IsAlive() ~= nil then
        self.group:Destroy()
      end
      self.group = SPAWN:New(self.original):InitRandomizeRoute(2,6,20000,1000):OnSpawnGroup(function(spawngroup)
      self.name = spawngroup:GetName() 
      self.active = false
      self.alive = true
      self.takeoff = false
      self.air = false
    end,{}):InitRepeatOnEngineShutDown():InitCleanUp(300):Spawn()
    self.starthandlers(self)
end

function bgroup:starthandlers()
  BASE:E({self.name,"Starting Handlers"})
  self.group:HandleEvent(EVENTS.Takeoff,function(EventData) 
    BASE:E({"Group:" .. self.name .. "Has just taken off"})
    self.air = true
    end,self)
  self.group:HandleEvent(EVENTS.Crash,function(EventData)
     BASE:E({"Group:" .. self.name .. "Has just Crashed?"}) 
     -- lets see if both units are dead or just one.
       
       local gunits = self.group:GetUnits()
       local unitcount = #gunits
       local unitalive = 0
        for i = 1, #gunits do
          local gunit = self.group:GetUnit(i)
          if gunit:IsAlive() ~= nil then
            unitalive = unitalive + 1  
          end
        end
       if unitalive == 0 then
        self:setregen(true)
        self.alive = false
        BASE:E({"All units reported dead, setting to regenerate"})
       end
  end,self)
  self.group:HandleEvent(EVENTS.Land,function(EventData) 
    BASE:E({self.name,"has landed"}) 
    self.air = false
    end,self)
  self.group:HandleEvent(EVENTS.EngineShutdown,function(EventData) 
    BASE:E({self.name,"Has Engine ShutDown"})
    if self.air == true then
      BASE:E({self.name,"Was in the Air we aren't doing nothing crash will handle it"})
    else
      BASE:E({self.name,"Was on the ground, Deleteing and respawning"})
      self.takeoff = false
      self.group:Destroy() 
      self.group = self.spawn(self)
    end
  end,self)
end

function bgroup:isAlive()
  return self.alive
end
function bgroup:getactive()
  return self.active
end
function bgroup:regenerate()
  self.spawn(self)
 end

function bgroup:start()
   BASE:E({"Sending Start Command for ", self.name})
   trigger.action.pushAITask(self.group:GetDCSObject(), 1)
   self.starthandlers(self)
   self.setactive(self,true)
end

SCHEDULER:New(nil,function()
  BASE:E({"BGROUP Scheudler run"})
  local chance1 = math.random(1,5) 
  if chance1 > 2 then
    if strikers:getactive() == false then
      BASE:E({"Strikers active is false"})
      if strikers:isAlive() ~= nil then
        BASE:E({"strikers alive is not nil starting strikers"})
        strikers:start()
      else
        BASE:E({"strikers alive was nil"})
        strikers:regenerate()
      end
    end
  end
  chance1 = random(1,5) 
  if chance1 > 3 then
    if cvstrikers:getactive() == false then
      BASE:E({"CVStrikers active is false"})
      if cvstrikers:isAlive() ~= nil then
        BASE:E({"cvstrikers alive is not nil starting strikers"})
        cvstrikers:start()
      else
        BASE:E({"cvstrikers alive was nil"})
        cvstrikers:regenerate()
      end
    end
  end
  chance1 = random(1,5) 
  if chance1 > 3 then
    if seadstrikers:getactive() == false then
      BASE:E({"SEADStrikers active is false"})
      if seadstrikers:isAlive() ~= nil then
        BASE:E({"seadstrikers alive is not nil starting strikers"})
        seadstrikers:start()
      else
        BASE:E({"seadstrikers alive was nil"})
        seadstrikers:regenerate()
      end
    end
  end
 end,{},600,3200,0.25)

BASE:E({"Bomber scripting end"})