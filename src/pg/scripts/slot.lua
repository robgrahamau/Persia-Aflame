-- Airbases
ALLSLOTS={}
REDNOSLOTS = { "F-15ESE", "AH-64D_BLK_II", "F-15C","F/A-18C","A-10C_2","FA-18C_hornet","A-10C","A-10A","F-14B","OH-58D","AJS37","AV8BNA",}

BASE:E({"5"})
abudbslots = slothandler:New("Abu Dhabi Intl",2,"AbuDhabi")
abudbslots:SetRedCTLD(180,1400,true,country.id.CJTF_RED)
abudbslots:SetBlueCTLD(170,1700,true,country.id.CJTF_BLUE)
abudbslots:setroutegroups(true,15000)
abudbslots:ActivateCTLD()
abudbslots:SetRedNotAllowed(REDNOSLOTS)
abudbslots:Start()
table.insert(ALLSLOTS,abudbslots)

BASE:E({"15"})
abunuslots = slothandler:New("Sir Abu Nuayr",2,"AbuNu")
abunuslots:SetRedCTLD(320,500,true,country.id.CJTF_RED)
abunuslots:SetBlueCTLD(330,600,true,country.id.CJTF_BLUE)
abunuslots:setroutegroups(true,5000)
abunuslots:ActivateCTLD()
abunuslots:SetRedNotAllowed(REDNOSLOTS)
abunuslots:Start()
table.insert(ALLSLOTS,abunuslots)
BASE:E({"24"})
dhafraslots = slothandler:New("Al Dhafra AFB",2,"Dhafra")
dhafraslots:SetBlueCTLD(090,3000,true,country.id.CJTF_BLUE)
dhafraslots:setroutegroups(true,15000)
dhafraslots:ActivateCTLD()
dhafraslots:Start()
table.insert(ALLSLOTS,dhafraslots)
BASE:E({"31"})
ejaskslots = slothandler:New("Bandar-e-Jask",1,"E-Jask")
ejaskslots:SetRedCTLD(40,1400,true,country.id.CJTF_RED)
ejaskslots:SetBlueCTLD(50,1700,true,country.id.CJTF_BLUE)
ejaskslots:setroutegroups(true,15000)
ejaskslots:ActivateCTLD()
ejaskslots:SetRedNotAllowed(REDNOSLOTS)
ejaskslots:Start()
table.insert(ALLSLOTS,ejaskslots)
BASE:E({"40"})
fujairahslots = slothandler:New("Fujairah Intl",2,"Fujairah")
fujairahslots:SetRedCTLD(180,500,true,country.id.CJTF_RED)
fujairahslots:SetBlueCTLD(200,700,true,country.id.CJTF_BLUE)
fujairahslots:setroutegroups(true,15000)
fujairahslots:ActivateCTLD()
fujairahslots:SetRedNotAllowed(REDNOSLOTS)
fujairahslots:Start()
table.insert(ALLSLOTS,fujairahslots)

havslots = slothandler:New("Havadarya",1,"Havadarya")
havslots:SetRedCTLD(0,1000,true,country.id.CJTF_RED)
havslots:SetBlueCTLD(10,1700,true,country.id.CJTF_BLUE)
havslots:setroutegroups(true,10000)
havslots:ActivateCTLD()
havslots:SetRedNotAllowed(REDNOSLOTS)
havslots:Start()
table.insert(ALLSLOTS,havslots)

jiroftslots = slothandler:New("Jiroft",1,"Jiroft")
jiroftslots:SetRedCTLD(40,500,true,country.id.CJTF_RED)
jiroftslots:SetBlueCTLD(40,800,true,country.id.CJTF_BLUE)
jiroftslots:setroutegroups(true,35000)
jiroftslots:ActivateCTLD()
jiroftslots:SetRedNotAllowed(REDNOSLOTS)
jiroftslots:Start()
table.insert(ALLSLOTS,jiroftslots)

kermanslots = slothandler:New("Kerman",1,"Kerman")
kermanslots:SetRedCTLD(270,2000,true,country.id.CJTF_RED)
kermanslots:SetBlueCTLD(270,2500,true,country.id.CJTF_BLUE)
kermanslots:setroutegroups(true,45000)
kermanslots:ActivateCTLD()
kermanslots:SetRedNotAllowed(REDNOSLOTS)
kermanslots:Start()
table.insert(ALLSLOTS,kermanslots)


