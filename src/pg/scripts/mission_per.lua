reinforhrs = 4
reinformins = 0
reinforcements = ((60 * 60) * reinforhrs) + (60 * reinformins) 
dsqnsize = 24
dsqnlsize = 32
dsqnssize = 18
dsqnvssize = 8

local SaveSchedulePersistence=600 
mainmission = { 
  ["Shiraz"] = 16,
  ["Shiraz1"] = 16,
  ["Shiraz2"] = 16,
  ["Shiraz_Int"] = 12,
  ["Kerman"] = 16,
  ["Kerman1"] = 16,
  ["Kerman2"] = 16,
  ["Kerman_INT"] = 12,
  ["Bandar_Abbas"] = 12,
  ["Bandar_Abbas2"] = 16,
  ["Bandar_Abbas_INT"] = 12,
  ["Lar"] = 8,
  ["Kish"] = 12,
  ["Kish_INT"] = 12,
  ["Kuznetsov_INT"] = 18,
  ["Stennis"] = 12,
  ["TeddyR"] = 12,
  ["Al_Dhafra"] = 32,  
  ["missionstartday"] = 0,
  ["missionstartmonth"] = 0,
  ["missionstartyear"] = 0,
  ["missionstarthour"] = 0,
  ["missionstartminute"] = 0,
  ["missionstartsecs"] = 0,
  ["lastupdatehour"] = 0,
  ["lastupdateminute"] = 0,
  ["lastupdatesec"] = 0,
  ["nextupdatehour"] = 0,
  ["nextupdatemin"] = 0,
  ["nextupdatesec"] = 0,
  ["manpads"] = false,
  ["firstrun"] = false,
  ['initinf'] = 0,
  ['initew'] = 0,
  ['initscud'] = 0,
  ['initsam'] = 0,
  ['ewper'] = 0,
  ['scudper'] = 0,
  ['samper'] = 0,
  ['invasionchance'] = 0,
  ['ships'] = true,
  ['shipgroup1'] = true,
  ['shipgroup2'] = true,
  ['shipgroup3'] = true,
}
local savefilename = "mainmissionsave.lua"
 
local savefile = lfs.writedir() .."pg\\" .. savefilename
local savepath = lfs.writedir() .."pg\\"
 -----------------------------------
 --Do not edit below here
 -----------------------------------
 local version = "1.0"
 
 function IntegratedbasicSerialize(s)
    if s == nil then
      return "\"\""
    else
      if ((type(s) == 'number') or (type(s) == 'boolean') or (type(s) == 'function') or (type(s) == 'table') or (type(s) == 'userdata') ) then
        return tostring(s)
      elseif type(s) == 'string' then
        return string.format('%q', s)
      end
    end
  end
  
-- imported slmod.serializeWithCycles (Speed)
  function IntegratedserializeWithCycles(name, value, saved)
    local basicSerialize = function (o)
      if type(o) == "number" then
        return tostring(o)
      elseif type(o) == "boolean" then
        return tostring(o)
      else -- assume it is a string
        return IntegratedbasicSerialize(o)
      end
    end

    local t_str = {}
    saved = saved or {}       -- initial value
    if ((type(value) == 'string') or (type(value) == 'number') or (type(value) == 'table') or (type(value) == 'boolean')) then
      table.insert(t_str, name .. " = ")
      if type(value) == "number" or type(value) == "string" or type(value) == "boolean" then
        table.insert(t_str, basicSerialize(value) ..  "\n")
      else

        if saved[value] then    -- value already saved?
          table.insert(t_str, saved[value] .. "\n")
        else
          saved[value] = name   -- save name for next time
          table.insert(t_str, "{}\n")
          for k,v in pairs(value) do      -- save its fields
            local fieldname = string.format("%s[%s]", name, basicSerialize(k))
            table.insert(t_str, IntegratedserializeWithCycles(fieldname, v, saved))
          end
        end
      end
      return table.concat(t_str)
    else
      return ""
    end
  end

