--- updates sam sites ---

if GROUP:FindByName("RSAM South Bandar SA-10"):IsAlive() then
  local grp = GROUP:FindByName("RSAM South Bandar SA-10")
  local DCSgroup = Group.getByName("RSAM South Bandar SA-10")
  local size = DCSgroup:getSize()
  
  local hastr = false
  local hassr = false
  for i = 1, size do
    if grp:GetUnit(i):IsAlive() == true then
      local type = grp:GetUnit(i):GetTypeName()
      BASE:E({"Type:",type})
      if type == "SAM SA-10 S-300PS TR 30N6" then
        hastr = true
      elseif type == "SAM SA-10 S-300PS SR 64H6E" then
        hassr = true
      end
    end
    if hastr == true and hassr == true then
      BASE:E({"Track & Search Radar exists we all good"})
    else
      BASE:E({"RSAM South Bandar SA-10 Missing a Search or Track Radar but still exists."})
      if size > 1 then
        BASE:E("RSAM South Bandar had more then 1 unit, it's been reinforced.")
        grp:Destroy()
        SPAWN:NewWithAlias(TEMP_SA10,"RSAM South Bandar SA-10"):InitRandomizeUnits(true,100,20):OnSpawnGroup(function(spawngroup) 
          local pds = nil
          if GROUP:FindByName("RSAM Bander Abbas SA-15-3"):IsAlive() == true then 
            pds = IranIADS:getSAMSiteByGroupName('RSAM Bander Abbas SA-15-3')
          end
          if pds ~= nil then
            IranIADS:addSAMSite('RSAM South Bandar SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode):addPointDefence(pds):setIgnoreHARMSWhilePointDefencesHaveAmmo(true)
          else
            IranIADS:addSAMSite('RSAM South Bandar SA-10'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE):addConnectionNode(IsouthNode):addConnectionNode(IsouthGroundNode)
          end
        end):Spawn()
      end
    end
  end
end