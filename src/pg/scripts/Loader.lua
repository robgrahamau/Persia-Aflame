
carrier5dead = false
carrier6dead = false
carrier6adead = false
kuzremoved = false

activearea = "• Island,Western,Qeshm,Bandar,Eastern \n • Protect Captured Areas and take hostile. \n • High Priority Targets - SCUD, TANKS, AAA, SAMS \n ROE Notice:\n • Reduce Civilian Damage \n • CBU Class weapons are to be limited to open field employment or restricted use in Towns/cities only if unable to find/kill with other weapons \n • CBU use prohibited on large cities."
activeareairan = "• Harasment of Coalition Forces \n • Defence of Irani Mainland and Islands. \n • Retaking of Lost Territory"
env.info("Persia Aflame Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
env.info("Loading MOOSE")
dofile(lfs.writedir() .."pg\\scripts\\Moose.lua")
env.info("Loading MIST")
dofile(lfs.writedir() .."pg\\scripts\\mist_4_5_98.lua")

env.info("hHypeMan")
assert(loadfile("C:/HypeMan/HypeMan.lua"))() 
HypeMan.sendBotMessage("**Persia Aflame is Starting.....** \n > MOOSE,MIST  Already Loaded, Hello Dave do you want to play a game of Chess? \n > or Perhaps a game of International War Crimes?")

function hm(msg)
	HypeMan.sendBotMessage(msg)
end
hm("> Randomising Maths because Maths needs SEEDS so things can grow")
function hmlso(msg)
	HypeMan.sendLSOBotMessage(msg)
end
HypeMan.sendBotMessage("> Hazel Link Starting.....Ground control to Ceiling Cat, do you read us?")
GRPC.debug = true
GRPC.host = '0.0.0.0'
GRPC.load()
seasonofgiving = false
iranichristmas = false
hm("> GRPC is a go, Ceiling Cat is real!")
--dofile(lfs.writedir() .."pg\\scripts\\cinc_loader.lua") 
--CinCServer.start("139.99.144.189", 3050)
HypeMan.sendBotMessage("> Persia Aflame Yes give me a VOICE!  SRS.lua")
dofile(lfs.writedir() .. [[pg\scripts\srs.lua]])
env.info("Loading Peristence")
hm("> Persia Aflame Those helicopter boys want to party  it seems so lets give em ways to pick crap up, CTLD.lua")
dofile(lfs.writedir() .. [[pg\scripts\CTLD.lua]])
hm("> Persia Aflame Well here comes Mav and Goose and all those so called hotshots : sqns.lua")
dofile(lfs.writedir() .. [[pg\scripts\sqns.lua]])
hm("> Persia Aflame Mother are you there? Please are you my Mommy? I need to know how to land, airboss.lua")
dofile(lfs.writedir() .. [[pg\scripts\Airboss.lua]])
hm("> Persia Aflame Ohhhhhhh Power Poles.... ADS.lua")
dofile(lfs.writedir() .. [[pg\scripts\ADS.lua]])
hm("> Persia Aflame Nope, sorry you don't own that jet your not allowed into it because this is IRAN not the West.. or was that this is the US and not Iran? slothandler1.lua")
dofile(lfs.writedir() .. [[pg\scripts\slothandler1.lua]])
hm("> Persia Aflame I suppose you'll want me to save this? simple_groupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_groupsaving.lua]])
hm("> Persia Aflame Damned Chopper Pilots.. you to? simple_ctldgroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_ctldgroupsaving.lua]])
hm("> Persia Aflame Christ even the admin wants to save stuff, anyone would think i've nothing better to do? simple_admingroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_admingroupsaving.lua]])
hm("> Persia Aflame Well this ones actually not working right now so HA I ignore you! simplestaticsaving.lua")
--dofile(lfs.writedir() .. [[pg\scripts\simplestaticsaving.lua]])
hm("> Persia Aflame Ohh did I dooo that? It's not a war crime if no one saw it. simple_scenery_persistence.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_scenery_persistence.lua]])
--hm("> Persia Aflame This isn't really working either we moved to a different system because of it.. I ignore you ctld_static_save.lua")
--dofile(lfs.writedir() .. [[pg\scripts\ctld_static_save.lua]])
hm("> Persia Aflame Man Pads.. I see Dead people, when ever they come down low enough: simple_mpadgroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_mpadgroupsaving.lua]])
hm("> Persia Aflame We aren't using this right now so nope... bye bye. simple_hercgroupsaving.lua")
dofile(lfs.writedir() .. [[pg\scripts\simple_hercgroupsaving.lua]])
hm("> Persia Aflame Sigh you want awacs? Because this is how you get AWACS PAM! bluesupportac.lua")
dofile(lfs.writedir() .. [[pg\scripts\bluesupportac.lua]])
hm("> Persia Aflame Robs favorate toys! markerevents.lua")
dofile(lfs.writedir() .. [[pg\scripts\markerevents.lua]])
hm("> Persia Aflame HayZues you want even more shit saved? Christ ok ok I'll make it persistant, mission_per.lua")
dofile(lfs.writedir() .. [[pg\scripts\mission_per.lua]])
hm("> Persia Aflame For crying out loud! MORE ? You want MORE saved How much shit do I have to save, I do other things to do, you know like lock up.... ctldsave.lua")
dofile(lfs.writedir() .. [[pg\scripts\ctldsave.lua]])
hm("> Persia Aflame More dead people in bound.. more manpads I see broken aircraft in skies of blue, manpads.lua")
dofile(lfs.writedir() .. [[pg\scripts\ManPads.lua]])
hm("> Persia Aflame Oh so now you want to know WHERE everything is? First you make me save it all now you want INTELLIGENCE? There ain't none on this intelligence level -100000 we have a SOCK.: server intel.lua")
dofile(lfs.writedir() .. [[pg\scripts\intel.lua]])
hm("> Persia Aflame Ohhh I get to talk to another application? DCS to MAP SERVER CAN YOU HEAR ME? dcslink.lua")
dofile(lfs.writedir() .. [[pg\scripts\dcslink.lua]])
hm("> Red Ohhh more sams and evil ness but I think that arsehole Rob turned it off, MANTIS and SHORAD Network")
dofile(lfs.writedir() .. [[pg\scripts\saminit.lua]])

hm("> loading Hercules_Cargo_CTLD.lua(Not active) actually no we aren't.. Hurry up and make it a real boy so we can use it again.")
-- dofile(lfs.writedir() .. [[pg\scripts\Hercules_Cargo_CTLD.lua]])
hm("> Persia Aflame Almost done now I have to actually talk to the people who connect to me, damned it... I really don't want to, but If you say so.... client.lua")
dofile(lfs.writedir() .. [[pg\scripts\client.lua]])


hm("> ATIS loading in.")
dofile(lfs.writedir() .. [[pg\scripts\atis.lua]])

hm("> Anti Jackass Script Loading in... No Nukes ever allowed again")

dofile(lfs.writedir() .. [[pg\scripts\jackasstest.lua]])
hm("> Persia Falme: ALL SCRIPTS LOADED, INTERNATIONAL WAR CRIMES ... I MEAN PERSIAN GULF AFLAME SERVER IS NOW ONLINE AND RUNNING \n PLEASE HAVE A PLEASENT AND PRODUCTIVE 8 HRS.")
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

-- Ok start GRPC and do the config in mission.


function season()
 if seasonofgiving  == false then
	local dowerun = math.random(1,100)
	if dowerun > 80 then
		hm("Season of Giving is a go")
		BASE:E({"season of giving is a go"})
		seasonofgiving = true
	end
 else
	BASE:E({"season of giving is not a go"})
	SCHEDULER:New(nil,season,{},(60*15))
 end 
end

function iransanta()
 if iranichristmas  == false then
	local dowerun = math.random(1,100)
	if dowerun > 80 then
		hm("Iran Crhistmas is a go")
		BASE:E({"Iran Crhistmas  is a go"})
		iranichristmas = true
	end
 else
    BASE:E({"Iran Crhistmas  is not a go"})
	SCHEDULER:New(nil,function() 
		iransanta()
	end,{},(60*10))
 end 
end

SCHEDULER:New(nil,function() 
 season()
end,{},(60*15))

SCHEDULER:New(nil,function() 
 iransanta()
end,{},(60*10))