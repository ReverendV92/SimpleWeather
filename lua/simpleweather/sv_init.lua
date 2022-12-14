
SW = SW or { }
SW.OldWindValues = SW.OldWindValues or { }

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_daynight.lua" )
AddCSLuaFile( "cl_texture.lua" )
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

		if SERVER and WEATHER.ConVar and not IsSinglePlayer then

			--CreateClientConVar( WEATHER.ConVar[1], "1" )
			--CreateConVar( WEATHER.ConVar[1] , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , WEATHER.ConVar[0] , "0" , "1" )

		end
		
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

function SW.Initialize()

	-- Find any existing env_wind entities
	for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

		-- Cache the defaults so we can call upon them later
		SW.OldWindValues = v:GetKeyValues( )
		-- PrintTable(SW.OldWindValues)
		-- print("base minwind " .. tostring( v:GetInternalVariable("minwind") ) )
		-- print("base maxwind " .. tostring( v:GetInternalVariable("maxwind") ) )

	end

	SW.LoadWeathers()

end
hook.Add( "InitPostEntity", "SW.Initialize", SW.Initialize )

SW.WeatherMode = ""
SW.NextRandomWeather = math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_autoweather_maxstart") * 60 * 60 )

function SW.SetWeather( s )

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then return end

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

	end

	SW.WeatherMode = s
	SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_autoweather_maxstart") * 60 * 60 )

	-- Run the Broadcast sound
	if s != "" and SW.GetCurrentWeather().Broadcast and GetConVarNumber("sw_weather_eas") != 0 then

		-- Create our model table
		local RadioModelTable = {}

		-- Find the common HL2 radio
		for k , ctr in pairs( ents.FindByModel( "models/props_lab/citizenradio.mdl" ) ) do

			-- print("HL2")
			-- Add it to the table
			table.insert( RadioModelTable , ctr )

		end

		-- Find the CS_Office radio
		for k , ofr in pairs( ents.FindByModel( "models/props/cs_office/radio.mdl" ) ) do

			-- print("office")
			-- Add it to the table
			table.insert( RadioModelTable , ofr )

		end

		-- Find our radio models
		for k , RadioModels in pairs( RadioModelTable ) do

			print(RadioModels:GetModel())
			-- Give anyone who knows the EAS/EBS a heart attack
			RadioModels:EmitSound( SW.GetCurrentWeather().Broadcast )

		end

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

function SW.Think()

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then

		return

	end

	if GetConVarNumber("sw_autoweather") != 0 and CurTime() > SW.NextRandomWeather then

		if SW.WeatherMode == "" then

			SW.SetWeather( table.Random( SW.AutoWeatherTypes ) )
			SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstop") * 60 * 60, GetConVarNumber("sw_autoweather_maxstop") * 60 * 60 )
			SW.GetCurrentWeather().Advisory = -1

		else

			SW.SetWeather( "" )
			SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_autoweather_maxstart") * 60 * 60 )

		end

	end

	if SW.GetCurrentWeather().Think then

		SW.GetCurrentWeather():Think()

	end

	SW.DayNightThink()

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
			trace.mask = MASK_PLAYERSOLID_BRUSHONLY
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
hook.Add( "Think", "SW.Think", SW.Think )

function SW.PlayerInitialSpawn( ply )

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then

		return

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

function SW.Initialize()

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then

		return

	end

	SW.InitDayNight( )

end
hook.Add( "Initialize", "SW.Initialize", SW.Initialize )

function SW.Move( ply, mv )

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then

		return

	end

	if SW.GetCurrentWeather().Move then
		
		SW.GetCurrentWeather():Move( ply, mv )
		
	end
	
end
hook.Add( "Move", "SW.Move", SW.Move )

local emeta = FindMetaTable( "Entity" )
local meta = FindMetaTable( "Player" )

function emeta:IsOutside()

	if GetConVarNumber("sw_func_master") != 1 then return false end
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

	if table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) or GetConVarNumber("sw_func_master") != 1 then

		return

	end

	if GetConVarNumber("sw_weather_alwaysoutside") == 1 then 

		return true 

	end
	
	local trace = { }
	trace.start = self:EyePos()
	trace.endpos = trace.start + Vector( 0, 0, 32768 )
	trace.mask = MASK_SOLID
	local tr = util.TraceLine( trace )
	
	if( tr.StartSolid ) then return false end
	if( tr.HitSky or tr.HitNoDraw ) then return true end
	
	return false
	
end
