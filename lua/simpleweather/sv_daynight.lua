
-- oh god oh fuck oh man this file is DOGSHIT
-- there is SO MUCH SPAGHETTI CODE

SW.Time = GetConVarNumber("sw_time_start")

-- There's some jank ass math involved with this, so for now it's not enabled -V92
-- SW_TIME_DAWN = GetConVarNumber("sw_time_dawn") or 6
-- SW_TIME_AFTERNOON = GetConVarNumber("sw_time_afternoon") or 12
-- SW_TIME_DUSK = GetConVarNumber("sw_time_dusk") or 18
-- SW_TIME_NIGHT = GetConVarNumber("sw_time_night") or 24

SW_TIME_DAWN = 6
SW_TIME_AFTERNOON = 12
SW_TIME_DUSK = 18
SW_TIME_NIGHT = 24

SW_TIME_WEATHER = 1
SW_TIME_WEATHER_NIGHT = 2
SW_TIME_FOG = 3

SW.SkyColors = { }

SW.SkyColors[SW_TIME_DAWN] = {
	["TopColor"]		= Vector( 0.64 , 0.73 , 0.91 ) ,
	["BottomColor"]		= Vector( 0.74 , 0.86 , 0.98 ) ,
	["FadeBias"]		= 0.82 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 2.44 ,
	["DuskScale"]		= 0.54 ,
	["DuskColor"]		= Vector( 1 , 0.38 , 0 ) ,
	["SunSize"]			= 2 ,
	["SunColor"]		= Vector( 0.2 , 0.1 , 0 )
}

SW.SkyColors[SW_TIME_AFTERNOON] = {
	["TopColor"]		= Vector( 0.24 , 0.61 , 1 ) ,
	["BottomColor"]		= Vector( 0.6 , 0.9 , 1 ) ,
	["FadeBias"]		= 0.27 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0.54 ,
	["DuskColor"]		= Vector( 1 , 0.38 , 0 ) ,
	["SunSize"]			= 5 ,
	["SunColor"]		= Vector( 0.2 , 0.1 , 0 )
}

SW.SkyColors[SW_TIME_DUSK] = {
	["TopColor"]		= Vector( 0.45 , 0.55 , 1 ) ,
	["BottomColor"]		= Vector( 0.91 , 0.64 , 0.05 ) ,
	["FadeBias"]		= 0.61 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 1.56 ,
	["DuskScale"]		= 0.54 ,
	["DuskColor"]		= Vector( 1 , 0 , 0 ) ,
	["SunSize"]			= 2 ,
	["SunColor"]		= Vector( 1 , 0.47 , 0 )
}

