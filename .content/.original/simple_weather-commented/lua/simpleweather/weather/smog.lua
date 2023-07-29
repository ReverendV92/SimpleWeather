WEATHER.ID = "smog"
WEATHER.Sound = ""
WEATHER.FogStart = 0
WEATHER.FogEnd = 512
WEATHER.FogMaxDensity = 0.97
WEATHER.FogColor = Color( 100, 100, 75, 255 )
WEATHER.ConVar = { "sw_smog", "Smog" }

SW.SmogCoughs			= true	-- Should smog make cough sound effects?
SW.SmogCoughDelayMin	= 10	-- Minimum delay in seconds between cough sound effects
SW.SmogCoughDelayMax	= 60	-- Maximum delay in seconds between cough sound effects

function WEATHER:Think()
	
	if( SERVER and SW.SmogCoughs ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( !v.NextSmogCough ) then
				
				v.NextSmogCough = CurTime() + math.random( SW.SmogCoughDelayMin, SW.SmogCoughDelayMax )
				
			end
			
			if( CurTime() >= v.NextSmogCough ) then
				
				v:EmitSound( Sound( "ambient/voices/cough" .. math.random( 1, 4 ) .. ".wav" ) )
				v.NextSmogCough = CurTime() + math.random( SW.SmogCoughDelayMin, SW.SmogCoughDelayMax )
				
			end
			
		end
		
	end
	
end
