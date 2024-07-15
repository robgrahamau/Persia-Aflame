-- This file is our main AI runner for the training mission it also handles the AI menutree
RangeTopMenu = MENU_COALITION:New(2,"Kobuleti Training Control")
SA2 = GROUP:FindByName("AI_SA2")
SA3 = GROUP:FindByName("AI_SA3")
SA6 = GROUP:FindByName("AI_SA6")
SA8 = GROUP:FindByName("AI_SA8")
SA10 = GROUP:FindByName("AI_SA10")
SA11 = GROUP:FindByName("AI_SA11")
SA15 = GROUP:FindByName("AI_SA15")
SA19 = GROUP:FindByName("AI_SA19")
RAPIER = GROUP:FindByName("AI_RAPIER")
HAWK = GROUP:FindByName("AI_HAWK")
NASAM = GROUP:FindByName("AI_NASAM")
SAMACTIVATIONTIME = nil
ACTIVETYPE = nil
SAMS = {SA2,SA3,SA6,SA8,SA10,SA11,SA15,SA19,RAPIER,HAWK,NASAM,}
AI_KOB_DEF_PAT = GROUP:FindByName("AI_KOB_DEF_PAT")
AI_KOB_DEF_NASAM = GROUP:FindByName("AI_KOB_DEF_NASAM")
AI_KOB_DEF_CRAM = GROUP:FindByName("AI_KOB_DEF_CRAM")
LIVEFIREROOTMENU = nil
lmenu1 = nil
lmenu2 = nil
lmenu3 = nil

MOVINGGROUP = GROUP:FindByName("moving1")
STATICGROUP = GROUP:FindByName("static1")
MPADVALLY1 = GROUP:FindByName("AI_MPADVALLY-1")
MPADVALLY2 = GROUP:FindByName("AI_MPADVALLY-2")
MPADVALLY3 = GROUP:FindByName("AI_MPADVALLY-3")
MPADVALLY4 = GROUP:FindByName("AI_MPADVALLY-4")
MPADVALLY5 = GROUP:FindByName("AI_MPADVALLY-5")

A2A_EASY = GROUP:FindByName("A2A_EASY")
A2A_EA = nil
A2A_EASY_S = SPAWN:New("A2A_EASY")
A2A_MEDIUM = GROUP:FindByName("A2A_MEDIUM")
A2A_ME = nil
A2A_MEDIUM_S = SPAWN:New("A2A_MEDIUM")
A2A_HARD = GROUP:FindByName("A2A_HARD")
A2A_HA = nil
A2A_HARD_S = SPAWN:New("A2A_HARD")
A2A_VHARD = GROUP:FindByName("A2A_VHARD")
A2A_VH = nil
A2A_VHARD_S = SPAWN:New("A2A_VHARD")
A2A_EHARD = GROUP:FindByName("A2A_EHARD")
A2A_EHARD_S = SPAWN:New("A2A_EHARD")
A2A_EH = nil
AIR_ACTIVETYPE = nil
AI_ACTIVEFIRE = GROUP:FindByName("AI_ACTIVEFIRE")
if AI_ACTIVEFIRE:IsAlive() then
  AI_ACTIVEFIRE:Destroy()
end
AI_BCONTACT = GROUP:FindByName("AI_BCONTACT")
if AI_BCONTACT:IsAlive() then
  AI_BCONTACT:Destroy()
end
AI_RCONTACT = GROUP:FindByName("AI_RCONTACT")
if AI_RCONTACT:IsAlive() then
  AI_RCONTACT:Destroy()
end
SAMLIVE = false
AIRLIVE = false
LIVEACT = false
TCONACT = false


function activatesam(sitetype)
	if sitetype ~= nil then
		SAMLIVE = true
		if sitetype:IsAlive() == true then
			sitetype:Destroy()
		end
      sitetype:Respawn()
			sitetype:Activate()
			hm("Warning Sam Site of type ".. sitetype:GetName() .. " Restricted Airspace activated \n If no one is within R551A in 60 Minutes Site will deactivate")
			MESSAGE:New("Warning Sam Site of type ".. sitetype:GetName() .. " Restricted Airspace activated \n If no one is within R551A in 60 Minutes Site will deactivate",20,"Range Master"):ToAll()
      ACTIVATE_R551A()
      SAMACTIVATIONTIME = timer.getTime()
      ACTIVETYPE = sitetype
			sammenu("active",sitetype)
	else
			hm("error in activatesam") 
	end
