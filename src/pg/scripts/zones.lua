-- All Persia Zones.


capzone1 = ZONE_POLYGON:New("CAP1",GROUP:FindByName("CAP1"))
capzone2 = ZONE_POLYGON:New("CAP2",GROUP:FindByName("CAP2")) 
capzone3 = ZONE_POLYGON:New("CAP3",GROUP:FindByName("CAP3")) 
capzone4 = ZONE_POLYGON:New("CAP4",GROUP:FindByName("CAP4")) 
capzone5 = ZONE_POLYGON:New("CAP5",GROUP:FindByName("CAP5"))
capzone6 = ZONE_POLYGON:New("CAP6",GROUP:FindByName("CAP6")) 
capzone7 = ZONE_POLYGON:New("CAP7",GROUP:FindByName("CAP7"))
capzonecow = ZONE_POLYGON:NewFromGroupName("Cow_AS")
BAS = ZONE_POLYGON:NewFromGroupName("AS1")
CV1_CAP = ZONE_POLYGON:NewFromGroupName("CV1_CAP")
CV2_CAP = ZONE_POLYGON:NewFromGroupName("CV2_CAP")
T_CAP = ZONE_POLYGON:NewFromGroupName("T_CAP") 
ZONE0 = ZONE_POLYGON:New("AA_SPAWNZONE1",GROUP:FindByName("AA_SPAWNZONE1"))
ZONE1 = ZONE_POLYGON:New("AA_SPAWNZONE2",GROUP:FindByName("AA_SPAWNZONE2"))
ZONE2 = ZONE_POLYGON:New("AA_SPAWNZONE3",GROUP:FindByName("AA_SPAWNZONE3"))
ZONE3 = ZONE_POLYGON:New("AA_City_Spawn_1",GROUP:FindByName("AA_City_Spawn_1"))
ZONE4 = ZONE_POLYGON:New("AA_City_Spawn_2",GROUP:FindByName("AA_City_Spawn_2"))
ZONE5 = ZONE_POLYGON:New("AA_City_Spawn_3",GROUP:FindByName("AA_City_Spawn_3"))
ZONE6 = ZONE_POLYGON:New("AA_City_Spawn_4",GROUP:FindByName("AA_City_Spawn_4"))
ZONE7 = ZONE_POLYGON:New("AA_City_Spawn_5",GROUP:FindByName("AA_City_Spawn_5"))
ZONE8 = ZONE_POLYGON:New("QZONE",GROUP:FindByName("QZONE"))


BCarrierTEMP = {"T_Hornet1","T_Hornet2"}
BLandTemp = {"T_F15","T_F16"}



function randomform()
  local rndnum = math.random(1,7)
  BASE:E({"Random Form number is",rndnum})
  if rndnum == 1 then
    return "Off road"
  elseif rndnum == 2 then
    return "Line abreast"
  elseif rndnum == 3 then
    return "Cone"
  elseif rndnum == 4 then
    return "Vee"
  elseif rndnum == 5 then
    return "Diamond"
  elseif rndnum == 6 then
    return "Echelon Left"
  elseif rndnum == 7 then
    return "Echelon Right"
  else
    return "Off road"   
  end  
  -- return "Off road" -- try and fix the @$@ routing issues of late.
end
--rbg = SET_GROUP:New():FilterCoalitions("red"):FilterActive(true):FilterStart()
--abg = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterStart()
--[[
function routegroups(_coord,dist,coalition)
	local gunits = nil
	if coalition:lower() == "blue" then
		gunits = abg:FilterCategoryGround():FilterActive(true):FilterOnce()
	else
		gunits = rbg:FilterCategoryGround():FilterActive(true):FilterOnce()
	end
	if gunits ~= nil then
		gunits:ForEach(function(g)  
			if g:IsAlive() == true then
				local _group = GROUP:FindByName(g:GetName())
				gc = _group:GetCoordinate()
				if gc == nil then
					BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
				else
					local d = gc:Get2DDistance(_coord)
					if d < dist then
						local rcoord = _coord:GetRandomCoordinateInRadius(500,100)
						g:RouteGroundTo(rcoord,math.random(10,20),randomform(),5)
					end
				end
			end
		end)
	end
end

]]

function spawnctld(airbase,country,heading,distance)
	if heading == nil then
		heading = math.random(0,359)
	else 
	local minh = heading - 5 
	if minh < 0 then minh = minh + 360 end
	local maxh = heading + 5
	if maxh > 360 then maxh = maxh - 360 end
		heading = math.random(minh, maxh)
	end
	if distance == nil then
		distance = math.random(200,750)
	end
	local ab = AIRBASE:FindByName(airbase)
	local co = ab:GetCoordinate()
	local nco = co:Translate(distance,heading,false,false)
	local vec3 = nco:GetVec3()
	local _unitId = ctld.getNextUnitId()
	local _name = "ctld Deployed FOB #" .. _unitId
	local _fob = nil
	_fob = ctld.spawnFOB(country, 211, vec3, _name)
	table.insert(ctld.logisticUnits, _fob:getName())
	if ctld.troopPickupAtFOB == true then
		table.insert(ctld.builtFOBS, _fob:getName())
	end
end