
WEATHER.ID = "hail";
WEATHER.Sound = "";
WEATHER.FogStart = 0
WEATHER.FogEnd = 1024
WEATHER.FogMaxDensity = 0.2
WEATHER.FogColor = Color( 100, 100, 100, 255 );
WEATHER.ConVar = { "sw_hail", "Hail" };
WEATHER.WindScale = 5

CreateConVar( "sw_sv_hail_delaymin" , "2" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Minimum delay in seconds between hail spawns." , "1" , "30" )
CreateConVar( "sw_sv_hail_delaymax" , "4" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Maximum delay in seconds between hail spawns." , "2" , "30" )
CreateConVar( "sw_sv_hail_lifetime" , "2" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Time for hail to fade after hitting the ground. -1 for never (not recommended)." , "-1" , "30" )

function WEATHER:Think( )

	if( SERVER ) then

		if( !SW.SkyPositions ) then

			SW.SkyPositions = { }

		end

		if( #SW.SkyPositions == 0 ) then

			return

		end

		if( !SW.NextHail ) then

			SW.NextHail = CurTime( )

		end

		if( CurTime( ) >= SW.NextHail ) then

			SW.NextHail = CurTime() + math.random( GetConVarNumber("sw_sv_hail_delaymin"), GetConVarNumber("sw_sv_hail_delaymax") )

			if( #SW.SkyPositionsTall == 0 ) then return end

			local hp = table.Random( SW.SkyPositionsTall )

			local ent = ents.Create( "sw_hail" )
			ent:SetPos( hp - Vector( 0, 0, 100 ) ) -- bbox is 140, 140, 140 x -140, -140, -140
			ent:Spawn()
			ent:Activate()

			local phys = ent:GetPhysicsObject( )

			if( phys and phys:IsValid() ) then
				
				local a = math.Rand( -math.pi, math.pi )
				local v = Vector( math.cos( a ), math.sin( a ), 0 )
				phys:AddVelocity( v * math.random( -500, 500 ) )
				
			end

		end

	end

end
