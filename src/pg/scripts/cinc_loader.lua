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
    local f = assert( base.loadfile( IncludeFile ) )
    if f == nil then
      error ("CINC: Could not load CINC file " .. IncludeFile )
    else
      env.info( "CINC: " .. IncludeFile .. " dynamically loaded." )
      return f()
    end
  end
end

__CinC.Includes = {}
__CinC.Include( lfs.writedir() .. "Scripts\\cinc\\src\\logger.lua" )
__CinC.Include( lfs.writedir() .. "Scripts\\cinc\\src\\server.lua" )
__CinC.Include( lfs.writedir() .. "Scripts\\cinc\\src\\get_airbases.lua" )

env.info('*** CINC INCLUDE END ***')