function file_exists(name) --check if the file already exists for writing
    if lfs.attributes(name) then
    BASE:E({"Mission file found"})
    return true
    else
    BASE:E({"Mission file not found"})
    return false end 
end

function writemission(data, file)--Function for saving to file (commonly found)
  File = io.open(file, "w")
  File:write(data)
  File:close()
end


function loadvalues()
  
  ra2disp:SetSquadron("Shiraz",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},mainmission.Shiraz)
  ra2disp:SetSquadron("Shiraz1",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},mainmission.Shiraz1)
  ra2disp:SetSquadron("Shiraz2",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F5_2","MIG29_2"},mainmission.Shiraz2)
  ra2disp:SetSquadron("Shiraz INT",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F4_2"},mainmission.Shiraz_Int)
  ra2disp:SetSquadron("Kerman",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},mainmission.Kerman)
  ra2disp:SetSquadron("Kerman1",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},mainmission.Kerman1)
  ra2disp:SetSquadron("Kerman2",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","M2000_1"},mainmission.Kerman2)
  ra2disp:SetSquadron("Kerman INT",AIRBASE.PersianGulf.Kerman_Airport,{"MIG21_1","MIG21_2"},mainmission.Kerman_INT)
  ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},mainmission.Bandar_Abbas)
  ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},mainmission.Bandar_Abbas2)
  ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},mainmission.Bandar_Abbas_INT)
  ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},mainmission.Lar)
  ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},mainmission.Kish)
  ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},mainmission.Kish_INT)
  ra2disp:SetSquadron("Kuznetsov INT","Kuznetsov",{"SU33_1","SU33_2"},mainmission.Kuznetsov_INT)
  
  ba2disp:SetSquadron("Stennis","Stennis",BCarrierTEMP,mainmission.Stennis)
  ba2disp:SetSquadron("TeddyR","TeddyR",BCarrierTEMP,mainmission.TeddyR)
  ba2disp:SetSquadron("Al Draf",AIRBASE.PersianGulf.Al_Dhafra_AB,BLandTemp,mainmission.Al_Dhafra)
  if mainmission.ships == nil then
    mainmission.shipgroup1 = true
    mainmission.shipgroup2 = true
    mainmission.shipgroup3 = true
    mainmission.ships = true
  end
  if mainmission.shipgroup1 == true then
    -- local temp = GROUP:FindByName("Type 054A Frigate"):Activate()
  end
  if mainmission.shipgroup2 == true then
    local temp = GROUP:FindByName("Cuban Tanker 1"):Activate()
  end
  if mainmission.shipgroup3 == true then
    local temp = GROUP:FindByName("Kuznetsov Group"):Activate()
  end
  --[[Lar:Load(savepath,"lars.txt")
  Shiraz:Load(savepath,"Shiraz.txt")
  Kish:Load(savepath,"Kish.txt")
  Kerman:Load(savepath,"Kerman.txt")
  Bandar:Load(savepath,"Bandar.txt")
  Tunb:Load(savepath,"Tunb.txt")
  ]]
end
--SCRIPT START
env.info("Loaded PD SAVE, version " .. version)
if file_exists(savefile) then --Script has been run before, so we need to load the save
    dofile(savefile)
    env.info("Main Mission: Existing database, loading from File.")
    BASE:E({mainmission})
    loadvalues()
    init = true
