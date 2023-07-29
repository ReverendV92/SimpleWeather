SW_TIME_DAWN = 6
SW_TIME_AFTERNOON = 12
SW_TIME_DUSK = 18
SW_TIME_NIGHT = 24

SW_TIME_WEATHER = 1
SW_TIME_WEATHER_NIGHT = 2

SW.TimePeriod = SW_TIME_DUSK

SW.CurFogDensity = 1

SW.StartTime = GetConVarNumber("sw_sv_time_start")
SW.Time = SW.StartTime

function SW.nInitFogSettings( len )
	
	SW.FogSettings = { }
	
	SW.FogSettings["FogStart"] = net.ReadUInt( 32 )
	SW.FogSettings["FogEnd"] = net.ReadUInt( 32 )
	SW.FogSettings["MaxDensity"] = net.ReadFloat()
	SW.FogSettings["r"] = net.ReadUInt( 8 )
	SW.FogSettings["g"] = net.ReadUInt( 8 )
	SW.FogSettings["b"] = net.ReadUInt( 8 )
	
end
net.Receive( "SW.nInitFogSettings", SW.nInitFogSettings )

function SW.nInitSkyboxFogSettings( len )
	
	SW.SkyboxFogSettings = { }
	
	SW.SkyboxFogSettings["FogStart"] = net.ReadUInt( 32 )
	SW.SkyboxFogSettings["FogEnd"] = net.ReadUInt( 32 )
	SW.SkyboxFogSettings["MaxDensity"] = net.ReadFloat()
	SW.SkyboxFogSettings["r"] = net.ReadUInt( 8 )
	SW.SkyboxFogSettings["g"] = net.ReadUInt( 8 )
	SW.SkyboxFogSettings["b"] = net.ReadUInt( 8 )
	
end
net.Receive( "SW.nInitSkyboxFogSettings", SW.nInitSkyboxFogSettings )

function SW.nSetTime( len )
	
	SW.Time = net.ReadFloat()
	
	if( !system.HasFocus() ) then
		
		SW.RequiresLightRefresh = true
		
	elseif( SW.RequiresLightRefresh ) then
		
		SW.RequiresLightRefresh = false
		
		timer.Simple( 1, function()
			render.RedownloadAllLightmaps()
		end )
		
	end
	
end
net.Receive( "SW.nSetTime", SW.nSetTime )