khasabslots = slothandler:New("Khasab",2,"Khasab")
khasabslots:SetRedCTLD(140,2200,true,country.id.CJTF_RED)
khasabslots:SetBlueCTLD(140,2000,true,country.id.CJTF_BLUE)
khasabslots:setroutegroups(true,15000)
khasabslots:ActivateCTLD()
khasabslots:SetRedNotAllowed(REDNOSLOTS)
khasabslots:Start()
table.insert(ALLSLOTS,khasabslots)


kishslots = slothandler:New("Kish Intl",1,"Kish")
kishslots:SetRedCTLD(220,1400,true,country.id.CJTF_RED)
kishslots:SetBlueCTLD(240,1500,true,country.id.CJTF_BLUE)
kishslots:setroutegroups(true,15000)
kishslots:ActivateCTLD()
kishslots:SetRedNotAllowed(REDNOSLOTS)
kishslots:Start()
table.insert(ALLSLOTS,kishslots)

larslots = slothandler:New("Lar",1,"Lar")
larslots:SetRedCTLD(10,1000,true,country.id.CJTF_RED)
larslots:SetBlueCTLD(170,1000,true,country.id.CJTF_BLUE)
larslots:setroutegroups(true,25000)
larslots:ActivateCTLD()
larslots:SetRedNotAllowed(REDNOSLOTS)
larslots:Start()
table.insert(ALLSLOTS,larslots)

lavanslots = slothandler:New("Lavan Island",1,"Lavan")
lavanslots:SetRedCTLD(240,600,true,country.id.CJTF_RED)
lavanslots:SetBlueCTLD(240,800,true,country.id.CJTF_BLUE)
lavanslots:setroutegroups(true,15000)
lavanslots:ActivateCTLD()
lavanslots:SetRedNotAllowed(REDNOSLOTS)
lavanslots:Start()
table.insert(ALLSLOTS,lavanslots)

liwaslots = slothandler:New("Liwa AFB",2,"Liwa")
liwaslots:SetRedCTLD(240,600,true,country.id.CJTF_RED)
liwaslots:SetBlueCTLD(240,800,true,country.id.CJTF_BLUE)
liwaslots:setroutegroups(true,15000)
liwaslots:ActivateCTLD()
liwaslots:SetRedNotAllowed(REDNOSLOTS)
liwaslots:Start()
table.insert(ALLSLOTS,liwaslots)

lengehslots = slothandler:New("Bandar Lengeh",1,"Lengeh")
lengehslots:SetRedCTLD(05,1000,true,country.id.CJTF_RED)
lengehslots:SetBlueCTLD(25,1000,true,country.id.CJTF_BLUE)
lengehslots:setroutegroups(true,25000)
lengehslots:ActivateCTLD()
lengehslots:SetRedNotAllowed(REDNOSLOTS)
lengehslots:Start()
table.insert(ALLSLOTS,lengehslots)

-- Al-Minhad
minhadslots = slothandler:New("Al Minhad AFB",2,"Minhad")
minhadslots:SetBlueCTLD(180,2000,true,country.id.CJTF_BLUE)
minhadslots:SetRedCTLD(180,3000,true,country.id.CJTF_RED)
minhadslots:ActivateCTLD()
minhadslots:setroutegroups(true,5000)
minhadslots:SetRedNotAllowed(REDNOSLOTS)
minhadslots:Start()
table.insert(ALLSLOTS,minhadslots)

musaslots = slothandler:New("Abu Musa Island",2,"Musa")
musaslots:SetRedCTLD(140,1000,true,country.id.CJTF_RED)
musaslots:SetBlueCTLD(150,1000,true,country.id.CJTF_BLUE)
musaslots:ActivateCTLD()
musaslots:setroutegroups(true,5000)
musaslots:SetRedNotAllowed(REDNOSLOTS)
musaslots:Start()
table.insert(ALLSLOTS,lavanslots)

