--[[ 
    This is the file that will be our factory 'class'
    factories consit of actual in game buildings that we assign by their map id's and then keep track of if they have been attacked. 
    Each factory can produce certain types of goods, These can be
    • Ground (possibly subdiv this later)
    • Ammo (allows ammo trucks to be spawned)
    • Aircraft (possibly subdiv this later)
    • Parts. (repairing?)
    Once they have produced a certain amount they will then send the production they have to a logistics hub because of this we will need to have a zone (easiest way)
    as we can't get building locations or the like beyond the id's.
    
    The class needs to do the following
    - Instance persiafactory:New()
    - Be able to have buildings added/removed :addbuilding(),:removebuilding().
    - Be able to report its current production state :checkstate()
    - be able to have production type set :setproduction()
    - be able to set the amount of time between production cycles :setprodtime()
    - be able to be told how much it has to have before it produces a convoy :setamount()
    - be able to have templates set up for the logistics convoy :settemplate()
    - be able to be told which warehouse/logstics hub it's going to :sethub()
    - be able to spawn in the convoy :spawnconvoy()
    - be able to route the convoy :routeconvoy()
    - be able to know if the convoy is alive or dead :checkconvoy()
    - be able to save it's data and know what filename to save to :save() :setsave()
    - be able to load it's data :load()
    - be able to destroy previously damaged buildings :DestroyBuildings()
    - be able to be flagged not to do the above when regenerating buildings.
    - be able to start/stop the factory :start() :stop()
    
    When convoys are out and a server restart happens we need to have the group name saved so that the existing convoy can be 'saved', 'respawned' and then rerouted to continue it's journey.
    To do: Everything above.
]]


DCSUnit = Unit.getByName("testunit")
env.info(DCSUnit)
GroupHeight = 0
GroupPosition = DCSUnit:getPosition()
UnitVel = DCSUnit:getVelocity()
LandHeight =  land.getHeight( { x = GroupPosition.p.x, y = GroupPosition.p.z } )
 GroupHeight = GroupHeight + ( GroupPosition.p.y - LandHeight )
 landheightft = LandHeight * 3.28084
groupheightft = GroupHeight * 3.28084
_msg = string.format("Altitude is %d land height is:%d",GroupHeight,LandHeight)
trigger.action.outText(_msg,30)
_msg = string.format("Altitude in ft is %d land height is:%d",groupheightft,landheightft)
trigger.action.outText(_msg,30)
env.info(UnitVel)