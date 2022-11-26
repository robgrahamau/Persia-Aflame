minutes = 60
hours = 1 -- DO NOT SET THIS TO 0, if your not using HOURS leave it as 1.
RED_EW_SET = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes({"IAA EW","REW"}):FilterStart()
RED_SAM_SET = SET_GROUP:New():FilterCoalitions("red"):FilterActive():FilterPrefixes({"IAA SAM","IAA SHORAD","RSAM","RAA"}):FilterStart()
RED_SCUD_SET = SET_GROUP:New():FilterCoalitions("red"):FilterActive():FilterPrefixes({"SCUD","IAA"}):FilterStart()
ALL_STATICS = SET_STATIC:New():FilterStart()
AIRBASE_STATICS= SET_STATIC:New()
RED_NO_FARPS = SET_STATIC:New()
BLUE_NO_FARPS = SET_STATIC:New()
RED_I_SET = SET_STATIC:New()
RED_A_SET = SET_STATIC:New()
BLUE_CTLD_SET = SET_STATIC:New()
RED_CTLD_SET = SET_STATIC:New()
giveintel = false
newintel = true
function no_farps()
  RED_NO_FARPS:Clear()
  RED_I_SET:Clear()
  RED_A_SET:Clear()
  RED_CTLD_SET:Clear()
  BLUE_CTLD_SET:Clear()
  BLUE_NO_FARPS:Clear()
  AIRBASE_STATICS:Clear()
  ALL_STATICS:ForEach(function (stat)
	local _name = stat:GetName()
	if AIRBASE:FindByName(_name) ~= nil then
		AIRBASE_STATICS:AddStatic(stat)
		--env.info(_name.." is a type of airbase, farp or oil rig")
		--avoid these types of static, they are really airbases
		else
			if stat:GetCoalition() == 1 then
				RED_NO_FARPS:AddStatic(stat)      
				local prefix = "Iran"
				local b = _name:find(prefix) == 1
				if b == true then
					RED_I_SET:AddStatic(stat)
				end
				prefix = "Army"
				local b = _name:find(prefix) == 1
				if b == true then
					RED_A_SET:AddStatic(stat)
				end
				prefix = "CTLD"
				local b = _name:find(prefix) == 1
				if b == true then
					RED_CTLD_SET:AddStatic(stat)
				end
				prefix = "ctld"
				local b = _name:find(prefix) == 1
				if b == true then
					RED_CTLD_SET:AddStatic(stat)
				end
			else
				BLUE_NO_FARPS:AddStatic(stat)
				local prefix = "CTLD"
				local b = _name:find(prefix) == 1
				if b == true then
					BLUE_CTLD_SET:AddStatic(stat)
				end
				prefix = "ctld"
				local b = _name:find(prefix) == 1
				if b == true then
					BLUE_CTLD_SET:AddStatic(stat)
				end     
			end
		end
  end)
end

no_farps()


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
ctldintelmarkers = {}
R_CTLD_INTEL = {}
B_CTLD_INTEL = {}

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
  if co ~= nil then
	local co = g:GetCoordinate()
	local lldm = co:ToStringLLDDM()
	local llds = co:ToStringLLDMS()
	local mgrs = co:ToStringMGRS()
	local text = "CIA Report: Early Warning Radar Detected \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
	EW_INTEL[gid].text = text
	intel_reports[gid] = text
	MESSAGE:New(text,15,"CIA Intel Update"):ToAll()  
	local m = co:MarkToAll(EW_INTEL[gid].text,true)
	HypeMan.sendBotMessage('** $SERVERNAME - INTEL REPORT ** \n ```' .. text .. '```')
	EW_INTEL[gid].markerid = m
  else
	BASE:E({"We had a NIL COORD in EW SET:",gid})
  end
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

function checkctldlogistics()
no_farps()

RED_CTLD_SET:ForEachStatic(function(g) 
  local gid =g:GetName()
  local data = {static = g, displayed = false,text="",markerid = nil}
  if g:IsAlive() == true then
    BASE:E({"Adding new Intel"})
    data.displayed = true
    local co = g:GetCoordinate()
	if co ~= nil then 
		local lldm = co:ToStringLLDDM()
		local llds = co:ToStringLLDMS()
		local mgrs = co:ToStringMGRS()
		local text = "RED CTLD Crate Pickup Point"
		data.text = text
		intel_reports[g:GetName()] = text
		if R_CTLD_INTEL[gid] == nil then
		local m = co:MarkToCoalitionRed(data.text,true)
		data.markerid = m
		R_CTLD_INTEL[gid] = data
	    end
	else
		BASE:E({"We had a NIL COORD in RED_CTLD_SET:",gid})
	end
  else
  if R_CTLD_INTEL[gid] ~= nil then
      -- remove the marker
      if R_CTLD_INTEL[gid].markerid ~= nil then
        COORDINATE:RemoveMark(R_CTLD_INTEL[gid].markerid)
        R_CTLD_INTEL[gid].markerid = nil
        R_CTLD_INTEL[gid] = nil
      end
    end
    intel_reports[gid] = ""    
  end
end)

