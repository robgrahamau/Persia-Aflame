BASE:E({"SLOT HANDLER FOR PERSIA AFLAME LOADING"})
trigger.action.setUserFlag("SSB",100)
SEH = EVENTHANDLER:New()
SEH:HandleEvent(EVENTS.BaseCaptured)




trigger.action.setUserFlag(100,0)
TunbRed = STATIC:FindByName("CTLD Tnub")
TunbBlue = STATIC:FindByName("CTLD Tnub B")
tmsg = false
function slot_tunb(coalition)
    BASE:E({"SLOTS RUNNING FOR TUNB",coalition})
    if coalition == 1 then
      TunbBlue:Destroy()
      if TunbRed:IsAlive() ~= true then
        TunbRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Tnub"):Spawn()
      end
      trigger.action.setUserFlag("Tunb UH1 #001",0)
      trigger.action.setUserFlag("Tunb UH1",0)
      trigger.action.setUserFlag("Tunb MI8",0)
      trigger.action.setUserFlag("Tunb MI8 #001",0)
      trigger.action.setUserFlag("Tunb KA50",0)
      trigger.action.setUserFlag("Tunb KA50 #001",0)
      trigger.action.setUserFlag("Tunb US UH1",100)
      trigger.action.setUserFlag("Tunb US UH1 #001",100)
      trigger.action.setUserFlag("Tunb Georgia KA50",100)
      trigger.action.setUserFlag("Tunb Georgia KA50 #001",100)
      trigger.action.setUserFlag("Tunb Georgia MI8",100)
      trigger.action.setUserFlag("Tunb Georgia MI8 #001",100)
      ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Island", 4)
	  if tmsg == true then
		MESSAGE:New("Iran has Retaken Tunb from the Coalition Invaders!",30):ToAll()
		tmsg = false
	  end
    else
      TunbRed:Destroy()
      if TunbBlue:IsAlive() ~= true then
        TunbBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Tnub B"):Spawn()
      end
      trigger.action.setUserFlag("Tunb UH1 #001",100)
      trigger.action.setUserFlag("Tunb UH1",100)
      trigger.action.setUserFlag("Tunb MI8",100)
      trigger.action.setUserFlag("Tunb MI8 #001",100)
      trigger.action.setUserFlag("Tunb KA50",100)
      trigger.action.setUserFlag("Tunb KA50 #001",100)
      trigger.action.setUserFlag("Tunb US UH1",0)
      trigger.action.setUserFlag("Tunb US UH1 #001",0)
      trigger.action.setUserFlag("Tunb Georgia KA50",0)
      trigger.action.setUserFlag("Tunb Georgia KA50 #001",0)
      trigger.action.setUserFlag("Tunb Georgia MI8",0)
      trigger.action.setUserFlag("Tunb Georgia MI8 #001",0)
      ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Island", 4)
	  if tmsg == false then
		MESSAGE:New("Coalition forces have liberated Tunb from Iran",30):ToAll()
		tmsg = true
	  end	
    end
end

