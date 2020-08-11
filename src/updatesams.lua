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
      if type == "S-300PS 40B6M tr" then
        hastr = true
      elseif type == "S-300PS 64H6E sr" then
        hassr = true
      end
    end
  end
  if hastr == true and hassr == true then
    BASE:E({"Track & Search Radar exists we all good"})
  else
  _unittable={}
    local sr = 
    {
        ["type"] = "S-300PS 64H6E sr",
        ["transportable"] = true,
        ["unitID"] = "150",
        ["skill"] = "Average",
        ["y"] = 19571.652343795,
        ["x"] = 121668.07031262,
        ["name"] = "RSAM South Bandar SA-10",
        ["playerCanDrive"] = true,
        ["heading"] = 200.00000008127,
    }
    for i = 1, size do
      if grp:GetUnit(i):IsAlive() == true then
        local tmpTable =
        {   
          ["type"]=grp:GetUnit(i):GetTypeName(),
          ["transportable"]=true,
          ["unitID"]=grp:GetUnit(i):GetID(),
          ["skill"]="Average",
          ["y"]=grp:GetUnit(i):GetVec2().y,
          ["x"]=grp:GetUnit(i):GetVec2().x,
          ["name"]=grp:GetUnit(i):GetName(),
          ["playerCanDrive"]=true,
          ["heading"]=grp:GetUnit(i):GetHeading(),
        }
        table.insert(_unittable,tmpTable) --add units to a temporary table
    end
  end
  end  
end