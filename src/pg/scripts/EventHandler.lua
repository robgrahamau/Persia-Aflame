rlog("Global Event Handler Events Version 1.00")

ADMINSPAWNED = {}
HEVENT = {
    ClassName = "Handle_Events",
    TANKERTIME = 0,
    AFACTIME = 0,
    TANKER_COOLDOWN = 0,
    AFAC_COOLDOWN = 0,
    _handlelqm = false,
    _handlemarkers = false,
    _handledead = false,
    spawnedunits = {},
    spawnedgroup = {},
    blueprefix = "cjtf_blue_",
    bluecountry = country.id.CJTF_BLUE,
    redprefix = "cjtf_red_",
    redcountry = country.id.CJTF_RED,
    neutralprefix = "untf_",
    neutralcountry = country.id.UN_PEACEKEEPERS,
    RDEBUG = false,
}


---creates a new handler events.
---@param _markers boolean - Do we handle marker events
---@param _lqm boolean - do we handle landing qualify mark events
---@param _death boolean - do we handle death events
---@param _tankertime integer - tanker marker time
---@param _tankercooldown integer - how long between tanker marks we can go.
---@return table nil
function HEVENT:New(_markers,_lqm,_death,_tankertime,_tankercooldown)
    local self = BASE:Inherit(self,BASE:New())
    self:E("Initalising Handle Events")
    self._handlemarkers = _markers or false
    self._handlelqm = _lqm or false
    self.TANKERTIMER= _tankertime or TANKERTIMER
    self.TANKER_COOLDOWN = _tankercooldown or TANKER_COOLDOWN
    self._handledead = _death or false
    return self
end

function HEVENT:SetDebug(_debug)
    _debug = _debug or true
    self.RDEBUG = _debug
end

function HEVENT:Log(_data)
    if self.RDEBUG == true then
        self:E({_data})
        hm(_data)
    end
end
--- sends a message out but does a check to see if we have a valid group or not if group is nil then we send to all
function HEVENT:Msg(_msg,_group,_col,_duration,_infotype,_clear)
  _infotype = _infotype or nil
  _clear = _clear or false
  _col = _col or nil
  _duration = _duration or 10
  if _group == nil then
    if _col == 1 then
      MESSAGE:New(_msg,_duration,_infotype,_clear):ToRed()
      self:Log({_msg,_duration,_group})
      return
    elseif _col == 2 then
      MESSAGE:New(_msg,_duration,_infotype,_clear):ToBlue()
      self:Log({_msg,_duration,_group})
      return
    else
      MESSAGE:New(_msg,_duration,_infotype,_clear):ToAll()
      self:Log({_msg,_duration,_group})
      return
    end
  else
    MESSAGE:New(_msg,_duration,_infotype,_clear):ToGroup(_group)
    self:Log({_msg,_duration,_group})
    return
  end
end



function HEVENT:handletemplate(_text,_coalition,_playername,_group)
  if ADMIN == true then
    local keywords = UTILS.Split(_text,",")
    local s = keywords[2]
    local file = string.format("%s.miz",s)
    self:Msg(string.format("Template Load in Progress. \n File: %s",file),nil,nil,15,"ADMIN",true)
    missionspawn(file)
  else
    self:Msg(string.format("Template loading requires admin controls be enabled to use, admin is currently false"),_group,nil,15,"ADMIN")
  end
end

--- Sets the Blue Spawn Prefix
---@param bp string - Blue Prefix.
function HEVENT:setblueprefix(bp)
  if bp ~= nil then
    self.blueprefix = bp
  end
end
--- Sets the Red Spawn Prefix
---@param rp string - red prefix.
function HEVENT:setredprefix(rp)
  if rp ~= nil then
    self.redprefix = rp
  end
end

--- Sets the Neutral Spawn Prefix
---@param up string - neutral prfix.
function HEVENT:setunprefix(up)
  if up ~= nil then
    self.neutralprefix = up
  end
end


---Start handler.
function HEVENT:Start()
  self:E({"Starting Handle_Events"})  
  if self._handlemarkers ~= false then
    self:HandleEvent(EVENTS.MarkRemoved)
  end
  if self._handlelqm ~= false then
      self:HandleEvent(EVENTS.LandingQualityMark)
  end
end

---Stop Handler
function HEVENT:Stop()
  self:E({"Stopping Handle_Events"})  
  self:UnHandleEvent(EVENTS.MarkRemoved)
  self:UnHandleEvent(EVENTS.LandingQualityMark)
end

---Landing Quality Mark Handler
---@param EventData EventData
function HEVENT:OnEventLandingQualityMark(EventData)
    self:E({"Landing Quality Mark",EventData})
    local comment = EventData.comment
    local who = EventData.IniPlayerName
    if who == nil then
        who = EventData.IniUnitName
        self:Log({"NPC Landed",who})
        return
    end
    if who == nil then
          who = "Unknown"
    end
    local t = EventData.IniTypeName
    if t == nil then
        t = "Unknown"
    end
    local where = EventData.PlaceName
    self:Log({comment,who,where,t})
    local _msg = string.format("**Super Carrier LSO Report** \n > **%s** \n > **Landing Grade for:** %s, **Flying:** %s \n > **Grade is:** %s",where,who,t,comment)
    hm(_msg)
    hmlso(_msg)
end

