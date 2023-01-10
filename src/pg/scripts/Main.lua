-- Globals are important.
Servername = "Persia Aflame"
lastupdate = "27/11/2022"

--- Boolean Variables
carrier5dead = false
carrier6dead = false
carrier6adead = false
kuzremoved = false
seasonofgiving = false
iranichristmas = false
NassauSpawned = false
PeleliuSpawned = false
useforrest = true
ADMIN = false
__HMLOADED = false
_DEBUG = false
_loaded = false
LSOLOAD = true
USEHM = true
usenew = true
--
adminspawned = {} 
_maxislandmainlandspawns = 24

trigger.action.setUserFlag(100,0) -- don't know why this is set.. but being safe.

trigger.action.setUserFlag("SSB",100) -- Set SSB active.
activearea = "Activate AO: UAE & Island A.O \n ROE Notice:\n • Reduce Collateral Damage."
activeareairan = "• Harasment of Coalition Forces \n • Defence of held territory"

farpcounter = 0
_spawnnumber = 0

TANKER_COOLDOWN = (1)*60

TEX_Timer = 0
TEX2_Timer = 0
ARC_Timer = 0
ARC2_Timer = 0
AFAC_Timer = 0
FAC1_Timer = 0
FAC1_COOLDOWN = (0.5)*60

-- Paths.
_LIBPATH = PGPATH .. "pg\\lib\\"
_SRCPATH = PGPATH .. "pg\\scripts\\"
_MCPATH = PGPATH .. "pg\\"
LSOSAVE = "C:\\Users\\root\\Saved Games\\lsogrades\\"
_PGPERPATH = lfs.writedir() .. "pg\\"


-- items go in here.
BLUEFIRESUPPORTNAME = "Watcher"
REDFIRESUPPORTNAME = "Vladamire"
agency = "Apollo"
sttsfreq = "122.80"


dofile( _LIBPATH .. "robutils.lua")


