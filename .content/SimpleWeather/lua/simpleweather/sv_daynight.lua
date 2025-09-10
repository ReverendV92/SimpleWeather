-- oh god oh fuck oh man this file is DOGSHIT
-- there is SO MUCH SPAGHETTI CODE

-- FLOAT = RGB / 255
-- RGB = FLOAT * 255

SW.Time = GetConVarNumber("sw_time_start")
if SW.Time == -1 then

	SW.Time = math.Rand( 0 , 23 )

end

SW_TIME_DAWN = 6
SW_TIME_AFTERNOON = 12
SW_TIME_DUSK = 18
SW_TIME_NIGHT = 20

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
	["TopColor"]		= Vector( 0.04 , 0.28 , 0.53 ) ,
	["BottomColor"]		= Vector( 0.6 , 0.9 , 1 ) ,
	["FadeBias"]		= 0.2 ,
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
	["FadeBias"]		= 0.3 ,
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
	["FadeBias"]		= 0.2 ,
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

-- Convert our menu-friendly integers to engine-compatible alphabeticals
local tblLightingConversion = {
	[1] = "a" ,
	[2] = "b" ,
	[3] = "c" ,
	[4] = "d" ,
	[5] = "e" ,
	[6] = "f" ,
	[7] = "g" ,
	[8] = "h" ,
	[9] = "i" ,
	[10] = "j" ,
	[11] = "k" ,
	[12] = "l" ,
	[13] = "m" ,
	[14] = "n" ,
	[15] = "o" ,
	[16] = "p" ,
	[17] = "q" ,
	[18] = "r" ,
	[19] = "s" ,
	[20] = "t" ,
	[21] = "u" ,
	[22] = "v" ,
	[23] = "w" ,
	[24] = "x" ,
	[25] = "y" ,
	[26] = "z"
}
SW_LIGHT_DAY = tblLightingConversion[GetConVarNumber("sw_light_day_brightness")]
SW_LIGHT_NIGHT = tblLightingConversion[GetConVarNumber("sw_light_night_brightness")]
SW_LIGHT_STORM = tblLightingConversion[GetConVarNumber("sw_light_storm_brightness")]

SW.LastLightStyle = ""

util.AddNetworkString( "SW.nInitFogSettings" )
util.AddNetworkString( "SW.nInitSkyboxFogSettings" )
util.AddNetworkString( "SW.nSetTime" )
util.AddNetworkString( "SW.nOpenConfigWindow" )

function SW.UpdateLightStyle( strLightStyle )

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	if GetConVarNumber("sw_func_lighting") == 1 and SW.LastLightStyle != strLightStyle then

		if( SW.LightEnvironment and SW.LightEnvironment:IsValid() ) then

			SW.LightEnvironment:Fire( "FadeToPattern" , strLightStyle )

		else

			engine.LightStyle( 0 , strLightStyle )

			timer.Simple( 0.05 , function()

				net.Start( "SW.nRedownloadLightmaps" )
				net.Broadcast()

			end )

		end

		-- print("Updating light style to: " .. strLightStyle )
		SW.LastLightStyle = strLightStyle

	end

end

function SW.InitPostEntitySV()

	-- Find any existing env_wind entities
	SW.EnvWind = ents.FindByClass( "env_wind" )[1]

	-- If we didn't find an env_wind or it isn't valid, create one
	if !IsValid(SW.EnvWind) then

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

	-- Cache the default env_wind keyvalues so we can call back to them later and reset them
	for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

		-- Cache the defaults so we can call upon them later
		SW.OldWindValues = v:GetKeyValues( )

	end

	SW.SkyPaint = ents.FindByClass( "env_skypaint" )[1]
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

	SW.EnvSun = ents.FindByClass( "env_sun" )[1]
	if GetConVarNumber("sw_func_sun") == 1 and IsValid(SW.EnvSun) then

		SW.EnvSun:SetKeyValue( "sun_dir", "1 0 0" )

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

	else

		SW.EnvSun = ents.Create("env_sun")
		SW.EnvSun:Spawn()
		SW.EnvSun:Activate()

	end

	SW.LightEnvironment = ents.FindByClass( "light_environment" )[1]
	
	SW.EnvFog = ents.FindByClass( "env_fog_controller" )[1]
	SW.SkyCam = ents.FindByClass( "sky_camera" )[1]
	if GetConVarNumber("sw_func_fog") == 1 then

		if IsValid(SW.EnvFog) then

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

		if IsValid(SW.SkyCam) then

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

	SW.UpdateLightStyle( SW_LIGHT_NIGHT )