SirriRed = STATIC:FindByName("CTLD Sirri Island")
SirriBlue = STATIC:FindByName("CTLD Sirri Island B")
smsg = false
function slot_sirri(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Sirri Island",3)
  if coalition == 1 then
    SirriBlue:Destroy()
    if SirriRed:IsAlive() ~= true then
      SirriRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Sirri Island"):Spawn()
	  BASE:E({"LETS GET Sirri Red's name",SirriRed:GetName()})
    end
    trigger.action.setUserFlag("Sirri US Island MI8", 100)
    trigger.action.setUserFlag("Sirri US Island MI8 #001", 100)
    trigger.action.setUserFlag("Sirri US Island KA50", 100)
    trigger.action.setUserFlag("Sirri US Island KA50 #001", 100)
    trigger.action.setUserFlag("Sirri US Island UH1", 100)
    trigger.action.setUserFlag("Sirri US Island UH1 #001", 100)
	if smsg == true then
		MESSAGE:New("Iran has Retaken Sirri Island from the Coalition Invaders!",30):ToAll()
		smsg = false
    end
  else
    SirriRed:Destroy()
    if SirriBlue:IsAlive() ~= true then
      SirriBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Sirri Island B"):Spawn()
	  BASE:E({"LETS GET Sirri Blue's name",SirriBlue:GetName()})
    end
    trigger.action.setUserFlag("Sirri US Island MI8", 0)
    trigger.action.setUserFlag("Sirri US Island MI8 #001", 0)
    trigger.action.setUserFlag("Sirri US Island KA50", 0)
    trigger.action.setUserFlag("Sirri US Island KA50 #001", 0)
    trigger.action.setUserFlag("Sirri US Island UH1", 0)
    trigger.action.setUserFlag("Sirri US Island UH1 #001", 0)
	if smsg == false then
		MESSAGE:New("Coalition Forces have liberated Sirri Island from Iran",30):ToAll()
		smsg = true
	end
  end
end

LavanRed = STATIC:FindByName("CTLD Lavin")
LavanBlue = STATIC:FindByName("CTLD Lavin B")
lmsg = false
function slot_lavan(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Lavin Island",3)
  if coalition == 1 then
    LavanBlue:Destroy()
    if LavanRed:IsAlive() ~= true then
      LavanRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Lavin"):Spawn()
    end
    
    trigger.action.setUserFlag("Lavin Island UH1", 0)
    trigger.action.setUserFlag("Lavin Island UH1 #001", 0)
    trigger.action.setUserFlag("Lavin Island KA50", 0)
    trigger.action.setUserFlag("Lavin Island KA50 #001", 0)
    trigger.action.setUserFlag("Lavin Island MI8", 0)
    trigger.action.setUserFlag("Lavin Island MI8 #001", 0)
    trigger.action.setUserFlag("Lavin Island US UH1", 100)
    trigger.action.setUserFlag("Lavin Island US UH1 #001", 100)
    trigger.action.setUserFlag("Lavin Island US KA50", 100)
    trigger.action.setUserFlag("Lavin Island US KA50 #001", 100)
    trigger.action.setUserFlag("Lavin Island US MI8", 100)
    trigger.action.setUserFlag("Lavin Island US MI8 #001", 100)
	if lmsg == true then
		MESSAGE:New("Iran has retaken Lavan Island from the US Backed Infidels",30):ToAll()
		lmsg = false
	end
  else
    LavanRed:Destroy()
    if LavanBlue:IsAlive() ~= true then
      LavanBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Lavin B"):Spawn()
    end
    
    trigger.action.setUserFlag("Lavin Island UH1", 100)
    trigger.action.setUserFlag("Lavin Island UH1 #001", 100)
    trigger.action.setUserFlag("Lavin Island KA50", 100)
    trigger.action.setUserFlag("Lavin Island KA50 #001", 100)
    trigger.action.setUserFlag("Lavin Island MI8", 100)
    trigger.action.setUserFlag("Lavin Island MI8 #001", 100)
    trigger.action.setUserFlag("Lavin Island US UH1", 00)
    trigger.action.setUserFlag("Lavin Island US UH1 #001", 00)
    trigger.action.setUserFlag("Lavin Island US KA50", 00)
    trigger.action.setUserFlag("Lavin Island US KA50 #001", 00)
    trigger.action.setUserFlag("Lavin Island US MI8", 00)
    trigger.action.setUserFlag("Lavin Island US MI8 #001", 00)
	if lmsg == false then
		MESSAGE:New("The US Led Coalition has liberated Lavan Island from Irani dictatorship",30):ToAll()
		lmsg = true
	end
  end
end
KishBlue = STATIC:FindByName("CTLD Kish B")
KishRed = STATIC:FindByName("CTLD Kish")
kimsg = false
function slot_kish(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Kish Island",3)
  if coalition == 1 then
    KishBlue:Destroy()
    if KishRed:IsAlive() ~= true then
      KishRed:ReSpawn() --= SPAWNSTATIC:NewFromStatic("CTLD Kish"):Spawn()
    end
    trigger.action.setUserFlag("Kish UH1", 0)
    trigger.action.setUserFlag("Kish UH1 #001", 0)
    trigger.action.setUserFlag("Kish Mi8", 0)
    trigger.action.setUserFlag("Kish Mi8 #001", 0)
    trigger.action.setUserFlag("Kish KA50", 0)
    trigger.action.setUserFlag("Kish KA50 #001", 0)
    trigger.action.setUserFlag("Kish US UH1", 100)
    trigger.action.setUserFlag("Kish US UH1 #001", 100)
    trigger.action.setUserFlag("Kish US KA50", 100)
    trigger.action.setUserFlag("Kish US KA50 #001", 100)
	ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},0)
	ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},0)
	if kimsg == true then
		MESSAGE:New("Kish Island is once more under Irani Control",30):ToAll()
		kimsg = false
	end
  else
    KishRed:Destroy()
    if KishBlue:IsAlive() ~= true then
      KishBlue = SPAWNSTATIC:NewFromStatic("CTLD Kish B"):Spawn()
    end
    trigger.action.setUserFlag("Kish UH1", 100)
    trigger.action.setUserFlag("Kish UH1 #001", 100)
    trigger.action.setUserFlag("Kish Mi8", 100)
    trigger.action.setUserFlag("Kish Mi8 #001", 100)
    trigger.action.setUserFlag("Kish KA50", 100)
    trigger.action.setUserFlag("Kish KA50 #001", 100)
    trigger.action.setUserFlag("Kish US UH1", 0)
    trigger.action.setUserFlag("Kish US UH1 #001", 0)
    trigger.action.setUserFlag("Kish US KA50", 0)
    trigger.action.setUserFlag("Kish US KA50 #001", 0)
	ra2disp:SetSquadron("Kish",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_1"},2)
	ra2disp:SetSquadron("Kish INT",AIRBASE.PersianGulf.Kish_International_Airport,{"M2000_2"},2)
	if kimsg == false then
		MESSAGE:New("Kish Island has been taken by the coalition forces",30):ToAll()
		kimsg = true
	end
  end
end



QeshmRed = STATIC:FindByName("CTLD Qeshm Island")
QeshmBlue = STATIC:FindByName("CTLD Qeshm Island B")
qemsg = false
function slot_qeshm(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Qeshm Island",4)
  if coalition == 1 then
    QeshmBlue:Destroy()
    if QeshmRed:IsAlive() ~= true then
      QeshmRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Qeshm Island"):Spawn()
    end
    trigger.action.setUserFlag("Qeshm Island US UH1", 100)
    trigger.action.setUserFlag("Qeshm Island US UH1 #001", 100)
    trigger.action.setUserFlag("Qeshm Island US KA50", 100)
    trigger.action.setUserFlag("Qeshm Island US KA50 #001", 100)
	if qemsg == true then
		MESSAGE:New("Qeshm Island has been Liberated from the Coalition invaders and Infidels",30):ToAll()
		qemsg = false
	end
  else
    QeshmRed:Destroy()
    if QeshmBlue:IsAlive() ~= true then
      QeshmBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Qeshm Island B"):Spawn()
      
    end
    trigger.action.setUserFlag("Qeshm Island US UH1", 00)
    trigger.action.setUserFlag("Qeshm Island US UH1 #001", 00)
    trigger.action.setUserFlag("Qeshm Island US KA50", 00)
    trigger.action.setUserFlag("Qeshm Island US KA50 #001", 00)
	if qemsg == false then
		MESSAGE:New("Qesh Island has been occuiped, Coalition forces are one step closer to taking Iran!",30):ToAll()
		qemsg = true
	end
  end
end

KhasabRed = STATIC:FindByName("CTLD AbuFarp B")
KhasabBlue = STATIC:FindByName("CTLD AbuFarp")
khmsg = false

function slot_khasab(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Khasab",4)
  if coalition == 1 then
    KhasabBlue:Destroy()
    if KhasabRed:IsAlive() ~= true then
      KhasabRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD AbuFarp B"):Spawn()
    end
    trigger.action.setUserFlag("RED KA50 Khasab", 00)
    trigger.action.setUserFlag("RED KA50 Khasab #001", 00)
    trigger.action.setUserFlag("RED UH1 Khasab", 00)
    trigger.action.setUserFlag("RED UH1 Khasab #001", 00)
    trigger.action.setUserFlag("SA342Mini #001", 100)
    trigger.action.setUserFlag("SA342Mini", 100)
    trigger.action.setUserFlag("UH1-Khasab 3", 100)
    trigger.action.setUserFlag("UH1-Khasab 2", 100)
    trigger.action.setUserFlag("UH1-Khasab 1", 100)
    trigger.action.setUserFlag("UH1-Khasab", 100)
    trigger.action.setUserFlag("KA50",100)
    trigger.action.setUserFlag("KA50 #001",100)
    trigger.action.setUserFlag("SA342Mist",100)
    trigger.action.setUserFlag("SA342Mist #001",100)
    trigger.action.setUserFlag("SA342M",100)
    trigger.action.setUserFlag("SA342M #001",100)
    trigger.action.setUserFlag("MI8-1",100)
    trigger.action.setUserFlag("MI8-2",100)
    trigger.action.setUserFlag("A10C_HAWG3_99",100)
    trigger.action.setUserFlag("A10C_HAWG3_100",100)
    trigger.action.setUserFlag("A10C_HAWG3_101",100)
    trigger.action.setUserFlag("A10C_HAWG3_102",100)
    trigger.action.setUserFlag("L-39ZA",100)
    trigger.action.setUserFlag("L-39ZA #001",100)
    trigger.action.setUserFlag("C-101CC",100)
    trigger.action.setUserFlag("C-101CC #001",100)
    trigger.action.setUserFlag("COLT5-54",100)
    trigger.action.setUserFlag("COLT5-55",100)
    trigger.action.setUserFlag("COLT5-56",100)
    trigger.action.setUserFlag("COLT5-57",100)
	if khmsg == true then
		MESSAGE:New("Iran Forces have captured Khasab in the Omani Republic!",30):ToAll()
		khmsg = false
	end
  else
    KhasabRed:Destroy()
    if KhasabBlue:IsAlive() ~= true then
      KhasabBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD AbuFarp"):Spawn()
    end
    trigger.action.setUserFlag("RED KA50 Khasab", 100)
    trigger.action.setUserFlag("RED KA50 Khasab #001", 100)
    trigger.action.setUserFlag("RED UH1 Khasab", 100)
    trigger.action.setUserFlag("RED UH1 Khasab #001", 100)
    trigger.action.setUserFlag("SA342Mini #001", 00)
    trigger.action.setUserFlag("SA342Mini", 00)
    trigger.action.setUserFlag("UH1-Khasab 3", 00)
    trigger.action.setUserFlag("UH1-Khasab 2", 00)
    trigger.action.setUserFlag("UH1-Khasab 1", 00)
    trigger.action.setUserFlag("UH1-Khasab", 00)
    trigger.action.setUserFlag("KA50",00)
    trigger.action.setUserFlag("KA50 #001",00)
    trigger.action.setUserFlag("SA342Mist",00)
    trigger.action.setUserFlag("SA342Mist #001",00)
    trigger.action.setUserFlag("SA342M",00)
    trigger.action.setUserFlag("SA342M #001",00)
    trigger.action.setUserFlag("MI8-1",00)
    trigger.action.setUserFlag("MI8-2",00)
    trigger.action.setUserFlag("A10C_HAWG3_99",00)
    trigger.action.setUserFlag("A10C_HAWG3_100",00)
    trigger.action.setUserFlag("A10C_HAWG3_101",00)
    trigger.action.setUserFlag("A10C_HAWG3_102",00)
    trigger.action.setUserFlag("L-39ZA",00)
    trigger.action.setUserFlag("L-39ZA #001",00)
    trigger.action.setUserFlag("C-101CC",00)
    trigger.action.setUserFlag("C-101CC #001",00)
    trigger.action.setUserFlag("COLT5-54",00)
    trigger.action.setUserFlag("COLT5-55",00)
    trigger.action.setUserFlag("COLT5-56",00)
    trigger.action.setUserFlag("COLT5-57",00)
	if khmsg == false then
		MESSAGE:New("The Omani People rest easier knowing that the Coalition has retaken Khasab",30):ToAll()
		khmsg = true
	end
  end

end


BandarRed = STATIC:FindByName("CTLD BandarFarp")
BandarBlue = STATIC:FindByName("CTLD BandarFarp B")
banmsg = false
function slot_bandar(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Bandar Abbas",4)
  if coalition == 1 then
    BandarBlue:Destroy()
    if BandarRed:IsAlive() ~= true then
      BandarRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD BandarFarp"):Spawn()
    end
    trigger.action.setUserFlag("Bandar MI8", 00)
    trigger.action.setUserFlag("Bandar MI8 #001", 00)
    trigger.action.setUserFlag("Bandar UH1", 00)
    trigger.action.setUserFlag("Bandar UH1 #001", 00)
    trigger.action.setUserFlag("Bandar KA50", 00)
    trigger.action.setUserFlag("Bandar KA50 #001", 00)
    trigger.action.setUserFlag("Bandar KA50 #002", 00)
    trigger.action.setUserFlag("Bandar KA50 #003", 00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR", 00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr", 00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr #001",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR #001",00)
    trigger.action.setUserFlag("Bandar_Mig-29 422",00)
    trigger.action.setUserFlag("Bandar_Mig-29",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #001",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #002",00)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #003",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #003",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #004",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #002",00)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #001",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #002",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #003",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #001",00)
    trigger.action.setUserFlag("Bander_M2000_Enfield2",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #001",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #002",00)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #003",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #001",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #002",00)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #003",00)
	trigger.action.setUserFlag("IRAF31th",00)
	trigger.action.setUserFlag("IRAF31th #001",00)
	ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},4)
	ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},4)
	if banmsg == true then
		MESSAGE:New("Iran has liberated Bandar Abbas from the oppressors and it is once more in our hands!",30):ToAll()
	end
  else
    BandarRed:Destroy()
    if BandarBlue:IsAlive() ~= true then
      BandarBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD BandarFarp B"):Spawn()
    end
    trigger.action.setUserFlag("Bandar MI8", 100)
    trigger.action.setUserFlag("Bandar MI8 #001", 100)
    trigger.action.setUserFlag("Bandar UH1", 100)
    trigger.action.setUserFlag("Bandar UH1 #001", 100)
    trigger.action.setUserFlag("Bandar KA50", 100)
    trigger.action.setUserFlag("Bandar KA50 #001", 100)
    trigger.action.setUserFlag("Bandar KA50 #002", 100)
    trigger.action.setUserFlag("Bandar KA50 #003", 100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR", 100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr", 100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 nohgnr #001",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 No HNGR #001",100)
    trigger.action.setUserFlag("Bandar_Mig-29 422",100)
    trigger.action.setUserFlag("Bandar_Mig-29",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #001",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #002",100)
    trigger.action.setUserFlag("Bander_F5E_Enfield2 #003",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #003",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #004",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #002",100)
    trigger.action.setUserFlag("Bandar_Mig-21_Chevy1 #001",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #002",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #003",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2 #001",100)
    trigger.action.setUserFlag("Bander_M2000_Enfield2",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #001",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #002",100)
    trigger.action.setUserFlag("Bandar_F-14B_Colt8_424 #003",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #001",100)
    trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #002",100)
	trigger.action.setUserFlag("Bandar_JF-17_Springfield4 #003",100)
	trigger.action.setUserFlag("IRAF31th",100)
	trigger.action.setUserFlag("IRAF31th #001",100)
	ra2disp:SetSquadron("Bandar Abbas",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG21_1","MIG29_2"},0)
	ra2disp:SetSquadron("Bandar Abbas 2",AIRBASE.PersianGulf.Bandar_Abbas_Intl,{"MIG29_1","MIG29_2","JF17_1","JF17_2","F4_1","F4_2"},0)
	if banmsg == true then
		MESSAGE:New("Coalition forces have occupied Bandar! We have crossed the Strait!",30):ToAll()
		banmsg = false
	end
  end

end

LarsRed = STATIC:FindByName("CTLD FLar")
LarsBlue = STATIC:FindByName("CTLD FLar B")
larmsg = false
function slot_lars(coalition)
  ctld.changeRemainingGroupsForPickupZone("CTLD Lar AFB",4)
  if coalition == 1 then
    LarsBlue:Destroy()
    if LarsRed:IsAlive() ~= true then
      LarsRed:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD FLar B"):Spawn()
    end
    trigger.action.setUserFlag("LARS_JF-17_Springfield7", 00)
    trigger.action.setUserFlag("LARS_JF-17_Springfield7 #001", 00)
	trigger.action.setUserFlag("Pak-F16-Lar",00)
	trigger.action.setUserFlag("Pak-F16-Lar #001",00)
	trigger.action.setUserFlag("Pak-F16-Lar #002",00)
	  ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},2)
  ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},2)
  if larmsg == true then
	MESSAGE:New("Lars is once more back in Irani Control",30):ToAll()
	larmsg = true
  end
  else
    LarsRed:Destroy()
    if LarsBlue:IsAlive() ~= true then
      LarsBlue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD FLar"):Spawn()
    end   
    trigger.action.setUserFlag("LARS_JF-17_Springfield7", 100)
    trigger.action.setUserFlag("LARS_JF-17_Springfield7 #001", 100)
	trigger.action.setUserFlag("Pak-F16-Lar",100)
	trigger.action.setUserFlag("Pak-F16-Lar #001",100)
	trigger.action.setUserFlag("Pak-F16-Lar #002",100)
	ra2disp:SetSquadron("Lar",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},0)
	ra2disp:SetSquadron("Lar Int",AIRBASE.PersianGulf.Lar_Airbase,{"F4_2"},0)
	if larmsg == false then
		MESSAGE:New("Lar Airbase has falledn to coalition forces",30):ToAll()
		larmsg = true
	end
  end
end


abunred = STATIC:FindByName("CTLD Abu Nuayr B")
abunblue = STATIC:FindByName("CTLD Abu Nuayr")
abunmsg = false
function slot_abun(coalition)
  if coalition == 1 then
    abunblue:Destroy()
    if abunred:IsAlive() ~= true then
      abunred:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Abu Nuayr B"):Spawn()
    end
	if abunmsg == true then
		MESSAGE:New("Iran has taken Abu Nuayr!",30):ToAll()
		abunmsg = false
	end
  else
    abunred:Destroy()
    if abunblue:IsAlive() ~= true then
      abunblue:ReSpawn() -- = SPAWNSTATIC:NewFromStatic("CTLD Abu Nuayr"):Spawn()
    end
	if abunmsg == false then
		MESSAGE:New("Coalition Forces have retaken Abu Nuayr",30):ToAll()
		abunmsg = true
	end
  end

end

havmsg = false
function slot_havadarya(coalition)
	if coalition == 1 then
		trigger.action.setUserFlag("Frogfoot 31", 00)
		trigger.action.setUserFlag("Frogfoot 32", 00)
		trigger.action.setUserFlag("Frogfoot 33", 00)
		trigger.action.setUserFlag("Frogfoot 34", 00)
		trigger.action.setUserFlag("Hav US UH1", 100)
		trigger.action.setUserFlag("Hav US UH1 #001", 100)
		trigger.action.setUserFlag("Hav US UH1 #002", 100)
		trigger.action.setUserFlag("Hav US UH1 #003", 100)
		trigger.action.setUserFlag("Hav US KA50", 100)
		trigger.action.setUserFlag("Hav US KA50 #001", 100)
		trigger.action.setUserFlag("Hav US KA50 #002", 100)
		trigger.action.setUserFlag("Hav US KA50 #003", 100)
		ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},4)
		if havmsg == true then
			MESSAGE:New("Havadarya has been retaken by the Irani People!",30):ToAll()
			havmsg = false
		end
	else
		trigger.action.setUserFlag("Frogfoot 31", 100)
		trigger.action.setUserFlag("Frogfoot 32", 100)
		trigger.action.setUserFlag("Frogfoot 33", 100)
		trigger.action.setUserFlag("Frogfoot 34", 100)
		trigger.action.setUserFlag("Hav US UH1", 00)
		trigger.action.setUserFlag("Hav US UH1 #001", 00)
		trigger.action.setUserFlag("Hav US UH1 #002", 00)
		trigger.action.setUserFlag("Hav US UH1 #003", 00)
		trigger.action.setUserFlag("Hav US KA50", 00)
		trigger.action.setUserFlag("Hav US KA50 #001", 00)
		trigger.action.setUserFlag("Hav US KA50 #002", 00)
		trigger.action.setUserFlag("Hav US KA50 #003", 00)
		ra2disp:SetSquadron("Bandar Abbas INT",AIRBASE.PersianGulf.Havadarya,{"MIG21_2"},0)
		if havmsg == false then
			MESSAGE:New("Coalition forces have taken Havadarya!",30):ToAll()
			havmsg = true 
		end
	end

end

function slot_jir(coalition)
	if coalition == 1 then
		trigger.action.setUserFlag("Pak-F16-Jiroft", 00)
		trigger.action.setUserFlag("Pak-F16-Jiroft #001", 00)
		trigger.action.setUserFlag("Pak-F16-Jiroft #002", 00)
	else
		trigger.action.setUserFlag("Pak-F16-Jiroft", 100)
		trigger.action.setUserFlag("Pak-F16-Jiroft #001", 100)
		trigger.action.setUserFlag("Pak-F16-Jiroft #002", 100)
	end
end


slot_tunb(1)
slot_sirri(1)
slot_lavan(1)
slot_kish(1)
slot_qeshm(1)
slot_khasab(2)
slot_bandar(1)
slot_lars(1)
slot_abun(2)
slot_havadarya(1)

function SEH:OnEventBaseCaptured(EventData)
 local AirbaseName = EventData.PlaceName -- The name of the airbase that was captured.
 local ABItem = AIRBASE:FindByName(AirbaseName)
 local coalition = ABItem:GetCoalition()
  -- local coalition = EventData.getCoalition()
 BASE:E({"Main Slot Controller BASE Captured Detected" .. AirbaseName,coalition})  
 if AirbaseName == AIRBASE.PersianGulf.Lar_Airbase then
    AbLar = coalition
 elseif AirbaseName == AIRBASE.PersianGulf.Sir_Abu_Nuayr then
    ctld.changeRemainingGroupsForPickupZone("CTLD Abu Nuayr", 3)
    slot_abun(2)    
 elseif AirbaseName == AIRBASE.PersianGulf.Sirri_Island then
    slot_sirri(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Abu_Musa_Island_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Abu Musa",3)
 elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Kochak then
    ctld.changeRemainingGroupsForPickupZone("CTLD Tunb Kochak", 3)
 elseif AirbaseName == AIRBASE.PersianGulf.Tunb_Island_AFB then
    slot_tunb(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Lavan_Island_Airport then
    slot_lavan(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Kish_International_Airport then
    slot_kish(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Qeshm_Island then
    slot_qeshm(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Khasab then
    slot_khasab(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl then
    slot_bandar(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Lar_Airbase then
    slot_lars(coalition)
 elseif AirbaseName == AIRBASE.PersianGulf.Jiroft_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Jiroft", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Shiraz_International_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Shiraz", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Kerman_Airport then
    ctld.changeRemainingGroupsForPickupZone("CTLD Kerman", 4)
 elseif AirbaseName == AIRBASE.PersianGulf.Havadarya then
	slot_havadarya(coalition)
 end

end
function SEH:OnEventDead(EventData)


end

stn = UNIT:FindByName("Stennis")
lh2 = UNIT:FindByName("LHA-2")
tdy = UNIT:FindByName("TeddyR")
tar = UNIT:FindByName("Tarawa")
GW = UNIT:FindByName("Washington")

stn:HandleEvent(EVENTS.Dead)
lh2:HandleEvent(EVENTS.Dead)
tdy:HandleEvent(EVENTS.Dead)
tar:HandleEvent(EVENTS.Dead)
GW:HandleEvent(EVENTS.Dead)
function GW:OnEventDead(EventData)
  if GW:IsAlive() ~= true then
  trigger.action.setUserFlag("GW_450",100)
  trigger.action.setUserFlag("GW_451",100)
  trigger.action.setUserFlag("GW_452",100)
  trigger.action.setUserFlag("GW_454",100)
  trigger.action.setUserFlag("GW_221",100)
  trigger.action.setUserFlag("GW_222",100)
  trigger.action.setUserFlag("GW_223",100)
  trigger.action.setUserFlag("GW_224",100)
  end
end

function stn:OnEventDead(EventData)
  if stn:IsAlive() ~= true then
    trigger.action.setUserFlag("STN_141",100)
    trigger.action.setUserFlag("STN_142",100)
    trigger.action.setUserFlag("STN_143",100)
    trigger.action.setUserFlag("STN_144",100)
    trigger.action.setUserFlag("STN_440",100)
    trigger.action.setUserFlag("STN_441",100)
    trigger.action.setUserFlag("STN_442",100)
    trigger.action.setUserFlag("STN_443",100)
    trigger.action.setUserFlag("STN_444",100)
    
  end
end
function lh2:OnEventDead(EventData)
  if lh2:IsAlive() ~= true then
    trigger.action.setUserFlag("STN-LHA2-Huey333",100)
    trigger.action.setUserFlag("STN-LHA2-Huey334",100)
    trigger.action.setUserFlag("STN-LHA2-Huey335",100)
    trigger.action.setUserFlag("STN-LHA2-Huey336",100)
    trigger.action.setUserFlag("STN-TAR-490",100)
    trigger.action.setUserFlag("STN-TAR-491",100)
    trigger.action.setUserFlag("STN-TAR-492",100)
    trigger.action.setUserFlag("STN-TAR-493",100)
    trigger.action.setUserFlag("STN-TAR-494",100)
  end
end

function tdy:OnEventDead(EventData)
  if tdy:IsAlive() ~= true then
    trigger.action.setUserFlag("TDY_101",100)
    trigger.action.setUserFlag("TDY_102",100)
    trigger.action.setUserFlag("TDY_103",100)
    trigger.action.setUserFlag("TDY_104",100)
    trigger.action.setUserFlag("TDY_105",100)
    trigger.action.setUserFlag("TDY_106",100)
    trigger.action.setUserFlag("TDY_107",100)
    trigger.action.setUserFlag("TDY_108",100)
    trigger.action.setUserFlag("TDY_401",100)
    trigger.action.setUserFlag("TDY_402",100)
    trigger.action.setUserFlag("TDY_403",100)
    trigger.action.setUserFlag("TDY_404",100)
    trigger.action.setUserFlag("TDY_405",100)
    trigger.action.setUserFlag("TDY_406",100)
    trigger.action.setUserFlag("TDY_407",100)
    trigger.action.setUserFlag("TDY_408",100)
    trigger.action.setUserFlag("TDY_409",100)
    trigger.action.setUserFlag("TDY_410",100)
    trigger.action.setUserFlag("TDY_411",100)
    trigger.action.setUserFlag("TDY_412",100)
  end
end

function tar:OnEventDead(EventData)
  if tar:IsAlive() ~= true then
    trigger.action.setUserFlag("TDY-TAR-480",100)
    trigger.action.setUserFlag("TDY-TAR-481",100)
    trigger.action.setUserFlag("TDY-TAR-482",100)
    trigger.action.setUserFlag("TDY-TAR-484",100)
    trigger.action.setUserFlag("TDY-TAR-Huey-303",100)
    trigger.action.setUserFlag("TDY-TAR-Huey314",100)
    trigger.action.setUserFlag("TDY-TAR-Huey319",100)
    trigger.action.setUserFlag("TDY-TAR-Huey444",100)
    trigger.action.setUserFlag("TED-TAR-KA50-21",100)
    trigger.action.setUserFlag("TED-TAR-KA50-22",100)
    trigger.action.setUserFlag("TED-TAR-KA50-23",100)
    trigger.action.setUserFlag("TED-TAR-KA50-24",100)
    trigger.action.setUserFlag("TED-TAR-Mi8-55",100)
    trigger.action.setUserFlag("TED-TAR-Mi8-56",100)
    trigger.action.setUserFlag("TED-TAR-SA342L-44",100)
    trigger.action.setUserFlag("TED-TAR-SA342L-45",100)
    trigger.action.setUserFlag("TED-TAR-SA342Min-222",100)
    trigger.action.setUserFlag("TED-TAR-SA342Min-223",100)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-111",100)
    trigger.action.setUserFlag("TED-TAR-SA342Mini-112",100)
    trigger.action.setUserFlag("TED-TAR-SA342m-66",100)
    trigger.action.setUserFlag("TED-TAR-SA342m-67",100)
  end
end


world.addEventHandler(SEH)

BASE:E({"SLOT HANDLER FOR PERSIA AFLAME LOADED"})