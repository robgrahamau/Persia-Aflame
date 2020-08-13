local io = io
local lfs = lfs
local timer = timer

CinCLogger = {}

local logFile = io.open(lfs.writedir()..[[Logs\cinc.log]], "w")

function CinCLogger.info(str)
  if logFile then
    logFile:write(timer.getTime() .. ": " .. str.."\r\n")
    logFile:flush()
  end
end

return CinCLogger