function SW.DayNightThink()
	
	if( !system.HasFocus() ) then
		
		SW.RequiresLightRefresh = true
		
	elseif( SW.RequiresLightRefresh ) then
		
		SW.RequiresLightRefresh = false
		render.RedownloadAllLightmaps()
		
	end
	
	if( GetConVarNumber("sw_sv_update_fog") == 0 ) then return end
	if( !SW.Time ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	-- local startdensity = SW.FogDayDensity
	local startdensity = GetConVarNumber("sw_sv_fog_densityday")
	-- local enddensity = SW.FogDayDensity
	local enddensity = GetConVarNumber("sw_sv_fog_densityday")
	local lerpdensity = 1
	
	if( SW.Time < 4 ) then
		
		-- startdensity = SW.FogNightDensity
		startdensity = GetConVarNumber("sw_sv_fog_densitynight")
		-- enddensity = SW.FogNightDensity
		enddensity = GetConVarNumber("sw_sv_fog_densitynight")
		
	elseif( SW.Time < 6 ) then
		
		-- startdensity = SW.FogNightDensity
		startdensity = GetConVarNumber("sw_sv_fog_densitynight")
		-- enddensity = SW.FogDayDensity
		enddensity = GetConVarNumber("sw_sv_fog_densityday")
		lerpdensity = ( SW.Time - 4 ) / 2
		
	elseif( SW.Time < 18 ) then
		
		
		
	elseif( SW.Time < 20 ) then
		
		-- startdensity = SW.FogDayDensity
		startdensity = GetConVarNumber("sw_sv_fog_densityday")
		-- enddensity = SW.FogNightDensity
		enddensity = GetConVarNumber("sw_sv_fog_densitynight")
		lerpdensity = ( SW.Time - 18 ) / 2
		
	else
		
		-- startdensity = SW.FogNightDensity
		startdensity = GetConVarNumber("sw_sv_fog_densitynight")
		-- enddensity = SW.FogNightDensity
		enddensity = GetConVarNumber("sw_sv_fog_densitynight")
		
	end
	
	-- if( !SW.FogIndoors and !SW.IsOutsideFrame ) then
	if( GetConVarNumber("sw_sv_fog_indoors") == 0 and !SW.IsOutsideFrame ) then
		
		-- SW.CurFogDensity = math.Approach( SW.CurFogDensity, 0, SW.FogSpeed )
		SW.CurFogDensity = math.Approach( SW.CurFogDensity, 0, GetConVarNumber("sw_sv_fog_speed") )
		
	elseif( SW.SkyboxVisible ) then
		
		-- SW.CurFogDensity = math.Approach( SW.CurFogDensity, Lerp( lerpdensity, startdensity, enddensity ), SW.FogSpeed )
		SW.CurFogDensity = math.Approach( SW.CurFogDensity, Lerp( lerpdensity, startdensity, enddensity ), GetConVarNumber("sw_sv_fog_speed") )
		
	end
	
end

function SW.SetupWorldFog()
	
	-- if( !SW.UpdateFog ) then return false end
	if( GetConVarNumber("sw_sv_update_fog") == 0 ) then return false end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( SW.GetCurrentWeather().FogColor ) then
		
		local w = SW.GetCurrentWeather()
		
		render.FogMode( MATERIAL_FOG_LINEAR )
		render.FogStart( w.FogStart )
		render.FogEnd( w.FogEnd )
		render.FogMaxDensity( w.FogMaxDensity * SW.CurFogDensity )
		
		local c = w.FogColor
		
		render.FogColor( c.r, c.g, c.b )
		
	else
		
		if( !SW.FogSettings or SW.CurFogDensity == 1 ) then return false end
		
		render.FogMode( MATERIAL_FOG_LINEAR )
		render.FogStart( SW.FogSettings["FogStart"] )
		render.FogEnd( SW.FogSettings["FogEnd"] )
		render.FogMaxDensity( SW.CurFogDensity * SW.FogSettings["MaxDensity"] )
		render.FogColor( SW.FogSettings["r"], SW.FogSettings["g"], SW.FogSettings["b"] )
		
	end
	
	return true
	
end
hook.Add( "SetupWorldFog", "SW.SetupWorldFog", SW.SetupWorldFog )

function SW.SetupSkyboxFog( scale )
	
	-- if( !SW.UpdateFog ) then return false end
	if( GetConVarNumber("sw_sv_update_fog") == 0 ) then return false end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( SW.GetCurrentWeather().FogColor ) then
		
		local w = SW.GetCurrentWeather()
		
		render.FogMode( MATERIAL_FOG_LINEAR )
		render.FogStart( 0 )
		render.FogEnd( 10 )
		render.FogMaxDensity( w.FogMaxDensity * SW.CurFogDensity )
		
		local c = w.FogColor
		
		render.FogColor( c.r, c.g, c.b )
		
	elseif( SW.FogSettings ) then
		
		if( !SW.SkyboxFogSettings or SW.CurFogDensity == 1 ) then return false end
		
		render.FogMode( MATERIAL_FOG_LINEAR )
		render.FogStart( SW.SkyboxFogSettings["FogStart"] )
		render.FogEnd( SW.SkyboxFogSettings["FogEnd"] )
		render.FogMaxDensity( SW.CurFogDensity * SW.SkyboxFogSettings["MaxDensity"] )
		render.FogColor( SW.SkyboxFogSettings["r"], SW.SkyboxFogSettings["g"], SW.SkyboxFogSettings["b"] )
		
	end
	
	return true
	
end
hook.Add( "SetupSkyboxFog", "SW.SetupSkyboxFog", SW.SetupSkyboxFog )