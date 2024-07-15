-- This file literally just does a single set and looks for helicopters to dump into ctld.
-- Edit: We start to do more checks now, we need to go through the client list and check if the name exists
-- if it does we just continue on else 
-- we need to add it.



hcs = SET_CLIENT:New():FilterCategories("helicopter"):FilterStart()



function checkfornewctld()
 
 
  hcs:ForEachClient(function(PlayerClient)
    clientfound = false
    local clientname = PlayerClient:GetName()
    BASE:E({"client check",clientname})
    for k, v in pairs(ctld.transportPilotNames) do
      if v == clientname then
        clientfound = true      
      end
    end  
    if clientfound == false then
      BASE:E({"client check client not found",clientname})
      table.insert(ctld.transportPilotNames,clientname)
    end
  end)
end



SCHEDULER:New(nil,function() checkfornewctld() end,nil,30,30)