end

function deactivatesam(sitetype)
	if sitetype ~= nil then
		SAMLIVE = false
		if sitetype:IsAlive() == true then
			sitetype:Destroy()
      ACTIVETYPE = nil
    end
		hm("deactivating Sam Site of type ".. sitetype:GetName() .. " Restricted Airspace dactivated")
		MESSAGE:New("deactivating Sam Site of type ".. sitetype:GetName() .. " Restricted Airspace deactivated",20,"Range Master"):ToAll()
		sammenu("inactive",nil)
    DEACTIVATE_R551A()
    clean('R551A')
	end
end

function sammenu(state,samtype)
  if state == "init" then
    sammenutop = MENU_COALITION:New(2,"SAM TRAINING RANGE",RangeTopMenu)
      sammenutop1 = MENU_COALITION:New(2,"RUSSIAN SAMS",sammenutop)
        sammenu1 = MENU_COALITION_COMMAND:New(2,"Activate SA2",sammenutop1,activatesam,SA2)
        sammenu2 = MENU_COALITION_COMMAND:New(2,"Activate SA3",sammenutop1,activatesam,SA3)
        sammenu3 = MENU_COALITION_COMMAND:New(2,"Activate SA6",sammenutop1,activatesam,SA6)
        sammenu4 = MENU_COALITION_COMMAND:New(2,"Activate SA8",sammenutop1,activatesam,SA8)
        sammenu5 = MENU_COALITION_COMMAND:New(2,"Activate SA10",sammenutop1,activatesam,SA10)
        sammenu6 = MENU_COALITION_COMMAND:New(2,"Activate SA11",sammenutop1,activatesam,SA11)
        sammenu7 = MENU_COALITION_COMMAND:New(2,"Activate SA15",sammenutop1,activatesam,SA15)
        sammenu8 = MENU_COALITION_COMMAND:New(2,"Activate SA19",sammenutop1,activatesam,SA19)
      sammenutop2 = MENU_COALITION:New(2,"US SAMS",sammenutop)
        sammenu9 = MENU_COALITION_COMMAND:New(2,"Activate RAPIER",sammenutop2,activatesam,RAPIER)
        sammenu10 = MENU_COALITION_COMMAND:New(2,"Activeate HAWK",sammenutop2,activatesam,HAWK)
        sammenu11 = MENU_COALITION_COMMAND:New(2,"Activeate NASAM",sammenutop2,activatesam,NASAM)
      
  elseif state == "inactive" then
    sammenu1:Remove()
    sammenu1 = MENU_COALITION_COMMAND:New(2,"Activate SA2",sammenutop1,activatesam,SA2)
    sammenu2 = MENU_COALITION_COMMAND:New(2,"Activate SA3",sammenutop1,activatesam,SA3)
    sammenu3 = MENU_COALITION_COMMAND:New(2,"Activate SA6",sammenutop1,activatesam,SA6)
    sammenu4 = MENU_COALITION_COMMAND:New(2,"Activate SA8",sammenutop1,activatesam,SA8)
    sammenu5 = MENU_COALITION_COMMAND:New(2,"Activate SA10",sammenutop1,activatesam,SA10)
    sammenu6 = MENU_COALITION_COMMAND:New(2,"Activate SA11",sammenutop1,activatesam,SA11)
    sammenu7 = MENU_COALITION_COMMAND:New(2,"Activate SA15",sammenutop1,activatesam,SA15)
    sammenu8 = MENU_COALITION_COMMAND:New(2,"Activate SA19",sammenutop1,activatesam,SA19)
    sammenu9 = MENU_COALITION_COMMAND:New(2,"Activate RAPIER",sammenutop2,activatesam,RAPIER)
    sammenu10 = MENU_COALITION_COMMAND:New(2,"Activeate HAWK",sammenutop2,activatesam,HAWK)
    sammenu11 = MENU_COALITION_COMMAND:New(2,"Activeate NASAM",sammenutop2,activatesam,NASAM)
  elseif state == "active" then
    sammenu1:Remove()
    sammenu2:Remove()
    sammenu3:Remove()
    sammenu4:Remove()
    sammenu5:Remove()
    sammenu6:Remove()
    sammenu7:Remove()
    sammenu8:Remove()
    sammenu9:Remove()
    sammenu10:Remove()
    sammenu11:Remove()
    sammenu1 = MENU_COALITION_COMMAND:New(2,"Deactivate Sam",sammenutop,deactivatesam,samtype)
  end
