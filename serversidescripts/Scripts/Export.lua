-- Data export script for DCS, version 1.2.
-- Copyright (C) 2006-2014, Eagle Dynamics.
-- See http://www.lua.org for Lua script system info 
-- We recommend to use the LuaSocket addon (http://www.tecgraf.puc-rio.br/luasocket) 
-- to use standard network protocols in Lua scripts.
-- LuaSocket 2.0 files (*.dll and *.lua) are supplied in the Scripts/LuaSocket folder
-- and in the installation folder of the DCS. 

-- Expand the functionality of following functions for your external application needs.
-- Look into Saved Games\DCS\Logs\dcs.log for this script errors, please.


BIOS = {}; 
BIOS.LuaScriptDir = [[C:\DCS-BIOS\dcs-lua\]]; 
BIOS.PluginDir = [[C:\Users\root\AppData\Roaming/DCS-BIOS/Plugins\]]; 
if lfs.attributes(BIOS.LuaScriptDir..[[BIOS.lua]]) ~= nil then 
dofile(BIOS.LuaScriptDir..[[BIOS.lua]]) 
end --[[DCS-BIOS Automatic Setup]]
pcall(function() local dcsSr=require('lfs');dofile(dcsSr.writedir()..[[Mods\Services\DCS-SRS\Scripts\DCS-SimpleRadioStandalone.lua]]); end,nil);


local Tacviewlfs=require('lfs');dofile(Tacviewlfs.writedir()..'Scripts/TacviewGameExport.lua')