end
hook.Add( "InitPostEntity", "SW.InitPostEntitySV", SW.InitPostEntitySV )

------------------------------
------------------------------

SW.LastTimePeriod = SW_TIME_NIGHT

function SW.GetRealTime()

	local tab = os.date( "*t" )

	return GetConVarNumber("sw_time_real_offset") + tab.hour + tab.min / 60 + tab.sec / 3600

end

function SW.DayNightThink()

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	if GetConVarNumber("sw_time_pause") == 0 then

		-- if( SW.Time >= 20 or SW.Time < 4 ) then
		if( SW.Time >= SW_TIME_DUSK or SW.Time < SW_TIME_DAWN ) then

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

	-- Disseminate: Credit to looter's atmos addon for this math
	-- V92: this is a mess and I hate this
	local mul = 0 

	-- if( SW.Time >= 4 and SW.Time < 12 ) then
	if( SW.Time >= SW_TIME_DAWN and SW.Time < (SW_TIME_DAWN + 2) ) then

		-- mul = math.EaseInOut( ( SW.Time - 4 ) / 8, 0, 1 )
		mul = math.EaseInOut( ( SW.Time - SW_TIME_DAWN ) / ( SW_TIME_DAWN + 2 ) , 0, 1 )

	-- elseif( SW.Time >= 12 and SW.Time < 20 ) then
	elseif( SW.Time >= SW_TIME_DUSK and SW.Time < (SW_TIME_DUSK + 2) ) then

		-- mul = math.EaseInOut( 1 - ( SW.Time - 12 ) / 8, 1, 0 )
		mul = math.EaseInOut( 1 - ( SW.Time - SW_TIME_DUSK ) / ( SW_TIME_DUSK + 2 ), 1, 0 )

	else

		if SW.Time >= SW_TIME_DUSK or SW.Time < SW_TIME_DAWN then
			mul = 0
		else
			mul = 1
		end

	end

	--------------------
	-- Map Logic Checks
	--------------------
	if SW.Time >= SW_TIME_NIGHT or SW.Time < SW_TIME_DAWN then

		-- print("Map Logic: NIGHT")
		-- Run the NIGHT map logic (4)
		SW.LastTimePeriod = SW_TIME_NIGHT
		SW.DNCUpdate( 4 )
		hook.Call( "WeatherDay", GAMEMODE )

	end

	if SW.Time >= SW_TIME_DAWN and SW.Time < SW_TIME_AFTERNOON then

		-- print("Map Logic: DAWN")
		-- Run the DAWN map logic (1)
		SW.LastTimePeriod = SW_TIME_DAWN
		SW.DNCUpdate( 1 )
		hook.Call( "WeatherDay", GAMEMODE )

	end

	if SW.Time >= SW_TIME_AFTERNOON and SW.Time < SW_TIME_DUSK then

		-- print("Map Logic: AFTERNOON")
		-- Run the AFTERNOON map logic (2)
		SW.LastTimePeriod = SW_TIME_AFTERNOON
		SW.DNCUpdate( 2 )
		hook.Call( "WeatherDay", GAMEMODE )

	end
	
	if SW.Time >= SW_TIME_DUSK and SW.Time < SW_TIME_NIGHT then
	
		-- print("Map Logic: DUSK")
		-- Run the DUSK map logic (3)
		SW.LastTimePeriod = SW_TIME_DUSK
		SW.DNCUpdate( 3 )
		hook.Call( "WeatherDay", GAMEMODE )

	end

	-----------------------
	-- Light Style Updates
	-----------------------
	
	-- Default Light Style
	local strLightStyle = string.char( math.Round( Lerp( mul , string.byte( SW_LIGHT_NIGHT ), string.byte( SW_LIGHT_DAY ) ) ) )
	strWeatherLightStyleDay = SW.GetCurrentWeather().LightStyleDay or "" 
	strWeatherLightStyleNight = SW.GetCurrentWeather().LightStyleNight or ""

	-- If there is a weather and they don't use the default sky...
	if SW.WeatherMode != "" then

		-- If the weather has a custom light style...
		if SW.GetCurrentWeather().LightStyleDay == true then
			strWeatherLightStyleDay = SW.GetCurrentWeather().LightStyleDay
		end

		-- If the weather has a custom night light style...
		if SW.GetCurrentWeather().LightStyleNight == true then
			strWeatherLightStyleNight = SW.GetCurrentWeather().LightStyleNight
		end

		-- This is probably a bad way to do this, but meh
		if SW.GetCurrentWeather().LightStyleNight == true and SW.GetCurrentWeather().LightStyleDay == true then

			-- print( "Weather has a custom day and night style." )
			strLightStyle = string.char( math.Round( Lerp( mul , string.byte( strWeatherLightStyleNight ), string.byte( strWeatherLightStyleDay ) ) ) )

		elseif SW.GetCurrentWeather().LightStyleNight == true and SW.GetCurrentWeather().LightStyleDay == false then

			-- print( "Weather has a custom night style." )
			strLightStyle = string.char( math.Round( Lerp( mul , string.byte( SW_LIGHT_NIGHT ), string.byte( strWeatherLightStyleDay ) ) ) )

		elseif SW.GetCurrentWeather().LightStyleNight == false and SW.GetCurrentWeather().LightStyleDay == true then

			-- print( "Weather has a custom day style." )
			strLightStyle = string.char( math.Round( Lerp( mul , string.byte( strWeatherLightStyleNight ), string.byte( SW_LIGHT_DAY ) ) ) )

		end

	else
	
		-- Basic old function...
		strLightStyle = string.char( math.Round( Lerp( mul , string.byte( SW_LIGHT_NIGHT ), string.byte( SW_LIGHT_STORM ) ) ) )

		-- print("Default weather. Light style is: " .. strLightStyle )
	end

	SW.UpdateLightStyle( strLightStyle )

	if GetConVarNumber("sw_func_sun") == 1 then

		if( !SW.NextSunUpdate or CurTime() > SW.NextSunUpdate ) then

			-- if( SW.Time > 4 and SW.Time < 20 and SW.GetCurrentWeather().ShowEnvSun != false ) then
			if( SW.Time > SW_TIME_DAWN and SW.Time < SW_TIME_DUSK and SW.GetCurrentWeather().ShowEnvSun != false ) then

				-- local mul = 1 - ( SW.Time - SW_TIME_DAWN ) / 16
				local mul = 1 - ( SW.Time - SW_TIME_DAWN ) / ( SW_TIME_DUSK - SW_TIME_DAWN )
				SW.EnvSun:SetKeyValue( "sun_dir", tostring( Angle( -180 * mul, 20, 0 ):Forward() ) )

			end

			-- if( SW.GetCurrentWeather().ShowEnvSun == false or SW.Time < 4 or SW.Time > 20 ) then
			if( SW.GetCurrentWeather().ShowEnvSun == false or SW.Time < SW_TIME_DAWN or SW.Time > SW_TIME_DUSK ) then

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

	if GetConVarNumber("sw_func_skybox") == 1 and IsValid(SW.SkyPaint) then

		if( !SW.NextSkyUpdate or CurTime() > SW.NextSkyUpdate ) then

			SW.NextSkyUpdate = CurTime() + GetConVarNumber("sw_perf_updatedelay_sky")

			local skypaintstart
			local skypaintend
			local skypaintlerp = 1

			if( SW.WeatherMode != "" and SW.GetCurrentWeather().DefaultSky != true ) then
		
				-- DUSK to NIGHT transition
				if( SW.Time >= SW_TIME_DUSK or SW.Time <= SW_TIME_NIGHT ) then
					
					skypaintstart = SW_TIME_WEATHER --_DUSK
					skypaintend = SW_TIME_WEATHER_NIGHT
					skypaintlerp = ( SW.Time - SW_TIME_DUSK ) / 2

				-- NIGHT to DAWN transition
				elseif( SW.Time <= SW_TIME_NIGHT or SW.Time <= SW_TIME_DAWN ) then

					skypaintstart = SW_TIME_WEATHER_NIGHT
					skypaintend = SW_TIME_WEATHER --_DAWN
					skypaintlerp = ( SW.Time - SW_TIME_DAWN ) / 2

				-- DAWN to AFTERNOON transition
				elseif( SW.Time <= SW_TIME_DAWN or SW.Time <= SW_TIME_AFTERNOON ) then

					skypaintstart = SW_TIME_WEATHER --_DAWN
					skypaintend = SW_TIME_WEATHER --_AFTERNOON
					skypaintlerp = ( SW.Time - SW_TIME_DAWN ) / 2
					
				-- AFTERNOON to DUSK transition
				elseif( SW.Time <= SW_TIME_AFTERNOON or SW.Time <= SW_TIME_DUSK ) then
					
					skypaintstart = SW_TIME_WEATHER --_AFTERNOON
					skypaintend = SW_TIME_WEATHER --_DUSK
					skypaintlerp = ( SW.Time - SW_TIME_AFTERNOON ) / 2

				end

				if( SW.GetCurrentWeather().FogColor ) then

					local c = SW.GetCurrentWeather().FogColor
					
					if( skypaintend == SW_TIME_WEATHER ) then

						skypaintend = SW_TIME_FOG

					end
					
					if( skypaintstart == SW_TIME_WEATHER ) then

						skypaintstart = SW_TIME_FOG

					end

				end
				
			else

				if( SW.Time <= 4 ) then
					
					skypaintstart = SW_TIME_NIGHT
					skypaintend = SW_TIME_NIGHT
					
				-- elseif( SW.Time <= 6 ) then
					-- skypaintstart = SW_TIME_NIGHT
					-- skypaintend = SW_TIME_DAWN
					-- skypaintlerp = ( SW.Time - 4 ) / 2

				elseif( SW.Time <= 8 ) then
					
					skypaintstart = SW_TIME_NIGHT
					skypaintend = SW_TIME_DAWN
					skypaintlerp = ( SW.Time - 4 ) / 4
					
				elseif( SW.Time <= 10 ) then
					
					skypaintstart = SW_TIME_DAWN
					skypaintend = SW_TIME_AFTERNOON
					skypaintlerp = ( SW.Time - 6 ) / 4

				elseif( SW.Time <= 16 ) then
					
					skypaintstart = SW_TIME_AFTERNOON
					skypaintend = SW_TIME_AFTERNOON
					skypaintlerp = 1

				-- elseif( SW.Time <= 18 ) then

					-- skypaintstart = SW_TIME_AFTERNOON
					-- skypaintend = SW_TIME_AFTERNOON
					-- skypaintlerp = 1

				elseif( SW.Time <= 18 ) then
					
					skypaintstart = SW_TIME_AFTERNOON
					skypaintend = SW_TIME_DUSK
					skypaintlerp = ( SW.Time - 16 ) / 2

				-- elseif( SW.Time <= 20 ) then
					
					-- skypaintstart = SW_TIME_AFTERNOON
					-- skypaintend = SW_TIME_DUSK
					-- skypaintlerp = ( SW.Time - 18 ) / 2

				elseif( SW.Time <= 20 ) then
					
					skypaintstart = SW_TIME_DUSK
					skypaintend = SW_TIME_NIGHT
					skypaintlerp = ( SW.Time - 18 ) / 2

				-- elseif( SW.Time <= 22 ) then

					-- skypaintstart = SW_TIME_DUSK
					-- skypaintend = SW_TIME_NIGHT
					-- skypaintlerp = ( SW.Time - 20 ) / 2
					
				else
					
					skypaintstart = SW_TIME_NIGHT
					skypaintend = SW_TIME_NIGHT
					
				end

			end
			
			local values = { }
			
			if( skypaintstart == SW_TIME_FOG ) then
		
				local c = SW.GetCurrentWeather().FogColor
				values.TopColor = Vector( c.r / 255, c.g / 255, c.b / 255 )
				values.BottomColor = Vector( c.r / 255, c.g / 255, c.b / 255 )
				
			else

				-- New
				-- values.TopColor = SW.SkyColors[skypaintstart].TopColor:Lerp( SW.SkyColors[skypaintend].TopColor, skypaintlerp )
				-- values.BottomColor = SW.SkyColors[skypaintstart].BottomColor:Lerp( SW.SkyColors[skypaintend].BottomColor, skypaintlerp )

				-- Old
				values.TopColor = Vector()
				values.TopColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.r, SW.SkyColors[skypaintend].TopColor.r )
				values.TopColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.g, SW.SkyColors[skypaintend].TopColor.g )
				values.TopColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].TopColor.b, SW.SkyColors[skypaintend].TopColor.b )

				values.BottomColor = Vector()
				values.BottomColor.x = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.r, SW.SkyColors[skypaintend].BottomColor.r )
				values.BottomColor.y = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.g, SW.SkyColors[skypaintend].BottomColor.g )
				values.BottomColor.z = Lerp( skypaintlerp, SW.SkyColors[skypaintstart].BottomColor.b, SW.SkyColors[skypaintend].BottomColor.b )

			end

			-- New
			-- values.FadeBias = SW.SkyColors[skypaintstart].FadeBias:Lerp( SW.SkyColors[skypaintend].FadeBias, skypaintlerp )
			-- values.HDRScale = SW.SkyColors[skypaintstart].HDRScale:Lerp( SW.SkyColors[skypaintend].HDRScale, skypaintlerp )
			-- values.DuskIntensity = SW.SkyColors[skypaintstart].DuskIntensity:Lerp( SW.SkyColors[skypaintend].DuskIntensity, skypaintlerp )
			-- values.DuskScale = SW.SkyColors[skypaintstart].DuskScale:Lerp( SW.SkyColors[skypaintend].DuskScale, skypaintlerp )
			-- values.DuskColor = SW.SkyColors[skypaintstart].DuskColor:Lerp( SW.SkyColors[skypaintend].DuskColor, skypaintlerp )
			-- values.SunColor = SW.SkyColors[skypaintstart].SunColor:Lerp( SW.SkyColors[skypaintend].SunColor, skypaintlerp )
			-- values.SunSize = SW.SkyColors[skypaintstart].SunSize:Lerp( SW.SkyColors[skypaintend].SunSize, skypaintlerp )

			-- Old
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
			
			-- if( SW.Time > 4 and SW.Time < 20 and SW.Weather == "" ) then
			if( SW.Time > SW_TIME_DAWN and SW.Time < SW_TIME_DUSK and SW.Weather == "" ) then

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

	if( SW.Time >= SW_TIME_DAWN and SW.Time < SW_TIME_DAWN + 2 ) then

		mul = math.EaseInOut( ( SW.Time - SW_TIME_DAWN ) / 8, 0, 1 )

	elseif( SW.Time >= SW_TIME_DUSK and SW.Time < SW_TIME_DUSK + 2 ) then

		mul = math.EaseInOut( 1 - ( SW.Time - SW_TIME_DUSK ) / 8, 1, 0 )

	end

	------------------------------
	-- Light Style Updates
	------------------------------
	
	-- Default Light Style
	local strLightStyle = string.char( math.Round( Lerp( mul , string.byte( SW_LIGHT_NIGHT ), string.byte( SW_LIGHT_DAY ) ) ) )

	-- If there is a weather and they don't use the default sky...
	if SW.WeatherMode != "" then

		-- If the weather has a custom light style...
		if SW.GetCurrentWeather().LightStyleDay == true then
			strWeatherLightStyleDay = SW.GetCurrentWeather().LightStyleDay
		end

		-- If the weather has a custom night light style...
		if SW.GetCurrentWeather().LightStyleNight == true then
			strWeatherLightStyleNight = SW.GetCurrentWeather().LightStyleNight
		end

		-- This is probably a bad way to do this, but meh
		if SW.GetCurrentWeather().LightStyleNight == true and SW.GetCurrentWeather().LightStyleDay == true then

			strLightStyle = string.char( math.Round( Lerp( mul , string.byte( strWeatherLightStyleNight ), string.byte( strWeatherLightStyleDay ) ) ) )

		elseif SW.GetCurrentWeather().LightStyleNight == true and SW.GetCurrentWeather().LightStyleDay == false then

			strLightStyle = string.char( math.Round( Lerp( mul , string.byte( SW_LIGHT_NIGHT ), string.byte( strWeatherLightStyleDay ) ) ) )

		elseif SW.GetCurrentWeather().LightStyleNight == false and SW.GetCurrentWeather().LightStyleDay == true then

			strLightStyle = string.char( math.Round( Lerp( mul , string.byte( strWeatherLightStyleNight ), string.byte( SW_LIGHT_DAY ) ) ) )

		end

	else
	
		-- Basic old function...
		strLightStyle = string.char( math.Round( Lerp( mul , string.byte( SW_LIGHT_NIGHT ), string.byte( SW_LIGHT_STORM ) ) ) )

	end

	SW.UpdateLightStyle( strLightStyle )

	if IsValid(SW.EnvSun) then

		SW.EnvSun:SetKeyValue( "sun_dir", "1 0 0" )

	end