end

sammenu("init",nil)

function SPAWNAIR(_spawn,_var)
  if _var ~= nil then
    if _var:IsAlive() then
      _var:Destroy()
    end
  end
  _var = _spawn:Spawn()
  return _var
end



function ACTIVATEAIR(airtype)
  if airtype ~= nil then
    AIRLIVE = true
    if airtype == A2A_EASY then
      A2A_EA = SPAWNAIR(A2A_EASY_S,A2A_EA)
    elseif airtype == A2A_MEDIUM then
      A2A_ME = SPAWNAIR(A2A_EASY_S,A2A_ME)
    elseif airtype == A2A_HARD then
      A2A_HA = SPAWNAIR(A2A_HARD_S,A2A_HA)
      airtype = A2A_HARD
    elseif airtype == A2A_VHARD then
      A2A_VH = SPAWNAIR(A2A_VHARD_S,A2A_VH)
    elseif airtype == A2A_EHARD then
      A2A_EH = SPAWNAIR(A2A_EHARD_S,A2A_EH)
    end
    AIR_ACTIVETYPE = airtype
    ACTIVATE_R552()
    hm("Warning AI Air of type ".. airtype:GetName() .. " has been Activated, Restricted Airspace now active \n Remain within Zone or Air Unit will deactivate")
    MESSAGE:New("Warning AI Air of type ".. airtype:GetName() .. " has been Activated, Restricted Airspace now active \n Remain within Zone or Airunit will deactivate",20,"Range Master"):ToAll()
    AIRMENU("active",airtype)
  else
      hm("error in ACTIVATEAIR") 
  end
end

function DEACTIVATEAIR(airtype)
  if airtype ~= nil then
    AIRLIVE = false
    DEACTIVATE_R552()
    if airtype == A2A_EASY then
      A2A_EA:Destroy()
    elseif airtype == A2A_MEDIUM then
      A2A_ME:Destroy()
    elseif airtype == A2A_HARD then
      A2A_HA:Destroy()
      airtype = A2A_HARD
    elseif airtype == A2A_VHARD then
      A2A_VH:Destroy()
    elseif airtype == A2A_EHARD then
      A2A_EH:Destroy()
    end
    AIR_ACTIVETYPE = nil
      hm("deactivating air unit of type ".. airtype:GetName() .. " Restricted Airspace dactivated")
      MESSAGE:New("deactivating air unit of type ".. airtype:GetName() .. " Restricted Airspace deactivated",20,"Range Master"):ToAll()
      AIRMENU("inactive",nil)
  end
end