else
    env.info("Main Mission: We couldn't find an existing Database to load from file")
    if os ~= nil then
        mnowTable = os.date('*t')
        mnowYear = mnowTable.year
        mnowMonth = mnowTable.month
        mnowDay = mnowTable.day
        mnowHour = mnowTable.hour
        mnowminute = mnowTable.min
        mnowsec = mnowTable.secs
        mnowTime = os.time()
    else
       mnowYear = 0
       mnowMonth = 0
       mnowDay = 0
       mnowHour = 0
       mnowminute = 0
       mnowsec = 0
       mnowtime = 0
    end
    mainmission.missionstartday = mnowTable.day
    mainmission.missionstarthour = mnowTable.hour
    mainmission.missionstartminute = mnowTable.min
    mainmission.missionstartmonth = mnowTable.month
    mainmission.missionstartsecs = mnowTable.secs
    mainmission.missionstartyear = mnowTable.year
    mainmission.lastupdatehour = mnowTable.hour
    mainmission.lastupdateminute = mnowTable.min
    mainmission.lastupdatesec = mnowTable.sec
    mainmission.nextupdate = mnowTime + reinforcements
    mainmission.nextupdatehour = mnowTable.hour + reinforhrs
    mainmission.nextupdatemin = mnowTable.min + reinformins
    BASE:E({mainmission.nextupdate})
    local temp = GROUP:FindByName("Cuban Tanker 1"):Activate()
    temp = GROUP:FindByName("Kuznetsov Group"):Activate()
    --[[Lar:Save(savepath,"lars.txt")
    Shiraz:Save(savepath,"Shiraz.txt")
    Kish:Save(savepath,"Kish.txt")
    Kerman:Save(savepath,"Kerman.txt")
    Bandar:Save(savepath,"Bandar.txt")
    Tunb:Save(savepath,"Tunb.txt")
    ]]
    init = true
end


function save()
  env.info("FORCE DATA Data SAVE!!!!!!!!!!.")
  newMissionStr = IntegratedserializeWithCycles("mainmission",mainmission) --save the Table as a serialised type with key SaveUnits
  writemission(newMissionStr, savefile)--write the file from the above to SaveUnits.lua
  env.info("Data saved.")
end


