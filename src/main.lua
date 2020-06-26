 ----------------- PERSIAN DAWN ----------------------
-------------MAIN FILE BY ROBERT GRAHAM--------------
-----------------------------------------------------

-- this holds the entire map state


map.blue = {} -- this stores our blue coalition items
map.red = {}  -- this stores our red coalition items.
map.blue["statechange"] = 0 -- stores the timestamp of the last change
map.blue["state"] = 0
map.red["statechange"] = 0 -- stores the timestamp of the last change
map.red["state"] = 0
map.nodes = {}    -- stores all our maps nodes.
map.phase1nodes = {1,2,3,4}
map.phase2nodes = {}
map.phase3nodes = {}
map.phase4nodes = {}

-- Nodes have types, this determinds what they produce and how important they are and hopefully if we can code it right how much the AI 
-- will prioritise taking it back the aim is to have them want to retake Military zones first then production zones and finally civillian.
-- node types are 
-- 1 - military
-- 2 - oil production
-- 3 - air production
-- 4 - ground production
-- 5 - raw material production
-- 6 - civillian center
-- Nodes also have status's, the status is kinda their current 'state' which can be ok, damaged, etc.. starting to wonder if i shouldn't make nodes
-- into it's own class.
nodes = {} 
nodes[1].name = "Sirri Island"
nodes[1].Controller = 1 -- each node is controlled by a coalition
nodes[1].type = 2 -- each node has a type
nodes[1].Status = 1 -- each node has a status, 
nodes[1].objects = {} -- each node can store objects like factories etc.
nodes[1].zone = "NODE1" -- each node has a zone object attached to it.

nodes[2].name = "Abu Musa Island"
nodes[2].Controller = 1 -- each node is controlled by a coalition
nodes[2].type = 1 -- each node has a type
nodes[2].Status = 1 -- each node has a status, 
nodes[2].objects = {} -- each node can store objects like factories etc.
nodes[2].zone = "NODE2" -- each node has a zone object attached to it.
nodes[3].name = "Tunb Kochack"
nodes[3].Controller = 1 -- each node is controlled by a coalition
nodes[3].type = 1 -- each node has a type
nodes[3].Status = 1 -- each node has a status, 
nodes[3].objects = {} -- each node can store objects like factories etc.
nodes[3].zone = "NODE3" -- each node has a zone object attached to it.
nodes[4].name = "Tunb Island"
nodes[4].Controller = 1 -- each node is controlled by a coalition
nodes[4].type = 1 -- each node has a type
nodes[4].Status = 1 -- each node has a status, 
nodes[4].objects = {} -- each node can store objects like factories etc.
nodes[4].zone = "NODE4" -- each node has a zone object attached to it.odes[2].zone = "NODE2" -- each node has a zone object attached to it

map.nodes = nodes -- store our nodes into map.


