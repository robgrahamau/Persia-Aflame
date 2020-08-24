BASE:E({"Loading Manpads script"})
BASE:E({"ZONES"})
ZONE0 = ZONE_POLYGON:New("AA_SPAWNZONE1",GROUP:FindByName("AA_SPAWNZONE1"))
ZONE1 = ZONE_POLYGON:New("AA_SPAWNZONE2",GROUP:FindByName("AA_SPAWNZONE2"))
ZONE2 = ZONE_POLYGON:New("AA_SPAWNZONE3",GROUP:FindByName("AA_SPAWNZONE3"))
ZONE3 = ZONE_POLYGON:New("AA_City_Spawn_1",GROUP:FindByName("AA_City_Spawn_1"))
ZONE4 = ZONE_POLYGON:New("AA_City_Spawn_2",GROUP:FindByName("AA_City_Spawn_2"))
ZONE5 = ZONE_POLYGON:New("AA_City_Spawn_3",GROUP:FindByName("AA_City_Spawn_3"))
ZONE6 = ZONE_POLYGON:New("AA_City_Spawn_4",GROUP:FindByName("AA_City_Spawn_4"))
ZONE7 = ZONE_POLYGON:New("AA_City_Spawn_5",GROUP:FindByName("AA_City_Spawn_5"))
ZONE8 = ZONE_POLYGON:New("QZONE",GROUP:FindByName("QZONE"))
if mainmission.manpads == nil then
  manpadinit = false
  mainmission.manpads = false
end

if mainmission.manpads == false then
  manpadinit = false
else
  manpadinit = true
end


init = false


if manpadinit == false then
  MANPADS = {}
  
  for i = 1,30 do
    BASE:E({"Manpad",i})
    u = "MANPAD" .. i
    if i < 11 then
      MANPADS[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,500,50):SpawnInZone(ZONE0,true)
    elseif i > 10 and i < 21 then
      MANPADS[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,500,50):SpawnInZone(ZONE1,true)
    else
      MANPADS[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,500,50):SpawnInZone(ZONE2,true)
    end
  end
  AAA = {}

  for i = 1,30 do
    BASE:E({"AAA Manpad",i})
    u = "AAA" .. i
    if i < 6 then 
      AAA[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,300,5):SpawnInZone(ZONE5,true)
    elseif i > 5 and i < 11 then
      AAA[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,300,5):SpawnInZone(ZONE4,true)
    elseif i > 10 and i < 16 then
      AAA[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,300,5):SpawnInZone(ZONE3,true)    
    elseif i > 15 and i < 21 then
      AAA[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,300,5):SpawnInZone(ZONE6,true)
    elseif i > 20 and i < 25 then
      AAA[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,300,5):SpawnInZone(ZONE7,true)
    else
      AAA[i] = SPAWN:New(u):InitRandomizeTemplate({"RAA - Template 01","RAA - Template 02","RAA - Template 03","RAA - Template 04","RAA - Template 05","RAA - Template 06","RAA - Template 07"}):InitRandomizeUnits(true,750,100):InitRandomizePosition(true,300,5):SpawnInZone(ZONE8,true)
    end
  end
  manpadinit = true
  mainmission.manpads = true
else
  BASE:E({"Manpads and AA where already in existance ignoring"})
end
init=true
