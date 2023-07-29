SW = SW or { }
SW.OldWindValues = SW.OldWindValues or { }

function SW.LoadWeathers()
	
	if( !SW.Weathers ) then
		SW.Weathers = { }
	end
	
	local tab = file.Find( "simpleweather/weather/*.lua", "LUA" )

	for _, v in pairs( tab ) do
		
		AddCSLuaFile( "simpleweather/weather/" .. v )
		
		WEATHER = { }
		
		include( "simpleweather/weather/" .. v )
		
		SW.Weathers[WEATHER.ID] = WEATHER
		
		WEATHER = nil
		
	end

end

function SW.GetCurrentWeather()
	
	if( !SW.Weathers ) then
		SW.Weathers = { }
	end
	
	if( !SW.Weathers[SW.WeatherMode] ) then
		return { }
	end
	
	return SW.Weathers[SW.WeatherMode]
	
end

function SW.Initialize()
	
	SW.LoadWeathers()
	
end
hook.Add( "InitPostEntity", "SW.Initialize", SW.Initialize )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_clock.lua" )
AddCSLuaFile( "cl_daynight.lua" )
AddCSLuaFile( "cl_texture.lua" )
AddCSLuaFile( "simpleweather_config.lua" )
AddCSLuaFile( "sh_admin.lua" )

include( "simpleweather_config.lua" )
include( "sv_daynight.lua" )
include( "sh_admin.lua" )

SW.WeatherMode = ""
-- SW.NextRandomWeather = math.Rand( SW.AutoMinTimeStartWeather * 60 * 60, SW.AutoMaxTimeStartWeather * 60 * 60 )
SW.NextRandomWeather = math.Rand( GetConVarNumber("sw_sv_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_sv_autoweather_maxstart") * 60 * 60 )

function SW.SetWeather( s )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( s == "" and SW.GetCurrentWeather().OnEnd ) then

		SW.GetCurrentWeather():OnEnd()

	end
	
	SW.WeatherMode = s
	-- SW.NextRandomWeather = CurTime() + math.Rand( SW.AutoMinTimeStartWeather * 60 * 60, SW.AutoMaxTimeStartWeather * 60 * 60 )
	SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_sv_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_sv_autoweather_maxstart") * 60 * 60 )
	
	if( s != "" and SW.GetCurrentWeather().OnStart ) then
		
		SW.GetCurrentWeather():OnStart()
		
		if WEATHER.WindScale then

			for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

				local baseValues = v:GetKeyValues( )
				local scale = WEATHER.WindScale

				v:SetKeyValue( "minwind" , baseValues["minwind"] * scale )
				v:SetKeyValue( "maxwind" , baseValues["maxwind"] * scale )
				v:SetKeyValue( "mingust" , baseValues["mingust"] * scale )
				v:SetKeyValue( "maxgust" , baseValues["maxgust"] * scale )
				v:SetKeyValue( "mingustdelay" , baseValues["mingustdelay"] * scale )
				v:SetKeyValue( "maxgustdelay" , baseValues["maxgustdelay"] * scale )
				v:SetKeyValue( "gustduration" , baseValues["gustduration"] * scale )
				v:SetKeyValue( "gustdirchange" , baseValues["gustdirchange"] * scale )

print(tostring( baseValues["minwind"] ) )
print(tostring( baseValues["maxwind"] ) )

			end

		end

	end
	
	net.Start( "SW.nSetWeather" )
		net.WriteString( s )
	net.Broadcast()
	
end

util.AddNetworkString( "SW.nSetWeather" )
util.AddNetworkString( "SW.nRedownloadLightmaps" )

function SW.Think()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		-- if( SW.AutoWeatherEnabled and CurTime() > SW.NextRandomWeather ) then
		if( GetConVarNumber("sw_sv_autoweather") == 1 and CurTime() > SW.NextRandomWeather ) then
			
			if( SW.WeatherMode == "" ) then
				
				SW.SetWeather( table.Random( SW.AutoWeatherTypes ) )
				-- SW.NextRandomWeather = CurTime() + math.Rand( SW.AutoMinTimeStopWeather * 60 * 60, SW.AutoMaxTimeStopWeather * 60 * 60 )
				SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_sv_autoweather_minstop") * 60 * 60, GetConVarNumber("sw_sv_autoweather_maxstop") * 60 * 60 )
				
			else
				
				SW.SetWeather( "" )
				-- SW.NextRandomWeather = CurTime() + math.Rand( SW.AutoMinTimeStartWeather * 60 * 60, SW.AutoMaxTimeStartWeather * 60 * 60 )
				SW.NextRandomWeather = CurTime() + math.Rand( GetConVarNumber("sw_sv_autoweather_minstart") * 60 * 60, GetConVarNumber("sw_sv_autoweather_maxstart") * 60 * 60 )
				
			end
			
		end
		
		if( SW.GetCurrentWeather().Think ) then
			
			SW.GetCurrentWeather():Think()
			
		end
		
		SW.DayNightThink()
		
		if( !SW.SkyPositions ) then
			
			SW.SkyPositions = { }
			
		end
		
		if( !SW.SkyPositionsTall ) then
			
			SW.SkyPositionsTall = { }
			
		end
		
		for _, v in pairs( player.GetAll() ) do
			
			if( !v.NextSkyPositionLog ) then
				
				v.NextSkyPositionLog = CurTime()
				
			end
			
			if( CurTime() >= v.NextSkyPositionLog ) then
				
				v.NextSkyPositionLog = CurTime() + 1
				
				local trace = { }
				trace.start = v:EyePos()
				trace.endpos = trace.start + Vector( 0, 0, 32768 )
				trace.mask = MASK_PLAYERSOLID_BRUSHONLY
				local tr = util.TraceLine( trace )
				
				-- if( tr.HitSky or tr.HitNoDraw or SW.AlwaysOutside ) then
				if( tr.HitSky or tr.HitNoDraw or GetConVarNumber("sw_sv_alwaysoutside") == 1 ) then
					
					local p = tr.HitPos + Vector( 0, 0, -1 )
					
					local good = true
					
					for _, v in pairs( SW.SkyPositions ) do
						
						if( v:Distance( p ) < 100 ) then
							
							good = false
							
						end
						
					end
					
					if( good ) then
						
						local trace = { }
						trace.start = p
						trace.endpos = p + Vector( 0, 0, -32768 )
						trace.filter = { }
						local tr = util.TraceLine( trace )
						
						if( tr.HitPos:Distance( p ) >= 300 ) then
							
							table.insert( SW.SkyPositionsTall, p )
							
						end
						
						table.insert( SW.SkyPositions, p )
						
					end
					
				end
				
			end
			
		end
		
	end
	
