--[[
To Do:
Rewrite this so that it can be used for both red and blue
Port over the rest of the actual main script so that it's not just the admin version.
Find a way to track if it's been destroyed or not.
]]


farpcounter = 0


function SPAWNFARP(coord,_col,_country)
	local FarpHDG = 3.1764992386297
	local radios ={127.5,125.25,129.25}
	local FARPLocationVect = coord:GetVec2()
	-- increase our counter we also
    farpcounter = farpcounter + 1
	local temptable = {
		FarpAX = FARPLocationVect.x,
		FarpAY = FARPLocationVect.y,
	}
	
    MESSAGE:New("A FARP Convoy has arrived at it's destination and is setting up a new FARP",30):ToBlue()
    local vehiclevect = coord:Translate(40,0)
    local SpawnServiceVehicles = SPAWN:NewWithAlias("t_farpgroup","FarpServiceVechiles" .. farpcounter):SpawnFromCoordinate(vehiclevect)    
    FPSpawnStatic("Farp1_ComandPost_" .. farpcounter .. "","kp_ug","Fortifications","FARP CP Blindage",100,(temptable.FarpAX - -46.022111867),(temptable.FarpAY - -9.20689690),(FarpHDG - 1.6057029118348))
    FPSpawnStatic("Farp1_Generator1_" .. farpcounter .. "","GeneratorF","Fortifications","GeneratorF",100,(temptable.FarpAX - -7.522753786),(temptable.FarpAY - -37.85968299),(FarpHDG -1.5358897417550))
    FPSpawnStatic("Farp1_Tent1_" .. farpcounter .. "","PalatkaB","Fortifications","FARP Tent",50,(temptable.FarpAX - -42.785309231),(temptable.FarpAY - -9.12264485),(FarpHDG - 1.6057029118348))  
    FPSpawnStatic("Farp1_CoveredAmmo1_" .. farpcounter .. "","SetkaKP","Fortifications","FARP Ammo Dump Coating",50,(temptable.FarpAX - 35.293756408),(temptable.FarpAY - 57.35770154),(FarpHDG - 3.1590459461098))
    FPSpawnStatic("Farp1_Tent2_" .. farpcounter .. "","PalatkaB","Fortifications","FARP Tent",50,(temptable.FarpAX - -49.432834216),(temptable.FarpAY - -9.14503574),(FarpHDG - 1.6057029118348))
    FPSpawnStatic("Farp1_Wsock1_" .. farpcounter .. "","H-Windsock_RW","Fortifications","Windsock",3,(temptable.FarpAX - 43.70051151),(temptable.FarpAY -  2.35458818),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre1_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.52339492),(temptable.FarpAY - 41.91442888),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre2_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.51502196),(temptable.FarpAY - 13.74232991),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre3_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.27681096),(temptable.FarpAY - -22.30693542),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre4_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 44.69212731),(temptable.FarpAY - 27.50978001),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre5_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.37543603),(temptable.FarpAY - -7.37904581),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre6_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.19740729),(temptable.FarpAY - 27.55856816),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre7_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.41098563),(temptable.FarpAY - -7.37904581),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre8_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.07919727),(temptable.FarpAY - 41.59167618),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre9_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.37543603),(temptable.FarpAY - 27.71737550),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre10_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.21662870),(temptable.FarpAY - 7.15182545),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre11_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 44.77786563),(temptable.FarpAY - -8.33188983),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre12_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 9.87567332),(temptable.FarpAY - 17.86661589),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre13_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.19740729),(temptable.FarpAY - -8.17308250),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre14_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.31389554),(temptable.FarpAY - 7.09103057),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre15_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.41098563),(temptable.FarpAY - 27.63797183),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre16_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 44.61905829),(temptable.FarpAY - 13.74232991),(FarpHDG ))
    FPSpawnStatic("Farp1_Tyre17_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 43.93118389),(temptable.FarpAY - -22.67033198),(FarpHDG )) 
    FPSpawnFarpBuilding("Farp_Heliport_" ..farpcounter .. "","invisiblefarp","Heliports","Invisible FARP",radios[farpcounter],0,farpcounter,(temptable.FarpAX - 0.00000000),(temptable.FarpAY - 0.00000000),(FarpHDG))
    BASE:E({self.name,"Spawned Farp",farpcounter})
 end
   
  function FPSpawnFarpBuilding(_name,_shape,_cat,_type,_radio,_modulation,_callsign,_x,_y,_heading)
    local staticObj = {
      ["name"] = _name , --unit name (Name this something identifying some you can find it later)
      ["category"] = _cat,
      ["shape_name"] = _shape,
      ["type"] = _type,
      ["heliport_frequency"] = _radio,
      ["x"] = _x,
      ["y"] = _y,
      ["heliport_modulation"] = _modulation,
      ["heliport_callsign_id"] = _callsign,
      ["heading"] = _heading,
           -- These can be left as is, but is required
      ["groupId"] = 1,          --id's of the group/unit we're spawning  (will auto increment if id is taken?)
          ["unitId"] = 1,
          ["dead"] = false,
    }
    coalition.addStaticObject(country.id.USA, staticObj)

  end
  -- spawns all our statics.
  function FPSpawnStatic(_name,_shape,_cat,_type,_rate,_x,_y,_heading)
    local staticObj = {
      ["name"] = _name , --unit name (Name this something identifying some you can find it later)
      ["category"] = _cat,
      ["shape_name"] = _shape,
      ["type"] = _type,
      ["rate"] = _rate,
      ["x"] = _x,
      ["y"] = _y,
      ["heading"] = _heading,
      ["groupId"] = 1,          --id's of the group/unit we're spawning  (will auto increment if id is taken?)
      ["unitId"] = 1,
      ["dead"] = false,
     }
     coalition.addStaticObject(country.id.USA, staticObj)
  end
