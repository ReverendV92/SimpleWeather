SW.Time = SW.StartTime;
SW.TimePaused = false;

SW_TIME_DAWN = 6;
SW_TIME_AFTERNOON = 12;
SW_TIME_DUSK = 18;
SW_TIME_NIGHT = 24;

SW_TIME_WEATHER = 1;
SW_TIME_WEATHER_NIGHT = 2;
SW_TIME_FOG = 3;

SW.SkyColors = { };
SW.SkyColors[SW_TIME_DAWN] = {
	TopColor 		= Vector( 0.64, 0.73, 0.91 ),
	BottomColor 	= Vector( 0.74, 0.86, 0.98 ),
	FadeBias 		= 0.82,
	HDRScale 		= 0.66,
	DuskIntensity 	= 2.44,
	DuskScale 		= 0.54,
	DuskColor 		= Vector( 1, 0.38, 0 ),
	SunSize 		= 2,
	SunColor 		= Vector( 0.2, 0.1, 0 )
};
SW.SkyColors[SW_TIME_AFTERNOON] = {
	TopColor 		= Vector( 0.24, 0.61, 1 ),
	BottomColor 	= Vector( 0.6, 0.9, 1 ),
	FadeBias 		= 0.27,
	HDRScale 		= 0.66,
	DuskIntensity 	= 0,
	DuskScale 		= 0.54,
	DuskColor 		= Vector( 1, 0.38, 0 ),
	SunSize 		= 5,
	SunColor 		= Vector( 0.2, 0.1, 0 )
};
SW.SkyColors[SW_TIME_DUSK] = {
	TopColor 		= Vector( 0.45, 0.55, 1 ),
	BottomColor 	= Vector( 0.91, 0.64, 0.05 ),
	FadeBias 		= 0.61,
	HDRScale 		= 0.66,
	DuskIntensity 	= 1.56,
	DuskScale 		= 0.54,
	DuskColor 		= Vector( 1, 0, 0 ),
	SunSize 		= 2,
	SunColor 		= Vector( 1, 0.47, 0 )
};
SW.SkyColors[SW_TIME_NIGHT] = {
	TopColor 		= Vector( 0, 0.01, 0.02 ),
	BottomColor 	= Vector( 0, 0, 0 ),
	FadeBias 		= 0.82,
	HDRScale 		= 0.66,
	DuskIntensity 	= 0,
	DuskScale 		= 0.54,
	DuskColor 		= Vector( 1, 0.38, 0 ),
	SunSize 		= 2,
	SunColor 		= Vector( 0.2, 0.1, 0 )
};
SW.SkyColors[SW_TIME_WEATHER] = {
	TopColor 		= Vector( 0.34, 0.34, 0.34 ),
	BottomColor 	= Vector( 0.19, 0.19, 0.19 ),
	FadeBias 		= 1,
	HDRScale 		= 0.66,
	DuskIntensity 	= 0,
	DuskScale 		= 0,
	DuskColor 		= Vector( 0, 0, 0 ),
	SunSize 		= 0,
	SunColor 		= Vector( 0, 0, 0 )
};
SW.SkyColors[SW_TIME_WEATHER_NIGHT] = {
	TopColor 		= Vector( 0.02, 0.02, 0.02 ),
	BottomColor 	= Vector( 0, 0, 0 ),
	FadeBias 		= 1,
	HDRScale 		= 0.66,
	DuskIntensity 	= 0,
	DuskScale 		= 0,
	DuskColor 		= Vector( 0, 0, 0 ),
	SunSize 		= 0,
	SunColor 		= Vector( 0, 0, 0 )
};
SW.SkyColors[SW_TIME_FOG] = {
	TopColor 		= Vector( 200 / 255, 200 / 255, 200 / 255 ),
	BottomColor 	= Vector( 200 / 255, 200 / 255, 200 / 255 ),
	FadeBias 		= 1,
	HDRScale 		= 0.66,
	DuskIntensity 	= 0,
	DuskScale 		= 0,
	DuskColor 		= Vector( 0, 0, 0 ),
	SunSize 		= 0,
	SunColor 		= Vector( 0, 0, 0 )
};

SW.LastLightStyle = "";

util.AddNetworkString( "SW.nInitFogSettings" );
util.AddNetworkString( "SW.nInitSkyboxFogSettings" );
util.AddNetworkString( "SW.nSetTime" );
util.AddNetworkString( "SW.nOpenConfigWindow" );