end

if( GetConVarNumber("sw_time_real") == 1 ) then

	SW.Time = SW.GetRealTime()

end

function SW.PauseTime( b )

	ConVar("sw_time_pause"):SetBool( b )

end

-- Day and Night Swap Functions
function SW.DNCUpdate( int )

	-- 1=Dawn
	if int == 1 then

		if( GetConVarNumber("sw_func_maplogic") == 1 ) then

			-- Run the DAWN map logic (1)
			SW.MapLogic( 1 )

		end

		SW.SkyPaint:SetStarTexture( "skybox/clouds" )
		SW.SkyPaint:SetStarLayers( 1 )
		SW.SkyPaint:SetStarScale( 1 )
		SW.SkyPaint:SetStarFade( 0.4 )
		SW.SkyPaint:SetStarSpeed( 0.03 )

		-- todo: env_sun sprite to sun

	end

	-- 2=Noon
	if int == 2 then

		if( GetConVarNumber("sw_func_maplogic") == 1 ) then

			-- Run the NOON map logic (2)
			SW.MapLogic( 2 )

		end

		SW.SkyPaint:SetStarTexture( "skybox/clouds" )
		SW.SkyPaint:SetStarLayers( 1 )
		SW.SkyPaint:SetStarScale( 1 )
		SW.SkyPaint:SetStarFade( 0.4 )
		SW.SkyPaint:SetStarSpeed( 0.03 )

	end

	-- 3=Dusk
	if int == 3 then

		if( GetConVarNumber("sw_func_maplogic") == 1 ) then

			-- Run the DUSK map logic (3)
			SW.MapLogic( 3 )

		end

		SW.SkyPaint:SetStarTexture( "skybox/starfield" )
		SW.SkyPaint:SetStarScale( 0.5 )
		SW.SkyPaint:SetStarFade( 1.5 )
		-- SW.SkyPaint:SetStarSpeed( GetConVarNumber("sw_time_speed_stars") )
		SW.SkyPaint:SetStarSpeed( 0.01 )

		-- todo: env_sun sprite to moon

	end

	-- 4=Midnight
	if int == 4 then

		if( GetConVarNumber("sw_func_maplogic") == 1 ) then

			-- Run the MIDNIGHT map logic (4)
			SW.MapLogic( 4 )

		end

		SW.SkyPaint:SetStarTexture( "skybox/starfield" )
		SW.SkyPaint:SetStarScale( 0.5 )
		SW.SkyPaint:SetStarFade( 1.5 )
		-- SW.SkyPaint:SetStarSpeed( GetConVarNumber("sw_time_speed_stars") )
		SW.SkyPaint:SetStarSpeed( 0.01 )

		-- todo: env_sun sprite to moon

	end

