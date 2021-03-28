--[[
  Full credit for this code goes to FlightControl's MOOSE framework.
  This code allows fully dynamic loading which also allows remote debugging
--]]

env.info('*** CINC INCLUDE START ***')

local base = _G

__CinC = {}

__CinC.Include = function( IncludeFile )
  if not __CinC.Includes[ IncludeFile ] then
    __CinC.Includes[IncludeFile] = IncludeFile
    local f = assert( base.loadfile( lfs.writedir() .. IncludeFile ) )
    if f == nil then
      error ("CINC: Could not load CINC file " .. IncludeFile )
    else
      env.info( "CINC: " .. IncludeFile .. " dynamically loaded." )
      return f()
    end
  end
end

__CinC.Includes = {}
__CinC.Include( 'Scripts/cinc/src/logger.lua' )
__CinC.Include( 'Scripts/cinc/src/server.lua' )
__CinC.Include( 'Scripts/cinc/src/api/get_airbases.lua' )
__CinC.Include( 'Scripts/cinc/src/api/get_markers.lua' )

env.info('*** CINC INCLUDE END ***')