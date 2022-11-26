-- Globals are important.
Servername = "Persia Aflame"
lastupdate = "21/10/2022"
carrier5dead = false
carrier6dead = false
carrier6adead = false
kuzremoved = false
seasonofgiving = false
iranichristmas = false
NassauSpawned = false
PeleliuSpawned = false
useforrest = true
_maxislandmainlandspawns = 24
trigger.action.setUserFlag(100,0) -- don't know why this is set.. but being safe.
_spawnnumber = 0
trigger.action.setUserFlag("SSB",100) -- Set SSB active.
activearea = "Activate AO: UAE\n \n ROE Notice:\n • Reduce Civilian Damage."
activeareairan = "• Harasment of Coalition Forces \n • Defence of held territory"
_loaded = false
agency = "Apollo"
sttsfreq = "122.80"
TANKER_COOLDOWN = (1)*60
TEX_Timer = 0
TEX2_Timer = 0
ARC_Timer = 0
ARC2_Timer = 0
usenew = true

env.info("Persia Aflame Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
env.info("Loading MOOSE")
dofile(PGPATH .."pg\\scripts\\Moose.lua")
env.info("Loading MIST")
dofile(PGPATH .."pg\\scripts\\mist_4_5_98.lua")
_lsch = SCHEDULER:New(nil,function() 
	BASE:E({"_lsch"})
	if _loaded == false then
		env.info("Mission Failed to load")
		MESSAGE:New("Mission Has not loaded correctly!!! Please Contact an ADMIN / Rob on DISCORD",30):ToAll()
	end
end,{},60,60)
env.info("HypeMan")
assert(loadfile("C:/HypeMan/HypeMan.lua"))() 
function hm(msg)
	HypeMan.sendBotMessage(string.format( "%1s:(%s)" , Servername,routines.utils.oneLineSerialize( msg ) ) )
	env.info(string.format( "%1s:(%s)" , Servername,routines.utils.oneLineSerialize( msg ) ) )
end

hm("> Persia Aflame is Starting..... \n > MOOSE,MIST  Already Loaded, Initialising Load.. ")

hm("Math Randomisation Underway")
for i=10,1 do local m = math.random(1,100) end
function hmlso(msg)
	HypeMan.sendLSOBotMessage(msg)
end

hm("Hazel Link Starting.....")
GRPC.debug = true
GRPC.host = '0.0.0.0'
GRPC.load()
hm("> GRPC is a go, Ceiling Cat is real!")

hm("> SRS.lua")
--dofile(PGPATH .. [[pg\scripts\srs.lua]])
dofile(PGPATH .. [[pg\scripts\stts.lua]])
HypeMan.sendBotMessage("> zones and functions.lua")
dofile(PGPATH .. [[pg\scripts\zones.lua]])

hm("> CTLD.lua")

dofile(PGPATH .. [[pg\scripts\CTLD.lua]])

hm("> ctldslotcheck.lua")
dofile(PGPATH .. [[pg\scripts\ctldslotcheck.lua]])

hm("> Loading in sqns.lua")
dofile(PGPATH .. [[pg\scripts\sqns.lua]])

hm("> pesiasqns.lua")
dofile(PGPATH .. [[pg\scripts\persiasqns.lua]])

hm("> Airboss.lua")
dofile(PGPATH .. [[pg\scripts\Airboss.lua]])

hm("> ADS.lua")
dofile(PGPATH .. [[pg\scripts\ADS.lua]])

-- This is all new code 1.80
hm("> Ok This could be where shit breaks, the new slot Handlers - Function/Class loading")
hm("> slothandler.lua")
dofile(PGPATH .. [[pg\scripts\slothandler.lua]])
hm("> carrierslothandler.lua")
dofile(PGPATH .. [[pg\scripts\carrierslothandler.lua]])
hm("> fobhandler.lua")
dofile(PGPATH .. [[pg\scripts\fobhandler.lua]])
hm("> Now we do all the actual slots")
hm("> slots.lua")
dofile(PGPATH .. [[pg\scripts\slot.lua]])
-- Check for dynamic events/spawning
hm("> Slotbased Events - slotevents.lua")
dofile(PGPATH .. [[pg\scripts\slotevents.lua]])

hm("> simple_groupsaving.lua")
dofile(PGPATH .. [[pg\scripts\simple_groupsaving.lua]])
hm("> simple_ctldgroupsaving.lua")
dofile(PGPATH .. [[pg\scripts\simple_ctldgroupsaving.lua]])
hm("> simple_admingroupsaving.lua")
dofile(PGPATH .. [[pg\scripts\simple_admingroupsaving.lua]])
hm("> Scenery will stay destroyed")
dofile(PGPATH .. [[pg\scripts\simple_scenery_persistence.lua]])
hm("> bluesupportac.lua")
dofile(PGPATH .. [[pg\scripts\bluesupportac.lua]])

hm("> markerevents.lua")
dofile(PGPATH .. [[pg\scripts\markerevents.lua]])
hm("> mission_per.lua")
dofile(PGPATH .. [[pg\scripts\mission_per.lua]])

hm("> ctldsave.lua")
dofile(PGPATH .. [[pg\scripts\ctldsave.lua]])

hm("> manpads.lua")
dofile(PGPATH .. [[pg\scripts\ManPads.lua]])

hm(">  intel.lua")
dofile(PGPATH .. [[pg\scripts\intel.lua]])
hm("> Persia Aflame Ohhh I get to talk to another application? DCS to MAP SERVER CAN YOU HEAR ME? dcslink.lua")
dofile(PGPATH .. [[pg\scripts\dcslink.lua]])

hm("> Persia Aflame Almost done now I have to actually talk to the people who connect to me, damned it... I really don't want to, but If you say so.... client.lua")
dofile(PGPATH .. [[pg\scripts\client.lua]])

hm("> Anti Jackass Script Loading in... No Nukes ever allowed again")

dofile(PGPATH .. [[pg\scripts\jackasstest.lua]])
dofile(PGPATH .. [[pg\robcommands.lua]])

dofile(PGPATH .. [[pg\scripts\CSAR.lua]])
hm("> Persia Aflame, Starting 'Sleep Cycle' for RED Anti Air")
dofile(PGPATH .. [[pg\scripts\sleepcycle.lua]])
hm("> templateload.lua")
dofile(PGPATH .. [[pg\scripts\templateloadnew.lua]])
lasthash = inputhash
missionpath = "C:\\Users\\root\\Dropbox\\ServerShared\\Persia_Templates\\"
hm("> Persia Falme: ALL SCRIPTS LOADED, INTERNATIONAL WAR CRIMES ... I MEAN PERSIAN GULF AFLAME SERVER IS NOW ONLINE AND RUNNING \n PLEASE HAVE A PLEASENT AND PRODUCTIVE 8 HRS.")
hm("=============================================")
_loaded = true



function rlog(msg)
	BASE:E(msg)
	hm(msg)
end

function DEBUGMESSAGE(msg)
	rlog(msg)
end


function loggroups()
	local tempset = SET_UNIT:New():FilterActive():FilterOnce()
	local ucounter = 0
	local ub = 0
	local ur = 0 
	tempset:ForEach(function(g) 
		ucounter = ucounter + 1
		local uc = g:GetCoalition()
		if uc == 1 then
			ur = ur + 1
		else
			ub = ub + 1
		end
	end)
	tempset = SET_GROUP:New():FilterActive():FilterOnce()
	local gcounter = 0
	local gb = 0
	local gr = 0 
	tempset:ForEach(function(g) 
		gcounter = gcounter + 1
		local gc = g:GetCoalition()
		if gc == 1 then
			gr = gr + 1
		else
			gb = gb + 1
		end
	end)
	rlog("Mission Start Current Group Count is: ".. gcounter .." Active Groups, \n Blue Groups: " .. gb .. " \n Red Groups: " .. gr .. " \n Unit Count is:" .. ucounter .. "Units \n Blue Units:" .. ub .. "\n Red Units:" .. ur .. "")
end


SCHEDULER:New(nil,loggroups
,{},0,(60*60))

function runrob()
dofile(PGPATH .. [[pg\robcommands.lua]])

	if inputhash ~= lasthash then
		BASE:E("Hash has changed")
		local ran, errorMSG = pcall(robinput)
		if not ran then
			BASE:E({"robinput errored ",errorMSG})
		end
		lasthash = inputhash
	end

end


SCHEDULER:New(nil,function() 
	local ran, errorMSG = pcall(runrob)
	if not ran then
		BASE:E({"error in runrobo ",errorMSG})
	end
	
end,{},0,5)








if _loaded == true then
	_lsch:Stop()
end