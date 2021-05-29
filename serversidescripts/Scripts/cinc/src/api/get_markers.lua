local logger = CinCLogger
local world = world
local ipairs = ipairs
local coord = coord

local command = function (_)
  logger.info("Command get_markers called")
  local markers = {}
  for i, v in ipairs(world.getMarkPanels()) do
    local lat,lon,alt = coord.LOtoLL(v.pos)
    local marker = {
        ["coalition"]= v.coalition,
        ["id"] = v.idx,
        ["time"] = v.time,
        ["author"] = v.author,
        ["text"] = v.text,
        ["groupID"] = v.groupID,
        ["lat"] = lat,
        ["lon"] = lon,
        ["alt"] = alt,
    }
    markers[i] = marker
  end
  
  return markers
end

CinCServer.add_command('get_markers', command)