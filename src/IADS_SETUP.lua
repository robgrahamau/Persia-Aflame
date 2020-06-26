
BASE:E{"IADS SCRIPT IRAN"}
IRANAWACSTOTAL = 4

-- Basic Set up of our IADS network

IranIADS = SkynetIADS:create('Iran')


BASE:E{"IADS SCRIPT STATICS"}
-- Our Power Sources.

local IcommandCenterPowerSource1 = StaticObject.getByName("Iran Power Main 1")
local IcommandCenterPowerSource2 = StaticObject.getByName("Iran Power Main 2")
local IcommandCenterPowerSource3 = StaticObject.getByName("Iran Power Main 3")
local IcommandCenterPowerSource4 = StaticObject.getByName("Iran Power Main 4")
local IcommandCenterPowerSource5 = StaticObject.getByName("Iran Power Main 5")
local IcommandCenterPowerSource6 = StaticObject.getByName("Iran Power Main 6")  
local IcommandCenter2PowerSource1 = StaticObject.getByName("Iran Power West Main 1")
local IcommandCenter2PowerSource2 = StaticObject.getByName("Iran Power West Main 2")
local IcommandCenter2PowerSource3 = StaticObject.getByName("Iran Power West Main 3")
local IcommandCenter2PowerSource4 = StaticObject.getByName("Iran Power West Main 4")
local IcommandCenter2PowerSource5 = StaticObject.getByName("Iran Power West Main 5")
local IcommandCenter2PowerSource6 = StaticObject.getByName("Iran Power West Main 6")
local IBandarAbbasPower1 = StaticObject.getByName("Iran Power South")
local IBandarAbbasPower2 = StaticObject.getByName("Iran Power South 1")
local IQueshmPower1 = StaticObject.getByName("Iran Power Queshm")
local IBandarLengehPower1 = StaticObject.getByName("Iran Power Bandar Lengeh")
local ISouthWestPower1 = StaticObject.getByName("Iran Power South West")
local ISouthWestPower2 = StaticObject.getByName("Iran Power South West2")
local IEastPower1 = StaticObject.getByName("Iran Power East")
local INorthPower = StaticObject.getByName("Iran Power North")
local IBandarPower = StaticObject.getByName("Iran Power Bandar")
local IBanderPower2 = StaticObject.getByName("Iran Power Bandar 2")
BASE:E{"IADS NODES"}
-- Our Nodes
-- lets make our nodes 
-- Radio Nodes First.
local IsouthWestNode = StaticObject.getByName("Iran Node South West")
local IsouthWestGroundNode = StaticObject.getByName("Iran Node West Ground")
local IsouthNode = StaticObject.getByName("Iran Node South")
local IsouthGroundNode = StaticObject.getByName("Iran Node South Ground")
local IsouthEastNode = StaticObject.getByName("Iran Node South East")
local ISouthEastGroundNode = StaticObject.getByName("Iran Node South East Ground")
local IBanderNode = StaticObject.getByName("Iran Node Bandar")
local IBanderNode2 = StaticObject.getByName("Iran Node Bandar 2")
local IBanderNode3 = StaticObject.getByName("Iran Node Bandar 3")
BASE:E{"COMMAND CENTER"}
local IcommandCenter = StaticObject.getByName("Iran C3 North")
-- add the Kerman C3 Center.
IranIADS:addCommandCenter(IcommandCenter):addPowerSource(IcommandCenterPowerSource1):addPowerSource(IcommandCenterPowerSource2):addPowerSource(IcommandCenterPowerSource3):addPowerSource(IcommandCenterPowerSource4):addPowerSource(IcommandCenterPowerSource5):addPowerSource(IcommandCenterPowerSource6)
-- Shiraz
local IcommandCenter2 = StaticObject.getByName("Iran C3 West")
IranIADS:addCommandCenter(IcommandCenter2):addPowerSource(IcommandCenter2PowerSource1):addPowerSource(IcommandCenter2PowerSource2):addPowerSource(IcommandCenter2PowerSource3):addPowerSource(IcommandCenter2PowerSource4):addPowerSource(IcommandCenter2PowerSource5)
local IcommandCenter3 = StaticObject.getByName("Iran C3 South")
IranIADS:addCommandCenter(IcommandCenter3):addPowerSource(IBandarPower):addPowerSource(IBanderPower2):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3)
BASE:E{"SA15's"}
-- Point Defense Systems (SA-15s)
if GROUP:FindByName("RSAM Bander Abbas SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite(  'RSAM Bander Abbas SA-15-1'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM Bander Abbas SA-15-2"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Bander Abbas SA-15-2'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM Bander Abbas SA-15-3"):IsAlive() == true then
IranIADS:addSAMSite('RSAM Bander Abbas SA-15-3'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM Bander Abbas SA-15-4"):IsAlive() == true then
IranIADS:addSAMSite('RSAM Bander Abbas SA-15-4'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM East SA-15-1"):IsAlive() == true then
IranIADS:addSAMSite('RSAM East SA-15-1'):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode)
end

if GROUP:FindByName("RSAM East SA-15-2"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM East SA-15-2'):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode)
end

if GROUP:FindByName("RSAM Qeshm SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Qeshm SA-15-1'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM Bandar Lengeh SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Bandar Lengeh SA-15-1'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM Kish SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Kish SA-15-1'):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
end

if GROUP:FindByName("RSAM West SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM West SA-15-1'):addConnectionNode(IsouthNode):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode)
end

if GROUP:FindByName("RSAM West SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite("RSAM West SA-15-1"):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode)
end

if GROUP:FindByName("RSAM Kerman SA-15-1"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Kerman SA-15-1')
end

if GROUP:FindByName("RSAM Kerman SA-15-2"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Kerman SA-15-2')
end

if GROUP:FindByName("RSAM Bandar SA-15"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Bandar SA-15'):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3)
end

if GROUP:FindByName("RSAM Bandar SA-15_2"):IsAlive() == true then
  IranIADS:addSAMSite('RSAM Bandar SA-15_2'):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3)
end
-- Early Warning Radar Systems
BASE:E{"EW's"}
local pds = nil
if GROUP:FindByName("RSAM Bandar SA-15_2"):IsAlive() == true then
  local pds = IranIADS:getSAMSiteByGroupName('RSAM Bander Abbas SA-15-1')
end

if GROUP:FindByName("REW South Bandar Abbas"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW South Bandar Abbas"):addPowerSource(IBandarAbbasPower1):addPowerSource(IBandarAbbasPower2):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW South Bandar Abbas"):addPowerSource(IBandarAbbasPower1):addPowerSource(IBandarAbbasPower2):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end  
end

pds = nil
if GROUP:FindByName("RSAM Qeshm SA-15-1"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Qeshm SA-15-1')
end

if GROUP:FindByName("REW South Qeshm"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW South Qeshm"):addPowerSource(IQueshmPower1):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW South Qeshm"):addPowerSource(IQueshmPower1):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end
pds = nil

if GROUP:FindByName('RSAM Bandar Lengeh SA-15-1'):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Bandar Lengeh SA-15-1')
end

if GROUP:FindByName("REW Bandar Lengeh"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW Bandar Lengeh"):addPowerSource(IBandarLengehPower1):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW Bandar Lengeh"):addPowerSource(IBandarLengehPower1):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end

pds = nil
if GROUP:FindByName('RSAM Kish SA-15-1'):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Kish SA-15-1')
end

if GROUP:FindByName("REW South Kish Island"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW South Kish Island"):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW South Kish Island"):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end

pds = nil 
if GROUP:FindByName('RSAM West SA-15-1'):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM West SA-15-1')
end

if GROUP:FindByName("REW West"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW West"):addPowerSource(ISouthWestPower1):addPowerSource(ISouthWestPower2):addConnectionNode(IsouthWestNode):addConnectionNode(IsouthWestGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW West"):addPowerSource(ISouthWestPower1):addPowerSource(ISouthWestPower2):addConnectionNode(IsouthWestNode):addConnectionNode(IsouthWestGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end

if GROUP:FindByName("REW West Far"):IsAlive() == true then
  IranIADS:addEarlyWarningRadar("REW West Far"):addPowerSource(ISouthWestPower1):addPowerSource(IcommandCenter2PowerSource4):addConnectionNode(IsouthWestNode):addConnectionNode(IsouthWestGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
end

pds = nil
if GROUP:FindByName("RSAM East SA-15-1"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM East SA-15-1')
end

if GROUP:FindByName("REW East"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW East"):addPowerSource(IEastPower1):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW East"):addPowerSource(IEastPower1):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end

pds = nil
if GROUP:FindByName("RSAM East Jiroft SA-15-1"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM East Jiroft SA-15-1')
end

if GROUP:FindByName("REW East Jiroft"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("REW East Jiroft"):addPowerSource(IEastPower1):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("REW East Jiroft"):addPowerSource(IEastPower1):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end
pds = nil

if GROUP:FindByName("RSAM Kerman SA-15-1"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Kerman SA-15-1')
end

if GROUP:FindByName("REW North"):IsAlive() == true then
 if pds ~= nil then
  IranIADS:addEarlyWarningRadar("REW North"):addPowerSource(IcommandCenterPowerSource5):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
 else
  IranIADS:addEarlyWarningRadar("REW North"):addPowerSource(IcommandCenterPowerSource5):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
 end
end

if GROUP:FindByName("REW West Shiraz"):IsAlive() == true then
  IranIADS:addEarlyWarningRadar("REW West Shiraz"):addPowerSource(IcommandCenter2PowerSource6)
end

pds = nil 
if GROUP:FindByName("RSAM East SA-15-2"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM East SA-15-2')
end

if GROUP:FindByName("RSAM East Far SA-10"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addEarlyWarningRadar("RSAM East Far SA-10"):addPowerSource(IEastPower1):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  else
    IranIADS:addEarlyWarningRadar("RSAM East Far SA-10"):addPowerSource(IEastPower1):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
end

BASE:E{"SA15's"}
-- Fixed Long Range Sam Systems
pds = nil 
if GROUP:FindByName("RSAM Bander Abbas SA-15-2"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Bander Abbas SA-15-2')
end
if GROUP:FindByName("RSAM South Bandar Abbas SA-2"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addSAMSite('RSAM South Bandar Abbas SA-2'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setGoLiveRangeInPercent(120)
  else
    IranIADS:addSAMSite('RSAM South Bandar Abbas SA-2'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):setGoLiveRangeInPercent(120)
  end
end

pds = nil 
if GROUP:FindByName("RSAM Bander Abbas SA-15-3"):IsAlive() == true then 
  pds = IranIADS:getSAMSiteByGroupName('RSAM Bander Abbas SA-15-3')
end
if GROUP:FindByName("RSAM South Bandar SA-10"):IsAlive() then
  if pds ~= nil then
    IranIADS:addSAMSite('RSAM South Bandar SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true)
  else
    IranIADS:addSAMSite('RSAM South Bandar SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
  end
end

pds = nil 
if GROUP:FindByName("RSAM Bander Abbas SA-15-4"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Bander Abbas SA-15-4')
end
if GROUP:FindByName("RSAM South SA-10"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addSAMSite('RSAM South SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true)
  else
    IranIADS:addSAMSite('RSAM South SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)    
  end  
end  

IranIADS:addSAMSite('RSAM South Bandar SA-2'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):setGoLiveRangeInPercent(120)

pds = nil
if GROUP:FindByName("RSAM East SA-15-2"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM East SA-15-2')
end
if GROUP:FindByName("RSAM East Far SA-10"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addSAMSite('RSAM East Far SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true)
  else
    IranIADS:addSAMSite('RSAM East Far SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthEastNode):addConnectionNode(ISouthEastGroundNode)
  end
end
pds = nil
if GROUP:FindByName("RSAM Kerman SA-15-2"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Kerman SA-15-2')
end
if GROUP:FindByName("RSAM North Kerman SA-10"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addSAMSite('RSAM North Kerman SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true)
  else
    IranIADS:addSAMSite('RSAM North Kerman SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
  end
end
pds = nil
if GROUP:FindByName("RSAM Bandar SA-15"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Bandar SA-15')
end
if GROUP:FindByName("RSAM Bandar SA-11"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addSAMSite("RSAM Bandar SA-11"):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setGoLiveRangeInPercent(120)
  else
    IranIADS:addSAMSite("RSAM Bandar SA-11"):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3):setGoLiveRangeInPercent(120)
  end
end
pds = nil 
if GROUP:FindByName("RSAM Bandar SA-15_2"):IsAlive() == true then
  pds = IranIADS:getSAMSiteByGroupName('RSAM Bandar SA-15_2')
end
if GROUP:FindByName("RSAM Bandar SA-6"):IsAlive() == true then
  if pds ~= nil then
    IranIADS:addSAMSite("RSAM Bandar SA-6"):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true):setGoLiveRangeInPercent(120)
  else
    IranIADS:addSAMSite("RSAM Bandar SA-6"):addConnectionNode(IBanderNode):addConnectionNode(IBanderNode2):addConnectionNode(IBanderNode3):setIgnoreHARMSWhilePointDefencesHaveAmmo(true)
  end
end


IranIADS:activate()
iadsdb = false
function IADSDB()
  if iadsdb == false then
    IranIADS:addRadioMenu()
    local iadsDebug = IranIADS:getDebugSettings()  
    iadsDebug.IADSStatus = true
    iadsDebug.samWentDark = true
    iadsDebug.contacts = true
    iadsDebug.radarWentLive = true
    iadsDebug.ewRadarNoConnection = true
    iadsDebug.samNoConnection = true
    iadsDebug.jammerProbability = true
    iadsDebug.addedEWRadar = true
    iadsDebug.hasNoPower = true
    iadsDebug.addedSAMSite = true
    iadsDebug.warnings = true
    iadsDebug.harmDefence = true
    iadsDebug.samSiteStatusEnvOutput = true
    iadsDebug.earlyWarningRadarStatusEnvOutput = true
    iadsdb = true
  else
    IranIADS:removeRadioMenu()
    local iadsDebug = IranIADS:getDebugSettings()  
    iadsDebug.IADSStatus = false
    iadsDebug.samWentDark = false
    iadsDebug.contacts = false
    iadsDebug.radarWentLive = false
    iadsDebug.ewRadarNoConnection = false
    iadsDebug.samNoConnection = false
    iadsDebug.jammerProbability = false
    iadsDebug.addedEWRadar = false
    iadsDebug.hasNoPower = false
    iadsDebug.addedSAMSite = false
    iadsDebug.warnings = false
    iadsDebug.harmDefence = false
    iadsDebug.samSiteStatusEnvOutput = false
    iadsDebug.earlyWarningRadarStatusEnvOutput = false
    iadsdb = false
  end
end


