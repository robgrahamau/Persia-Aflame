-- Globals are important.
version = "1.110.0"
Servername = "Training Mission"
password = ""
ADMINPASSWORD2 = ""
PATHTODROPBOX = "C:\\Users\\root\\Dropbox\\ServerShared\\new_training_mission\\"
usedropbox = true
MPATH = lfs.writedir()
if usedropbox == true then
	MPATH = PATHTODROPBOX
end
-- end globals.
env.info("Training Mission Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
dofile(MPATH .."src\\Main.lua")