env.info("Persia Aflame Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
env.info("Loading MOOSE")

_LOADFILE("PGMoose.lua",_LIBPATH,true,-1,15)

-- dofile(PGPATH .."pg\\scripts\\Moose.lua")
env.info("Loading MIST")
-- dofile(PGPATH .."pg\\scripts\\mist_4_5_98.lua")
_LOADFILE("mist.lua",_LIBPATH,true,-1,15)
_lsch = SCHEDULER:New(nil,function() 
	BASE:E({"_lsch"})
	if _loaded == false then
		env.info("Mission Failed to load")
		MESSAGE:New("Mission Has not loaded correctly!, Please Contact an ADMIN / Rob on DISCORD",30):ToAll()
	end
end,{},60,60)

if USEHM == true then
	env.info("HypeMan")
	_LOADFILE("Hypeman.lua","C:\\HypeMan\\",true,-1,15)
	--assert(loadfile("C:/HypeMan/HypeMan.lua"))() 
	__HMLOADED = true
end

function hm(msg)
	if USEHM == true then
		HypeMan.sendBotMessage(string.format( "%1s:(%s)" , Servername,routines.utils.oneLineSerialize( msg ) ) )
	end
	env.info(string.format( "%1s:(%s)" , Servername,routines.utils.oneLineSerialize( msg ) ) )
end

function hmlso(msg)
	if USEHM == true then
		HypeMan.sendLSOBotMessage(msg)
	end
	env.info(msg)
end

hm("> Persia Aflame is Starting..... \n > MOOSE,MIST  Already Loaded, Initialising Load.. ")
hm("Math Randomisation Underway")

for i=10,1 do local m = math.random(1,100) end

hm("Hazel Link Starting.....")
GRPC.debug = true
GRPC.host = '0.0.0.0'
GRPC.load()
hm("> GRPC is a go, Ceiling Cat is real!")

hm("> stts.lua")
--dofile(PGPATH .. [[pg\scripts\stts.lua]])
_LOADFILE("stts.lua",_SRCPATH,true,-1,15)
hm("> zones and functions.lua")
_LOADFILE("zones.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\zones.lua]])
hm("> CTLD.lua")
_LOADFILE("CTLD.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\CTLD.lua]])
hm("> ctldslotcheck.lua")
_LOADFILE("ctldslotcheck.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\ctldslotcheck.lua]])
hm("> Loading in sqns.lua")
_LOADFILE("sqns.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\sqns.lua]])
hm("> pesiasqns.lua")
_LOADFILE("persiasqns.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\persiasqns.lua]])
hm("> Airboss.lua")
_LOADFILE("Airboss.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\Airboss.lua]])
hm("> ADS.lua")
_LOADFILE("ADS.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\ADS.lua]])
hm("> slothandler.lua")
_LOADFILE("slothandler.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\slothandler.lua]])
hm("> carrierslothandler.lua")
_LOADFILE("carrierslothandler.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\carrierslothandler.lua]])
hm("> fobhandler.lua")
_LOADFILE("fobhandler.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\fobhandler.lua]])
hm("> Now we do all the actual slots")
hm("> slots.lua")
_LOADFILE("slot.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\slot.lua]])
-- Check for dynamic events/spawning
hm("> Slotbased Events - slotevents.lua")
_LOADFILE("slotevents.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\slotevents.lua]])
--hm("> simple_groupsaving.lua")
--_LOADFILE("simple_groupsaving.lua",_SRCPATH,true,-1,15)

--hm("> simple_ctldgroupsaving.lua")
--_LOADFILE("simple_ctldgroupsaving.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\simple_ctldgroupsaving.lua]])
--hm("> simple_admingroupsaving.lua")
--_LOADFILE("simple_admingroupsaving.lua",_SRCPATH,true,-1,15)

_LOADFILE("save_groups.lua",_SRCPATH,true,-1,15)
SAVE_SET = SET_GROUP:New():FilterCategories("ground"):FilterPrefixes({"IAA","GM_USAA","cjtf_blue","cjtf_red","CTLD","ctld","RSAM","REW","SCUD","BSAM","USEW","AAA","RDEF","Iran Ammo"}):FilterActive(true):FilterStart()
MainSave = GroundUnitSave:New(SAVE_SET,"testsave_Units.lua",_PGPERPATH)
MainSave:Start(300)
--hm("> simple_scenery_persistence.ua")
--_LOADFILE("simple_scenery_persistence.lua",_SRCPATH,true,-1,15)

hm("> bluesupportac.lua")
_LOADFILE("bluesupportac.lua",_SRCPATH,true,-1,15)
--dofile(PGPATH .. [[pg\scripts\bluesupportac.lua]])

--[[
hm("> markerevents.lua")
_LOADFILE("markerevents.lua",_SRCPATH,true,-1,15)
]]
hm(">EventHandler")
_LOADFILE("EventHandler.lua",_SRCPATH,true,-1,15)

_MAINEVENT = HEVENT:New(true,true,false,1,1)
_MAINEVENT:setblueprefix("GM_USAA")
_MAINEVENT:setredprefix("IAA")
_MAINEVENT:SetDebug(true)
_MAINEVENT:Start()

hm("> mission_per.lua")
_LOADFILE("mission_per.lua",_SRCPATH,true,-1,15)

hm("> ctldsave.lua")
_LOADFILE("ctldsave.lua",_SRCPATH,true,-1,15)

hm("> intel.lua")
_LOADFILE("intel.lua",_SRCPATH,true,-1,15)

hm("> dcslink.lua")
_LOADFILE("dcslink.lua",_SRCPATH,true,-1,15)

hm("> client.lua")
_LOADFILE("client.lua",_SRCPATH,true,-1,15)


hm("> Anti Jackass Script Loading in...jackasstest.lua")
_LOADFILE("jackasstest.lua",_SRCPATH,true,-1,15)

hm("> robcommands.lua")
_LOADFILE("robcommands.lua",_MCPATH,true,-1,15)

hm("> CSAR.lua")
_LOADFILE("CSAR.lua",_SRCPATH,true,-1,15)

hm("> Persia Aflame, Starting 'Sleep Cycle' for RED Anti Air")
_LOADFILE("sleepcycle.lua",_SRCPATH,true,-1,15)

hm("> templateload.lua")
_LOADFILE("templateloadnew.lua",_SRCPATH,true,-1,15)

lasthash = inputhash
missionpath = "C:\\Users\\root\\Dropbox\\ServerShared\\Persia_Templates\\"
hm("> Persia Falme: ALL SCRIPTS LOADED, INTERNATIONAL WAR CRIMES ... I MEAN PERSIAN GULF AFLAME SERVER IS NOW ONLINE AND RUNNING \n PLEASE HAVE A PLEASENT AND PRODUCTIVE 8 HRS.")
hm("=============================================")
_loaded = true



function rlog(_msg)
	RGUTILS.log(_msg)
	hm(_msg)
end

function DEBUGMESSAGE(_msg)
	rlog(_msg)
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