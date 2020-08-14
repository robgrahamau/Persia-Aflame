BASE:E({"STARTING ATO SYSTEM FOR REDCOMMAND."})


evh = EVENTHANDLER:New()
evh:HandleEvent(EVENTS.BaseCaptured)

local AbLar= 1
local AbKish = 1 
local AbShiraz = 1 
local AbKerman = 1
local AbBandar = 1
local AbTunb = 1

Z_CAP1 = ZONE_POLYGON:NewFromGroupName("CAP1") -- SW Central (CZ2)
Z_CAP2 = ZONE_POLYGON:NewFromGroupName("CAP2") -- CENTRAL (CZ1)
Z_CAP3 = ZONE_POLYGON:NewFromGroupName("CAP3") -- EAST CENTRAL (CZ3)
Z_CAP4 = ZONE_POLYGON:NewFromGroupName("CAP4") -- OCEAN WEST (CZ2)
Z_CAP5 = ZONE_POLYGON:NewFromGroupName("CAP5") -- OCEAN SWEST (CZ1
Z_CAP6 = ZONE_POLYGON:NewFromGroupName("CAP6") -- OCEAN BANDAR (CZ1)
Z_CAP7 = ZONE_POLYGON:NewFromGroupName("CAP7") -- EASTERN CZ3
CZ1 = ZONE:New("CZ1")
CZ2 = ZONE:New("CZ2")
CZ3 = ZONE:New("CZ3")
CZ4 = ZONE:New("CZ4")
Z_SADZ = ZONE:New("Shiraz_ADZ")
Z_KADZ = ZONE:New("Kerman_ADZ")
Z_RAS = ZONE_POLYGON:NewFromGroupName("RAS")
Z_TNKR1 = ZONE:New("TNKR1")
Z_TNKR2 = ZONE:New("TNKR2")
Z_AWACS1 = ZONE:New("AWACS1")
Z_AWACS2 = ZONE:New("AWACS2")
Z_AWACS3 = ZONE:New("AWACS3")
Z_AWACS4 = ZONE:New("AWACS4")

U_AWACS1 = nil
U_AWACS2 = nil

lastawacs = 0
I24 = SQUADRON:New("IRAF24TH",12,"Irani Airforce 24th Sqn") -- f4's
I24:SetSkill(AI.Skill.HIGH)
I24:SetRadio(270)
I24:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
I24:AddMissonCapability({AUFTRAG.Type.CAP},100)
I24:SetEngagementRange(200)

I25 = SQUADRON:New("IRAF25TH",12,"Irani Airforce 25th Sqn") -- f4's
I25:SetSkill(AI.Skill.HIGH)
I25:SetRadio(270)
I25:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
I25:AddMissonCapability({AUFTRAG.Type.CAP},100)
I25:SetEngagementRange(250)

I26 = SQUADRON:New("IRAF25TH",12,"Irani Airforce 25th Sqn") -- f5's
I26:SetSkill(AI.Skill.GOOD)
I26:SetRadio(270)
I26:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.CAP,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},70)
I26:SetEngagementRange(250)

I30 = SQUADRON:New("IRAF30th",12,"Irani Airforce 30th Sqn") -- MIG29's
I30:SetSkill(AI.Skill.HIGH)
I30:SetRadio(270)
I30:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.CAP,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
I30:SetEngagementRange(350)

I31 = SQUADRON:New("IRAF31th",12,"Irani Airforce 31st Sqn") -- MIG29's
I31:SetSkill(AI.Skill.HIGH)
I31:SetRadio(270)
I31:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.CAP,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
I31:SetEngagementRange(350)

I32 = SQUADRON:New("IRAF32nd",12,"Irani Airforce 32nd Sqn") -- f4's
I32:SetSkill(AI.Skill.HIGH)
I32:SetRadio(270)
I32:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
I32:AddMissonCapability({AUFTRAG.Type.CAP},100)
I32:SetEngagementRange(250)

I33 = SQUADRON:New("IRAF33rd",12,"Irani Airforce 33rd Sqn") -- mig21s
I33:SetSkill(AI.Skill.HIGH)
I33:SetRadio(270)
I33:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
I33:AddMissonCapability({AUFTRAG.Type.CAP},100)
I33:AddMissonCapability({AUFTRAG.Type.STRIKE,AUFTRAG.Type.BAI,AUFTRAG.Type.CAS},50)
I33:SetEngagementRange(250)


I39 = SQUADRON:New("IRAF39th",12,"Irani Airforce 39th Sqn") -- mig21s
I39:SetSkill(AI.Skill.HIGH)
I39:SetRadio(270)
I39:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},80)
I39:AddMissonCapability({AUFTRAG.Type.CAP},100)
I39:AddMissonCapability({AUFTRAG.Type.STRIKE,AUFTRAG.Type.BAI,AUFTRAG.Type.CAS},50)
I39:SetEngagementRange(250)

I91 = SQUADRON:New("IRAF91",24,"Irani Airforce 91st Sqn Kish") -- m2000
I91:SetSkill(AI.Skill.HIGH)
I91:SetRadio(270)
I91:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT},100)
I91:AddMissonCapability({AUFTRAG.Type.CAP,AUFTRAG.Type.ESCORT},100)
I91:SetEngagementRange(200)

