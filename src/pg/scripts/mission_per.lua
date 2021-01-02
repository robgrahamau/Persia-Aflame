reinforhrs = 7
reinformins = 0
minreinf = 2
maxreinf = 14
reinforcements = ((60 * 60) * reinforhrs) + (60 * reinformins) 
dsqnsize = 24
dsqnlsize = 32
dsqnssize = 18
dsqnvssize = 8
newsmallsize = 6
newlargesize = 12
usenew = true

local SaveSchedulePersistence=300 


mainmission = { 
  ["i30th"] = 12,
  ["i30th_1"] = 12,
  ["i30th_2"] = 12,
  ["i25th"] = 12,
  ["i25th_1"] = 12,
  ["i26th"] = 12,
  ["i01st"] = 12,
  ["i02nd"] = 12,
  ["i03rd"] = 12,
  ["i31st"] = 12,
  ["i32nd"] = 12,
  ["i33rd"] = 12,
  ["i33rd_1"] = 6,
  ["i33rd_2"] = 6,
  ["i91st"] = 12,
  ["i91st_1"] = 6,
  ["cap1"] = 16,
  ["cap2"] = 16,
  ["cap3"] = 16,
  ["cap4"] = 16,
  ["cap5"] = 24,
  ["cap6"] = 24,
  ["cv5alert"] = 12,
  ["cv6alert"] = 12,
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
  ['SoldierUnitID'] = 12000,
  ['SoldierGroupID'] = 12000,
  ['bandarspawn'] = false,
  ['tunbspawn'] = false,
  ['sirrispawn'] = false,
  ['lavanspawn'] = false,
  ['khasabspawn'] = false,
  ['larsspawn'] = false,
  ['kishspawn'] = false,
  ['qeshmspawn'] = false,
  ['abunspawn'] = false,
  ['havspawn'] = false,
  ['bandarlspawn'] = false,
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
  if usenew == true then
    BASE:E({"Loading in values from mainmission to new sqns"})
	HypeMan.sendBotMessage("Now loading main mission persistence data")
    i30th:SetSqnCount(mainmission.i30th)
    i30th_1:SetSqnCount(mainmission.i30th_1)
    i30th_2:SetSqnCount(mainmission.i30th_2)
    BASE:E({"30th Done"})
    i25th:SetSqnCount(mainmission.i25th)
    i25th_1:SetSqnCount(mainmission.i25th_1)
    BASE:E({"25th done"})
    i26th:SetSqnCount(mainmission.i26th)
    BASE:E({"26 done"})
    i01st:SetSqnCount(mainmission.i01st)
    i02nd:SetSqnCount(mainmission.i02nd)
    i03rd:SetSqnCount(mainmission.i03rd)
    BASE:E({"01st done"})
    i31st:SetSqnCount(mainmission.i31st)
    i32nd:SetSqnCount(mainmission.i32nd)
    i33rd:SetSqnCount(mainmission.i33rd)
    BASE:E({"31st done"})
    i33rd_1:SetSqnCount(mainmission.i33rd_1)
    i33rd_2:SetSqnCount(mainmission.i33rd_2)
    BASE:E({"33rd done"})
    i91st:SetSqnCount(mainmission.i91st)
    i91st_1:SetSqnCount(mainmission.i91st_1)
    BASE:E({"91st done"})
    cap1:SetSqnCount(mainmission.cap1)
    cap2:SetSqnCount(mainmission.cap2)
    cap3:SetSqnCount(mainmission.cap3)
    cap4:SetSqnCount(mainmission.cap4)
    cap5:SetSqnCount(mainmission.cap5)
    cap6:SetSqnCount(mainmission.cap6)
    BASE:E({"cap done"})
    cv5alert:SetSqnCount(mainmission.cv5alert)
    cv6alert:SetSqnCount(mainmission.cv6alert)
    BASE:E({"new sqns done"})
  else
    BASE:E({"Loading old"})
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
  end  
  if mainmission.ships == nil then
    mainmission.shipgroup1 = true
    mainmission.shipgroup2 = true
    mainmission.shipgroup3 = true
    mainmission.ships = true
  end
  if mainmission.shipgroup2 == true then
    local temp = GROUP:FindByName("Cuban Tanker 1"):Activate()
  end
  if mainmission.shipgroup1 == true then
    local temp = GROUP:FindByName("Kuznetsov Group"):Activate()
  end
  mainmission.shipgroup3 = false
  if mainmission.SoldierUnitID == nil then
	BASE:E({"SoldierUnitID was nil"})
	SoldierGroupID = 12000
	SoldierUnitID = 12000
 else 
	SoldierUnitID = mainmission.SoldierUnitID
	SoldierGroupID = mainmission.SoldierGroupID
  end
  if mainmission.bandarspawn == nil then
	bandarspawn = false
	tunbspawn = false
	sirrispawn = false
	lavanspawn = false
	khasabspawn = false
	larsspawn = false
	kishspawn = false
	qeshmspawn = false
	abunspawn = false
	havspawn = false
	bandarlspawn = false
  else
	bandarspawn = mainmission.bandarlspawn
	tunbspawn = mainmission.tunbspawn
	sirrispawn = mainmission.sirrispawn
	lavanspawn = mainmission.lavanspawn
	khasabspawn = mainmission.khasabspawn
	larsspawn = mainmission.larsspawn
	kishspawn = mainmission.kishspawn
	qeshmspawn = mainmission.qeshmspawn
	abunspawn = mainmission.abunspawn
	havspawn = mainmission.havspawn
	bandarlspawn = mainmission.bandarlspawn
  end
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
    init = true
end


function save()
  env.info("FORCE DATA Data SAVE!!!!!!!!!!.")
  newMissionStr = IntegratedserializeWithCycles("mainmission",mainmission) --save the Table as a serialised type with key SaveUnits
  writemission(newMissionStr, savefile)--write the file from the above to SaveUnits.lua
  env.info("Data saved.")
end

function logoutput(s,o,c)
  BASE:E({"Reinforcements : Sqn group:" .. s .. " Had:" .. o .. ", now has:" .. c .. ""})
end

function updatesqn(s,size,am,mm)
  if s:GetSqnCount() < size then
    local a = math.random(2,am)
    local c = s:GetSqnCount()
    if c < 0 then 
      c = 0
    end
    local o = c
    c = c + a
    mm = c
    s:SetSqnCount(c)
    logoutput(s.sqnname,o,c)
  end
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
      if usenew == true then
        BASE:E({"Updating New SQNS"})
        updatesqn(cap1,16,8,mainmission.cap1)
        updatesqn(cap2,16,8,mainmission.cap2)
        updatesqn(cap3,16,8,mainmission.cap3)        
        updatesqn(cap4,16,8,mainmission.cap4)
        updatesqn(cap5,24,12,mainmission.cap5)        
        updatesqn(cap6,24,12,mainmission.cap6)
        updatesqn(cv5alert,12,6,mainmission.cv5alert)
        updatesqn(cv6alert,12,6,mainmission.cv6alert)
        local ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Shiraz_International_Airport)
        local col = ABItem:GetCoalition()
        if col == 1 then
          updatesqn(i30th,12,6,mainmission.i30th)
          updatesqn(i30th_1,12,6,mainmission.i30th_1)
          updatesqn(i30th_2,12,6,mainmission.i30th_2)
          updatesqn(i25th,12,6,mainmission.i25th)
          updatesqn(i25th_1,12,6,mainmission.i25th_1)
          updatesqn(i26th,12,6,mainmission.i26th)       
        else
          BASE:E({"Reinforcements Shiraz Not Held by Red"})
        end
        ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Kerman_Airport)
        col = ABItem:GetCoalition()
        if col == 1 then
          updatesqn(i01st,12,6,mainmission.i01st)
          updatesqn(i02nd,12,6,mainmission.i02nd)
          updatesqn(i03rd,12,6,mainmission.i03rd)      
        else
          BASE:E({"Reinforcements Kerman not held by Red"})
        end
        ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl)
        col = ABItem:GetCoalition()
        if col == 1 then
          updatesqn(i31st,12,6,mainmission.i31st)
          updatesqn(i32nd,12,6,mainmission.i32nd)
          updatesqn(i33rd,12,6,mainmission.i33rd)      
          updatesqn(i33rd_2,12,6,mainmission.i33rd_2)      
        else
          BASE:E({"Reinforcements Bandar not held by Red"})
        end
        ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Havadarya)
        col = ABItem:GetCoalition()
        if col == 1 then
          updatesqn(i33rd_1,12,6,mainmission.i33rd_1)      
        else
          BASE:E({"Reinforcements Havadarya not held by Red"})
        end
        local ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport)
        local col = ABItem:GetCoalition()
        if col == 1 then
          updatesqn(i91st,12,6,mainmission.i91st)
          updatesqn(i91st_1,12,6,mainmission.i91st_1)
        else
          BASE:E({"Reinforcements Kish not held by Red"})
        end
      else
      -- old script      
             if mainmission.Shiraz < dsqnsize then
          if mainmission.Shiraz < 0 then
            mainmission.Shiraz = 0
          end
          local newval = mainmission.Shiraz + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
          ra2disp:SetSquadron("Shiraz",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},newval)
        end
        if mainmission.Shiraz1 < dsqnsize then
          if mainmission.Shiraz1 < 0 then
            mainmission.Shiraz1 = 0
          end
          local newval = mainmission.Shiraz1 + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
          ra2disp:SetSquadron("Shiraz1",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F4_1","F4_2","SU33_1","SU33_2"},newval)
        end
        if mainmission.Shiraz2 < dsqnsize then 
          if mainmission.Shiraz2 < 0 then
            mainmission.Shiraz2 = 0
          end
          local newval = mainmission.Shiraz2 + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
          ra2disp:SetSquadron("Shiraz2",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F5_2","MIG29_2"},newval)
        end
        if mainmission.Shiraz_Int < dsqnssize then
          if mainmission.Shiraz_Int < 0 then
            mainmission.Shiraz_Int = 0
          end 
          local newval = mainmission.Shiraz_Int + math.random(minreinf,maxreinf)
          if newval > dsqnssize then
            newval = dsqnssize
          end
          ra2disp:SetSquadron("Shiraz INT",AIRBASE.PersianGulf.Shiraz_International_Airport,{"F5_1","MIG29_1","F4_2"},newval)
        end
        if mainmission.Kerman < dsqnsize then
          if mainmission.Kerman < 0 then
            mainmission.Kerman = 0
          end 
          local newval = mainmission.Kerman + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
          ra2disp:SetSquadron("Kerman",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},newval)
        end
        if mainmission.Kerman1 < dsqnsize then 
          if mainmission.Kerman1 < 0 then
            mainmission.Kerman1 = 0
          end
          local newval = mainmission.Kerman1 + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
          ra2disp:SetSquadron("Kerman1",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","JF17_1","JF17_2","M2000_1"},newval)
        end
        if mainmission.Kerman2 < dsqnsize then
          if mainmission.Kerman2 < 0 then
            mainmission.Kerman2 = 0
          end
        local newval = mainmission.Kerman2 + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
        ra2disp:SetSquadron("Kerman2",AIRBASE.PersianGulf.Kerman_Airport,{"F14_1","F14_2","M2000_1"},newval)
        end
        if mainmission.Kerman_INT < dsqnssize then
          if mainmission.Kerman_INT < 0 then
            mainmission.Kerman_INT = 0
          end 
          local newval = mainmission.Kerman_INT + math.random(minreinf,maxreinf)
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
          local newval = mainmission.Bandar_Abbas + math.random(minreinf,maxreinf)
          if newval > dsqnsize then
            newval = dsqnsize
          end
          ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},newval)
        end
        if (mainmission.Bandar_Abbas2 < dsqnsize) and (coalition == 1) then
          if mainmission.Bandar_Abbas2 < 0 then
            mainmission.Bandar_Abbas2 = 0
          end  
          local newval = mainmission.Bandar_Abbas2 + math.random(minreinf,maxreinf)
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
          local newval = mainmission.Bandar_Abbas_INT + math.random(minreinf,maxreinf)
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
      local newval = mainmission.Kish + math.random(minreinf,maxreinf)
      if newval > dsqnssize then
        newval = dsqnssize 
      end
      ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},mainmission.Kish)
    end
    if (mainmission.Kish_INT < dsqnvssize) and (coalition == 1) then
      if mainmission.Kish_INT < 0 then
          mainmission.Kish_INT = 0
      end 
      local newval = mainmission.Kish_INT + math.random(minreinf,maxreinf)
      if newval > dsqnvssize then
        newval = dsqnvssize
      end
      ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},newval)
    end
    if mainmission.Kuznetsov_INT < dsqnlsize then
      if mainmission.Kuznetsov_INT < 0 then
          mainmission.Kuznetsov_INT = 0
        end 
      
      local newval = mainmission.Kuznetsov_INT + math.random(minreinf,maxreinf)
      if newval > dsqnlsize then 
        newval = dsqnlsize 
      end
      ra2disp:SetSquadron("Kuznetsov INT","Kuznetsov",{"SU33_1","SU33_2"},newval)
    end
   if mainmission.Stennis < 18 then
  if mainmission.Stennis < 0 then
          mainmission.Stennis = 0
    end 
    local newval = mainmission.Stennis + math.random(minreinf,maxreinf)
    if newval > 18 then
      newval = 18
    end
     ba2disp:SetSquadron("Stennis","Stennis",BCarrierTEMP,newval)
   end
   if mainmission.TeddyR < 18 then
    if mainmission.TeddyR < 0 then
          mainmission.TeddyR = 0
        end 
    local newval = mainmission.TeddyR + math.random(minreinf,maxreinf)
    if newval > 18 then
      newval = 18 
    end
    ba2disp:SetSquadron("TeddyR","TeddyR",BCarrierTEMP,newval)
    end
     if mainmission.Al_Dhafra < 32 then
      if mainmission.Al_Dhafra < 0 then
        mainmission.Al_Dhafra = 0
      end 
      local newval = mainmission.Al_Dhafra + math.random(minreinf,maxreinf)
      if newval > 32 then
        newval = 32
      end
      ba2disp:SetSquadron("Al Draf",AIRBASE.PersianGulf.Al_Dhafra_AB,BLandTemp,newval)
    end
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
  if usenew == true then
    BASE:E({"SHould be updating Main Mission Now"})
    mainmission.cap1 = cap1:GetSqnCount()
    mainmission.cap2 = cap2:GetSqnCount()
    mainmission.cap3 = cap3:GetSqnCount()
    mainmission.cap4 = cap4:GetSqnCount()
    mainmission.cap5 = cap5:GetSqnCount()
    mainmission.cap6 = cap6:GetSqnCount()
    mainmission.cv5alert = cv5alert:GetSqnCount()
    mainmission.cv6alert = cv6alert:GetSqnCount()
    BASE:E({"Updating New SQNS - Red"})
    mainmission.i01st = i01st:GetSqnCount()
    mainmission.i02nd = i02nd:GetSqnCount()
    mainmission.i30th = i30th:GetSqnCount()
    mainmission.i30th_1 = i30th_1:GetSqnCount()
    mainmission.i30th_2 = i30th_2:GetSqnCount()
    mainmission.i25th = i25th:GetSqnCount()
    mainmission.i25th_1 = i25th_1:GetSqnCount()
    mainmission.i26th = i26th:GetSqnCount()
    mainmission.i03rd = i03rd:GetSqnCount()
    mainmission.i31st = i31st:GetSqnCount()
    mainmission.i32nd = i32nd:GetSqnCount()
    mainmission.i33rd = i33rd:GetSqnCount()
    mainmission.i33rd_1 = i33rd_1:GetSqnCount()
    mainmission.i33rd_2 = i33rd_2:GetSqnCount()
    mainmission.i91st = i91st:GetSqnCount()
    mainmission.i91st_1 = i91st_1:GetSqnCount()
  else
  BASE:E({"SHould be updating Main Mission Now"})
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
  end
  BASE:E({"SHould be updating Main Mission Now that aren't part of the sqns"})
  mainmission.shipgroup1 = false
  if GROUP:FindByName("Cuban Tanker 1"):IsAlive() == true then
  mainmission.shipgroup2 = GROUP:FindByName("Cuban Tanker 1"):IsAlive()
  else
  mainmission.shipgroup2 = false
  end
  if GROUP:FindByName("Kuznetsov Group"):IsAlive() == true then
  mainmission.shipgroup1 = GROUP:FindByName("Kuznetsov Group"):IsAlive()
  else
  mainmission.shipgroup1 = false
  end
  mainmission.SoldierGroupID = SoldierGroupID
  mainmission.SoldierUnitID = SoldierUnitID
  
  mainmission.bandarlspawn = bandarspawn
  mainmission.tunbspawn = tunbspawn 
  mainmission.sirrispawn = sirrispawn
  mainmission.lavanspawn = lavanspawn
  mainmission.khasabspawn = khasabspawn
  mainmission.larsspawn = larsspawn
  mainmission.kishspawn = kishspawn
  mainmission.qeshmspawn = qeshmspawn
  mainmission.abunspawn = abunspawn
  mainmission.havspawn = havspawn
  mainmission.bandarlspawn = bandarlspawn
  
  BASE:E({"Values updated"})
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