BLUE_CTLD_SET:ForEachStatic(function(g) 
  local gid =g:GetName()
  local data = {static = g, displayed = false,text="",markerid = nil}
  if g:IsAlive() == true then
    BASE:E({"Adding new Intel"})
    data.displayed = true
    local co = g:GetCoordinate()
    if co == nil then
		BASE:E({"We had a NIL COORD in BLUE CTLD SET:",gid})
	else
		local lldm = co:ToStringLLDDM()
		local llds = co:ToStringLLDMS()
		local mgrs = co:ToStringMGRS()
		local text = "BLUE CTLD Crate Pickup Point"
		data.text = text
		intel_reports[g:GetName()] = text
		if B_CTLD_INTEL[gid] == nil then
			local m = co:MarkToCoalitionBlue(data.text,false)
			data.markerid = m
			-- we already have the marker
			B_CTLD_INTEL[gid] = data      
		end
	end
  else
    if B_CTLD_INTEL[gid] ~= nil then
      if B_CTLD_INTEL[gid].markerid ~= nil then
        -- remove the marker
        COORDINATE:RemoveMark(B_CTLD_INTEL[gid].markerid)
        B_CTLD_INTEL[gid] = nil
      end
    end
    intel_reports[gid] = ""    
  end
end)

end




function ctldintelupdate(zone)
  BASE:E({"Updating CTLD marker for Zone",zone})
  local data = {ctldarea = ZONE:New(zone), displayed = true ,text="Pickup Zone For CTLD",markerid = nil}
  local coord = data.ctldarea:GetCoordinate()
  local text = "CIA/IIA Report (CTLD) Troop Pickup Point"
  local m = coord:MarkToAll(text,true)
  data.markerid = m
  ctldintelmarkers[zone] = data
end


function markerremove()
  for i,k in pairs(EW_INTEL) do 
    if k.group:IsAlive() ~= true and k.displayed == true then
		if k.markerid ~= nil then
			COORDINATE:RemoveMark(k.markerid)
			intel_reports[k.group:GetName()] = ""
		end
    end
  end

  for i,k in pairs(SAM_INTEL) do 
    if k.group:IsAlive() ~= true and k.displayed == true then
		if k.markerid ~= nil then
			COORDINATE:RemoveMark(k.markerid)
			intel_reports[k.group:GetName()] = ""
		end
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

  BASE:E({"Dead Groupss should no longer have markers"})

end

if giveintel == true then
	SCHEDULER:New(nil,markerremove,{},300,300)
end
SCHEDULER:New(nil,function() 
  no_farps()
  RED_I_SET = RED_NO_FARPS:FilterPrefixes("Iran"):FilterOnce()
  RED_A_SET = RED_NO_FARPS:FilterPrefixes("Army"):FilterOnce()
  RED_CTLD_SET = RED_NO_FARPS:FilterPrefixes("CTLD"):FilterOnce()
  BLUE_CTLD_SET = BLUE_NO_FARPS:FilterPrefixes("CTLD"):FilterOnce()
 end,{},120,300)
 