--- Handles our OnEventMarkRemoved Events, This is our MAIN handler and has a lot of commands.
---@param EventData EventData
function HEVENT:OnEventMarkRemoved(EventData)
  if EventData.text~=nil and EventData.text:lower():find("-") then
    local dcsgroupname = EventData.IniDCSGroupName
    local _playername = EventData.IniPlayerName
    local _group = GROUP:FindByName(dcsgroupname)
    local text = EventData.text:lower()
    local text2 = EventData.text
    local vec3={y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
    local coord = COORDINATE:NewFromVec3(vec3)
    local _coord = coord
    local _coalition = EventData.coalition
    local _col = EventData.coalition
    local red = false
    if _coalition == 1 then
      red = true
    end
    coord.y = coord:GetLandHeight()
    local basekeywords = UTILS.Split(text,",")
    self:Log({basekeywords})
    local mainkey = basekeywords[1]
    self:Log({"Main Key",mainkey})
    if mainkey == ("-weather") then
      self:handleWeatherRequest(text2,coord,_group) -- Confirmed
    elseif mainkey == ("-tanker") then
      self:handleTankerRequest(text2,coord,_coalition,_playername,_group) -- Confirmed
    elseif mainkey == ("-afac") then
      self:handleAfacRequest(text2,coord,_coalition,_playername,_group) -- Confirmed
    elseif mainkey == ("-help") then
      self:handlehelp(_group) -- partly done.
    elseif mainkey == ("-smoke") then
      self:handleSmoke(text2,coord,_coalition,_group,_playername) -- confirmed.
    elseif mainkey == ("-groupcheck") then 
      self:groupchecker(_group_coalition) -- confirmed.
    elseif mainkey == ("-flare") then
      self:handleflare(text2,coord,_coalition,_group,_playername) -- need to check
    elseif mainkey == ("-ctldfob") then -- confirmed.
      -- ctld drop.
      if ADMIN == true then
       self:ctldfobspawn(text,coord,_coalition,_group,_playername)
      else
        self:Msg("Unable, Admin commands need to be active to use the ctldfob command",_group,nil,10)
      end
    elseif mainkey == ("-rqm") then -- not implimented yet.,
        self:randomspawn(text2,coord,_playername,_group)
    elseif mainkey == ("-routeside") then
      if ADMIN == true then
        self:routemassgroup(text2,coord,_playername,_group,_coalition) -- done
      else
        self:Msg("Unable, Admin commands need to be active to use the routeside command",_group,nil,10)
      end
    elseif mainkey == ("-combine") then
      self:massgroup(text2,coord,_playername,_coalition)
    elseif mainkey == ("-massdel") then
      if ADMIN == true then
        self:deletemassgroup(text2,coord,_playername,_coalition) -- done
      else
        self:Msg("Unable, Admin commands need to be active to use the massdel command",_group,nil,10)
      end
    elseif mainkey == ("-massgroup") then
      if ADMIN == true then
        self:massgroup(text2,coord,_playername,_coalition) -- done
      else
        self:Msg("Unable, Admin commands need to be active to use the massgroup command",_group,nil,10)
      end
    elseif mainkey == ("-explode") then
      if ADMIN == true then
        self:handleExplosion(text2,coord,_playername,_group) -- done.
      else
        self:Msg("Unable, Admin commands need to be active to use the -explode command",_group,nil,10)
      end
    elseif mainkey == ("-loadtemplate") then
      self:handletemplate(text2,_coalition,_playername,_group)
    elseif mainkey == ("-admin") then
        self:handleeadmin(text2,_playername)
    elseif mainkey == ("-radmin") then
        self:rhandleeadmin(text2,_group,_playername)
    elseif mainkey == ("-spawn") or mainkey == ("-rs") then
      if ADMIN == true then
        self:newhandlespawn(text2,coord,_group,_playername,_coalition) -- done
      else
        self:Msg("Unable, Admin commands need to be active to use the spawn command",_group,nil,10)
      end
    elseif mainkey == ("-oldspawn") then
      if ADMIN == true then
        self:handleoldspawn(text2,coord) -- done
      else
        self:Msg("Unable, Admin commands need to be active to use the spawn command",_group,nil,10)
      end
    elseif mainkey == ("-load") then
      if ADMIN == true then
        _loadfile("input.lua",_MCPATH)
        self:Msg("input.lua should have completed its run",_group,nil,10)
      else
        self:Msg("unable, Admin Commands need to be active to input a file",_group,nil,10)
      end
    elseif mainkey == ("-despawn") or mainkey == ("-ds") then
      if ADMIN == true then
        self:handledespawn(text2,_playername,_group,_coalition) -- done
      else
        self:Msg("Unable, Admin Commands need to be active to use the despawn command",_group,nil,10)
      end
    elseif mainkey == ("-msgall") or mainkey == ("-ma") then
      if ADMIN == true then
        self:Msgtoall(text2) --done
      else
        self:Msg("Unable, Admin commands need to be active to use msgall",_group,nil,10)
      end
    elseif mainkey == ("-farpspawn") or mainkey == ("-spawnfarp") then
      if ADMIN == true then
        self:spawnfarp(text2,coord,_group,_playername,_coalition)
      else
        self:Msg("Unable, Admin commands need to be active to use spawnfarp/farpspawn",_group,nil,10)
      end
    end
  end
end

function HEVENT:spawnfarp(text,coord,_group,_playername,_coalition)
  _coord = coord or nil
  _group = _group or nil
  _playername = _playername or nil
  _coalition = _coalition or nil
  if _coord == nil then
    self:Msg("Warning, No Coordinate was passed, can't spawn farp error!",_group,nil,10)
  end
  local FarpHDG = 3.1764992386297
	local radios ={127.5,125.25,129.25}
	local FARPLocationVect = coord:GetVec2()
	-- increase our counter we also
  farpcounter = farpcounter + 1
	local temptable = {
		FarpAX = FARPLocationVect.x,
		FarpAY = FARPLocationVect.y,
	}
    local _msg = string.format("A farp convoy has arrived at it's destination at %s and is setting up",coord:ToStringMGRS())
    self:Msg(_msg,nil,_coalition,10)

    local vehiclevect = coord:Translate(40,0)
    local SpawnServiceVehicles = SPAWN:NewWithAlias("t_farpgroup","FarpServiceVechiles" .. farpcounter):SpawnFromCoordinate(vehiclevect)    
    self:FPSpawnStatic("Farp1_ComandPost_" .. farpcounter .. "","kp_ug","Fortifications","FARP CP Blindage",100,(temptable.FarpAX - -46.022111867),(temptable.FarpAY - -9.20689690),(FarpHDG - 1.6057029118348))
    self:FPSpawnStatic("Farp1_Generator1_" .. farpcounter .. "","GeneratorF","Fortifications","GeneratorF",100,(temptable.FarpAX - -7.522753786),(temptable.FarpAY - -37.85968299),(FarpHDG -1.5358897417550))
    self:FPSpawnStatic("Farp1_Tent1_" .. farpcounter .. "","PalatkaB","Fortifications","FARP Tent",50,(temptable.FarpAX - -42.785309231),(temptable.FarpAY - -9.12264485),(FarpHDG - 1.6057029118348))  
    self:FPSpawnStatic("Farp1_CoveredAmmo1_" .. farpcounter .. "","SetkaKP","Fortifications","FARP Ammo Dump Coating",50,(temptable.FarpAX - 35.293756408),(temptable.FarpAY - 57.35770154),(FarpHDG - 3.1590459461098))
    self:FPSpawnStatic("Farp1_Tent2_" .. farpcounter .. "","PalatkaB","Fortifications","FARP Tent",50,(temptable.FarpAX - -49.432834216),(temptable.FarpAY - -9.14503574),(FarpHDG - 1.6057029118348))
    self:FPSpawnStatic("Farp1_Wsock1_" .. farpcounter .. "","H-Windsock_RW","Fortifications","Windsock",3,(temptable.FarpAX - 43.70051151),(temptable.FarpAY -  2.35458818),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre1_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.52339492),(temptable.FarpAY - 41.91442888),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre2_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.51502196),(temptable.FarpAY - 13.74232991),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre3_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.27681096),(temptable.FarpAY - -22.30693542),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre4_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 44.69212731),(temptable.FarpAY - 27.50978001),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre5_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.37543603),(temptable.FarpAY - -7.37904581),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre6_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.19740729),(temptable.FarpAY - 27.55856816),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre7_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.41098563),(temptable.FarpAY - -7.37904581),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre8_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.07919727),(temptable.FarpAY - 41.59167618),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre9_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.37543603),(temptable.FarpAY - 27.71737550),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre10_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - -9.21662870),(temptable.FarpAY - 7.15182545),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre11_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 44.77786563),(temptable.FarpAY - -8.33188983),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre12_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 9.87567332),(temptable.FarpAY - 17.86661589),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre13_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 26.19740729),(temptable.FarpAY - -8.17308250),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre14_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.31389554),(temptable.FarpAY - 7.09103057),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre15_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 8.41098563),(temptable.FarpAY - 27.63797183),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre16_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 44.61905829),(temptable.FarpAY - 13.74232991),(FarpHDG ))
    self:FPSpawnStatic("Farp1_Tyre17_" .. farpcounter .. "","H-tyre_B_WF","Fortifications","Black_Tyre_WF",3,(temptable.FarpAX - 43.93118389),(temptable.FarpAY - -22.67033198),(FarpHDG )) 
    self:FPSpawnFarpBuilding("Farp_Heliport_" ..farpcounter .. "","invisiblefarp","Heliports","Invisible FARP",radios[farpcounter],0,farpcounter,(temptable.FarpAX - 0.00000000),(temptable.FarpAY - 0.00000000),(FarpHDG))
    BASE:E({self.name,"Spawned Farp",farpcounter})
 end

 function HEVENT:FPSpawnFarpBuilding(_name,_shape,_cat,_type,_radio,_modulation,_callsign,_x,_y,_heading)
  local staticObj = {
    ["name"] = _name , --unit name (Name this something identifying some you can find it later)
    ["category"] = _cat,
    ["shape_name"] = _shape,
    ["type"] = _type,
    ["heliport_frequency"] = _radio,
    ["x"] = _x,
    ["y"] = _y,
    ["heliport_modulation"] = _modulation,
    ["heliport_callsign_id"] = _callsign,
    ["heading"] = _heading,
         -- These can be left as is, but is required
    ["groupId"] = 1,          --id's of the group/unit we're spawning  (will auto increment if id is taken?)
        ["unitId"] = 1,
        ["dead"] = false,
  }
  coalition.addStaticObject(country.id.USA, staticObj)
end
-- spawns all our statics.
function HEVENT:FPSpawnStatic(_name,_shape,_cat,_type,_rate,_x,_y,_heading)
  local staticObj = {
    ["name"] = _name , --unit name (Name this something identifying some you can find it later)
    ["category"] = _cat,
    ["shape_name"] = _shape,
    ["type"] = _type,
    ["rate"] = _rate,
    ["x"] = _x,
    ["y"] = _y,
    ["heading"] = _heading,
    ["groupId"] = 1,          --id's of the group/unit we're spawning  (will auto increment if id is taken?)
    ["unitId"] = 1,
    ["dead"] = false,
   }
   coalition.addStaticObject(country.id.USA, staticObj)
end

--- Handles a admin spawn of a CTLD Fob at the given coordinate
---@param text string
---@param _coalition integer
---@param _group string
---@param _playername string
function HEVENT:ctldfobspawn(text,_coord,_coalition,_group,_playernamee)
    if ctld ~= nil then
        self:Log({"attempting to spawn a CTLD fob"})
        self:Msg("Attempting to spawn a CTLD fob",_group,_coalition,10)
        local _unitId = ctld.getNextUnitId()
        local _name = "ctld Deployed FOB #" .. _unitId
        local _fob = nil
        self:E({"ctld",text})
        local keywords=UTILS.Split(text,",")
        local s = keywords[2]
        if (s == "blue") or (s=="b") then
          _fob = ctld.spawnFOB(self.bluecountry, 211, _coord:GetVec3(), _name)
        elseif (s == "red") then
          _fob = ctld.spawnFOB(self.redcountry, 211, _coord:GetVec3(), _name)
        elseif (s == "n") then
          _fob = ctld.spawnFob(self.neutralcountry, 211,_coord:GetVec3(),_name)
        else
          _fob = ctld.spawnFOB(self.bluecountry, 211, _coord:GetVec3(), _name)
        end
        table.insert(ctld.logisticUnits, _fob:getName())
        if ctld.troopPickupAtFOB == true then
          table.insert(ctld.builtFOBS, _fob:getName())
        end
    else
        self:Msg("No CTLD instance was found was found are you certain it's installed and active?",_group,nil,10,"Admin:")
    end
