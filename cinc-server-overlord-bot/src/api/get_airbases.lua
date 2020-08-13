local logger = CinCLogger
local world = world
local ipairs = ipairs
local coord = coord
local atmosphere = atmosphere
local math = math
local Airbase = Airbase

local get_airbase = function (airbase)
    local airbase_properties = {}
    airbase_properties["id"] = airbase:getID()
    airbase_properties["name"] = airbase:getName()
    airbase_properties["category"] = airbase:getDesc()['category'] 
    airbase_properties["coalition"] = airbase:getCoalition()
    
    local latitude, longitude, altitude = coord.LOtoLL(airbase:getPoint())   
    airbase_properties["latitude"] = latitude
    airbase_properties["longitude"] = longitude
    airbase_properties["altitude"] = altitude
    
    -- Taken from https://github.com/VEAF/VEAF-Mission-Creation-Tools/blob/master/src/scripts/veaf/veaf.lua#L402 by Zip    

    -- Get wind velocity vector
    local point = airbase:getPoint()
    
    -- Add some height to make sure we don't get 0 AGL because that is ground level which DCS considers invalid.  
    -- Also real world ATIS measures 10 meters up which is handy.
    point.y = point.y + 10
    local windvec3  = atmosphere.getWind(point)
    local direction = math.deg(math.atan2(windvec3.z, windvec3.x))
  
    if direction < 0 then
      direction = direction + 360
    end
  
    -- Convert TO direction to FROM direction. 
    if direction > 180 then
      direction = direction-180
    else
      direction = direction+180
    end
  
    -- Calc 2D strength.
    local strength = math.sqrt((windvec3.x)^2+(windvec3.z)^2)

    airbase_properties["wind_heading"] = direction 
    airbase_properties["wind_speed"] = strength -- m/s

    return airbase_properties
end

local command = function (_)
  logger.info("Command get_airbases called")
  local data = world.getAirbases()
  local result = {}
  for i, airbase in ipairs(data) do
    if airbase:getDesc()['category'] == Airbase.Category.SHIP then
       -- No-op
    else
      result[i] = get_airbase(airbase)
    end
  end
  return result
end

CinCServer.add_command('get_airbases', command)