I01 = SQUADRON:New("IRAF01",14,"Irani Airforce 1st Sqn Kerman") -- F14
I01:SetSkill(AI.Skill.EXCELLENT)
I01:SetRadio(270)
I01:AddMissonCapability({AUFTRAG.Type.ESCORT,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.CAP},100)
I01:SetEngagementRange(350)

I02 = SQUADRON:New("P01",8,"Pakistani Airforce 2nd Sqn Kerman") -- JF17
I02:SetSkill(AI.Skill.EXCELLENT)
I02:SetRadio(270)
I02:AddMissonCapability({AUFTRAG.Type.CAP},100)
I02:AddMissonCapability({AUFTRAG.Type.ESCORT,AUFTRAG.Type.INTERCEPT,50})
I02:AddMissonCapability({AUFTRAG.Type.SEAD,AUFTRAG.Type.ANTISHIP,100})
I02:SetEngagementRange(350)

I03 = SQUADRON:New("SSCV-1",8,"Pakistani Airforce 3rd Sqn Shiraz") -- JF17
I03:SetSkill(AI.Skill.EXCELLENT)
I03:SetRadio(270)
I03:AddMissonCapability({AUFTRAG.Type.CAP},100)
I03:AddMissonCapability({AUFTRAG.Type.ESCORT,AUFTRAG.Type.INTERCEPT,50})
I03:AddMissonCapability({AUFTRAG.Type.SEAD,AUFTRAG.Type.ANTISHIP,100})
I03:SetEngagementRange(350)

I51 = SQUADRON:New("I51",18,"Irani Airforce 51st Sqn Kerman") -- MIG21
I51:SetSkill(AI.Skill.EXCELLENT)
I51:SetRadio(270)
I51:AddMissonCapability({AUFTRAG.Type.ESCORT,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.CAP},100)
I51:AddMissonCapability({AUFTRAG.Type.STRIKE,AUFTRAG.Type.BAI,AUFTRAG.Type.CAS},50)
I51:SetEngagementRange(350)



P101 = SQUADRON:New("P101",4,"Pakistani Airforce 101st Sqn Kerman") -- F16
P101:SetSkill(AI.Skill.EXCELLENT)
P101:SetRadio(270)
P101:AddMissonCapability({AUFTRAG.Type.ESCORT,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.CAP},100)
P101:AddMissonCapability({AUFTRAG.Type.STRIKE,AUFTRAG.Type.BAI,AUFTRAG.Type.CAS},80)
P101:SetEngagementRange(300)


H01 = SQUADRON:New("IranAH1",12,"Kish Attack Sqn") -- Kish Helicopter Squad
H01:SetSkill(AI.Skill.HIGH)
H01:SetRadio(270)
H01:AddMissonCapability({AUFTRAG.Type.CAS,AUFTRAG.Type.BAI},100)
H01:SetEngagementRange(200)

H02 = SQUADRON:New("IranAH2",8,"Tunb Attack Sqn")
H02:SetSkill(AI.Skill.HIGH)
H02:SetRadio(270)
H02:AddMissonCapability({AUFTRAG.Type.CAS,AUFTRAG.Type.BAI},100)
H02:SetEngagementRange(200)

H03 = SQUADRON:New("IranAH3",12,"Bandar Attack Sqn")
H03:SetSkill(AI.Skill.HIGH)
H03:SetRadio(270)
H03:AddMissonCapability({AUFTRAG.Type.CAS,AUFTRAG.Type.BAI},100)
H03:SetEngagementRange(200)

S01 = SQUADRON:New("Strikers",16,"Shiraz Strikers") -- SU-24's 
S01:SetSkill(AI.Skill.HIGH)
S01:SetRadio(270)
S01:AddMissonCapability({AUFTRAG.Type.CAS,AUFTRAG.Type.BAI,AUFTRAG.Type.SEAD,AUFTRAG.Type.BOMBING,AUFTRAG.Type.STRIKE},100)
S01:SetEngagementRange(350)


T1 = SQUADRON:New("Texaco11",4,"Irani Tanker Support")
T1:SetSkill(AI.Skill.EXCELLENT)
T1:SetRadio(250)
T1:SetCallsign(CALLSIGN.Tanker.Texaco,1)
T1:AddMissonCapability({AUFTRAG.Type.TANKER},100)
T1:SetEngagementRange(400)

A1 = SQUADRON:New("AWAC Overlord11",4,"AWAC Shiraz")
A1:SetSkill(AI.Skill.EXCELLENT)
A1:SetRadio(251)
A1:SetCallsign(CALLSIGN.AWACS.Darkstar,1)
A1:AddMissonCapability({AUFTRAG.Type.AWACS},100)
A1:SetEngagementRange(400)

A2 = SQUADRON:New("AWAC Overlord21",4,"AWAC Kerman")
A2:SetSkill(AI.Skill.EXCELLENT)
A2:SetRadio(252)
A2:SetCallsign(CALLSIGN.AWACS.Overlord,1)
A2:AddMissonCapability({AUFTRAG.Type.AWACS},100)
A2:SetEngagementRange(400)

