
--[[
DCS-SimpleTextToSpeech
Version 0.1
Compatible with SRS version 1.9.0.2 +
DCS Modification Required:
You will need to edit MissionScripting.lua in DCS World/Scripts/MissionScripting.lua and remove the sanitisation.
To do this remove all the code below the comment - the line starts "local function sanitizeModule(name)"
Do this without DCS running to allow mission scripts to use os functions.
*You WILL HAVE TO REAPPLY AFTER EVERY DCS UPDATE*
USAGE:
Add this script into the mission as a DO SCRIPT or DO SCRIPT FROM FILE to initialise it
Make sure to edit the STTS.SRS_PORT and STTS.DIRECTORY to the correct values before adding to the mission.
Then its as simple as calling the correct function in LUA as a DO SCRIPT or in your own scripts
Example calls:
STTS.TextToSpeech("Hello DCS WORLD","251","AM","1.0","SRS",2)
Arguments in order are:
 - Message to say, make sure not to use a newline (\n) !
 - Frequency in MHz
 - Modulation - AM/FM
 - Volume - 1.0 max, 0.5 half
 - Name of the transmitter - ATC, RockFM etc
 - Coalition - 0 spectator, 1 red 2 blue
 This example will say the words "Hello DCS WORLD" on 251 MHz AM at maximum volume with a client called SRS and to the Blue coalition only
STTS.PlayMP3("C:\\Users\\Ciaran\\Downloads\\PR-Music.mp3","255,31","AM,FM","0.5","Multiple",0)
Arguments in order are:
 - FULL path to the MP3 to play
 - Frequency in MHz - to use multiple separate with a comma - Number of frequencies MUST match number of Modulations
 - Modulation - AM/FM - to use multiple
 - Volume - 1.0 max, 0.5 half
 - Name of the transmitter - ATC, RockFM etc
 - Coalition - 0 spectator, 1 red 2 blue
This will play that MP3 on 255MHz AM & 31 FM at half volume with a client called "Multiple" and to Spectators only
]]
env.info("Loading SRS stuff")

STTS = {}
-- FULL Path to the FOLDER containing DCS-SR-ExternalAudio.exe - EDIT TO CORRECT FOLDER
STTS.DIRECTORY = "E:\\DCS-SimpleRadio-Standalone"
STTS.SRS_PORT = 5002 -- LOCAL SRS PORT - DEFAULT IS 5002


-- DONT CHANGE THIS UNLESS YOU KNOW WHAT YOU'RE DOING
STTS.EXECUTABLE = "DCS-SR-ExternalAudio.exe"

function STTS.TextToSpeech(message,freqs,modulations, volume,name, coalition )

    message = message:gsub("\"","\\\"")

    local cmd = string.format("start \"%s\" \"%s\\%s\" \"%s\" %s %s %s %s \"%s\" %s", STTS.DIRECTORY, STTS.DIRECTORY, STTS.EXECUTABLE, message, freqs, modulations, coalition,STTS.SRS_PORT, name, volume )

    os.execute(cmd)

end

function STTS.PlayMP3(pathToMP3,freqs,modulations, volume,name, coalition )

    local cmd = string.format("start \"%s\" \"%s\\%s\" \"%s\" %s %s %s %s \"%s\" %s", STTS.DIRECTORY, STTS.DIRECTORY, STTS.EXECUTABLE, pathToMP3, freqs, modulations, coalition,STTS.SRS_PORT, name, volume )

    os.execute(cmd)

end

env.info("Loadinged SRS stuff")

BASE:E({"SLOT HANDLER FOR PERSIA AFLAME LOADING"})
trigger.action.setUserFlag("SSB",100)
SEH = EVENTHANDLER:New()
SEH:HandleEvent(EVENTS.BaseCaptured)
stn = UNIT:FindByName("Stennis")
lh2 = UNIT:FindByName("LHA-2")
tdy = UNIT:FindByName("TeddyR")
tar = UNIT:FindByName("Tarawa")
GW = UNIT:FindByName("Washington")
lh3 = UNIT:FindByName("LHA-3")
lh4 = UNIT:FindByName("LHA-4")
bandaractive = false
kishactive = false
stn:HandleEvent(EVENTS.Dead)
lh2:HandleEvent(EVENTS.Dead)
tdy:HandleEvent(EVENTS.Dead)
tar:HandleEvent(EVENTS.Dead)
GW:HandleEvent(EVENTS.Dead)
lh3:HandleEvent(EVENTS.Dead)
lh4:HandleEvent(EVENTS.Dead)
am = AIRBASE:FindByName(AIRBASE.PersianGulf.Abu_Musa_Island_Airport)
si = AIRBASE:FindByName(AIRBASE.PersianGulf.Sirri_Island)
tk = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Kochak)
ta = AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Island_AFB)


trigger.action.setUserFlag(100,0)
TunbRed = STATIC:FindByName("CTLD Tnub")
TunbBlue = STATIC:FindByName("CTLD Tnub B")
BandarRed = STATIC:FindByName("CTLD BandarFarp")
BandarBlue = STATIC:FindByName("CTLD BandarFarp B")
SirriRed = STATIC:FindByName("CTLD Sirri Island")
SirriBlue = STATIC:FindByName("CTLD Sirri Island B")
LavanRed = STATIC:FindByName("CTLD Lavin")
LavanBlue = STATIC:FindByName("CTLD Lavin B")
KhasabRed = STATIC:FindByName("CTLD AbuFarp B")
KhasabBlue = STATIC:FindByName("CTLD AbuFarp")
LarsRed = STATIC:FindByName("CTLD FLar")
LarsBlue = STATIC:FindByName("CTLD FLar B")
KishBlue = STATIC:FindByName("CTLD Kish B")
KishRed = STATIC:FindByName("CTLD Kish")
QeshmRed = STATIC:FindByName("CTLD Qeshm Island")
QeshmBlue = STATIC:FindByName("CTLD Qeshm Island B")
abunred = STATIC:FindByName("CTLD Abu Nuayr B")
abunblue = STATIC:FindByName("CTLD Abu Nuayr")
havred = STATIC:FindByName("CTLD BandarFarp D")
havblue = STATIC:FindByName("CTLD BandarFarp C")
havmsg = false
abunmsg = false
qemsg = false
kimsg = false
larmsg = false
khmsg = false
lmsg = false
smsg = false
banmsg = false
tmsg = false
jirmsg = false
shiraz = false
kerman = false
blenmsg = false
defenders = {"Defenders","Defenders-1"}
spawnnumber = 1
spawner = nil
spawner2 = nil
spawner3 = nil
spawner4 = nil
spawner5 = nil
spawner6 = nil