end
hook.Add( "Think", "SW.Think", SW.Think )

function SW.PlayerInitialSpawn( ply )
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		net.Start( "SW.nSetWeather" )
			net.WriteString( SW.WeatherMode )
		net.Send( ply )
		
		-- if( SW.FogSettings and SW.UpdateFog ) then
		if( SW.FogSettings and GetConVarNumber("sw_sv_update_fog") == 1 ) then
			
			net.Start( "SW.nInitFogSettings" )
				net.WriteUInt( SW.FogSettings["FogStart"], 32 )
				net.WriteUInt( SW.FogSettings["FogEnd"], 32 )
				net.WriteFloat( SW.FogSettings["MaxDensity"] )
				net.WriteUInt( SW.FogSettings["r"], 8 )
				net.WriteUInt( SW.FogSettings["g"], 8 )
				net.WriteUInt( SW.FogSettings["b"], 8 )
			net.Send( ply )
			
		end
		
		-- if( SW.SkyboxFogSettings and SW.UpdateFog ) then
		if( SW.SkyboxFogSettings and GetConVarNumber("sw_sv_update_fog") == 1 ) then
			
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
	
end
hook.Add( "PlayerInitialSpawn", "SW.PlayerInitialSpawn", SW.PlayerInitialSpawn )

function SW.Initialize()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		SW.InitDayNight( )

		for k , v in pairs( ents.FindByClass( "env_wind" ) ) do

			local baseValues = SW.OldWindValues
			SW.OldWindValues = baseValues

			v:SetKeyValue( "minwind" , baseValues["minwind"] )
			v:SetKeyValue( "maxwind" , baseValues["maxwind"] )
			v:SetKeyValue( "mingust" , baseValues["mingust"] )
			v:SetKeyValue( "maxgust" , baseValues["maxgust"] )
			v:SetKeyValue( "mingustdelay" , baseValues["mingustdelay"] )
			v:SetKeyValue( "maxgustdelay" , baseValues["maxgustdelay"] )
			v:SetKeyValue( "gustduration" , baseValues["gustduration"] )
			v:SetKeyValue( "gustdirchange" , baseValues["gustdirchange"] )
print(tostring( baseValues["minwind"] ) )
print(tostring( baseValues["maxwind"] ) )

		end

	end
	
end
hook.Add( "Initialize", "SW.Initialize", SW.Initialize )

function SW.Move( ply, mv )
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		if( SW.GetCurrentWeather().Move ) then
			
			SW.GetCurrentWeather():Move( ply, mv )
			
		end
		
	end
	
end
hook.Add( "Move", "SW.Move", SW.Move )

local emeta = FindMetaTable( "Entity" )
local meta = FindMetaTable( "Player" )

function emeta:IsOutside()
	
	-- if( SW.AlwaysOutside ) then return true end
	if GetConVarNumber("sw_sv_alwaysoutside") == 1 then return true end
	
	local trace = { }
	trace.start = self:GetPos() + self:OBBCenter()
	trace.endpos = trace.start + Vector( 0, 0, 32768 )
	trace.filter = self
	local tr = util.TraceLine( trace )
	
	if( tr.HitSky or tr.HitNoDraw ) then return true end
	
	return false
	
end

function meta:IsOutside()
	
	-- if( SW.AlwaysOutside ) then return true end
	if GetConVarNumber("sw_sv_alwaysoutside") == 1 then return true end
	
	local trace = { }
	trace.start = self:EyePos()
	trace.endpos = trace.start + Vector( 0, 0, 32768 )
	trace.mask = MASK_SOLID
	local tr = util.TraceLine( trace )
	
	if( tr.StartSolid ) then return false end
	if( tr.HitSky or tr.HitNoDraw ) then return true end
	
	return false
	
end

-- function SW.PlayerSay( ply, text, team )
	
	-- if( string.lower( text ) == string.lower( SW.ChatCommand ) ) then
	-- if( string.lower( text ) == string.lower( GetConVarString("sw_sv_chatcommand") ) ) then
		
		-- if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
			
			-- net.Start( "SW.nOpenConfigWindow" )
			-- net.Send( ply )
			-- return ""
			
		-- end
		
	-- end
	
-- end
-- hook.Add( "PlayerSay", "SW.PlayerSay", SW.PlayerSay )