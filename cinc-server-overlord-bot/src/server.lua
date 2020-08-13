package.path  = package.path .. ";.\\LuaSocket\\?.lua;"
package.cpath = package.cpath .. ";.\\LuaSocket\\?.dll;"

local assert = assert
local clients = {}
local commands = {}
local ipairs = ipairs
local JSON = loadfile("Scripts\\JSON.lua")()
local logger = CinCLogger
local pcall = pcall
local server
local socket = require("socket")
local table = table
local timer = timer
local type = type

local CLIENT_CONNECTON_WAIT = 1 -- Seconds
local RPC_PROCESSING_WAIT = 0.1 -- seconds

CinCServer = {}

--- Encode and send response to the client.
-- @param client a LuaSocket client object
-- @param response LUA table representing response object 
local function return_response(client, response)
  local encoded_response = JSON:encode(response) .."\n"
  client:send(encoded_response)
  logger.info("Response sent: " .. encoded_response)
end

--- Log an error and send to the client.
-- @param client a LuaSocket client object
-- @param message the error message 
local function return_error(client, message)
 local response = {}
 response['error'] = message
 return_response(client, response)
end

--- Basic validation of incoming requests.
-- @param client a LuaSocket client object
-- @param request LUA table representing request object 
local function validate_request(client, request)
  local lua_response = {}

  if not request then
    return_error(client, 'No request detected')
    return false   
  elseif
    type(request['name']) ~= "string" then
    return_error(client, 'Name of procedure to execute is required')
    return false   
  elseif request['arguments'] and (type(request['arguments']) ~= "table") then
    return_error(client, 'Arguments must be a hash if present')
    return false   
  end
  return true
end

--- Check to see if there are any clients waiting to connect.
-- Looks for waiting clients and, if found, adds them to the client table so
-- that their requests can be handled
-- 
-- @param _ A dummy paramater required for the DCS scheduleFunction to work
-- @return the time so wait before checking again
local function acceptClient(_)
  -- wait for a connection from a client
  local client = server:accept()

  if client then
    local client_ip, client_port = client:getsockname()
    client:settimeout(0) -- make sure we don't block waiting for this client's request
    client:setoption("keepalive", true)
    table.insert(clients, client)
    logger.info("Client " .. table.getn(clients) .. " connected from " .. client_ip)
  end
  return timer.getTime() + CLIENT_CONNECTON_WAIT 
end

--- Handle an individual request.
-- Handles an individual request by decoding it, performing basic validation on it
-- then dispatching it to the appropriate function in the commands table.
-- Once the command has responded it encodes it and sends back to the client 
-- 
-- @param client a LuaSocket client object
-- @param encoded_request the RPC encoded request. Currently JSON 
local function handleRequest(client, encoded_request)
  local request

  logger.info("RPC Data: " .. encoded_request)
  request = JSON:decode(encoded_request)     
 
  if validate_request(client, request) then
    local command_name = request['name']
    local arguments = request['arguments']

    if commands[command_name] == nil then
      return_error(client, 'The command "' .. command_name .. '" is not recognised')
    end

    local success, result = pcall(commands[command_name], arguments)

    if not success then
      logger.info('Error calling ' .. command_name )
      return_error(client, result)
    else 
      return_response(client, result)
    end 
  end
end

--- Checks for waiting RPC messages from clients.
-- Checks each client to see if there is a waiting RPC message and
-- starts processing it if so.
-- We will check for new connections every second and process calls every
-- 100ms (arbitrarily chosen number)
-- 
-- We are limiting each client to 1 message per invocation to avoid
-- processing too many messages at once and potentially blocking the main
-- DCS thread which will lead to stuttering and lag.
-- 
-- This solution works well enough for when just OverlordBot is calling as
-- it is one client and calls infrequently. We are going to want to do some sort
-- of coroutine setup later if we start getting more clients.
-- @see https://forums.eagle.ru/showthread.php?t=146064
-- @see Moose Core.Database for examples
-- 
-- @param _ A dummy paramater required for the DCS scheduleFunction to work
-- @return the time so wait for handling the next batch of requests
local function handleRequests(_)
  local encoded_request -- JSON encoded request
  local err
  
  for client_id, client in ipairs(clients) do  
    encoded_request, err = client:receive('*l')
    if encoded_request == nil and err == 'closed' then
      logger.info("Client " .. client_id .. " disconnected")
      table.remove(clients, client_id)
    end
    if encoded_request then
      logger.info("RPC detected from client " .. client_id)
      local success, message = pcall(handleRequest, client, encoded_request)     
      if not success then
        logger.info(message)
        return_error(client, 'Internal error')
      end     
    end
  end 
  return timer.getTime() + RPC_PROCESSING_WAIT
end


--- Start the DCS RPC Server.
-- Starts the DCS RPC server so that it can accept connections and process
-- calls using the DCS function scheduler.
-- 
-- We will check for new connections every second and process calls every
-- 100ms (arbitrarily chosen number)
-- @param ip String IP Address to bind to. Use "*" for all
-- @param port Number
function CinCServer.start(ip, port)
  logger.info("RPC server starting")
  server = assert(socket.bind(ip, port))
  server:settimeout(0)
  logger.info("RPC server bound on " .. ip .. ":" .. port)

  logger.info('RPC server listen schedulers starting')
  timer.scheduleFunction(acceptClient, nil, timer.getTime() + CLIENT_CONNECTON_WAIT)
  timer.scheduleFunction(handleRequests, nil, timer.getTime() + RPC_PROCESSING_WAIT)
  logger.info('RPC server listen schedulers started')
end

function CinCServer.add_command(name, funct)
  commands[name] = funct
end