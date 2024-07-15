-- Current Fobs BQ99, BR31, BS02 BQ26, CQ37
-- ANY FARP that is not active needs to be deactived in here

AOBOUNDRY = {
	topleftx=117310,
	topleftz=-191922,
	bottomrightx=-122960,
	bottomrightz=41111,
	boundrycolor1 = {234,63,247},
	boundrycolor2 = {234,63,247},
}

_aobox = highlightarea(AOBOUNDRY.topleftx, AOBOUNDRY.topleftz, AOBOUNDRY.bottomrightx, AOBOUNDRY.bottomrightz ,-1,AOBOUNDRY.boundrycolor1,0.5,AOBOUNDRY.boundrycolor2,0.35,3,nil) -- Kish/Western AO

AOBOUNDRY2 = {
	topleftx=121055,
	topleftz=-293982,
	bottomrightx=-3621,
	bottomrightz=-192318,
	boundrycolor1 = {234,63,247},
	boundrycolor2 = {234,63,247},
}


USEAO2 = true
_aobox2 = nil
--COORDINATE:RemoveMark(_aobox)
if USEAO2 == true then
	_aobox2 = highlightarea(AOBOUNDRY2.topleftx, AOBOUNDRY2.topleftz, AOBOUNDRY2.bottomrightx, AOBOUNDRY2.bottomrightz ,-1,AOBOUNDRY2.boundrycolor1,0.5,AOBOUNDRY2.boundrycolor2,0.35,3,nil) -- Kish/Western AO
end

-- Dynamically Drawn Intel Zones.
BASE:E({"BlueGroundForces"})
	BlueGroundForces = SET_GROUP:New():FilterCategories("ground"):FilterCoalitions("blue"):FilterStart()
	BlueGroundForces:ForEachGroup(function(_group) BASE:E({_group:GetName()}) end)
	BASE:E({"StestZone"})
	bluezone = ZONE_ELASTIC:New("Blue Force Zone")
	bluezone:AddSetGroup(BlueGroundForces)
	bluezone:SetColor({0,0,1}, 0.15)
	bluezone:SetFillColor({0,0,1}, 0.15)
	bluezone:StartUpdate(0,300,nil,true)
	

	RedGroundForces = SET_GROUP:New():FilterCategories("ground"):FilterCoalitions("red"):FilterStart()
	RedGroundForces:ForEachGroup(function(_group) BASE:E({_group:GetName()}) end)
	BASE:E({"StestZone"})
	redzone = ZONE_ELASTIC:New("Red Force Zone")
	redzone:AddSetGroup(RedGroundForces)
	redzone:SetColor({1,0,0}, 0.15)
	redzone:SetFillColor({1,0,0}, 0.15)
	redzone:StartUpdate(0,300,nil,true)

-- FARP DEACTIVATION


--CQ37:Deactivate()
--CQ34:Deactivate()
CR43:Deactivate()
--CR71:Deactivate()
CS80:Deactivate()
--BN85:Deactivate()
--BQ26:Deactivate()
--BQ51:Deactivate()
--BQ99:Deactivate()
--BR31:Deactivate()
BS02:Deactivate()
--CT75:Deactivate()
--DP05:Deactivate()
--DQ28:Deactivate()
--DQ49:Deactivate()
DR35:Deactivate()
--DR84:Deactivate() 
DS34:Deactivate()
DS30:Deactivate() 
--DU06:Deactivate()

--EP36:Deactivate()
EQ13:Deactivate()
EQ47:Deactivate()
ER84:Deactivate() 
ER00:Deactivate()

ER41:Deactivate()
EP99:Deactivate()
EQ97:Deactivate()
ER68:Deactivate()
EQ53:Deactivate()
ER27:Deactivate() 
ES21:Deactivate() 
ES84:Deactivate() 
FP84:Deactivate()
FQ43:Deactivate() 
FT31:Deactivate() 
FR47:Deactivate()
GQ06:Deactivate()
GS04:Deactivate() 
GR56:Deactivate()
--YK65:Deactivate()
--YN50:Deactivate()
--RKM09:Deactivate()

CBH:Deactivate()
ISR:Deactivate()



--ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf["Qeshm_Island"])
-- ABItem:SetAutoCaptureOFF()
-- ABItem:SetCoalition(1)
ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf["Bandar_Abbas_Intl"])
ABItem:SetAutoCaptureOFF()
ABItem:SetCoalition(1)
ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf["Havadarya"])
ABItem:SetAutoCaptureOFF()
ABItem:SetCoalition(1)
ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf["Al_Minhad_AB"])
ABItem:SetAutoCaptureOFF()
ABItem:SetCoalition(2)
ABItem = AIRBASE:FindByName(AIRBASE.PersianGulf["Al_Dhafra_AB"])
ABItem:SetAutoCaptureOFF()
ABItem:SetCoalition(2)