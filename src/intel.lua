minutes = 60
hours = 1 -- DO NOT SET THIS TO 0, if your not using HOURS level it as 1.
RED_EW_SET = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("REW"):FilterStart()
RED_SAM_SET = SET_GROUP:New():FilterCoalitions("red"):FilterActive():FilterPrefixes("RSAM"):FilterStart()
RED_SCUD_SET = SET_GROUP:New():FilterCoalitions("red"):FilterActive():FilterPrefixes("SCUD"):FilterStart()
RED_I_SET = SET_STATIC:New():FilterCoalitions("red"):FilterPrefixes("Iran"):FilterStart()
RED_A_SET = SET_STATIC:New():FilterCoalitions("red"):FilterPrefixes("Army"):FilterStart()

ARMY_INTEL = {}
EW_INTEL = {}
SAM_INTEL = {}
SCUD_INTEL = {}
INF_INTEL = {}
EW_INTELOUT = 0
SAM_INTELOUT = 0
SCUD_INTELOUT = 0
INF_INTELOUT = 0
intel_reports = {}
InvasionSuccess = "Fail"
-- set up our data 

RED_EW_SET:ForEachGroupAlive(function(g) 
  BASE:E({g})
  local gid =g:GetName()
  local data = {group = nil, displayed = false,text="",markerid = nil}
  EW_INTEL[gid] = data
  EW_INTEL[gid].group = g
  EW_INTEL[gid].displayed = true
  local co = g:GetCoordinate()
  local lldm = co:ToStringLLDDM()
  local llds = co:ToStringLLDMS()
  local mgrs = co:ToStringMGRS()
  local text = "CIA Report: Early Warning Radar Detected \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
  EW_INTEL[gid].text = text
  intel_reports[gid] = text
  MESSAGE:New(text,30,"CIA Intel Update"):ToAll()  
  local m = co:MarkToAll(EW_INTEL[gid].text,true)
  EW_INTEL[gid].markerid = m
end)

RED_SAM_SET:ForEachGroupAlive(function(g) 
  local gid =g:GetName()
  local data = {group = g, displayed = false,text="",markerid = nil}
  SAM_INTEL[gid] = data
  intel_reports[gid] = ""
end)

RED_SCUD_SET:ForEachGroupAlive(function(g) 
  local gid =g:GetName()
  local data = {group = g, displayed = false,text="",markerid = nil}
  SCUD_INTEL[gid] = data
  intel_reports[gid] = ""
end)
RED_I_SET:ForEachStatic(function(g) 
  local gid =g:GetName()
  local data = {static = g, displayed = false,text="",markerid = nil}
  INF_INTEL[gid] = data
  intel_reports[gid] = ""
end)

RED_A_SET:ForEachStatic(function(g) 
  local gid =g:GetName()
  local data = {static = g, displayed = false,text="",markerid = nil}
  ARMY_INTEL[gid] = data
  intel_reports[gid] = ""
end)