function AIRMENU(state,airtype)
  if state == "init" then
    Airtraining = MENU_COALITION:New(2,"AIR TRAINING RANGE",RangeTopMenu)
    amenu1 = MENU_COALITION_COMMAND:New(2,"Activate Guns",Airtraining,ACTIVATEAIR,A2A_EASY)
    amenu2 = MENU_COALITION_COMMAND:New(2,"Activate Fox-1",Airtraining,ACTIVATEAIR,A2A_HARD)
    amenu3 = MENU_COALITION_COMMAND:New(2,"Activate Fox-2",Airtraining,ACTIVATEAIR,A2A_MEDIUM)
    amenu4 = MENU_COALITION_COMMAND:New(2,"Activate Fox-1/2 Hard",Airtraining,ACTIVATEAIR,A2A_VHARD)
    amenu5 = MENU_COALITION_COMMAND:New(2,"Activate Fox-3",Airtraining,ACTIVATEAIR,A2A_EHARD)
  elseif state == "inactive" then
    amenu1:Remove()
    amenu1 = MENU_COALITION_COMMAND:New(2,"Activate Guns",Airtraining,ACTIVATEAIR,A2A_EASY)
    amenu2 = MENU_COALITION_COMMAND:New(2,"Activate Fox-1",Airtraining,ACTIVATEAIR,A2A_HARD)
    amenu3 = MENU_COALITION_COMMAND:New(2,"Activate Fox-2",Airtraining,ACTIVATEAIR,A2A_MEDIUM)
    amenu4 = MENU_COALITION_COMMAND:New(2,"Activate Fox-1/2 Hard",Airtraining,ACTIVATEAIR,A2A_VHARD)
    amenu5 = MENU_COALITION_COMMAND:New(2,"Activate Fox-3",Airtraining,ACTIVATEAIR,A2A_EHARD)
  elseif state == "active" then
    amenu1:Remove()
    amenu2:Remove()
    amenu3:Remove()
    amenu4:Remove()
    amenu5:Remove()
    amenu1 = MENU_COALITION_COMMAND:New(2,"Deactivate AI Air Unit",Airtraining,DEACTIVATEAIR,airtype)
  
  end
end

AIRMENU("init",nil)


MPADLIVE = false
function ACTIVATEMANPADALLY()
  MPADLIVE = true
  if MPADVALLY1:IsAlive() == true then
    MPADVALLY1:Destroy()
    MPADVALLY1:Respawn()
    MPADVALLY2:Destroy()
    MPADVALLY2:Respawn()
    MPADVALLY3:Destroy()
    MPADVALLY3:Respawn()
    MPADVALLY4:Destroy()
    MPADVALLY4:Respawn()
    MPADVALLY5:Destroy()
    MPADVALLY5:Respawn()
  end
  MPADVALLY1:Activate()
  MPADVALLY2:Activate()
  MPADVALLY3:Activate()
  MPADVALLY4:Activate()
  MPADVALLY5:Activate()
  ACTIVATE_R441()
  lmenu3:Remove()
  lmenu3 = MENU_COALITION_COMMAND:New(2,"Deactivate Man Pad Ally",LiveFire,DEACTIVATEMANPADALLY,{})
  hm("Warning Manpad Ally is now active, Anyone in the range may be shot at and the restricted airspace R441 is now active")
  MESSAGE:New("Warning LManpad Ally is now active, Anyone in the range may be shot at and the restricted airspace R441 is now active",20,"Range Master"):ToAll()
end

function DEACTIVATEMANPADALLY()
  MPADLIVE = false
  if MPADVALLY1:IsAlive() == true then
    MPADVALLY1:Destroy()
    MPADVALLY1:Respawn()
    MPADVALLY2:Destroy()
    MPADVALLY2:Respawn()
    MPADVALLY3:Destroy()
    MPADVALLY3:Respawn()
    MPADVALLY4:Destroy()
    MPADVALLY4:Respawn()
    MPADVALLY5:Destroy()
    MPADVALLY5:Respawn()
  end
  lmenu3:Remove() 
  lmenu3 = MENU_COALITION_COMMAND:New(2,"Activate Manpad Ally",LIVEFIREROOTMENU,ACT_LIVE,MPADVALLY1)
  DEACTIVATE_R441()
  hm("Deactivating the restricted airspace R441 is now deactive")
  MESSAGE:New("Manpad Vally Standing down.",20,"Range Master"):ToAll()
end


function ACTIVATE_TROOPSINCONTACT()
  
  if AI_RCONTACT:IsAlive() == true then
    AI_RCONTACT:Destroy()
    AI_RCONTACT:Respawn()
   
  end
  AI_RCONTACT:Activate()
  if AI_BCONTACT:IsAlive() == true then
    AI_BCONTACT:Destroy()
    AI_BCONTACT:Respawn()
    
  end
  AI_BCONTACT:Activate()
  lmenu2:Remove()
  lmenu2 = MENU_COALITION_COMMAND:New(2,"Deactivate Troops in Contact",LIVEFIREROOTMENU,DEACTIVATE_TROOPSINCONTACT,{})
  ACTIVATE_R550()
  TCONACT = true
  hm("Warning Troops in contact is now live, anyone may be shot at, R550 is Active")
  MESSAGE:New("Warning Troops in contact is now live, anyone may be shot at, R550 is Active",20,"Range Master"):ToAll()
