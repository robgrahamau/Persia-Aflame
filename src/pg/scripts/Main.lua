-- Globals are important.
Servername = "Persia Aflame"
lastupdate = "31/01/2023"
newslots = true
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
USEFM = true
__HMLOADED = false
_DEBUG = false
_loaded = false
LSOLOAD = true
USEHM = true
usenew = true
ChargeAttackOn = true 
--
adminspawned = {} 
_maxislandmainlandspawns = 24
ALLFOBS = {}
trigger.action.setUserFlag(100,0) -- don't know why this is set.. but being safe.

trigger.action.setUserFlag("SSB",100) -- Set SSB active.
activearea = "•Lars through to southern coast see area on F10 map\n \n ROE Notice:\n • Reduce Civilian Damage."
activeareairan = "• Defend Attacked areas areas marked by dotted Square on F10 map"

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

_LOADFILE("Moose.lua",_LIBPATH,true,-1,15)

env.info("Loading MIST")

_LOADFILE("mist.lua",_LIBPATH,true,-1,15)
_lsch = SCHEDULER:New(nil,function() 
	BASE:E({"_lsch"})
	if _loaded == false then
		env.info("Mission Failed to load")
		MESSAGE:New("Mission Has not loaded correctly!, Please Contact an ADMIN / Rob on DISCORD",30):ToAll()
	end
end,{},60,60)
if USEFM == true then
	mySocket=SOCKET:New()
end

if USEHM == true then
	env.info("HypeMan")
	__HMLOADED = _LOADFILE("Hypeman.lua","C:\\HypeMan\\",false,-1,15,true)
	if __HMLOADED == false then
		USEHM = false
		USEFMDegbug = false
	end
end

function hm(msg)
	if USEHM == true then
		HypeMan.sendBotMessage(string.format( "%1s:(%s)" , Servername,routines.utils.oneLineSerialize( msg ) ) )
	end
	if USEFMDegbug == true then
		dcsbot.sendBotMessage(string.format( "%1s:(%s)" , Servername,routines.utils.oneLineSerialize( msg ) ))
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
if GRPC ~= nil then
	GRPC.debug = true
	GRPC.host = '0.0.0.0'
	GRPC.load()
else
	env.info("GRPC not avalible")
end
hm("> GRPC is a go, Ceiling Cat is real!")

hm("> stts.lua")

_LOADFILE("stts.lua",_SRCPATH,true,-1,15)
hm("> zones and functions.lua")
_LOADFILE("zones.lua",_SRCPATH,true,-1,15)

hm("> CTLD.lua")
_LOADFILE("CTLD.lua",_SRCPATH,true,-1,15)

hm("> ctldslotcheck.lua")
_LOADFILE("ctldslotcheck.lua",_SRCPATH,true,-1,15)

hm("> Loading in sqns.lua")
_LOADFILE("sqns.lua",_SRCPATH,true,-1,15)

hm("> pesiasqns.lua")
_LOADFILE("persiasqns.lua",_SRCPATH,true,-1,15)

hm("> Airboss.lua")
_LOADFILE("Airboss.lua",_SRCPATH,true,-1,15)

hm("> ADS.lua")
_LOADFILE("ADS.lua",_SRCPATH,true,-1,15)

hm("> slothandler.lua")
_LOADFILE("slothandler.lua",_SRCPATH,true,-1,15)

hm("> carrierslothandler.lua")
_LOADFILE("carrierslothandler.lua",_SRCPATH,true,-1,15)

hm("> fobhandler.lua")
_LOADFILE("fobhandler.lua",_SRCPATH,true,-1,15)

hm("> Now we do all the actual slots")
hm("> slots.lua")
_LOADFILE("slot.lua",_SRCPATH,true,-1,15)
-- Check for dynamic events/spawning
hm("> Slotbased Events - slotevents.lua")
_LOADFILE("slotevents.lua",_SRCPATH,true,-1,15)

_LOADFILE("save_groups.lua",_SRCPATH,true,-1,15)
SAVE_SET = SET_GROUP:New():FilterCategories("ground"):FilterPrefixes({"RAA","IAA","GM_USAA","cjtf_blue","cjtf_red","CTLD","ctld","RSAM","REW","SCUD","BSAM","USEW","AAA","RDEF","Iran Ammo"}):FilterActive(true):FilterStart()
MainSave = GroundUnitSave:New(SAVE_SET,"testsave_Units.lua",_PGPERPATH)
MainSave:SetDisp(60,true)
MainSave:Start(300)
Csave = CTLDSave:New("ctld_save.lua",_PGPERPATH)
Csave:Start(60)