k279 = SQUADRON:New("K279",16,"Russian 279th Kiap Sqn") -- SU33
k279:SetSkill(AI.Skill.EXCELLENT)
k279:SetRadio(270)
k279:AddMissonCapability({AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT},100)
k279:AddMissonCapability({AUFTRAG.Type.CAP},100)
k279:SetEngagementRange(350)



Lar=AIRWING:New("Lars Warehouse","Lars ADZ")
Kish = AIRWING:New("Kish Warehouse","Kish ADZ")
Shiraz = AIRWING:New("Shiraz Warehouse","Shiraz ADZ")
Kerman = AIRWING:New("Kerman Warehouse","Kerman ADZ")
Bandar = AIRWING:New("Bandar Warehouse","Bandar ADZ")
Tunb = AIRWING:New("Tunb Warehouse","Tunb ADZ")




Kerman:SetReportOff()
Lar:SetReportOff()
Shiraz:SetReportOff()
Kish:SetReportOff()
Bandar:SetReportOff()
Tunb:SetReportOff()
Lar:AddSquadron(I24) -- f4
Kish:AddSquadron(I91) -- m2000
Kish:AddSquadron(I39) -- mig29
Kish:AddSquadron(H01) -- ah1
Shiraz:AddSquadron(k279) -- su33
Shiraz:AddSquadron(I25) -- f4
Shiraz:AddSquadron(I26) -- f5
Shiraz:AddSquadron(I30) -- mig29
Shiraz:AddSquadron(I03) -- JF17
Shiraz:AddSquadron(T1) -- KC135
Shiraz:AddSquadron(A1) -- E3
Shiraz:AddSquadron(S01) -- SU24
Kerman:AddSquadron(A2) -- E3
Kerman:AddSquadron(I01) -- F14
Kerman:AddSquadron(I02) -- Jf17
Kerman:AddSquadron(I51) -- MIG21
Kerman:AddSquadron(P101) -- F16
Bandar:AddSquadron(I31) -- MIG29
Bandar:AddSquadron(I32) -- F4
Bandar:AddSquadron(I33) -- MIG21
Bandar:AddSquadron(H03) -- AH1
Tunb:AddSquadron(H02) -- AH1


