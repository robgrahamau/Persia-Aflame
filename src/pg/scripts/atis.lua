BASE:E({"Persia ATIS"})
hm("> Initalising ATIS ")
SRSPath = "E:\\DCS-SimpleRadio-Standalone"
ratis = false
if ratis == true then 

atismin = ATIS:New(AIRBASE.PersianGulf.Al_Minhad_AB,118.750,0)
atismin:SetTowerFrequencies({118.550,38.500,250.100,3.800})
atismin:SetTACAN(99)
atismin:AddILS(110.75,"27")
atismin:AddILS(110.70,"09")
atismin:SetSRS(SRSPATH,"male","en-US",nil,5002)
atismin:Start()


atisda = ATIS:New(AIRBASE.PersianGulf.Al_Dhafra_AB,126.750,0)
atisda:SetTowerFrequencies({126.500,39.500,210.100,4.300})
atisda:SetTACAN(96)
atisda:AddILS(111.10,"13L")
atisda:AddILS(108.70,"13R")
atisda:AddILS(108.70,"31L")
atisda:AddILS(109.10,"31R")
atisda:SetSRS(SRSPATH,"female","en-US",nil,5002)
atisda:Start()

BASE:E({"Persia ATIS - Done"})
hm("> Initalising ATIS - Minhad 118.750, Dhafra 126.750")

else
	hm("> We are Not initalised due to issues")
end

BASE:E({"Persia ATIS - Done"})
hm("> Initalising ATIS - Minhad 118.750, Dhafra 126.750")