hm("> shandler.lua")
_LOADFILE("shandler.lua",_SRCPATH,true,-1,15)


hm("> bluesupportac.lua")
_LOADFILE("bluesupportac.lua",_SRCPATH,true,-1,15)


hm(">EventHandler")
_LOADFILE("EventHandler.lua",_SRCPATH,true,-1,15)

_MAINEVENT = HEVENT:New(true,true,false,1,1)
_MAINEVENT:setblueprefix("GM_USAA")
_MAINEVENT:setredprefix("IAA")
_MAINEVENT:SetDebug(true)
_MAINEVENT:Start()

hm("> mission_per.lua")
_LOADFILE("mission_per.lua",_SRCPATH,true,-1,15)


hm("> intel.lua")
_LOADFILE("intel.lua",_SRCPATH,true,-1,15)

--hm("> dcslink.lua")
--_LOADFILE("dcslink.lua",_SRCPATH,true,-1,15)

hm("> client.lua")
_LOADFILE("client.lua",_SRCPATH,true,-1,15)

hm("> Skynet")
_LOADFILE("skynet-iads-compiled.lua",_LIBPATH,true,-1,15)

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

hm("> deepstrike.lua")
_LOADFILE("deepstrike.lua",_SRCPATH,true,-1,15)

hm("> deepstrikes.lua")
_LOADFILE("deepstrikes.lua",_SRCPATH,true,-1,15)

hm("> newbluesupport.lua")
_LOADFILE("newbluesupport.lua",_SRCPATH,true,-1,15)


hm("> IADS.lua")
_LOADFILE("iads.lua",_SRCPATH,true,-1,15)


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

function UNITCOUNTER(_col,_ground)
	_col = _col or -1
	_ground = _ground or false
	local _cstring = "red"
	if _col == 2 then
		_cstring = "blue"
	end
	local tempset = SET_UNIT:New():FilterActive():FilterOnce()	
	if _col ~= -1 then
		if _ground == false then
			tempset = SET_UNIT:New():FilterCoalitions(_cstring):FilterActive():FilterOnce()
		else
			tempset = SET_UNIT:New():FilterCoalitions(_cstring):FilterCategories("ground"):FilterActive():FilterOnce()
		end
	end
	local ucounter = 0
	ucounter = tempset:CountAlive()
	local _msg = string.format("UNITCOUNTER: coalition was %s Ground only was %s total unit count was %d",_cstring,tostring(_ground),ucounter)
	rlog(_msg)
	return ucounter
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
	return ucounter
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
		BASE:E({"error in runrob",errorMSG})
	end
	
end,{},0,5)

if _loaded == true then
	_lsch:Stop()
	_lsch = nil -- clean up the memory for it by removing it.
end


-- set up our zone to show the active ao
--_aobox = highlightarea(305493,75533,202114,176566,-1,{234,63,247},0.5,{234,63,247},0.35,3,nil)
 --_aobox2 = highlightarea(158989,-50885,105557,76245,-1,{234,63,247},0.5,{234,63,247},0.35,3,nil)  -- Bandar Area
 _aobox2 = highlightarea(198295, -325539, 32270, -107193 ,-1,{234,63,247},0.5,{234,63,247},0.35,3,nil) -- Kish/Western AO

--hindgobybye = GROUP:FindByName("Hind_Sweep1")
--hindgobyebye:Destroy()

allredunits = SET_GROUP:New():FilterCategories("ground"):FilterCoalitions("red"):FilterPrefixes({"RAA","IAA","GM_USAA","cjtf_blue","cjtf_red","CTLD","ctld","RSAM","REW","SCUD","BSAM","USEW","AAA","RDEF","Iran Ammo"}):FilterActive(true):FilterOnce()

SCHEDULER:New(nil,function() 
	rediads = IADSMonitor:New("Red IADS",allredunits,"red")
	rediads:Start()
end,{},180)

SCHEDULER:New(nil,function() 
hindgobybye = GROUP:FindByName("Hind_Sweep1")
hindgobyebye:Destroy() 
end,{},600)

hm("> AO.lua")
_LOADFILE("AO.lua",_SRCPATH,true,-1,15)


local ran, errorMSG = pcall(function() dofile(lfs.writedir() .. 'Scripts/net/DCSServerBot/DCSServerBot.lua') end)
if not ran then
	RGUTILS.log({"Error: ",errorMSG})
end