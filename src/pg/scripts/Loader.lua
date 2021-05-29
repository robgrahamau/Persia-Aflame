
carrier5dead = false
carrier6dead = false
carrier6adead = false
kuzremoved = false

env.info("Persia Aflame Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
env.info("Loading MOOSE")
dofile(lfs.writedir() .."pg\\scripts\\Moose.lua")
env.info("Loading MIST")
dofile(lfs.writedir() .."pg\\scripts\\mist_4_3_74.lua")

env.info("hHypeMan")
assert(loadfile("C:/HypeMan/HypeMan.lua"))() 
HypeMan.sendBotMessage("**Persia Aflame is Starting.....** \n > MOOSE,MIST AND CinCServer Already Loaded")

function hm(msg)
	HypeMan.sendBotMessage(msg)
end
HypeMan.sendBotMessage("> Hazel Link Starting.....")
dofile(lfs.writedir() .."pg\\scripts\\cinc_loader.lua") 
CinCServer.start("139.99.144.189", 3050)
HypeMan.sendBotMessage("> Persia Aflame is SRS.lua")
dofile(lfs.writedir() .. [[pg\scripts\srs.lua]])
env.info("Loading Peristence")
hm("> Persia Aflame CTLD.lua")
dofile(lfs.writedir() .. [[pg\scripts\CTLD.lua]])
hm("> Persia Aflame sqns.lua")
dofile(lfs.writedir() .. [[pg\scripts\sqns.lua]])
hm("> Persia Aflame airboss.lua")
dofile(lfs.writedir() .. [[pg\scripts\Airboss.lua]])
hm("> Persia Aflame ADS.lua")
dofile(lfs.writedir() .. [[pg\scripts\ADS.lua]])
hm("> Persia Aflame slothandler1.lua")
dofile(lfs.writedir() .. [[pg\scripts\slothandler1.lua]])
hm("> Persia Aflame simple_groupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_groupsaving.lua]])
hm("> Persia Aflame simple_ctldgroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_ctldgroupsaving.lua]])
hm("> Persia Aflame simple_admingroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_admingroupsaving.lua]])
hm("> Persia Aflame simplestaticsaving.lua")
--dofile(lfs.writedir() .. [[pg\scripts\simplestaticsaving.lua]])
hm("> Persia Aflame simple_scenery_persistence.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_scenery_persistence.lua]])
hm("> Persia Aflame ctld_static_save.lua")
--dofile(lfs.writedir() .. [[pg\scripts\ctld_static_save.lua]])
--hm("> Persia Aflame simple_mpadgroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_mpadgroupsaving.lua]])
hm("> Persia Aflame simple_hercgroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_hercgroupsaving.lua]])
hm("> Persia Aflame bluesupportac.lua")
dofile(lfs.writedir() .. [[pg\scripts\bluesupportac.lua]])
hm("> Persia Aflame markerevents.lua")
dofile(lfs.writedir() .. [[pg\scripts\markerevents.lua]])
hm("> Persia Aflame mission_per.lua")
dofile(lfs.writedir() .. [[pg\scripts\mission_per.lua]])
hm("> Persia Aflame ctldsave.lua")
dofile(lfs.writedir() .. [[pg\scripts\ctldsave.lua]])
hm("> Persia Aflame manpads.lua")
dofile(lfs.writedir() .. [[pg\scripts\ManPads.lua]])
hm("> Persia Aflame intel.lua")
dofile(lfs.writedir() .. [[pg\scripts\intel.lua]])
hm("> Persia Aflame dcslink.lua")
dofile(lfs.writedir() .. [[pg\scripts\dcslink.lua]])
hm("> Red MANTIS and SHORAD Network")
dofile(lfs.writedir() .. [[pg\scripts\saminit.lua]])

hm("> loading Hercules_Cargo_CTLD.lua(Not active)")
-- dofile(lfs.writedir() .. [[pg\scripts\Hercules_Cargo_CTLD.lua]])
hm("> Persia Aflame client.lua")
dofile(lfs.writedir() .. [[pg\scripts\client.lua]])
hm("> Persia Falme: ALL SCRIPTS LOADED, HAVE A GOOD 8 HRS.")
hm("=============================================")
--[[
if kuzremoved == true then
	local kuz = GROUP:FindByName("Kuznetsov Group")
	kuz:Destroy()
	hm("** WARNING KUZNETSOV GROUP WAS PREVIOUSLY RENDERED TOO DAMAGED TO FIGHT AND IS NO LONGER AVALIBLE **")
end
if carrier5dead == true then
	local cg5 = GROUP:FindByName("Carrier Group 5")
	cg5:Destroy()
	hm("** WARNING CARRIER GROUP 5 USS Theodore Rosevelte WAS PREVIOUSLY RENDERED TOO DAMAGED TO FIGHT AND IS NO LONGER AVALIBLE **")
	ShellTeddy:Stop()
	if useawacs == true then
		awacsTeddy:Stop()
	end
	if abossactive == true then
		AirbossTeddy:Stop()
	end
end

if carrier6dead == true then
	local cg6 = GROUP:FindByName("Carrier Group 6")
	cg6:Destroy()
	hm("** WARNING CARRIER GROUP 6 USS Stennis WAS PREVIOUSLY RENDERED TOO DAMAGED TO FIGHT AND IS NO LONGER AVALIBLE **")
	if abossactive  == true then
		AirbossStennis:Stop()
	end
	ShellStennis:Stop()
	if useawacs == true then
		awacsStennis:Stop()
	end
end

if carrier6adead == true then
	local cg6 = GROUP:FindByName("Carrier Group 6a")
	cg6:Destroy()
	if abossactive  == true then
		if washingtonactive == true then
			AirbossWash:Stop()
		end
	end
	hm("** WARNING CARRIER GROUP 6a USS Washington WAS PREVIOUSLY RENDERED TOO DAMAGED TO FIGHT AND IS NO LONGER AVALIBLE **")
end
]]