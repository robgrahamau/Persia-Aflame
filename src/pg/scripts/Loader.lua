-- Globals are important.
version = "1.110.0"
Servername = "Persia Aflame"
lastupdate = "21/10/2022"
password = "hogsarebest"
ADMINPASSWORD2 = "tgw"
PATHTODROPBOX = "C:\\Users\\root\\Dropbox\\ServerShared\\Persia_Aflame_Core_Code\\dcs\\"
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
