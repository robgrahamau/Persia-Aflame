LuaQ                   $      $@  @  $    $ΐ  ΐ  $    $@ @ $          lotatc_mutils_load    lotatc_mutils_preload    lotatc_mutils_run    lotatc_mutils_get_mid    lotatc_mutils_get_player_name    lotatc_mutils_get_units    lotatc_mutils_get_callsign                       E@     Α  \ΐ       Ό       atc_id_xtract = function(runtimeId)
      for i,v in pairs(db.units) do
        if v.ID == runtimeId then
          return v.unitId
        end
      end
      return 'nil'
    end
      lotatc_mutils_run    MUtils load                        )            E@     Α  \ΐ             if not serialize then
      serialize = function(val)
        if type(val)=='number' or type(val)=='boolean' then
          return tostring(val)
        elseif type(val)=='string' then
          return string.format("%q", val)
        elseif type(val)=='table' then
          local k,v
          local str = '{'
          for k,v in pairs(val) do
            str=str..'['..serialize(k)..']='..serialize(v)..','
          end
          str = str..'}'
          return str
        end
        return 'nil'
      end
    end
      lotatc_mutils_run    MUtils preload                     ,   /           Α@     @            lotatc_utils_run    mission                     2   @     #   @  @ A   ^  E@  Fΐ ΐ  ΐ   \  ΐ  A ΐ   @ A Α A A Α AA  AΑ A A   Α @                   string    format $   return serialize(atc_id_xtract(%s))    lotatc_mutils_run 
   Search id    nil    lotatc_debug 
   Not found    --> ID: 
   --> RRES: 	   tonumber                     C   K        E      \ @  Z   Ε  Ζΐΐ  E  FΑά           lotatc_mutils_get_mid        DCS    getUnitProperty    UNIT_PLAYER_NAME                     N   v      *   
   E   F@ΐ \ Fΐ Fΐΐ  Α  A A Α Α ’@δ       Η@ Ε   ά @ FΒΒΐE  \@D   D ΖDD a  ΐύ!  @όα  ΐϊ          DCS    getCurrentMission    mission 
   coalition    plane    helicopter    vehicle    static    ship    _get_units    pairs    country        S   d          ΐF @ Z    E@   @ \ ΐ  ΐA  Ζΐ@Δ     J  CAIAIΙB‘  ΐόa  ϊ        group    pairs    units       π?   id    unitId    type                                 y   ¬     $^   J      ΐ    @    ^  Κ   A  @ Α@AJ A Α bA Α ΐ  ΕΒ BάΔ @ FZ  @FZ  EΒ
  ΐΕ ΖEΒ
@
ΖBΪ  	ΕΖ Bά ΘΒ @Γ   H FΓ C Θ FΓ I ΓD  ΓDHD ΑΘ  I Ε  @ ΕI ^  α   χ‘  ΐτ!   ρα  ο‘   ξ^          lotatc_mutils_get_mid    DCS    getCurrentMission    mission 
   coalition    plane    helicopter    pairs    country    group    units    unitId 	   callsign    type    number 	   tostring    name    gsub    (%w+)(%d)(%d) 	   %1 %2-%3    onboard_num                             