end

function DEACTIVATE_TROOPSINCONTACT()
  if AI_RCONTACT:IsAlive() == true then
    AI_RCONTACT:Destroy()
  end
  if AI_BCONTACT:IsAlive() == true then
    AI_BCONTACT:Destroy()
  end
  TCONACT = false
  lmenu2:Remove()
  lmenu2 = MENU_COALITION_COMMAND:New(2,"Activate Troops in Contact",LIVEFIREROOTMENU,ACT_LIVE,AI_RCONTACT)
  if LIVEACT == false then
    DEACTIVATE_R550()
    hm("Troops in contact is now deactivated, no hostile live fires remain R550 is deactive")
    MESSAGE:New("Troops in contact is now deactivated, no hostile live fires remain R550 is deactive",20,"Range Master"):ToAll()
  else
    hm("Troops in contact is now deactivated, However Live Fire Group is still active R550 is still Active.")
    MESSAGE:New("Troops in contact is now deactivated, However Live Fire Group is still active R550 will remain Active.",20,"Range Master"):ToAll()
  end
end

function ACTIVATE_LIVEFIRE() 
  if AI_ACTIVEFIRE:IsAlive() then
    AI_ACTIVEFIRE:Destroy()
  end
  LIVEACT = true
  AI_ACTIVEFIRE:InitRandomizePositionRadius(3400, 1000)
  AI_ACTIVEFIRE:Respawn()
  AI_ACTIVEFIRE:Activate()
  lmenu1:Remove()
  lmenu1 = MENU_COALITION_COMMAND:New(2,"Deactivate Live Fire",LIVEFIREROOTMENU,DEACTIVATE_LIVEFIRE,{})
  ACTIVATE_R550()
  hm("Warning Live Fire Range is now active, Anyone in the range may be shot at and the restricted airspace R550 is now active")
  MESSAGE:New("Warning Live Fire Range is now active, Anyone in the range may be shot at and the restricted airspace R550 Active",20,"Range Master"):ToAll()
end

function DEACTIVATE_LIVEFIRE()
  if AI_ACTIVEFIRE:IsAlive() then
    AI_ACTIVEFIRE:Destroy()
  end
  LIVEACT = false
  lmenu1:Remove()
  lmenu1 = MENU_COALITION_COMMAND:New(2,"Activate Live Fire Range",LIVEFIREROOTMENU,ACT_LIVE,AI_ACTIVEFIRE)
  if TCONACT == false then
    DEACTIVATE_R550()
    hm("Live Fire Contact is now deactivated, no hostile live fires remain R550 is deactive")
    MESSAGE:New("Live Fire Contact is now deactivated, no hostile live fires remain R550 is deactive",20,"Range Master"):ToAll()
  else
    hm("Live Fire Group is now deactivated, However Troops in Contact Groups are still active - R550 is still Active.")
    MESSAGE:New("Live Fire Group is now deactivated, However Troops in Contact Groups are still active - R550 will remain Active.",20,"Range Master"):ToAll()
  end
end

function ACT_LIVE(livetype)
  if livetype ~= nil then
    if livetype == MPADVALLY1 then
      ACTIVATEMANPADALLY()
      return true
    end
    if livetype == AI_RCONTACT then
      ACTIVATE_TROOPSINCONTACT()
    end
    if livetype == AI_ACTIVEFIRE then
      ACTIVATE_LIVEFIRE()
    end
    hm("Warning Live Fire Range is now active, Anyone in the range may be shot at and the restricted airspace R550 is now active")
    --MESSAGE:New("Warning Live Fire Range is now active, Anyone in the range may be shot at and the restricted airspace R550 is now active",20,"Range Master"):ToAll()
  else
      hm("error in activate live") 
  end
end

