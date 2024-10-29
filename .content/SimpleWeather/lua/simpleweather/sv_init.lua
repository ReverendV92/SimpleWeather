
SW = SW or { }
SW.OldWindValues = SW.OldWindValues or { }

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_daynight.lua" )
AddCSLuaFile( "sh_weathereffects.lua" )
include( "sv_daynight.lua" )
include( "sh_weathereffects.lua" )

local IsSinglePlayer = game.SinglePlayer()

function SW.LoadWeathers()

	if !SW.Weathers then

		SW.Weathers = { }

	end
	
	local tab = file.Find( "simpleweather/weather/*.lua", "LUA" )

	for _, v in pairs( tab ) do
		
		AddCSLuaFile( "simpleweather/weather/" .. v )
		
		WEATHER = { }
		
		include( "simpleweather/weather/" .. v )
		
		SW.Weathers[WEATHER.ID] = WEATHER

		-- if SERVER and WEATHER.ConVar and not IsSinglePlayer then

			--CreateClientConVar( WEATHER.ConVar[1], "1" )
			--CreateConVar( WEATHER.ConVar[1] , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , WEATHER.ConVar[0] , "0" , "1" )

		-- end
		
		WEATHER = nil
		
	end

end
SW.LoadWeathers()

function SW.GetCurrentWeather()
	
	if !SW.Weathers then
		SW.Weathers = { }
	end
	
	if !SW.Weathers[SW.WeatherMode] then
		return { }
	end
	
	return SW.Weathers[SW.WeatherMode]
	
end

SW.WeatherMode = ""
SW.NextRandomWeather = math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60, GetConVarNumber("sw_autoweather_maxstart") * 60 )