function SW.UpdateLightStyle( s )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( SW.UpdateLighting and SW.LastLightStyle != s ) then
		
		if( SW.LightEnvironment and SW.LightEnvironment:IsValid() ) then
			
			SW.LightEnvironment:Fire( "FadeToPattern", s );
			
		else
			
			engine.LightStyle( 0, s );
			
			timer.Simple( 0.05, function()
				
				net.Start( "SW.nRedownloadLightmaps" );
				net.Broadcast();
				
			end );
			
		end
		
		SW.LastLightStyle = s;
		
	end
	
end

function SW.InitDayNight()
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	if( SW.UpdateSkybox ) then

		RunConsoleCommand( "sv_skyname", "painted" );

	end

end

function SW.InitPostEntity()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		SW.LightEnvironment = ents.FindByClass( "light_environment" )[1];
		SW.Sun = ents.FindByClass( "env_sun" )[1];
		SW.SkyPaint = ents.FindByClass( "env_skypaint" )[1];
		SW.EnvFog = ents.FindByClass( "env_fog_controller" )[1];
		SW.SkyCam = ents.FindByClass( "sky_camera" )[1];
		
		if( SW.EnvFog and SW.EnvFog:IsValid() ) then
			
			local tab = SW.EnvFog:GetSaveTable();
			
			SW.FogSettings = { };
			SW.FogSettings["FogStart"] = math.Round( tonumber( tab.fogstart ) );
			SW.FogSettings["FogEnd"] = math.Round( tonumber( tab.fogend ) );
			SW.FogSettings["MaxDensity"] = tonumber( tab.fogmaxdensity );
			
			local col = string.Explode( " ", tab.fogcolor );
			
			SW.FogSettings["r"] = tonumber( col[1] );
			SW.FogSettings["g"] = tonumber( col[2] );
			SW.FogSettings["b"] = tonumber( col[3] );
			
		end
		
		if( SW.SkyCam and SW.SkyCam:IsValid() ) then
			
			local tab = SW.SkyCam:GetSaveTable();
			
			SW.SkyboxFogSettings = { };
			SW.SkyboxFogSettings["FogStart"] = math.Round( tonumber( tab.fogstart ) );
			SW.SkyboxFogSettings["FogEnd"] = math.Round( tonumber( tab.fogend ) );
			SW.SkyboxFogSettings["MaxDensity"] = tonumber( tab.fogmaxdensity );
			
			local col = string.Explode( " ", tab.fogcolor );
			
			SW.SkyboxFogSettings["r"] = tonumber( col[1] );
			SW.SkyboxFogSettings["g"] = tonumber( col[2] );
			SW.SkyboxFogSettings["b"] = tonumber( col[3] );
			
		end
		
		SW.UpdateLightStyle( SW.MaxDarkness );
		
		if( SW.UpdateSun and SW.Sun and SW.Sun:IsValid() ) then
			
			SW.Sun:SetKeyValue( "sun_dir", "1 0 0" );
			
		end
		
		if( SW.UpdateSkybox and ( !SW.SkyPaint or !SW.SkyPaint:IsValid() ) ) then
			
			SW.SkyPaint = ents.Create( "env_skypaint" );
			SW.SkyPaint:Spawn();
			SW.SkyPaint:Activate();
			
		end
		
		if( string.lower( game.GetMap() ) == "rp_evocity_v33x" or string.lower( game.GetMap() ) == "rp_evocity_v4b1" or string.lower( game.GetMap() ) == "rp_evocity2_v5p" ) then
			
			for _, v in pairs( ents.FindByName( "daynight_brush" ) ) do
				
				v:Remove();
				
			end
			
		end
		
	end
	
end
hook.Add( "InitPostEntity", "SW.InitPostEntity", SW.InitPostEntity );

SW.LastTimePeriod = SW_TIME_NIGHT;

function SW.GetRealTime()
	
	local tab = os.date( "*t" );
	
	return SW.RealtimeOffset + tab.hour + tab.min / 60 + tab.sec / 3600;
	
end

