_PASSWORD = "notset"
inputhash = 1

function checkislands()
	local am = AIRBASE:FindByName(AIRBASE.PersianGulf["Abu_Musa_Island_Airport"])
	local si = AIRBASE:FindByName(AIRBASE.PersianGulf["Sirri_Island"])
	local tk = AIRBASE:FindByName(AIRBASE.PersianGulf["Tunb_Kochak"])
	local ta = AIRBASE:FindByName(AIRBASE.PersianGulf["Tunb_Island_AFB"])
	local qs = AIRBASE:FindByName(AIRBASE.PersianGulf["Qeshm_Island"])
	local abna = AIRBASE:FindByName(AIRBASE.PersianGulf["Sir_Abu_Nuayr"])
	
	if tk:GetCoalition() == 2 and ta:GetCoalition() == 2 and si:GetCoalition() == 2 and am:GetCoalition() == 2 then
	  if PeleliuSpawned == false then
		local _Peleliu = GROUP:FindByName("Peleliu"):Activate()
		PeleliuSpawned = true
		MESSAGE:New("USS Peleliu has been activated and is sailing north to Kish",30):ToBlue()
		hm("USS Peleliu is in the AO and activated")
	  end
	  --if qs:GetCoalition() == 2 then
		  if NassauSpawned == false then
			  local _Nassau = GROUP:FindByName("Nassau"):Activate()
			  NassauSpawned = true
			  MESSAGE:New("USS Nassau has been activated and is sailing north to Qeshm",30):ToBlue()
			  hm("USS Nassau is in the AO and activated")
		  end
	  --end
	end
end
function robinput()
	
end

