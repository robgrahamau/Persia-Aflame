
env.info("--------------Persia Aflame AIRBOSS CONTROLLER----------------------")
env.info("--------------By Robert Graham for TGW -------------------")
env.info("--------------LAST CHANGED IN VER: 1.26.00 -------------------")
env.info("--------------USES MOOSE AND CTDL ------------------------")

abossactive = true
washingtonactive = true
teddyairboss = true
forestairboss = true
useawacs = false

if abossactive == true then
	if useawacs == true then
  awacsStennis = RECOVERYTANKER:New(UNIT:FindByName("Washington"), "USEW Magic11")
  awacsStennis:SetAWACS(true,true)
  awacsStennis:SetCallsign(CALLSIGN.AWACS.Magic,1)
  awacsStennis:SetRecoveryAirboss(false)
  awacsStennis:SetTakeoffAir()
  awacsStennis:SetAltitude(20000)
  awacsStennis:SetRadio(250)
  awacsStennis:SetModex(332)
  -- awacsStennis:SetTACAN(44,"MGK")
  awacsStennis:SetSpeed(330)
  awacsStennis:Start()
  
  
  awacsTeddy = RECOVERYTANKER:New(UNIT:FindByName("TeddyR"), "USEW Wizard11")
  awacsTeddy:SetAWACS(true,true)
  awacsTeddy:SetTakeoffAir()
  awacsTeddy:SetRecoveryAirboss(false)
  awacsTeddy:SetCallsign(CALLSIGN.AWACS.Wizard,1)
  ShellTeddy:SetRespawnInAir()
  awacsTeddy:SetAltitude(20000)
  awacsTeddy:SetRadio(252)
  awacsTeddy:SetSpeed(350)
  awacsTeddy:SetModex(232)
  --awacsTeddy:SetTACAN(48,"WIZ")
  awacsTeddy:Start()
  
	end
  
  BASE:E("Stennis Tanker")
  
  ShellStennis = RECOVERYTANKER:New(UNIT:FindByName("Washington"), "Shell11")
  ShellStennis:SetCallsign(CALLSIGN.Tanker.Shell,1)
  ShellStennis:SetTakeoffCold()
  ShellStennis:SetSpeed(310)
  ShellStennis:SetRacetrackDistances(15,10)
  ShellStennis:SetPatternUpdateDistance(15)
  ShellStennis:SetRecoveryAirboss(false)
  ShellStennis:SetRadio(255)
  ShellStennis:SetModex(913)
  ShellStennis:SetTACAN(49,"SHL")
  ShellStennis:Start()
  
  
  ShellTeddy = RECOVERYTANKER:New(UNIT:FindByName("TeddyR"), "Shell21")
  ShellTeddy:SetRecoveryAirboss(false)
  ShellTeddy:SetCallsign(CALLSIGN.Tanker.Shell,2)
  ShellTeddy:SetSpeed(310)
  ShellTeddy:SetRadio(257)
  ShellTeddy:SetModex(910)
  ShellTeddy:SetTACAN(47,"SHL")
  ShellTeddy:SetLowFuelThreshold(0.05)
  ShellTeddy:SetRespawnInAir()
  ShellTeddy:SetTakeoffAir()
  ShellTeddy:Start()
  if useforest == true then
  ShellForest = RECOVERYTANKER:New(UNIT:FindByName("Forrestal"), "Shell21")
  ShellForest:SetTakeoffCold()
  ShellForest:SetRecoveryAirboss(false)
  ShellForest:SetCallsign(CALLSIGN.Tanker.Shell,3)
  ShellForest:SetSpeed(310)
  ShellForest:SetRadio(259)
  ShellForest:SetModex(910)
  ShellForest:SetTACAN(62,"SH3")
  ShellForest:SetLowFuelThreshold(0.2)
  ShellForest:Start()
	end
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
	AirbossWash:SetMPWireCorrection(12)
	AirbossWash:setdisplaymessage(false)
	if washingtonactive == true then
		AirbossWash:Start()
		hm("Washington Airboss has been activated. \n > LSO is Now online on 118.45, Marshall 306 \n > TACAN 25x > ICLS 5 > RECOVERY PERIOD: 30 Minutes > Recovery Speed: 25 Knots")
	else
		CV_WASH = NAVYGROUP:New("Carrier Group 6a")
		CV_WASH:SetPatrolAdInfinitum(true)
		hm("Not using Airboss just patrolling forever")
	end

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
	AirbossTeddy:SetBeaconRefresh(600)
	AirbossTeddy:SetICLS(7,"RSE")
	AirbossTeddy:SetAirbossNiceGuy(true)
	AirbossTeddy:SetMenuRecovery(45,25,false,0)
	AirbossTeddy:SetHoldingOffsetAngle(0)
	AirbossTeddy:SetMaxSectionSize(4)
	AirbossTeddy:SetPatrolAdInfinitum(true)
	AirbossTeddy:SetRefuelAI(30)
	AirbossTeddy:SetSoundfilesFolder("Airboss Soundfiles/")
	AirbossTeddy:SetDefaultPlayerSkill("TOPGUN Graduate")
	AirbossTeddy:SetHandleAIOFF()
	AirbossTeddy:SetWelcomePlayers(false)
	AirbossTeddy:SetDefaultMessageDuration(1)
	AirbossTeddy:SetRecoveryTurnTime(60)
	AirbossTeddy:SetEmergencyLandings(true)
	AirbossTeddy:SetWelcomePlayers(false)
	AirbossTeddy:SetMPWireCorrection(12)
	AirbossTeddy:setdisplaymessage(false)
	function AirbossTeddy:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
		myGrade.messageType = 2
		myGrade.name = playerData.name
		HypeMan.sendBotTable(myGrade)
	end

	function AirbossTeddy:OnAfterStart(From,Event,To)
		self:DeleteAllRecoveryWindows()
	end
	if teddyairboss == true then
		AirbossTeddy:Start()
		hm("TEDDY's Airboss has been activated. \n > LSO is Now online on 118.40, Marshall 304 \n > TACAN 53x > ICLS 7 > RECOVERY PERIOD: 45 Minutes > Recovery Speed: 20 Knots")
		hm("Airboss is started for Teddy, 118.40, 304, 53x, 7ICLS")
	else
		CV_TDY= NAVYGROUP:New("Carrier Group 5")
		CV_TDY:SetPatrolAdInfinitum(true) 
		hm("Airboss is not started for Teddy, running on Navygroup patrol ad infinitum")
	end
	
	AirbossForest = AIRBOSS:New("Forrestal","Forrestal")
	AirbossForest:Load("C:\\Users\\root\\Saved Games\\lsogrades\\")
	AirbossForest:SetAutoSave("C:\\Users\\root\\Saved Games\\lsogrades\\")
	AirbossForest:SetTrapSheet("C:\\Users\\root\\Saved Games\\lsogrades\\")
	AirbossForest:SetLSORadio(118.00)
	AirbossForest:SetMarshalRadio(306)
	AirbossForest:SetTACAN(59,"X","FOR")
	AirbossForest:SetBeaconRefresh(600)
	AirbossForest:SetICLS(3,"EST")
	AirbossForest:SetAirbossNiceGuy(true)
	AirbossForest:SetMenuRecovery(45,25,false,0)
	AirbossForest:SetHoldingOffsetAngle(0)
	AirbossForest:SetMaxSectionSize(4)
	AirbossForest:SetPatrolAdInfinitum(true)
	AirbossForest:SetRefuelAI(15)
	--AirbossForest:SetSoundfilesFolder("Airboss Soundfiles/")
	AirbossForest:SetDefaultPlayerSkill("TOPGUN Graduate")
	AirbossForest:SetHandleAIOFF()
	AirbossForest:SetWelcomePlayers(false)
	AirbossForest:SetDefaultMessageDuration(1)
	AirbossForest:SetRecoveryTurnTime(60)
	AirbossForest:SetEmergencyLandings(true)
	AirbossForest:SetWelcomePlayers(false)
	AirbossForest:SetMPWireCorrection(12)
	AirbossForest:setdisplaymessage(false)
	
	function AirbossForest:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
		myGrade.messageType = 2
		myGrade.name = playerData.name
		HypeMan.sendBotTable(myGrade)
	end
	if forestairboss == true then
		AirbossForest:Start()
		hm("Forestalls Airboss has been activated. \n > LSO is Now online on 118.00, Marshall 305 \n > TACAN 59x > ICLS 2 > RECOVERY PERIOD: 45 Minutes > Recovery Speed: 20 Knots")
		hm("Airboss is started for Teddy, 118.40, 304, 53x, 7ICLS")
	end
	
	
	
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
	AirbossStennis:SetMPWireCorrection(12)
	function AirbossStennis:OnAfterStart(From,Event,To)
		self:DeleteAllRecoveryWindows()
	end
	AirbossStennis:Start()
	hm("Back of the Bus (Stennis) Airboss has been activated. \n > LSO is Now online on 119.25, Marshall 305 \n > TACAN 35x > ICLS 3 > RECOVERY PERIOD: 30 Minutes > Recovery Speed: 25 Knots")
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
		if washingtonactive == true then
			AirbossWash:AddRecoveryWindow(timerecovery_start,timerecovery_end,25,false,0)
		else
			CV_WASH:AddTurnIntoWind(timerecovery_start,timeend,25,false,0) 
		end
	end
end

