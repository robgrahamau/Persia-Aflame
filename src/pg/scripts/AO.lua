-- Current Fobs BQ99, BR31, BS02 BQ26, CQ37
-- ANY FARP that is not active needs to be deactived in here
AOBOUNDRY = {
    topleftx=198295,
    topleftz=-325539,
    bottomrightx=32270,
    bottomrightz=-107193,
    boundrycolor1 = {234,63,247},
    boundrycolor2 = {234,63,247},
}
_aobox = highlightarea(AOBOUNDRY.topleftx, AOBOUNDRY.topleftz, AOBOUNDRY.bottomrightx, AOBOUNDRY.bottomrightz ,-1,AOBOUNDRY.boundrycolor1,0.5,AOBOUNDRY.boundrycolor2,0.35,3,nil) -- Kish/Western AO

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
BN85:Deactivate()
--BQ26:Deactivate()
BQ51:Deactivate()
--BQ99:Deactivate()
--BR31:Deactivate()
--BS02:Deactivate()
CT75:Deactivate()
DP05:Deactivate()
DR35:Deactivate()
DS34:Deactivate()
DU06:Deactivate()
EP36:Deactivate()
EQ13:Deactivate()
ER00:Deactivate()
FR47:Deactivate()
--YK65:Deactivate()
YN50:Deactivate()
CR43:Deactivate()
CR71:Deactivate()
--CQ37:Deactivate()
CQ34:Deactivate()
CS80:Deactivate()
DQ28:Deactivate()
DQ49:Deactivate()
EQ47:Deactivate()
ER41:Deactivate()
EP99:Deactivate()
EQ97:Deactivate()
ER68:Deactivate()
EQ53:Deactivate()

FQ43:Deactivate() 
ER84:Deactivate() 
DR84:Deactivate() 
ER27:Deactivate() 
DS30:Deactivate() 
ES21:Deactivate() 
ES84:Deactivate() 
FT31:Deactivate() 
RKM09:Deactivate()
GS04:Deactivate() 
GR56:Deactivate()
GQ06:Deactivate()
FP84:Deactivate()
CBH:Deactivate()
ISR:Deactivate()