end

--- handle an admin attempt.
---@param text string
---@param _playername string
function HEVENT:handleeadmin(text,_playername)
  if _playername == nil then
    _playername = "Player"
  end
  local keywords=UTILS.Split(text, ",")
  local wrongpassword = false
  local enteredpassword = nil
  BASE:E({keywords=keywords})
  for _,keyphrase in pairs(keywords) do
    enteredpassword = keyphrase
  end
  
  if enteredpassword == _PASSWORD then
    if ADMIN then
      ADMIN = false
      wrongpassword = false
      MESSAGE:New(string.format("Admin Commands are now disabled by %s",_playername),30):ToAll()
      hm(string.format("Admin Commands have been disabled by %s",_playername))
    else
      ADMIN = true
      wrongpassword = false
      MESSAGE:New(string.format("Admin Commands have been enabled by %s",_playername),30):ToAll()
      hm(string.format("Admin Commands have been enabled by %s",_playername))
    end
  else
      ADMIN = false
      wrongpassword = true
      MESSAGE:New(string.format("Wrong Password was entered by by %s",_playername),30):ToAll()
      hm(string.format("@Admin Group Wrong Password was entered by %s",_playername))
  end
end

--- Silent version of the above
---@param text string
---@param _group GROUP
---@param _playername string
function HEVENT:rhandleeadmin(text,_group,_playername)
  if _playername == nil then
    _playername = "Player"
  end
  local keywords=UTILS.Split(text, ",")
  BASE:E({keywords=keywords})
  for _,keyphrase in pairs(keywords) do
    if keyphrase == _PASSWORD then
      if ADMIN == false then
        ADMIN = true
      else
        ADMIN = false
      end
    end
  end
  if ADMIN == true then
    BASE:E({"ADMIN ENABLED"})
    self:msg(string.format("%s, Admin Commands are Now Enabled",_playername),_group,15)
  else
    BASE:E({"ADMIN DISABLED"})
    self:msg(string.format("%s, Admin Commands are Now Disabled",_playername),_group,15)
  end
end

--- Handles our call to do an explosion.
function HEVENT:handleExplosion(text,coord,_playername,_playergroup)
  if _playername == nil then
    _playername = "Player"
  end
  local keywords=UTILS.Split(text, ",")
  local yeild = keywords[2]
  yeild = tonumber(yeild)
  if ADMIN == true then
    if yeild == nil then
      yeild = 250
      local msg = string.format("Ok %s initated a 250lbs explosive",_playername)
      hm(msg)
      self:Msg(msg,_playergroup,15)
    end
    coord:Explosion(yeild)
    local msg = string.format("%d Yeild Explosion now initated by %s",yeild,_playername)
    hm(msg)
    self:Msg(msg,_playergroup,15)
  end
end

--- Handles our Flare marker.
--- command -flare,c=colour,i=y,a=1000,msl=n
--- example: -flare,c=white,i=y,a=500,msl=y
--- would launch a flare at the target coord then a illumination bomb at an altitude of 500ft msl. if n was used it would be agl.
---@param text string
---@param _coord COORDINATE
---@param col int
---@param _group GROUP
---@param _playername string
function HEVENT:handleflare(_text,coord,col,_group,_playername)
    if _playername == nil then
        _playername = "Player"
    end
    local keywords = UTILS.Split(_text,",")
    self:Log({keywords})
    local _color = "red"
    local _coord = coord
    local _flarecolor = FLARECOLOR.Red
    local _ilumination = false
    local _msl = false
    local _alt = UTILS.FeetToMeters(200)
    local _talt = 200
    local _height = "AGL"
    for _,keyphrase in pairs(keywords) do
        local str=UTILS.Split(keyphrase,"=")
        local key=str[1]
        local val=str[2]
        if key:lower() == "c" or key:lower() == "colour" or key:lower() == "color" then
            if val:lower() == "white" then
                _color = "white"
                _flarecolor = FLARECOLOR.White
            elseif val:lower() == "yellow" then
                _color = "yellow"
                _flarecolor = FLARECOLOR.Yellow
            elseif val:lower() == "green" then
                _color = "green"
                _flarecolor = FLARECOLOR.Green
            end
        end
        if key:lower() == "i" or key:lower() == "ilum" or key:lower() == "light" then
            if val:lower() == "true" or val:lower() == "yes" or val:lower()== "y" then
                _ilumination = true
            end
        end
        if key:lower() == "msl" or key:lower() == "m" then
           if val:lower() == "y" or val:lower() == true then
                _msl = true
                _height = "MSL"
           end
        end
        if key:lower() == "a" or key:lower()=="alt" then
            local _talt = tonumber(val)
            if val == nil or val < 200 then
             _talt = 200
            end
            _alt = UTILS.FeetToMeters(_talt)
        end
    end

    local _agent = BLUEFIRESUPPORTNAME
    local _col = 2
    local _side = "blue"

    if col == 1 then
        _col = 1
        _side = "red"
        _agent = REDFIRESUPPORTNAME
    end
    local _dist = SMOKERANGE or 10000
    local _inrange = false
    local _time = 30
    local _unitdistance = MAXUNITDISTANCE or 10000
    local _gunits = SET_GROUP:New():FilterCategories({"helicopter","ground","ship"}):FilterCoalitions(_side):FilterActive(true):FilterOnce()
    local _flaregroup = nil
    local _flarecoord = nil
    local gc = nil
    if ADMIN ~= true then
        _gunits:ForEach(function(g)
            if g:IsAlive() == true then
                local groupname = g:GetName()
                gc = g:GetCoordinate()
                if gc == nil then
                    self:Log({"Couldn't get the coord for group:",g:GetName(),g:GetCoordinate(),gc})
                else
                    local d = gc:Get2DDistance(_coord)
                    if d < _dist then
                        _inrange = true
                        if d < _unitdistance then
                        _unitdistance = d
                        _flaregroup = g
                        _flarecoord = gc
                        end
                    end
                end
            end
        end)
    else
        -- if we are in admin mode we bypass alot of this and just do everything from the coord it's always in range.
        _inrange = true
        gc = coord
    end
    local _mgrs = _coord:ToStringMGRS()
    self:Log({"FLARE MGRS:",_mgrs})
    local _msgpart1 = string.format("%s, this is %s requesting a %s flare fired towards %s",_agent,_playername,_color,_mgrs)

    if _ilumination == true then
        _msgpart1 = string.format("%s followed by an illumination round at a height of %d %s",_msgpart1,_talt,_height)
    end
    self:Msg(_msgpart1,nil,_col,10)
    hm(_msgpart1)
    if _inrange or ADMIN then
        _time = 30
        local _bearing = gc:GetAngleDegrees(_coord:GetVec3())
        _msg = string.format("%s, %s flare request recieved in the air in %d seconds",_playername,_agent,15)
        if _ilumination == true then
            _msg = string.format("%s, an illumination round will follow %d seconds after it to burst at %d %s",_msg,_time,_talt,_height)
        end
        self:Msg(_msg,nil,_col,10)
        SCHEDULER:New(nil,function() 
            gc:Flare(_flarecolor,_bearing)
            if ilumination == true then
                SCHEDULER:New(nil,function() 
                    local _tc = coord:GetRandomCoordinateInRadius(500,10)
                    _tc:SetAltitude(_alt,_msl)
                    _tc:IlluminationBomb()
                    self:Msg(string.format("%s, %s, spot lights up",_playername,_agent))
                end,{},_time)
            end
            _msg = string.format("%s, %s, sparkmark is out",_playername,_agent)
            self:Msg(_msg,nil,_col,10)
        end,{},15)
    else
        _msg = string.format("%s, %s unable to comply no friendly units are within %d meters range of your request",_playername,_agent,_dist)
        self:Msg(_msg,nil,_col,10)
    end
end