function reinforce()
   if os ~= nil then
        mnowTable = os.date('*t')
        mnowYear = nowTable.year
        mnowMonth = nowTable.month
        mnowDay = nowTable.day
        mnowHour = nowTable.hour
        mnowminute = nowTable.min
        mnowsec = nowTable.secs
        mnowTime = os.time()
    end
    BASE:E({"Running Reinforcement Scripting nowtime,nextupdate",mnowTime,mainmission.nextupdate})
    if mnowTime > mainmission.nextupdate then
      BASE:E({"Reinforcements arriving"})
      if mainmission.Shiraz < dsqnsize then
        if mainmission.Shiraz < 0 then
          mainmission.Shiraz = 0
        end
        local newval = mainmission.Shiraz + math.random(2,8)
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Shiraz",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},newval)
      end
      if mainmission.Shiraz1 < dsqnsize then
        if mainmission.Shiraz1 < 0 then
          mainmission.Shiraz1 = 0
        end
        local newval = mainmission.Shiraz1 + math.random(2,8)
        
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Shiraz1",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},newval)
      end
      if mainmission.Shiraz2 < dsqnsize then 
        if mainmission.Shiraz2 < 0 then
          mainmission.Shiraz2 = 0
        end
        local newval = mainmission.Shiraz2 + math.random(2,8)
        
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Shiraz2",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F5_2","MIG29_2"},newval)
      end
      if mainmission.Shiraz_Int < dsqnssize then
        if mainmission.Shiraz_Int < 0 then
          mainmission.Shiraz_Int = 0
        end 
        local newval = mainmission.Shiraz_Int + math.random(2,8)
        if newval > dsqnssize then
          newval = dsqnssize
        end
        ra2disp:SetSquadron("Shiraz INT",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F4_2"},newval)
      end
      if mainmission.Kerman < dsqnsize then
        if mainmission.Kerman < 0 then
          mainmission.Kerman = 0
        end 
        local newval = mainmission.Kerman + math.random(2,8)
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Kerman",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},newval)
      end
      if mainmission.Kerman1 < dsqnsize then 
        if mainmission.Kerman1 < 0 then
          mainmission.Kerman1 = 0
        end
        local newval = mainmission.Kerman1 + math.random(2,8)
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Kerman1",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},newval)
      end
      if mainmission.Kerman2 < dsqnsize then
        if mainmission.Kerman2 < 0 then
          mainmission.Kerman2 = 0
        end
        local newval = mainmission.Kerman2 + math.random(2,8)
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Kerman2",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","M2000_1"},newval)
      end
      if mainmission.Kerman_INT < dsqnssize then
        if mainmission.Kerman_INT < 0 then
          mainmission.Kerman_INT = 0
        end 
        local newval = mainmission.Kerman_INT + math.random(0,8)
        if newval > dsqnssize then
          newval = dsqnssize
        end
        ra2disp:SetSquadron("Kerman INT",AIRBASE.PersianGulf.Kerman_Airport,{"MIG21_1","MIG21_2"},newval)
      end
	  local ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl)
	  local coalition = ABItem:GetCoalition()
      if (mainmission.Bandar_Abbas < dsqnsize) and (coalition == 1) then
        if mainmission.Bandar_Abbas < 0 then
          mainmission.Bandar_Abbas = 0
        end 
        local newval = mainmission.Bandar_Abbas + math.random(0,6)
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},newval)
      end
      if (mainmission.Bandar_Abbas2 < dsqnsize) and (coalition == 1) then
        if mainmission.Bandar_Abbas2 < 0 then
          mainmission.Bandar_Abbas2 = 0
        end  
        local newval = mainmission.Bandar_Abbas2 + math.random(0,6)
        if newval > dsqnsize then
          newval = dsqnsize
        end
        ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},newval)
      end
	  ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Havadarya)
	  coalition = ABItem:GetCoalition()
	  if mainmission.Bandar_Abbas_INT < 0 then 
		mainmission.Bandar_Abbas_INT = 0 
		ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_1","MIG21_2"},0)
	  end
      if (mainmission.Bandar_Abbas_INT < dsqnssize) and (coalition == 1) then
        if mainmission.Bandar_Abbas_INT < 0 then
          mainmission.Bandar_Abbas_INT = 0
        end 
        local newval = mainmission.Bandar_Abbas_INT + math.random(0,4)
        if newval > dsqnssize then
          newval = dsqnssize 
        end
        ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_1","MIG21_2"},newval)
      end
	  ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Lar_Airbase)
	  coalition = ABItem:GetCoalition()
      if (mainmission.Lar < dsqnvssize) and (coalition == 1) then
      if mainmission.Lar < 0 then
          mainmission.Lar = 0
        end 
        local newval = mainmission.Lar + 2
        if newval > dsqnvssize then
          newval = dsqnvssize
        end
        ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},newval)
     end
	 ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport)
	 coalition = ABItem:GetCoalition()
     if (mainmission.Kish < dsqnssize) and (coalition == 1) then
      if mainmission.Kish < 0 then
          mainmission.Kish = 0
        end 
      local newval = mainmission.Kish + math.random(0,4)
      if newval > dsqnssize then
        newval = dsqnssize 
      end
      ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},mainmission.Kish)
    end
    if (mainmission.Kish_INT < dsqnvssize) and (coalition == 1) then
      if mainmission.Kish_INT < 0 then
          mainmission.Kish_INT = 0
      end 
      local newval = mainmission.Kish_INT + math.random(0,4) 
      if newval > dsqnvssize then
        newval = dsqnvssize
      end
      ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},newval)
    end
    if mainmission.Kuznetsov_INT < dsqnlsize then
      if mainmission.Kuznetsov_INT < 0 then
          mainmission.Kuznetsov_INT = 0
        end 
      
      local newval = mainmission.Kuznetsov_INT + math.random(0,6)
      if newval > dsqnlsize then 
        newval = dsqnlsize 
      end
      ra2disp:SetSquadron("Kuznetsov INT","Kuznetsov",{"SU33_1","SU33_2"},newval)
    end
   if mainmission.Stennis < 18 then
	if mainmission.Stennis < 0 then
          mainmission.Stennis = 0
    end 
    local newval = mainmission.Stennis + math.random(2,12)
    if newval > 18 then
      newval = 18
    end
     ba2disp:SetSquadron("Stennis","Stennis",BCarrierTEMP,newval)
   end
   if mainmission.TeddyR < 18 then
    if mainmission.TeddyR < 0 then
          mainmission.TeddyR = 0
        end 
    local newval = mainmission.TeddyR + math.random(2,12)
    if newval > 18 then
      newval = 18 
    end
    ba2disp:SetSquadron("TeddyR","TeddyR",BCarrierTEMP,newval)
   end
   if mainmission.Al_Dhafra < 32 then
    if mainmission.Al_Dhafra < 0 then
        mainmission.Al_Dhafra = 0
    end 
    local newval = mainmission.Al_Dhafra + math.random(4,16)
    if newval > 32 then
      newval = 32
    end
    ba2disp:SetSquadron("Al Draf",AIRBASE.PersianGulf.Al_Dhafra_AB,BLandTemp,newval)
  end
  mainmission.nextupdate = mnowTime + reinforcements
  
  mainmission.lastupdatehour = mnowHour
  mainmission.lastupdateminute = mnowminute
  mainmission.lastupdatesec = mnowsec
  BASE:E({"next update is at",mainmission.nextupdate})
  updatevalues()
  end
