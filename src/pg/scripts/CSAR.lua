local thisunitname  = "csar.lua"
env.info(thisunitname .. " Started")
csarspawn = 0
function MyUID() 
	csarspawn = csarspawn + 1
	return csarspawn
end
function shuffletable(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end
-- CSAR significantly changed to use MOOSE 

csarmessageno = 0
csarmessages =
{"I'll never say a bad word about you air beaters again! Thanks for the lift!",
 "Man - thanks for getting me back here. I bet it was more tempting to go find cows than rescue me!",
 "On second thought - take me back to the enemy - I dont wanna face the music for losing an aircraft.",
 "You're cute when you're flying. Hmm - I think I've lost too much blood. Yuuuh. Cheque please.",
 "Ooof - you call that a medic landing? I think I got more injuries by being on this flight than I did getting shot down!",
 "Morphine - I love morpine. Oh - we're hear already? Well - I enjoyed that ride! I got to punch out more often!",
 "Thanks for the rescue. Now we will never speak of you rescuing me again.",
 "I hope you like beer - because I'm buying you a lot for saving my ass",
 "Oh - skip the MASH - take me to the pub!",
 "Ooof - I've already crashed once today - I didnt need to again. Oh? Really? You call that a landing, not a crash? Oh - yeah - OK then, sure!",
 "Sorry for ruining your date - but I apprecaite the rescue. Oh - you too pilots aren't dating? Could have fooled me. Well - thanks anyway",
 "Thanks for the lift. Quick tip: Keep flying the way you do - and you'll be needing a rescue chopper yourself real soon!",
 "Thanks for the lift... Oh - it's you! You look so good in flight gear that I didn't recognise you",
 "Thanks for the lift. I'd love to stick around and fly in choppers with you -but some of us have a real job to get back to",
 "I was worried about my reputation after crashing - but after seeing you fly - I really have nothing to worry about!",
 "What great flying. You should rename your unit to Beaver, because damn",
 "That flight back was awkward - but in a cute way. Like an elevator ride but with puppies",
 "Thanks for not crashing on the way back to base!",
 }

 hotmessageno = 0
 hotmessages = 
 {
  'MAYDAY! MAYDAY! Area is HOT! I repeat - I have Enemy Hostiles closing in on me!',
  'MAYDAY! MAYDAY! I have hostiles in the immediate vacinity! Get me out of here!',
  'MAYDAY! MAYDAY! I can see hostiles. LZ is hot! I repeat.... LZ is hot!',
  'MAYDAY! MAYDAY! Ive got myself into a pickle here! Unfrendlies are close by!',
 }

shuffletable(csarmessages)
shuffletable(hotmessages)

local AirbaseSet = SET_AIRBASE:New():FilterStart():FilterOnce()


my_csar = CSAR:New(coalition.side.BLUE, "GM_DownedPilot", "DownedPilot")
my_csar.immortalcrew = true
my_csar.invisiblecrew = true
my_csar.autosmoke = true
my_csar.useprefix = false
my_csar.csarOncrash = true
my_csar.enableForAI = false
my_csar.coordtype = 2
my_csar.limitmaxdownedpilots = true
my_csar.pilotmustopendoors = false
my_csar.maxdownedpilots = 10 
my_csar.allowFARPRescue = true
my_csar.FARPRescueDistance = 1000
my_csar.mashprefix = {"blue_","Carrier","Nassau", "Peleliu", }
my_csar:__Start(2)


function my_csar:OnAfterRescued(From,Event,To,HeliUnit,HeliName,PilotsSaved)
  csarmessageno = csarmessageno + 1
  if csarmessageno > #csarmessages then 
    csarmessageno = 1
  end
  --self:_DisplayMessageToSAR(HeliUnit, string.format("%s: %s.", HeliName,  csarmessages[csarmessageno]), self.messageTime,true,true)
  self:_DisplayMessageToSAR(HeliUnit, string.format("%s: %s.", HeliName,  csarmessages[csarmessageno]), 30 ,true,true)
end

-- Failed to work
--function my_csar.OnAfterApproach(self,From,Event,To,Heliname,Woundedgroupname)
--DEBUGMESSAGE('OUTPUTTING SOUND TO GROUP '..Heliname)
--  trigger.action.outSoundForGroup(Heliname, 'poppingsmoke-short.ogg')
--end

function my_csar:OnAfterApproach(from, event, to, heliname, groupname)
  -- trigger units to move towards the pick up.
  local gcount = 0
  local dist = 2000
  local _cood = groupname:GetCoordinate()
  local gunits = nil
  gunits = SET_GROUP:New():FilterCoalitions(cl):FilterActive(true):FilterCategoryGround():FilterOnce()
  if gunits ~= nil then  
    gunits:ForEach(function(g)
      if g:IsAlive() == true then
  	  	local gc = g:GetCoordinate()
		    if gc == nil then
  				BASE:E({"Could not get Coord for group:",g:GetName(),g:GetCoordinate(),gc})
			  else
    			local d = gc:Get2DDistance(coord)
	  		  if d < dist then
            gcount = gcount + 1
	  	  		local rcoord = coord:GetRandomCoordinateInRadius(500,100)
					  g:RouteGroundTo(rcoord,math.random(10,20),randomform(),5)
				  end
			  end
		  end
    end)
  end
end


function my_csar:OnAfterPilotDown(From,Event,To,Group,Frequency,Leadername,CoordinatesText)
 -- Should only do when in enemy territory. Maybe check where closest enemy group is, or if nearest airfield is friendly or not?
 -- try SET_AIRBASE:FindNearestAirbaseFromPointVec2( PointVec2 )
 
 -- spawn enemy troops within 500m range - maybe 2 or 3 lots of 4 inf?
 
 
   
  local myvec2 = Group:GetPointVec2()
  if myvec2 == nil then
  --DEBUGMESSAGE('ERROR - NIL')
  end
  local myvec3 = Group:GetVec3()
  
  --DEBUGMESSAGE('X = '..tostring(myvec2.x))
  --DEBUGMESSAGE('Y = '..tostring(myvec2.y))
  
  
  
  local abx = AirbaseSet:FindNearestObjectFromPointVec2(myvec2)
  
 if abx == nil then
  DEBUGMESSAGE('ERROR - ABX IS NIL')
  else
    if abx:GetCoalition() == coalition.side.RED  then
      -- DEBUGMESSAGE('NEAREST AIRBASE IS RED!')
      if math.random(3) > 1 then -- Only do 66% of the time - some will not have any hostiles
        for i = 1, math.random(4)  do
          local spawnpos = COORDINATE:NewFromVec3(Group:GetCoordinate()):GetRandomCoordinateInRadius(160, 120)
         local unitalias = "CSAR-"..MyUID() -- MyUID so it doesn't override old unit each time this is triggered
         --if spawnpos.y > 50 then -- Only spawn if altitude is significant enough to be away from the sea (Don't want red units spawning in sea)
         if spawnpos:GetSurfaceType() ~= 3 then -- Don't spawn if in ocean
             SPAWN:NewWithAlias("GM_RCSARInf", unitalias):InitRandomizePosition( true , 1000, 500):SpawnFromVec3(spawnpos:GetVec3())
        end
     end  -- for
     --MESSAGE:New('Enemy Hostiles closing in on downed pilot!' ,25):ToAll()  -- Would LOVE to delay this message!

     hotmessageno = hotmessageno + 1
     if hotmessageno > #hotmessages then 
      hotmessageno = 1
     end
     SCHEDULER:New(nil,function()  MESSAGE:New(hotmessages[hotmessageno], 25):ToBlue() end,{},random(30,300)) -- randomize between 30 seconds and 5 minutes.
     
    end --math random for spawn 
else
      --DEBUGMESSAGE('NEAREST BASE IS NOT RED')
      end     
   end -- abx is not nill
 end  -- function 


env.info(thisunitname .. " Ended")