qeshmslots = slothandler:New("Qeshm Island",1,"Qeshm")
qeshmslots:SetRedCTLD(320,900,true,country.id.CJTF_RED)
qeshmslots:SetBlueCTLD(330,1100,true,country.id.CJTF_BLUE)
qeshmslots:setroutegroups(true,35000)
qeshmslots:ActivateCTLD()
qeshmslots:SetRedNotAllowed(REDNOSLOTS)
qeshmslots:Start()
table.insert(ALLSLOTS,qeshmslots)

sirrislots = slothandler:New("Sirri Island",1,"Sirri")
sirrislots:SetRedCTLD(290,2000,true,country.id.CJTF_RED)
sirrislots:SetBlueCTLD(290,2300,true,country.id.CJTF_BLUE)
sirrislots:ActivateCTLD()
sirrislots:setroutegroups(true,5000)
sirrislots:SetRedNotAllowed(REDNOSLOTS)
sirrislots:Start()
table.insert(ALLSLOTS,sirrislots)

shirazslots = slothandler:New("Shiraz Intl",1,"Shiraz")
shirazslots:SetRedCTLD(180,2000,true,country.id.CJTF_RED)
shirazslots:SetBlueCTLD(180,2300,true,country.id.CJTF_BLUE)
shirazslots:ActivateCTLD()
shirazslots:setroutegroups(true,50000)
shirazslots:SetRedNotAllowed(REDNOSLOTS)
shirazslots:Start()
table.insert(ALLSLOTS,shirazslots)

tunbslots = slothandler:New("Tunb Island AFB",1,"Tunb")
tunbslots:SetRedCTLD(320,1000,true,country.id.CJTF_RED)
tunbslots:SetBlueCTLD(320,1200,true,country.id.CJTF_BLUE)
tunbslots:ActivateCTLD()
tunbslots:setroutegroups(true,5000)
tunbslots:SetRedNotAllowed(REDNOSLOTS)
tunbslots:Start()
table.insert(ALLSLOTS,lavanslots)

rasslots = slothandler:New("Ras Al Khaimah Intl",2,"Ras Al Khaimah")
rasslots:SetRedCTLD(190,1800,true,country.id.CJTF_RED)
rasslots:SetBlueCTLD(190,2000,true,country.id.CJTF_BLUE)
rasslots:ActivateCTLD()
rasslots:setroutegroups(true,10000)
rasslots:SetRedNotAllowed(REDNOSLOTS)
rasslots:Start()
table.insert(ALLSLOTS,rasslots)

abbasslots = slothandler:New("Bandar Abbas Intl",1,"Abbas")
abbasslots:SetRedCTLD(90,1500,true,country.id.CJTF_RED)
abbasslots:SetBlueCTLD(90,2000,true,country.id.CJTF_BLUE)
abbasslots:setroutegroups(true,11000)
abbasslots:ActivateCTLD()
abbasslots:SetRedNotAllowed(REDNOSLOTS)
abbasslots:Start()

table.insert(ALLSLOTS,abbasslots)
-- Carriers

Teddyslot = carrierslothandler:New("TeddyR","Teddy"):Start()
Washingtonslot = carrierslothandler:New("Washington","Washington"):Start()
Forrestalslot = carrierslothandler:New("Forrestal","Forrestal"):Start()

Kuznetsov = carrierslothandler:New("Kuznetsov","Kuznetsov"):Start()
Tarawaslot = carrierslothandler:New("Tarawa","Tarawa"):Start()
Saipanslot = carrierslothandler:New("Saipan","Saipan"):Start()
Nassauslot = carrierslothandler:New("Nassau","Nassau"):Start()
Peleliuslot = carrierslothandler:New("Peleliu","Peleliu"):Start()

table.insert(ALLSLOTS,Teddyslot)
table.insert(ALLSLOTS,Washingtonslot)
table.insert(ALLSLOTS,Forrestalslot)
table.insert(ALLSLOTS,Kuznetsov)
table.insert(ALLSLOTS,Tarawaslot)
table.insert(ALLSLOTS,Saipanslot)
table.insert(ALLSLOTS,Nassauslot)
table.insert(ALLSLOTS,Peleliuslot)

if newslots == true then
    Invslot = carrierslothandler:New("Inv","Inv"):Start()
    Abeslot = carrierslothandler:New("Abe","Abe"):Start()
    table.insert(ALLSLOTS,Abeslot)
    table.insert(ALLSLOTS,Invslot)
