
BASE:E({"SAM INITALIZING"})
redsams = SET_GROUP:New():FilterPrefixes({"IAA SAM","IAA EW","RSAM","REW"}):FilterActive(true):FilterStart()
rmantis = MANTIS:New("Iran MANTIS","IAA SAM","IAA EW",nil,"red",true)
rmantis:Start()
rshorad = SHORAD:New("Iran Shorad","IAA Shorad",redsams,UTILS.NMToMeters(15),600,"red")
rmantis:AddShorad(rshorad,600)
 
 