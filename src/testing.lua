t1 = GROUP:FindByName("REW 12")
t2 = GROUP:FindByName("RSAM 12")
t3 = GROUP:FindByName("RSAM 13")


if t1:IsAlive() ~= true then
  BASE:E({"T1 is Nil"})
else
  
  BASE:E({"T1 is not nil"})
end

if GROUP:FindByName("RSAM 12"):IsAlive() ~= true then
  BASE:E({"T2 is Nil"})
else
  BASE:E({"T2 is not nil"})
end


if GROUP:FindByName("RSAM 13"):IsAlive() ~= true then
  BASE:E({"T3 is Nil"})
else
  BASE:E({"T3 is not nil"})
end