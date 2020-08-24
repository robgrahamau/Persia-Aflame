-- Initalise the SAM Sites for the first time after

INITSAMS = true
Reinforce = false

SAMTABLE = {}

if INITSAMS == true then
  
  local sam = SPAWN:New("RSAM South Bandar Abbas SA-2"):Spawn()
  SAMTABLE["RSAM South Bandar Abbas SA-2"] = sam
  SAMTABLE["RSAM South SA-10"] = SPAWN:New("RSAM South SA-10"):Spawn()
  SAMTABLE["RSAM South Bandar SA-2"] = SPAWN:New("RSAM South Bandar SA-2"):Spawn()
else


end

SCHEDULER:New(nil,function() 
  BASE:E:({"SAM CHECKING"})
for i,v in pairs(SAMTABLE) do
  BASE:E({v})  

end

end,{},60,60)