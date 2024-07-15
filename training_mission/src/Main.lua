-- Globals are important.
Servername = "TGW Training Mission"
lastupdate = "05/02/2023"
_loaded = false
-- Paths.
_LIBPATH = MPATH .. "\\lib\\"
_SRCPATH = MPATH .. "\\src\\"
LSOSAVE = "C:\\Users\\root\\Saved Games\\lsogrades\\"
dofile( _LIBPATH .. "robutils.lua")



local ran, errorMSG = pcall(function() dofile(lfs.writedir() .. 'Scripts/net/DCSServerBot/DCSServerBot.lua') end)
if not ran then
	RGUTILS.log({"Error: ",errorMSG})
end
-- items go in here.
BLUEFIRESUPPORTNAME = "Watcher"
REDFIRESUPPORTNAME = "Vladamire"
agency = "Apollo"
sttsfreq = "122.80"
USEDCSBOT = true
INPUTHASH = 00000
LASTHASH = 00000
env.info("Training Mission Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
env.info("Loading MOOSE")

_LOADFILE("Moose.lua",_LIBPATH,true,-1,15)
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
		HypeMan.sendBotMessage(string.format( "%1s:(%s)" , Servername,UTILS.OneLineSerialize ( msg ) ) )
	end
	if USEDCSBOT == true then
		dcsbot.sendBotMessage(string.format( "%1s:(%s)" , Servername,UTILS.OneLineSerialize ( msg ) ))
	end
	if USEFMDegbug == true then
		dcsbot.sendBotMessage(string.format( "%1s:(%s)" , Servername,UTILS.OneLineSerialize ( msg ) ))
	end
	env.info(string.format( "%1s:(%s)" , Servername,UTILS.OneLineSerialize ( msg ) ) )
end

hm("> Training Mission is Starting..... \n > MOOSE,MIST  Already Loaded, Initialising Load.. ")
hm("Math Randomisation Underway")

for i=10,1 do local m = math.random(1,100) end
hm("> lotatc.lua")
_LOADFILE("lotatc.lua",_SRCPATH,false,-1,15)

hm("> stts.lua")
_LOADFILE("stts.lua",_SRCPATH,true,-1,15)

hm("> client.lua")
_LOADFILE("client.lua",_SRCPATH,true,-1,15)

hm("> zones.lua")
_LOADFILE("zones.lua",_SRCPATH,true,-1,15)

hm("> BFM.lua")
_LOADFILE("BFM.lua",_SRCPATH,true,-1,15)

hm("> airboss.lua")
_LOADFILE("airboss.lua",_SRCPATH,true,-1,15)


hm("> ai.lua")
_LOADFILE("ai.lua",_SRCPATH,true,-1,15)

hm("> fox.lua")
_LOADFILE("fox.lua",_SRCPATH,true,-1,15)

hm("> range.lua")
_LOADFILE("range.lua",_SRCPATH,true,-1,15)

hm("> atc.lua")
_LOADFILE("atc.lua",_SRCPATH,true,-1,15)


hm("> markerevent.lua")
_LOADFILE("markerevent.lua",_SRCPATH,true,-1,15)


-- lotatcLink.registerAtis("blue","Kobuleti", true, "Alpha", "133.100AM")
myevent = HEVENT:New(true,false,false,10,10,false)
myevent:Start()
hm("> Training Mission: ALL SCRIPTS LOADED")
hm("=============================================")


_loaded = true



function rlog(_msg)
	RGUTILS.log(_msg)
	hm(_msg)
end

function DEBUGMESSAGE(_msg)
	rlog(_msg)
end
firstrun = true -- sets up our first run for the below command set so we don't run anything in it but update the hash.
function runrob()
dofile(_SRCPATH .. [[comm\robcommands.lua]])
	if INPUTHASH ~= LASTHASH then
		if firstrun == true then
			LASTHASH = INPUTHASH
			firstrun = false
		else
			BASE:E("Hash has changed")
			local ran, errorMSG = pcall(robinput)
			if not ran then
				BASE:E({"robinput errored ",errorMSG})
			end
			LASTHASH = INPUTHASH
		end
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

