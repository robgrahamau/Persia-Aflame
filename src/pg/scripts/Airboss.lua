BASE:E({"HYPEMAN LOAD"})
assert(loadfile("C:/HypeMan/HypeMan.lua"))() 
BASE:E({"HYPEMAN SHOULD BE LOADED"})

env.info("--------------Persia Aflame AIRBOSS CONTROLLER----------------------")
env.info("--------------By Robert Graham for TGW -------------------")
env.info("--------------LAST CHANGED IN VER: 0.69.00 -------------------")
env.info("--------------USES MOOSE AND CTDL ------------------------")

abossactive = true

if abossactive == true then

  awacsStennis = RECOVERYTANKER:New(UNIT:FindByName("Washington"), "USEW Magic11")
  awacsStennis:SetAWACS(true,true)
  awacsStennis:SetCallsign(CALLSIGN.AWACS.Magic,1)
  awacsStennis:SetTakeoffAir()
  awacsStennis:SetAltitude(20000)
  awacsStennis:SetRadio(250)
  awacsStennis:SetTACAN(44,"MGK")
  awacsStennis:SetSpeed(330)
  awacsStennis:Start()
  BASE:E("Stennis Tanker")
  
  ShellStennis = RECOVERYTANKER:New(UNIT:FindByName("Washington"), "Shell11")
  ShellStennis:SetCallsign(CALLSIGN.Tanker.Shell,1)
  ShellStennis:SetRespawnInAir()
  ShellStennis:SetSpeed(310)
  ShellStennis:SetRacetrackDistances(15,10)
  ShellStennis:SetPatternUpdateDistance(25)
  ShellStennis:SetRadio(255)
  ShellStennis:SetModex(911)
  ShellStennis:SetTACAN(9,"SHL")
  ShellStennis:Start()
  
  awacsTeddy = RECOVERYTANKER:New(UNIT:FindByName("TeddyR"), "USEW Wizard11")
  awacsTeddy:SetAWACS(true,true)
  awacsTeddy:SetTakeoffCold()
  awacsTeddy:SetCallsign(CALLSIGN.AWACS.Wizard,1)
  awacsTeddy:SetAltitude(20000)
  awacsTeddy:SetRadio(252)
  awacsTeddy:SetSpeed(350)
  awacsTeddy:SetTACAN(48,"WIZ")
  awacsTeddy:Start()
  
  ShellTeddy = RECOVERYTANKER:New(UNIT:FindByName("TeddyR"), "Shell21")
  ShellTeddy:SetTakeoffAir()
  ShellTeddy:SetCallsign(CALLSIGN.Tanker.Shell,2)
  ShellTeddy:SetSpeed(310)
  ShellTeddy:SetRadio(257)
  ShellTeddy:SetModex(910)
  ShellTeddy:SetTACAN(7,"SHL")
  ShellTeddy:SetLowFuelThreshold(0.2)
  ShellTeddy:Start()
  

  
AirbossWash = AIRBOSS:New("Washington","Washington")
AirbossWash:Load("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossWash:SetAutoSave("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossWash:SetTrapSheet("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossWash:SetLSORadio(118.45)
AirbossWash:SetMarshalRadio(306)
AirbossWash:SetTACAN(25,"X","NNGW")
AirbossWash:SetICLS(5,"WSH")
AirbossWash:SetAirbossNiceGuy(true)
AirbossWash:SetHandleAIOFF()
AirbossWash:SetWelcomePlayers(false)
AirbossWash:SetDefaultMessageDuration(1)
AirbossWash:SetEmergencyLandings(true)
AirbossWash:SetPatrolAdInfinitum(true)
AirbossWash:Start()


function AirbossWash:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
	myGrade.messageType = 2
	myGrade.name = playerData.name
	HypeMan.sendBotTable(myGrade)
end
  
AirbossTeddy = AIRBOSS:New("TeddyR","TeddyR")
AirbossTeddy:Load("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossTeddy:SetAutoSave("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossTeddy:SetTrapSheet("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossTeddy:SetLSORadio(118.40)
AirbossTeddy:SetMarshalRadio(304)
AirbossTeddy:SetTACAN(53,"X","TED")
AirbossTeddy:SetICLS(7,"RSE")
AirbossTeddy:SetAirbossNiceGuy(true)
AirbossTeddy:SetMenuRecovery(45,25,false,0)
AirbossTeddy:SetHoldingOffsetAngle(0)
AirbossTeddy:SetMaxSectionSize(4)
AirbossTeddy:SetPatrolAdInfinitum(true)
AirbossTeddy:SetRefuelAI(30)
AirbossTeddy:SetSoundfilesFolder("Airboss Soundfiles/")
AirbossTeddy:SetRecoveryTurnTime(120)
AirbossTeddy:SetDefaultPlayerSkill("TOPGUN Graduate")
AirbossTeddy:SetHandleAIOFF()
AirbossTeddy:SetWelcomePlayers(false)
AirbossTeddy:SetDefaultMessageDuration(1)
AirbossTeddy:SetRecoveryTurnTime(5)
AirbossTeddy:SetEmergencyLandings(true)
AirbossTeddy:SetWelcomePlayers(false)

function AirbossTeddy:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
	myGrade.messageType = 2
	myGrade.name = playerData.name
	HypeMan.sendBotTable(myGrade)
end

function AirbossTeddy:OnAfterStart(From,Event,To)
  self:DeleteAllRecoveryWindows()
end
AirbossTeddy:Start()

AirbossStennis = AIRBOSS:New("Stennis","Stennis")
-- Delete auto recovery window.

AirbossStennis:Load("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossStennis:SetAutoSave("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossStennis:SetTrapSheet("C:\\Users\\root\\Saved Games\\lsogrades\\")
AirbossStennis:SetMarshalRadio(305)
AirbossStennis:SetLSORadio(119.25)
AirbossStennis:SetTACAN(35,"X","STE")
AirbossStennis:SetICLS(3,"NIS")
AirbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")
AirbossStennis:SetAirbossNiceGuy(true)
AirbossStennis:SetRefuelAI(20)
AirbossStennis:SetMenuRecovery(30,25,false,0)
AirbossStennis:SetHoldingOffsetAngle(0)
AirbossStennis:SetRecoveryTanker(ShellStennis)
AirbossStennis:SetRecoveryTurnTime(300)
AirbossStennis:SetPatrolAdInfinitum(true)
AirbossStennis:SetHandleAIOFF()

function AirbossStennis:OnAfterStart(From,Event,To)
  self:DeleteAllRecoveryWindows()
end
--[[  CV_WASH = NAVYGROUP:New("Carrier Group 6a")
  CV_WASH:SetPatrolAdInfinitum(true)
  CV_TDY= NAVYGROUP:New("Carrier Group 5")
  CV_TDY:SetPatrolAdInfinitum(true)
]]
AirbossStennis:Start()


function AirbossStennis:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
	myGrade.messageType = 2
	myGrade.name = playerData.name
	HypeMan.sendBotTable(myGrade)
end

function AirbossStennis:OnAfterRecoveryStart(From,Event,To,Case,Offset)
    local timenow=timer.getAbsTime( )
    local timestart=timenow+5
    local timeend=timenow+30*60
    local timerecovery_start = UTILS.SecondsToClock(timestart,true)
    local timerecovery_end = UTILS.SecondsToClock(timeend,true)
    AirbossWash:AddRecoveryWindow(timerecovery_start,timerecovery_end,25,false,0)
	--CV_WASH:AddTurnIntoWind(timerecovery_start,timeend,25,false,0) ]]
end
end