SW.SkyColors[SW_TIME_NIGHT] = {
	["TopColor"]		= Vector( 0 , 0.01 , 0.02 ) ,
	["BottomColor"]		= Vector( 0 , 0 , 0 ) ,
	["FadeBias"]		= 0.82 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0.54 ,
	["DuskColor"]		= Vector( 1 , 0.38 , 0 ) ,
	["SunSize"]			= 2 ,
	["SunColor"]		= Vector( 0.2 , 0.1 , 0 )
}
SW.SkyColors[SW_TIME_WEATHER] = {
	["TopColor"]		= Vector( 0.34 , 0.34 , 0.34 ) ,
	["BottomColor"]		= Vector( 0.19 , 0.19 , 0.19 ) ,
	["FadeBias"]		= 1 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0 ,
	["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	["SunSize"]			= 0 ,
	["SunColor"]		= Vector( 0 , 0 , 0 )
}

SW.SkyColors[SW_TIME_WEATHER_NIGHT] = {
	["TopColor"]		= Vector( 0.02 , 0.02 , 0.02 ) ,
	["BottomColor"]		= Vector( 0 , 0 , 0 ) ,
	["FadeBias"]		= 1 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0 ,
	["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	["SunSize"]			= 0 ,
	["SunColor"]		= Vector( 0 , 0 , 0 )
}

SW.SkyColors[SW_TIME_FOG] = {
	["TopColor"]		= Vector( 200 / 255 , 200 / 255 , 200 / 255 ) ,
	["BottomColor"]		= Vector( 200 / 255 , 200 / 255 , 200 / 255 ) ,
	["FadeBias"]		= 1 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0 ,
	["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	["SunSize"]			= 0 ,
	["SunColor"]		= Vector( 0 , 0 , 0 )
}

SW.LastLightStyle = ""

util.AddNetworkString( "SW.nInitFogSettings" )
util.AddNetworkString( "SW.nInitSkyboxFogSettings" )
util.AddNetworkString( "SW.nSetTime" )
util.AddNetworkString( "SW.nOpenConfigWindow" )

function SW.UpdateLightStyle( s )

	if table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then 

		return 

	end

	if GetConVarNumber("sw_func_lighting") == 1 and SW.LastLightStyle != s then

		if( SW.LightEnvironment and SW.LightEnvironment:IsValid() ) then

			SW.LightEnvironment:Fire( "FadeToPattern", s )

		else

			engine.LightStyle( 0, s )

			timer.Simple( 0.05, function()

				net.Start( "SW.nRedownloadLightmaps" )
				net.Broadcast()

			end )

		end

		SW.LastLightStyle = s

	end

end

function SW.InitDayNight()

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then return end

	if GetConVarNumber("sw_func_skybox") == 1 then

		RunConsoleCommand( "sv_skyname", "painted" )

	end

end

function SW.InitPostEntity()

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then

		return

	end

	SW.LightEnvironment = ents.FindByClass( "light_environment" )[1]
	SW.EnvSun = ents.FindByClass( "env_sun" )[1]
	SW.SkyPaint = ents.FindByClass( "env_skypaint" )[1]
	SW.EnvFog = ents.FindByClass( "env_fog_controller" )[1]
	SW.SkyCam = ents.FindByClass( "sky_camera" )[1]
	SW.EnvWind = ents.FindByClass( "env_wind" )[1]
	SW.UpdateLightStyle( GetConVarString("sw_light_max_night") )

	if !SW.EnvWind or !SW.EnvWind:IsValid() then

		SW.EnvWind = ents.Create( "env_wind" )
		SW.EnvWind:Spawn()
		SW.EnvWind:Activate()

		SW.EnvWind:SetKeyValue( "gustdirchange" , "30" )
		SW.EnvWind:SetKeyValue( "gustduration" , "2" )
		SW.EnvWind:SetKeyValue( "minwind" , "16" )
		SW.EnvWind:SetKeyValue( "maxwind" , "24" )
		SW.EnvWind:SetKeyValue( "mingust" , "32" )
		SW.EnvWind:SetKeyValue( "maxgust" , "48" )
		SW.EnvWind:SetKeyValue( "mingustdelay" , "8" )
		SW.EnvWind:SetKeyValue( "maxgustdelay" , "16" )
		SW.EnvWind:SetKeyValue( "targetname" , "sw_windController" )

	end

	-- Find any existing env_wind entities
	for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

		-- Cache the defaults so we can call upon them later
		SW.OldWindValues = v:GetKeyValues( )
		-- PrintTable(SW.OldWindValues)
		-- print("base minwind " .. tostring( v:GetInternalVariable("minwind") ) )
		-- print("base maxwind " .. tostring( v:GetInternalVariable("maxwind") ) )

	end

	if GetConVarNumber("sw_func_fog") == 1 then

		if SW.EnvFog and SW.EnvFog:IsValid() then

			local tab = SW.EnvFog:GetSaveTable()

			SW.FogSettings = { }
			SW.FogSettings["FogStart"] = math.Round( tonumber( tab.fogstart ) )
			SW.FogSettings["FogEnd"] = math.Round( tonumber( tab.fogend ) )
			SW.FogSettings["MaxDensity"] = tonumber( tab.fogmaxdensity )

			local col = string.Explode( " ", tab.fogcolor )

			SW.FogSettings["r"] = tonumber( col[1] )
			SW.FogSettings["g"] = tonumber( col[2] )
			SW.FogSettings["b"] = tonumber( col[3] )

		end

		if SW.SkyCam and SW.SkyCam:IsValid() then

			local tab = SW.SkyCam:GetSaveTable()

			SW.SkyboxFogSettings = { }
			SW.SkyboxFogSettings["FogStart"] = math.Round( tonumber( tab.fogstart ) )
			SW.SkyboxFogSettings["FogEnd"] = math.Round( tonumber( tab.fogend ) )
			SW.SkyboxFogSettings["MaxDensity"] = tonumber( tab.fogmaxdensity )

			local col = string.Explode( " ", tab.fogcolor )

			SW.SkyboxFogSettings["r"] = tonumber( col[1] )
			SW.SkyboxFogSettings["g"] = tonumber( col[2] )
			SW.SkyboxFogSettings["b"] = tonumber( col[3] )

		end

	end

	if GetConVarNumber("sw_func_sun") == 1 then

		if SW.EnvSun and SW.EnvSun:IsValid() then

			SW.EnvSun:SetKeyValue( "sun_dir", "1 0 0" )

			-- SW.EnvSun = ents.Create("env_sun")
			-- SW.EnvSun:Spawn()
			-- SW.EnvSun:Activate()

		-- else

			-- local tab = SW.EnvSun:GetSaveTable()

			-- SW.EnvSun:SetKeyValue( "angles" , tab["angles"] )
			-- SW.EnvSun:SetKeyValue( "hdrcolorscale" , tab["hdrcolorscale"] )
			-- SW.EnvSun:SetKeyValue( "material" , tostring( tab["material"] ) )
			-- SW.EnvSun:SetKeyValue( "overlaycolor" , tab["overlaycolor"] )
			-- SW.EnvSun:SetKeyValue( "overlaymaterial" , tostring( tab["overlaymaterial"] ) )
			-- SW.EnvSun:SetKeyValue( "overlaysize" , tonumber( tab["overlaysize"] ) )
			-- SW.EnvSun:SetKeyValue( "pitch" , tonumber( tab["pitch"] ) )
			-- SW.EnvSun:SetKeyValue( "rendercolor" , tab["rendercolor"] )
			-- SW.EnvSun:SetKeyValue( "size" , tonumber( tab["size"] ) )
			-- SW.EnvSun:SetKeyValue( "use_angles" , tobool( tab["use_angles"] ) )

		end

	end

	if GetConVarNumber("sw_func_skybox") == 1 then

		if !SW.SkyPaint or !SW.SkyPaint:IsValid() then

			SW.SkyPaint = ents.Create("env_skypaint")
			SW.SkyPaint:Spawn()
			SW.SkyPaint:Activate()

		-- else

			-- local tab = SW.SkyPaint:GetSaveTable()

			-- SW.SkyPaint:SetKeyValue( "bottomcolor" , tab["bottomcolor"] )
			-- SW.SkyPaint:SetKeyValue( "drawstars" , tobool( tab["drawstars"] ) )
			-- SW.SkyPaint:SetKeyValue( "duskcolor" , tab["duskcolor"] )
			-- SW.SkyPaint:SetKeyValue( "duskintensity" , tab["duskintensity"] )
			-- SW.SkyPaint:SetKeyValue( "duskscale" , tonumber( tab["duskscale"] ) )
			-- SW.SkyPaint:SetKeyValue( "fadebias" , tonumber( tab["fadebias"] ) )
			-- SW.SkyPaint:SetKeyValue( "hdrscale" , tonumber( tab["hdrscale"] ) )
			-- SW.SkyPaint:SetKeyValue( "starfade" , tonumber( tab["starfade"] ) )
			-- SW.SkyPaint:SetKeyValue( "starscale" , tonumber( tab["starscale"] ) )
			-- SW.SkyPaint:SetKeyValue( "sunsize" , tonumber( tab["starspeed"] ) )
			-- SW.SkyPaint:SetKeyValue( "startexture" , tostring( tab["startexture"] ) )
			-- SW.SkyPaint:SetKeyValue( "suncolor" , tab["suncolor"] )
			-- SW.SkyPaint:SetKeyValue( "sunnormal" , tab["sunnormal"] )
			-- SW.SkyPaint:SetKeyValue( "sunposmethod" , tobool( tab["sunposmethod"] ) )
			-- SW.SkyPaint:SetKeyValue( "sunsize" , tonumber( tab["sunsize"] ) )
			-- SW.SkyPaint:SetKeyValue( "topcolor" , tab["topcolor"] )

		end

	end

	-- Some maps have a proprietary jank method of day-night control we need to remove
	if( string.lower( game.GetMap() ) == "rp_evocity_v33x" or string.lower( game.GetMap() ) == "rp_evocity_v4b1" or string.lower( game.GetMap() ) == "rp_evocity2_v5p" or string.lower( game.GetMap() ) == "rp_cosmoscity_v1b" ) then

		for _, v in pairs( ents.FindByName( "daynight_brush" ) ) do

			v:Remove()

		end

	end

end
hook.Add( "InitPostEntity", "SW.InitPostEntity", SW.InitPostEntity )

SW.LastTimePeriod = SW_TIME_NIGHT

function SW.GetRealTime()

	local tab = os.date( "*t" )

	return GetConVarNumber("sw_time_real_offset") + tab.hour + tab.min / 60 + tab.sec / 3600

end

function SW.DayNightThink()

	if table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then
	
		return
		
	end

	if( GetConVarNumber("sw_time_pause") == 0 ) then

		if( SW.Time >= 20 or SW.Time < 4 ) then

			SW.Time = SW.Time + FrameTime() * GetConVarNumber("sw_time_speed_night")

		else

			SW.Time = SW.Time + FrameTime() * GetConVarNumber("sw_time_speed_day")

		end

		if( GetConVarNumber("sw_time_real") == 1 ) then

			SW.Time = SW.GetRealTime()

		end

	end

	if( SW.Time >= 24 ) then

		SW.Time = 0

	end

	if( !SW.NextClientUpdate or CurTime() > SW.NextClientUpdate ) then

		net.Start( "SW.nSetTime" )
		net.WriteFloat( SW.Time )
		net.Broadcast()
		SW.NextClientUpdate = CurTime() + GetConVarNumber("sw_perf_updatedelay_client")

	end

	local mul = 0 -- Credit to looter's atmos addon for this math

	if( SW.Time >= 4 and SW.Time < 12 ) then

		mul = math.EaseInOut( ( SW.Time - 4 ) / 8, 0, 1 )

	elseif( SW.Time >= 12 and SW.Time < 20 ) then

		mul = math.EaseInOut( 1 - ( SW.Time - 12 ) / 8, 1, 0 )

	end

	local s = string.char( math.Round( Lerp( mul, string.byte( GetConVarString("sw_light_max_night") ), string.byte( GetConVarString("sw_light_max_day") ) ) ) )

	if( SW.WeatherMode != "" ) then

		s = string.char( math.Round( Lerp( mul, string.byte( GetConVarString("sw_light_max_night") ), string.byte( GetConVarString("sw_light_max_storm") ) ) ) )

	end

	SW.UpdateLightStyle( s )

	if GetConVarNumber("sw_func_sun") == 1 and SW.EnvSun and SW.EnvSun:IsValid() then

		if( !SW.NextSunUpdate or CurTime() > SW.NextSunUpdate ) then

			if( SW.Time > 4 and SW.Time < 20 and SW.WeatherMode == "" ) then

				local mul = 1 - ( SW.Time - 4 ) / 16
				SW.EnvSun:SetKeyValue( "sun_dir", tostring( Angle( -180 * mul, 20, 0 ):Forward() ) )

			end

			if( SW.WeatherMode != "" or SW.Time < 4 or SW.Time > 20 ) then

				if !SW.EnvSun.Off then

					SW.EnvSun:Fire( "TurnOff" )
					SW.EnvSun.Off = true

				end

			else

				if SW.EnvSun.Off then

					SW.EnvSun:Fire( "TurnOn" )
					SW.EnvSun.Off = false

				end

			end

			SW.NextSunUpdate = CurTime() + GetConVarNumber("sw_perf_updatedelay_sun")

		end

	end

	local t = math.floor( SW.Time )
	if t != SW.LastHookHour then
		SW.LastHookHour = t
		hook.Call( "OnHour", GAMEMODE, t )
	end

	if SW.Time < 6 then

		SW.LastTimePeriod = SW_TIME_DUSK

	elseif SW.Time < 18 then

		if( SW.LastTimePeriod != SW_TIME_DAWN ) then

			if( GetConVarNumber("sw_func_maplogic") == 1 ) then

				for _, v in pairs( ents.FindByName( "dawn" ) ) do

					v:Fire( "Trigger" )

				end

				for _, v in pairs( ents.FindByName( "day_events" ) ) do

					v:Fire( "Trigger" )

				end

				if( string.lower( game.GetMap() ) == "rp_harbor2ocean_catalyst2_v3" ) then

					for _, v in pairs( ents.FindByName( "amblol2" ) ) do v:Fire( "TurnOn" ) end
					for _, v in pairs( ents.FindByName( "1" ) ) do v:Fire( "TurnOn" ) end
					for _, v in pairs( ents.FindByName( "lamps`" ) ) do v:Fire( "TurnOn" ) end

				end

				if( string.lower( game.GetMap() ) == "rp_cosmoscity_v1b" ) then

					for _, v in pairs( ents.FindByName( "ocrp_sun" ) ) do v:Fire( "TurnOn" ) end
					for _, v in pairs( ents.FindByName( "ocrp_lights`" ) ) do v:Fire( "TurnOn" ) end

				end

			end

			hook.Call( "WeatherDay", GAMEMODE )

		end

		SW.LastTimePeriod = SW_TIME_DAWN

	else

		if SW.LastTimePeriod != SW_TIME_DUSK then

			if GetConVarNumber("sw_func_maplogic") == 1 then

				for _, v in pairs( ents.FindByName( "dusk" ) ) do

					v:Fire( "Trigger" )

				end

				for _, v in pairs( ents.FindByName( "night_events" ) ) do

					v:Fire( "Trigger" )

				end

				if string.lower( game.GetMap() ) == "rp_harbor2ocean_catalyst2_v3" then

					for _, v in pairs( ents.FindByName( "amblol2" ) ) do v:Fire( "TurnOff" ) end
					for _, v in pairs( ents.FindByName( "1" ) ) do v:Fire( "TurnOff" ) end
					for _, v in pairs( ents.FindByName( "lamps`" ) ) do v:Fire( "TurnOff" ) end

				end

				if( string.lower( game.GetMap() ) == "rp_cosmoscity_v1b" ) then

					for _, v in pairs( ents.FindByName( "ocrp_sun" ) ) do v:Fire( "TurnOff" ) end
					for _, v in pairs( ents.FindByName( "ocrp_lights`" ) ) do v:Fire( "TurnOff" ) end

				end

			end

			hook.Call( "WeatherNight", GAMEMODE )

		end

		SW.LastTimePeriod = SW_TIME_DUSK

	end

	if( GetConVarNumber("sw_func_skybox") == 1 and SW.SkyPaint and SW.SkyPaint:IsValid() ) then
		
		if( !SW.NextSkyUpdate or CurTime() > SW.NextSkyUpdate ) then

			SW.NextSkyUpdate = CurTime() + GetConVarNumber("sw_perf_updatedelay_sky")
			
			local skypaintstart
			local skypaintend
			local skypaintlerp = 1
			
			if( SW.WeatherMode != "" and !SW.GetCurrentWeather().DefaultSky ) then
				
				if( SW.Time >= 20 or SW.Time <= 4 ) then
					
					skypaintstart = SW_TIME_WEATHER_NIGHT
					skypaintend = SW_TIME_WEATHER_NIGHT
					
				elseif( SW.Time < 6 ) then
					
					skypaintstart = SW_TIME_WEATHER_NIGHT
					skypaintend = SW_TIME_WEATHER
					skypaintlerp = ( SW.Time - 4 ) / 2
					
				elseif( SW.Time < 18 ) then
					
					skypaintstart = SW_TIME_WEATHER
					skypaintend = SW_TIME_WEATHER
					
				elseif( SW.Time < 20 ) then
					
					skypaintstart = SW_TIME_WEATHER
					skypaintend = SW_TIME_WEATHER_NIGHT
					skypaintlerp = ( SW.Time - 18 ) / 2
					
				end
				
				if( SW.GetCurrentWeather().FogColor ) then
					
					local c = SW.GetCurrentWeather().FogColor
					
					if( skypaintend == SW_TIME_WEATHER ) then
						skypaintend = SW_TIME_FOG
					end
					
					if( skypaintstart == SW_TIME_WEATHER ) then
						skypaintstart = SW_TIME_FOG
					end
					
					SW.SkyPaint:SetStarTexture( "skybox/clouds" )
					SW.SkyPaint:SetStarScale( 1 )
					SW.SkyPaint:SetStarFade( 0 )
					SW.SkyPaint:SetStarSpeed( 0.03 )
					
				else
					
					SW.SkyPaint:SetStarTexture( "skybox/clouds" )
					SW.SkyPaint:SetStarScale( 1 )
					SW.SkyPaint:SetStarFade( 0.4 )
					SW.SkyPaint:SetStarSpeed( 0.03 )
					
				end
				
			else
				
				if( SW.Time < 4 ) then
					
					skypaintstart = SW_TIME_NIGHT
					skypaintend = SW_TIME_NIGHT
					
				elseif( SW.Time < 6 ) then
					
					skypaintstart = SW_TIME_NIGHT
					skypaintend = SW_TIME_DAWN
					skypaintlerp = ( SW.Time - 4 ) / 2
					
				elseif( SW.Time < 10 ) then
					
					skypaintstart = SW_TIME_DAWN
					skypaintend = SW_TIME_AFTERNOON
					skypaintlerp = ( SW.Time - 6 ) / 4
					
				elseif( SW.Time < 18 ) then
					
					skypaintstart = SW_TIME_AFTERNOON
					skypaintend = SW_TIME_AFTERNOON
					skypaintlerp = 1
					
				elseif( SW.Time < 20 ) then
					
					skypaintstart = SW_TIME_AFTERNOON
					skypaintend = SW_TIME_DUSK
					skypaintlerp = ( SW.Time - 18 ) / 2
					
				elseif( SW.Time < 22 ) then
					
					skypaintstart = SW_TIME_DUSK
					skypaintend = SW_TIME_NIGHT
					skypaintlerp = ( SW.Time - 20 ) / 2
					
				else
					
					skypaintstart = SW_TIME_NIGHT
					skypaintend = SW_TIME_NIGHT
					
				end
				
				SW.SkyPaint:SetStarTexture( "skybox/starfield" )
				SW.SkyPaint:SetStarScale( 0.5 )
				SW.SkyPaint:SetStarFade( 1.5 )
				SW.SkyPaint:SetStarSpeed( GetConVarNumber("sw_time_speed_stars") )
				
			end
			
			local values = { }
			
			if( skypaintstart == SW_TIME_FOG ) then
				
				local c = SW.GetCurrentWeather().FogColor
				values.TopColor = Vector( c.r / 255, c.g / 255, c.b / 255 )
				values.BottomColor = Vector( c.r / 255, c.g / 255, c.b / 255 )
				
			else
				
				values.TopColor = Vector()
				values.TopColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.r, SW.SkyColors[skypaintend].TopColor.r )
				values.TopColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.g, SW.SkyColors[skypaintend].TopColor.g )
				values.TopColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.b, SW.SkyColors[skypaintend].TopColor.b )
				
				values.BottomColor = Vector()
				values.BottomColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.r, SW.SkyColors[skypaintend].BottomColor.r )
				values.BottomColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.g, SW.SkyColors[skypaintend].BottomColor.g )
				values.BottomColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.b, SW.SkyColors[skypaintend].BottomColor.b )
				
			end
			
			values.FadeBias = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].FadeBias, SW.SkyColors[skypaintend].FadeBias )
			values.HDRScale = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].HDRScale, SW.SkyColors[skypaintend].HDRScale )
			
			values.DuskIntensity = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskIntensity, SW.SkyColors[skypaintend].DuskIntensity )
			values.DuskScale = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskScale, SW.SkyColors[skypaintend].DuskScale )
			
			values.DuskColor = Vector()
			values.DuskColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskColor.r, SW.SkyColors[skypaintend].DuskColor.r )
			values.DuskColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskColor.g, SW.SkyColors[skypaintend].DuskColor.g )
			values.DuskColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].DuskColor.b, SW.SkyColors[skypaintend].DuskColor.b )
			
			values.SunColor = Vector()
			values.SunColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunColor.r, SW.SkyColors[skypaintend].SunColor.r )
			values.SunColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunColor.g, SW.SkyColors[skypaintend].SunColor.g )
			values.SunColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunColor.b, SW.SkyColors[skypaintend].SunColor.b )
			
			values.SunSize = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].SunSize, SW.SkyColors[skypaintend].SunSize )
			
			SW.SkyPaint:SetTopColor( values.TopColor )
			SW.SkyPaint:SetBottomColor( values.BottomColor )
			SW.SkyPaint:SetFadeBias( values.FadeBias )
			SW.SkyPaint:SetHDRScale( values.HDRScale )
			SW.SkyPaint:SetDuskIntensity( values.DuskIntensity )
			SW.SkyPaint:SetDuskScale( values.DuskScale )
			SW.SkyPaint:SetDuskColor( values.DuskColor )
			SW.SkyPaint:SetSunColor( values.SunColor )
			
			if( SW.Time > 4 and SW.Time < 20 and SW.Weather == "" ) then

				SW.SkyPaint:SetSunSize( values.SunSize )

			else

				SW.SkyPaint:SetSunSize( 0 )

			end
			
		end
		
	end
	
end

function SW.SetTime( t )

	SW.Time = t

	local mul = 0

	if( SW.Time >= 4 and SW.Time < 12 ) then

		mul = math.EaseInOut( ( SW.Time - 4 ) / 8, 0, 1 )

	elseif( SW.Time >= 12 and SW.Time < 20 ) then

		mul = math.EaseInOut( 1 - ( SW.Time - 12 ) / 8, 1, 0 )

	end

	local s = string.char( math.Round( Lerp( mul, string.byte( GetConVarString("sw_light_max_night") ), string.byte( GetConVarString("sw_light_max_day") ) ) ) )

	if( SW.WeatherMode != "" ) then

		s = string.char( math.Round( Lerp( mul, string.byte( GetConVarString("sw_light_max_night") ), string.byte( GetConVarString("sw_light_max_storm") ) ) ) )

	end

	SW.UpdateLightStyle( s )

	if SW.EnvSun and SW.EnvSun:IsValid() then

		SW.EnvSun:SetKeyValue( "sun_dir", "1 0 0" )

	end

end

if( GetConVarNumber("sw_time_real") == 1 ) then

	SW.Time = SW.GetRealTime()

end

function SW.PauseTime( b )

	ConVar("sw_time_pause"):SetBool( b )

end