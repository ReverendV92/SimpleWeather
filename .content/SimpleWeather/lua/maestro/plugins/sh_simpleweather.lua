maestro.command( "weather", { "string:weather" }, function( caller, var )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return true, "SimpleWeather is disabled on this map." end
	
	if( var == "none" ) then
		
		var = ""
		
	end
	
	if( var == "" or SW.Weathers[var] ) then
		
		SW.SetWeather( var )
		
	else
		
		return true, "Invalid weather type \"" .. var .. "\" specified."
		
	end
	
	return false, "set weather to %1"
	
end, "Change the weather." )

maestro.command( "stopweather", { }, function( caller )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return true, "SimpleWeather is disabled on this map." end
	
	SW.SetWeather( "" )
	return false, "stopped weather"
	
end, "Stop the weather." )

maestro.command( "autoweather", { "boolean:on" }, function( caller, val )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return true, "SimpleWeather is disabled on this map." end

	GetConVarNumber("sw_autoweather") = tobool( val )
	return false, "set auto-weather to %1"
	
end, "Change auto-weather on or off." )

maestro.command( "settime", { "number:time" }, function( caller, val )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return true, "SimpleWeather is disabled on this map." end
	
	if( val >= 0 and val <= 24 ) then
		
		SW.SetTime( val )
		return false, "set time to %1"
		
	end
	
	return true, "Invalid time \"" .. tostring( val ) .. "\" specified."
	
end, "Change auto-weather on or off." )

maestro.command( "enabletime", { "boolean:on" }, function( caller, val )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return true, "SimpleWeather is disabled on this map." end
	
	SW.PauseTime( tobool( val ) )
	return false, "set the passage of time to %1"
	
end, "Change the passage of time on or off." )
