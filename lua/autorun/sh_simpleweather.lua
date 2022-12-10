
AddCSLuaFile( )

SW = SW or { }

-- What maps to not run the skybox functions on
SW.MapBlacklist = { 
    "rp_bad_map_name_here",
    "gm_another_bad_map",
    "map_that_you_dont_want_sw_on" ,
 
    -- A short list I know of to get you started -V92
    -- Ideally, keep them alphabetical to preserve your sanity.
    "act_airport" , -- Indoor
    "act_city" , -- Night
    "act_corp" , -- Night
    "act_crash" , -- Rain
    "act_metro" , -- Indoor
    "act_plaza" , -- Indoor
    "act_rails" , -- Indoor
    "act_snowmax" , -- Snow
    "ahl2_580plaza" , -- Indoor
    "ahl2_airport" , -- Indoor
    "ahl2_amuse" , -- Night
    "ahl2_canalwar" , -- Night
    "ahl2_killacorp" , -- Night
    "ahl2_icetown" , -- Snow
    "ancientdust_thc16c2" , -- Indoor
    "credits" , -- Special
    "d1_town_04" , -- Indoor
    "d3_citadel_02" , -- Indoor
    "d3_citadel_03" , -- Indoor
    "d3_citadel_04" , -- Indoor
    "d3_citadel_05" , -- Indoor
    "de_crookcounty" , -- Fog
    "de_nightfever" , -- Night
    "de_shanty_v3_fix" , -- Rain
    "de_vangogh_s" , -- Special
    "dod_colmar" , -- Snow
    "dod_wn71" , -- Special
    "dm_agoge_b2" , -- Night
    "dm_arctic_vendetta_sun_v3" , -- Snow
    "dm_arctic_vendetta_snow_v3" , -- Night
    "dm_zeus_redux" , -- Night
    "ep1_c17_00" , -- Indoor
    "ep1_c17_00a" , -- Indoor
    "ep1_citadel_01" , -- Indoor
    "ep1_citadel_02" , -- Indoor
    "ep1_citadel_02b" , -- Indoor
    "ep1_citadel_03" , -- Indoor
    "ep1_citadel_04" , -- Indoor
    "ep2_outland_02" , -- Indoor
    "ep2_outland_03" , -- Indoor
    "ep2_outland_04" , -- Indoor
    "gm_arid_valley_v2_night" , -- Night
    "gm_arena_submerge" , -- Indoor
    "gm_adventurers" , -- Night
    "gm_black" , -- Special
    "gm_black_v2" , -- Special
    "gm_black_v2_reflective" , -- Special
    "gm_black_v3" , -- Special
    "gm_black_v3_reflective" , -- Special
    "gm_black_v3_colourable" , -- Special
    "gm_blackmesasigma_night" , -- Night
    "gm_downtown" , -- Night
    "gm_dddustbowl_night" , -- Night
    "gm_dddustbowl2night" , -- Night
    "gm_excess_island_night" , -- Night
    "gm_galactic_rc1" , -- Special
    "gm_geekroom_v2" , -- Indoor
    "gm_greenland" , -- Indoor
    "gm_floatingworlds_ii_night" , -- Night
    "gm_holygarden" , -- Night
    "gm_holygarden_cataclysm" , -- Night
    "gm_longentrepot" , -- Indoor
    "gm_mallparking" , -- Indoor
    "gm_skylife_v1" , -- Special
    "gm_stormfront" , -- Rain
    "gm_sunsetgulch_night" , -- Night
    "gm_traincity_v2_rain" , -- Rain
    "gm_traincity_v2_night" , -- Night
    "fs_gs-teamspeak" , -- Indoor
    "fs_shining" , -- Indoor
    "haj_vinoridge" , -- Night
    "holo_wreck_v3" , -- Special
    "intro" , -- Special
    "proxy_museum" , -- Special
    "rp_cc_caves_01" , -- Indoor
    "rp_ineu_pass_v1b_night" , -- Night
    "rp_junglestorm" , -- Night
    "rp_necro_torrington_v2" , -- Night
    "rp_necro_urban_v1" , -- Snow
    "rp_necro_urban_v2" , -- Snow
    "rp_necro_urban_v3a" , -- Rain
    "rp_necro_urban_v3b" , -- Rain
    "rp_wildwest_sup" , -- Night
    "steamclub_v1" , -- Indoor
    "tetsu0_comp33" , -- Night
    "trp_coastal-sub-facility_v2" , -- Night
    "v92_airship" , -- Indoor
    "v92_auditorium" , -- Indoor
    "v92_basementdweller" , -- Indoor
    "v92_brainarchives" , -- Indoor
    "v92_cyberapartment" , -- Indoor
    "v92_cyberapartment_blue" , -- Indoor
    "v92_cyberapartment_green" , -- Indoor
    "v92_ratloft" , -- Indoor
    "v92_steptest" , -- Special
    "v92_toysoldiers" , -- Indoor
    "v92_toyhouse_night" , -- Night
}

----------------------------------------
----------------------------------------
-- WEATHER SETTINGS
----------------------------------------
----------------------------------------

-- What weather to automatically start.
SW.AutoWeatherTypes = {
	-- "acidrain" ,
	-- "blizzard" ,
	"fog" ,
	-- "hail" ,
	-- "lightning" ,
	-- "meteor" ,
	"rain" ,
	-- "sandstorm" ,
	-- "smog" ,
	-- "snow" ,
	"thunderstorm" ,
	-- "heavystorm" ,
}

