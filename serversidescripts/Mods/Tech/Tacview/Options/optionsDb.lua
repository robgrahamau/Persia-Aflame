local DbOption = require("Options.DbOption")
local i18n = require('i18n')

-- Constants

local TACVIEW_DO_NOT_RECORD_ANY_DATA					= _("Do not record any data")
local TACVIEW_RECORD_LOCAL_PLAYER_ONLY					= _("Record local player only")
local TACVIEW_RECORD_ALL_AVAILABLE_DATA					= _("Record all available data")
local TACVIEW_RECORD_ONE_FILE_PER_CLIENT				= _("Record one file per client")

local TACVIEW_DEBUG_MODE_NONE							= _("Disabled (default)")
local TACVIEW_DEBUG_MODE_MINIMAL						= _("Minimal")
local TACVIEW_DEBUG_MODE_FULL							= _("Full ")			-- WARNING: NOT A TYPO. I HAVE ADDED A SPACE TO GET A UNIQUE "ID", OTHERWISE I GOT (INCORRECT) TRANSLATION FROM OTHER ADDONS.

local TACVIEW_TERRAIN_EXPORT_DISABLED					= _("Disabled (default)")
local TACVIEW_TERRAIN_EXPORT_PREDEFINED					= _("Predefined Terrain")
local TACVIEW_TERRAIN_EXPORT_UNKNOWN					= _("Unknown Terrain")

local TACVIEW_AUTO_DISCARD_FLIGHTS_NEVER				= _("never")
local TACVIEW_AUTO_DISCARD_FLIGHTS_SHORTER_THAN_10_SEC	= _("shorter than 10 sec (default)")
local TACVIEW_AUTO_DISCARD_FLIGHTS_SHORTER_THAN_1_MIN	= _("shorter than 1 min")
local TACVIEW_AUTO_DISCARD_FLIGHTS_SHORTER_THAN_5_MIN	= _("shorter than 5 min")

-- Local variables

local tacviewConfigDialog = nil

-- Update UI