end


function updatevalues()
  mainmission.Shiraz = ra2disp:GetSquadronAmount("Shiraz")
  mainmission.Shiraz1 = ra2disp:GetSquadronAmount("Shiraz1")
  mainmission.Shiraz2 = ra2disp:GetSquadronAmount("Shiraz2")
  mainmission.Shiraz_Int = ra2disp:GetSquadronAmount("Shiraz INT")
  mainmission.Kerman = ra2disp:GetSquadronAmount("Kerman")
  mainmission.Kerman1 = ra2disp:GetSquadronAmount("Kerman1")
  mainmission.Kerman2 = ra2disp:GetSquadronAmount("Kerman2")
  mainmission.Kerman_INT = ra2disp:GetSquadronAmount("Kerman INT")
  mainmission.Bandar_Abbas = ra2disp:GetSquadronAmount("Bandar Abbas")
  mainmission.Bandar_Abbas2 = ra2disp:GetSquadronAmount("Bandar Abbas 2")
  mainmission.Bandar_Abbas_INT = ra2disp:GetSquadronAmount("Bandar Abbas INT")
  mainmission.Lar = ra2disp:GetSquadronAmount("Lar")
  mainmission.Kish = ra2disp:GetSquadronAmount("Kish")
  mainmission.Kish_INT = ra2disp:GetSquadronAmount("Kish INT")

  mainmission.Stennis = ba2disp:GetSquadronAmount("Stennis")
  mainmission.TeddyR = ba2disp:GetSquadronAmount("TeddyR")
  mainmission.Al_Dhafra = ba2disp:GetSquadronAmount("Al Draf")
  
  mainmission.shipgroup1 = false
  mainmission.shipgroup2 = GROUP:FindByName("Cuban Tanker 1"):IsAlive()
  mainmission.shipgroup3 = GROUP:FindByName("Kuznetsov Group"):IsAlive()
  --[[Shiraz:Save(savepath,"Shiraz.txt")
  Kish:Save(savepath,"Kish.txt")
  Kerman:Save(savepath,"Kerman.txt")
  Bandar:Save(savepath,"Bandar.txt")
  Tunb:Save(savepath,"Tunb.txt")]]
end

SCHEDULER:New( nil, function()
if init == true then
  updatevalues()
  reinforce()
  save()
else
  env.info("MainMission: init was not true not saving")
end
end, {}, 60, SaveSchedulePersistence)