if SERVER then

	----------------------------------------
	----------------------------------------
	-- CIRCUIT BREAKER
	----------------------------------------
	----------------------------------------

	CreateConVar( "sw_func_master" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable SimpleWeather mod." , "0" , "1" )
	CreateConVar( "sw_func_lighting" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable map lighting updates.\nTurn this off if the map's a night map already!" , "0" , "1" )
	CreateConVar( "sw_func_sun" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable sun moving through the sky." , "0" , "1" )
	CreateConVar( "sw_func_skybox" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable the skybox to change color through the day." , "0" , "1" )
	CreateConVar( "sw_func_fog" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable the fog to change color.\nPrevents weird light fog at night - turn it off if weird stuff happens." , "0" , "1" )
	CreateConVar( "sw_func_wind" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable wind functions.\nTurn it off if weird stuff happens." , "0" , "1" )
	CreateConVar( "sw_func_maplogic" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable any map-based effects, like lampposts turning off and on." , "0" , "1" )

	CreateConVar( "sw_autoweather" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Enable auto-weather starting." , "0" , "1" )
	CreateConVar( "sw_autoweather_minstart" , "1" , { FCVAR_ARCHIVE } , "(FLOAT) Minimum time in hours before weather begins." , "0" , "16" )
	CreateConVar( "sw_autoweather_maxstart" , "3" , { FCVAR_ARCHIVE } , "(FLOAT) Maximum time in hours before weather begins." , "0" , "16" )
	CreateConVar( "sw_autoweather_minstop" , "0.2" , { FCVAR_ARCHIVE } , "(FLOAT) Minimum time in hours before weather stops." , "0" , "16" )
	CreateConVar( "sw_autoweather_maxstop" , "8" , { FCVAR_ARCHIVE } , "(FLOAT) Maximum time in hours before weather stops." , "0" , "16" )

	CreateConVar( "sw_weather_eas" , "1" , { FCVAR_ARCHIVE } , "(BOOL) Toggle radio models playing the EAS broadcasting tones when severe weather starts." , "0" , "1" )
	CreateConVar( "sw_weather_alwaysoutside" , "0" , { FCVAR_ARCHIVE } , "(BOOL) Should players be considered outside at all times?\n(ie. if you want snow in an indoor map) " , "0" , "1" )

	CreateConVar( "sw_fog_densityday" , "1" , { FCVAR_ARCHIVE } , "(FLOAT) Fog max density during the day." , "0" , "1" )
	CreateConVar( "sw_fog_densitynight" , "0.4" , { FCVAR_ARCHIVE } , "(FLOAT) Fog max density during the night." , "0" , "1" )
	CreateConVar( "sw_fog_indoors" , "0" , { FCVAR_ARCHIVE } , "(INT) Enable fog when you have a roof over your head." , "0" , "1" )
	CreateConVar( "sw_fog_speed" , "0.01" , { FCVAR_ARCHIVE } , "(FLOAT) Speed at which fog appears and disappears.\nDecrease to make fog changes slower." , "0" , "1" )

	----------------------------------------
	----------------------------------------
	-- DAY/NIGHT SETTINGS
	----------------------------------------
	----------------------------------------

	CreateConVar( "sw_time_pause" , "0" , { FCVAR_ARCHIVE } , "(BOOL) Change the passage of time on or off." , "0" , "1" )
	CreateConVar( "sw_time_start" , "10" , { FCVAR_ARCHIVE } , "(INT) Set start time." , "0" , "23" )
	CreateConVar( "sw_time_real" , "0" , { FCVAR_ARCHIVE } , "(BOOL) Set real-time on or off." , "0" , "1" )
	CreateConVar( "sw_time_real_offset" , "0" , { FCVAR_ARCHIVE } , "(INT) If realtime is on, add this many timezones.\nFor example, if the server was GMT and you set this to -5, it'd be EST ingame." , "-12" , "12" )
	CreateConVar( "sw_time_speed_day" , "0.01" , { FCVAR_ARCHIVE } , "(FLOAT) Multiplier of time during the day.\nMake this bigger for time to go faster, and smaller for time to go slower." , "0" , "1" )
	CreateConVar( "sw_time_speed_night" , "0.02" , { FCVAR_ARCHIVE } , "(FLOAT) Multiplier of time during the night.\nMake this bigger for time to go faster, and smaller for time to go slower." , "0" , "1" )
	CreateConVar( "sw_time_speed_stars" , "0.01" , { FCVAR_ARCHIVE } , "(FLOAT) Set the rotation speed of stars" , "0.01" , "5" )

	-- CreateConVar( "sw_time_dawn" , "6" , { FCVAR_ARCHIVE } , "(INT) Hour to consider Dawn." , "0" , "23" )
	-- CreateConVar( "sw_time_afternoon" , "12" , { FCVAR_ARCHIVE } , "(INT) Hour to consider Afternoon." , "0" , "23" )
	-- CreateConVar( "sw_time_dusk" , "18" , { FCVAR_ARCHIVE } , "(INT) Hour to consider Dusk." , "0" , "23" )
	-- CreateConVar( "sw_time_night" , "24" , { FCVAR_ARCHIVE } , "(INT) Hour to consider Night." , "0" , "23" )

	CreateConVar( "sw_perf_updatedelay_client" , "1" , { FCVAR_ARCHIVE } , "(INT) Delay in seconds between updating the time on the client." , "1" , "60" )
	CreateConVar( "sw_perf_updatedelay_sun" , "1" , { FCVAR_ARCHIVE } , "(FLOAT) Delay in seconds between updating the sun position.\nSetting this to a smaller number will allow smoother sun movement, but doing this also causes lag." , "0" , "15" )
	CreateConVar( "sw_perf_updatedelay_sky" , "0.1" , { FCVAR_ARCHIVE } , "(FLOAT) Delay in seconds between updating the sky colors.\nSetting this to a smaller number will allow smoother transitions, but doing this also causes lag." , "0" , "15" )

	CreateConVar( "sw_light_max_night" , "b" , { FCVAR_ARCHIVE , FCVAR_DONTRECORD } , "(a-z) Maximum darkness level during night.\nIncrease to add light. \"a\" is darkest, \"z\" is lightest." )
	CreateConVar( "sw_light_max_day" , "y" , { FCVAR_ARCHIVE , FCVAR_DONTRECORD } , "(a-z) Maximum lightness level at noon on a clear day.\nIncrease to add light. \"a\" is darkest, \"z\" is lightest." )
	CreateConVar( "sw_light_max_storm" , "j" , { FCVAR_ARCHIVE , FCVAR_DONTRECORD } , "(a-z) Maximum lightness level at noon on a stormy day.\nIncrease to add light. \"a\" is darkest, \"z\" is lightest." )

end

if CLIENT then

	CreateClientConVar( "sw_cl_weather_toggle", "1" , true , false , "(BOOL) Display client-side weather effects." , "0" , "1" )

	CreateClientConVar( "sw_cl_screenfx", "1" , true , false , "(BOOL) Show screen weather effects." , "0" , "1" )
	CreateClientConVar( "sw_cl_screenfx_vehicle", "0" , true , false , "(BOOL) Show screen weather effects when in vehicles." , "0" , "1" )

	CreateClientConVar( "sw_cl_colormod", "1" , true , false , "(BOOL) Enable colormod when it's cloudy." , "0" , "1" )
	CreateClientConVar( "sw_cl_colormod_indoors", "0" , true , false , "(BOOL) Enable colormod indoors." , "0" , "1" )

	CreateClientConVar( "sw_cl_sound", "1" , true , false , "(BOOL) Play sounds." , "0" , "1" )
	CreateClientConVar( "sw_cl_sound_volume", "1" , true , false , "(FLOAT) Volume sounds should play at." , "0" , "1" )
	CreateClientConVar( "sw_cl_sound_siren", "1" , true , false , "(BOOL) Toggle the alarm siren if it annoys you as much as it does me." , "0" , "1" )
	CreateClientConVar( "sw_cl_sound_siren_path", "ambient/alarms/alarm_citizen_loop1.wav" , true , false , "(STRING) Path for the siren sound effect. Can pretty much be whatever you want." )

	----------------------------------------
	----------------------------------------
	-- HUD
	----------------------------------------
	----------------------------------------

	CreateClientConVar( "sw_cl_hud_toggle", "1" , true , false , "(BOOL) Draw SimpleWeather HUD." , "0" , "1" )
	CreateClientConVar( "sw_cl_hud_position", "1" , true , false , "(BOOL) Show HUD at top of screen instead of bottom." , "0" , "1" )
	CreateClientConVar( "sw_cl_hud_weather_toggle", "1" , true , false , "(BOOL) Draw weather icon." , "0" , "1" )
	CreateClientConVar( "sw_cl_hud_clock_toggle", "1" , true , false , "(BOOL) Draw clock." , "0" , "1" )
	CreateClientConVar( "sw_cl_hud_clock_style", "1" , true , false , "(BOOL) 24 hour clock." , "0" , "1" )

	----------------------------------------
	----------------------------------------
	-- MISC
	----------------------------------------
	----------------------------------------

	CreateClientConVar( "sw_cl_announcement", "1" , true , false , "(BOOL) Show an informational chat message when weather starts." , "0" , "1" )
	CreateClientConVar( "sw_cl_startupdisplay", "0" , true , false , "(BOOL) Show info on opening config when a player joins the server." , "0" , "1" )
	CreateClientConVar( "sw_cl_particles_max", "7000" , true , false , "(INT) Maximum number of particles to create at any one time." , "0" , "10000" )

end

sound.Add( {
	["name"] = "SW.EAS.Alert" ,
	["channel"] = CHAN_STATIC ,
	["volume"] = 1.0 ,
	["level"] = 80 ,
	["pitch"] = 100 ,
	["sound"] = "simpleweather/eas/alert.mp3"
} )

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
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) ) or GetConVarNumber("sw_func_master") != 1 then return end

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
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) ) or GetConVarNumber("sw_func_master") != 1 then return { } end

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
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) ) or GetConVarNumber("sw_func_master") != 1 then return end

	if( ply and ply:IsValid() and !ply:IsAdmin( ) ) then

		ply:PrintMessage( 2 , "You need to be admin to do this!" )
		return

	end

	SW.SetWeather( "" )

end
concommand.Add( "sw_stopweather" , StopWeather , function( ) return { } end , "Stop the weather." , { FCVAR_DONTRECORD } )

local function SetTime( ply, cmd, args )

	if( CLIENT ) then return end
	if( table.HasValue( SW.MapBlacklist , string.lower( game.GetMap() ) ) ) or GetConVarNumber("sw_func_master") != 1 then return end

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

concommand.Add( "sw_settime", SetTime, function() return { "sw_settime (0-24)" } end , "Set the time of day." , { FCVAR_NEVER_AS_STRING , FCVAR_DONTRECORD } )

if CLIENT then
	
	include( "simpleweather/cl_init.lua" )

	--------------------------------------------------
	-- Test code stolen from TFA base
	--------------------------------------------------

	function SW.CheckBoxNet(_parent, label, convar, ...)
		local gconvar = assert(GetConVar(convar), "Unknown ConVar: " .. convar .. "!")
		local newpanel

		if IsSinglePlayer then
			newpanel = _parent:CheckBox(label, convar, ...)
		else
			newpanel = _parent:CheckBox(label, nil, ...)
		end

		if not IsSinglePlayer then
			if not IsValid(newpanel.Button) then return newpanel end

			newpanel.Button.Think = function(_self)
				local bool = gconvar:GetBool()

				if _self:GetChecked() ~= bool then
					_self:SetChecked(bool)
				end
			end

			newpanel.OnChange = function(_self, _bVal)
				if not LocalPlayer():IsAdmin() then return end
				if _bVal == gconvar:GetBool() then return end

				net.Start("SW_SetServerCommand")
				net.WriteString(convar)
				net.WriteString(_bVal and "1" or "0")
				net.SendToServer()
			end
		end

		return newpanel

	end

	--------------------------------------------------
	-- Spawn Menu Panels
	--------------------------------------------------

	hook.Add( "PopulateToolMenu", "SimpleWeather", function()

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Admin" , " Admin" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {

				["MenuButton"] = 1 ,
				["Folder"] = "sw_admin" ,
				["Options"] = {

					["default"] = {

						["sw_func_master"] = "1" ,
						["sw_func_skybox"] = "1" ,
						["sw_func_lighting"] = "1" ,
						["sw_func_sun"] = "1" ,
						["sw_func_fog"] = "1" ,
						["sw_func_wind"] = "1" ,
						["sw_func_maplogic"] = "1" ,

					},

					["disabled"] = {

						["sw_func_master"] = "0" ,
						["sw_func_skybox"] = "0" ,
						["sw_func_lighting"] = "0" ,
						["sw_func_sun"] = "0" ,
						["sw_func_fog"] = "0" ,
						["sw_func_wind"] = "0" ,
						["sw_func_maplogic"] = "0" ,

					}

				},

				["CVars"] = {

					"sw_func_master" ,
					"sw_func_skybox" ,
					"sw_func_lighting" ,
					"sw_func_sun" ,
					"sw_func_fog" ,
					"sw_func_wind" ,
					"sw_func_maplogic" ,

				}

			} )

			Panel:Help( "These commands toggle entire parts of the mod. Use on more troublesome maps. Reloading the map might be required." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Enable Mod" , ["Command"] = "sw_func_master" } )
			Panel:ControlHelp( "Toggle entire SimpleWeather mod - all functionality will be disabled." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Update Skybox" , ["Command"] = "sw_func_skybox" } )
			Panel:ControlHelp( "Enable the skybox to change color through the day. Probably should disable on maps with special skyboxes." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Update Lighting" , ["Command"] = "sw_func_lighting" } )
			Panel:ControlHelp( "Enable map lighting updates.\nTurn this off if the map's a night map already!" , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Update Sun" , ["Command"] = "sw_func_sun" } )
			Panel:ControlHelp( "Enable sun moving through the sky." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Update Fog" , ["Command"] = "sw_func_fog" } )
			Panel:ControlHelp( "Enable the fog to change color.\nPrevents weird light fog at night - turn it off if weird stuff happens." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Update Wind" , ["Command"] = "sw_func_wind" } )
			Panel:ControlHelp( "Enable wind functions.\nTurn it off if weird stuff happens." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Map Outputs" , ["Command"] = "sw_func_maplogic" } )
			Panel:ControlHelp( "Enabled map-specific outputs, like streetlights.\n(Situtational. Only works on select maps. Needs to be improved.)" , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Emergency Alerts" , ["Command"] = "sw_weather_eas" } )
			Panel:ControlHelp( "Toggle radio models playing the EAS broadcasting tones when severe weather starts." , {} )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Client" , " Client" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {

				["MenuButton"] = 1 ,
				["Folder"] = "sw_client" ,
				["Options"] = {

					["default"] = {

						["sw_cl_hud_weather_toggle"] = "1",
						["sw_cl_hud_clock_toggle"] = "1",
						["sw_cl_hud_position"] = "1",
						["sw_cl_hud_clock_style"] = "1",
						["sw_cl_colormod"] = "1",
						["sw_cl_colormod_indoors"] = "0",
						["sw_cl_particles_max"] = "7000",
						["sw_cl_screenfx"] = "1",
						["sw_cl_screenfx_vehicle"] = "1",
						["sw_cl_sound"] = "1",
						["sw_cl_sound_volume"] = "0.3",
						["sw_cl_screenfx_lightning"] = "1",

					},

					["potato"] = {

						["sw_cl_hud_weather_toggle"] = "1",
						["sw_cl_hud_clock_toggle"] = "1",
						["sw_cl_hud_position"] = "1",
						["sw_cl_hud_clock_style"] = "1",
						["sw_cl_colormod"] = "0",
						["sw_cl_colormod_indoors"] = "0",
						["sw_cl_particles_max"] = "100",
						["sw_cl_screenfx"] = "0",
						["sw_cl_screenfx_vehicle"] = "0",
						["sw_cl_sound"] = "0",
						["sw_cl_sound_volume"] = "0.3",
						["sw_cl_screenfx_lightning"] = "0"

					},

					["hardcore"] = {

						["sw_cl_hud_weather_toggle"] = "0",
						["sw_cl_hud_clock_toggle"] = "0",
						["sw_cl_hud_position"] = "1",
						["sw_cl_hud_clock_style"] = "1",
						["sw_cl_colormod"] = "1",
						["sw_cl_colormod_indoors"] = "0",
						["sw_cl_particles_max"] = "7000",
						["sw_cl_screenfx"] = "1",
						["sw_cl_screenfx_vehicle"] = "1",
						["sw_cl_sound"] = "1",
						["sw_cl_sound_volume"] = "0.6",
						["sw_cl_screenfx_lightning"] = "1"

					}

				},

				["CVars"] = {

					"sw_cl_hud_weather_toggle" ,
					"sw_cl_hud_clock_toggle" ,
					"sw_cl_hud_position" ,
					"sw_cl_hud_clock_style" ,
					"sw_cl_colormod" ,
					"sw_cl_colormod_indoors" ,
					"sw_cl_particles_max" ,
					"sw_cl_screenfx" ,
					"sw_cl_screenfx_vehicle" ,
					"sw_cl_sound" ,
					"sw_cl_sound_volume" ,
					"sw_cl_screenfx_lightning"

				}

			} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Show Weather Alerts" , ["Command"] = "sw_cl_announcement" } )
			Panel:ControlHelp( "Show an informational chat message when weather starts." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Show HUD" , ["Command"] = "sw_cl_hud_toggle" } )
			Panel:ControlHelp( "Show HUD elements." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "HUD on Top" , ["Command"] = "sw_cl_hud_position" } )
			Panel:ControlHelp( "Show HUD elements on top or bottom of screen." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Show Weather" , ["Command"] = "sw_cl_hud_weather_toggle" } )
			Panel:ControlHelp( "Toggle weather HUD element" , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Show Clock" , ["Command"] = "sw_cl_hud_clock_toggle" } )
			Panel:ControlHelp( "Toggle clock HUD element" , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "24-Hour Clock" , ["Command"] = "sw_cl_hud_clock_style" } )
			Panel:ControlHelp( "24 hour or 12 hour clock style." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Color Mod" , ["Command"] = "sw_cl_colormod" } )
			Panel:ControlHelp( "Use the color mod." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Color Mod Indoors" , ["Command"] = "sw_cl_colormod_indoors" } )
			Panel:ControlHelp( "Force the color mod indoors." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Play Sounds" , ["Command"] = "sw_cl_sound" } )
			Panel:ControlHelp( "Toggle sound effects." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Play Sirens" , ["Command"] = "sw_cl_sound_siren" } )
			Panel:ControlHelp( "Toggle siren sounds." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Volume" , ["Command"] = "sw_cl_sound_volume" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )
			Panel:ControlHelp( "Sound effect volume." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Screen Effects" , ["Command"] = "sw_cl_screenfx" } )
			Panel:ControlHelp( "Show screen effects." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Vehicle Screen Effects" , ["Command"] = "sw_cl_screenfx_vehicle" } )
			Panel:ControlHelp( "Show screen effects in vehicles." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Lightning Flashes" , ["Command"] = "sw_cl_screenfx_lightning" } )
			Panel:ControlHelp( "Lightning makes the screen flash. Recommend turning off at high frequency." )

			Panel:AddControl( "slider" , { ["Label"] = "Max Particles" , ["Command"] = "sw_cl_particles_max" , ["Min"] = "0" , ["Max"] = "10000" , ["Type"] = "int" } )
			Panel:ControlHelp( "Max amount of particles to draw." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Show Startup Message" , ["Command"] = "sw_cl_startupdisplay" } )
			Panel:ControlHelp( "Show the new user chat message on spawn." , {} )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_QuickWeather" , " Quick Weather" , "" , "" , function( Panel )

			Panel:AddControl( "button" , { ["Label"] = "Clear" , ["Command"] = "sw_stopweather" } )
			Panel:ControlHelp( "Stop All Weather" , {} )
			Panel:AddControl( "button" , { ["Label"] = "Fog" , ["Command"] = "sw_weather fog" } )
			Panel:ControlHelp( "Fog.\nHampers visibility." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Smog" , ["Command"] = "sw_weather smog" } )
			Panel:ControlHelp( "Smog.\nHampers visibility.\nInflicts DOT from noxious air." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Sandstorm" , ["Command"] = "sw_weather sandstorm" } )
			Panel:ControlHelp( "Sandstorm.\nHampers visibility and hearing." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Rain" , ["Command"] = "sw_weather rain" } )
			Panel:ControlHelp( "Rain.\nOvercast skies." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Thunderstorm" , ["Command"] = "sw_weather thunderstorm" } )
			Panel:ControlHelp( "Thunderstorm.\nOvercast skies. Hampers visibility.\nLightning may strike you for significant damage." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Hail" , ["Command"] = "sw_weather hail" } )
			Panel:ControlHelp( "Hail.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Heavy Storm" , ["Command"] = "sw_weather heavystorm" } )
			Panel:ControlHelp( "Heavy Storm.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects.\nLightning may strike you for significant damage." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Lightning" , ["Command"] = "sw_weather lightning" } )
			Panel:ControlHelp( "Lightning.\nOvercast skies.\nLightning may strike you for significant damage." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Snow" , ["Command"] = "sw_weather snow" } )
			Panel:ControlHelp( "Snow.\nOvercast skies. Hampers visibility." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Blizzard" , ["Command"] = "sw_weather blizzard" } )
			Panel:ControlHelp( "Blizzard.\nOvercast skies. Hampers visibility and hearing." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Acid Rain" , ["Command"] = "sw_weather acidrain" } )
			Panel:ControlHelp( "Acid Rain.\nOvercast skies. Hampers visibility.\nInflicts DOT due to caustic rain." , {} )
			Panel:AddControl( "button" , { ["Label"] = "Meteor Storm" , ["Command"] = "sw_weather meteor" } )
			Panel:ControlHelp( "Meteor Storm.\nOvercast skies.\nMeteor strike will cause significant damage." , {} )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_RNG" , " Auto-Weather" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {

				["MenuButton"] = 1 ,
				["Folder"] = "sw_rng" ,
				["Options"] = {

					["default"] = {

						["sw_autoweather"] = "1" ,
						["sw_autoweather_minstart"] = "1" ,
						["sw_autoweather_maxstart"] = "3" ,
						["sw_autoweather_minstop"] = "1" ,
						["sw_autoweather_maxstop"] = "4" ,
						["sw_acidrain"] = "0" ,
						["sw_blizzard"] = "0" ,
						["sw_fog"] = "1" ,
						["sw_lightning"] = "0" ,
						["sw_hail"] = "0" ,
						["sw_meteor"] = "0" ,
						["sw_rain"] = "1" ,
						["sw_sandstorm"] = "0" ,
						["sw_smog"] = "0" ,
						["sw_snow"] = "0" ,
						["sw_thunderstorm"] = "1" ,

					},

					["v92"] = {

						["sw_autoweather"] = "1" ,
						["sw_autoweather_minstart"] = "0.5" ,
						["sw_autoweather_maxstart"] = "1" ,
						["sw_autoweather_minstop"] = "4" ,
						["sw_autoweather_maxstop"] = "8" ,
						["sw_acidrain"] = "0" ,
						["sw_blizzard"] = "0" ,
						["sw_fog"] = "0" ,
						["sw_hail"] = "0" ,
						["sw_lightning"] = "0" ,
						["sw_meteor"] = "0" ,
						["sw_rain"] = "1" ,
						["sw_sandstorm"] = "0" ,
						["sw_smog"] = "0" ,
						["sw_snow"] = "0" ,
						["sw_thunderstorm"] = "1" ,

					}

				} ,

				["CVars"] = {

					"sw_autoweather" ,
					"sw_autoweather_minstart" ,
					"sw_autoweather_maxstart" ,
					"sw_autoweather_minstop" ,
					"sw_autoweather_maxstop" ,
					"sw_acidrain" ,
					"sw_blizzard" ,
					"sw_fog" ,
					"sw_hail" ,
					"sw_lightning" ,
					"sw_meteor" ,
					"sw_rain" ,
					"sw_sandstorm" ,
					"sw_smog" ,
					"sw_snow" ,
					"sw_thunderstorm" ,

				}

			} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Auto-Weather" , ["Command"] = "sw_autoweather" } )
			Panel:ControlHelp( "Random weathers start over time." , {} )

			Panel:Help( "Minimum and maximum time before a weather will start." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Min. Before Start" , ["Command"] = "sw_autoweather_minstart" , ["Min"] = "0" , ["Max"] = "8" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Max Before Start" , ["Command"] = "sw_autoweather_maxstart" , ["Min"] = "1" , ["Max"] = "8" , ["Type"] = "int" } )

			Panel:Help( "Minimum and maximum time before a weather will stop." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Min. Before Stopping" , ["Command"] = "sw_autoweather_minstop" , ["Min"] = "0" , ["Max"] = "8" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Max Before Stopping" , ["Command"] = "sw_autoweather_maxstop" , ["Min"] = "1" , ["Max"] = "8" , ["Type"] = "int" } )

			Panel:Help( "Which weathers will play randomly.\nMore extreme weathers would best be kept off unless desired." , {} )
			Panel:AddControl( "checkbox" , { ["Label"] = "Fog" , ["Command"] = "sw_fog" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Smog" , ["Command"] = "sw_smog" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Sandstorm" , ["Command"] = "sw_sandstorm" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Rain" , ["Command"] = "sw_rain" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Hail" , ["Command"] = "sw_hail" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Thunderstorm" , ["Command"] = "sw_thunderstorm" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Heavy Storm" , ["Command"] = "sw_heavystorm" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Lightning" , ["Command"] = "sw_lightning" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Snow" , ["Command"] = "sw_snow" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Blizzard" , ["Command"] = "sw_blizzard" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Acid Rain" , ["Command"] = "sw_acidrain" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Meteor Storm" , ["Command"] = "sw_meteor" } )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Fog" , "Fog" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_fog" ,
				["Options"] = {
					["default"] = {
						["sw_fog_indoors"] = "0",
						["sw_fog_densityday"] = "1",
						["sw_fog_densitynight"] = "0.4",
						["sw_fog_speed"] = "0.01",
					}
				},
				["CVars"] = {
					"sw_fog_indoors",
					"sw_fog_densityday",
					"sw_fog_densitynight",
					"sw_fog_speed",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Fog" , ["Command"] = "sw_weather fog" } )
			Panel:ControlHelp( "Fog.\nHampers visibility." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Fog Indoors" , ["Command"] = "sw_fog_indoors" } )
			Panel:ControlHelp( "Toggle fog being force-rendered while indoors." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Day Fog Density" , ["Command"] = "sw_fog_densityday" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )
			Panel:AddControl( "slider" , { ["Label"] = "Night Fog Density" , ["Command"] = "sw_fog_densitynight" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )
			Panel:AddControl( "slider" , { ["Label"] = "Fog Speed" , ["Command"] = "sw_fog_speed" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Smog" , "Smog" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_smog" ,
				["Options"] = {
					["default"] = {
						["sw_smog_dmg_sound_toggle"] = "1",
						["sw_smog_dmg_delay"] = "10",
						["sw_smog_dmg_delayoffset"] = "5",
						["sw_smog_dmg_toggle"] = "1",
						["sw_smog_dmg_amount"] = "3",
					},
					["hardcore"] = {
						["sw_smog_dmg_sound_toggle"] = "1",
						["sw_smog_dmg_delay"] = "5",
						["sw_smog_dmg_delayoffset"] = "5",
						["sw_smog_dmg_toggle"] = "1",
						["sw_smog_dmg_amount"] = "5",
					}
				},
				["CVars"] = {
					"sw_smog_dmg_sound_toggle",
					"sw_smog_dmg_delay",
					"sw_smog_dmg_delayoffset",
					"sw_smog_dmg_toggle",
					"sw_smog_dmg_amount",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Smog" , ["Command"] = "sw_weather smog" } )
			Panel:ControlHelp( "Smog.\nHampers visibility.\nInflicts DOT from noxious air." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Toggle Coughing" , ["Command"] = "sw_smog_dmg_sound_toggle" } )
			Panel:ControlHelp( "Toggle coughing sounds." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Damage Delay" , ["Command"] = "sw_smog_dmg_delay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Delay between damage." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Delay Offset" , ["Command"] = "sw_smog_dmg_delayoffset" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Random delay offset between damage." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Toggle Damage" , ["Command"] = "sw_smog_dmg_toggle" } )
			Panel:ControlHelp( "Toggle smog damage." , {} )
			
			Panel:AddControl( "slider" , { ["Label"] = "Damage Amount" , ["Command"] = "sw_smog_dmg_amount" , ["Min"] = "1" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:ControlHelp( "How much damage per hit the smog does." , {} )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Rain" , "Rain" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_rain" ,
				["Options"] = {
					["default"] = {
						["sw_rain_showsmoke"] = "1",
						["sw_rain_showimpact"] = "1",
						["sw_rain_quality"] = "1",
						["sw_rain_dropsize_min"] = "20",
						["sw_rain_dropsize_max"] = "40",
						["sw_rain_height"] = "300",
						["sw_rain_radius"] = "500",
						["sw_rain_count"] = "20",
						["sw_rain_dietime"] = "3",
					},
					["potato"] = {
						["sw_rain_showsmoke"] = "0",
						["sw_rain_showimpact"] = "0",
						["sw_rain_quality"] = "1",
						["sw_rain_dropsize_min"] = "20",
						["sw_rain_dropsize_max"] = "40",
						["sw_rain_height"] = "100",
						["sw_rain_radius"] = "150",
						["sw_rain_count"] = "20",
						["sw_rain_dietime"] = "1",
					}
				},
				["CVars"] = {
					"sw_rain_showsmoke",
					"sw_rain_showimpact",
					"sw_rain_quality",
					"sw_rain_dropsize_min",
					"sw_rain_dropsize_max",
					"sw_rain_height",
					"sw_rain_radius",
					"sw_rain_count",
					"sw_rain_dietime",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Rain" , ["Command"] = "sw_weather rain" } )
			Panel:ControlHelp( "Rain.\nOvercast skies." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Rain Puffs" , ["Command"] = "sw_rain_showsmoke" } )
			Panel:AddControl( "checkbox" , { ["Label"] = "Rain Impacts" , ["Command"] = "sw_rain_showimpact" } )
			Panel:AddControl( "slider" , { ["Label"] = "Rain Quality" , ["Command"] = "sw_rain_quality" , ["Min"] = "1" , ["Max"] = "4" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Drop Size Minimum" , ["Command"] = "sw_rain_dropsize_min" , ["Min"] = "10" , ["Max"] = "1000" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Drop Size Maximum" , ["Command"] = "sw_rain_dropsize_max" , ["Min"] = "10" , ["Max"] = "1000" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Rain Height" , ["Command"] = "sw_rain_height" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Rain Radius" , ["Command"] = "sw_rain_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Rain Amount" , ["Command"] = "sw_rain_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Rain Lifetime" , ["Command"] = "sw_rain_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

		end )

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_AcidRain" , "Acid Rain" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_acidrain" ,
				["Options"] = {
					["default"] = {
						["sw_acidrain_dmg_toggle"] = "1",
						["sw_acidrain_dmg_amount"] = "5",
						["sw_acidrain_dmg_delay"] = "2",
					},
				},
				["CVars"] = {
					"sw_acidrain_dmg_toggle",
					"sw_acidrain_dmg_amount",
					"sw_acidrain_dmg_delay",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Acid Rain" , ["Command"] = "sw_weather acidrain" } )
			Panel:ControlHelp( "Acid Rain.\nOvercast skies. Hampers visibility.\nInflicts DOT due to caustic rain." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Toggle Damage" , ["Command"] = "sw_acidrain_dmg_toggle" } )
			Panel:ControlHelp( "Toggle acid rain damage." , {} )
			
			Panel:AddControl( "slider" , { ["Label"] = "Damage Amount" , ["Command"] = "sw_acidrain_dmg_amount" , ["Min"] = "1" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:ControlHelp( "How much damage per hit the acid rain does." , {} )
			
			Panel:AddControl( "slider" , { ["Label"] = "Damage Delay" , ["Command"] = "sw_acidrain_dmg_delay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "How long between damage hits." , {} )

		end )

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Thunderstorm" , "Thunderstorm" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_thunderstorm" ,
				["Options"] = {
					["default"] = {
						["sw_storm_radius"] = "500",
						["sw_storm_count"] = "120",
						["sw_storm_dietime"] = "3",
						-- ["sw_thunder_mindelay"] = "10",
						-- ["sw_thunder_maxdelay"] = "30",
					},
					["potato"] = {
						["sw_storm_radius"] = "150",
						["sw_storm_count"] = "25",
						["sw_storm_dietime"] = "1",
						-- ["sw_thunder_mindelay"] = "10",
						-- ["sw_thunder_maxdelay"] = "30",
					}
				},
				["CVars"] = {
					"sw_storm_radius",
					"sw_storm_count",
					"sw_storm_dietime",
					-- "sw_thunder_mindelay",
					-- "sw_thunder_maxdelay",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Thunderstorm" , ["Command"] = "sw_thunderstorm" } )
			Panel:ControlHelp( "Thunderstorm.\nOvercast skies. Hampers visibility.\nLightning may strike you for significant damage." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Thunderstorm Radius" , ["Command"] = "sw_storm_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Thunderstorm Amount" , ["Command"] = "sw_storm_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Thunderstorm Lifetime" , ["Command"] = "sw_storm_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

			-- Panel:AddControl( "slider" , { ["Label"] = "Thunder Minimum Delay" , ["Command"] = "sw_thunder_mindelay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			-- Panel:AddControl( "slider" , { ["Label"] = "Thunder Maximum Delay" , ["Command"] = "sw_thunder_maxdelay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )

			Panel:AddControl( "button" , { ["Label"] = "Start Heavy Storm" , ["Command"] = "sw_weather heavystorm" } )
			Panel:ControlHelp( "Heavy Storm.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects. Lightning may strike you for significant damage." , {} )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Lightning" , "Lightning" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_lightning" ,
				["Options"] = {
					["default"] = {
						["sw_lightning_delay"] = "10",
						["sw_lightning_delayoffset"] = "5",
						["sw_lightning_target_prop"] = "1",
						["sw_lightning_target_player"] = "1",
						["sw_lightning_target_npc"] = "1",
						["sw_lightning_force"] = "1",
						["sw_lightning_force_amount"] = "40",
						["sw_lightning_ignite_target"] = "1",
						["sw_lightning_ignite_duration"] = "3",
						["sw_lightning_damage"] = "50",
						["sw_lightning_target_world"] = "1",
						["sw_lightning_target_chance"] = "85",
						["sw_lightning_fancyfx"] = "1",
					},
					["hardcore"] = {
						["sw_lightning_delay"] = "3",
						["sw_lightning_delayoffset"] = "3",
						["sw_lightning_damage"] = "100",
						["sw_lightning_target_prop"] = "1",
						["sw_lightning_target_player"] = "1",
						["sw_lightning_target_npc"] = "1",
						["sw_lightning_force"] = "1",
						["sw_lightning_force_amount"] = "40",
						["sw_lightning_ignite_target"] = "1",
						["sw_lightning_ignite_duration"] = "10",
						["sw_lightning_target_world"] = "1",
						["sw_lightning_target_chance"] = "25",
						["sw_lightning_fancyfx"] = "1",
					},
					["potato"] = {
						["sw_lightning_delay"] = "15",
						["sw_lightning_delayoffset"] = "10",
						["sw_lightning_damage"] = "50",
						["sw_lightning_target_prop"] = "1",
						["sw_lightning_target_player"] = "1",
						["sw_lightning_target_npc"] = "1",
						["sw_lightning_force"] = "0",
						["sw_lightning_ignite_target"] = "0",
						["sw_lightning_fancyfx"] = "0",
					}
				},
				["CVars"] = {
					"sw_lightning_delay",
					"sw_lightning_delayoffset",
					"sw_lightning_damage",
					"sw_lightning_target_prop",
					"sw_lightning_target_player",
					"sw_lightning_target_npc",
					"sw_lightning_force",
					"sw_lightning_force_amount",
					"sw_lightning_ignite_target",
					"sw_lightning_ignite_duration",
					"sw_lightning_target_world",
					"sw_lightning_target_chance",
					"sw_lightning_fancyfx",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Lightning" , ["Command"] = "sw_weather lightning" } )
			Panel:ControlHelp( "Lightning.\nOvercast skies.\nLightning may strike you for significant damage." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Lightning Delay" , ["Command"] = "sw_lightning_delay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Delay between lightning." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Lightning Delay Offset" , ["Command"] = "sw_lightning_delayoffset" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Random delay offset between lightning." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Chance Ratio" , ["Command"] = "sw_lightning_target_chance" , ["Min"] = "1" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:ControlHelp( "Chance out of 100 for lightning to strike ground vs. targets." )

			Panel:AddControl( "checkbox" , { ["Label"] = "Targets World" , ["Command"] = "sw_lightning_target_world" } )
			Panel:ControlHelp( "Lightning will also strike world instead of purely targets." )
			Panel:AddControl( "checkbox" , { ["Label"] = "Targets Props" , ["Command"] = "sw_lightning_target_prop" } )
			Panel:ControlHelp( "Lightning target props." )
			Panel:AddControl( "checkbox" , { ["Label"] = "Targets Players" , ["Command"] = "sw_lightning_target_player" } )
			Panel:ControlHelp( "Lightning target players." )
			Panel:AddControl( "checkbox" , { ["Label"] = "Targets NPCs" , ["Command"] = "sw_lightning_target_npc" } )
			Panel:ControlHelp( "Lightning target NPCs." )

			Panel:AddControl( "slider" , { ["Label"] = "Damage Amount" , ["Command"] = "sw_lightning_damage" , ["Min"] = "1" , ["Max"] = "150" , ["Type"] = "int" } )
			Panel:ControlHelp( "Lightning strike damage." )

			Panel:AddControl( "checkbox" , { ["Label"] = "Inflicts Physics Force" , ["Command"] = "sw_lightning_force" } )
			Panel:ControlHelp( "Lightning inflicts physics force on objects." )
			Panel:AddControl( "slider" , { ["Label"] = "Force Amount" , ["Command"] = "sw_lightning_force_amount" , ["Min"] = "1" , ["Max"] = "200" , ["Type"] = "int" } )
			Panel:ControlHelp( "Physics force amount." )

			-- Panel:AddControl( "checkbox" , { ["Label"] = "Ignites Ground" , ["Command"] = "sw_lightning_ignite_world" } )
			-- Panel:ControlHelp( "Lightning ignites world." )
			Panel:AddControl( "checkbox" , { ["Label"] = "Ignites Targets" , ["Command"] = "sw_lightning_ignite_target" } )
			Panel:ControlHelp( "Lightning ignites targets." )
			Panel:AddControl( "slider" , { ["Label"] = "Burn Duration" , ["Command"] = "sw_lightning_ignite_duration" , ["Min"] = "1" , ["Max"] = "15" , ["Type"] = "int" } )
			Panel:ControlHelp( "Lighting strike burn duration." )

			Panel:AddControl( "checkbox" , { ["Label"] = "Fancy Effects" , ["Command"] = "sw_lightning_fancyfx" } )
			Panel:ControlHelp( "Show fancy effects for lightning." )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Hail" , "Hail" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_hail" ,
				["Options"] = {
					["default"] = {
						["sw_hail_delay"] = "2",
						["sw_hail_delayoffset"] = "2",
						["sw_hail_lifetime"] = "2",
						["sw_hail_drag"] = "2",
					},
					["potato"] = {
						["sw_hail_delay"] = "2",
						["sw_hail_delayoffset"] = "4",
						["sw_hail_lifetime"] = "0",
						["sw_hail_drag"] = "2",
					}
				},
				["CVars"] = {
					"sw_hail_delay",
					"sw_hail_delayoffset",
					"sw_hail_lifetime",
					"sw_hail_drag",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Hail" , ["Command"] = "sw_weather hail" } )
			Panel:ControlHelp( "Hail.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Hail Delay" , ["Command"] = "sw_hail_delay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Delay between hail." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Hail Delay Offset" , ["Command"] = "sw_hail_delayoffset" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Random delay offset between hail." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Hail Lifetime" , ["Command"] = "sw_hail_lifetime" , ["Min"] = "-1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Time for hail to fade after hitting the ground. -1 for never (not recommended)." )

			Panel:AddControl( "slider" , { ["Label"] = "Hail Drag" , ["Command"] = "sw_hail_drag" , ["Min"] = "0" , ["Max"] = "20" , ["Type"] = "int" } )
			Panel:ControlHelp( "Amount of drag to add to hail. Higher = slower decent." )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Meteor" , "Meteor" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_meteor" ,
				["Options"] = {
					["default"] = {
						["sw_meteor_delay"] = "2",
						["sw_meteor_delayoffset"] = "2",
						["sw_meteor_lifetime"] = "2",
						["sw_meteor_whoosh"] = "1",
						["sw_meteor_drag"] = "10",
						["sw_meteor_fancyfx"] = "1",
					},
					["hardcore"] = {
						["sw_meteor_delay"] = "1",
						["sw_meteor_delayoffset"] = "2",
						["sw_meteor_lifetime"] = "2",
						["sw_meteor_whoosh"] = "1",
						["sw_meteor_drag"] = "0",
						["sw_meteor_fancyfx"] = "1",
					},
					["potato"] = {
						["sw_meteor_delay"] = "5",
						["sw_meteor_delayoffset"] = "10",
						["sw_meteor_lifetime"] = "0",
						["sw_meteor_whoosh"] = "0",
						["sw_meteor_drag"] = "10",
						["sw_meteor_fancyfx"] = "0",
					}
				},
				["CVars"] = {
					"sw_meteor_delay",
					"sw_meteor_delayoffset",
					"sw_meteor_lifetime",
					"sw_meteor_drag",
					"sw_meteor_whoosh",
					"sw_meteor_fancyfx",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Meteor Storm" , ["Command"] = "sw_weather meteor" } )
			Panel:ControlHelp( "Meteor Storm.\nOvercast skies.\nMeteor strike will cause significant damage." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Meteor Delay" , ["Command"] = "sw_meteor_delay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Delay between meteors." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Meteor Delay Offset" , ["Command"] = "sw_meteor_delayoffset" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Random delay offset between meteors." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Meteor Lifetime" , ["Command"] = "sw_meteor_lifetime" , ["Min"] = "-1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Time for meteor shards to fade after hitting the ground. -1 for never (not recommended)." )

			Panel:AddControl( "slider" , { ["Label"] = "Meteor Drag" , ["Command"] = "sw_meteor_drag" , ["Min"] = "0" , ["Max"] = "50" , ["Type"] = "int" } )
			Panel:ControlHelp( "Amount of drag to add to the meteors. Higher = slower decent." )

			Panel:AddControl( "checkbox" , { ["Label"] = "Impact Sounds" , ["Command"] = "sw_meteor_whoosh" } )
			Panel:ControlHelp( "Meteors play a whoosh sound when near the ground." )

			Panel:AddControl( "checkbox" , { ["Label"] = "Fancy Effects" , ["Command"] = "sw_meteor_fancyfx" } )
			Panel:ControlHelp( "Show fancy effects for meteors." )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Snow" , "Snow" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {
				["MenuButton"] = 1 ,
				["Folder"] = "sw_snow" ,
				["Options"] = {
					["default"] = {
						["sw_snow_stay"] = "1",
						["sw_snow_height"] = "200",
						["sw_snow_radius"] = "1200",
						["sw_snow_count"] = "20",
						["sw_snow_dietime"] = "5",
						["sw_blizzard_height"] = "100",
						["sw_blizzard_radius"] = "1000",
						["sw_blizzard_count"] = "30",
						["sw_blizzard_dietime"] = "2",
					},
					["potato"] = {
						["sw_snow_stay"] = "0",
						["sw_snow_height"] = "100",
						["sw_snow_radius"] = "250",
						["sw_snow_count"] = "10",
						["sw_snow_dietime"] = "1",
						["sw_blizzard_height"] = "100",
						["sw_blizzard_radius"] = "500",
						["sw_blizzard_count"] = "20",
						["sw_blizzard_dietime"] = "1",
					}
				},
				["CVars"] = {
					"sw_snow_stay",
					"sw_snow_height",
					"sw_snow_radius",
					"sw_snow_count",
					"sw_blizzard_height",
					"sw_blizzard_radius",
					"sw_blizzard_count",
					"sw_blizzard_dietime",
				}
			} )

			Panel:AddControl( "button" , { ["Label"] = "Start Snow" , ["Command"] = "sw_weather snow" } )
			Panel:ControlHelp( "Snow.\nOvercast skies. Hampers visibility." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Snow Stays" , ["Command"] = "sw_snow_stay" } )
			Panel:ControlHelp( "Snow particles stick to ground." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Snow Height" , ["Command"] = "sw_snow_height" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Snow Radius" , ["Command"] = "sw_snow_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Snow Amount" , ["Command"] = "sw_snow_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Snow Lifetime" , ["Command"] = "sw_snow_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

			Panel:AddControl( "button" , { ["Label"] = "Start Blizzard" , ["Command"] = "sw_weather blizzard" } )
			Panel:ControlHelp( "Blizzard.\nOvercast skies. Hampers visibility and hearing.\nInflicts DOT from noxious air." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Blizzard Height" , ["Command"] = "sw_blizzard_height" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Blizzard Radius" , ["Command"] = "sw_blizzard_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Blizzard Amount" , ["Command"] = "sw_blizzard_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:AddControl( "slider" , { ["Label"] = "Blizzard Lifetime" , ["Command"] = "sw_blizzard_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

			Panel:AddControl( "checkbox" , { ["Label"] = "Toggle Coughing" , ["Command"] = "sw_blizzard_dmg_sound_toggle" } )
			Panel:ControlHelp( "Toggle coughing sounds." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Damage Delay" , ["Command"] = "sw_blizzard_dmg_delay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Delay between damage." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Damage Delay Offset" , ["Command"] = "sw_blizzard_dmg_delayoffset" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
			Panel:ControlHelp( "Random delay offset between damage." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Toggle Damage" , ["Command"] = "sw_blizzard_dmg_toggle" } )
			Panel:ControlHelp( "Toggle Blizzard damage." , {} )
			
			Panel:AddControl( "slider" , { ["Label"] = "Damage Amount" , ["Command"] = "sw_blizzard_dmg_amount" , ["Min"] = "1" , ["Max"] = "100" , ["Type"] = "int" } )
			Panel:ControlHelp( "How much damage per hit the Blizzard does." , {} )

		end)

		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Time" , "Time" , "" , "" , function( Panel )

			Panel:AddControl("ComboBox", {

				["MenuButton"] = 1 ,
				["Folder"] = "sw_time" ,
				["Options"] = {

					["default"] = {

						["sw_time_pause"] = "0" ,
						["sw_time_start"] = "10" ,
						["sw_time_real"] = "0" ,
						["sw_time_real_offset"] = "0" ,
						["sw_time_speed_day"] = "0.01" ,
						["sw_time_speed_night"] = "0.02" ,
						["sw_time_speed_stars"] = "0.01" ,

					},

					["Stargazer"] = {

						["sw_time_pause"] = "1" ,
						["sw_time_start"] = "0" ,
						["sw_settime"] = "0" ,
						["sw_time_speed_stars"] = "0.01" ,

					},

					["Daydreamer"] = {

						["sw_time_pause"] = "1" ,
						["sw_time_start"] = "10" ,
						["sw_settime"] = "10" ,

					}

				},

				["CVars"] = {

					"sw_settime" ,
					"sw_time_pause" ,
					"sw_time_start" ,
					"sw_time_real" ,
					"sw_time_real_offset" ,
					"sw_time_speed_day" ,
					"sw_time_speed_night" ,
					"sw_time_speed_stars" ,

				}

			} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Pause Time" , ["Command"] = "sw_time_pause" } )
			Panel:ControlHelp( "Pause the current time." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Start Time" , ["Command"] = "sw_time_start" , ["Min"] = "0" , ["Max"] = "23" , ["Type"] = "int" } )
			Panel:ControlHelp( "Time the server will start at on load." , {} )

			Panel:AddControl( "checkbox" , { ["Label"] = "Real-Time Clock" , ["Command"] = "sw_time_real" } )
			Panel:ControlHelp( "Use the system clock time instead." , {} )

			Panel:AddControl( "slider" , { ["Label"] = "Real-Time Offset" , ["Command"] = "sw_time_real_offset" , ["Min"] = "-12" , ["Max"] = "12" , ["Type"] = "int" } )
			Panel:ControlHelp( "Real time clock time zone offset." , {} )

			Panel:Help( "Rate at which day or night passes.\nWARNING: Higher numbers increase system chug. RAISE AT OWN RISK." , {} )
			Panel:AddControl( "slider" , { ["Label"] = "Day Speed" , ["Command"] = "sw_time_speed_day" , ["Min"] = "0.01" , ["Max"] = "0.2" , ["Type"] = "float" } )
			Panel:AddControl( "slider" , { ["Label"] = "Night Speed" , ["Command"] = "sw_time_speed_night" , ["Min"] = "0.01" , ["Max"] = "0.2" , ["Type"] = "float" } )

			Panel:AddControl( "slider" , { ["Label"] = "Star Rotate Speed" , ["Command"] = "sw_time_speed_stars" , ["Min"] = "0.01" , ["Max"] = "3" , ["Type"] = "float" } )
			Panel:ControlHelp( "Rate at which stars rotate at night." , {} )

			-- There's some jank ass math involved with this, so for now it's not enabled -V92

			-- Panel:AddControl( "slider" , { ["Label"] = "Dawn Time" , ["Command"] = "sw_time_dawn" , ["Min"] = "0" , ["Max"] = "23" , ["Type"] = "int" } )
			-- Panel:ControlHelp( "Time to consider Dawn.\nControls when map inputs runs the day_events entity." , {} )

			-- Panel:AddControl( "slider" , { ["Label"] = "Afternoon Time" , ["Command"] = "sw_time_afternoon" , ["Min"] = "0" , ["Max"] = "23" , ["Type"] = "int" } )
			-- Panel:ControlHelp( "Time to consider Afternoon." , {} )

			-- Panel:AddControl( "slider" , { ["Label"] = "Dusk Time" , ["Command"] = "sw_time_dusk" , ["Min"] = "0" , ["Max"] = "23" , ["Type"] = "int" } )
			-- Panel:ControlHelp( "Time to consider Dusk.\nControls when map inputs runs the night_events entity." , {} )

			-- Panel:AddControl( "slider" , { ["Label"] = "Night Time" , ["Command"] = "sw_time_night" , ["Min"] = "0" , ["Max"] = "23" , ["Type"] = "int" } )
			-- Panel:ControlHelp( "Time to consider Night." , {} )

		end)

	end)

	--------------------------------------------------
	-- Context Menu Bar
	--------------------------------------------------

	hook.Add( "PopulateMenuBar", "SimpleWeather_MenuBar", function( menubar )

		local m = menubar:AddOrGetMenu( "Simple Weather" )

		local hud = m:AddSubMenu( "Client..." )

		hud:SetDeleteSelf( false )

		hud:AddCVar( "Show HUD" , "sw_cl_hud_toggle" , "1" , "0" )
		hud:AddCVar( "HUD on Top" , "sw_cl_hud_position" , "1" , "0" )
		hud:AddCVar( "Show Weather Icon" , "sw_cl_hud_weather_toggle" , "1" , "0" )
		hud:AddCVar( "Show Clock" , "sw_cl_hud_clock_toggle" , "1" , "0" )
		hud:AddCVar( "24-Hour Clock" , "sw_cl_hud_clock_style" , "1" , "0" )
		hud:AddCVar( "Screen effects" , "sw_cl_screenfx" , "1" , "0" )
		hud:AddCVar( "Screen effects in vehicles" , "sw_cl_screenfx_vehicle" , "1" , "0" )
		hud:AddCVar( "Lightning Flashes" , "sw_cl_screenfx_lightning" , "1" , "0" )
		hud:AddCVar( "Color Mod" , "sw_cl_colormod" , "1" , "0" )
		hud:AddCVar( "Color Mod while Indoors" , "sw_cl_colormod_indoors" , "1" , "0" )
		hud:AddCVar( "Always Outside" , "sw_weather_alwaysoutside" , "1" , "0" )

		m:AddSpacer( )

		local times = m:AddSubMenu( "Time..." )

		times:SetDeleteSelf( false )

		times:AddCVar( "Pause Time", "sw_time_pause" , "1" , "0" )
		times:AddCVar( "Real Time", "sw_time_real" , "1" , "0" )
		times:AddOption( "0000", function( ) RunConsoleCommand( "sw_settime" , "0" ) end )
		times:AddOption( "0200", function( ) RunConsoleCommand( "sw_settime" , "2" ) end )
		times:AddOption( "0400", function( ) RunConsoleCommand( "sw_settime" , "4" ) end )
		times:AddOption( "0600", function( ) RunConsoleCommand( "sw_settime" , "6" ) end )
		times:AddOption( "0800", function( ) RunConsoleCommand( "sw_settime" , "8" ) end )
		times:AddOption( "1000", function( ) RunConsoleCommand( "sw_settime" , "10" ) end )
		times:AddOption( "1200", function( ) RunConsoleCommand( "sw_settime" , "12" ) end )
		times:AddOption( "1400", function( ) RunConsoleCommand( "sw_settime" , "14" ) end )
		times:AddOption( "1600", function( ) RunConsoleCommand( "sw_settime" , "16" ) end )
		times:AddOption( "1800", function( ) RunConsoleCommand( "sw_settime" , "18" ) end )
		times:AddOption( "2000", function( ) RunConsoleCommand( "sw_settime" , "20" ) end )
		times:AddOption( "2200", function( ) RunConsoleCommand( "sw_settime" , "22" ) end )

		local timeoffset = m:AddSubMenu( "Real Time Offset..." )

		timeoffset:SetDeleteSelf( false )

		timeoffset:AddOption( "-12", function( ) RunConsoleCommand( "sw_time_real_offset" , "-12" ) end )
		timeoffset:AddOption( "-11", function( ) RunConsoleCommand( "sw_time_real_offset" , "-11" ) end )
		timeoffset:AddOption( "-10", function( ) RunConsoleCommand( "sw_time_real_offset" , "-10" ) end )
		timeoffset:AddOption( "-9", function( ) RunConsoleCommand( "sw_time_real_offset" , "-9" ) end )
		timeoffset:AddOption( "-8", function( ) RunConsoleCommand( "sw_time_real_offset" , "-8" ) end )
		timeoffset:AddOption( "-7", function( ) RunConsoleCommand( "sw_time_real_offset" , "-7" ) end )
		timeoffset:AddOption( "-6", function( ) RunConsoleCommand( "sw_time_real_offset" , "-6" ) end )
		timeoffset:AddOption( "-5", function( ) RunConsoleCommand( "sw_time_real_offset" , "-5" ) end )
		timeoffset:AddOption( "-4", function( ) RunConsoleCommand( "sw_time_real_offset" , "-4" ) end )
		timeoffset:AddOption( "-3", function( ) RunConsoleCommand( "sw_time_real_offset" , "-3" ) end )
		timeoffset:AddOption( "-2", function( ) RunConsoleCommand( "sw_time_real_offset" , "-2" ) end )
		timeoffset:AddOption( "-1", function( ) RunConsoleCommand( "sw_time_real_offset" , "-1" ) end )
		timeoffset:AddOption( "0", function( ) RunConsoleCommand( "sw_time_real_offset" , "0" ) end )
		timeoffset:AddOption( "1", function( ) RunConsoleCommand( "sw_time_real_offset" , "1" ) end )
		timeoffset:AddOption( "2", function( ) RunConsoleCommand( "sw_time_real_offset" , "2" ) end )
		timeoffset:AddOption( "3", function( ) RunConsoleCommand( "sw_time_real_offset" , "3" ) end )
		timeoffset:AddOption( "4", function( ) RunConsoleCommand( "sw_time_real_offset" , "4" ) end )
		timeoffset:AddOption( "5", function( ) RunConsoleCommand( "sw_time_real_offset" , "5" ) end )
		timeoffset:AddOption( "6", function( ) RunConsoleCommand( "sw_time_real_offset" , "6" ) end )
		timeoffset:AddOption( "7", function( ) RunConsoleCommand( "sw_time_real_offset" , "7" ) end )
		timeoffset:AddOption( "8", function( ) RunConsoleCommand( "sw_time_real_offset" , "8" ) end )
		timeoffset:AddOption( "9", function( ) RunConsoleCommand( "sw_time_real_offset" , "9" ) end )
		timeoffset:AddOption( "10", function( ) RunConsoleCommand( "sw_time_real_offset" , "10" ) end )
		timeoffset:AddOption( "11", function( ) RunConsoleCommand( "sw_time_real_offset" , "11" ) end )
		timeoffset:AddOption( "12", function( ) RunConsoleCommand( "sw_time_real_offset" , "12" ) end )

		m:AddCVar( "Map Outputs", "sw_func_maplogic" , "1" , "0" )

		m:AddSpacer( )

		local volume = m:AddSubMenu( "Sounds..." )

		volume:SetDeleteSelf( false )

		volume:AddCVar( "Sounds" , "sw_cl_sound" , "1" , "0" )
		volume:AddCVar( "Sirens" , "sw_cl_sound_siren" , "1" , "0" )
		volume:AddOption( "Volume 33%", function( ) RunConsoleCommand( "sw_cl_sound_volume" , "0.3" ) end )
		volume:AddOption( "Volume 66%", function( ) RunConsoleCommand( "sw_cl_sound_volume" , "0.6" ) end )
		volume:AddOption( "Volume 100%", function( ) RunConsoleCommand( "sw_cl_sound_volume" , "1" ) end )

		local perf = m:AddSubMenu( "Performance..." )

		perf:SetDeleteSelf( false )

		perf:AddCVar( "Rain Impacts" , "sw_rain_showimpact" , "1" , "0" )
		perf:AddCVar( "Rain Puffs" , "sw_rain_showsmoke" , "1" , "0" )
		perf:AddCVar( "Snow Stays" , "sw_snow_stay" , "1" , "0" )

		local rainquality = perf:AddSubMenu( "Rain Quality..." )

		rainquality:SetDeleteSelf( false )

		rainquality:AddOption( "Low", function( ) RunConsoleCommand( "sw_rain_quality" , "1" ) end )
		rainquality:AddOption( "Medium", function( ) RunConsoleCommand( "sw_rain_quality" , "2" ) end )
		rainquality:AddOption( "High", function( ) RunConsoleCommand( "sw_rain_quality" , "3" ) end )
		rainquality:AddOption( "Ultra", function( ) RunConsoleCommand( "sw_rain_quality" , "4" ) end )

		m:AddSpacer( )

		local rng = m:AddSubMenu( "Start Weather..." )

		rng:SetDeleteSelf( false )

		rng:AddOption( "Fog", function( ) RunConsoleCommand( "sw_weather" , "fog" ) end )
		rng:AddOption( "Smog", function( ) RunConsoleCommand( "sw_weather" , "smog" ) end )
		rng:AddOption( "Sandstorm", function( ) RunConsoleCommand( "sw_weather" , "sandstorm" ) end )

		rng:AddSpacer( )

		rng:AddOption( "Rain", function( ) RunConsoleCommand( "sw_weather" , "rain" ) end )
		rng:AddOption( "Hail", function( ) RunConsoleCommand( "sw_weather" , "hail" ) end )
		rng:AddOption( "Thunderstorm", function( ) RunConsoleCommand( "sw_weather" , "thunderstorm" ) end )
		rng:AddOption( "Heavy Storm", function( ) RunConsoleCommand( "sw_weather" , "heavystorm" ) end )
		rng:AddOption( "Lightning", function( ) RunConsoleCommand( "sw_weather" , "lightning" ) end )
		
		rng:AddSpacer( )

		rng:AddOption( "Snow", function( ) RunConsoleCommand( "sw_weather" , "snow" ) end )
		rng:AddOption( "Blizzard", function( ) RunConsoleCommand( "sw_weather" , "blizzard" ) end )

		rng:AddSpacer( )

		rng:AddOption( "Acid Rain", function( ) RunConsoleCommand( "sw_weather" , "acidrain" ) end )
		rng:AddOption( "Meteor Storm", function( ) RunConsoleCommand( "sw_weather" , "meteor" ) end )

		m:AddOption( "Stop Current Weather", function( ) RunConsoleCommand( "sw_stopweather" ) end )

		local rng = m:AddSubMenu( "Auto-Weather..." )

		rng:SetDeleteSelf( false )

		rng:AddCVar( "Enable", "sw_autoweather" , "1" , "0" )

		rng:AddSpacer( )

		rng:AddCVar( "Fog", "sw_fog" , "1" , "0" )
		rng:AddCVar( "Smog", "sw_smog" , "1" , "0" )
		rng:AddCVar( "Sandstorm", "sw_sandstorm" , "1" , "0" )

		rng:AddSpacer( )

		rng:AddCVar( "Rain", "sw_rain" , "1" , "0" )
		rng:AddCVar( "Hail", "sw_hail" , "1" , "0" )
		rng:AddCVar( "Thunderstorm", "sw_thunderstorm" , "1" , "0" )
		rng:AddCVar( "Heavy Storm", "sw_heavystorm" , "1" , "0" )
		rng:AddCVar( "Lightning", "sw_lightning" , "1" , "0" )
		
		rng:AddSpacer( )

		rng:AddCVar( "Snow", "sw_snow" , "1" , "0" )
		rng:AddCVar( "Blizzard", "sw_blizzard" , "1" , "0" )

		rng:AddSpacer( )

		rng:AddCVar( "Acid Rain", "sw_acidrain" , "1" , "0" )
		rng:AddCVar( "Meteor Storm", "sw_meteor" , "1" , "0" )

	end )

end

if SERVER then

	resource.AddWorkshop( "531458635" ) -- SimpleWeather https://steamcommunity.com/sharedfiles/filedetails/?id=531458635

	include( "simpleweather/sv_init.lua" )

	--------------------------------------------------
	-- Test code stolen from TFA base
	--------------------------------------------------

	local IsSinglePlayer = game.SinglePlayer()

	util.AddNetworkString("SW_SetServerCommand")

	local function QueueConVarChange(convarname, convarvalue)
		if not convarname or not convarvalue then return end

		timer.Create("sw_cvarchange_" .. convarname, 0.1, 1, function()
			if not string.find(convarname, "sw_") or not GetConVar(convarname) then return end -- affect only SW convars

			RunConsoleCommand(convarname, convarvalue)
		end)
	end

	local function ChangeServerOption(_length, _player)
		local _cvarname = net.ReadString()
		local _value = net.ReadString()

		if IsSinglePlayer then return end
		if not IsValid(_player) or not _player:IsAdmin() then return end

		QueueConVarChange(_cvarname, _value)
	end

	net.Receive("SW_SetServerCommand", ChangeServerOption)

end
