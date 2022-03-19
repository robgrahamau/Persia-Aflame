--- All Sqns for Persia.

-- Blue Sqns
cap1 = sqn:New("Eagle CAP","USCAP1",300,math.random(2,16),2,(60*30),AIRBASE.PersianGulf.Al_Dhafra_AB,SPAWN.Takeoff.Air)
cap2 = sqn:New("Mirage CAP","USCAP2",300,math.random(2,16),2,(60*30),AIRBASE.PersianGulf.Al_Dhafra_AB,SPAWN.Takeoff.Air)
cap3 = sqn:New("Viper CAP","USCAP3",300,math.random(2,16),2,(60*15),AIRBASE.PersianGulf.Al_Dhafra_AB,SPAWN.Takeoff.Air)
cap4 = sqn:New("Hornet CAP","USCAP4",300,math.random(2,16),2,(60*25),AIRBASE.PersianGulf.Al_Dhafra_AB,SPAWN.Takeoff.Air)
cap5 = sqn:New("CAG 5 CAP","USCAP5",300,math.random(2,14),2,(60*30),"TeddyR",SPAWN.Takeoff.Air)
cap6 = sqn:New("CAG 6 CAP","USCAP6-1",300,math.random(2,14),2,(60*30),"Washington",SPAWN.Takeoff.Air)
cv5alert = sqn:New("CAG 5 CAP 2","USCAP5",300,math.random(2,14),2,(60*15),"TeddyR",SPAWN.Takeoff.Air)
cv6alert = sqn:New("CAG 6 CAP 2","USCAP6-1",300,math.random(2,14),2,(60*15),"Washington",SPAWN.Takeoff.Air) 


-- Red Sqns

-- Shriaz
i30th = sqn:New("30th Squadron CAP 1","IRAF30th",300,math.random(2,12),2,(60*25),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i30th_1 = sqn:New("30th Squadron CAP 2","IRAF30th-1",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i30th_2 = sqn:New("30th Squadron CAP 3","IRAF30th-2",300,math.random(2,12),2,(60*25),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i25th = sqn:New("25th Squadron CAP 1","IRAF25TH",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i25th_1 = sqn:New("25th Squadron CAP 2","IRAF25TH-1",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i25th_2 = sqn:New("25th Squadron CAP 3","IRAF25TH-1",300,math.random(2,12),2,(60*45),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i26th = sqn:New("26th Squadron CAP 1","IRAF26TH",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)
i26th_1 = sqn:New("26th Squadron CAP 4","IRAF26TH",300,math.random(2,12),2,(60*45),AIRBASE.PersianGulf.Shiraz_International_Airport,SPAWN.Takeoff.Air)

--kerman
i01st = sqn:New("1st Squadron CAP 1","IRAF01",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Kerman_Airport,SPAWN.Takeoff.Air)
i02nd = sqn:New("2nd Squadron CAP 1","IRAF02",300,math.random(2,12),2,(60*25),AIRBASE.PersianGulf.Kerman_Airport,SPAWN.Takeoff.Air)
i03rd = sqn:New("3rd Squadron CAP 1","IRAF03",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Kerman_Airport,SPAWN.Takeoff.Air)
i03rd_1 = sqn:New("3rd Squadron CAP 2","IRAF03",300,math.random(2,12),2,(60*45),AIRBASE.PersianGulf.Kerman_Airport,SPAWN.Takeoff.Air)

--bandar
i31st = sqn:New("31st Squadron CAP 1","IRAF31th",300,math.random(2,12),2,(60*15),AIRBASE.PersianGulf.Bandar_Abbas_Intl,SPAWN.Takeoff.Air)
i32nd = sqn:New("32nd Squadron CAP 1","IRAF32nd",300,math.random(2,12),2,(60*25),AIRBASE.PersianGulf.Bandar_Abbas_Intl,SPAWN.Takeoff.Air)
i32nd_2 = sqn:New("32nd Squadron CAP 2","IRAF32nd",300,math.random(2,12),2,(60*45),AIRBASE.PersianGulf.Bandar_Abbas_Intl,SPAWN.Takeoff.Air)
i33rd = sqn:New("33rd Squadron CAP 1","IRAF33rd",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Bandar_Abbas_Intl,SPAWN.Takeoff.Air)
i33rd_2 = sqn:New("33rd Alert2","IRAF33rd",300,math.random(2,12),2,(60*45),AIRBASE.PersianGulf.Bandar_Abbas_Intl,SPAWN.Takeoff.Air)
i33rd_2 = intercept:New("33rd Alert2","IRAF33rd",300,6,2,(60*2),ZONE:New("BAI"))

i91st_2 = sqn:New("91st Squadron CAP 2","IRAF91",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Lar_Airbase,SPAWN.Takeoff.Air)
--hav
i33rd_1 = sqn:New("33rd Alert Hav","IRAF33rd-1",300,math.random(0,6),2,(60*35),AIRBASE.PersianGulf.Havadarya,SPAWN.Takeoff.Air)
--intercept:New("33rd Alert","IRAF33rd-1",300,6,2,(60*2),ZONE:New("BAI-1"))

--kish
i91st = sqn:New("91st Squadron CAP 1","IRAF91",300,math.random(2,12),2,(60*35),AIRBASE.PersianGulf.Kish_International_Airport,SPAWN.Takeoff.Air)
i91st_1 = sqn:New("91st Squadron CAP 2","IRAF91",300,math.random(2,12),2,(60*45),AIRBASE.PersianGulf.Kish_International_Airport,SPAWN.Takeoff.Air)
--i91st_1 = intercept:New("91st Alert","IRAF91",300,6,2,(60*2),ZONE:New("KAI"))

-- Functions.


function startblue()
	-- blue units
	SCHEDULER:New(nil,function() cap1:Start() end,{},math.random(1,120))
	SCHEDULER:New(nil,function() cap2:Start() end,{},math.random(1,120))
	SCHEDULER:New(nil,function() cap3:Start() end,{},math.random(1,120))
	SCHEDULER:New(nil,function() cap4:Start() end,{},math.random(1,120))
	SCHEDULER:New(nil,function() cap5:Start() end,{},math.random(60,240))
	SCHEDULER:New(nil,function() cap6:Start() end,{},math.random(60,240))

end

function startred()
	-- iran units
	-- IRAF01,IRAF02,IRAF03,IRAF31th,IRAF32nd,IRAF33rd,IRAF33rd-1,IRAF91
	-- Shiraz Units
	i30th:Start()
	i30th_1:Start()
	i30th_2:Start() 
	i25th:Start() 
	i25th_1:Start()
	i25th_2:Start()
	i26th:Start()
	-- i26th_1:Start()
	-- Kerman Units
	i01st:Start()
	i02nd:Start()
	i03rd:Start()
	-- i03rd_1:Start()
	-- Bandar Units
	i31st:Start()
	i32nd:Start() 
	--i32nd_2:Start()
	i33rd:Start() 
	-- Bandar Intercept.
	--i33rd_2:Start()
	-- Havadaria Intercept
	i33rd_1:Start()
	--kish
	i91st:Start()
	-- lars
	i91st_2:Start()
	--intercept
	--i91st_1:Start()
end

SCHEDULER:New(nil,function() 
  if usenew == true and init == true then
    startblue()
    startred()
  end
end,{},60)
