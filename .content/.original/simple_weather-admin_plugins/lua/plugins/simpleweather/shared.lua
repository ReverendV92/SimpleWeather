
if SERVER then

	local plugin = plugin

	plugin:IncludeFile( "shared.lua", SERVERGUARD.STATE.SHARED )

end

plugin.unique = "simpleweather"

plugin.name = "SimpleWeather"
plugin.author = "disseminate"
plugin.version = "1.0"
plugin.description = "Official SimpleWeather serverguard plugin."
plugin.permissions = { "Administrator" }

local command = {}

command.help = "Change the weather."
command.command = "weather"
command.arguments = { "weather" }
command.permissions = "Administrator"

function command:Execute( ply, bSilent, args )

	local type = args[1]

	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( type == "" or type == "none" or SW.Weathers[type] ) then
		
		if( type == "none" ) then
			SW.SetWeather( "" )
		else
			SW.SetWeather( type )
		end
		
		if( !bSilent ) then
			serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " set weather to ", SERVERGUARD.NOTIFY.GREEN, type, SERVERGUARD.NOTIFY.WHITE, ".")
		end
		
	else
		
		local s = "none "
		
		for k, v in pairs( SW.Weathers ) do
			s = s .. k .. " "
		end
		
		serverguard.Notify( ply, SERVERGUARD.NOTIFY.RED, "ERROR: invalid weather type \"", SERVERGUARD.NOTIFY.WHITE, type, SERVERGUARD.NOTIFY.RED, "\" specified.\nValid weathers: " .. s )
		
	end

end

plugin:AddCommand( command )

local command = {}

command.help = "Stop the weather."
command.command = "stopweather"
command.arguments = { }
command.permissions = "Administrator"

function command:Execute( ply, bSilent, args )

	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.SetWeather( "" )
	if( !bSilent ) then
		serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " stopped the weather.")
	end

end

plugin:AddCommand( command )

local command = {}

command.help = "Change auto-weather on or off."
command.command = "autoweather"
command.arguments = { "enabled" }
command.permissions = "Administrator"

function command:Execute( ply, bSilent, args )

	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	local enabled = tobool( args[1] )

	ConVar("sw_autoweather"):SetBool( 1 )
	if( !bSilent ) then
		if( enabled ) then
			serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " enabled autoweather.")
		else
			serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " disabled autoweather.")
		end
	end

end

plugin:AddCommand( command )

local command = {}

command.help = "Change the time."
command.command = "settime"
command.arguments = { "time (0-24)" }
command.permissions = "Administrator"

function command:Execute( ply, bSilent, args )

	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	local time = tonumber( args[1] )
	time = math.Clamp( time, 0, 24 )
	
	SW.SetTime( time )
	if( !bSilent ) then
		serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " set time to ", SERVERGUARD.NOTIFY.GREEN, "" .. time, SERVERGUARD.NOTIFY.WHITE, ".")
	end

end

plugin:AddCommand( command )

local command = {}

command.help = "Toggle the passage of time."
command.command = "enabletime"
command.arguments = { "enabled" }
command.permissions = "Administrator"

function command:Execute( ply, bSilent, args )

	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	local enabled = tobool( args[1] )
	
	SW.PauseTime( !enabled )
	if( !bSilent ) then
		if( enabled ) then
			serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " enabled the passage of time.")
		else
			serverguard.Notify( nil, SERVERGUARD.NOTIFY.GREEN, ply:Name(), SERVERGUARD.NOTIFY.WHITE, " disabled the passage of time.")
		end
	end

end

if CLIENT then

plugin:IncludeFile( "shared.lua", SERVERGUARD.STATE.CLIENT )

end

plugin:AddCommand( command )
