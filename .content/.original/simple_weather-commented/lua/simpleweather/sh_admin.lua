
----------------------------------------
----------------------------------------
-- WEATHER SETTINGS
----------------------------------------
----------------------------------------

CreateClientConVar( "sw_cl_showweather", "1" , true , false , "(BOOL) Display weathers." , "0" , "1" )

CreateConVar( "sw_sv_autoweather" , "0" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Enable auto-weather\n(i.e. automatically cycling between weather)." , "0" , "1" )
CreateConVar( "sw_sv_autoweather_minstart" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Minimum time in hours before weather begins." , "1" , "8" )
CreateConVar( "sw_sv_autoweather_maxstart" , "3" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Maximum time in hours before weather begins." , "1" , "8" )
CreateConVar( "sw_sv_autoweather_minstop" , "0.2" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Minimum time in hours before weather stops." , "0" , "8" )
CreateConVar( "sw_sv_autoweather_maxstop" , "8" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Maximum time in hours before weather stops." , "1" , "8" )

CreateConVar( "sw_sv_alwaysoutside" , "0" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Should players be considered outside at all times\n(ie. if you want snow in an indoor map)? " , "0" , "1" )

CreateClientConVar( "sw_cl_rain_screen", "1" , true , false , "(BOOL) Show rain on screen." , "0" , "1" )
CreateClientConVar( "sw_cl_rain_dropsize_min", "20" , true , false , "(INT) Minimum size of the raindrops on screen." , "10" , "100" )
CreateClientConVar( "sw_cl_rain_dropsize_max", "40" , true , false , "(INT) Maximum size of the raindrops on screen." , "10" , "100" )
CreateClientConVar( "sw_cl_rain_vehicledrops", "0" , true , false , "(BOOL) Show rain on screen when in vehicles." , "0" , "1" )
CreateClientConVar( "sw_cl_rain_showimpact", "1" , true , false , "(BOOL) Make rain splash particle effect." , "0" , "1" )
CreateClientConVar( "sw_cl_rain_showsmoke", "1" , true , false , "(BOOL) Make rain steam particle effect." , "0" , "1" )
CreateClientConVar( "sw_cl_rain_quality", "1" , true , false , "(INT) Rain impact quality." , "1" , "4" )
CreateClientConVar( "sw_cl_rain_height", "300" , true , false , "(INT) Maximum height to make rain." , "0" , "2500" )
CreateClientConVar( "sw_cl_rain_radius", "500" , true , false , "(INT) Radius of rain effect." , "0" , "2500" )
CreateClientConVar( "sw_cl_rain_count", "20" , true , false , "(INT) Amount of particles in rain effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_cl_rain_dietime", "3" , true , false , "(INT) Time in seconds until rain vanishes." , "0" , "16" )

-- CreateClientConVar( "sw_cl_storm_height", "200" , true , false , "(INT) Maximum height to make rain." , "0" , "2500" )
CreateClientConVar( "sw_cl_storm_radius", "500" , true , false , "(INT) Radius of storm effect." , "0" , "2500" )
CreateClientConVar( "sw_cl_storm_count", "120" , true , false , "(INT) Amount of particles in storm effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_cl_storm_dietime", "3" , true , false , "(INT) Time in seconds until storm vanishes." , "0" , "16" )

CreateClientConVar( "sw_cl_snow_height", "200" , true , false , "(INT) Maximum height to make snow." , "0" , "2500" )
CreateClientConVar( "sw_cl_snow_radius", "1200" , true , false , "(INT) Radius of snow effect." , "0" , "2500" )
CreateClientConVar( "sw_cl_snow_count", "20" , true , false , "(INT) Amount of particles in snow effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_cl_snow_dietime", "5" , true , false , "(INT) Time in seconds until snow vanishes." , "0" , "16" )

CreateClientConVar( "sw_cl_blizzard_height", "100" , true , false , "(INT) Maximum height to make blizzard." , "0" , "2500" )
CreateClientConVar( "sw_cl_blizzard_radius", "1000" , true , false , "(INT) Radius of blizzard effect." , "0" , "2500" )
CreateClientConVar( "sw_cl_blizzard_count", "30" , true , false , "(INT) Amount of particles in blizzard effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_cl_blizzard_dietime", "2" , true , false , "(INT) Time in seconds until blizzard vanishes." , "0" , "16" )
CreateClientConVar( "sw_cl_snow_stay", "1" , true , false , "(BOOL) Leave snow on the ground." , "0" , "1" )

CreateConVar( "sw_sv_thunder_mindelay" , "10" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Minimum delay in seconds to cause lightning/thunder while stormy." , "1" , "30" )
CreateConVar( "sw_sv_thunder_maxdelay" , "30" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Maximum delay in seconds to cause lightning/thunder while stormy." , "1" , "30" )
CreateConVar( "sw_sv_lightning_flash" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Enable lightning flashes." , "0" , "1" )

CreateClientConVar( "sw_cl_colormod", "1" , true , false , "(BOOL) Enable colormod when it's cloudy." , "0" , "1" )
CreateClientConVar( "sw_cl_colormod_indoors", "0" , true , false , "(BOOL) Enable colormod indoors." , "0" , "1" )

CreateClientConVar( "sw_cl_sounds", "1" , true , false , "(BOOL) Play sounds." , "0" , "1" )
CreateClientConVar( "sw_cl_fxvolume", "1" , true , false , "(FLOAT) Volume sounds should play at." , "0" , "1" )

CreateConVar( "sw_sv_fog_densityday" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Fog max density during the day." , "0" , "1" )
CreateConVar( "sw_sv_fog_densitynight" , "0.4" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Fog max density during the night." , "0" , "1" )
CreateConVar( "sw_sv_fog_indoors" , "0" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Enable fog when you have a roof over your head." , "0" , "1" )
CreateConVar( "sw_sv_fog_speed" , "0.01" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Speed at which fog appears and disappears.\nDecrease to make fog changes slower." , "0" , "1" )

----------------------------------------
----------------------------------------
-- DAY/NIGHT SETTINGS
----------------------------------------
----------------------------------------

CreateConVar( "sw_sv_enabletime" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Change the passage of time on or off." , "0" , "1" )

-- CreateConVar( "sw_sv_time_start" , "10" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Set start time." , "0" , "23" )

CreateConVar( "sw_sv_realtime" , "0" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Set real-time on or off." , "0" , "1" )
CreateConVar( "sw_sv_realtime_offset" , "0" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) If realtime is on, add this many timezones.\nFor example, if the server was GMT and you set this to -5, it'd be EST ingame." , "-12" , "12" )
CreateConVar( "sw_sv_day_scale" , "0.01" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Multiplier of time during the day.\nMake this bigger for time to go faster, and smaller for time to go slower." , "0" , "1" )
CreateConVar( "sw_sv_night_scale" , "0.02" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Multiplier of time during the night.\nMake this bigger for time to go faster, and smaller for time to go slower." , "0" , "1" )

CreateConVar( "sw_sv_update_lighting" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Enable map lighting updates.\nTurn this off if the map's a night map already!" , "0" , "1" )
CreateConVar( "sw_sv_update_sun" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Enable sun moving through the sky." , "0" , "1" )
CreateConVar( "sw_sv_update_skybox" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Enable the skybox to change color through the day." , "0" , "1" )
CreateConVar( "sw_sv_update_fog" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Turn off fog at night.\nPrevents weird light fog at night - turn it off if weird stuff happens." , "0" , "1" )
CreateConVar( "sw_sv_mapoutputs" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(BOOL) Enable any map-based effects, like lampposts turning off and on." , "0" , "1" )

CreateConVar( "sw_sv_perf_updatedelay_client" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(INT) Delay in seconds between updating the time on the client." , "1" , "60" )
CreateConVar( "sw_sv_perf_updatedelay_sun" , "1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Delay in seconds between updating the sun position.\nSetting this to a smaller number will allow smoother sun movement, but doing this also causes lag." , "0" , "15" )
CreateConVar( "sw_sv_perf_updatedelay_sky" , "0.1" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Delay in seconds between updating the sky colors.\nSetting this to a smaller number will allow smoother transitions, but doing this also causes lag." , "0" , "15" )

CreateConVar( "sw_sv_light_max_night" , "b" , { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_DONTRECORD } , "(a-z) Maximum darkness level during night.\nIncrease to add light. \"a\" is darkest, \"z\" is lightest." )
CreateConVar( "sw_sv_light_max_day" , "y" , { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_DONTRECORD } , "(a-z) Maximum lightness level at noon on a clear day.\nIncrease to add light. \"a\" is darkest, \"z\" is lightest." )
CreateConVar( "sw_sv_light_max_storm" , "j" , { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_DONTRECORD } , "(a-z) Maximum lightness level at noon on a stormy day.\nIncrease to add light. \"a\" is darkest, \"z\" is lightest." )

CreateConVar( "sw_sv_starrotatespeed" , "0.01" , { FCVAR_ARCHIVE , FCVAR_REPLICATED } , "(FLOAT) Set the rotation speed of stars" , "0.01" , "5" )

----------------------------------------
----------------------------------------
-- CLOCK HUD
----------------------------------------
----------------------------------------

CreateClientConVar( "sw_cl_clock_show", "1" , true , false , "(BOOL) Draw clock." , "0" , "1" )
CreateClientConVar( "sw_cl_clock_position", "1" , true , false , "(BOOL) Show HUD at top of screen instead of bottom." , "0" , "1" )
CreateClientConVar( "sw_cl_clock_style", "1" , true , false , "(BOOL) 24 hour clock." , "0" , "1" )

----------------------------------------
----------------------------------------
-- MISC
----------------------------------------
----------------------------------------

-- CreateConVar( "sw_sv_chatcommand" , "!weatheroptions" , { FCVAR_ARCHIVE , FCVAR_REPLICATED , FCVAR_DONTRECORD } , "(STRING) Chat command to use to open client config window." )
CreateClientConVar( "sw_cl_startupdisplay", "0" , true , false , "(BOOL) Show info on opening config when a player joins the server." , "0" , "1" )
CreateClientConVar( "sw_cl_particles_max", "7000" , true , false , "(INT) Maximum number of particles to create at any one time." , "0" , "10000" )

local function SWAdminMessage( ply, msg )
	
	if( ply and ply:IsValid() ) then
		
		ply:PrintMessage( 2, msg )
		
	else
		
		MsgN( msg )
		
	end
	
end

------------------------------

local function Weather( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap( ) ) ) ) then return end

	if( ply and ply:IsValid( ) and !ply:IsAdmin( ) ) then

		ply:PrintMessage( 2 , "You need to be admin to do this!" )
		return

	end

	if( args[1] == "none" ) then

		args[1] = ""

	end

	if( args[1] == "" or SW.Weathers[args[1]] ) then

		SW.SetWeather( args[1] )

	else

		SWAdminMessage( ply , "ERROR: invalid weather type \"" .. tostring( args[1] ) .. "\" specified." )

	end

end
concommand.Add( "sw_weather", Weather, function( )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap( ) ) ) ) then return { } end

	local tab = { }

	for k, _ in pairs( SW.Weathers ) do

		table.insert( tab , "sw_weather " .. k )

	end

	table.insert( tab, "sw_weather none" )

	return tab

end , "Change the weather." , { FCVAR_DONTRECORD } )

------------------------------

local function StopWeather( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap( ) ) ) ) then return end

	if( ply and ply:IsValid() and !ply:IsAdmin( ) ) then

		ply:PrintMessage( 2 , "You need to be admin to do this!" )
		return

	end

	SW.SetWeather( "" )

end
concommand.Add( "sw_stopweather" , StopWeather , function( ) return { } end , "Stop the weather." , { FCVAR_DONTRECORD } )

------------------------------

local function AlwaysOutside( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	if( ply and ply:IsValid() and !ply:IsAdmin() ) then

		ply:PrintMessage( 2, "You need to be admin to do this!" )
		return

	end

	if( args[1] == "0" ) then

		SW.AlwaysOutside = false

	elseif( args[1] == "1" ) then

		SW.AlwaysOutside = true

	else

		SWAdminMessage( ply, "ERROR: invalid always outside status \"" .. tostring( args[1] ) .. "\" specified." )

	end

end
concommand.Add( "sw_sv_alwaysoutside" , AlwaysOutside , function( ) return { "sw_sv_alwaysoutside 0" , "sw_sv_alwaysoutside 1" } end, "Always outside on or off." , { FCVAR_ARCHIVE , FCVAR_REPLICATED } )

------------------------------
--[[
local function AutoWeather( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	if( ply and ply:IsValid() and !ply:IsAdmin() ) then

		ply:PrintMessage( 2, "You need to be admin to do this!" )
		return

	end

	if( args[1] == "0" ) then

		-- SW.AutoWeatherEnabled = false
		ConVar("sw_sv_autoweather"):SetBool(0)

	elseif( args[1] == "1" ) then

		-- SW.AutoWeatherEnabled = true
		ConVar("sw_sv_autoweather"):SetBool(1)

	else

		SWAdminMessage( ply, "ERROR: invalid auto-weather status \"" .. tostring( args[1] ) .. "\" specified." )

	end

end
concommand.Add( "sw_autoweather", AutoWeather, function( ) return { "sw_autoweather 0", "sw_autoweather 1" } end, "Change auto-weather on or off." , { FCVAR_ARCHIVE , FCVAR_REPLICATED } )
--]]
------------------------------

local function SetTime( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	if( ply and ply:IsValid() and !ply:IsAdmin() ) then

		ply:PrintMessage( 2, "You need to be admin to do this!" )
		return

	end
	
	if( tonumber( args[1] ) and tonumber( args[1] ) >= 0 and tonumber( args[1] ) <= 23 ) then

		SW.SetTime( tonumber( args[1] ) )

	else

		SWAdminMessage( ply, "ERROR: invalid time \"" .. tostring( args[1] ) .. "\" specified." )

	end

end
concommand.Add( "sw_settime", SetTime, function() return { "sw_settime (0-24)" } end, "Set the time of day." , { FCVAR_NEVER_AS_STRING , FCVAR_DONTRECORD } )

------------------------------

local function RealTime( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap( ) ) ) ) then return end

	if( ply and ply:IsValid() and !ply:IsAdmin() ) then

		ply:PrintMessage( 2, "You need to be admin to do this!" )
		return

	end

	if( args[1] == "0" ) then

		-- SW.Realtime = false
		ConVar("sw_sv_realtime"):SetBool(0)

	elseif( args[1] == "1" ) then

		-- SW.Realtime = true
		ConVar("sw_sv_realtime"):SetBool(1)

	else

		SWAdminMessage( ply, "ERROR: invalid real-time status \"" .. tostring( args[1] ) .. "\" specified." )

	end

end
-- concommand.Add( "sw_sv_realtime", RealTime, function() return { "sw_sv_realtime 0" , "sw_sv_realtime 1" } end, "Set real-time on or off." , { FCVAR_ARCHIVE , FCVAR_REPLICATED } )

------------------------------

-- concommand.Add( "sw_sv_realtime_offset", RealTimeOffset, function()

	-- if( CLIENT ) then return end
	-- if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	-- if( ply and ply:IsValid() and !ply:IsAdmin() ) then

		-- ply:PrintMessage( 2, "You need to be admin to do this!" )
		-- return

	-- end
	
	-- if( tonumber( args[1] ) and tonumber( args[1] ) >= 0 and tonumber( args[1] ) <= 23 ) then

		-- SW.RealtimeOffset( tonumber( args[1] ) )

	-- else

		-- SWAdminMessage( ply, "ERROR: invalid offset time \"" .. tostring( args[1] ) .. "\" specified." )

	-- end

-- end , "Set real-time offset." , { FCVAR_ARCHIVE , FCVAR_REPLICATED } )

------------------------------

local function StartTime( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end

	if( ply and ply:IsValid() and !ply:IsAdmin() ) then

		ply:PrintMessage( 2, "You need to be admin to do this!" )
		return

	end
	
	if( tonumber( args[1] ) and tonumber( args[1] ) >= 0 and tonumber( args[1] ) <= 23 ) then

		SW.StartTime( tonumber( args[1] ) )

	else

		SWAdminMessage( ply, "ERROR: invalid start time \"" .. tostring( args[1] ) .. "\" specified." )

	end

end

concommand.Add( "sw_sv_time_start", StartTime, function()

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap( ) ) ) ) then return { } end

	local tab = { }

	for k, _ in pairs( SW.StartTime ) do

		table.insert( tab , "sw_sv_time_start " .. k )

	end

	table.insert( tab, "sw_sv_time_start 10" )

	return tab

end , "Set start time." , { FCVAR_ARCHIVE , FCVAR_REPLICATED } )

------------------------------

-- local function EnableTime( ply , cmd , args )

	-- if( CLIENT ) then return end
	-- if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap( ) ) ) ) then return end

	-- if( ply and ply:IsValid( ) and !ply:IsAdmin() ) then

		-- ply:PrintMessage( 2, "You need to be admin to do this!" )
		-- return

	-- end

	-- if( args[1] == "0" ) then

		-- SW.PauseTime( true )

	-- elseif( args[1] == "1" ) then

		-- SW.PauseTime( false )

	-- else

		-- SWAdminMessage( ply , "ERROR: invalid value \"" .. tostring( args[1] ) .. "\" specified." )

	-- end

-- end
-- concommand.Add( "sw_sv_enabletime" , EnableTime , function( ) return { "sw_sv_enabletime 0" , "sw_sv_enabletime 1" } end , "Change the passage of time on or off." , { FCVAR_ARCHIVE , FCVAR_REPLICATED } )

------------------------------

local function ShowWeather( ply , cmd , args )

	if( SERVER ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap( ) ) ) ) then return end

	if( args[1] == "0" ) then

		-- SW.ShowWeather = false
		ConVar("sw_cl_showweather"):SetBool(0)

	elseif( args[1] == "1" ) then

		-- SW.ShowWeather = true
		ConVar("sw_cl_showweather"):SetBool(1)

	else

		SWAdminMessage( ply , "ERROR: invalid value \"" .. tostring( args[1] ) .. "\" specified." )

	end

end
-- concommand.Add( "sw_cl_showweather" , ShowWeather , function( ) return { "sw_cl_showweather 0" , "sw_cl_showweather 1" } end , "Display weather on client." , { FCVAR_ARCHIVE , FCVAR_CLIENTCMD_CAN_EXECUTE , FCVAR_CLIENTDLL } )

------------------------------