function SW.DayNightThink()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		if( !SW.TimePaused ) then
			
			if( SW.Time >= 20 or SW.Time < 4 ) then
				
				SW.Time = SW.Time + FrameTime() * SW.NightTimeMul;
				
			else
				
				SW.Time = SW.Time + FrameTime() * SW.DayTimeMul;
				
			end
			
			if( SW.Realtime ) then
				
				SW.Time = SW.GetRealTime();
				
			end
			
		end
		
		if( SW.StaticTime != false ) then

			SW.Time = SW.StaticTime;
			
		end
		
		if( SW.Time >= 24 ) then
			
			SW.Time = 0;
			
		end
		
		if( !SW.NextClientUpdate or CurTime() > SW.NextClientUpdate ) then
			
			net.Start( "SW.nSetTime" );
				net.WriteFloat( SW.Time );
			net.Broadcast();
			SW.NextClientUpdate = CurTime() + SW.ClientUpdateDelay;
			
		end
		
		local mul = 0; -- Credit to looter's atmos addon for this math
		
		if( SW.Time >= 4 and SW.Time < 12 ) then
			
			mul = math.EaseInOut( ( SW.Time - 4 ) / 8, 0, 1 );
			
		elseif( SW.Time >= 12 and SW.Time < 20 ) then
			
			mul = math.EaseInOut( 1 - ( SW.Time - 12 ) / 8, 1, 0 );
			
		end
		
		local s = string.char( math.Round( Lerp( mul, string.byte( SW.MaxDarkness ), string.byte( SW.MaxLightness ) ) ) );
		
		if( SW.WeatherMode != "" ) then
			
			s = string.char( math.Round( Lerp( mul, string.byte( SW.MaxDarkness ), string.byte( SW.MaxLightnessStorm ) ) ) );
			
		end
		
		SW.UpdateLightStyle( s );
		
		if( SW.UpdateSun and SW.Sun and SW.Sun:IsValid() ) then
			
			if( !SW.NextSunUpdate or CurTime() > SW.NextSunUpdate ) then
				
				if( SW.Time > 4 and SW.Time < 20 and SW.WeatherMode == "" ) then
					
					local mul = 1 - ( SW.Time - 4 ) / 16;
					SW.Sun:SetKeyValue( "sun_dir", tostring( Angle( -180 * mul, 20, 0 ):Forward() ) );
					
				end
				
				if( SW.WeatherMode != "" or SW.Time < 4 or SW.Time > 20 ) then
					
					if( !SW.Sun.Off ) then
						
						SW.Sun:Fire( "TurnOff" );
						SW.Sun.Off = true;
						
					end
					
				else
					
					if( SW.Sun.Off ) then
						
						SW.Sun:Fire( "TurnOn" );
						SW.Sun.Off = false;
						
					end
					
				end
				
				SW.NextSunUpdate = CurTime() + SW.SunUpdateDelay;
				
			end
			
		end

		local t = math.floor( SW.Time );
		if( t != SW.LastHookHour ) then
			SW.LastHookHour = t;
			hook.Call( "OnHour", GAMEMODE, t );
		end
		
		if( SW.Time < 6 ) then
			
			SW.LastTimePeriod = SW_TIME_DUSK;
			
		elseif( SW.Time < 18 ) then
			
			if( SW.LastTimePeriod != SW_TIME_DAWN ) then
				
				if( SW.FireOutputs ) then
					
					for _, v in pairs( ents.FindByName( "dawn" ) ) do
						
						v:Fire( "Trigger" );
						
					end
					
					for _, v in pairs( ents.FindByName( "day_events" ) ) do
						
						v:Fire( "Trigger" );
						
					end
					
					if( string.lower( game.GetMap() ) == "rp_harbor2ocean_catalyst2_v3" ) then
						
						for _, v in pairs( ents.FindByName( "amblol2" ) ) do v:Fire( "TurnOn" ) end
						for _, v in pairs( ents.FindByName( "1" ) ) do v:Fire( "TurnOn" ) end
						for _, v in pairs( ents.FindByName( "lamps`" ) ) do v:Fire( "TurnOn" ) end
						
					end
					
				end
				
				hook.Call( "WeatherDay", GAMEMODE );
				
			end
			
			SW.LastTimePeriod = SW_TIME_DAWN;
			
		else
			
			if( SW.LastTimePeriod != SW_TIME_DUSK ) then
				
				if( SW.FireOutputs ) then
					
					for _, v in pairs( ents.FindByName( "dusk" ) ) do
						
						v:Fire( "Trigger" );
						
					end
					
					for _, v in pairs( ents.FindByName( "night_events" ) ) do
						
						v:Fire( "Trigger" );
						
					end
					
					if( string.lower( game.GetMap() ) == "rp_harbor2ocean_catalyst2_v3" ) then
						
						for _, v in pairs( ents.FindByName( "amblol2" ) ) do v:Fire( "TurnOff" ) end
						for _, v in pairs( ents.FindByName( "1" ) ) do v:Fire( "TurnOff" ) end
						for _, v in pairs( ents.FindByName( "lamps`" ) ) do v:Fire( "TurnOff" ) end
						
					end
					
				end
				
				hook.Call( "WeatherNight", GAMEMODE );
				
			end
			
			SW.LastTimePeriod = SW_TIME_DUSK;
			
		end
		
		if( SW.UpdateSkybox and SW.SkyPaint and SW.SkyPaint:IsValid() ) then
			
			if( !SW.NextSkyUpdate or CurTime() > SW.NextSkyUpdate ) then
				
				SW.NextSkyUpdate = CurTime() + SW.SkyUpdateDelay;
				
				local skypaintstart;
				local skypaintend;
				local skypaintlerp = 1;
				
				if( SW.WeatherMode != "" and !SW.GetCurrentWeather().DefaultSky ) then
					
					if( SW.Time >= 20 or SW.Time <= 4 ) then
						
						skypaintstart = SW_TIME_WEATHER_NIGHT;
						skypaintend = SW_TIME_WEATHER_NIGHT;
						
					elseif( SW.Time < 6 ) then
						
						skypaintstart = SW_TIME_WEATHER_NIGHT;
						skypaintend = SW_TIME_WEATHER;
						skypaintlerp = ( SW.Time - 4 ) / 2;
						
					elseif( SW.Time < 18 ) then
						
						skypaintstart = SW_TIME_WEATHER;
						skypaintend = SW_TIME_WEATHER;
						
					elseif( SW.Time < 20 ) then
						
						skypaintstart = SW_TIME_WEATHER;
						skypaintend = SW_TIME_WEATHER_NIGHT;
						skypaintlerp = ( SW.Time - 18 ) / 2;
						
					end
					
					if( SW.GetCurrentWeather().FogColor ) then
						
						local c = SW.GetCurrentWeather().FogColor;
						
						if( skypaintend == SW_TIME_WEATHER ) then
							skypaintend = SW_TIME_FOG;
						end
						
						if( skypaintstart == SW_TIME_WEATHER ) then
							skypaintstart = SW_TIME_FOG;
						end
						
						SW.SkyPaint:SetStarTexture( "skybox/clouds" );
						SW.SkyPaint:SetStarScale( 1 );
						SW.SkyPaint:SetStarFade( 0 );
						SW.SkyPaint:SetStarSpeed( 0.03 );
						
					else
						
						SW.SkyPaint:SetStarTexture( "skybox/clouds" );
						SW.SkyPaint:SetStarScale( 1 );
						SW.SkyPaint:SetStarFade( 0.4 );
						SW.SkyPaint:SetStarSpeed( 0.03 );
						
					end
					
				else
					
					if( SW.Time < 4 ) then
						
						skypaintstart = SW_TIME_NIGHT;
						skypaintend = SW_TIME_NIGHT;
						
					elseif( SW.Time < 6 ) then
						
						skypaintstart = SW_TIME_NIGHT;
						skypaintend = SW_TIME_DAWN;
						skypaintlerp = ( SW.Time - 4 ) / 2;
						
					elseif( SW.Time < 10 ) then
						
						skypaintstart = SW_TIME_DAWN;
						skypaintend = SW_TIME_AFTERNOON;
						skypaintlerp = ( SW.Time - 6 ) / 4;
						
					elseif( SW.Time < 18 ) then
						
						skypaintstart = SW_TIME_AFTERNOON;
						skypaintend = SW_TIME_AFTERNOON;
						skypaintlerp = 1;
						
					elseif( SW.Time < 20 ) then
						
						skypaintstart = SW_TIME_AFTERNOON;
						skypaintend = SW_TIME_DUSK;
						skypaintlerp = ( SW.Time - 18 ) / 2;
						
					elseif( SW.Time < 22 ) then
						
						skypaintstart = SW_TIME_DUSK;
						skypaintend = SW_TIME_NIGHT;
						skypaintlerp = ( SW.Time - 20 ) / 2;
						
					else
						
						skypaintstart = SW_TIME_NIGHT;
						skypaintend = SW_TIME_NIGHT;
						
					end
					
					SW.SkyPaint:SetStarTexture( "skybox/starfield" );
					SW.SkyPaint:SetStarScale( 0.5 );
					SW.SkyPaint:SetStarFade( 1.5 );
					SW.SkyPaint:SetStarSpeed( SW.StarRotateSpeed );
					
				end
				
				local values = { };
				
				if( skypaintstart == SW_TIME_FOG ) then
					
					local c = SW.GetCurrentWeather().FogColor;
					values.TopColor = Vector( c.r / 255, c.g / 255, c.b / 255 );
					values.BottomColor = Vector( c.r / 255, c.g / 255, c.b / 255 );
					
				else
					
					values.TopColor = Vector();
					values.TopColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.r, SW.SkyColors[skypaintend].TopColor.r );
					values.TopColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.g, SW.SkyColors[skypaintend].TopColor.g );
					values.TopColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.b, SW.SkyColors[skypaintend].TopColor.b );
					
					values.BottomColor = Vector();
					values.BottomColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.r, SW.SkyColors[skypaintend].BottomColor.r );
					values.BottomColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.g, SW.SkyColors[skypaintend].BottomColor.g );
					values.BottomColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.b, SW.SkyColors[skypaintend].BottomColor.b );
					
				end
				
				values.FadeBias = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].FadeBias, SW.SkyColors[skypaintend].FadeBias );
				values.HDRScale = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].HDRScale, SW.SkyColors[skypaintend].HDRScale );
				
				values.DuskIntensity = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskIntensity, SW.SkyColors[skypaintend].DuskIntensity );
				values.DuskScale = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskScale, SW.SkyColors[skypaintend].DuskScale );
				
				values.DuskColor = Vector();
				values.DuskColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskColor.r, SW.SkyColors[skypaintend].DuskColor.r );
				values.DuskColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskColor.g, SW.SkyColors[skypaintend].DuskColor.g );
				values.DuskColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskColor.b, SW.SkyColors[skypaintend].DuskColor.b );
				
				values.SunColor = Vector();
				values.SunColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunColor.r, SW.SkyColors[skypaintend].SunColor.r );
				values.SunColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunColor.g, SW.SkyColors[skypaintend].SunColor.g );
				values.SunColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunColor.b, SW.SkyColors[skypaintend].SunColor.b );
				
				values.SunSize = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunSize, SW.SkyColors[skypaintend].SunSize );
				
				SW.SkyPaint:SetTopColor( values.TopColor );
				SW.SkyPaint:SetBottomColor( values.BottomColor );
				SW.SkyPaint:SetFadeBias( values.FadeBias );
				SW.SkyPaint:SetHDRScale( values.HDRScale );
				SW.SkyPaint:SetDuskIntensity( values.DuskIntensity );
				SW.SkyPaint:SetDuskScale( values.DuskScale );
				SW.SkyPaint:SetDuskColor( values.DuskColor );
				SW.SkyPaint:SetSunColor( values.SunColor );
				
				if( SW.Time > 4 and SW.Time < 20 and SW.Weather == "" ) then
					
					SW.SkyPaint:SetSunSize( values.SunSize );
					
				else
					
					SW.SkyPaint:SetSunSize( 0 );
					
				end
				
			end
			
		end
		
	end
	
end

function SW.SetTime( t )
	
	SW.Time = t;
	
	local mul = 0;
	
	if( SW.Time >= 4 and SW.Time < 12 ) then
		
		mul = math.EaseInOut( ( SW.Time - 4 ) / 8, 0, 1 );
		
	elseif( SW.Time >= 12 and SW.Time < 20 ) then
		
		mul = math.EaseInOut( 1 - ( SW.Time - 12 ) / 8, 1, 0 );
		
	end
	
	local s = string.char( math.Round( Lerp( mul, string.byte( SW.MaxDarkness ), string.byte( SW.MaxLightness ) ) ) );
	
	if( SW.WeatherMode != "" ) then
		
		s = string.char( math.Round( Lerp( mul, string.byte( SW.MaxDarkness ), string.byte( SW.MaxLightnessStorm ) ) ) );
		
	end
	
	SW.UpdateLightStyle( s );
	
	if( SW.Sun and SW.Sun:IsValid() ) then
		
		SW.Sun:SetKeyValue( "sun_dir", "1 0 0" );
		
	end
	
end

if( SW.Realtime ) then
	
	SW.Time = SW.GetRealTime();
	
end

function SW.PauseTime( b )
	
	SW.TimePaused = b;
	
end