--- Handles our smoke marker rounds..
---@param text string
---@param _coord COORDINATE
---@param col int
---@param _group GROUP
---@param _playername string
function HEVENT:handleSmoke(text,_coord,col,_group,_playername)
  if _playername == nil then
    _playername = "Player"
  end
  local keywords=UTILS.Split(text, ",")
  self:E({keywords})
  local keyphrase= "white"
  if keywords[2] ~= nil then
    keyphrase = keywords[2]
  end
  local _agent = BLUEFIRESUPPORTNAME
  local _col = 2
  local _side = "blue"
  if col == 1 then
    _col = 1
    _side = "red"
    _agent = REDFIRESUPPORTNAME
  end
  local _dist = SMOKERANGE or 10000
  local _inrange = false
  local _time = 30
  local _unitdistance = 10000
  local gunits = SET_GROUP:New():FilterCategoryGround():FilterCoalitions(_side):FilterActive(true):FilterOnce()
  local nc = _coord:GetRandomCoordinateInRadius(500,100)
  -- if admin is true we bypass a chunk of stuff and just automatically dump ourselves in range.
  if ADMIN ~= true then 
    gunits:ForEach(function(g)
      if g:IsAlive() == true then
        local groupname = g:GetName()
        local _group = GROUP:FindByName(groupname)
        local gc = _group:GetCoordinate()
        if gc == nil then
          BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
        else
          local d = gc:Get2DDistance(_coord)
          if d < _dist then
            _inrange = true
            if d < _unitdistance then
              _unitdistance = d
            end
          end
        end
      end
    end)
  else
    _inrange = true
    nc = _coord
  end
  local _mgrs = _coord:ToStringMGRS()
  BASE:E({"SMOKE MGRS SHOULD BE HERE",_mgrs})
  local msg = string.format("%s, this is %s requesting smoke at %s.",_agent,_playername,_mgrs)
  self:Msg(msg,nil,_col,10)
  hm(string.format("%s, this is %s requesting smoke at %s",_agent,_playername,_coord:ToStringMGRS()))
  if _inrange then
    -- calculate time to get smoke on target this will be (d/1000) * 5 + 30
    _time = (_unitdistance/1000) * 5 + 30
    local _or = (_unitdistance/100)
    local _ir = (_unitdistance/1000) * 2
    nc = _coord:GetRandomCoordinateInRadius(_or,_ir)
    if ADMIN == true then
      _time = 1
      nc = _coord
    end
    msg = string.format("%s, %s smoke mark request recieved estimate impact in %d seconds",_playername,_agent,_time)
    self:Msg(msg,nil,_col,10)
    if keyphrase:lower():find("red") then
      SCHEDULER:New(nil,function() 
        nc:SmokeRed() 
        msg = string.format("%s, %s red mark should be on the deck",_playername,_agent)
        self:Msg(msg,nil,_col,10)
      end,{},_time)
      return           
    elseif keyphrase:lower():find("blue") then
      SCHEDULER:New(nil,function() 
        nc:SmokeBlue() 
        msg = string.format("%s, %s blue mark should be on the deck",_playername,_agent)
        self:Msg(msg,nil,_col,10)
      end,{},_time)
      return
    elseif keyphrase:lower():find("green") then
      SCHEDULER:New(nil,function() 
        nc:SmokeGreen() 
        msg = string.format("%s, %s green mark should be on the deck",_playername,_agent)
        self:Msg(msg,nil,_col,10)
      end,{},_time)
      return
    elseif keyphrase:lower():find("orange") then
      SCHEDULER:New(nil,function() 
        nc:SmokeOrange()
        msg = string.format("%s, %s orange mark should be on the deck",_playername,_agent)
        self:Msg(msg,nil,_col,10)
      end,{},_time)
      return
    else
      SCHEDULER:New(nil,function() 
        nc:SmokeWhite() 
        msg = string.format("%s, %s White mark should be on the deck",_playername,_agent)
        self:Msg(msg,nil,_col,10)
      end,{},_time)
    end
  else
    local msg = string.format("%s , %s Unable to launch smoke, no friendly units are within 10km of the target area.",_playername,_agent)
    self:Msg(msg,nil,_col,10)
  end
end

--- Handle a weather request.
---@param text string marker text
---@param coord COORDINATE moose coodinate
---@param _group GROUP moose Group
function HEVENT:handleWeatherRequest(text, coord, _group,_coalition)
  local weather=env.mission.weather
  local visibility = weather.visibility.distance
  local clouds = weather.clouds
  local turbulance = weather.groundTurbulence
  local visrep = UTILS.Round(UTILS.MetersToNM(visibility))
  _coalition = _coalition or nil
  if visrep > 10 then
    visrep = 10
  end
  local mgrs = coord:ToStringMGRS()

  local currentPressure = coord:GetPressure(0)
  local currentTemperature = coord:GetTemperature()
  local currentWindDirection, currentWindStrengh = coord:GetWind()
  local currentWindDirection1a, currentWindStrength1a = coord:GetWind(UTILS.FeetToMeters(500))
  local currentWindDirection1, currentWindStrength1 = coord:GetWind(UTILS.FeetToMeters(1000))
  local currentWindDirection2, currentWindStrength2 = coord:GetWind(UTILS.FeetToMeters(2000))
  local currentWindDirection5, currentWindStrength5 = coord:GetWind(UTILS.FeetToMeters(5000))
  local currentWindDirection10, currentWindStrength10 = coord:GetWind(UTILS.FeetToMeters(10000))
  local weatherString = string.format("Requested weather at coordinates %s: \n Visibility: %d , Wind from %d@%.1fkts, QNH %.2f, Temperature %d", mgrs, visrep, currentWindDirection, UTILS.MpsToKnots(currentWindStrengh), currentPressure * 0.0295299830714, currentTemperature)
  local weatherString1 = string.format("Wind 500ft MSL: Wind from%d@%.1fkts",currentWindDirection1, UTILS.MpsToKnots(currentWindStrength1a))
  local weatherString2a = string.format("Wind 1,000ft MSL: Wind from%d@%.1fkts",currentWindDirection2, UTILS.MpsToKnots(currentWindStrength1))
  local weatherString2 = string.format("Wind 2,000ft MSL: Wind from%d@%.1fkts",currentWindDirection2, UTILS.MpsToKnots(currentWindStrength2))
  local weatherString5 = string.format("Wind 5,000ft MSL: Wind from%d@%.1fkts",currentWindDirection5, UTILS.MpsToKnots(currentWindStrength5))
  local weatherString10 = string.format("Wind 10,000ft MSL: Wind from%d@%.1fkts",currentWindDirection10, UTILS.MpsToKnots(currentWindStrength10))
  self:Msg(weatherString, _group, _coalition, 30, MESSAGE.Type.Information)
  self:Msg(weatherString2a,_group, _coalition, 30, MESSAGE.Type.Information)
  self:Msg(weatherString1, _group, _coalition,30, MESSAGE.Type.Information)
  self:Msg(weatherString2,_group, _coalition,30, MESSAGE.Type.Information)
  self:Msg(weatherString5, _group, _coalition,30, MESSAGE.Type.Information)
  self:Msg(weatherString10, _group, _coalition,30, MESSAGE.Type.Information)
  hm('Weather Requested \n ' .. weatherString .. '\n' .. weatherString1 .. '\n' .. weatherString2 .. '\n' .. weatherString5 .. '\n' .. weatherString10 .. '\n')
end


--- checks current group and unit count for all coalitions.
function HEVENT:groupchecker(_group,_col)
  local _group = _group or nil
  local _col = _col or nil
  local tempset = SET_UNIT:New():FilterActive():FilterOnce()
  local ucounter = 0
  local ub = 0
  local ur = 0
  local un = 0
  tempset:ForEach(function(g) 
    ucounter = ucounter + 1
    local uc = g:GetCoalition()
    if uc == 1 then
      ur = ur + 1
    elseif uc == 2 then
      ub = ub + 1
    else
      un = un + 1
    end
  end)
  tempset = SET_GROUP:New():FilterActive():FilterOnce()
  local gcounter = 0
  local gb = 0
  local gr = 0
  local gn = 0
  tempset:ForEach(function(g) 
    gcounter = gcounter + 1
    local gc = g:GetCoalition()
    if gc == 1 then
      gr = gr + 1
    elseif gc == 2 then
      gb = gb + 1
    else
      gn = gn + 1
    end
  end)
  self:Msg(string.format("Current Group Count is: %d Active Groups, \n • Blue Groups: %d , Red Groups: %d , Neutral Groups: %d \n Unit Count is: %d Units \n • Blue Units: %d , Red Units: %d , Neutral Units: %d ",gcounter,gb,gr,gn,ucounter,ub,ur,un),_group,_col,20)
end


--- handles our help requests.
---@param _group GROUP
function HEVENT:handlehelp(_group)
  local msgtext = "Map Command Help Requested. \n The Following are valid commands for markers any with a - at the start require you to delete the marker. \n -help (this command) \n -smoke,red or -smoke,green or -smoke,blue or -smoke,white (Spawn a random smoke near the location if a friendly unit is close enough) \n -flare or -flare,c=colour,i=y or n , a=altitude(ft),msl=y/n (msl or agl) eg -flare,c=red,i=y,a=1000,msl=n would fire a flare from the nearest friendly within range and an illumination round at an altitude of 1000ft agl.  \n -weather (request a GRIBS weather report from the location of the marker) \n"
  local _msg = self:Msg(msgtext,_group,60)
