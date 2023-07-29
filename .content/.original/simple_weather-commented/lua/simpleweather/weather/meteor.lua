WEATHER.ID = "meteor"
WEATHER.Sound = "siren"
WEATHER.ConVar = { "sw_meteor", "Meteor" }

SW.MeteorMinDelay 	= 0	-- Minimum delay between meteor spawns
SW.MeteorMaxDelay 	= 5	-- Maximum delay between meteor spawns
SW.MeteorFadeTime 	= 10	-- Time for meteors to fade after hitting the ground. -1 for never (not recommended)
SW.MeteorWhoosh		= true -- Play whoosh sound before meteors hit the ground

function WEATHER:Think()
	
	if( SERVER ) then
		
		if( !SW.SkyPositions ) then
			
			SW.SkyPositions = { }
			
		end
		
		if( #SW.SkyPositions == 0 ) then
			
			return
			
		end
		
		if( !SW.NextMeteor ) then
			
			SW.NextMeteor = CurTime( )
			
		end
		
		if( CurTime( ) >= SW.NextMeteor ) then
			
			SW.NextMeteor = CurTime() + math.random( SW.MeteorMinDelay, SW.MeteorMaxDelay )
			
			if( #SW.SkyPositionsTall == 0 ) then return end
			
			local hp = table.Random( SW.SkyPositionsTall )
			
			local ent = ents.Create( "sw_meteor" )
			ent:SetPos( hp - Vector( 0, 0, 100 ) ) -- bbox is 140, 140, 140 x -140, -140, -140
			ent:Spawn()
			ent:Activate()
			
			local phys = ent:GetPhysicsObject()
			
			if( phys and phys:IsValid() ) then
				
				local a = math.Rand( -math.pi, math.pi )
				local v = Vector( math.cos( a ), math.sin( a ), 0 )
				phys:AddVelocity( v * math.random( -500, 500 ) )
				
			end
			
		end
		
	end
	
end

local function f( ply, ent )
	
	if( ent and ent:IsValid( ) and ent:GetClass( ) == "sw_meteor" ) then return false end
	
end
hook.Add( "PhysgunPickup", "SW.Meteor.PhysgunPickup", f )
