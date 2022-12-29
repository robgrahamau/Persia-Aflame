env.info("moosectld.lua")
-- moose ctld

bluectld= CTLD:New(coalition.side.BLUE,{"Super","super","SUPER",},"Transport Command")
bluectld.useprefix = false
bluectld.CrateDistance = 100
bluectld.dropcratesanywhere = true
bluectld.maximumHoverHeight = 15
bluectld.minimumHoverHeight = 3
bluectld.forcehoverload = false
bluectld.smokedistance = 2000
bluectld.repairtime = 300
bluectld.cratecountry = country.id.CJTF_BLUE
bluectld.allowcratepickupagain = true
bluectld.enableslingload = false
bluectld.pilotmustopendoors = false
bluectld.usesubcats = true
bluectld.basetype = "container_cargo"
bluectld.EngineerSearch = 2000
bluectld:UnitCapabilities("UH-60L",true,true,2,14,16,3500)
bluectld:UnitCapabilities("UH-1H",true,true,1,8,16,1000)
bluectld:Start()

bluectld:AddTroopsCargo("us platoon",{"us platoon"},CTLD_CARGO.Enum.TROOPS,12,100,10,"Troops")
bluectld:AddTroopsCargo("us manpad",{"us manpad"},CTLD_CARGO.Enum.TROOPS,6,100,10,"Troops")
bluectld:AddTroopsCargo("us engineers",{"us engineers"},CTLD_CARGO.Enum.ENGINEERS,4,80,10,"Troops")

bluectld:AddCratesCargo("Patriot",{"patriot"},CTLD_CARGO.Enum.FOB,24,750,50,"SAM SYSTEMS")
bluectld:AddCratesCargo("Hawk",{"hawk"},CTLD_CARGO.Enum.FOB,16,750,34,"SAM SYSTEMS")
bluectld:AddCratesCargo("NASAM",{"nasam"},CTLD_CARGO.Enum.FOB,8,750,26,"SAM SYSTEMS")
bluectld:AddCratesCargo("Service Vehicles",{"servicevehicletemplate"},CTLD_CARGO.Enum.VEHICLE,18,500,4,"Command & Control")
bluectld:AddCratesCargo("FPS117",{"fps117"},CTLD_CARGO.Enum.FOB,12,600,12,"Command & Control")
bluectld:AddCratesRepair("Patriot Repair","patriot",CTLD_CARGO.Enum.REPAIR,8,500,30,"Repair")
bluectld:AddCratesRepair("Hawk Repair","hawk",CTLD_CARGO.Enum.REPAIR,6,500,30,"Repair")
bluectld:AddCratesRepair("NASAM Repair","nasam",CTLD_CARGO.Enum.REPAIR,3,500,30,"Repair")

bluectld:AddCTLDZone("tanf",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,false)
bluectld:AddCTLDZone("h3",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,false)
bluectld:AddCTLDZone("palmyra",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,false,false)
bluectld:AddCTLDZone("ezor",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,false,false)



redctld = CTLD:New(coalition.side.RED,{"Epsilon","epsilon","EPSILON"},"Syrian Transport Command")
redctld.useprefix = false
redctld.CrateDistance = 100
redctld.dropcratesanywhere = true
redctld.maximumHoverHeight = 15
redctld.minimumHoverHeight = 3
redctld.forcehoverload = false
redctld.smokedistance = 2000
redctld.repairtime = 300
redctld.cratecountry = country.id.CJTF_RED
redctld.allowcratepickupagain = true
redctld.enableslingload = false
redctld.pilotmustopendoors = false
redctld.usesubcats = true
redctld.basetype = "container_cargo"
redctld.EngineerSearch = 2000
redctld:UnitCapabilities("UH-60L",true,true,2,14,16,3500)
redctld:UnitCapabilities("UH-1H",true,true,1,8,16,1000)
redctld:Start()

redctld:AddTroopsCargo("Syrian platoon",{"syrian platoon"},CTLD_CARGO.Enum.TROOPS,12,100,10,"Troops")
redctld:AddTroopsCargo("Syrian manpad",{"syrian manpad"},CTLD_CARGO.Enum.TROOPS,6,100,10,"Troops")
redctld:AddTroopsCargo("Syrian engineers",{"syrian engineers"},CTLD_CARGO.Enum.ENGINEERS,4,80,10,"Troops")

redctld:AddCratesCargo("SA5",{"sa5"},CTLD_CARGO.Enum.FOB,30,750,45,"SAM SYSTEMS")
redctld:AddCratesCargo("SA10",{"sa10"},CTLD_CARGO.Enum.FOB,24,750,52,"SAM SYSTEMS")
redctld:AddCratesCargo("SA3",{"sa3"},CTLD_CARGO.Enum.FOB,18,750,40,"SAM SYSTEMS")
redctld:AddCratesCargo("SA2",{"sa2"},CTLD_CARGO.Enum.FOB,18,750,40,"SAM SYSTEMS")
redctld:AddCratesCargo("Service Vehicles",{"servicevehicletemplate"},CTLD_CARGO.Enum.VEHICLE,18,500,4,"Command & Control")
redctld:AddCratesRepair("SA5 Repair","sa5",CTLD_CARGO.Enum.REPAIR,10,500,30,"Repair")
redctld:AddCratesRepair("SA10 Repair","sa10",CTLD_CARGO.Enum.REPAIR,8,500,30,"Repair")
redctld:AddCratesRepair("SA3 Repair","sa3",CTLD_CARGO.Enum.REPAIR,6,500,30,"Repair")
redctld:AddCratesRepair("SA2 Repair","sa2",CTLD_CARGO.Enum.REPAIR,6,500,30,"Repair")

redctld:AddCTLDZone("tanf",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,false,false)
redctld:AddCTLDZone("palmyra",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,false)
redctld:AddCTLDZone("ezor",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,false)
BASE:E({"Injecting red CTLD"})
prespawnsa10 = CTLD_CARGO:New(nil,"SA10",{"sa10"},CTLD_CARGO.Enum.FOB,true,true,24,nil,false,750,3,"SAM SYSTEMS")
redctld:InjectVehicles(ZONE:New("sa10"),prespawnsa10)
redctld:InjectVehicles(Z_PALSA10,prespawnsa10)


env.info("moosectld.lua end")