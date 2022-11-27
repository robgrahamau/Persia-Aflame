local p0  = 101325.0;  -- [N/m^2] = [Pa]
local p1  =  22632.05545875171;                 -- [N/m^2] = [Pa] Calculated @ 11000.0000000000001 [ft]
local p2  =   5474.884659730908;                -- [N/m^2] =-- [Pa] Calculated @ 20000.000000000001  [ft]
local p3  =   868.0176477556424;                -- [N/m^2] = [Pa] Calculated @ 32000.000000000001  [ft]

local p0hPa   =   1013.25;     -- [hPa]
local p0inHG  =     29.92;     -- [inHG] Truncated 29.9213
local p0mmHG                   = p0inHG*25.4;   -- [mmHG] w/ 25.4 [mm] = 1.0 [in]

local T0  =    288.15;     -- [K]
local T1  =    216.65;     -- [K]
local T2  =    216.65;     -- [K]

local h1  =  36089.238845144355;                -- [ft] = 11000 [m] w/ CftTOm
local h2  =  65616.79790026246;                 -- [ft] = 20000 [m] w/ CftTOm
local h3  = 104986.87664041994;                 -- [ft] = 32000 [m] w/ CftTOm

local dTdh0 = -0.0019812;                     -- [K/ft] w/ CftTOm
local dTdh0SI = -0.0065;   -- [K/m]

local dTdh2 = 0.0003048;                     -- [K/ft] w/ CftTOm
local dTdh2SI = 0.001;    -- [K/m]

local CPascalTOPSI = 1.45037737730209e-04;
local ChPaTOinHG  = p0inHG/p0hPa;
local ChPaTOmmHG  = p0mmHG/p0hPa;
local ClbPft3TOkgPm3 = 16.0184633739601;               -- [lb/ft^3] to [kg/m^3]

local CftTOm = 0.3048;
local CftTOnm = 1.64578833693305e-04;

local CnmTOm = 1852.0;

local CftPsTOkn   = CftTOnm*3600.0;
local CftPsTOmph  = 3600.0/5280.0;
local CftPsTOkph  = CftTOm*3600.0/1000.0;

local CmPsTOkn    = 3600.0/CnmTOm;

local CknTOftPs   = 1.0/(CftTOnm*3600.0);

local CRGasSI = 287.053;    -- [m^2/(s^2*K)] = [J/(kg*K)]

local CgSI = 9.80665;  -- [m/s^2]

local CgRGas  = (CgSI*CftTOm)/CRGasSI;
local CgRGasSI    = CgSI/CRGasSI;

local CgRGas  = (CgSI*CftTOm)/CRGasSI;

local CGamma  =      1.4;  -- [-]
local CGammaRGas  = (CGamma*CRGasSI)/(CftTOm*CftTOm);   -- [ft^2/(s^2*K)]

local CaSLSI  = math.sqrt(CGamma*CRGasSI*T0);
local CPressureSLSI                    = 101325.0;  -- [Pa] = [N/m^2]
local CaSLNU  = CaSLSI*CmPsTOkn;                    -- [kts] Nautical Unit
local CRhoSLSI    =      1.225;    -- [kg/m^3]

local CKelvinTOCelsius                 =    273.15;
local CKelvinTORankine                 =      1.8;

local CCelsiusTOFahrenheitLinear       =     32.0;
local CCelsiusTOFahrenheitProportional =      1.8;



RGUTILS = {}
---Stand Alone version of BASE to use as my own logged.
---@param Arguments any
function RGUTILS.log( Arguments )
    if _DEBUG then
        local DebugInfoCurrent = debug.getinfo( 2, "nl" )
        local DebugInfoFrom = debug.getinfo( 3, "l" )
        local Function = "function"
        if DebugInfoCurrent.name then
            Function = DebugInfoCurrent.name
        end
        local LineCurrent = DebugInfoCurrent.currentline
          local LineFrom = -1 
        if DebugInfoFrom then
          LineFrom = DebugInfoFrom.currentline
        end
        env.info( string.format( "%6d(%6d)/%1s:%30s%05s.%s(%s)" , LineCurrent, LineFrom, "Info", "Rob Debug", ":", Function, RGUTILS.oneLineSerialize( Arguments ) ) )
        hm(string.format( "%6d(%6d)/%1s:%30s%05s.%s(%s)" , LineCurrent, LineFrom, "Info", "Rob Debug", ":", Function, RGUTILS.oneLineSerialize( Arguments ) ) )
        trigger.action.outText( string.format( "%6d(%6d)/%1s:%30s%05s.%s(%s)" , LineCurrent, LineFrom, "Info", "Rob Debug", ":", Function, RGUTILS.oneLineSerialize( Arguments ) ),true,false)
    else
      env.info( string.format( "%1s:%30s%05s(%s)" , "Info", "Rob Debug", ":", RGUTILS.oneLineSerialize( Arguments ) ) )
      hm(string.format( "%1s:%30s%05s(%s)" , "Info", "Rob Debug", ":", RGUTILS.oneLineSerialize( Arguments ) ) )
    end