end

--- Handles AFAC requests for both red and blue.
-- requires that you enter the group name, works as follows:
-- -afac route,n=My afac Group Name,a=15000,h=120,d=20,s=330 
-- where n = group name
-- a = altitude in ft
-- h = heading in degress
-- d = distance in nm
-- s = speed in CAS.
---@param text string marker text
---@param coord COORDINATE moose coordinate
---@param _col int 0 = neutral, 1 = red, 2 = blue
---@param _playername string players name
---@param _group GROUP MOOSE GROUP.
---@return boolean
function HEVENT:handleAfacRequest(text,coord,_col,_playername,_group)
  if _playername == nil then
    _playername = "Player"
  end
  local currentTime = os.time()
    local keywords=UTILS.Split(text, ",")
    local heading = nil
    local distance = nil
    local endcoord = nil
    local endpoint = false
    local altitude = nil
    local altft = nil
    local spknt = nil
    local speed = nil
    local afacgroupname = nil
    local afacgroup
    local afacname = ""
    local _afac 

    BASE:E({keywords=keywords})
    for _,keyphrase in pairs(keywords) do
      local str=UTILS.Split(keyphrase, "=")
      local key=str[1]
      local val=str[2]
      if key:lower():find("n") then
        afacgroupname = val
        BASE:E({"Keyword N is:",val,afacgroupname})
      end
      if key:lower():find("h") then
        heading = tonumber(val)
      end
      if key:lower():find("d") then
        distance = tonumber(val)
      end
      if key:lower():find("a") then
        altitude = tonumber(val)
      end
      if key:lower():find("s") then
        speed = tonumber(val)
      end
    end
    -- if we have no afac name we break out with a msg.
    if afacgroupname == nil then
      self:Msg("No afac group was entered, please enter a afac group to control and try again",_group,30)
      return false
    else
      afacgroup = GROUP:FindByName(afacgroupname)
      _afac = afacgroup
      BASE:E({afacgroup})
      if afacgroup == nil then
        self:Msg(string.format("No Group with the name %s was found please check and try again",afacgroupname),_group,30)
        return
      end
    end
    -- if the tankers not well ours we don't command it.
    if afacgroup:GetCoalition() ~= _col then
      self:Msg(string.format("Unable to command afac group %s as they are not of your coalition %s",afacgroupname,_playername),_group,30)
      return
    end
    -- lets work out our cooldowns.
    local cooldown = currentTime - self.AFACTIME
    if cooldown < self.AFAC_COOLDOWN then 
      self:Msg(string.format("%s Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60),_group,30)
      return
    end
    -- is the tanker alive?
    if afacgroup:IsAlive() ~= true then
      self:Msg(string.format("%s is currently not avalible for tasking, it's M.I.A",afacgroupname),_group,30)
      return
    end
    -- update our tanker time.
    self.AFACTIME = currentTime
    
    -- check our values make them sane or default them to sane values.
    if altitude == nil then
      altft = 19000
      altitude = UTILS.FeetToMeters(19000)
    else
      if altitude > 34000 then
        altitude = 34000
      elseif altitude < 1000 then
        altitude = 1000
      end
      altft = altitude
      altitude = UTILS.FeetToMeters(altft)
    end
    if speed == nil then
      spknt = RGUTILS.CalculateTAS(altitude,280,0)
      speed = UTILS.KnotsToMps(spknt)
    else
      if speed > 220 then
        spknt = RGUTILS.CalculateTAS(altitude,220)
      elseif speed < 90 then
        spknt = RGUTILS.CalculateTAS(altitude,90)
      else
        spknt = RGUTILS.CalculateTAS(altitude,speed,0)
      end
      speed = UTILS.KnotsToMps(spknt)
    end
    if heading ~= nil then
      if heading < 0 then
        heading = 0
      elseif heading > 360 then
        heading = 360
      end
      if distance ~= nil then
        if distance > 100 then
          distance = 100
        end
        if distance < 5 then
          distance = 5
        end
        endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
      else
        endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
        distance = 25
      end
    else
      heading = math.random(0,360)
      endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
      distance = 25
    end
    -- actually build our task and push it to the AFAC.
    _afac:ClearTasks()
    local routeTask = _afac:TaskOrbit( coord, altitude,  speed, endcoord )
    _afac:SetTask(routeTask, 2)    
	  local afacTask = _afac:EnRouteTaskFAC(UTILS.NMToMeters(10),1)
	  _afac:PushTask(afacTask, 4)
    -- message to all of blue goes out.
    local _mgrs = coord:ToStringMGRS()
    self:Msg(string.format("%s AFAC is re-routed to the location requested by %s. at %s \nIt will orbit on a heading of %d for %d nm, Alt: %d CAS: %d.\n%d minutes cooldown starting now", _afac:GetName(),_playername,_mgrs,heading,distance,altft,spknt, self.AFAC_COOLDOWN / 60),nil,_col,30, MESSAGE.Type.Information)
    SCHEDULER:New(nil, function() self:afacCooldownHelp(afacgroupname,_col) end, {}, self.AFAC_COOLDOWN)
end

--- handles tanker cooldown help requests
---@param afacname string
---@param _col int
function HEVENT:afacCooldownHelp(afacname,_col)
    local msg = MESSAGE:New(string.format("afac routing is now available again for %s. Use the following marker commands:\n-afac,n=%s \n-afac,n=%s ,h=<0-360>,d=<5-100>,a=<2-30,000>,s=<90-200> \nFor more control",afacname,afacname,afacname,afacname), 30, MESSAGE.Type.Information)
    if _col == 1 then
      msg:ToRed()
    else 
      msg:ToBlue()
    end
end

--- handles tanker cooldown help requests
---@param tankername string
---@param _col int
function HEVENT:tankerCooldownHelp(tankername,_col)
    local msg = MESSAGE:New(string.format("Tanker routing is now available again for %s. Use the following marker commands:\n-tanker,n=%s \n-tanker,n=%s ,h <0-360>,d <5-100>,a <10-30,000>,s <250-400> \nFor more control",tankername,tankername,tankername), 30, MESSAGE.Type.Information)
    if _col == 1 then
      msg:ToRed()
    else 
      msg:ToBlue()
    end
end

--- Handles tanker requests for both red and blue.
-- requires that you enter the group name, works as follows:
-- -tanker route,n=My Tanker Group Name,a=15000,h=120,d=20,s=330 
-- where n = group name
-- a = altitude in ft
-- h = heading in degress
-- d = distance in nm
-- s = speed in CAS.
---@param text string marker text
---@param coord COORDINATE moose coordinate
---@param _col int 0 = neutral, 1 = red, 2 = blue
---@param _playername string players name
---@param _group GROUP MOOSE GROUP.
---@return boolean
function HEVENT:handleTankerRequest(text,coord,_col,_playername,_group)
  if _playername == nil then
    _playername = "Player"
  end
  local currentTime = os.time()
  local keywords=UTILS.Split(text, ",")
  local heading = nil
  local distance = nil
  local endcoord = nil
  local endpoint = false
  local altitude = nil
  local altft = nil
  local spknt = nil
  local speed = nil
  local tankergroupname = nil
  local tankergroup
  local tankername = ""
  BASE:E({keywords=keywords})

  for _,keyphrase in pairs(keywords) do
    local str=UTILS.Split(keyphrase, "=")
    local key=str[1]
    local val=str[2]
    if key:lower():find("n") then
      tankergroupname = val
      BASE:E({"tanker n is:",val,tankergroupname})
    end
    if key:lower():find("h") then
      heading = tonumber(val)
    end
    if key:lower():find("d") then
      distance = tonumber(val)
    end
    if key:lower():find("a") then
      altitude = tonumber(val)
    end
    if key:lower():find("s") then
      speed = tonumber(val)
    end
  end
    -- if we have no tanker name we break out with a msg.
  if tankergroupname == nil or tankergroupname == "" then
    self:Msg("No tanker group was entered, please enter a tanker group to control and try again",_group,30)
    return false
  else
    tankergroup = GROUP:FindByName(tankergroupname)
    BASE:E({"tg:",tankergroup})
    if tankergroup == nil then
      self:Msg(string.format("No Group with the name %s was found please check and try again",tankergroupname),_group,30)
      return
    end
  end
  -- check that the unit is actually a tanker.
    local tanker = tankergroup:GetUnit(1)
    if tanker == nil then
      tanker = tankergroup:GetUnit(0) -- just try.. incase.
    end
  if tanker:IsTanker() ~= true then
    self:Msg(string.format("%s is not a valid tanker group and is unable to be redirected",tankergroupname),_group,30)
    return
  end
  -- if the tankers not well ours we don't command it.
  if tankergroup:GetCoalition() ~= _col then
    self:Msg(string.format("Unable to command tanker group %s as they are not of your coalition %s",tankergroupname,_playername),_group,30)
    return
  end
  -- lets work out our cooldowns.
  local cooldown = currentTime - self.TANKERTIMER
  if cooldown < self.TANKER_COOLDOWN then 
    self:Msg(string.format("%s Requests are not available at this time.\nRequests will be available again in %d minutes", (TANKER_COOLDOWN - cooldown) / 60),_group,30)
    return
  end
  -- is the tanker alive?
  if tankergroup:IsAlive() ~= true then
    self:Msg(string.format("%s is currently not avalible for tasking, it's M.I.A",tankergroupname),_group,30)
    return
  end
  -- update our tanker time.
  self.TANKERTIMER = currentTime
  -- check our values make them sane or default them to sane values.
  if altitude == nil then
    altft = 19000
    altitude = UTILS.FeetToMeters(19000)
  else
    if altitude > 34000 then
      altitude = 34000
    elseif altitude < 6000 then
      altitude = 6000
    end
      altft = altitude
      altitude = UTILS.FeetToMeters(altft)
  end
  if speed == nil then
    spknt = RGUTILS.CalculateTAS(altitude,280,0)
    speed = UTILS.KnotsToMps(spknt)
  else
    if speed > 350 then
      spknt = RGUTILS.CalculateTAS(altitude,350)
    elseif speed < 200 then
      spknt = RGUTILS.CalculateTAS(altitude,200)
    else
      spknt = RGUTILS.CalculateTAS(altitude,speed,0)
    end
    speed = UTILS.KnotsToMps(spknt)
  end
  if heading ~= nil then
    if heading < 0 then
      heading = 0
    elseif heading > 360 then
      heading = 360
    end
    if distance ~= nil then
      if distance > 100 then
        distance = 100
      end
      if distance < 5 then
          distance = 5
      end
      endcoord = coord:Translate(UTILS.NMToMeters(distance),heading)
    else
      endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
      distance = 25
    end
  else
    heading = math.random(0,360)
    endcoord = coord:Translate(UTILS.NMToMeters(25),heading)
    distance = 25
  end
  -- actually build our task and push it to the tanker.
  tanker:ClearTasks()
  local routeTask = tanker:TaskOrbit( coord, altitude,  speed, endcoord )
  tanker:SetTask(routeTask, 2)
  local tankerTask = tanker:EnRouteTaskTanker()
  tanker:PushTask(tankerTask, 4)
  -- message to all of blue goes out.
  local _mgrs = coord:ToStringMGRS()
  self:Msg(string.format("%s Tanker is re-routed to the location requested by %s. at %s \nIt will orbit on a heading of %d for %d nm, Alt: %d CAS: %d.\n%d minutes cooldown starting now", tanker:GetName(),_playername,_mgrs,heading,distance,altft,spknt, TANKER_COOLDOWN / 60),nil,_col,30, MESSAGE.Type.Information)
  SCHEDULER:New(nil, function() self:tankerCooldownHelp(tankergroupname,_col) end, {}, TANKER_COOLDOWN)
end

--- handles tanker cooldown help requests
---@param tankername string
---@param _col int
function HEVENT:tankerCooldownHelp(tankername,_col)
    self:Msg(string.format("Tanker routing is now available again for %s. Use the following marker commands:\n-tanker route %s \n-tanker route %s ,h <0-360>,d <5-100>,a <10-30,000>,s <250-400> \nFor more control",tankername,tankername,tankername),nil,_col, 30, MESSAGE.Type.Information)
end


--- Handles spawnining in a existing template group from the mission.
function HEVENT:newhandlespawn(text,coord,_group,_playername,_coalition)
  if _playername == nil then
    _playername = "player"
  end
  self:Log({"Spawn Request",text,coord,_playername,_group,_coalition})
  local keywords=UTILS.Split(text, ",")
  local unit = nil
  local name = nil
  local heading = nil
  local uheading = nil
  local side = 1
  local ran = false
  local rl = 150
  local ru = 450
  local prefix = self.redprefix
  for _,keyphrase in pairs(keywords) do
     local str=UTILS.Split(keyphrase, "=")
      local key=str[1]
      local val=str[2]
    if key:lower() == "u" then
      unit = val
    elseif key:lower() == "n" then
      name = val
    elseif key:lower()== "h" then
      heading = tonumber(val)
     elseif key:lower() == "uh" then
      uheading = tonumber(val)
    elseif key:lower()== "r" then
      if val:lower() == "true" then
        ran = true 
      else
        ran = false
      end
    elseif key:lower()== "lower" or key:lower() == "min" then
      rl = tonumber(val)
    elseif key:lower() == "upper" or key:lower() == "max" then
      ru = tonumber(val)
    elseif key:lower() == "s" or key:lower() == "c" then
      if val:lower() == "blue" or val:lower() == "b" then
        side = 2
      elseif val:lower() == "un" or val:lower() == "n" then
        side = 0
      else
        side = 1
      end
    end
  end
  local sp = nil
  if (name ~= nil) and (unit ~= nil) then
    local tempgroup = GROUP:FindByName(unit)
    if tempgroup ~= nil then
      if side == 1 then
        prefix = self.redprefix
        sp = SPAWN:NewWithAlias(unit,string.format("%s_%s",self.redprefix,name)):InitCountry(self.redcountry)
      elseif side == 2 then
        prefix = self.blueprefix
        sp = SPAWN:NewWithAlias(unit,string.format("%s_%s",self.blueprefix,name)):InitCountry(self.bluecountry)
      else
        prefix = self.neutralprefix
        sp = SPAWN:NewWithAlias(unit,string.format("%s_%s",self.neutralprefix,name)):InitCountry(self.neutralcountry)
      end

      if ran == true then
        sp:InitRandomizeUnits(true,rl,ru)
      end
      if heading ~= nil then
        self:Log({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
        sp:InitGroupHeading(heading)
      else
        self:Log({"HEADING ACTUALLY WAS NIL WAS",heading})
      end
      if uheading ~= nil then
        self:Log({"UNIT HEADING ACTUALLY WAS NOT NIL WAS",heading})
        sp:InitHeading(heading)
      else
        self:Log({"UNIT HEADING ACTUALLY WAS NIL WAS",heading})
      end
      self:Log({"Spawning:",unit,side,ran,heading})
      sp = sp:SpawnFromCoordinate(coord)
      table.insert(self.spawnedgroup,sp)
      
      self:Msg(string.format("Spawn command completed. Group spawned with a name of %s and a template of %s",prefix .. "_" .. name,unit),_group,_col,10,"Admin")
    else
      self:Msg(string.format("Unable to spawn requested group, %s template does not exist",unit),_group,_col,15)
      self:Log({"Unable to spawn group:",unit})
    end
  else
    self:Log({"Name was Nil! or unit was nil",unit,name})
    self:Msg(string.format("unable to spawn requested group you need a name and a template! \n you had name: %s and template: %s",name,unit),_group,_col,15)
  end
end


--- Routes Mass Group based on distance from the marker.
---@param text string
---@param coord COORDINATE
---@param _playername string
---@param _group GROUP
function HEVENT:routemassgroup(text,coord,_playername,_group,_col)
  local keywords=UTILS.Split(text,",")
  local dist = 25000
  local cl = "red"
  local gcount = 0
  for _,keyphrase in pairs(keywords) do
    local str=UTILS.Split(keyphrase, "=")
    local key=str[1]
    local val=str[2]
    if key:lower():find("d") then
      dist = tonumber(val)
    end
    if key:lower():find("s") then
      cl = val
      if cl == nil then
        cl = "red"
        BASE:E({"routemassgroups cl was nil shouldn't be",cl,val})
      end
      if cl ~= "red" or cl ~="blue" then
        if cl:lower() == "red" or cl:lower() == "r" then
          cl = "red"
        elseif cl:lower() == "blue" or cl:lower() == "b" then
          cl = "blue"
        else
          cl = "red"
        end
      end
    end
  end
  local gunits = nil
  gunits = SET_GROUP:New():FilterCoalitions(cl):FilterActive(true):FilterCategoryGround():FilterOnce()
  if gunits ~= nil then  
    gunits:ForEach(function(g)
      if g:IsAlive() == true then
				local _group = GROUP:FindByName(g:GetName())
				gc = _group:GetCoordinate()
				if gc == nil then
					BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
				else
          
					local d = gc:Get2DDistance(coord)
					if d < dist then
            gcount = gcount + 1
						local rcoord = coord:GetRandomCoordinateInRadius(500,100)
						g:RouteGroundTo(rcoord,math.random(10,20),randomform(),5)
					end
				end
			end
    end)
  end

  self:Msg(string.format("Routing %d groups withing a distance %d of coalition %s to the marker point",gcount,dist,cl),_group,_col,15,"Admin")
end


---Handles a Despawn request.
---@param text string
---@param _playername string DCS player name
---@param _group GROUP dcs group.
function HEVENT:handledespawn(text,_playername,_group,_col)
  BASE:E({"DeSpawn Request",text})
  local keywords=UTILS.Split(text, ",")
  local unit = nil
  BASE:E({"DESPAWN", keywords=keywords})
  unit = keywords[2]
  local mgroup = nil
  mgroup = GROUP:FindByName(unit)
  if mgroup == nil then
    self:Log({"Despawn error no group found"})
    self:Msg(string.format("Admin Command Error, group with name %s not found.",unit),_group,_col,12)
  else
    if mgroup:IsAlive() == true then
      mgroup:Destroy()
    end
    self:Log({"Despawning Unit",unit})
    self:Msg(string.format("Admin Command group with name %s has been removed.",unit),_group,_col,12)
  end
end


--- works out the massgroup command
-- command entry is '-massgroup,d=1000,s=red,n=groupname'
-- if s is blank then it defaults to removing both.
---@param text string marker text
---@param coord COORDINATE moose coordinate
---@param _playername string event init playername.
function HEVENT:massgroup(text,coord,_playername,coalition)
  local _playername = _playername or "Admin"
  local keywords=UTILS.Split(text,",")
  local dist = 1000
  local _col = "red"
  local name = nil
  for _,keyphrase in pairs(keywords) do
    BASE:E({keywords})
    local str=UTILS.Split(keyphrase, "=")
    local key=str[1]
    local val=str[2]
    BASE:E({key,val})
    if key:lower():find("d") then
      _dist = tonumber(val)
    end
    if key:lower():find("s") then
      _col = val
    end
    if key:lower():find("n") then
      _name = val
    end
    if _name == nil then
      local _msg = string.format("Sorry %s unable to group, you did not enter a group name",_playername)
      self:Msg(_msg,nil,nil,15,"Admin",false)
    end
  end
  BASE:E({_dist,_col,_name,_playername})
  self:domassgroup(coord,_dist,_col,_name,_playername)
end

--- Executes the Massgroup Command, combining groups based on distance and coalition.
--- @param _coord COORDINATE moose coordinate
--- @param _dist INT distance in meters
--- @param _coalition string Coalition "red" or "blue"
--- @param _name string Combined Group name.
--- @param _playername string player who executed the marker event if known.
function HEVENT:domassgroup(_coord,_dist,_coalition,_name,_playername)
  BASE:E({_coord,dist,_coalition,_name,_playername})
  local delcount = 0
  local _mgrs = _coord:ToStringMGRS()
  local _msg = string.format("Mass group requested by admin %s at coord %s all groups within %d meters of %s coalition will be grouped",_playername,_mgrs,_dist,_coalition)
  self:Msg(_msg,nil,nil,30,"admin")
  local tempunits = {}
  local tempgroup = {}
  local _gx = nil
  local _gy = nil
  local _unitcount = 0
  local _country = nil
  local _CategoryID = nil
  local _name = "IAA_" .. _name
  local _country = self.bluecountry
  local gunits = nil
  if _coalition:lower():find("blue") then
    _country = self.bluecountry
    gunits = SET_GROUP:New():FilterCoalitions("blue"):FilterCategoryGround():FilterActive(true):FilterOnce()
  elseif _coalition:lower():find("red") then
    _country = self.redcountry
    gunits = SET_GROUP:New():FilterCoalitions("red"):FilterCategoryGround():FilterActive(true):FilterOnce()
  else
    self:Msg("domassgroup did not detect a coalition entry check for a bug",nil,nil,15,"Admin",false)
    return false
  end
  if gunits == nil then
    self:Msg("domassgroup Error gunits was never set!",nil,nil,15,"admin",false)
    return false
  end
  
  gunits:ForEach(function(grp)  
    if grp:IsAlive() == true then
      local _group = GROUP:FindByName(grp:GetName())
      gc = _group:GetCoordinate()
      _CategoryID = grp:GetCategory()
      if gc == nil then
        self:Log({"Could not get Coord for group:",grp:GetName(),grp:GetCoordinate(),gc})
      else
        local d = gc:Get2DDistance(_coord)
        if d < _dist then
          local DCSgroup = Group.getByName(grp:GetName())
          local size = DCSgroup:getSize()
          local _units = grp:GetUnits()
          for _key,_un in pairs(_units) do
            local _unit = UNIT:FindByName(_un.UnitName)
            if _unit:IsAlive() == true then
              -- store our group x,y from the first unit
              if _gx == nil then
                _gx = _unit:GetVec2().x
              end
              if _gy == nil then
                _gy = _unit:GetVec2().y
              end                

              local skill = RGUTILS.GetExperience()

              local _h = UTILS.ToRadian(_unit:GetHeading())
              local tmpTable =
              {   
                ["type"]=_unit:GetTypeName(),
                ["transportable"]=true,
                ["unitID"]=_unit:GetID(),
                ["skill"]=skill,
                ["y"]=_unit:GetVec2().y,
                ["x"]=_unit:GetVec2().x,
                ["name"]=_unit:GetName(),
                ["playerCanDrive"]=true,
                ["heading"]=_h,
              }
              _unitcount = _unitcount + 1
              table.insert(tempunits,tmpTable) --add units to a temporary table
            end
          end-- This section here needs to check the unit table and store all the units in tempunits.
          grp:Destroy()
          delcount = delcount + 1
        end
      end
    else
      self:Log({"Group is dead",g:GetName()})
    end
  end)
  local groupData = 
  {
    ["visible"] = false,
    ["hiddenOnPlanner"] = true,
    ["hiddenOnMFD"] = true,
    ["tasks"] = {}, -- end of ["tasks"]
    ["uncontrollable"] = false,
    ["task"] = "Ground Nothing",
    ["hidden"] = false,
    ["units"] = tempunits,
    ["y"] = _gy,
    ["x"] = _gx,
    ["name"] = _name,
  } 
  coalition.addGroup(_country, _CategoryID, groupData)

  local _msg = string.format("Mass Group Request by %s Completed. \n We combined %d groups containing %d units. \n the new group is called %s",_playername,delcount,_unitcount,_name)
  self:Msg(_msg,nil,nil,15,"Admin",false)
end

--- works out the massdel command
-- command entry is '-massdel,d=1000,s=red'
-- if s is blank then it defaults to removing both.
---@param text string marker text
---@param coord COORDINATE moose coordinate
---@param _playername string event init playername.
function HEVENT:deletemassgroup(text,coord,_playername)
  local keywords=UTILS.Split(text,",")
  local dist = 25000
  local col = "both"
  for _,keyphrase in pairs(keywords) do
    local str=UTILS.Split(keyphrase, "=")
    local key=str[1]
    local val=str[2]
    if key:lower():find("d") then
      dist = tonumber(val)
    end
    if key:lower():find("s") then
      col = val 
    end
  end
  self:massdel(coord,dist,col,_playername)
end



---Handles Mass Deletion
---@param _coord COORDINATE dcs coordinate
---@param dist int meters
---@param _coalition int coalition 1 = red, 2 = blue, 0 = neutral.
---@param _playername string player who initated the marker.
function HEVENT:massdel(_coord,dist,_coalition,_playername)
  if _playername == nil then
    _playername = "Player"
  end
  local delcount = 0
  local _mgrs = _coord:ToStringMGRS()
  local _msg = string.format("Mass Delete requested by admin %s at coord %s, all units within %d meters of %s coalition will be deleted",_playername,_mgrs,dist,_coalition)
  self:Msg(_msg,nil,nil,30,"admin")
  local gunits = SET_GROUP:New():FilterCategoryGround():FilterActive(true):FilterOnce()
  if _coalition == "blue" or _coalition == "Blue" or _coalition == "BLUE" then
    gunits:FilterCoalitions("blue"):FilterCategoryGround():FilterActive(true):FilterOnce()
  elseif _coalition == "red" then
    gunits:FilterCoalitions("red"):FilterCategoryGround():FilterActive(true):FilterOnce()
  else
    gunits:FilterCategoryGround():FilterActive(true):FilterOnce()
  end
  gunits:ForEach(function(g)  
    if g:IsAlive() == true then
      local _group = GROUP:FindByName(g:GetName())
      gc = _group:GetCoordinate()
      if gc == nil then
        self:Log({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
      else
        local d = gc:Get2DDistance(_coord)
        if d < dist then
          g:Destroy()
          delcount = delcount + 1
        end
      end
    else
      self:Log({"Group is dead",g:GetName()})
    end
  end)
  MESSAGE:New(string.format("Mass Delete requested Completed, we deleted %d Groups",delcount),30,"Info"):ToAll()
end

---send a Message to all
---@param text string
function HEVENT:Msgtoall(text)
  self:Log({"Msg to all",text})
  local keywords=UTILS.Split(text,",")
  local msg = keywords[2]
  if msg ~= nil then
    self:Msg(msg,nil,nil,15)
  end
end


--- THIS NEEDS TO GO BYE BYE ASAP.do
--- Remember to update documentation.
function HEVENT:handleoldspawn(text,coord)
  BASE:E({"Spawn Request",text,coord})
  local keywords=UTILS.Split(text, ",")
  local unit = nil
  local name = nil
  local heading = nil
  local random = false
  for _,keyphrase in pairs(keywords) do
    local str=UTILS.Split(keyphrase, " ")
    local key=str[1]
    local val=str[2]
    if key:lower() == "u" then
      unit = val
    elseif key:lower() == "n" then
      name = val
    elseif key:lower() == "h" then
      heading = tonumber(val)
    elseif key:lower() == "r" then
      if val:lower() == "true" then
        random = true
      else
        random = false
      end  
    end
  end

  
  if unit == "rarmour" then
    local su = SPAWN:NewWithAlias("GM_Tanks","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rarmour1" then
    local su = SPAWN:NewWithAlias("GM_Tanks-1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rarmour2" then
    local su = SPAWN:NewWithAlias("GM_Tanks-2","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsa15" then
    local su = SPAWN:NewWithAlias("GM_RSA15","IAA SHORAD " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rbuk" then
    local su = SPAWN:NewWithAlias("GM_RBUK","IAA SAM " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsa19" then
    local su = SPAWN:NewWithAlias("GM_RSA19","IAA SHORAD " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rflak" then
    local su = SPAWN:NewWithAlias("GM_FLAK_RED","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rflak1" then
    local su = SPAWN:NewWithAlias("GM_BO_RED","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,150,400)
    end
    if heading ~= nil then
      BASE:E({"HEADING ACTUALLY WAS NOT NIL WAS",heading})
      su:InitHeading(heading)
    else
    BASE:E({"HEADING ACTUALLY WAS NIL WAS",heading})
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rinf" then
    local su = SPAWN:NewWithAlias("GM_Infantry","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,200,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rinf1" then
    local su = SPAWN:NewWithAlias("GM_Infantry-1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,200,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "raaa" then
    local su = SPAWN:NewWithAlias("GM_AAA","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,200,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rmpad" then
    local su = SPAWN:NewWithAlias("GM_AAA-1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,200,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
  elseif unit == "rsam" then
    local su = SPAWN:NewWithAlias("GM_SA10","IAA SAM " .. name)
    if random == true then
      su:InitRandomizeUnits(true,300,800)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rgrad" then
    local su = SPAWN:NewWithAlias("GM_GRAD","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rroad" then
    local su = SPAWN:NewWithAlias("GM_ROAD","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bbase" then
    local su = SPAWN:NewWithAlias("GM_BBASE","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rbase" then
    local su = SPAWN:NewWithAlias("GM_BASE","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsa2" then
    local su = SPAWN:NewWithAlias("GM_SA2","IAA SAM" .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rrap" then
    local su = SPAWN:NewWithAlias("GM_RRAP","IAA SAM " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rew" then
    local su = SPAWN:NewWithAlias("GM_REW","IAA EW " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "brap" then
    local su = SPAWN:NewWithAlias("GM_BRAP","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bhawk" then
    local su = SPAWN:NewWithAlias("GM_HAWK","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bart1" then
    local su = SPAWN:NewWithAlias("GM_BART1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bart2" then
    local su = SPAWN:NewWithAlias("GM_BART2","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bart3" then
    local su = SPAWN:NewWithAlias("GM_BART3","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rart1" then
    local su = SPAWN:NewWithAlias("GM_RART","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rhawk" then
    local su = SPAWN:NewWithAlias("GM_HAWKR","IAA SAM " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bpat" then
    local su = SPAWN:NewWithAlias("GM_PAT","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bah64" then
    local su = SPAWN:NewWithAlias("GM_AH64","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bjtac" then
    local su = SPAWN:NewWithAlias("GM_JTAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
    elseif unit == "bfac" then
    local su = SPAWN:NewWithAlias("GM_BFAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "bsup" then
    local su = SPAWN:NewWithAlias("GM_BSUP","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rsup" then
    local su = SPAWN:NewWithAlias("GM_RSUP","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rah1" then
    local su = SPAWN:NewWithAlias("GM_AH1","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rscud" then
    local su = SPAWN:NewWithAlias("GM_SCUD","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,200)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsa6" then
    local su = SPAWN:NewWithAlias("GM_SA6","IAA SHORAD " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading,heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)  
  elseif unit == "barmour" then
    local su = SPAWN:NewWithAlias("GM_BArmor","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "barmour1" then
    local su = SPAWN:NewWithAlias("GM_BArmor-1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
elseif unit == "barmour2" then
    local su = SPAWN:NewWithAlias("GM_BArmor-2","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "binf" then
    local su = SPAWN:NewWithAlias("GM_BInf","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "binf1" then
    local su = SPAWN:NewWithAlias("GM_BInf-1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "uh60" then
    local su = SPAWN:NewWithAlias("GM_BH","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "mi8" then
    local su = SPAWN:NewWithAlias("GM_MI8","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "baaa" then
    local su = SPAWN:NewWithAlias("GM_BAAA","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu25t" then
    local su = SPAWN:NewWithAlias("GM_SU25T","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu24m2" then
    local su = SPAWN:NewWithAlias("GM_SU24M2","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu24m1" then
    local su = SPAWN:NewWithAlias("GM_SU24M1","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rsu24m" then
    local su = SPAWN:NewWithAlias("GM_SU24M","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rmig29" then
    local su = SPAWN:NewWithAlias("GM_MIG29","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rjf17" then
    local su = SPAWN:NewWithAlias("GM_JF17","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rf14" then
    local su = SPAWN:NewWithAlias("GM_F14","IAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
  elseif unit == "ba10" then
    local su = SPAWN:NewWithAlias("GM_A10","GM_USAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bf15" then
    local su = SPAWN:NewWithAlias("GM_F15C","GM_USAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bf15e" then
    local su = SPAWN:NewWithAlias("GM_F15E","GM_USAA " .. name):InitRandomizeRoute(1,2,UTILS.NMToMeters(60),UTILS.FeetToMeters(5000))
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "afac" then
    local su = SPAWN:NewWithAlias("GM_AFAC","GM_USAA " .. name)
	MESSAGE:New("DCS AI AFAC should be on 265UHF",30):ToBlue()
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "rafac" then
    local su = SPAWN:NewWithAlias("GM_AFAC-1","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "afac2" then
    local su = SPAWN:NewWithAlias("GM_AFAC","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase(su:GetName(), _code) 
	MESSAGE:New("DCS AI AFAC should be on 265UHF",30):ToBlue()
  elseif unit == "rafac2" then
    local su = SPAWN:NewWithAlias("GM_AFAC","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase(su:GetName(), _code) 
	elseif unit == "bjtac1" then
    local su = SPAWN:NewWithAlias("GM_BJTAC","GM_USAA " .. name)
	MESSAGE:New("DCS AI JTAC should be on 133VHF",30):ToBlue()
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
	local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase(su:GetName(), _code) 
  elseif unit == "rjtac" then
    local su = SPAWN:NewWithAlias("GM_RJTAC","GM_IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
  local _code = table.remove(ctld.jtacGeneratedLaserCodes, 1)
    --put to the end
    table.insert(ctld.jtacGeneratedLaserCodes, _code)
    ctld.JTACAutoLase(su:GetName(), _code) 
  elseif unit == "hvt" then
    local su = SPAWN:NewWithAlias("GM_HVT","IAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "b52" then
    local su = SPAWN:NewWithAlias("GM_B52","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "b1" then
    local su = SPAWN:NewWithAlias("GM_B1","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "c17" then
    local su = SPAWN:NewWithAlias("GM_C17A","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
  elseif unit == "bc130" then
    local su = SPAWN:NewWithAlias("GM_BC130","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su)
   elseif unit == "rc130" then
    local su = SPAWN:NewWithAlias("GM_RC130","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
  elseif unit == "il74" then
    local su = SPAWN:NewWithAlias("GM_IL76","GM_USAA " .. name)
    if random == true then
      su:InitRandomizeUnits(true,100,500)
    end
    if heading ~= nil then
      su:InitGroupHeading(heading)
    end
    su = su:SpawnFromCoordinate(coord)
    table.insert(adminspawned,su) 
  else
    MESSAGE:New("Banner: I tried Tony, I really tried...",10):ToAll()
  end
end
