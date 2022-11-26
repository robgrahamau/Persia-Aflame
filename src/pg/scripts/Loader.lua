-- Globals are important.
version = "1.112.0"
Servername = "Persia Aflame"
lastupdate = "24/11/2022"
password = "lalalala"
ADMINPASSWORD2 = "lala"
PATHTODROPBOX = "C:\\Users\\root\\Dropbox\\ServerShared\\Persia_Aflame_Core_Code\\dcs\\" -- path to were the files are this needs to go in the right folder
usedropbox = true
PGPATH = lfs.writedir()
if usedropbox == true then
	PGPATH = PATHTODROPBOX
end
-- end globals.
env.info("Persia Aflame Loader")
env.info("Mission by Robert Graham")
env.info("Mission Script Loader Active")
dofile(PGPATH .."pg\\scripts\\Main.lua")