function spawnislands()
  if shiraz == false then
	spawnnumber = spawnnumber + 1
	if spawner == nil then
		spawner = SPAWN:NewWithAlias("IslandSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
	else
		if spawner:IsAlive() ~= true then
		spawner = SPAWN:NewWithAlias("IslandSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
		end
	end
	if spawner2 == nil then
		spawner2 = SPAWN:NewWithAlias("IslandCAS","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
	else
		if spawner2:IsAlive() ~= true then
			spawner2 = SPAWN:NewWithAlias("IslandCAS","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
		end
	end
	if spawner3 == nil then
		spawner3 = SPAWN:NewWithAlias("IslandCAP","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
	else
		if spawner3:IsAlive() ~= true then
			spawner3 = SPAWN:NewWithAlias("IslandCAP","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
		end
	end
  end
end

function spawnmainland()
  if shiraz == false then
    spawnnumber = spawnnumber + 1
    if spawner4 == nil then
		spawner4 = SPAWN:NewWithAlias("QeshmSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
	else
		if spawner4:IsAlive() ~= true then
			spawner4 = SPAWN:NewWithAlias("QeshmSead","SEADFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
		end
	end
	if spawner5 == nil then
		spawner5 = SPAWN:NewWithAlias("mainlandcap","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
	
	else
		if spawner5:IsAlive() ~= true then
			spawner5 = SPAWN:NewWithAlias("mainlandcap","CAPFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,5,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()
		
		end
	end
    if spawner6 == nil then
		spawner6 = SPAWN:NewWithAlias("ManlandCas","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()    
	else
		if spawner6:IsAlive() ~= true then
			spawner6 = SPAWN:NewWithAlias("ManlandCas","CASFLIGHT" .. spawnnumber .. ""):InitRandomizeRoute(1,3,10000,1000):InitCleanUp(300):InitRepeatOnLanding():Spawn()    
		end
	end
  end
end

function spawndefenders(groupname)
	BASE:E({"SPAWNING DEFENDERS IF Loading == False",Loading})
  if Loading == false then
    local dspawner = SPAWN:NewWithAlias(groupname,"IAA defenders" .. spawnnumber ..""):InitRandomizeTemplate(defenders):Spawn()
    spawnnumber = spawnnumber + 1
  end
end

function slot_tunb(coalition)
    BASE:E({"SLOTS RUNNING FOR TUNB",coalition})
    if coalition == 1 then
      TunbBlue:Destroy()
      if TunbRed:IsAlive() ~= true then
        TunbRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Tnub"):Spawn()
      end
      trigger.action.setUserFlag("Tunb UH1 #001",0)
      trigger.action.setUserFlag("Tunb UH1",0)
      trigger.action.setUserFlag("Tunb MI8",0)
      trigger.action.setUserFlag("Tunb MI8 #001",0)
      trigger.action.setUserFlag("Tunb KA50",0)
      trigger.action.setUserFlag("Tunb KA50 #001",0)
      trigger.action.setUserFlag("Tunb US UH1",100)
      trigger.action.setUserFlag("Tunb US UH1 #001",100)
      trigger.action.setUserFlag("Tunb Georgia KA50",100)
      trigger.action.setUserFlag("Tunb Georgia KA50 #001",100)
      trigger.action.setUserFlag("Tunb Georgia MI8",100)
      trigger.action.setUserFlag("Tunb Georgia MI8 #001",100)
      ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Island", 4)
    if tmsg == true then
    MESSAGE:New("Iran has Retaken Tunb from the Coalition Invaders!",30):ToAll()
    STTS.TextToSpeech("Tunb has been retaken by Irani Forces",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have lost Tunb to Irani Forces",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Tunb has been taken by Iran ==============")
    tmsg = false
    end
    else
      TunbRed:Destroy()
      if TunbBlue:IsAlive() ~= true then
        TunbBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Tnub B"):Spawn()
      end
      
      trigger.action.setUserFlag("Tunb UH1 #001",100)
      trigger.action.setUserFlag("Tunb UH1",100)
      trigger.action.setUserFlag("Tunb MI8",100)
      trigger.action.setUserFlag("Tunb MI8 #001",100)
      trigger.action.setUserFlag("Tunb KA50",100)
      trigger.action.setUserFlag("Tunb KA50 #001",100)
      trigger.action.setUserFlag("Tunb US UH1",0)
      trigger.action.setUserFlag("Tunb US UH1 #001",0)
      trigger.action.setUserFlag("Tunb Georgia KA50",0)
      trigger.action.setUserFlag("Tunb Georgia KA50 #001",0)
      trigger.action.setUserFlag("Tunb Georgia MI8",0)
      trigger.action.setUserFlag("Tunb Georgia MI8 #001",0)
      ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Island", 4)
    if tmsg == false then
    MESSAGE:New("Coalition forces have liberated Tunb from Iran",30):ToAll()
    STTS.TextToSpeech("Tunb has fallen to the capitalist infidels",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have liberated Tunb from Irani Forces",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Tunb has been taken by the Coalition  ==================")
    tmsg = true
    SCHEDULER:New(nil,spawnislands,{},math.random(5,1200))
    end 
    end
end

function slot_sirri(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Sirri Island",3)
  if coalition == 1 then
    SirriBlue:Destroy()
    if SirriRed:IsAlive() ~= true then
      SirriRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Sirri Island"):Spawn()
    BASE:E({"LETS GET Sirri Red's name",SirriRed:GetName()})
    end
    trigger.action.setUserFlag("Sirri US Island MI8", 100)
    trigger.action.setUserFlag("Sirri US Island MI8 #001", 100)
    trigger.action.setUserFlag("Sirri US Island KA50", 100)
    trigger.action.setUserFlag("Sirri US Island KA50 #001", 100)
    trigger.action.setUserFlag("Sirri US Island UH1", 100)
    trigger.action.setUserFlag("Sirri US Island UH1 #001", 100)
  if smsg == true then
    MESSAGE:New("Iran has Retaken Sirri Island from the Coalition Invaders!",30):ToAll()
    STTS.TextToSpeech("Sirri Island has been retaken from the US led scum",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have lost Sirri Island to Iran!",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Siri Island has been taken by Iran  ==================")
    smsg = false
    end
  else
    SirriRed:Destroy()
    
    if SirriBlue:IsAlive() ~= true then
      SirriBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Sirri Island B"):Spawn()
    BASE:E({"LETS GET Sirri Blue's name",SirriBlue:GetName()})
    end
    trigger.action.setUserFlag("Sirri US Island MI8", 0)
    trigger.action.setUserFlag("Sirri US Island MI8 #001", 0)
    trigger.action.setUserFlag("Sirri US Island KA50", 0)
    trigger.action.setUserFlag("Sirri US Island KA50 #001", 0)
    trigger.action.setUserFlag("Sirri US Island UH1", 0)
    trigger.action.setUserFlag("Sirri US Island UH1 #001", 0)
  if smsg == false then
    MESSAGE:New("Coalition Forces have liberated Sirri Island from Iran",30):ToAll()
    STTS.TextToSpeech("Sirri Island has been lost to the western invaders",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We liberated Sirri Island from Iran!",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Siri Island has been taken by Coalition Forces  ==================")
    SCHEDULER:New(nil,spawnislands,{},math.random(60,1200))
    SCHEDULER:New(nil,function() 
      spawndefenders("sirrispawn")
    end,{},math.random(60,300))
    smsg = true
  end
  end
end

function slot_lavan(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Lavin Island",3)
  if coalition == 1 then
    LavanBlue:Destroy()
    if LavanRed:IsAlive() ~= true then
      LavanRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Lavin"):Spawn()
    end
    
    trigger.action.setUserFlag("Lavin Island UH1", 0)
    trigger.action.setUserFlag("Lavin Island UH1 #001", 0)
    trigger.action.setUserFlag("Lavin Island KA50", 0)
    trigger.action.setUserFlag("Lavin Island KA50 #001", 0)
    trigger.action.setUserFlag("Lavin Island MI8", 0)
    trigger.action.setUserFlag("Lavin Island MI8 #001", 0)
    trigger.action.setUserFlag("Lavin Island US UH1", 100)
    trigger.action.setUserFlag("Lavin Island US UH1 #001", 100)
    trigger.action.setUserFlag("Lavin Island US KA50", 100)
    trigger.action.setUserFlag("Lavin Island US KA50 #001", 100)
    trigger.action.setUserFlag("Lavin Island US MI8", 100)
    trigger.action.setUserFlag("Lavin Island US MI8 #001", 100)
  if lmsg == true then
    MESSAGE:New("Iran has retaken Lavan Island from the US Backed Infidels",30):ToAll()
    STTS.TextToSpeech("Lavan Island is once more back in Irani Hands",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have lost our foothold on Lavan Island!",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Lavan Island has been taken by Iran  ==================")
    lmsg = false
  end
  else
    LavanRed:Destroy()
    if LavanBlue:IsAlive() ~= true then
      LavanBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Lavin B"):Spawn()
    end
    
    trigger.action.setUserFlag("Lavin Island UH1", 100)
    trigger.action.setUserFlag("Lavin Island UH1 #001", 100)
    trigger.action.setUserFlag("Lavin Island KA50", 100)
    trigger.action.setUserFlag("Lavin Island KA50 #001", 100)
    trigger.action.setUserFlag("Lavin Island MI8", 100)
    trigger.action.setUserFlag("Lavin Island MI8 #001", 100)
    trigger.action.setUserFlag("Lavin Island US UH1", 00)
    trigger.action.setUserFlag("Lavin Island US UH1 #001", 00)
    trigger.action.setUserFlag("Lavin Island US KA50", 00)
    trigger.action.setUserFlag("Lavin Island US KA50 #001", 00)
    trigger.action.setUserFlag("Lavin Island US MI8", 00)
    trigger.action.setUserFlag("Lavin Island US MI8 #001", 00)
  if lmsg == false then
    MESSAGE:New("The US Led Coalition has liberated Lavan Island from Irani dictatorship",30):ToAll()
    STTS.TextToSpeech("Lavan Island has fallen",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have gained a foothold on Lavan Island!",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Lavan Island has been taken by Coalition Forces  ==================")
    SCHEDULER:New(nil,spawnislands,{},math.random(5,1200))
    SCHEDULER:New(nil,function() 
      spawndefenders("lavanspawn")
    end,{},math.random(60,300))
    lmsg = true
  end
  end
end

function slot_kish(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Kish Island",3)
  if coalition == 1 then
    KishBlue:Destroy()
    if KishRed:IsAlive() ~= true then
      KishRed:ReSpawn() --= SPAWNSTATIC:NewFromStatic("CTLD Kish"):Spawn()
    end
    trigger.action.setUserFlag("Kish UH1", 0)
    trigger.action.setUserFlag("Kish UH1 #001", 0)
    trigger.action.setUserFlag("Kish Mi8", 0)
    trigger.action.setUserFlag("Kish Mi8 #001", 0)
    trigger.action.setUserFlag("Kish KA50", 0)
    trigger.action.setUserFlag("Kish KA50 #001", 0)
    trigger.action.setUserFlag("Frogfoot 21", 0)
    trigger.action.setUserFlag("Frogfoot 22", 0)
    trigger.action.setUserFlag("Frogfoot 23", 0)
    trigger.action.setUserFlag("Frogfoot 24", 0)
    trigger.action.setUserFlag("IRAF91-1", 0)
    trigger.action.setUserFlag("IRAF91-2", 0)
    trigger.action.setUserFlag("IRAF91-3", 0)
    trigger.action.setUserFlag("IRAF91-4", 0)
    trigger.action.setUserFlag("KishBoar -1",100)
    trigger.action.setUserFlag("KishBoar -2",100)
    trigger.action.setUserFlag("KishBoar -3",100)
    trigger.action.setUserFlag("KishBoar -4",100)
    trigger.action.setUserFlag("Kish US UH1", 100)
    trigger.action.setUserFlag("Kish US UH1 #001", 100)
    trigger.action.setUserFlag("Kish US KA50", 100)
    trigger.action.setUserFlag("Kish US KA50 #001", 100)
  ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},2)
  ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},2)
  if kimsg == true then
    MESSAGE:New("Kish Island is once more under Irani Control",30):ToAll()
    STTS.TextToSpeech("Kish Island has been retaken",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have lost our foothold on Lavan Island!",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Kish Island has been taken by Iran  ==================")
    kimsg = false
  end
  else
    KishRed:Destroy()
    if KishBlue:IsAlive() ~= true then
      KishBlue = SPAWNSTATIC:NewFromStatic("CTLD Kish B"):Spawn()
    end
    trigger.action.setUserFlag("Kish UH1", 100)
    trigger.action.setUserFlag("Kish UH1 #001", 100)
    trigger.action.setUserFlag("Kish Mi8", 100)
    trigger.action.setUserFlag("Kish Mi8 #001", 100)
    trigger.action.setUserFlag("Kish KA50", 100)
    trigger.action.setUserFlag("Kish KA50 #001", 100)
    trigger.action.setUserFlag("Frogfoot 21", 100)
    trigger.action.setUserFlag("Frogfoot 22", 100)
    trigger.action.setUserFlag("Frogfoot 23", 100)
    trigger.action.setUserFlag("Frogfoot 24", 100)
    trigger.action.setUserFlag("IRAF91-1", 100)
    trigger.action.setUserFlag("IRAF91-2", 100)
    trigger.action.setUserFlag("IRAF91-3", 100)
    trigger.action.setUserFlag("IRAF91-4", 100)
    trigger.action.setUserFlag("Kish US UH1", 0)
    trigger.action.setUserFlag("Kish US UH1 #001", 0)
    trigger.action.setUserFlag("Kish US KA50", 0)
    trigger.action.setUserFlag("Kish US KA50 #001", 0)
    trigger.action.setUserFlag("KishBoar -1",00)
    trigger.action.setUserFlag("KishBoar -2",00)
    trigger.action.setUserFlag("KishBoar -3",00)
    trigger.action.setUserFlag("KishBoar -4",00)
  ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},-99)
  ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},-99)
  if kimsg == false then
    MESSAGE:New("Kish Island has been taken by the coalition forces",30):ToAll()
    STTS.TextToSpeech("Kish Island has fallen",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have gained a foothold on Kish Island!",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Kish Island has been taken by Coalition Forces  ==================")
    kimsg = true
    SCHEDULER:New(nil,spawnislands,{},math.random(5,1200))
        SCHEDULER:New(nil,function() 
      spawndefenders("kishspawn")
    end,{},math.random(60,300))
    
    
  end
  end
end

function slot_qeshm(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Qeshm Island",4)
  if coalition == 1 then
    QeshmBlue:Destroy()
    if QeshmRed:IsAlive() ~= true then
      QeshmRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Qeshm Island"):Spawn()
    end
    trigger.action.setUserFlag("Qeshm Island US UH1", 100)
    trigger.action.setUserFlag("Qeshm Island US UH1 #001", 100)
    trigger.action.setUserFlag("Qeshm Island US KA50", 100)
    trigger.action.setUserFlag("Qeshm Island US KA50 #001", 100)
  if qemsg == true then
    MESSAGE:New("Qeshm Island has been Liberated from the Coalition invaders and Infidels",30):ToAll()
    STTS.TextToSpeech("Qeshm Island is once more ours, we must continue to push back the infidels",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have lost Qeshm Island, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Qeshm Island has been taken by Iran  ==================")
    qemsg = false
  end
  else
    QeshmRed:Destroy()
    if QeshmBlue:IsAlive() ~= true then
      QeshmBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Qeshm Island B"):Spawn()
      
    end
    trigger.action.setUserFlag("Qeshm Island US UH1", 00)
    trigger.action.setUserFlag("Qeshm Island US UH1 #001", 00)
    trigger.action.setUserFlag("Qeshm Island US KA50", 00)
    trigger.action.setUserFlag("Qeshm Island US KA50 #001", 00)
  if qemsg == false then
    MESSAGE:New("Qesh Island has been occuiped, Coalition forces are one step closer to taking Iran!",30):ToAll()
    STTS.TextToSpeech("Qeshm Island has falledn to the infidels! We must retake it before they gain a foothold",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("Qeshm Island is now ours, we have a base on Bandar's doorstep.",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Qeshm Island has been taken by Iran  ==================")
    qemsg = true
    SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    SCHEDULER:New(nil,function() 
      spawndefenders("qeshmspawn")
    end,{},math.random(60,300))
  end
  end
end

function slot_khasab(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Khasab",4)
  if coalition == 1 then
    KhasabBlue:Destroy()
    if KhasabRed:IsAlive() ~= true then
      KhasabRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD AbuFarp B"):Spawn()
    end
    trigger.action.setUserFlag("RED KA50 Khasab", 00)
    trigger.action.setUserFlag("RED KA50 Khasab #001", 00)
    trigger.action.setUserFlag("RED UH1 Khasab", 00)
    trigger.action.setUserFlag("RED UH1 Khasab #001", 00)
    trigger.action.setUserFlag("SA342Mini #001", 100)
    trigger.action.setUserFlag("SA342Mini", 100)
    trigger.action.setUserFlag("UH1-Khasab 3", 100)
    trigger.action.setUserFlag("UH1-Khasab 2", 100)
    trigger.action.setUserFlag("UH1-Khasab 1", 100)
    trigger.action.setUserFlag("UH1-Khasab", 100)
    trigger.action.setUserFlag("KA50",100)
    trigger.action.setUserFlag("KA50 #001",100)
    trigger.action.setUserFlag("SA342Mist",100)
    trigger.action.setUserFlag("SA342Mist #001",100)
    trigger.action.setUserFlag("SA342M",100)
    trigger.action.setUserFlag("SA342M #001",100)
    trigger.action.setUserFlag("MI8-1",100)
    trigger.action.setUserFlag("MI8-2",100)
    trigger.action.setUserFlag("A10C_HAWG3_99",100)
    trigger.action.setUserFlag("A10C_HAWG3_100",100)
    trigger.action.setUserFlag("A10C_HAWG3_101",100)
    trigger.action.setUserFlag("A10C_HAWG3_102",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG6_910",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG9_913",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG8_912",100)
    trigger.action.setUserFlag("{TGW} A10C_HAWG7_911",100)
    trigger.action.setUserFlag("COLT5-54",100)
    trigger.action.setUserFlag("COLT5-55",100)
    trigger.action.setUserFlag("COLT5-56",100)
    trigger.action.setUserFlag("COLT5-57",100)
  if khmsg == true then
    MESSAGE:New("Iran Forces have captured Khasab in the Omani Republic!",30):ToAll()
    STTS.TextToSpeech("Khasab is now in Irani hands, the Omani Republic should not have backed the Infidels.",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("We have lost Khasab! We must retake it at all costs, the Irani Invaders must not be allowed to gain a foothold.",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Khasab Island has been taken by Iran  ==================")
    khmsg = false
  end
  else
    KhasabRed:Destroy()
    if KhasabBlue:IsAlive() ~= true then
      KhasabBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD AbuFarp"):Spawn()
    end
    trigger.action.setUserFlag("RED KA50 Khasab", 100)
    trigger.action.setUserFlag("RED KA50 Khasab #001", 100)
    trigger.action.setUserFlag("RED UH1 Khasab", 100)
    trigger.action.setUserFlag("RED UH1 Khasab #001", 100)
    trigger.action.setUserFlag("SA342Mini #001", 00)
    trigger.action.setUserFlag("SA342Mini", 00)
    trigger.action.setUserFlag("UH1-Khasab 3", 00)
    trigger.action.setUserFlag("UH1-Khasab 2", 00)
    trigger.action.setUserFlag("UH1-Khasab 1", 00)
    trigger.action.setUserFlag("UH1-Khasab", 00)
    trigger.action.setUserFlag("KA50",00)
    trigger.action.setUserFlag("KA50 #001",00)
    trigger.action.setUserFlag("SA342Mist",00)
    trigger.action.setUserFlag("SA342Mist #001",00)
    trigger.action.setUserFlag("SA342M",00)
    trigger.action.setUserFlag("SA342M #001",00)
    trigger.action.setUserFlag("MI8-1",00)
    trigger.action.setUserFlag("MI8-2",00)
    trigger.action.setUserFlag("A10C_HAWG3_99",00)
    trigger.action.setUserFlag("A10C_HAWG3_100",00)
    trigger.action.setUserFlag("A10C_HAWG3_101",00)
    trigger.action.setUserFlag("A10C_HAWG3_102",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG6_910",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG9_913",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG8_912",00)
    trigger.action.setUserFlag("{TGW} A10C_HAWG7_911",00)
    trigger.action.setUserFlag("COLT5-54",00)
    trigger.action.setUserFlag("COLT5-55",00)
    trigger.action.setUserFlag("COLT5-56",00)
    trigger.action.setUserFlag("COLT5-57",00)
  if khmsg == false then
    MESSAGE:New("The Omani People rest easier knowing that the Coalition has retaken Khasab",30):ToAll()
    STTS.TextToSpeech("Khasab has been lost to us, we must recover from this blow quickly.",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("Khasab is once more in the rightful hands of the Omani people.",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Khasab Island has been taken by Coalition Forces  ==================")
    khmsg = true
  end
  end

end


function slot_bandar(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Bandar Abbas",4)
  if coalition == 1 then
    BandarBlue:Destroy()
    if BandarRed:IsAlive() ~= true then
      BandarRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD BandarFarp"):Spawn()
    end
    trigger.action.setUserFlag("Bandar MI8", 00)
    trigger.action.setUserFlag("Bandar MI8 #001", 00)
    trigger.action.setUserFlag("Bandar UH1", 00)
    trigger.action.setUserFlag("Bandar UH1 #001", 00)
    trigger.action.setUserFlag("Bandar KA50", 00)
    trigger.action.setUserFlag("Bandar KA50 #001", 00)
    trigger.action.setUserFlag("Bandar KA50 #002", 00)
    trigger.action.setUserFlag("Bandar KA50 #003", 00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR", 00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr", 00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr #001",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR #001",00)
    trigger.action.setUserFlag("Bandar_Mig-29 422",00)
    trigger.action.setUserFlag("Bandar_Mig-29",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #001",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #002",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #003",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #003",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #004",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #002",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #001",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #002",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #003",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #001",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #001",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #002",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #003",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #001",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #002",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #003",00)
    trigger.action.setUserFlag("Pak-F16-Bandar",00)
    trigger.action.setUserFlag("Pak-F16-Bandar #001",00)
    trigger.action.setUserFlag("Pak-F16-Bandar #002",00)
    trigger.action.setUserFlag("Pak-F16-Bandar #003",00)
    trigger.action.setUserFlag("IRAF31th",00)
    trigger.action.setUserFlag("IRAF31th #001",00)
    ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},4)
    ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},4)
    if banmsg == false then
      MESSAGE:New("Iran has liberated Bandar Abbas from the oppressors and it is once more in our hands!",30):ToAll()
      STTS.TextToSpeech("Bandar is once more ours, we must continue to push back the infidels",253.00,"AM",0.75,"TGW Command", 1 )
      STTS.TextToSpeech("We have lost Bandar Abbas, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      HypeMan.sendBotMessage("================= Bandar Abbas has been taken by Iran  ==================")
      banmsg = true
    end
  else
    BandarRed:Destroy()
    if BandarBlue:IsAlive() ~= true then
      BandarBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD BandarFarp B"):Spawn()
    end
    trigger.action.setUserFlag("Bandar MI8", 100)
    trigger.action.setUserFlag("Bandar MI8 #001", 100)
    trigger.action.setUserFlag("Bandar UH1", 100)
    trigger.action.setUserFlag("Bandar UH1 #001", 100)
    trigger.action.setUserFlag("Bandar KA50", 100)
    trigger.action.setUserFlag("Bandar KA50 #001", 100)
    trigger.action.setUserFlag("Bandar KA50 #002", 100)
    trigger.action.setUserFlag("Bandar KA50 #003", 100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR", 100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr", 100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr #001",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR #001",100)
    trigger.action.setUserFlag("Bandar_Mig-29 422",100)
    trigger.action.setUserFlag("Bandar_Mig-29",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #001",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #002",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #003",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #003",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #004",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #002",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #001",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #002",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #003",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #001",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #001",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #002",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #003",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #001",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #002",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #003",100)
    trigger.action.setUserFlag("Pak-F16-Bandar",100)
    trigger.action.setUserFlag("Pak-F16-Bandar #001",100)
    trigger.action.setUserFlag("Pak-F16-Bandar #002",100)
    trigger.action.setUserFlag("Pak-F16-Bandar #003",100)
    trigger.action.setUserFlag("IRAF31th",100)
    trigger.action.setUserFlag("IRAF31th #001",100)
    ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},0)
    ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},0)
  if banmsg == true then
    MESSAGE:New("Coalition forces have occupied Bandar! We have crossed the Strait!",30):ToAll()
    STTS.TextToSpeech("We have lost Bandar Abbas! This can not stand we must retake that airfield at all costs.",253.00,"AM",0.75,"TGW Command", 1 )
    STTS.TextToSpeech("Bandar Abbas is now ours, we have crossed the straight of Hormoz",253.00,"AM",0.75,"TGW Command", 2 )
    HypeMan.sendBotMessage("================= Bandar Abbas has been taken by Coalition Forces  ==================")
    SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    SCHEDULER:New(nil,function() 
      spawndefenders("bandarspawn")
    end,{},math.random(60,300))
    banmsg = false
  end
  end

end

function slot_lars(coalition)
  BASE:E({"LARS SLOT",coalition})
  ctld.changeRemainingGroupsForPickupZone("CTLD Lar AFB",4)
  if coalition == 1 then
    LarsBlue:Destroy()
    if LarsRed:IsAlive() ~= true then
      LarsRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD FLar B"):Spawn()
    end
	BASE:E({"Lars shuld be locked to Blue"})
    trigger.action.setUserFlag("LarsK -1", 100)
    trigger.action.setUserFlag("LarsK -2", 100)
    trigger.action.setUserFlag("LarsK -3", 100)
    trigger.action.setUserFlag("LarsK -4", 100)
    trigger.action.setUserFlag("LarsK -5", 00)
    trigger.action.setUserFlag("LarsK -6", 00)
    trigger.action.setUserFlag("LarsK -7", 00)
    trigger.action.setUserFlag("LarsK -8", 00)
    trigger.action.setUserFlag("LarsU -1", 100)
    trigger.action.setUserFlag("LarsU -2", 100)
    trigger.action.setUserFlag("LarsU -3", 100)
    trigger.action.setUserFlag("LarsU -4", 100)
    trigger.action.setUserFlag("LarsU -5", 00)
    trigger.action.setUserFlag("LarsU -6", 00)
    trigger.action.setUserFlag("LarsU -7", 00)
    trigger.action.setUserFlag("LarsU -8", 00)
    trigger.action.setUserFlag("LARS_JF-17_Springfield7", 00)
    trigger.action.setUserFlag("LARS_JF-17_Springfield7 #001", 00)
    trigger.action.setUserFlag("Pak-F16-Lar",00)
    trigger.action.setUserFlag("Pak-F16-Lar #001",00)
    trigger.action.setUserFlag("Pak-F16-Lar #002",00)
    ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},2)
	ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},2)
	if larmsg == true then
		MESSAGE:New("Lars is once more back in Irani Control",30):ToAll()
		larmsg = true
		STTS.TextToSpeech("Lars Airbase is once more ours.",253.00,"AM",0.75,"TGW Command", 1 )
		STTS.TextToSpeech("We have Lars Airbase, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
		HypeMan.sendBotMessage("================= Lar Airbase has been taken by Iran  ==================")
	end
  else
    LarsRed:Destroy()
    if LarsBlue:IsAlive() ~= true then
      LarsBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD FLar"):Spawn()
    end   
	BASE:E({"Lars shuld be locked to Red"})
    trigger.action.setUserFlag("LarsK -1", 00)
    trigger.action.setUserFlag("LarsK -2", 00)
    trigger.action.setUserFlag("LarsK -3", 00)
    trigger.action.setUserFlag("LarsK -4", 00)
    trigger.action.setUserFlag("LarsK -5", 100)
    trigger.action.setUserFlag("LarsK -6", 100)
    trigger.action.setUserFlag("LarsK -7", 100)
    trigger.action.setUserFlag("LarsK -8", 100)
    trigger.action.setUserFlag("LarsU -1", 00)
    trigger.action.setUserFlag("LarsU -2", 00)
    trigger.action.setUserFlag("LarsU -3", 00)
    trigger.action.setUserFlag("LarsU -4", 00)
    trigger.action.setUserFlag("LarsU -5", 100)
    trigger.action.setUserFlag("LarsU -6", 100)
    trigger.action.setUserFlag("LarsU -7", 100)
    trigger.action.setUserFlag("LarsU -8", 100)
    trigger.action.setUserFlag("LARS_JF-17_Springfield7", 100)
    trigger.action.setUserFlag("LARS_JF-17_Springfield7 #001", 100)
    trigger.action.setUserFlag("Pak-F16-Lar",100)
    trigger.action.setUserFlag("Pak-F16-Lar #001",100)
    trigger.action.setUserFlag("Pak-F16-Lar #002",100)
    ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},0)
    ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},0)
  if larmsg == false then
    MESSAGE:New("Lar Airbase has fallen to coalition forces",30):ToAll()
    STTS.TextToSpeech("Lars Airbase is now under our control.",253.00,"AM",0.75,"TGW Command", 2 )
    STTS.TextToSpeech("We have lost Lars Airbase, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 1 )
    HypeMan.sendBotMessage("================= Lar Airbase has been taken by Coalition Forces  ==================")
    SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    SCHEDULER:New(nil,function() 
      spawndefenders("larspawn")
    end,{},math.random(60,300))
    larmsg = true
  end
  end
end


function slot_abun(coalition)
  if coalition == 1 then
    abunblue:Destroy()
    if abunred:IsAlive() ~= true then
      abunred:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Abu Nuayr B"):Spawn()
    end
  if abunmsg == true then
    MESSAGE:New("Iran has taken Abu Nuayr!",30):ToAll()
    STTS.TextToSpeech("We have liberated Abu Nuayr from the Coalition.",253.00,"AM",0.75,"TGW Command", 1 )
  STTS.TextToSpeech("We have lost Abu Nuayr, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
    abunmsg = false
    HypeMan.sendBotMessage("================= Abu Nuayr has been taken by Iran  ==================")
  end
  else
    abunred:Destroy()
    if abunblue:IsAlive() ~= true then
      abunblue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Abu Nuayr"):Spawn()
    end
  if abunmsg == false then
    MESSAGE:New("Coalition Forces have retaken Abu Nuayr",30):ToAll()
    STTS.TextToSpeech("We have liberated Abu Nuayr from the Irani forces.",253.00,"AM",0.75,"TGW Command", 2 )
    STTS.TextToSpeech("We have lost Abu Nuayr, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 1 )
    abunmsg = true
    HypeMan.sendBotMessage("================= Abu Nuayr has been taken by Coalition Forces  ==================")
    end
  end

end

function slot_havadarya(coalition)
  if coalition == 1 then
  havblue:Destroy()
      if havred:IsAlive() ~= true then
        havred:ReSpawn() 
      end
    trigger.action.setUserFlag("Frogfoot 31", 00)
    trigger.action.setUserFlag("Frogfoot 32", 00)
    trigger.action.setUserFlag("Frogfoot 33", 00)
    trigger.action.setUserFlag("Frogfoot 34", 00)
    trigger.action.setUserFlag("Hav US UH1", 100)
    trigger.action.setUserFlag("Hav US UH1 #001", 100)
    trigger.action.setUserFlag("Hav US UH1 #002", 100)
    trigger.action.setUserFlag("Hav US UH1 #003", 100)
    trigger.action.setUserFlag("Hav US KA50", 100)
    trigger.action.setUserFlag("Hav US KA50 #001", 100)
    trigger.action.setUserFlag("Hav US KA50 #002", 100)
    trigger.action.setUserFlag("Hav US KA50 #003", 100)
    ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},4)
    if havmsg == true then
      MESSAGE:New("Havadarya has been retaken by the Irani People!",30):ToAll()
      STTS.TextToSpeech("We have liberated Havadarya from the Coalition.",253.00,"AM",0.75,"TGW Command", 1 )
      STTS.TextToSpeech("We have lost Havadarya to the Irani forces we must regroup and retake it.",253.00,"AM",0.75,"TGW Command", 2 )
      HypeMan.sendBotMessage("================= Havadarya has been taken by Iran  ==================")
      havmsg = false
    end
  else
    havred:Destroy()
    if havblue:IsAlive() ~= true then
      havblue:ReSpawn() 
    end
    trigger.action.setUserFlag("Frogfoot 31", 100)
    trigger.action.setUserFlag("Frogfoot 32", 100)
    trigger.action.setUserFlag("Frogfoot 33", 100)
    trigger.action.setUserFlag("Frogfoot 34", 100)
    trigger.action.setUserFlag("Hav US UH1", 00)
    trigger.action.setUserFlag("Hav US UH1 #001", 00)
    trigger.action.setUserFlag("Hav US UH1 #002", 00)
    trigger.action.setUserFlag("Hav US UH1 #003", 00)
    trigger.action.setUserFlag("Hav US KA50", 00)
    trigger.action.setUserFlag("Hav US KA50 #001", 00)
    trigger.action.setUserFlag("Hav US KA50 #002", 00)
    trigger.action.setUserFlag("Hav US KA50 #003", 00)
    ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},0)
    if havmsg == false then
      MESSAGE:New("Coalition forces have taken Havadarya!",30):ToAll()
      STTS.TextToSpeech("We have taken Havadarya, now we must hold it for the Irani Army will not be pleased",253.00,"AM",0.75,"TGW Command", 2 )
      STTS.TextToSpeech("We have lost Havadarya to the infidel invaders, we must respond immediately!.",253.00,"AM",0.75,"TGW Command", 1 )
      HypeMan.sendBotMessage("================= Havadarya has been taken by Coalition Forces  ==================")
      havmsg = true 
      SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
      SCHEDULER:New(nil,function() 
        spawndefenders("havspawn")
      end,{},math.random(60,300))
    end
  end
end
function slot_bandarlengeh(coalition)
  if coalition == 1 then
    if blenmsg == true then
      MESSAGE:New("Bandar Lengeh has been retaken from the coalition forces",30):ToAll()
      STTS.TextToSpeech("Bandar Lengeh is now under our control.",253.00,"AM",0.75,"TGW Command", 1 )
      STTS.TextToSpeech("We have lost Bandar Lengeh, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      HypeMan.sendBotMessage("================= Bandar Lengeh has been taken by Iran  ==================")
      blenmsg = false
    end
  else
    if blenmsg == false then
      MESSAGE:New("Bandar Lengeh has been taken from the Irani People",30):ToAll()
      STTS.TextToSpeech("Bandar Lengeh has been lost",253.00,"AM",0.75,"TGW Command", 1 )
      STTS.TextToSpeech("We have taken Bandar Lengeh",253.00,"AM",0.75,"TGW Command", 2 )
      HypeMan.sendBotMessage("================= Bandar Lengeh has been taken by Coalitoin ==================")
      SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
      SCHEDULER:New(nil,function() 
        spawndefenders("bandarlspawn")
      end,{},math.random(60,300))
      blenmsg = true
    end
  end

end
function slot_jir(coalition)
  if coalition == 1 then
    trigger.action.setUserFlag("Pak-F16-Jiroft", 00)
    trigger.action.setUserFlag("Pak-F16-Jiroft #001", 00)
    trigger.action.setUserFlag("Pak-F16-Jiroft #002", 00)
    if jirmsg == true then
      MESSAGE:New("Jiroft has been retaken from the coalition forces",30):ToAll()
      STTS.TextToSpeech("Jiroft is now under our control.",253.00,"AM",0.75,"TGW Command", 1 )
      STTS.TextToSpeech("We have lost Jiroft, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 2 )
      HypeMan.sendBotMessage("================= Jiroft has been taken by Iran  ==================")
      jirmsg = false
    end
  else
    trigger.action.setUserFlag("Pak-F16-Jiroft", 100)
    trigger.action.setUserFlag("Pak-F16-Jiroft #001", 100)
    trigger.action.setUserFlag("Pak-F16-Jiroft #002", 100)
    if jirmsg == false then
      MESSAGE:New("Jiroft has fallen to coalition forces",30):ToAll()
      STTS.TextToSpeech("Jiroft is now under our control.",253.00,"AM",0.75,"TGW Command", 2 )
      STTS.TextToSpeech("We have lost Jiroft, this ia a terrible blow",253.00,"AM",0.75,"TGW Command", 1 )
      HypeMan.sendBotMessage("================= Havadarya has been taken by Coalition Forces  ==================")
      jirmsg = true
      SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    end
  end
end

function locklhab()
  trigger.action.setUserFlag("LHA3-AV8",100)
  trigger.action.setUserFlag("LHA3-AV8 #001",100)
  trigger.action.setUserFlag("LHA3-AV8 #002",100)
  trigger.action.setUserFlag("LHA3-AV8 #003",100)
  trigger.action.setUserFlag("LHA3-KA50",100)
  trigger.action.setUserFlag("LHA3-KA50 #001",100)
  trigger.action.setUserFlag("LHA3-UH1",100)
  trigger.action.setUserFlag("LHA3-UH1 #001",100)
  trigger.action.setUserFlag("LHA3-UH1 #002",100)
  trigger.action.setUserFlag("LHA3-UH1 #003",100) 
end

function locklha4()
  trigger.action.setUserFlag("LHA4-UH1",100)  
  trigger.action.setUserFlag("LHA4-UH1 #001",100)
  trigger.action.setUserFlag("LHA4-UH1 #002",100)
  trigger.action.setUserFlag("LHA4-UH1 #003",100)
  trigger.action.setUserFlag("LHA4-KA50",100)
  trigger.action.setUserFlag("LHA4-KA50 #001",100)
  trigger.action.setUserFlag("LHA4-AV8",100)
  trigger.action.setUserFlag("LHA4-AV8 #001",100)
  trigger.action.setUserFlag("LHA4-AV8 #002",100)
  trigger.action.setUserFlag("LHA4-AV8 #003",100)
end

function checkislands()
  if (tk:GetCoalition() == 2) and (ta:GetCoalition() == 2) then
  BASE:E({"Blue holds the Tunb Islands Activating Bandar LHA"})
  if bandaractive == false then
    local acti = GROUP:FindByName("LHA_BANDAR"):Activate()
    bandaractive = true
    MESSAGE:New("Marine Forces are moving up to the Bandar Coast Slots now Open",30):ToBlue()
    HypeMan.sendBotMessage("================= LHA3 Slots are now Active  ==================")
    trigger.action.setUserFlag("LHA3-AV8",00)
    trigger.action.setUserFlag("LHA3-AV8 #001",00)
    trigger.action.setUserFlag("LHA3-AV8 #002",00)
    trigger.action.setUserFlag("LHA3-AV8 #003",00)
    trigger.action.setUserFlag("LHA3-KA50",00)
    trigger.action.setUserFlag("LHA3-KA50 #001",00)
    trigger.action.setUserFlag("LHA3-UH1",00)
    trigger.action.setUserFlag("LHA3-UH1 #001",00)
    trigger.action.setUserFlag("LHA3-UH1 #002",00)
    trigger.action.setUserFlag("LHA3-UH1 #003",00)  
	trigger.action.setUserFlag("IRAF91-1",00)  
  end
 end
 if (am:GetCoalition() == 2) and (si:GetCoalition() == 2) then
  BASE:E({"Blue holds the Tunb Islands Activating Bandar LHA"})
  if kishactive == false then
    local acti = GROUP:FindByName("LHA_KISH"):Activate()
    kishactive = true
    MESSAGE:New("Marine Forces are moving up towards Kish Island, Slots now Open",30):ToBlue()
    HypeMan.sendBotMessage("================= LHA4 Slots are now Active  ==================")
    trigger.action.setUserFlag("LHA4-UH1",00)
    trigger.action.setUserFlag("LHA4-UH1 #001",00)
    trigger.action.setUserFlag("LHA4-UH1 #002",00)
    trigger.action.setUserFlag("LHA4-UH1 #003",00)
    trigger.action.setUserFlag("LHA4-KA50",00)
    trigger.action.setUserFlag("LHA4-KA50 #001",00)
    trigger.action.setUserFlag("LHA4-AV8",00)
    trigger.action.setUserFlag("LHA4-AV8 #001",00)
    trigger.action.setUserFlag("LHA4-AV8 #002",00)
    trigger.action.setUserFlag("LHA4-AV8 #003",00)
  end
 end
end

locklhab()
locklha4()
slot_tunb(1)
slot_sirri(1)
slot_lavan(1)
slot_kish(1)
slot_qeshm(1)
slot_khasab(2)
slot_bandar(1)
slot_lars(1)
slot_abun(2)
slot_havadarya(1)
airbases = {}
function SEH:OnEventBaseCaptured(EventData)
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
  -- local coalition = EventData.getCoalition()
 BASE:E({"Main Slot Controller BASE Captured Detected" .. AirbaseName,coalition})  
 if AirbaseName == AIRBASE.PersianGulf.Lar_Airbase then
    BASE:E({"Lars Slot Change"})
    slot_lars(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Sir_Abu_Nuayr then
    ctld.changeRemainingGroupsForPickupZone("CTLD Abu Nuayr", 3)
    slot_abun(2)    
 elseif AirbaseName == AIRBASE.PersianGulf.Sirri_Island then
    slot_sirri(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Abu_Musa_Island_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Abu Musa",3)
 elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Kochak then
    ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Kochak", 3)
 elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Island_AFB then
    slot_tunb(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Lavan_Island_Airport then
    slot_lavan(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Kish_International_Airport then
    slot_kish(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Qeshm_Island then
    slot_qeshm(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Khasab then
    slot_khasab(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl then
    slot_bandar(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Jiroft_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Jiroft", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Shiraz_International_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Shiraz", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Kerman_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Kerman", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Havadarya then
    slot_havadarya(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Bandar_Lengeh then
    slot_bandarlengeh(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Kerman_Airport then
    if coalition == 1 then
      if kerman == true then
        kerman = false
      end
    else
      if kerman == false then
        kerman = true
      end
    end
  elseif AirbaseName == AIRBASE.PersianGulf.Shiraz_International_Airport then
    if coalition == 1 then
      if shiraz == true then
        shiraz = false
      end
    else
      if shiraz == false then
        shiraz = true
      end
    end
 
 else
  local col = "Coalition"
  if coalition == 1 then
    col = "Iran"
    else
    col = "Coalition"
    end
  if airbases[AirbaseName] ~= coalition then
    BASE:E({"Warning Airbase: ".. AirbaseName .." was lost to .. " ..col.. ""})
    MESSAGE:New("Warning Airbase: ".. AirbaseName .." was lost to .. " ..col.. "",30):ToAll()
    HypeMan.sendBotMessage("Warning Airbase: ".. AirbaseName .." was lost to .. " ..col.. "")
    airbases[AirbaseName] = coalition
    if coalition == 2 then
     -- SCHEDULER:New(nil,spawnmainland,{},math.random(5,1200))
    end
  end
 end
 
 -- Do a check for all 4 red islands if there blue we want to switch on the 2 tarawa's and their slots
 checkislands()
end



function lh3:OnEventDead(EventData)
  BASE:E({"LHA3 end"})
  trigger.action.setUserFlag("LHA3-AV8",100)
  trigger.action.setUserFlag("LHA3-AV8 #001",100)
  trigger.action.setUserFlag("LHA3-AV8 #002",100)
  trigger.action.setUserFlag("LHA3-AV8 #003",100)
  trigger.action.setUserFlag("LHA3-KA50",100)
  trigger.action.setUserFlag("LHA3-KA50 #001",100)
  trigger.action.setUserFlag("LHA3-UH1",100)
  trigger.action.setUserFlag("LHA3-UH1 #001",100)
  trigger.action.setUserFlag("LHA3-UH1 #002",100)
  trigger.action.setUserFlag("LHA3-UH1 #003",100) 
  HypeMan.sendBotMessage("================= LHA3 DESTROYED ! Slots are now locked  ==================")
end

function lh4:OnEventDead(EventData)
  BASE:E({"LHA4 end"})
  trigger.action.setUserFlag("LHA4-UH1",100)
  trigger.action.setUserFlag("LHA4-UH1 #001",100)
  trigger.action.setUserFlag("LHA4-UH1 #002",100)
  trigger.action.setUserFlag("LHA4-UH1 #003",100)
  trigger.action.setUserFlag("LHA4-KA50",100)
  trigger.action.setUserFlag("LHA4-KA50 #001",100)
  trigger.action.setUserFlag("LHA4-AV8",100)
  trigger.action.setUserFlag("LHA4-AV8 #001",100)
  trigger.action.setUserFlag("LHA4-AV8 #002",100)
  trigger.action.setUserFlag("LHA4-AV8 #003",100)
  HypeMan.sendBotMessage("================= LHA4 DESTROYED ! Slots are now locked  ==================")
end


function GW:OnEventDead(EventData)
  if GW:IsAlive() ~= true then
  trigger.action.setUserFlag("GW_450",100)
  trigger.action.setUserFlag("GW_451",100)
  trigger.action.setUserFlag("GW_452",100)
  trigger.action.setUserFlag("GW_454",100)
  trigger.action.setUserFlag("GW_221",100)
  trigger.action.setUserFlag("GW_222",100)
  trigger.action.setUserFlag("GW_223",100)
  trigger.action.setUserFlag("GW_224",100)
  HypeMan.sendBotMessage("================= USS George Washington DESTROYED ! Slots are now locked  ==================")
  end
end

function stn:OnEventDead(EventData)
  if stn:IsAlive() ~= true then
    trigger.action.setUserFlag("STN_141",100)
    trigger.action.setUserFlag("STN_142",100)
    trigger.action.setUserFlag("STN_143",100)
    trigger.action.setUserFlag("STN_144",100)
    trigger.action.setUserFlag("STN_440",100)
    trigger.action.setUserFlag("STN_441",100)
    trigger.action.setUserFlag("STN_442",100)
    trigger.action.setUserFlag("STN_443",100)
    trigger.action.setUserFlag("STN_444",100)
  HypeMan.sendBotMessage("================= USS Stennis DESTROYED ! Slots are now locked  ==================")
    
  end
end
function lh2:OnEventDead(EventData)
  if lh2:IsAlive() ~= true then
    trigger.action.setUserFlag("STN-LHA2-Huey333",100)
    trigger.action.setUserFlag("STN-LHA2-Huey334",100)
    trigger.action.setUserFlag("STN-LHA2-Huey335",100)
    trigger.action.setUserFlag("STN-LHA2-Huey336",100)
    trigger.action.setUserFlag("STN-TAR-490",100)
    trigger.action.setUserFlag("STN-TAR-491",100)
    trigger.action.setUserFlag("STN-TAR-492",100)
    trigger.action.setUserFlag("STN-TAR-493",100)
    trigger.action.setUserFlag("STN-TAR-494",100)
  HypeMan.sendBotMessage("================= LHA2 in the Stennis Battlegroup DESTROYED ! Slots are now locked  ==================")
  end
end

function tdy:OnEventDead(EventData)
  if tdy:IsAlive() ~= true then
    trigger.action.setUserFlag("TDY_101",100)
    trigger.action.setUserFlag("TDY_102",100)
    trigger.action.setUserFlag("TDY_103",100)
    trigger.action.setUserFlag("TDY_104",100)
    trigger.action.setUserFlag("TDY_105",100)
    trigger.action.setUserFlag("TDY_106",100)
    trigger.action.setUserFlag("TDY_107",100)
    trigger.action.setUserFlag("TDY_108",100)
    trigger.action.setUserFlag("TDY_401",100)
    trigger.action.setUserFlag("TDY_402",100)
    trigger.action.setUserFlag("TDY_403",100)
    trigger.action.setUserFlag("TDY_404",100)
    trigger.action.setUserFlag("TDY_405",100)
    trigger.action.setUserFlag("TDY_406",100)
    trigger.action.setUserFlag("TDY_407",100)
    trigger.action.setUserFlag("TDY_408",100)
    trigger.action.setUserFlag("TDY_409",100)
    trigger.action.setUserFlag("TDY_410",100)
    trigger.action.setUserFlag("TDY_411",100)
    trigger.action.setUserFlag("TDY_412",100)
  HypeMan.sendBotMessage("================= USS Theodore Rosevolt DESTROYED ! Slots are now locked  ==================")
  end
end

function tar:OnEventDead(EventData)
  if tar:IsAlive() ~= true then
    trigger.action.setUserFlag("TDY-TAR-480",100)
    trigger.action.setUserFlag("TDY-TAR-481",100)
    trigger.action.setUserFlag("TDY-TAR-482",100)
    trigger.action.setUserFlag("TDY-TAR-484",100)
    trigger.action.setUserFlag("TDY-TAR-Huey-303",100)
    trigger.action.setUserFlag("TDY-TAR-Huey314",100)
    trigger.action.setUserFlag("TDY-TAR-Huey319",100)
    trigger.action.setUserFlag("TDY-TAR-Huey444",100)
    trigger.action.setUserFlag("TED-TAR-KA50-21",100)
    trigger.action.setUserFlag("TED-TAR-KA50-22",100)
    trigger.action.setUserFlag("TED-TAR-KA50-23",100)
    trigger.action.setUserFlag("TED-TAR-KA50-24",100)
    trigger.action.setUserFlag("TED-TAR-Mi8-55",100)
    trigger.action.setUserFlag("TED-TAR-Mi8-56",100)
    trigger.action.setUserFlag("TED-TAR-SA342L-44",100)
    trigger.action.setUserFlag("TED-TAR-SA342L-45",100)
    trigger.action.setUserFlag("TED-TAR-SA342Min-222",100)
    trigger.action.setUserFlag("TED-TAR-SA342Min-223",100)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-111",100)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-112",100)
    trigger.action.setUserFlag("TED-TAR-SA342m-66",100)
    trigger.action.setUserFlag("TED-TAR-SA342m-67",100)
  HypeMan.sendBotMessage("================= USS TARAWA Destroyed ! Slots are now locked  ==================")
  end
end


world.addEventHandler(SEH)

BASE:E({"SLOT HANDLER FOR PERSIA AFLAME LOADED"})









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
 --BASE:E({self.fobname,"Base capture"})
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
 --BASE:E({self.fobname,"Base capture",coalition})
 if AirbaseName == self.fobname then
  if coalition == 2 then
      if self:IsBlue() ~= true then
        self:FlipBlue()
        local col = "Coalition"
        COORDINATE:RemoveMark(self.marker)
		local co = self.fobunit:GetCoordinate()
        self.marker = co:MarkToAll("Helicopter Forward Operating Base, Currently Owned by: ".. col .."",true)
      end
  elseif coalition == 1 then
      if self:IsBlue() == true then
        self:FlipRed()
        local col = "Coalition"
        COORDINATE:RemoveMark(self.marker)
		local co = self.fobunit:GetCoordinate()
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

BASE:E({"FOB HANDLER DONE"})

SCHEDULER:New(nil,function()
BASE:E({"Loading is now false"})
Loading = false
 end,{},600)