function redairreinforcements()
  BASE:E({"Red Airbase Reinforcements by Aircraft Type"})
  local jf17 = math.random(1,6)
  local f14 = math.random(1,2)
  local f16 = math.random(1,4)
  local mig29 = math.random(1,16)
  local f4 = math.random(1,8)
  local f5 = math.random(1,4)
  local mig21 = math.random(1,16)
  local su24 = math.random(1,8)
  local e3 = math.random(1,2)
  local kc135 = math.random(1,2)
  local ah1 = math.random(3,12)
  local su33 = math.random(2,8)
  BASE:E({"Red Has been Sent the Following:",jf17,f14,f16,mig29,f4,f5,mig21,su24,e3,kc135,ah1})

  local ah1a = 0
  local f4a = 0
  local f5a = 0
  local jf17a = 0
  local f14a = 0
  local f16a = 0
  local mig29a = 0
  local mig21a = 0
  local su24a = 0
  local su33a = 0
  local e3a = 0
  local kc135a = 0

      
  if Kish:GetCoalition() == 1 then
    ah1a = ah1a + 1
    mig21 = mig21 + 1
  end
  if Bandar:GetCoalition() == 1 then
    ah1a = ah1a + 1
    f4a = f4a + 1
    mig29a = mig29a + 1
    mig21a = mig21a + 1
  end
  if Tunb:GetCoalition() == 1 then
    ah1a = ah1a + 1
  end
  if Lar:GetCoalition() == 1 then
    f4a = f4a + 1
  end
  if Shiraz:GetCoalition() == 1 then
    su33a = su33a + 1
    f4a = f4a + 1 
    f5a = f5a + 1
    mig29a = mig29a + 1
    kc135a = kc135a + 1
    e3a = e3a + 1 
    su24a = su24a + 1
    jf17a = jf17a + 1
    f16a = f16a+1
  end
  if Kerman:GetCoalition() == 1 then
    e3a = e3a + 1 
    jf17a = jf17a + 1
    f14a = f14a + 1
    mig21 = mig21 + 1 
  end
  BASE:E({"Reinforcing...."})  
  if (ah1 ~= 0) and (ah1a ~= 0) then
  local distrib = math.ceil((ah1/ah1a))
  BASE:E({"We have ".. ah1a .. " ab's and each AB will get ".. distrib .."AH1's"})
  if Kish:GetCoalition() == 1 then
    Kish:AddAssetToSquadron(H01,distrib)
  end
  if Tunb:GetCoalition() == 1 then
    Tunb:AddAssetToSquadron(H02,distrib)
  end
  if Bandar:GetCoalition() == 1 then
    Bandar:AddAssetToSquadron(H03,distrib)
  end
  end
  if (f4 ~= 0) and (f4a ~= 0) then
  distrib = math.ceil((f4/f4a))
  BASE:E({"We have ".. f4a .. " ab's and each AB will get ".. distrib .."f4's"})
  if distrib ~= 0 then
    if Bandar:GetCoalition() == 1 then
      Bandar:AddAssetToSquadron(I32,distrib)
    end
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(I25,distrib)
    end
    if Lar:GetCoalition() == 1 then
      Lar:AddAssetToSquadron(I24,distrib)
    end
  end
  end
  
  if (f5 ~= 0) and (f5a ~= 0) then
  distrib = math.ceil((f5/f5a))
  BASE:E({"We have ".. f5a .. " ab's and each AB will get ".. distrib .." f5's"})
  if distrib ~= 0 then
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(I26,distrib)
    end
  end
  end
  
  if (f14 ~= 0) and (f14a ~= 0) then
  distrib = math.ceil((f14/f14a))
  BASE:E({"We have ".. f14a .. " ab's and each AB will get ".. distrib .." f14's"})
  if distrib ~= 0 then
    if Kerman:GetCoalition() == 1 then
      Kerman:AddAssetToSquadron(I01,distrib)
    end
  end
  end
  if (f16 ~= 0) and (f16a ~= 0) then
  distrib = math.ceil((f16/f16a))
  BASE:E({"We have ".. f16a .. " ab's and each AB will get ".. distrib .." f16's"})
  if distrib ~= 0 then
    if Kerman:GetCoalition() == 1 then
      Kerman:AddAssetToSquadron(P101,distrib)
    end
  end
  end
  
    
  if (jf17 ~= 0) and (jf17a ~= 0) then
  distrib = math.ceil((jf17/jf17a))
  BASE:E({"We have ".. jf17a .. " ab's and each AB will get ".. distrib .." jf17's"})
  if distrib ~= 0 then
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(I03,distrib)
    end
    if Kerman:GetCoalition() == 1 then
      Kerman:AddAssetToSquadron(I02,distrib)
    end
  end
  end
  
  if (mig21 ~= 0) and (mig21a ~= 0) then
  distrib = math.ceil((mig21/mig21a))
  BASE:E({"We have ".. mig21a .. " ab's and each AB will get ".. distrib .." mig21's"})
  if distrib ~= 0 then
    if Bandar:GetCoalition() == 1 then
      Bandar:AddAssetToSquadron(I33,distrib)
    end
    if Kerman:GetCoalition() == 1 then
      Kerman:AddAssetToSquadron(I51,distrib)
    end
    if Kish:GetCoalition() == 1 then
      Kish:AddAssetToSquadron(I39,distrib)
    end
  end
  end
  
  if (mig29 ~= 0) and (mig29a ~= 0) then
  distrib = math.ceil((mig29/mig29a))
  BASE:E({"We have ".. mig29a .. " ab's and each AB will get ".. distrib .." mig29's"})
  if distrib ~= 0 then
    if Bandar:GetCoalition() == 1 then
      Bandar:AddAssetToSquadron(I31,distrib)
    end
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(I30,distrib)
    end
  end
  end
  
  if (su24 ~= 0) and (su24a ~= 0) then
  distrib = math.ceil((su24/su24a))
  BASE:E({"We have ".. su24a .. " ab's and each AB will get ".. distrib .." su24's"})
  if distrib ~= 0 then
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(S01,distrib)
    end
  end
  end
  
  if (su33 ~= 0) and (su33a ~= 0) then
  distrib = math.ceil((su33/su33a))
  BASE:E({"We have ".. su33a .. " ab's and each AB will get ".. distrib .." su33's"})
  if distrib ~= 0 then
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(k279,distrib)
    end
  end
  end
  
  if (e3 ~= 0) and (e3a ~= 0) then
    distrib = math.ceil((e3/e3a))
  BASE:E({"We have ".. e3 .. " ab's and each AB will get ".. distrib .." E3's"})
  if distrib ~= 0 then
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(A1,distrib)
    end
    if Kerman:GetCoalition() == 1 then
      Kerman:AddAssetToSquadron(A2,distrib)
    end
  end
  end
  
  if (kc135 ~= 0) and (kc135a ~= 0) then
  distrib = math.ceil((kc135/kc135a))
  BASE:E({"We have ".. kc135a .. " ab's and each AB will get ".. distrib .." kc135's"})
  if distrib ~= 0 then
    if Shiraz:GetCoalition() == 1 then
      Shiraz:AddAssetToSquadron(T1,distrib)
    end
  end
  end
  BASE:E({"RED REINFORCEMENT HAS BEEN COMPLETED"})