function DEACT_LIVE(livetype)
  if livetype ~= nil then
    LIVEACT = false
    if livetype == MPADVALLY1 then
      DEACTIVATEMANPADALLY()
      --clean('R441')
    if livetype == AI_RCONTACT then
      DEACTIVATE_TROOPSINCONTACT()
    end
    if livetype == AI_ACTIVEFIRE then
      DEACTIVATE_LIVEFIRE()
    end
    
    end
  end
end


function LIVEFIREMENU(state)
  if state == "init" then
    LIVEFIREROOTMENU = MENU_COALITION:New(2,"LIVE FIRE RANGE",RangeTopMenu)
    lmenu1 = MENU_COALITION_COMMAND:New(2,"Activate Live Fire Range",LIVEFIREROOTMENU,ACT_LIVE,AI_ACTIVEFIRE)
    lmenu2 = MENU_COALITION_COMMAND:New(2,"Activate Troops in Contact",LIVEFIREROOTMENU,ACT_LIVE,AI_RCONTACT)
    lmenu3 = MENU_COALITION_COMMAND:New(2,"Activate Manpad Ally",LIVEFIREROOTMENU,ACT_LIVE,MPADVALLY1)
  end
end

LIVEFIREMENU("init",nil)

function CHECKR550ITEMS()
  CLEANUP = false
  if MOVINGGROUP:IsAlive() ~= true then
    MOVINGGROUP:Respawn()
    CLEANUP = true
  end
  if STATICGROUP:IsAlive() ~= true then
    STATICGROUP:Respawn()
    CLEANUP = true
  end
  if CLEANUP == true then
    clean('R550')
  end
  if LIVEACT == true then
    if AI_ACTIVEFIRE:IsAlive() ~= true then
      DEACTIVATE_LIVEFIRE()
    end
  end
  if TCONACT == true then
    if AI_RCONTACT:IsAlive() ~= true or AI_BCONTACT:IsAlive() ~= true then
      DEACTIVATE_TROOPSINCONTACT()
    end
  end
end

function CHECKR551AITEMS()
  local _time = timer.getTime()
  if SAMLIVE == true then
    local clientsinzone = false
    if _time - SAMACTIVATIONTIME > 3600 then
      -- we need to check if anyone is in R551A if they are we reset the timer else we deactivate the samsite.
      CLIENTS:ForEachClientInZone(Z_R551A,function(_client) 
        if _client:IsAlive() then
          clientsinzone = true
        end
      end)
      if clientsinzone == true then
        SAMACTIVATIONTIME = timer.getTime() + 1800
      else
        local _msg = "No client aircraft found in R551A while SAM is active, deactivating SAM and R551A"
        hm(_msg) 
        MESSAGE:New(_msg,10,"Range Control"):ToAll()
        deactivatesam(ACTIVETYPE)
      end
    end
    if ACTIVETYPE ~= nil then
      if ACTIVETYPE:IsAlive() ~= true then
        deactivatesam(ACTIVETYPE)
      end
    end
  end


end
function CHECKR552ITEMS()
  if AIRLIVE == true then
    if AIR_ACTIVETYPE == A2A_EASY then
      if A2A_EA:IsAlive() ~= true then
        DEACTIVATEAIR(A2A_EASY)
      end
    elseif AIR_ACTIVETYPE == A2A_MEDIUM then
      if A2A_ME:IsAlive() ~= true then
        DEACTIVATEAIR(A2A_MEDIUM)
      end
    elseif AIR_ACTIVETYPE == A2A_HARD then
      if A2A_ME:IsAlive() ~= true then
        DEACTIVATEAIR(A2A_HARD)
      end
    elseif AIR_ACTIVETYPE == A2A_VHARD then
      if A2A_VH:IsAlive() ~= true then
        DEACTIVATEAIR(A2A_VHARD)
      end
    elseif AIR_ACTIVETYPE == A2A_EHARD then
      if A2A_EH:IsAlive() ~= true then
        DEACTIVATE(A2A_EHARD)
      end
    end
  end
end
AICHECK = SCHEDULER:New(nil,function() 
  CHECKR550ITEMS()
  CHECKR551AITEMS()
  CHECKR552ITEMS()
end,{},5,5)