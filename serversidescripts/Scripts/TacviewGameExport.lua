-- Tacview ACMI - Universal Flight Analysis Tool 1.7.6
-- Flight Data Recorder for DCS World Export LUA Environment
-- Copyright (C) 2006-2018 - Raia Software Inc.
-- All rights reserved.

do
	if isTacviewModuleInitialized~=true then

		-- Protection against multiple references (typically wrong script installation)

		isTacviewModuleInitialized=true;

		-- Load Tacview DLL from Saved Games folder

		local tacviewModPath = lfs.writedir()..'Mods\\tech\\Tacview\\bin\\'
		package.cpath = package.cpath..';'..tacviewModPath..'?.dll;'
		log.write('TACVIEW.EXPORT.LUA',log.INFO,'Loading C++ flight data recorder from ['..tacviewModPath..']')

		local status,tacview = pcall(require,'tacview')

		-- Load Tacview DLL from Tacview installation folder
		-- (failsafe in case of Unicode characters in Saved Games path)

		if not status then

			tacviewModPath = os.getenv('TACVIEW_DCS2ACMI_PATH')..'Mods\\tech\\Tacview\\bin\\'
			package.cpath = package.cpath..';'..tacviewModPath..'?.dll;'
			log.write('TACVIEW.EXPORT.LUA',log.INFO,'Loading C++ flight data recorder from ['..tacviewModPath..']')

			status,tacview = pcall(require,'tacview')

		end

		-- Register Callbacks in DCS World Export environment

		local tacviewName = 'Tacview 1.8.6.201 C++ flight data recorder';

		if status then

			-- (Hook) Called once right before mission start.
			do
				local PrevLuaExportStart=LuaExportStart;

				LuaExportStart=function()

					tacview.ExportStart()

					if PrevLuaExportStart then
						PrevLuaExportStart();
					end
				end
			end

			-- (Hook) Called right after every simulation frame.
			do
				local PrevLuaExportAfterNextFrame=LuaExportAfterNextFrame;

				LuaExportAfterNextFrame=function()

					-- log.info(string.format("LUA heap size: %d KiB",collectgarbage("count")));

					tacview.ExportUpdate()

					if PrevLuaExportAfterNextFrame then
						PrevLuaExportAfterNextFrame();
					end
				end
			end

			-- (Hook) Called right after mission end.
			do
				local PrevLuaExportStop=LuaExportStop;

				LuaExportStop=function()

					tacview.ExportStop()

					if PrevLuaExportStop then
						PrevLuaExportStop();
					end
				end
			end

			log.write('TACVIEW.EXPORT.LUA',log.INFO,tacviewName..' successfully loaded.')

		-- Failed to load Tacview DLL

		else

			log.write('TACVIEW.EXPORT.LUA',log.ERROR,'Failed to load '..tacviewName..'.')
			tacview = nil

		end
	end
end
