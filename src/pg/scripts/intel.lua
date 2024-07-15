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
	hm('** $SERVERNAME - INTEL REPORT ** \n ```' .. text .. '```')
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


SCHEDULER:New(nil,function() 
  no_farps()
  RED_I_SET = RED_NO_FARPS:FilterPrefixes("Iran"):FilterOnce()
  RED_A_SET = RED_NO_FARPS:FilterPrefixes("Army"):FilterOnce()
  RED_CTLD_SET = RED_NO_FARPS:FilterPrefixes("CTLD"):FilterOnce()
  BLUE_CTLD_SET = BLUE_NO_FARPS:FilterPrefixes("CTLD"):FilterOnce()
 end,{},120,600)
 