if giveintel == true then 
SCHEDULER:New(nil,function() 
BASE:E({"Intelligence Update in progress"})
BASE:E({"Checking all Markers and updating markers"})

markerremove()

BASE:E({"CTLD LOGISTICS CHECK"})
--checkctldlogistics()


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
          local text = "CIA Report " .. nowHour .. ":" ..nowminute .. ", Detected a known Surface to Air Installation \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
          k.text = text
          intel_reports[k.group:GetName()] = text
		  HypeMan.sendBotMessage('** $SERVERNAME - INTEL REPORT ** \n > ```' .. text .. ' threat level is: ' .. threatlevel ..'```')
          MESSAGE:New(text,15,"CIA Intel Update"):ToBlue()
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
          local text = "CIA Report " .. nowHour .. ":" ..nowminute .. ", Detected Possible Hostile Ground Force, NOTE: DATA MAY NOT BE ACCURATE IF UNITS HAVE MOVED. \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
          k.text = text
          intel_reports[k.group:GetName()] = text
          MESSAGE:New(text,15,"CIA Intel Update"):ToBlue()
		  hm('** $SERVERNAME - INTEL REPORT ** \n > ```' .. text .. '```')
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
          local text = "CIA Report," .. nowHour .. ":" ..nowminute .. " Detected IADS Critical System. \n " .. lldm .. "\n " .. llds .. "\n " .. mgrs .. ""
          k.text = text
          intel_reports[k.static:GetName()] = text
          MESSAGE:New(text,15,"CIA Intel Update"):ToBlue()
		  hm('** $SERVERNAME - INTEL REPORT ** \n > ```' .. text .. '```')
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

end

if newintel == true then
abg = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterStart()
blueintel = INTEL:New(abg,"blue","CIA")
blueintel:SetClusterAnalysis(true,false)
blueintel:FilterCategoryGroup({Group.Category.SHIP,Group.Category.GROUND})
blueintel:Start()
intelmarkers = {}
blueintelmsgs = {}
function blueintel:OnAfterNewCluster(From, Event, To, Cluster)
  BASE:E({"Intel: Blue Intel, New Cluster"})
  if Cluster.ctype ~= "Aircraft" then
	--local _group = GROUP:FindByName(Contact.groupname)
	local coord = blueintel:GetClusterCoordinate(Cluster)
	local lat,long = coord:GetLLDDM()

	local text = string.format("NEW CONTACTS Detected Map ID %d \n Type %s  , Detected units: %d, Threat Level: %d, \n Location (MGRS): %s", Cluster.index, Cluster.ctype, Cluster.size, Cluster.threatlevelMax,coord:ToStringMGRS())
	local mtext = string.format("Map ID %d \n Type %s : , size %d, Threat Level: %d, \n Location (MGRS): %s", Cluster.index, Cluster.ctype,Cluster.size,Cluster.threatlevelMax,coord:ToStringMGRS())
	table.insert(blueintelmsgs,ms)
	local m = MESSAGE:New(text,60,"CIA"):ToBlue()  
	for k,v in pairs(intelmarkers) do
		if intelmarkers[k]["groupname"] == Cluster.index then
			markexist = true
			COORDINATE:RemoveMark(intelmarkers[k]["markid"])
			table.remove(intelmarkers,k)
		end
	end
	local marker = coord:MarkToCoalitionBlue(mtext,false)
	local im = {["cluster"] = Cluster.index,["groupname"] =  Cluster.index, ["markid"] = marker}
	local ms = {["cluster"] = Cluster.index,["groupname"] =  Cluster.index, ["msg"] = text}
  
	table.insert(intelmarkers,im)
  
	hm("New Intel was dropped for blue see F10 Map")
	BASE:E({"Intel: blueintelmsgs",blueintelmsgs})
  end
end
function blueintel:OnAfterLostCluster(From,Event,To,Cluster,Mission)
	BASE:E({"Intel: BLUE INTEL CLUSTER LOST",Cluster})
end

rbg = SET_GROUP:New():FilterCoalitions("red"):FilterActive(true):FilterStart()
--[[
redintel = INTEL:New(rbg,"red","IIA")
redintel:SetClusterAnalysis(true,false)
redintel:FilterCategoryGroup({Group.Category.SHIP,Group.Category.GROUND})
redintel:Start()
redintelmarkers = {}
redintelmsgs = {}

function redintel:OnAfterNewCluster(From, Event, To, Cluster)
  --local _group = GROUP:FindByName(Contact.groupname)
  local coord = redintel:GetClusterCoordinate(Cluster)
  local text = string.format("NEW CONTACTS Detected Map ID %d \n Type %s  , Detected units: %d, Threat Level: %d, \n Location (MGRS): %s", Cluster.index, Cluster.ctype, Cluster.size, Cluster.threatlevelMax,coord:ToStringMGRS())
  local mtext = string.format("Map ID %d \n Type %s , size %d, Threat Level: %d, \n Location (MGRS): %s", Cluster.index, Cluster.ctype, Cluster.size,Cluster.threatlevelMax,coord:ToStringMGRS())
  local m = MESSAGE:New(text,60,"red"):ToRed()  
  local markexist = false
  for k,v in pairs(redintelmarkers) do
	if redintelmarkers[k]["groupname"] == Cluster.index then
		BASE:E({"Group Already existed"})
		markexist = true
		COORDINATE:RemoveMark(redintelmarkers[k]["markid"])
		table.remove(redintelmarkers,k)
	end
  end
  
  local marker = coord:MarkToCoalitionRed(mtext,false)
  local rim = {["cluster"] = Cluster.index,["groupname"] =  Cluster.index, ["markid"] = marker}
  local ms = {["cluster"] = Cluster.index,["groupname"] =  Cluster.index, ["msg"] = text}
  table.insert(redintelmarkers,im)
  table.insert(redintelmsgs,ms)
  hm("New Intel was dropped for Red see F10 Map")
end

function redintel:OnAfterLostCluster(From,Event,To,Cluster,Mission)
	BASE:E({"RED INTEL CLUSTER LOST",Cluster})
  for k,v in pairs(redintelmarkers) do
    if redintelmarkers[k]["cluster"] == Cluster.index then
      COORDINATE:RemoveMark(redintelmarkers[k]["markid"])
	  table.remove(redintelmarkers,k)
    end
  end
  for k,v in pairs(redintelmsgs) do
		if redintelmsgs[k]["cluster"] == Cluster then
			table.remove(redintelmsgs,k)
		end
	end
end
]]
end