end

function RGUTILS.updatetime()
  if os ~= nil then
      NOWTABLE = os.date('*t')
      NOWYEAR = NOWTABLE.year
      NOWMONTH = NOWTABLE.month
      NOWDAY = NOWTABLE.day
      NOWHOUR = NOWTABLE.hour
      NOWMINUTE = NOWTABLE.min
      NOWSEC = NOWTABLE.sec
      NOWTIME = os.time()
  else
      rlog("WARNING, OS IS SANATIZED AND WE ARE UNABLE TO GET THAT INFORMATION. SOME THINGS MAY NOT FUNCTION CORRECTLY.")
  end
end
function RGUTILS.getTimefromseconds(time)
  local days = math.floor(time/86400)
  local remaining = time % 86400
  local hours = math.floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = math.floor(remaining/60)
  remaining = remaining % 60
  local seconds = math.floor(remaining)
  return string.format("%d:%02d:%02d:%02d",days,hours,minutes,seconds)
end

-- porting in Slmod's serialize_slmod2
RGUTILS.oneLineSerialize = function( tbl ) -- serialization of a table all on a single line, no comments, made to replace old get_table_string function

    lookup_table = {}
  
    local function _Serialize( tbl )
  
      if type( tbl ) == 'table' then -- function only works for tables!
  
        if lookup_table[tbl] then
          return lookup_table[object]
        end
  
        local tbl_str = {}
  
        lookup_table[tbl] = tbl_str
  
        tbl_str[#tbl_str + 1] = '{'
  
        for ind, val in pairs( tbl ) do -- serialize its fields
          local ind_str = {}
          if type( ind ) == "number" then
            ind_str[#ind_str + 1] = '['
            ind_str[#ind_str + 1] = tostring( ind )
            ind_str[#ind_str + 1] = ']='
          else -- must be a string
            ind_str[#ind_str + 1] = '['
            ind_str[#ind_str + 1] = RGUTILS.basicSerialize( ind )
            ind_str[#ind_str + 1] = ']='
          end
  
          local val_str = {}
          if ((type( val ) == 'number') or (type( val ) == 'boolean')) then
            val_str[#val_str + 1] = tostring( val )
            val_str[#val_str + 1] = ','
            tbl_str[#tbl_str + 1] = table.concat( ind_str )
            tbl_str[#tbl_str + 1] = table.concat( val_str )
          elseif type( val ) == 'string' then
            val_str[#val_str + 1] = RGUTILS.basicSerialize( val )
            val_str[#val_str + 1] = ','
            tbl_str[#tbl_str + 1] = table.concat( ind_str )
            tbl_str[#tbl_str + 1] = table.concat( val_str )
          elseif type( val ) == 'nil' then -- won't ever happen, right?
            val_str[#val_str + 1] = 'nil,'
            tbl_str[#tbl_str + 1] = table.concat( ind_str )
            tbl_str[#tbl_str + 1] = table.concat( val_str )
          elseif type( val ) == 'table' then
            if ind == "__index" then
              --	tbl_str[#tbl_str + 1] = "__index"
              --	tbl_str[#tbl_str + 1] = ','   --I think this is right, I just added it
            else
  
              val_str[#val_str + 1] = _Serialize( val )
              val_str[#val_str + 1] = ',' -- I think this is right, I just added it
              tbl_str[#tbl_str + 1] = table.concat( ind_str )
              tbl_str[#tbl_str + 1] = table.concat( val_str )
            end
          elseif type( val ) == 'function' then
            --	tbl_str[#tbl_str + 1] = "function " .. tostring(ind)
            --	tbl_str[#tbl_str + 1] = ','   --I think this is right, I just added it
          else
            --					env.info('unable to serialize value type ' .. routines.utils.basicSerialize(type(val)) .. ' at index ' .. tostring(ind))
            --					env.info( debug.traceback() )
          end
  
        end
        tbl_str[#tbl_str + 1] = '}'
        return table.concat( tbl_str )
      else
        if type( tbl ) == 'string' then
          return tbl
        else
          return tostring( tbl )
        end
      end
    end
  
    local objectreturn = _Serialize( tbl )
    return objectreturn
  end


--- Message out to all that doesn't use MOOSE
---@param string _msg
---@param int _duration
---@param boolean _clear 
RGUTILS.MessageAll = function(_msg,_duration,_clear)
  _msg = _msg or nil
  _duration = _duration or 10
  _clear = _clear or false
  if _msg == nil then
    return false
  end
  trigger.action.outText(_msg,_duration,_clear)
end

RGUTILS.MessageRed = function(_msg,_duration,_clear)
  _msg = _msg or nil
  _duration = _duration or 10
  _clear = _clear or false
  if _msg == nil then
    return false
  end
  trigger.action.outTextForCoalition(1,_msg,_duration,_clear)
end

RGUTILS.MessageBlue = function(_msg,_duration,_clear)
  _msg = _msg or nil
  _duration = _duration or 10
  _clear = _clear or false
  if _msg == nil then
    return false
  end
  trigger.action.outTextForCoalition(2,_msg,_duration,_clear)
end

RGUTILS.MessageNeutral = function(_msg,_duration,_clear)
  _msg = _msg or nil
  _duration = _duration or 10
  _clear = _clear or false
  if _msg == nil then
    return false
  end
  trigger.action.outTextForCoalition(0,_msg,_duration,_clear)
end

RGUTILS.MessageGroup = function(_msg,_duration,_group,_clear)
  _msg = _msg or nil
  _group = _group or nil
  _duration = _duration or 10
  _clear = _clear or false
  _t = nil
  if _msg == nil then
    return false
  end
  if _group == nil then
    return false
  else
    _t = Group.getByName(_group)
    if _t ~= nil then
      if _t:isExist() ~= true then
        return false
      end
    end
  end
  trigger.action.outTextForGroup(_t:getID(),_msg,_duration,_clear)
end

RGUTILS.MessageUnit= function(_msg,_duration,_unit,_clear)
  _msg = _msg or nil
  _unit = _unit or nil
  _duration = _duration or 10
  _clear = _clear or false
  _t = nil
  if _msg == nil then
    return false
  end
  if _unit == nil then
    return false
  else
    _t = Unit.getByName(_unit)
    if _t ~= nil then
      if _t:isExist() ~= true then
        return false
      end
    end
  end
  trigger.action.outTextForUnit(_t:getID(),_msg,_duration,_clear)
end

  -- porting in Slmod's "safestring" basic serialize
RGUTILS.basicSerialize = function( s )
  if s == nil then
    return "\"\""
  else
    if ((type( s ) == 'number') or (type( s ) == 'boolean') or (type( s ) == 'function') or (type( s ) == 'table') or (type( s ) == 'userdata')) then
      return tostring( s )
    elseif type( s ) == 'string' then
      s = string.format( '%s', s:gsub( "%%", "%%%%" ) )
      return s
    end
  end
end

RGUTILS.msg = function(_msg,_group,_duration,_infotype,_clear)
  _infotype = infotype or nil
  _clear = clear or false
  if _group == nil then
    RGUTILS.MessageAll(_msg,_duration,_clear)
    RGUTILS.log({_msg,_duration,_group})
  else
    RGUTILS.MessageGroup:New(_msg,_duration,_group,_clear)
    RGUTILS.log({_msg,_duration,_group})
  end
end

RGUTILS.groupchecker = function()
  local tempset = SET_UNIT:New():FilterActive():FilterOnce()
  local checker = {}
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
  checker.activegroups = gcounter
  checker.bluegroups = gb
  checker.redgroups = gr
  checker.neutralgroups = gn
  checker.activeunits = ucounter
  checker.blueunits = ub
  checker.redunits = ur
  checker.neutralunits = un
  return checker
end


function RGUTILS.calculateTemperaturePressure(ah) 
  local T = 0.0
  local p = 0.0
  if (ah <= h1) then
    -- Layer 0 > Troposphere
    T = T0 + dTdh0*ah
    p = p0*math.pow((T0/T), (CgRGasSI/dTdh0SI))
  elseif (ah <= h2) then

    T = T1;
    p = p1*math.exp((CgRGas/T1)*(h1 - ah))
  elseif (ah <= h3) then
    -- Layer 2 > Stratosphere (1/2)
    T = T2 + dTdh2*(ah - h2)
    p = p2*math.pow((T2/T), (CgRGasSI/dTdh2SI))
  else
    local temp= {
      T=0.0,
      p=0.0,
      Valid=false,
    }
    return temp
  end
  local temp= {
    T = T,
    p = p,
    Valid = true,
  }
  return temp
end



function RGUTILS.CalculateTAS(_ALT,_CAS,_DISA)
  local disa = _DISA or 0
  local h = _ALT
  local CAS = _CAS
  local TemperaturePressure = RGUTILS.calculateTemperaturePressure(h);
  if TemperaturePressure.Valid == false then
    return
  end
  local T = TemperaturePressure.T + disa
  local p = TemperaturePressure.p
  Rho = p/(CRGasSI*T) 
  a = math.sqrt(CGammaRGas*T)
  local TAS = math.sqrt(5)*a*math.sqrt(math.pow(((CPressureSLSI/p)*(math.pow((CAS*CAS/(5.0*CaSLNU*CaSLNU)) + 1, (CGamma/(CGamma - 1))) - 1) + 1), (CGamma - 1)/CGamma) - 1)
  local Mach = TAS/a
  local EAS = TAS*math.sqrt(Rho/CRhoSLSI)
  TAS = math.floor(TAS * CftPsTOkn)
  EAS = math.floor(EAS * CftPsTOkn)
  return TAS
end


---Hypeman Msg Handler
---@param msg string
function hm(msg)
  if __HMLOADED then
      HypeMan.sendBotMessage(msg)
  else
      env.info(string.format("Hypeman not loaded: %s",msg))
  end
end

---Hypeman LSO Msg Handler
---@param msg string
function hmlso(msg)
if _HMLOADED then
      HypeMan.sendLSOBotMessage(msg)
  else
      env.info(string.format("Hypemand not loaded - LSOMSG: %s",msg))
  end
end

--- Schedules a message to all users on the system.
---@param msg string The message to send.
---@param _time integer the time between messages.
---@param _repeat integer -1 for infinite repeat, 0 or nil for single display, or the # of times to repeat.
function RGUTILS.scheduledmsgtoall(msg,_time,_repeat)
  _repeat = _repeat or 0
  _time = _time or 15
  if _repeat ~= 0 then
    if _repeat > 0 then
      _repeat = _repeat - 1
    end
  end
  RGUTILS.MessageAll(msg,15,false)
  if _repeat ~= 0 then
    timer.scheduleFunction(function() RGUTILS.scheduledmsgtoall(msg,_time,_repeat)  end,{},timer.getTime() + _time)
  end
end


---File Loader with error handling.
---@param filename string name of the file to run
---@param path string path to the file to run.
---@param dmsg boolean display an error message in dcs if there is an error
---@param _repeat integer -1 = repeat to infinity, 0 or nil = no repeat, else # of times to repeat the msg.
---@param _time integer time in seconds for msg to repeat displaying, defaults to 15 seconds.
function _LOADFILE(filename,path,dmsg,_repeat,_time)
  dmsg = dmsg or false
  _repeat = _repeat or nil
  _time = _time or nil
  RGUTILS.log({"Attempting to load file",filename,path})    
    local ran, errorMSG = pcall(function() dofile(path .. filename) end)
		if not ran then
			RGUTILS.log({"_LOADFILE errored ",errorMSG})
      if dmsg then
        local _msg = string.format("Warning File %s errored, check log for msg",filename)
        RGUTILS.scheduledmsgtoall(_msg,_time,_repeat)
      end
		end
end