SCHEDULER:New(nil,function() 
BASE:E({"Intelligence Update in progress"})
BASE:E({"Checking all Markers and updating markers"})

for i,k in pairs(EW_INTEL) do 
  if k.group:IsAlive() ~= true and k.displayed == true then
    COORDINATE:RemoveMark(k.markerid)
    intel_reports[k.group:GetName()] = ""
  end
end

for i,k in pairs(SAM_INTEL) do 
  if k.group:IsAlive() ~= true and k.displayed == true then
    COORDINATE:RemoveMark(k.markerid)
    intel_reports[k.group:GetName()] = ""
  end
end

for i,k in pairs(SCUD_INTEL) do 
  if k.group:IsAlive() ~= true and k.displayed == true then
    COORDINATE:RemoveMark(k.markerid)
    intel_reports[k.group:GetName()] = ""
  end
end

for i,k in pairs(INF_INTEL) do 
  if k.static:IsAlive() ~= true and k.displayed == true then
    COORDINATE:RemoveMark(k.markerid)
    intel_reports[k.static:GetName()] = ""
  end
end

for i,k in pairs(ARMY_INTEL) do 
  if k.static:IsAlive() ~= true and k.displayed == true then
    COORDINATE:RemoveMark(k.markerid)
    intel_reports[k.static:GetName()] = ""
  end
end
BASE:E({"Dead units should no longer have markers"})

local inteltype = math.random(1,6)
  BASE:E({"Intelligence Reports Type is",inteltype})
if inteltype == 1 or inteltype == 4 or inteltype == 5 then
  BASE:E({"Entered Update SAM INTEL"})
  local intelcount =  math.random(1,4)
  for i = 1,intelcount,1 do
    local updated = false 
    for i,k in pairs(SAM_INTEL) do 
      if updated == false then
        if k.group:IsAlive() == true and k.displayed == false then
          k.displayed = true
          local co = k.group:GetCoordinate()
          local lldm = co:ToStringLLDDM()
          local llds = co:ToStringLLDMS()
          local mgrs = co:ToStringMGRS()
          BASE:E({"Get Group Type:",k.group:GetTypeName()})
          local threatlevel = k.group:GetThreatLevel()
          local text = "CIA Report: Detected Surface to Air Installation \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
          k.text = text
          intel_reports[k.group:GetName()] = text
          MESSAGE:New(text,20,"CIA Intel Update"):ToBlue()
          local m = co:MarkToCoalitionBlue(k.text,true)
          k.markerid = m
          updated = true
        end
      end
    end
  end
end

if inteltype == 2 or inteltype == 4 or inteltype == 6 then
  BASE:E({"Entered Update SCUD INTEL"})
    local updated = false 
    for i,k in pairs(SCUD_INTEL) do 
      if updated == false then
        if k.group:IsAlive() == true and k.displayed == false then
          BASE:E({"Adding new Intel"})
          k.displayed = true
          local co = k.group:GetCoordinate()
          local lldm = co:ToStringLLDDM()
          local llds = co:ToStringLLDMS()
          local mgrs = co:ToStringMGRS()
          local text = "CIA Report: Detected Possible SCUD, ARTY or ARMY Staging Site. \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
          k.text = text
          intel_reports[k.group:GetName()] = text
          MESSAGE:New(text,20,"CIA Intel Update"):ToBlue()
          local m = co:MarkToCoalitionBlue(k.text,true)
          k.markerid = m
          updated = true
        end
      end
  end
end

if inteltype == 3 or inteltype == 5 or inteltype == 6 then
  BASE:E({"Entered Update INF INTEL"})
  local intelcount =  math.random(1,2)
  for i = 1,intelcount,1 do
    local updated = false 
    for i,k in pairs(INF_INTEL) do 
      if updated == false then
        if k.static:IsAlive() == true and k.displayed == false then
          BASE:E({"Adding new Intel"})
          k.displayed = true
          local co = k.static:GetCoordinate()
          local lldm = co:ToStringLLDDM()
          local llds = co:ToStringLLDMS()
          local mgrs = co:ToStringMGRS()
          local text = "CIA Report: Detected IADS Critical System. \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
          k.text = text
          intel_reports[k.static:GetName()] = text
          MESSAGE:New(text,20,"CIA Intel Update"):ToBlue()
          local m = co:MarkToCoalitionBlue(k.text,true)
          k.markerid = m
          updated = true
        end
      end
    end
  end
end

local staticsalive = 0
for i,k in pairs(INF_INTEL) do 
  if k.static:IsAlive() == true then
    staticsalive = staticsalive + 1
    
  end
end
local ewalive = 0
for i,k in pairs(EW_INTEL) do 
  if k.group:IsAlive() == true then
    ewalive = ewalive + 1

  end
end
local scudalive = 0
for i,k in pairs(SCUD_INTEL) do 
  if k.group:IsAlive() == true then
    scudalive = scudalive + 1

  end
end
local samalive = 0
for i,k in pairs(SAM_INTEL) do
  if k.group:IsAlive() == true then
    samalive = samalive + 1
    
  end
end

if mainmission.firstrun == nil then
  mainmission.firstrun = false
  mainmission.initew = 0
  mainmission.initinf = 0
  mainmission.initscud = 0
  mainmission.initsam = 0
  mainmission.infper = 0
  mainmission.ewper = 0
  mainmission.scudper = 0
  mainmission.samper = 0
  mainmission.invasionchance = 0
  BASE:E({"mission is currently running and updating we had a nil firstrun so we are putting that value in"})
end
if mainmission.firstrun == false then
  mainmission.initinf = staticsalive
  mainmission.initew = ewalive
  mainmission.initscud = scudalive
  mainmission.initsam = samalive
  BASE:E({"INF_INTEL ALIVE:",staticsalive})
  BASE:E({"EW_INTEL ALIVE:",ewalive})
  BASE:E({"SCUD_INTEL ALIVE:",scudalive})
  BASE:E({"SAM_INTEL ALIVE:",samalive})
  BASE:E({mainmission.initinf,mainmission.initew,mainmission.initscud,mainmission.initsam})
  mainmission.firstrun = true
else
  BASE:E({"Mission has been running for a bit, current values are"})
  BASE:E({mainmission.initinf,mainmission.initew,mainmission.initscud,mainmission.initsam})
  BASE:E({staticsalive,ewalive,scudalive,samalive})
end
local staticsper =  (staticsalive / mainmission.initinf) * 100
local ewper = (ewalive / mainmission.initew) * 100
local scudper = (scudalive / mainmission.initscud) * 100
local samper = (samalive / mainmission.initsam) * 100
mainmission.infper = staticsper
mainmission.ewper = ewper
mainmission.scudper = scudper
mainmission.samper = samper
local invasionchance = 0
if staticsper > 75 then
  invasionchance = invasionchance + 0
elseif staticsper < 75 and staticsper > 50 then
  invasionchance = invasionchance + 10
elseif staticsper < 50 and staticsper > 25 then
  invasionchance = invasionchance + 20
else 
  invasionchance = invasionchance + 25
end
if ewper > 75 then
  invasionchance = invasionchance + 0
elseif ewper < 75 and ewper > 50 then
  invasionchance = invasionchance + 10
elseif ewper < 50 and ewper > 25 then
  invasionchance = invasionchance + 20
else 
  invasionchance = invasionchance + 25
end
if scudper > 75 then
  invasionchance = invasionchance + 0
elseif scudper < 75 and scudper > 50 then
  invasionchance = invasionchance + 10
elseif scudper < 50 and scudper > 25 then
  invasionchance = invasionchance + 20
else 
  invasionchance = invasionchance + 25
end
if samper > 75 then
  invasionchance = invasionchance + 0
elseif samper < 75 and samper > 50 then
  invasionchance = invasionchance + 10
elseif samper < 50 and samper > 25 then
  invasionchance = invasionchance + 20
else 
  invasionchance = invasionchance + 25
end
mainmission.invasionchance = invasionchance
end,{},30,((60*minutes) * hours))