local function UpdateOptions()

	-- Check parameters

	if tacviewConfigDialog == nil then
		return
	end

	local moduleEnabled = tacviewConfigDialog.tacviewModuleEnabledCheckbox:getState()

	-- Flight Data Recording

	local flightDataRecordingEnabled = tacviewConfigDialog.tacviewFlightDataRecordingEnabledCheckbox:getState()

	tacviewConfigDialog.tacviewFlightDataRecordingTitle:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewFlightDataRecordingEnabledCheckbox:setEnabled(moduleEnabled)

	tacviewConfigDialog.tacviewSinglePlayerFlightsLabel:setEnabled(moduleEnabled and flightDataRecordingEnabled)
	tacviewConfigDialog.tacviewSinglePlayerFlightsComboList:setEnabled(moduleEnabled and flightDataRecordingEnabled)

	tacviewConfigDialog.tacviewMultiplayerFlightsAsClientLabel:setEnabled(moduleEnabled and flightDataRecordingEnabled)
	tacviewConfigDialog.tacviewMultiplayerFlightsAsClientComboList:setEnabled(moduleEnabled and flightDataRecordingEnabled)

	tacviewConfigDialog.tacviewMultiplayerFlightsAsHostLabel:setEnabled(moduleEnabled and flightDataRecordingEnabled)
	tacviewConfigDialog.tacviewMultiplayerFlightsAsHostComboList:setEnabled(moduleEnabled and flightDataRecordingEnabled)

	tacviewConfigDialog.tacviewBookmarkShortcutLabel:setEnabled(moduleEnabled and flightDataRecordingEnabled)
	tacviewConfigDialog.tacviewBookmarkShortcutComboList:setEnabled(moduleEnabled and flightDataRecordingEnabled)

	tacviewConfigDialog.tacviewAutoDiscardFlightsLabel:setEnabled(moduleEnabled and flightDataRecordingEnabled)
	tacviewConfigDialog.tacviewAutoDiscardFlightsComboList:setEnabled(moduleEnabled and flightDataRecordingEnabled)

	-- Advanced Options

	tacviewConfigDialog.tacviewAdvancedOptionsTitle:setEnabled(moduleEnabled)

	tacviewConfigDialog.tacviewDebugModeLabel:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewDebugModeComboList:setEnabled(moduleEnabled)

	-- Tools

	local terrainExportValue = tacviewConfigDialog.tacviewTerrainExportComboList:getSelectedItem()

	tacviewConfigDialog.tacviewToolsTitle:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewTerrainExportLabel:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewTerrainExportComboList:setEnabled(moduleEnabled)

	tacviewConfigDialog.tacviewTerrainExportWarning:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewTerrainExportWarning:setVisible(terrainExportValue.value ~= 0)
	tacviewConfigDialog.tacviewTerrainExportWarning2:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewTerrainExportWarning2:setVisible(terrainExportValue.value ~= 0)

	-- Real-Time Telemetry

	local realTimeTelemetryEnabled = tacviewConfigDialog.tacviewRealTimeTelemetryEnabledCheckbox:getState()

	tacviewConfigDialog.tacviewRealTimeTelemetryTitle:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewRealTimeTelemetryEnabledCheckbox:setEnabled(moduleEnabled)

	tacviewConfigDialog.tacviewRealTimeTelemetryPortLabel:setEnabled(moduleEnabled and realTimeTelemetryEnabled)
	tacviewConfigDialog.tacviewRealTimeTelemetryPortEditBox:setEnabled(moduleEnabled and realTimeTelemetryEnabled)

	tacviewConfigDialog.tacviewRealTimeTelemetryPasswordLabel:setEnabled(moduleEnabled and realTimeTelemetryEnabled)
	tacviewConfigDialog.tacviewRealTimeTelemetryPasswordEditBox:setEnabled(moduleEnabled and realTimeTelemetryEnabled)

	tacviewConfigDialog.tacviewRealTimeTelemetryPasswordHelp:setEnabled(moduleEnabled and realTimeTelemetryEnabled)

	-- Remote Control

	local remoteControlEnabled = tacviewConfigDialog.tacviewRemoteControlEnabledCheckbox:getState()

	tacviewConfigDialog.tacviewRemoteControlTitle:setEnabled(moduleEnabled)
	tacviewConfigDialog.tacviewRemoteControlEnabledCheckbox:setEnabled(moduleEnabled)

	tacviewConfigDialog.tacviewRemoteControlPortLabel:setEnabled(moduleEnabled and remoteControlEnabled)
	tacviewConfigDialog.tacviewRemoteControlPortEditBox:setEnabled(moduleEnabled and remoteControlEnabled)

	tacviewConfigDialog.tacviewRemoteControlPasswordLabel:setEnabled(moduleEnabled and remoteControlEnabled)
	tacviewConfigDialog.tacviewRemoteControlPasswordEditBox:setEnabled(moduleEnabled and remoteControlEnabled)

end

-- Callbacks

local function OnShowDialog(dialogBox)

	-- Setup local variables

	if tacviewConfigDialog ~= dialogBox then
		tacviewConfigDialog = dialogBox
	end

	-- Update dialog box state

	UpdateOptions()

end

-- Module on/off

local tacviewModuleEnabled = DbOption.new():setValue(true):checkbox()
:callback(function(value)
	UpdateOptions()
end)

-- Flight Data Recording

local tacviewFlightDataRecordingEnabled = DbOption.new():setValue(true):checkbox()
:callback(function(value)
	UpdateOptions()
end)

local tacviewSinglePlayerFlights = DbOption.new():setValue(2):combo({
										DbOption.Item(TACVIEW_DO_NOT_RECORD_ANY_DATA):Value(0),
										DbOption.Item(TACVIEW_RECORD_LOCAL_PLAYER_ONLY):Value(1),
										DbOption.Item(TACVIEW_RECORD_ALL_AVAILABLE_DATA):Value(2),
										})

local tacviewMultiplayerFlightsAsClient = DbOption.new():setValue(2):combo({
										DbOption.Item(TACVIEW_DO_NOT_RECORD_ANY_DATA):Value(0),
										DbOption.Item(TACVIEW_RECORD_LOCAL_PLAYER_ONLY):Value(1),
										DbOption.Item(TACVIEW_RECORD_ALL_AVAILABLE_DATA):Value(2),
										})