function SW.SetWeather( s )

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	SW.WeatherMode = s
	SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_autoweather_maxstart") * 60 * 60 )

	---------------------------------------------
	---------------------------------------------
	-- Wind Shenanigans
	---------------------------------------------
	---------------------------------------------

	-- Clear Weather Reset
	if s == "" then

		-- Reset the env_wind to default so we don't keep multiplying 
		for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

			local scale = SW.GetCurrentWeather().WindScale

			v:SetKeyValue( "minwind" , SW.OldWindValues["minwind"] )
			v:SetKeyValue( "maxwind" , SW.OldWindValues["maxwind"] )
			v:SetKeyValue( "mingust" , SW.OldWindValues["mingust"] )
			v:SetKeyValue( "maxgust" , SW.OldWindValues["maxgust"] )
			v:SetKeyValue( "mingustdelay" , SW.OldWindValues["mingustdelay"] )
			v:SetKeyValue( "maxgustdelay" , SW.OldWindValues["maxgustdelay"] )
			v:SetKeyValue( "gustduration" , SW.OldWindValues["gustduration"] )
			v:SetKeyValue( "gustdirchange" , SW.OldWindValues["gustdirchange"] )
			-- print("reset minwind " .. tostring( v:GetInternalVariable("minwind") ) )
			-- print("reset maxwind " .. tostring( v:GetInternalVariable("maxwind") ) )

		end

		SW.ResetSnowTextureSettings()
	end

	-- Run the env_wind scaling
	if s != "" and SW.GetCurrentWeather().WindScale and GetConVarNumber("sw_func_wind") == 1 then

		for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

			local scale = SW.GetCurrentWeather().WindScale

			v:SetKeyValue( "minwind" , SW.OldWindValues["minwind"] * scale )
			v:SetKeyValue( "maxwind" , SW.OldWindValues["maxwind"] * scale )
			v:SetKeyValue( "mingust" , SW.OldWindValues["mingust"] * scale )
			v:SetKeyValue( "maxgust" , SW.OldWindValues["maxgust"] * scale )
			v:SetKeyValue( "mingustdelay" , SW.OldWindValues["mingustdelay"] * scale )
			v:SetKeyValue( "maxgustdelay" , SW.OldWindValues["maxgustdelay"] * scale )
			v:SetKeyValue( "gustduration" , SW.OldWindValues["gustduration"] * scale )
			v:SetKeyValue( "gustdirchange" , SW.OldWindValues["gustdirchange"] * scale )
			-- print("current minwind " .. tostring( v:GetInternalVariable("minwind") ) )
			-- print("current maxwind " .. tostring( v:GetInternalVariable("maxwind") ) )

		end

	end

	-- Run the Broadcast sound
	if s != "" and SW.GetCurrentWeather().Broadcast and GetConVarNumber("sw_weather_eas") != 0 then

		-- Create our model table
		local RadioModelTable = {}

		-- Find the common HL2 radio
		for k , v in pairs( ents.FindByModel( "models/props_lab/citizenradio.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end
		-- Find the HL2 speakers
		for k , v in pairs( ents.FindByModel( "models/props_wasteland/speakercluster01a.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end

		-- Find the HL2 vehicles
		for k , v in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do
			table.insert( RadioModelTable , v )
		end
		for k , v in pairs( ents.FindByClass( "prop_vehicle_airboat" ) ) do
			table.insert( RadioModelTable , v )
		end

		-- Find the CS_Office radio
		for k , v in pairs( ents.FindByModel( "models/props/cs_office/radio.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end

		-- Find the DoD:S radio
		for k , v in pairs( ents.FindByModel( "models/props_misc/german_radio.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end

		-- Find the BMS radios
		for k , v in pairs( ents.FindByModel( "models/props_marines/army_radio.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end
		for k , v in pairs( ents.FindByModel( "models/props_marines/prc77_radio.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end

		-- Find the Insurgency: MIC radios
		for k , v in pairs( ents.FindByModel( "models/props/radio01.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end
		for k , v in pairs( ents.FindByModel( "models/generic/radio.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end

		for k , v in pairs( ents.FindByModel( "models/props_generic/loudspeaker.mdl" ) ) do
			table.insert( RadioModelTable , v )
		end

		-- Find our radio models
		for k , RadioModels in pairs( RadioModelTable ) do
			-- Give anyone who knows the EAS/EBS a heart attack
			RadioModels:EmitSound( SW.GetCurrentWeather().Broadcast )
		end

		if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sv_init - SW.SetWeather - EAS Radios Added") end

	end

	---------------------------------------------
	---------------------------------------------
	-- Particle Shenanigans
	---------------------------------------------
	---------------------------------------------

	-- OUT WITH THE OLD
	for k , v in pairs( ents.FindByName("sw_particlesys") ) do

		if IsValid(v) then

			SafeRemoveEntity(v)

			if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sv_init - SW.SetWeather - Removed old SW particle systems") end

		end

	end

	-- AND IN WITH THE NEW
	if SW.GetCurrentWeather().ParticleSystem and GetConVarNumber("sw_func_particle_type") == 1 then

		SW.ParticleSys = ents.Create( "info_particle_system" )

		SW.ParticleSys:SetKeyValue( "targetname" , "sw_particlesys" )
		SW.ParticleSys:SetKeyValue( "flag_as_weather" , "1" )
		SW.ParticleSys:SetKeyValue( "start_active" , "1" )
		SW.ParticleSys:SetKeyValue( "effect_name" , tostring(SW.GetCurrentWeather().ParticleSystem) )

		SW.ParticleSys:Spawn()
		SW.ParticleSys:Activate()

		if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sv_init - SW.SetWeather - Added new SW particle systems") end

	end

	---------------------------------------------
	---------------------------------------------
	-- Weather function calls
	---------------------------------------------
	---------------------------------------------

	-- Run the OnStart function
	if s != "" and SW.GetCurrentWeather().OnStart then

		SW.GetCurrentWeather():OnStart()

	end

	-- Run the OnEnd function
	if s == "" and SW.GetCurrentWeather().OnEnd then

		SW.GetCurrentWeather():OnEnd()

	end

	net.Start( "SW.nSetWeather" )
		net.WriteString( s )
	net.Broadcast()

end

util.AddNetworkString( "SW.nSetWeather" )
util.AddNetworkString( "SW.nRedownloadLightmaps" )

hook.Add( "PostCleanupMap" , "SW.CleanupReset" , function() 

	SW.SetWeather("")

	if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sv_init - PostCleanupMap - Reset to defaults") end

end)

function SW.ThinkSV()

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	SW.DayNightThink()

	if GetConVarNumber("sw_autoweather") != 0 and CurTime() > SW.NextRandomWeather then

		if SW.WeatherMode == "" then

			SW.SetWeather( table.Random( SW.AutoWeatherTypes ) )
			SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstop") * 60 * 60, GetConVarNumber("sw_autoweather_maxstop") * 60 * 60 )
			-- SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstop") * 60, GetConVarNumber("sw_autoweather_maxstop") * 60 )
			SW.GetCurrentWeather().Advisory = -1

			if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sv_init::SW.Think::AutoWeather Started") end

		else

			SW.SetWeather( "" )
			SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60, GetConVarNumber("sw_autoweather_maxstart") * 60 )
			-- SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60 , GetConVarNumber("sw_autoweather_maxstart") * 60 )

			if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sv_init::SW.Think::AutoWeather Stopped") end

		end

	end

	if SW.GetCurrentWeather().Think then

		SW.GetCurrentWeather():Think()

	end

	----------------------------------------
	----------------------------------------
	-- Weather Spawn Positions
	-- SW.SkyPositions
	----------------------------------------
	----------------------------------------

	if !SW.SkyPositions then

		SW.SkyPositions = { }

	end

	if !SW.SkyPositionsTall then

		SW.SkyPositionsTall = { }

	end

	for _, v in pairs( player.GetAll() ) do

		if !v.NextSkyPositionLog then

			v.NextSkyPositionLog = CurTime()

		end

		if CurTime() >= v.NextSkyPositionLog then

			v.NextSkyPositionLog = CurTime() + 1

			-- This was hard-coded to be on top of the player, and now it isn't. -V92
			local trace = { }
			-- trace.start = v:EyePos()
			trace.start = v:GetPos() + v:GetForward() * math.random( -8192 , 8192 ) + v:GetRight() * math.random( -8192 , 8192 )
			trace.endpos = trace.start + Vector( 0, 0, 32768 )
			trace.mask = MASK_VISIBLE
			local tr = util.TraceLine( trace )

			if tr.HitSky or tr.HitNoDraw or GetConVarNumber("sw_weather_alwaysoutside") == 1 then

				local p = tr.HitPos + Vector( 0, 0, -1 )

				local good = true

				for _, v in pairs( SW.SkyPositions ) do

					if( v:Distance( p ) < 100 ) then

						good = false

					end

				end

				if good then

					local trace = { }
					trace.start = p
					trace.endpos = p + Vector( 0, 0, -32768 )
					trace.filter = { }
					local tr = util.TraceLine( trace )

					if tr.HitPos:Distance( p ) >= 300 then

						table.insert( SW.SkyPositionsTall , p )

					end

					table.insert( SW.SkyPositions , p )

				end

			end

		end

	end
end
hook.Add( "Think", "SW.ThinkSV", SW.ThinkSV )

function SW.PlayerInitialSpawn( ply )

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	if GetConVarNumber("sw_func_skybox") != 0 then

		RunConsoleCommand( "sv_skyname", "painted" )

	end

	net.Start( "SW.nSetWeather" )
		net.WriteString( SW.WeatherMode )
	net.Send( ply )

	if( SW.FogSettings and GetConVarNumber("sw_func_fog") == 1 ) then
		
		net.Start( "SW.nInitFogSettings" )
			net.WriteUInt( SW.FogSettings["FogStart"], 32 )
			net.WriteUInt( SW.FogSettings["FogEnd"], 32 )
			net.WriteFloat( SW.FogSettings["MaxDensity"] )
			net.WriteUInt( SW.FogSettings["r"], 8 )
			net.WriteUInt( SW.FogSettings["g"], 8 )
			net.WriteUInt( SW.FogSettings["b"], 8 )
		net.Send( ply )

	end

	if( SW.SkyboxFogSettings and GetConVarNumber("sw_func_fog") == 1 ) then
		
		net.Start( "SW.nInitSkyboxFogSettings" )
			net.WriteUInt( SW.SkyboxFogSettings["FogStart"], 32 )
			net.WriteUInt( SW.SkyboxFogSettings["FogEnd"], 32 )
			net.WriteFloat( SW.SkyboxFogSettings["MaxDensity"] )
			net.WriteUInt( SW.SkyboxFogSettings["r"], 8 )
			net.WriteUInt( SW.SkyboxFogSettings["g"], 8 )
			net.WriteUInt( SW.SkyboxFogSettings["b"], 8 )
		net.Send( ply )
		
	end

end
hook.Add( "PlayerInitialSpawn", "SW.PlayerInitialSpawn", SW.PlayerInitialSpawn )

function SW.PostInitEntitySV()

	SW.raincount = ents.FindByClass( "func_precipitation" )
	-- print("SW RainCount: " .. #SW.raincount)

	if GetConVarNumber("sw_func_precip") != 0 then
		SW.FuncPrecip = ents.FindByClass( "func_precipitation" )
		for k , v in pairs( SW.FuncPrecip ) do
			v:Remove()
		end
	end

	SW.LoadWeathers()

end
hook.Add( "InitPostEntity", "SW.PostInitEntitySV", SW.PostInitEntitySV )
hook.Add( "PostCleanupMap", "SW.PostInitEntitySV", SW.PostInitEntitySV )

function SW.Move( ply, mv )

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	if SW.GetCurrentWeather().Move then
		
		SW.GetCurrentWeather():Move( ply, mv )
		
	end
	
end
hook.Add( "Move", "SW.Move", SW.Move )

local emeta = FindMetaTable( "Entity" )
local meta = FindMetaTable( "Player" )

function emeta:IsOutside()

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	if GetConVarNumber("sw_weather_alwaysoutside") == 1 then return true end
	
	local trace = { }
	trace.start = self:GetPos() + self:OBBCenter()
	trace.endpos = trace.start + Vector( 0, 0, 32768 )
	trace.filter = self
	local tr = util.TraceLine( trace )
	
	if( tr.HitSky or tr.HitNoDraw ) then 

		return true 

	end
	
	return false
	
end

function meta:IsOutside()

	-- If SimpleWeather is disabled...
	if GetConVarNumber("sw_func_master") != 1 then return end

	if GetConVarNumber("sw_weather_alwaysoutside") == 1 then 

		return true 

	end
	
	local trace = { }
	trace.start = self:EyePos()
	trace.endpos = trace.start + Vector( 0, 0, 32768 )
	trace.mask = MASK_VISIBLE
	local tr = util.TraceLine( trace )
	
	if( tr.StartSolid ) then return false end
	if( tr.HitSky or tr.HitNoDraw ) then return true end
	
	return false
	
end