end



-- Fobs
BN85 = fob:New("BN85","red_bn85","blue_bn85",2,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,BN85)
BQ26 = fob:New("BQ26","red_BQ26","blue_BQ26",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,BQ26)
BQ51 = fob:New("BQ51","red_BQ51","blue_BQ51",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,BQ51)
BQ99 = fob:New("BQ99","red_bq99","blue_BQ99",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,BQ99)
BR31 = fob:New("BR31","red_BR31","blue_BR31",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,BR31)
BS02 = fob:New("BS02","red_BS02","blue_BS02",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,BS02)
CT75 = fob:New("CT75","red_CT75","blue_CT75",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CT75)
DP05 = fob:New("DP05","red_DP05","blue_DP05",2,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DP05)
DR35 = fob:New("DR35","red_DR35","blue_DR35",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DR35)
DS34 = fob:New("DS34","red_DS34","blue_DS34",1,0):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DR34)
DU06 = fob:New("DU06","red_DU06","blue_DU06",1,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DU06)
EP36 = fob:New("EP36","red_EP36","blue_EP36",1,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,EP36)
EQ13 = fob:New("EQ13","red_EQ13","blue_EQ13",1,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,EQ13)
ER00 = fob:New("ER00","red_ER00","blue_ER00",1,270):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ER00)
FR47 = fob:New("FR47","red_FR47","blue_FR47",1,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,FR47)
YK65 = fob:New("YK65","red_YK65","blue_YK65",1,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,YK65)
YN50 = fob:New("YN50","red_YN50","blue_YN50",1,180):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,YN50)
CR43 = fob:New("CR43","red_CR","blue_CR",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CR43)
CR71 = fob:New("CR71","red_CR71","blue_CR71",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CR71)
CQ37 = fob:New("CQ37","red_CQ37","blue_CQ37",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CQ37)
CQ34 = fob:New("CQ34","red_CQ34","blue_CQ34",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CQ34)
CS80 = fob:New("CS80","red_CS80","blue_CS80",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CS80)
DQ28 = fob:New("DQ28","red_DQ28","blue_DQ28",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DQ28)
DQ49 = fob:New("DQ49","red_DQ49","blue_DQ49",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DQ49)
EQ47 = fob:New("EQ47","red_EQ47","blue_EQ47",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,EQ47)
ER41 = fob:New("ER41","red_ER41","blue_ER41",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ER41)
EP99 = fob:New("EP99","red_EP99","blue_EP99",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,EP99)
EQ97 = fob:New("EQ97","red_EQ97","blue_EQ97",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,EQ97)
ER68 = fob:New("ER68","red_er68","blue_er68",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ER68)
EQ53 = fob:New("EQ53","red_eq53","blue_eq53",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,EQ53)
FQ43 = fob:New("FQ43","red_fq43","blue_fq43",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,FQ43)
ER84 = fob:New("ER84","red_er84","blue_er84",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ER84)
DR84 = fob:New("DR84","red_dr84","blue_dr84",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DR84)
ER27 = fob:New("ER27","red_er27","blue_er27",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ER27)
DS30 = fob:New("DS30","red_ds30","blue_ds30",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,DS30)
ES21 = fob:New("ES21","red_es21","blue_es21",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ES21)
ES84 = fob:New("ES84","red_es84","blue_es84",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ES84)
FT31 = fob:New("FT31","red_ft31","blue_ft31",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,FT31)
RKM09 = fob:New("RKM09","red_rkm09","blue_rkm09",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,RKM09)
GS04 = fob:New("GS04","red_gs04","blue_gs04",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,GS04)
GR56 = fob:New("GR56","red_gr56","blue_gr56",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,GR56)
GQ06 = fob:New("GQ06","red_gq06","blue_gq06",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,GQ06)
FP84 = fob:New("FP84","red_fp84","blue_fp84",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,FP84)
CBH = fob:New("CBH","red_cbh","blue_cbh",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,CBH)
ISR = fob:New("ISR","red_isr","blue_isr",1,90):SetRedNotAllowed(REDNOSLOTS):Start()
table.insert(ALLFOBS,ISR)