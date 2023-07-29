local function SWAdminMessage( ply, msg )
	
	if( ply and ply:IsValid() ) then
		
		ply:PrintMessage( 2, msg );
		
	else
		
		MsgN( msg );
		
	end
	
end

local function Weather( ply, cmd, args )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( ply and ply:IsValid() and !ply:IsAdmin() ) then
		
		ply:PrintMessage( 2, "You need to be admin to do this!" );
		return;
		
	end
	
	if( args[1] == "none" ) then
		
		args[1] = "";
		
	end
	
	if( args[1] == "" or SW.Weathers[args[1]] ) then
		
		SW.SetWeather( args[1] );
		
	else
		
		SWAdminMessage( ply, "ERROR: invalid weather type \"" .. tostring( args[1] ) .. "\" specified." );
		
	end
	
end
concommand.Add( "sw_weather", Weather, function()
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return { } end
	
	local tab = { };
	
	for k, _ in pairs( SW.Weathers ) do
		
		table.insert( tab, "sw_weather " .. k );
		
	end
	
	table.insert( tab, "sw_weather none" );
	
	return tab;
	
end, "Change the weather." );

local function StopWeather( ply, cmd, args )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( ply and ply:IsValid() and !ply:IsAdmin() ) then
		
		ply:PrintMessage( 2, "You need to be admin to do this!" );
		return;
		
	end
	
	SW.SetWeather( "" );
	
end
concommand.Add( "sw_stopweather", StopWeather, function() return { } end, "Stop the weather." );

local function AutoWeather( ply, cmd, args )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( ply and ply:IsValid() and !ply:IsAdmin() ) then
		
		ply:PrintMessage( 2, "You need to be admin to do this!" );
		return;
		
	end
	
	if( args[1] == "0" ) then
		
		SW.AutoWeatherEnabled = false;
		
	elseif( args[1] == "1" ) then
		
		SW.AutoWeatherEnabled = true;
		
	else
		
		SWAdminMessage( ply, "ERROR: invalid auto-weather status \"" .. tostring( args[1] ) .. "\" specified." );
		
	end
	
end
concommand.Add( "sw_autoweather", AutoWeather, function() return { "sw_autoweather 0", "sw_autoweather 1" } end, "Change auto-weather on or off." );

local function SetTime( ply, cmd, args )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( ply and ply:IsValid() and !ply:IsAdmin() ) then
		
		ply:PrintMessage( 2, "You need to be admin to do this!" );
		return;
		
	end
	
	if( tonumber( args[1] ) and tonumber( args[1] ) >= 0 and tonumber( args[1] ) <= 24 ) then
		
		SW.SetTime( tonumber( args[1] ) );
		
	else
		
		SWAdminMessage( ply, "ERROR: invalid time \"" .. tostring( args[1] ) .. "\" specified." );
		
	end
	
end
concommand.Add( "sw_settime", SetTime, function() return { "sw_settime (0-24)" } end, "Set the time of day." );

local function EnableTime( ply, cmd, args )
	
	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( ply and ply:IsValid() and !ply:IsAdmin() ) then
		
		ply:PrintMessage( 2, "You need to be admin to do this!" );
		return;
		
	end
	
	if( args[1] == "0" ) then
		
		SW.PauseTime( true );
		
	elseif( args[1] == "1" ) then
		
		SW.PauseTime( false );
		
	else
		
		SWAdminMessage( ply, "ERROR: invalid value \"" .. tostring( args[1] ) .. "\" specified." );
		
	end
	
end
concommand.Add( "sw_enabletime", EnableTime, function() return { "sw_pausetime 0", "sw_pausetime 1" } end, "Change the passage of time on or off." );