local tacviewMultiplayerFlightsAsHost = DbOption.new():setValue(2):combo({
										DbOption.Item(TACVIEW_DO_NOT_RECORD_ANY_DATA):Value(0),
										DbOption.Item(TACVIEW_RECORD_LOCAL_PLAYER_ONLY):Value(1),
										DbOption.Item(TACVIEW_RECORD_ALL_AVAILABLE_DATA):Value(2),
										DbOption.Item(TACVIEW_RECORD_ONE_FILE_PER_CLIENT):Value(3),
										})

local tacviewBookmarkShortcut = DbOption.new():setValue(0):combo({
										DbOption.Item(_("RAlt + B")):Value(0),
										DbOption.Item(_("`")):Value(1),
										DbOption.Item(_("²")):Value(2),
										})

local tacviewAutoDiscardFlights = DbOption.new():setValue(10):combo({
										DbOption.Item(TACVIEW_AUTO_DISCARD_FLIGHTS_NEVER):Value(0),
										DbOption.Item(TACVIEW_AUTO_DISCARD_FLIGHTS_SHORTER_THAN_10_SEC):Value(10),
										DbOption.Item(TACVIEW_AUTO_DISCARD_FLIGHTS_SHORTER_THAN_1_MIN):Value(60),
										DbOption.Item(TACVIEW_AUTO_DISCARD_FLIGHTS_SHORTER_THAN_5_MIN):Value(300),
										})

-- Advanced Options

local tacviewDebugMode = DbOption.new():setValue(0):combo({
										DbOption.Item(TACVIEW_DEBUG_MODE_NONE):Value(0),
										DbOption.Item(TACVIEW_DEBUG_MODE_MINIMAL):Value(1),
										DbOption.Item(TACVIEW_DEBUG_MODE_FULL):Value(2),
										})

-- Tools

local tacviewTerrainExport = DbOption.new():setValue(0):combo({
										DbOption.Item(TACVIEW_TERRAIN_EXPORT_DISABLED):Value(0),
										DbOption.Item(TACVIEW_TERRAIN_EXPORT_PREDEFINED):Value(1),
										DbOption.Item(TACVIEW_TERRAIN_EXPORT_UNKNOWN):Value(2),
										})
:callback(function(value)
	UpdateOptions()
end)

-- Real-Time Telemetry

local tacviewRealTimeTelemetryEnabled = DbOption.new():setValue(true):checkbox()
:callback(function(value)
	UpdateOptions()
end)

local tacviewRealTimeTelemetryPort = DbOption.new():setValue("42674"):editbox()
local tacviewRealTimeTelemetryPassword = DbOption.new():setValue(""):editbox()

-- Remote Control

local tacviewRemoteControlEnabled = DbOption.new():setValue(false):checkbox()
:callback(function(value)
	UpdateOptions()
end)

local tacviewRemoteControlPort = DbOption.new():setValue("42675"):editbox()
local tacviewRemoteControlPassword = DbOption.new():setValue(""):editbox()

-- Returns dialog box controls and callbacks

return
{
	-- Events

	callbackOnShowDialog  				= OnShowDialog,

	-- Module on/off

	tacviewModuleEnabled				= tacviewModuleEnabled,

	-- Flight Data Recording

	tacviewFlightDataRecordingEnabled	= tacviewFlightDataRecordingEnabled,
	tacviewSinglePlayerFlights			= tacviewSinglePlayerFlights,
	tacviewMultiplayerFlightsAsClient	= tacviewMultiplayerFlightsAsClient,
	tacviewMultiplayerFlightsAsHost		= tacviewMultiplayerFlightsAsHost,
	tacviewBookmarkShortcut				= tacviewBookmarkShortcut,
	tacviewAutoDiscardFlights			= tacviewAutoDiscardFlights,

	-- Advanced Options

	tacviewDebugMode					= tacviewDebugMode,

	-- Tools

	tacviewTerrainExport				= tacviewTerrainExport,

	-- Real-Time Telemetry

	tacviewRealTimeTelemetryEnabled		= tacviewRealTimeTelemetryEnabled,
	tacviewRealTimeTelemetryPort		= tacviewRealTimeTelemetryPort,
	tacviewRealTimeTelemetryPassword	= tacviewRealTimeTelemetryPassword,

	-- Remote Control

	tacviewRemoteControlEnabled			= tacviewRemoteControlEnabled,
	tacviewRemoteControlPort			= tacviewRemoteControlPort,
	tacviewRemoteControlPassword		= tacviewRemoteControlPassword,
}
