BASE:E({"Rob's Fob dynamic script, Handles the capturing and changes of Fobs and Farps."})

fob = {
ClassName = "FOBS",
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

function fob:New(name,redspawn,bluespawn,coalition)
  local self = BASE:Inherit(self,BASE:New())
  self.fobname = name
  self.fobunit = STATIC:FindByName(name)
  self.coalition = coalition
  self.redspawn = redspawn
  self.bluespawn = bluespawn
  self.marker = nil
  BASE:E({self.fobname,"Created",self.coalition})
  return self
end

function fob:AddRedSlots(slotlist)
  self.redslots = slotlist
end

function fob:AddBlueSlots(slotlist)
  self.blueslots = slotlist
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
  for k,v in pairs(self.bluestaticlist) do 
    local s = STATIC:FindByName(v)
    BASE:E({s})
    s:Destroy()
  end
    for k,v in pairs(self.redstaticlist) do 
    local s = STATIC:FindByName(v)
    BASE:E({s})
    s:ReSpawn()
  end
  self.group = self.redspawn:Spawn()
  self.coalition = 1
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
  for k,v in pairs(self.redstaticlist) do 
      local s = STATIC:FindByName(v)
      BASE:E({s})
      s:Destroy()
  end
    for k,v in pairs(self.bluestaticlist) do 
    local s = STATIC:FindByName(v)
    BASE:E({s})
    s:ReSpawn()
  end
  self.group = self.bluespawn:Spawn()
  self.coalition = 2
end

function fob:AddBlueStatics(statics)
	self.bluestaticlist = statics
end
function fob:AddRedStatics(statics)
	self.redstaticlist = statics
end

function fob:Startup()
  BASE:E({self.fobname,"Starting up"})
  local col = "Iran"
  if self.coalition == 1 then
    self:FlipRed()
    
  else
    self:FlipBlue()
    col = "Coalition"
  end
  
  self:HandleEvent(EVENTS.BaseCaptured) 
  local co = self.fobunit:GetCoordinate()
  self.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
end


function fob:IsBlue()
  if self.fobunit.coalition == 2 then
    return true
  else
    return false
  end
end

function fob:OnEventBaseCaptured(EventData)
 BASE:E({self.fobname,"Base capture"})
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
  BASE:E({self.fobname,"Base capture",coalition})
 if AirbaseName == self.fobname then
  if coalition == 2 then
      if self:IsBlue() ~= true then
        self:FlipBlue()
        local col = "Coalition"
        COORDINATE:RemoveMark(self.marker)
        self.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
      end
  elseif coalition == 1 then
      if self:IsBlue() == true then
        self:FlipRed()
        local col = "Coalition"
        COORDINATE:RemoveMark(self.marker)
        self.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
      end
  end
 end
end


EP = fob:New("EP",SPAWN:New("red_ep"),SPAWN:New("blue_ep"),1)
EP:AddRedStatics({"EPLOG"})
EP:AddBlueStatics({"EPBLOG"})
EP:AddRedSlots({"EPUH2","EPUH2-1","EPKA50-2","EPKA50-3","EPMI8-2","EPMI8-3"})
EP:AddBlueSlots({"EPUH1","EPUH1-1","EPKA50","EPKA50-1","EPMI8","EPMI8-1"})
EP:Startup()

EQ = fob:New("EQ",SPAWN:New("red_EQ"),SPAWN:New("blue_EQ"),1)
EQ:AddRedStatics({"EQRLOG"})
EQ:AddBlueStatics({"EQBLOG"})
EQ:AddRedSlots({"EQUH2","EQUH2-1"})
EQ:AddBlueSlots({"EQUH1","EQUH1-1"})
EQ:Startup()

ER = fob:New("ER",SPAWN:New("red_ER"),SPAWN:New("blue_ER"),1)
ER:AddRedStatics({"ERRLOG"})
ER:AddBlueStatics({"ERBLOG"})
ER:AddRedSlots({"ERUH2","ERUH2-1"})
ER:AddBlueSlots({"ERUH1","ERUH1-1"})
ER:Startup()

FR = fob:New("FR",SPAWN:New("red_FR"),SPAWN:New("blue_FR"),1)
FR:AddRedStatics({"FRRLOG"})
FR:AddBlueStatics({"FRBLOG"})
FR:AddRedSlots({"FRUH2","FRUH2-1"})
FR:AddBlueSlots({"FRUH1","FRUH1-1"})
FR:Startup()

FDR = fob:New("farp fdr35",SPAWN:New("farp_resup"),SPAWN:New("farp_resupb"),1)
FDR:AddRedStatics({"FRRLOG"})
FDR:AddBlueStatics({"FRBLOG"})
FDR:AddRedSlots({"BFARP KA50","BFARP KA50 #001","BFARP UH1","BFARP MI8","BFARP UH1-1","BFARP MI8-1"})
FDR:AddBlueSlots({"BFARP UH1-2","BFARP UH1-3","BFARP KA501-1","BFARP KA501","BFARP MI81","BFARP MI81-1",})
FDR:Startup()

CR = fob:New("CR",SPAWN:New("red_CR"),SPAWN:New("blue_CR"),1)
CR:AddRedStatics({"CRRLOG"})
CR:AddBlueStatics({"CRBLOG"})
CR:AddRedSlots({"CRUH2-1","CRUH2","CRKA502","CRKA502-1"})
CR:AddBlueSlots({"CRUH1","CRUH1-1","CRKA501","CRKA501-1"})
CR:Startup()

BQ = fob:New("BQ",SPAWN:New("red_BQ"),SPAWN:New("blue_BQ"),1)
BQ:AddRedStatics({"BQRLOG"})
BQ:AddBlueStatics({"BQBLOG"})
BQ:AddRedSlots({"BQUH2","BQUH2-1","BQKA502","BQKA502-1"})
BQ:AddBlueSlots({"BQUH1","BQUH1-1","BQKA501","BQKA501-1"})
BQ:Startup()

CQ = fob:New("CQ",SPAWN:New("red_CQ"),SPAWN:New("blue_CQ"),1)
CQ:AddRedStatics({"CQRLOG"})
CQ:AddBlueStatics({"CQBLOG"})
CQ:AddRedSlots({"CQUH2","CQUH2-1","CQKA50","BQKA502-1"})
CQ:AddBlueSlots({"CQUH1","CQUH1-1","CQKA502","CQKA502-1"})
CQ:Startup()

BR = fob:New("BR",SPAWN:New("red_BR"),SPAWN:New("blue_BR"),1)
BR:AddRedStatics({"BRRLOG"})
BR:AddBlueStatics({"BRBLOG"})
BR:AddRedSlots({"BRUH2","BRUH2-1"})
BR:AddBlueSlots({"BRUH1","BRUH1-1"})
BR:Startup()

BS = fob:New("BS",SPAWN:New("red_BS"),SPAWN:New("blue_BS"),1)
BS:AddRedStatics({"CQRLOG"})
BS:AddBlueStatics({"CQBLOG"})
BS:AddRedSlots({"BSUH2","BSUH2-1","BSKA50-2","BSKA50-3"})
BS:AddBlueSlots({"BSUH1","BSUH1-1","BSKA50","BSKA50-1"})
BS:Startup()

YN = fob:New("YN",SPAWN:New("red_YN"),SPAWN:New("blue_YN"),1)
YN:AddRedStatics({"YNRLOG"})
YN:AddBlueStatics({"YNBLOG"})
YN:AddRedSlots({"YNUH2","YNUH2-1","BSKA502","BSKA502-1"})
YN:AddBlueSlots({"YNUH1","YNUH1-1","YNKA501","YNKA501-1"})
YN:Startup()

DS = fob:New("DS",SPAWN:New("red_DS"),SPAWN:New("blue_DS"),1)
DS:AddRedStatics({"DSRLOG"})
DS:AddBlueStatics({"DSBLOG"})
DS:AddRedSlots({"DSUH2","DSUH2-1","DSKA502","DSKA502-1"})
DS:AddBlueSlots({"DSUH1","DSUH1-1","DSKA50-1","DSKA50"})
DS:Startup()

CT = fob:New("CT",SPAWN:New("red_CT"),SPAWN:New("blue_CT"),1)
CT:AddRedStatics({"CTRLOG"})
CT:AddBlueStatics({"CTBLOG"})
CT:AddRedSlots({"CTUH2","CTUH2-1","CTKA502","CTKA502-1"})
CT:AddBlueSlots({"CTUH1","CTUH1-1","CTKA501","CTKA501-1"})
CT:Startup()

DU = fob:New("DU",SPAWN:New("red_DU"),SPAWN:New("blue_DU"),1)
DU:AddRedStatics({"DURLOG"})
DU:AddBlueStatics({"DUBLOG"})
DU:AddRedSlots({"DUUH2","DUUH2-1","DUKA502","DUKA502-1"})
DU:AddBlueSlots({"DUUH1","DUUH1-1","DUKA501","DUKA501-1"})
DU:Startup()