end
local SU24 = Shiraz:NewPayload("SU-24MSead",99,{AUFTRAG.Type.SEAD},100)
SU24 = Shiraz:NewPayload("SU-24MStrike",99,{AUFTRAG.Type.STRIKE,AUFTRAG.Type.BOMBING},100)
local F4Cap = Lar:NewPayload("F4_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL},100)
F4Cap = Lar:NewPayload("F4_2",99,{AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.PATROL},80)
F4Cap = Shiraz:NewPayload("F4_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL},100)
F4Cap = Shiraz:NewPayload("F4_2",99,{AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.PATROL},80)
F4Cap = Bandar:NewPayload("F4_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL},100)
F4Cap = Bandar:NewPayload("F4_2",99,{AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.PATROL},80)
local F5cap = Shiraz:NewPayload("F5_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL, AUFTRAG.Type.INTERCEPT},100)
F5cap = Shiraz:NewPayload("F5_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL, AUFTRAG.Type.INTERCEPT},100)
local M200Cap = Kish:NewPayload("M2000_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT},100)
M200Cap = Kish:NewPayload("M2000_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT},70)
local mig29cap = Shiraz:NewPayload("MIG29_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
mig29cap = Shiraz:NewPayload("MIG29_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
mig29cap = Shiraz:NewPayload("MIG29_3",99,{AUFTRAG.Type.STRIKE,AUFTRAG.Type.BAI},50)
mig29cap = Bandar:NewPayload("MIG29_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
mig29cap = Bandar:NewPayload("MIG29_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
mig29cap = Bandar:NewPayload("MIG29_3",99,{AUFTRAG.Type.STRIKE,AUFTRAG.Type.BAI},50)
local su33cap = Shiraz:NewPayload("SU33_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
su33cap = Shiraz:NewPayload("SU33_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
local JF17 = Kerman:NewPayload("JF17_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
JF17 = Kerman:NewPayload("JF17_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
JF17 = Kerman:NewPayload("JF17_3",99,{AUFTRAG.Type.SEAD},100)
JF17 = Kerman:NewPayload("JF17_3",99,{AUFTRAG.Type.STRIKE},100)
JF17 = Kerman:NewPayload("JF17_4",99,{AUFTRAG.Type.ANTISHIP},100)
JF17 = Shiraz:NewPayload("JF17_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
JF17 = Shiraz:NewPayload("JF17_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
JF17 = Shiraz:NewPayload("JF17_3",99,{AUFTRAG.Type.SEAD},100)
JF17 = Shiraz:NewPayload("JF17_3",99,{AUFTRAG.Type.STRIKE},100)
JF17 = Shiraz:NewPayload("JF17_4",99,{AUFTRAG.Type.ANTISHIP},100)
local F16 = Kerman:NewPayload("P101 BAI",66,{AUFTRAG.Type.BAI,AUFTRAG.Type.STRIKE,AUFTRAG.Type.CAS},100)
local F14 = Kerman:NewPayload("F14_1",66,{AUFTRAG.Type.CAP,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
F14 = Kerman:NewPayload("F14_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
local MIG21 = Kerman:NewPayload("MIG21_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
MIG21 = Kerman:NewPayload("MIG21_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
MIG21 = Kerman:NewPayload("MIG21_3",99,{AUFTRAG.Type.BAI,AUFTRAG.Type.STRIKE,AUFTRAG.Type.CAS},50)
MIG21 = Bandar:NewPayload("MIG21_1",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
MIG21 = Bandar:NewPayload("MIG21_2",99,{AUFTRAG.Type.CAP,AUFTRAG.Type.PATROL,AUFTRAG.Type.INTERCEPT,AUFTRAG.Type.ESCORT},100)
MIG21 = Bandar:NewPayload("MIG21_3",99,{AUFTRAG.Type.BAI,AUFTRAG.Type.STRIKE,AUFTRAG.Type.CAS},50)
Lar:Start()
Shiraz:Start()
Kish:Start()
Kerman:Start()
Bandar:Start()
Tunb:Start()

   
rlooksee = SET_GROUP:New():FilterCoalitions("red"):FilterActive():FilterStart()
local RedAgentSet = rlooksee
local IAA = INTEL:New(RedAgentSet,coalition.side.RED)
local MADZ = INTEL:New(RedAgentSet,coalition.side.RED)

ADZZONES = SET_ZONE:New()
ADZZONES:AddZone(Z_SADZ)
ADZZONES:AddZone(Z_KADZ)
MADZ:SetAcceptZones(ADZZONES)
IAA:AddAcceptZone(Z_RAS)
IAA:Start()
MADZ:Start()

function awacsdisp(airgroup,repeats,escort,escortab)
BASE:E({"AWACSD"},airgroup)
  if airgroup:GetCoalition() == 1 then
    
    local lz = Z_AWACS1
    local rnd = math.random(1,4)
    if lastawacs ~= 0 then
    if rnd == lastawacs then
      if (rnd <= 4) and (rnd > 1) then
        rnd = rnd - 1
      else 
        rnd = rnd + 1
      end
    end
  end
  if rnd == 2 then
    lz = Z_AWACS2
  elseif rnd == 3 then
    lz = Z_AWACS3
  elseif rnd == 4 then
    lz = Z_AWACS4
  end
  lastawacs = rnd
  local awacs = AWACS(lz,airgroup,repeats,escort,escortab)
  return awacs
  else
    BASE:E({"Airgroups coalition was not Red Unable to comply",airgroup:GetCoalition()})
    return false
  end
end

function AWACS(lz,airgroup,repeats,escort,escortab)
  BASE:E({"AWACS Called"})
  local awacsfrag = AUFTRAG:NewAWACS(lz:GetRandomCoordinate(),32000,350,090,20)
  awacsfrag:SetRepeatOnFailure(repeats)
  airgroup:AddMission(awacsfrag)
  function awacsfrag:OnAfterSuccess(From,Event,To)
    awacsdisp(airgroup,repeats,escort,escortab)
  end
  function awacsfrag:OnAfterStarted(From,Event,To)
    if escort == true then
      for _,flightgroup in pairs(awacsfrag:GetOpsGroups()) do
        local escort = AUFTRAG:NewESCORT(flightgroup:GetGroup(), {x=500, y=0, z=-50},UTILS.NMToMeters(40),{"Air"})
        escortab:AddMission(escort)  
      end
    end
  end
  function awacsfrag:OnAfterFailed(From,Event,To)
    awacsdisp(airgroup,repeats,escort,escortab)
  end
  
  return awacsfrag
end


function tnkdisp(airgroup,tcn,text,repeats,rdo,escort,escortab)
  BASE:E({"tnkr Dispatcher"})
  if airgroup:GetCoalition() == 1 then
    local lz = Z_TNKR1
    if math.random(1,2) == 2 then
     lz = Z_TNKR2
    end
    local tnkr = tanker(lz,airgroup,tcn,text,repeats,rdo,escort,escortab)
    return tnkr
  else
    BASE:E({"Airgroups coalition was not Red Unable to comply",airgroup:GetCoalition()})
    return false
  end
end


function tanker(lz,airgroup,tcn,text,repeats,rdo,escort,escortab)
  local tnkrfrag = AUFTRAG:NewTANKER(lz:GetRandomCoordinate(),16000,376,math.random(0,359),50,1)
  tnkrfrag:SetRadio(rdo)
  tnkrfrag:SetTACAN(tcn,text)
  airgroup:AddMission(tnkrfrag)
  function tnkrfrag:OnAfterSuccess(From,Event,To)
    tnkdisp(airgroup,tcn,text,repeats,rdo,escort,escortab)
  end
  function tnkrfrag:OnAfterStarted(From,Event,To)
    if escort == true then
      for _,flightgroup in pairs(tnkrfrag:GetOpsGroups()) do
        local escort = AUFTRAG:NewESCORT(flightgroup:GetGroup(), {x=500, y=0, z=-50},UTILS.NMToMeters(40),{"Air"})
        escort:SetEngageRange(40)
        escortab:AddMission(escort)  

      end
    end
  end
  function tnkrfrag:onafterFailed(From,Event,To)
    tnkdisp(airgroup,tcn,text,repeats,rdo,escort,escortab)
  end
  return tnkrfrag
end

function larcapdisp()
  if Lar:GetCoalition() == 1 then
    larcap()
  else
    BASE:E({"LAR CAP UNABLE, Not Red"})
  end
end

function larcap()
    local capzone = Z_CAP2
    local ccz = CZ2
    if math.random(1,2) == 2 then
      capzone = Z_CAP5
      ccz = CZ2
    end
    larcapfrag1 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})  
    larcapfrag1:SetEngageAltitude(math.random(10000,25000))
    larcapfrag1:SetEngageRange(80)
    Lar:AddMission(larcapfrag1)
    function larcapfrag1:OnAfterSuccess(From,Event,To)
      larcapdisp()
    end
    function larcapfrag1:OnAfterFailed(From,Event,To)
          larcapdisp()
    end
end


function kercapdisp(cap)
  if Kerman:GetCoalition() == 1 then
    if cap == 1 then
      kercap()
    else
      kercap2()
    end
  else
    BASE:E({"KERMAN CAP UNABLE, Not Red"})
  end
end

function kercap()
    local capzone = Z_CAP3
    local ccz = CZ3
    if math.random(1,2) == 2 then
      capzone = Z_CAP6
      local ccz = CZ4
    end
    kercapfrag1 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    kercapfrag1:SetRequiredAssets(math.random(1,2))
    kercapfrag1:SetEngageAltitude(math.random(10000,25000))
    kercapfrag1:SetEngageRange(80)
    Kerman:AddMission(kercapfrag1)
    
    function kercapfrag1:OnAfterSuccess(From,Event,To)
      kercapdisp(1)
    end
    function kercapfrag1:OnAfterFailed(From,Event,To)
      kercapdisp(1)
    end
end

function kercap2()
    local capzone = Z_CAP3
    local ccz = CZ3
    if math.random(1,2) == 2 then
      capzone = Z_CAP6
      local ccz = CZ4
    end
    kercapfrag2 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    kercapfrag2:SetRequiredAssets(math.random(1,2))
    kercapfrag2:SetEngageAltitude(math.random(10000,25000))
    kercapfrag2:SetEngageRange(80)
    Kerman:AddMission(kercapfrag2)
    function kercapfrag2:OnAfterSuccess(From,Event,To)
      kercapdisp(2)
    end
    function kercapfrag2:OnAfterFailed(From,Event,To)
      kercapdisp(2)
    end
end

function bandcapdisp()
BASE:E({"bcapd"})
  if Bandar:GetCoalition() == 1 then
    bandcap()
  else
    BASE:E({"BANDAR CAP UNABLE, Not Red"})
  end
end
function bandcap()
BASE:E({"bandar cap"})
    local capzone = Z_CAP6
    local ccz = CZ1
    local rnd = math.random(1,3) 
    if rnd == 2 then
      capzone = Z_CAP6
      ccz = CZ4
    elseif rnd == 3 then
      capzone = Z_CAP7
      ccz = CZ3
    end
    bandcapfrag = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    bandcapfrag:SetRequiredAssets(math.random(1,2))
    bandcapfrag:SetEngageAltitude(math.random(10000,25000))
    bandcapfrag:SetEngageRange(80)
    Bandar:AddMission(bandcapfrag)
    function bandcapfrag:OnAfterSuccess(From,Event,To)
      bandcapdisp()
    end
    function bandcapfrag:OnAfterFailed(From,Event,To)
      bandcapdisp()
    end
end



function shircapdisp(cap)
  BASE:E({"shircapd"})
  if Shiraz:GetCoalition() == 1 then
    if cap == 1 then
      shircap()
    else
      shircap2()
    end
  else
   BASE:E({"SHIRAZ CAP UNABLE, Not Red"})
  end
end

function shircap()
BASE:E({"shircap"})
    local capzone = Z_CAP1
    local ccz = CZ1
    if math.random(1,2) == 2 then
      capzone = Z_CAP4
      local ccz = CZ1
    end
    shircapfrag1 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    shircapfrag1:SetRequiredAssets(math.random(1,2))
    shircapfrag1:SetEngageAltitude(math.random(10000,25000))
    Shiraz:AddMission(shircapfrag1)
    function shircapfrag1:OnAfterSuccess(From,Event,To)
      shircapdisp(1)
    end
    function shircapfrag1:OnAfterFailed(From,Event,To)
      shircapdisp(1)
    end
end

function shircap2()
  BASE:E({"shircap2"})
    local capzone = Z_CAP2
    local ccz = CZ2
    if math.random(1,2) == 2 then
      capzone = Z_CAP5
      ccz = CZ2
    end
    shircapfrag2 = AUFTRAG:NewCAP(ccz,math.random(22000,28000),math.random(370,450),capzone:GetRandomCoordinate(),math.random(0,359),math.random(10,25),{"Air"})
    shircapfrag2:SetRequiredAssets(math.random(1,2))
    shircapfrag2:SetEngageAltitude(math.random(10000,25000))
    Shiraz:AddMission(shircapfrag2)
    function shircapfrag2:OnAfterSuccess(From,Event,To)
      shircapdisp()
    end
    function shircapfrag2:OnAfterFailed(From,Event,To)
      shircapdisp()
    end
end

function findclosestab(target)

 local maxdistance = 1000000
  local airbase = nil
  local cab = AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport)
  local c = cab:GetCoordinate()
  if (maxdistance > c:Get2DDistance(target:GetCoordinate())) and (Kish:GetNumberOfAssets() > 0) and (Kish:GetCoalition() == 1) then
    maxdistance = c:Get2DDistance(target:GetCoordinate())
    airbase = Kish
  end
  
  cab = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl)
  c = cab:GetCoordinate()
  local bandardistance = c:Get2DDistance(target:GetCoordinate())
  if (maxdistance > c:Get2DDistance(target:GetCoordinate())) and (Bandar:GetNumberOfAssets() > 0) and (Bandar:GetCoalition() == 1) then
    maxdistance = c:Get2DDistance(target:GetCoordinate())
    airbase = Bandar
  end
  
  cab = AIRBASE:FindByName(AIRBASE.PersianGulf.Lar_Airbase)
  c = cab:GetCoordinate()
  local lardistance = c:Get2DDistance(target:GetCoordinate())
  if maxdistance > c:Get2DDistance(target:GetCoordinate()) and Lar:GetNumberOfAssets() > 0  and Lar:GetCoalition() == 1 then
    maxdistance = c:Get2DDistance(target:GetCoordinate())
    airbase = Lars
  end
  
  cab = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Island_AFB)
  c = cab:GetCoordinate()
  local lardistance = c:Get2DDistance(target:GetCoordinate())
  if (maxdistance > c:Get2DDistance(target:GetCoordinate())) and (Tunb:GetNumberOfAssets() > 0) and (Tunb:GetCoalition() == 1) then
    maxdistance = c:Get2DDistance(target:GetCoordinate())
    airbase = Tunb
  end
  
  
  cab = AIRBASE:FindByName(AIRBASE.PersianGulf.Kerman_Airport)
  c = cab:GetCoordinate()
  local kermandistance = c:Get2DDistance(target:GetCoordinate())
  if (maxdistance > c:Get2DDistance(target:GetCoordinate())) and (Kerman:GetNumberOfAssets() > 0) and (Kerman:GetCoalition() == 1) then
    maxdistance = c:Get2DDistance(target:GetCoordinate())
    airbase = Kerman
  end
  
  cab = AIRBASE:FindByName(AIRBASE.PersianGulf.Shiraz_International_Airport)
  c = cab:GetCoordinate()
  local shirazdistance = c:Get2DDistance(target:GetCoordinate())
  if (maxdistance > c:Get2DDistance(target:GetCoordinate())) and (Shiraz:GetNumberOfAssets() > 0) and (Shiraz:GetCoalition() == 1) then
    maxdistance = c:Get2DDistance(target:GetCoordinate())
    airbase = Shiraz
  end
  return airbase
end




function ATO(contact)
  BASE:E({"ATO RUNNING",contact.attribute})
  local target = GROUP:FindByName(contact.groupname)
  
 if (contact.attribute == "Air_Bomber") or (contact.attribute == "Air_Fighter") or (contact.attribute == GROUP.Attribute.AIR_AWACS) or (contact.attribute == "Air_Other") or (contact.attribute == "Air_OtherAir") then
  -- we need to work out what airbase is the closest to the contact so we can vector the correct intercept group
  local airbase = findclosestab(target)
  local frag = AUFTRAG:NewINTERCEPT(target)
  airbase:AddMission(frag)
  elseif (contact.attribute == "Ground_SAM") or (contact.attribute == "Ground_AAA") or (contact.attribute == "Ground_EWR") then
    -- SEAD AIRCRAFT
  -- we need to work out what airbase is the closest to the contact so we can vector the correct intercept group
  local airbase = findclosestab(target)
 
  local frag = AUFTRAG:NewBAI(target)
  airbase:AddMission(frag)
  
  elseif (contact.attribute == "Ground_Infantry") then
  -- Helicopters
  local airbase = findclosestab(target) 
 
  local frag = AUFTRAG:NewCAS(target)
  airbase:AddMission(frag)
   
  elseif (contact.attribute == GROUP.Attribute.NAVAL_AIRCRAFTCARRIER) or (contact.attribute == GROUP.Attribute.NAVAL_ARMEDSHIP) or (contact.attribute == GROUP.Attribute.NAVAL_WARSHIP) then
  local airbase = findclosestab(target) 
  local frag = AUFTRAG:NewANTISHIP(target)
  airbase:AddMission(frag)
  else
  -- anything else 
  BASE:E({"We detected something unhandled",contact})
 end
end
BASE:E({"Requesting Start of all the items in 30 seconds"})

SCHEDULER:New(nil,function() 
BASE:E({"Should be running scheduler for AWACS etc"})
  tnkdisp(Shiraz,66,tex,4,252,true,Shiraz)
  SCHEDULER:New(nil,function() U_AWACS1 = awacsdisp(Shiraz,4,true,Shiraz) end, {}, math.random(5,120))
  SCHEDULER:New(nil,function() U_AWACS2 = awacsdisp(Kerman,4,true,Kerman) end, {}, math.random(300,600))
  SCHEDULER:New(nil,function() larcapdisp() end, {}, math.random(5,600))
  SCHEDULER:New(nil,function() kercapdisp(1) end, {}, math.random(5,600))
  SCHEDULER:New(nil,function() kercapdisp(2) end, {}, math.random(300,1200))
  SCHEDULER:New(nil,function() bandcapdisp() end, {}, math.random(5,600))
  SCHEDULER:New(nil,function() shircapdisp(1) end, {}, math.random(5,600))
  SCHEDULER:New(nil,function() shircapdisp(2) end, {}, math.random(300,1200))
end,{},30)

function MADZ:OnAfterNewContact(From,Event,To,Contact)
  BASE:E({"Contact Detected in ADZ Zones"})
  local target = GROUP:FindByName(Contact.groupname)
  if target:IsPartlyOrCompletelyInZone(K_ADZ) then
    if (Kerman:GetNumberOfAssets() ~= 0) and (Kerman:GetCoalition() == 1) then
      local frag = AUFTRAG:NewINTERCEPT(target)
      Kerman:AddMission(frag)
    end
  elseif target:IsPartlyOrCompletelyInZone(S_ADZ) then
    if (Shiraz:GetNumberOfAssets() ~= 0) and (Shiraz:GetCoalition() == 1) then
      local frag = AUFTRAG:NewINTERCEPT(target)
      Shiraz:AddMission(frag)
    end
  end

end

function IAA:OnAfterNewContact(From, Event, To, Contact)
  BASE:E({"Contact Detected"})
  local contact=Contact --Ops.Intelligence#INTEL.Contact
   ATO(contact) --fire the function for the contact  
end --end OnAfterNew


function evh:OnEventBaseCaptured(EventData)
  local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
  local ABItem = AIRBASE:FindByName(AirbaseName)
  local coalition = ABItem:GetCoalition()
  -- local coalition = EventData.getCoalition()
  self:E({self.name,"redcommand BASE Captured " .. AirbaseName,coalition})  
  if AirbaseName == AIRBASE.PersianGulf.Lar_Airbase then
    AbLar = coalition
  elseif AirbaseName == AIRBASE.PersianGulf.Kish_International_Airport then
    AbKish = coalition
  elseif AirbaseName == AIRBASE.PersianGulf.Shiraz_International_Airport then
    AbShiraz = coalition
  elseif AirbaseName == AIRBASE.PersianGulf.Kerman_Airport then
    AbKerman = coalition
  elseif AirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl then
    AbBandar = coalition
  elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Island_AFB then
    AbTunb = coalition
  end
end

world.addEventHandler(evh)