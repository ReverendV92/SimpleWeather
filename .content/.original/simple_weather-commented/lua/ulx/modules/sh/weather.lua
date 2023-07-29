SW.ULXAccess = ULib.ACCESS_SUPERADMIN -- Whatever access level you want

function ulx.weather( ply, type )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( type == "" or type == "none" or SW.Weathers[type] ) then
		
		if( type == "none" ) then
			SW.SetWeather( "" )
		else
			SW.SetWeather( type )
		end
		
		ulx.fancyLogAdmin( ply, "#A set weather to #s", type )
		
	else
		
		local s = "none "
		
		for k, v in pairs( SW.Weathers ) do
			s = s .. k .. " "
		end
		
		ply:PrintMessage( 2, "ERROR: invalid weather type \"" .. type .. "\" specified.\nValid weathers: " .. s .. "\n" )
		
	end
	
end
local weather = ulx.command( "SimpleWeather", "ulx weather", ulx.weather, "!weather" )
weather:addParam{ type=ULib.cmds.StringArg, hint="type" }
weather:defaultAccess( SW.ULXAccess )
weather:help( "Change the weather." )

function ulx.stopweather( ply )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.SetWeather( "" )
	ulx.fancyLogAdmin( ply, "#A turned off weather" )
	
end
local weather = ulx.command( "SimpleWeather", "ulx stopweather", ulx.stopweather, "!stopweather" )
weather:defaultAccess( SW.ULXAccess )
weather:help( "Stop the weather." )

function ulx.autoweather( ply, enabled )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	-- SW.AutoWeatherEnabled = enabled
	ConVar("sw_sv_autoweather"):SetBool( 1 )
	ulx.fancyLogAdmin( ply, "#A set auto-weather to #s", tostring( enabled ) )
	
end
local weather = ulx.command( "SimpleWeather", "ulx autoweather", ulx.autoweather, "!autoweather" )
weather:addParam{ type=ULib.cmds.BoolArg, hint="enabled" }
weather:defaultAccess( SW.ULXAccess )
weather:help( "Change auto-weather on or off." )

function ulx.settime( ply, time )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.SetTime( time )
	ulx.fancyLogAdmin( ply, "#A set time to #s", tostring( time ) )
	
end
local weather = ulx.command( "SimpleWeather", "ulx settime", ulx.settime, "!settime" )
weather:addParam{ type=ULib.cmds.NumArg, min=0, max=24, default=0, hint="time", error="invalid time \"%s\" specified", ULib.cmds.restrictToCompletes }
weather:defaultAccess( SW.ULXAccess )
weather:help( "Change the time." )

function ulx.enabletime( ply, enabled )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.PauseTime( !enabled )
	ulx.fancyLogAdmin( ply, "#A set the passage of time to #s", tostring( enabled ) )
	
end
local weather = ulx.command( "SimpleWeather", "ulx enabletime", ulx.enabletime, "!enabletime" )
weather:addParam{ type=ULib.cmds.BoolArg, hint="enabled" }
weather:defaultAccess( SW.ULXAccess )
weather:help( "Change the passage of time on or off." )
