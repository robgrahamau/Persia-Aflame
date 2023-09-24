--[[
Arco11Handler = SHANDLER:New("Arco 11",4,false) 
Arco11Handler:IsTanker(true) 
Arco11Handler:Start()

Texaco11Handler = SHANDLER:New("Texaco 11",4,false)
Texaco11Handler:IsTanker(true) 
Texaco11Handler:Start()

Texaco21Handler = SHANDLER:New("Texaco 21",4,false)
Texaco21Handler:IsTanker(true)
Texaco21Handler:Start()
]]
rlog("Loading Support aircraft and starting them")

SHELL51 = SHANDLER:New("Shell51",4,false) 
SHELL51:IsTanker(true)
SHELL51.checkalive = true
SHELL51:Start() 


ARCO51 = SHANDLER:New("Arco51",4,false)
ARCO51:IsTanker(true)
ARCO51.checkalive = true
ARCO51:Start()

ARCO11 = SHANDLER:New("Arco 11",4,false)
ARCO11:IsTanker(true)
ARCO11.checkalive = true
ARCO11:Start()

TEXACO11 = SHANDLER:New("Texaco 11",4,false)
TEXACO11:IsTanker(true) 
TEXACO11.checkalive = true
TEXACO11:Start() 

TEXACO21 = SHANDLER:New("Texaco 21",4,false) 
TEXACO21:IsTanker(true) 
TEXACO21.checkalive = true
TEXACO21:Start()


RTEXACO11 = SHANDLER:New("Texaco11",4,false)
RTEXACO11:IsTanker(true) 
RTEXACO11.checkalive = true
RTEXACO11:Start()

RARCO11 = SHANDLER:New("IARCO11",4,false) 
RARCO11:IsTanker(true) 
RARCO11.checkalive = true 
RARCO11:Start()

rlog("Loaded all tankers for both red and blue")