end

-- Map-Specific Logic
function SW.MapLogic( int )

	-- 1=Dawn
	if int == 1 then

		for _, v in pairs( ents.FindByName( "dawn" ) ) do

			v:Fire( "Trigger" )

		end

		for _, v in pairs( ents.FindByName( "day_events" ) ) do

			v:Fire( "Trigger" )

		end

		if( string.lower( game.GetMap() ) == "rp_flatgrass_redux" ) then

			for _, v in pairs( ents.FindByName( "dnc_toggle" ) ) do

				v:Fire( "FireUser2" )

			end

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

	-- 2=Noon
	if int == 2 then

		for _, v in pairs( ents.FindByName( "noon" ) ) do

			v:Fire( "Trigger" )

		end

		for _, v in pairs( ents.FindByName( "noon_events" ) ) do

			v:Fire( "Trigger" )

		end

		if( string.lower( game.GetMap() ) == "rp_flatgrass_redux" ) then

			for _, v in pairs( ents.FindByName( "dnc_toggle" ) ) do

				v:Fire( "FireUser2" )

			end

		end

	end

	-- 3=Dusk
	if int == 3 then

		for _, v in pairs( ents.FindByName( "dusk" ) ) do

			v:Fire( "Trigger" )

		end

		for _, v in pairs( ents.FindByName( "night_events" ) ) do

			v:Fire( "Trigger" )

		end

		if( string.lower( game.GetMap() ) == "rp_flatgrass_redux" ) then

			for _, v in pairs( ents.FindByName( "dnc_toggle" ) ) do

				v:Fire( "FireUser1" )

			end

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

	-- 4=Midnight
	if int == 4 then

		for _, v in pairs( ents.FindByName( "midnight" ) ) do

			v:Fire( "Trigger" )

		end

		for _, v in pairs( ents.FindByName( "midnight_events" ) ) do

			v:Fire( "Trigger" )

		end

		if( string.lower( game.GetMap() ) == "rp_flatgrass_redux" ) then

			for _, v in pairs( ents.FindByName( "dnc_toggle" ) ) do

				v:Fire( "FireUser1" )

			end

		end

	end

end
