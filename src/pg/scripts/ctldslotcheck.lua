-- This file literally just does a single set and looks for helicopters to dump into ctld.

hcs = SET_CLIENT:New():FilterCategories("helicopter"):FilterOnce()
hcs:ForEachClient(function(PlayerClient)
  local clientname = PlayerClient:GetName()
  table.insert(ctld.transportPilotNames,clientname)
end)