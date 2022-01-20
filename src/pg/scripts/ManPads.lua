
if firstrun == true then
	BASE:E({"Loading Manpads script"})
	BASE:E({"ZONES"})

	if mainmission.manpads == nil then
		manpadinit = false
		mainmission.manpads = false
	end
	
	if mainmission.manpads == false then
		mainmission.manpads = false
		manpadinit = false
	else
		manpadinit = true
		mainmission.manpads = true
	end
	init = false
	MANPADS = {}
	AAA = {}
	manpadinit = true
	mainmission.manpads = true
else
  BASE:E({"Manpads and AA where already in existance ignoring"})
end

init=true
