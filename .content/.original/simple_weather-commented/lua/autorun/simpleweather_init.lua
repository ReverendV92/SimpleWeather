
AddCSLuaFile( )

if SERVER then

	resource.AddWorkshop( "531458635" )

	include( "simpleweather/sv_init.lua" )

end

if CLIENT then
	
	include( "simpleweather/cl_init.lua" )

	local function SimpleWeather_Client( CPanel )

		CPanel:AddControl("ComboBox", {

			["MenuButton"] = 1 ,
			["Folder"] = "sw_client" ,
			["Options"] = {

				["default"] = {

					["sw_cl_colormod"] = "1",
					["sw_cl_colormod_indoors"] = "0",
					["sw_cl_clock_show"] = "1",
					["sw_cl_clock_position"] = "1",
					["sw_cl_clock_style"] = "1",
					["sw_cl_sounds"] = "1",
					["sw_cl_fxvolume"] = "0.3",

				}

			},

			["CVars"] = {

				"sw_cl_colormod" ,
				"sw_cl_colormod_indoors" ,
				"sw_cl_clock_show" ,
				"sw_cl_clock_position" ,
				"sw_cl_clock_style" ,
				"sw_cl_sounds" ,
				"sw_cl_fxvolume" ,

			}

		} )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Color Mod" , ["Command"] = "sw_cl_colormod" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Color Mod Indoors" , ["Command"] = "sw_cl_colormod_indoors" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Play Sounds" , ["Command"] = "sw_cl_sounds" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Volume" , ["Command"] = "sw_cl_fxvolume" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )

	end

	local function SimpleWeather_Fog( CPanel )

		CPanel:AddControl("ComboBox", {
			["MenuButton"] = 1 ,
			["Folder"] = "sw_client" ,
			["Options"] = {
				["default"] = {
					["sw_sv_fog_indoors"] = "0",
					["sw_sv_fog_densityday"] = "1",
					["sw_sv_fog_densitynight"] = "0.4",
					["sw_sv_fog_speed"] = "0.01",
				}
			},
			["CVars"] = {
				"sw_sv_fog_indoors",
				"sw_sv_fog_densityday",
				"sw_sv_fog_densitynight",
				"sw_sv_fog_speed",
			}
		} )

		CPanel:AddControl( "button" , { ["Label"] = "Start Fog" , ["Command"] = "sw_weather fog" } )
		CPanel:ControlHelp( "Fog.\nHampers visibility." , {} )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Fog Indoors" , ["Command"] = "sw_sv_fog_indoors" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Day Fog Density" , ["Command"] = "sw_sv_fog_densityday" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Night Fog Density" , ["Command"] = "sw_sv_fog_densitynight" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Fog Speed" , ["Command"] = "sw_sv_fog_speed" , ["Min"] = "0" , ["Max"] = "1" , ["Type"] = "float" } )

	end

	local function SimpleWeather_Rain( CPanel )

		CPanel:AddControl("ComboBox", {
			["MenuButton"] = 1 ,
			["Folder"] = "sw_client" ,
			["Options"] = {
				["default"] = {
					["sw_cl_rain_showsmoke"] = "1",
					["sw_cl_rain_showimpact"] = "1",
					["sw_cl_rain_vehicledrops"] = "1",
					["sw_sv_lightning_flash"] = "1",
					["sw_cl_rain_quality"] = "1",
					["sw_cl_rain_screen"] = "1",
					["sw_cl_rain_dropsize_min"] = "20",
					["sw_cl_rain_dropsize_max"] = "40",
					["sw_cl_rain_height"] = "300",
					["sw_cl_rain_radius"] = "500",
					["sw_cl_rain_count"] = "20",
					["sw_cl_rain_dietime"] = "3",
					["sw_cl_storm_radius"] = "500",
					["sw_cl_storm_count"] = "120",
					["sw_cl_storm_dietime"] = "3",
					["sw_sv_thunder_mindelay"] = "10",
				}
			},
			["CVars"] = {
				"sw_cl_rain_showsmoke",
				"sw_cl_rain_showimpact",
				"sw_cl_rain_vehicledrops",
				"sw_sv_lightning_flash",
				"sw_cl_rain_quality",
				"sw_cl_rain_screen",
				"sw_cl_rain_dropsize_min",
				"sw_cl_rain_dropsize_max",
				"sw_cl_rain_height",
				"sw_cl_rain_radius",
				"sw_cl_rain_count",
				"sw_cl_rain_dietime",
				"sw_cl_storm_radius",
				"sw_cl_storm_count",
				"sw_cl_storm_dietime",
				"sw_sv_thunder_mindelay",
			}
		} )

		CPanel:AddControl( "button" , { ["Label"] = "Start Rain" , ["Command"] = "sw_weather rain" } )
		CPanel:ControlHelp( "Rain.\nOvercast skies." , {} )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Rain Puffs" , ["Command"] = "sw_cl_rain_showsmoke" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Rain Impacts" , ["Command"] = "sw_cl_rain_showimpact" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Vehicle Screen Effects" , ["Command"] = "sw_cl_rain_vehicledrops" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Lighting Flashes" , ["Command"] = "sw_sv_lightning_flash" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Rain Quality" , ["Command"] = "sw_cl_rain_quality" , ["Min"] = "1" , ["Max"] = "4" , ["Type"] = "int" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Screen Effects" , ["Command"] = "sw_cl_rain_screen" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Drop Size Minimum" , ["Command"] = "sw_cl_rain_dropsize_min" , ["Min"] = "10" , ["Max"] = "1000" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Drop Size Maximum" , ["Command"] = "sw_cl_rain_dropsize_max" , ["Min"] = "10" , ["Max"] = "1000" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Rain Height" , ["Command"] = "sw_cl_rain_height" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Rain Radius" , ["Command"] = "sw_cl_rain_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Rain Amount" , ["Command"] = "sw_cl_rain_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Rain Lifetime" , ["Command"] = "sw_cl_rain_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )
		
		CPanel:AddControl( "button" , { ["Label"] = "Start Thunderstorm" , ["Command"] = "sw_weather storm" } )
		CPanel:ControlHelp( "Thunderstorm.\nOvercast skies. Hampers visibility.\nLightning may strike you for significant damage." , {} )

		CPanel:AddControl( "slider" , { ["Label"] = "Thunderstorm Radius" , ["Command"] = "sw_cl_storm_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Thunderstorm Amount" , ["Command"] = "sw_cl_storm_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Thunderstorm Lifetime" , ["Command"] = "sw_cl_storm_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

		CPanel:AddControl( "slider" , { ["Label"] = "Thunder Minimum Delay" , ["Command"] = "sw_sv_thunder_mindelay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Thunder Maximum Delay" , ["Command"] = "sw_sv_thunder_maxdelay" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Thunder Flashing" , ["Command"] = "sw_sv_lightning_flash" } )

		CPanel:AddControl( "button" , { ["Label"] = "Start Hail" , ["Command"] = "sw_weather hail" } )
		CPanel:ControlHelp( "Hail.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects." , {} )

		CPanel:AddControl( "button" , { ["Label"] = "Start Heavy Storm" , ["Command"] = "sw_weather heavystorm" } )
		CPanel:ControlHelp( "Heavy Storm.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects. Lightning may strike you for significant damage." , {} )

	end

	local function SimpleWeather_Lightning( CPanel )

		CPanel:AddControl("ComboBox", {
			["MenuButton"] = 1 ,
			["Folder"] = "sw_client" ,
			["Options"] = {
				["default"] = {
					["sw_sv_lightning_delaymin"] = "1",
					["sw_sv_lightning_delaymax"] = "10",
					["sw_sv_lightning_dmg_prop"] = "1",
					["sw_sv_lightning_dmg_player"] = "1",
					["sw_sv_lightning_force"] = "1",
					["sw_sv_lightning_force_amount"] = "40",
					["sw_sv_lightning_ignite"] = "1",
					["sw_sv_lightning_ignitetime"] = "10",
					["sw_sv_lightning_dmg_amount"] = "50",
					["sw_sv_lightning_hitground"] = "1",
					["sw_sv_lightning_hitground_chance"] = "70",
				}
			},
			["CVars"] = {
				"sw_sv_lightning_delaymin",
				"sw_sv_lightning_delaymax",
				"sw_sv_lightning_dmg_prop",
				"sw_sv_lightning_dmg_player",
				"sw_sv_lightning_force",
				"sw_sv_lightning_force_amount",
				"sw_sv_lightning_ignite",
				"sw_sv_lightning_ignitetime",
				"sw_sv_lightning_dmg_amount",
				"sw_sv_lightning_hitground",
				"sw_sv_lightning_hitground_chance",
			}
		} )

		CPanel:AddControl( "button" , { ["Label"] = "Start Lightning" , ["Command"] = "sw_weather lightning" } )
		CPanel:ControlHelp( "Lightning.\nOvercast skies.\nLightning may strike you for significant damage." , {} )

		CPanel:AddControl( "slider" , { ["Label"] = "Minimum Delay" , ["Command"] = "sw_sv_lightning_delaymin" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Maximum Delay" , ["Command"] = "sw_sv_lightning_delaymax" , ["Min"] = "2" , ["Max"] = "30" , ["Type"] = "int" } )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Hits Ground" , ["Command"] = "sw_sv_lightning_hitground" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Chance Ratio" , ["Command"] = "sw_sv_lightning_hitground_chance" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
		CPanel:ControlHelp( "Chance for lightning to strike ground vs. players." )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Damages Props" , ["Command"] = "sw_sv_lightning_dmg_prop" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Damages Players" , ["Command"] = "sw_sv_lightning_dmg_player" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Damage Amount" , ["Command"] = "sw_sv_lightning_dmg_amount" , ["Min"] = "0" , ["Max"] = "150" , ["Type"] = "int" } )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Inflicts Force" , ["Command"] = "sw_sv_lightning_force" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Force Amount" , ["Command"] = "sw_sv_lightning_force_amount" , ["Min"] = "0" , ["Max"] = "200" , ["Type"] = "int" } )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Ignites Props" , ["Command"] = "sw_sv_lightning_ignite" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Burn Duration" , ["Command"] = "sw_sv_lightning_ignitetime" , ["Min"] = "0" , ["Max"] = "30" , ["Type"] = "int" } )

	end

	local function SimpleWeather_Hail( CPanel )

		CPanel:AddControl("ComboBox", {
			["MenuButton"] = 1 ,
			["Folder"] = "sw_client" ,
			["Options"] = {
				["default"] = {
					["sw_sv_hail_delaymin"] = "1",
					["sw_sv_hail_delaymax"] = "10",
					["sw_sv_hail_lifetime"] = "2",
				}
			},
			["CVars"] = {
				"sw_sv_hail_delaymin",
				"sw_sv_hail_delaymax",
				"sw_sv_hail_lifetime",
			}
		} )

		CPanel:AddControl( "button" , { ["Label"] = "Start Hail" , ["Command"] = "sw_weather hail" } )
		CPanel:ControlHelp( "Hail.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects." , {} )

		CPanel:AddControl( "slider" , { ["Label"] = "Minimum Delay" , ["Command"] = "sw_sv_hail_delaymin" , ["Min"] = "1" , ["Max"] = "30" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Maximum Delay" , ["Command"] = "sw_sv_hail_delaymax" , ["Min"] = "2" , ["Max"] = "30" , ["Type"] = "int" } )

		CPanel:AddControl( "slider" , { ["Label"] = "Hail Lifetime" , ["Command"] = "sw_sv_hail_lifetime" , ["Min"] = "-1" , ["Max"] = "30" , ["Type"] = "int" } )
		CPanel:ControlHelp( "Time for hail to fade after hitting the ground. -1 for never (not recommended)." )

	end

	local function SimpleWeather_Snow( CPanel )

		CPanel:AddControl("ComboBox", {
			["MenuButton"] = 1 ,
			["Folder"] = "sw_client" ,
			["Options"] = {
				["default"] = {
					["sw_cl_snow_stay"] = "1",
					["sw_cl_snow_height"] = "200",
					["sw_cl_snow_radius"] = "1200",
					["sw_cl_snow_count"] = "20",
					["sw_cl_snow_dietime"] = "5",
					["sw_cl_blizzard_height"] = "100",
					["sw_cl_blizzard_radius"] = "1000",
					["sw_cl_blizzard_count"] = "30",
					["sw_cl_blizzard_dietime"] = "2",
				}
			},
			["CVars"] = {
				"sw_cl_snow_stay",
				"sw_cl_snow_height",
				"sw_cl_snow_radius",
				"sw_cl_snow_count",
				"sw_cl_blizzard_height",
				"sw_cl_blizzard_radius",
				"sw_cl_blizzard_count",
				"sw_cl_blizzard_dietime",
			}
		} )

		CPanel:AddControl( "button" , { ["Label"] = "Start Snow" , ["Command"] = "sw_weather snow" } )
		CPanel:ControlHelp( "Snow.\nOvercast skies. Hampers visibility." , {} )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Snow Stays" , ["Command"] = "sw_cl_snow_stay" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Snow Height" , ["Command"] = "sw_cl_snow_height" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Snow Radius" , ["Command"] = "sw_cl_snow_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Snow Amount" , ["Command"] = "sw_cl_snow_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Snow Lifetime" , ["Command"] = "sw_cl_snow_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

		CPanel:AddControl( "button" , { ["Label"] = "Start Blizzard" , ["Command"] = "sw_weather blizzard" } )
		CPanel:ControlHelp( "Blizzard.\nOvercast skies. Hampers visibility and hearing." , {} )

		CPanel:AddControl( "slider" , { ["Label"] = "Blizzard Height" , ["Command"] = "sw_cl_blizzard_height" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Blizzard Radius" , ["Command"] = "sw_cl_blizzard_radius" , ["Min"] = "0" , ["Max"] = "2500" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Blizzard Amount" , ["Command"] = "sw_cl_blizzard_count" , ["Min"] = "0" , ["Max"] = "100" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Blizzard Lifetime" , ["Command"] = "sw_cl_blizzard_dietime" , ["Min"] = "0" , ["Max"] = "16" , ["Type"] = "int" } )

	end

	local function SimpleWeather_Time( CPanel )

		CPanel:AddControl("ComboBox", {

			["MenuButton"] = 1 ,
			["Folder"] = "sw_time" ,
			["Options"] = {

				["default"] = {

					["sw_sv_starrotatespeed"] = "0.01" ,
					["sw_sv_time_start"] = "10" ,
					["sw_sv_realtime"] = "0" ,
					["sw_sv_realtime_offset"] = "0" ,
					["sw_sv_enabletime"] = "1" ,
					["sw_sv_mapoutputs"] = "1" ,

				}

			},

			["CVars"] = {

				"sw_sv_starrotatespeed" ,
				"sw_sv_time_start" ,
				"sw_sv_realtime" ,
				"sw_sv_realtime_offset" ,
				"sw_sv_enabletime" ,
				"sw_sv_mapoutputs" ,

			}

		} )

		CPanel:AddControl( "checkbox" , { ["Label"] = "Enable Time" , ["Command"] = "sw_sv_enabletime" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Show Clock" , ["Command"] = "sw_cl_clock_show" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Clock Position" , ["Command"] = "sw_cl_clock_position" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "24-Hour Clock" , ["Command"] = "sw_cl_clock_style" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Start Time" , ["Command"] = "sw_sv_time_start" , ["Min"] = "0" , ["Max"] = "23" , ["Type"] = "int" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Real-Time Clock" , ["Command"] = "sw_sv_realtime" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Real-Time Offset" , ["Command"] = "sw_sv_realtime_offset" , ["Min"] = "-12" , ["Max"] = "12" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Star Rotate Speed" , ["Command"] = "sw_sv_starrotatespeed" , ["Min"] = "0.01" , ["Max"] = "3" , ["Type"] = "float" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Map Outputs" , ["Command"] = "sw_sv_mapoutputs" } )

	end

	local function SimpleWeather_Weather( CPanel )

		CPanel:AddControl( "button" , { ["Label"] = "Clear" , ["Command"] = "sw_stopweather" } )
		CPanel:ControlHelp( "Stop All Weather" , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Fog" , ["Command"] = "sw_weather fog" } )
		CPanel:ControlHelp( "Fog.\nHampers visibility." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Smog" , ["Command"] = "sw_weather smog" } )
		CPanel:ControlHelp( "Smog.\nHampers visibility.\nInflicts DOT from noxious air." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Sandstorm" , ["Command"] = "sw_weather sandstorm" } )
		CPanel:ControlHelp( "Sandstorm.\nHampers visibility and hearing." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Rain" , ["Command"] = "sw_weather rain" } )
		CPanel:ControlHelp( "Rain.\nOvercast skies." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Thunderstorm" , ["Command"] = "sw_weather storm" } )
		CPanel:ControlHelp( "Thunderstorm.\nOvercast skies. Hampers visibility.\nLightning may strike you for significant damage." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Hail" , ["Command"] = "sw_weather hail" } )
		CPanel:ControlHelp( "Hail.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Heavy Storm" , ["Command"] = "sw_weather heavystorm" } )
		CPanel:ControlHelp( "Heavy Storm.\nOvercast skies. Hampers visibility.\nHail may cause damage to struck objects.\nLightning may strike you for significant damage." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Lightning" , ["Command"] = "sw_weather lightning" } )
		CPanel:ControlHelp( "Lightning.\nOvercast skies.\nLightning may strike you for significant damage." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Snow" , ["Command"] = "sw_weather snow" } )
		CPanel:ControlHelp( "Snow.\nOvercast skies. Hampers visibility." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Blizzard" , ["Command"] = "sw_weather blizzard" } )
		CPanel:ControlHelp( "Blizzard.\nOvercast skies. Hampers visibility and hearing." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Acid Rain" , ["Command"] = "sw_weather acidrain" } )
		CPanel:ControlHelp( "Acid Rain.\nOvercast skies. Hampers visibility.\nInflicts DOT due to caustic rain." , {} )
		CPanel:AddControl( "button" , { ["Label"] = "Meteor Storm" , ["Command"] = "sw_weather meteor" } )
		CPanel:ControlHelp( "Meteor Storm.\nOvercast skies.\nMeteor strike will cause significant damage." , {} )

	end

	local function SimpleWeather_RNGWeather( CPanel )

		CPanel:AddControl("ComboBox", {

			["MenuButton"] = 1 ,
			["Folder"] = "sw_weather" ,
			["Options"] = {

				["default"] = {

					["sw_sv_autoweather"] = "1" ,
					["sw_sv_autoweather_minstart"] = "1" ,
					["sw_sv_autoweather_maxstart"] = "3" ,
					["sw_sv_autoweather_minstop"] = "0.2" ,
					["sw_sv_autoweather_maxstop"] = "8" ,
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
					["sw_storm"] = "1" ,

				}

			} ,

			["CVars"] = {

				"sw_sv_autoweather" ,
				"sw_sv_autoweather_minstart" ,
				"sw_sv_autoweather_maxstart" ,
				"sw_sv_autoweather_minstop" ,
				"sw_sv_autoweather_maxstop" ,
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
				"sw_storm" ,

			}

		} )

		-- CPanel:AddControl( "checkbox" , { ["Label"] = "Auto-Weather" , ["Command"] = "sw_sv_autoweather" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Min. Before Start" , ["Command"] = "sw_sv_autoweather_minstart" , ["Min"] = "1" , ["Max"] = "8" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Max Before Start" , ["Command"] = "sw_sv_autoweather_maxstart" , ["Min"] = "1" , ["Max"] = "8" , ["Type"] = "int" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Min. Before Stopping" , ["Command"] = "sw_sv_autoweather_minstop" , ["Min"] = "0" , ["Max"] = "8" , ["Type"] = "float" } )
		CPanel:AddControl( "slider" , { ["Label"] = "Max Before Stopping" , ["Command"] = "sw_sv_autoweather_maxstop" , ["Min"] = "1" , ["Max"] = "8" , ["Type"] = "float" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Fog" , ["Command"] = "sw_fog" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Smog" , ["Command"] = "sw_smog" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Sandstorm" , ["Command"] = "sw_sandstorm" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Rain" , ["Command"] = "sw_rain" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Hail" , ["Command"] = "sw_hail" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Thunderstorm" , ["Command"] = "sw_storm" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Heavy Storm" , ["Command"] = "sw_heavystorm" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Lightning" , ["Command"] = "sw_lightning" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Snow" , ["Command"] = "sw_snow" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Blizzard" , ["Command"] = "sw_blizzard" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Acid Rain" , ["Command"] = "sw_acidrain" } )
		CPanel:AddControl( "checkbox" , { ["Label"] = "Meteor Storm" , ["Command"] = "sw_meteor" } )

	end

	hook.Add( "PopulateToolMenu" , "SimpleWeather_Options" , function( )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Client" , "Client" , "" , "" , SimpleWeather_Client )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Time" , "Time" , "" , "" , SimpleWeather_Time )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Weather" , "Weather" , "" , "" , SimpleWeather_Weather )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_RNGWeather" , "Auto-Weather" , "" , "" , SimpleWeather_RNGWeather )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Rain" , "Rain" , "" , "" , SimpleWeather_Rain )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Hail" , "Hail" , "" , "" , SimpleWeather_Hail )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Lightning" , "Lightning" , "" , "" , SimpleWeather_Lightning )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Snow" , "Snow" , "" , "" , SimpleWeather_Snow )
		spawnmenu.AddToolMenuOption( "Options" , "Simple Weather" , "SimpleWeather_Fog" , "Fog" , "" , "" , SimpleWeather_Fog )
	end )

	hook.Add( "PopulateMenuBar", "SimpleWeather_MenuBar", function( menubar )

		local m = menubar:AddOrGetMenu( "Simple Weather" )

		local hud = m:AddSubMenu( "HUD..." )

		hud:SetDeleteSelf( false )

		hud:AddCVar( "Show Clock" , "sw_cl_clock_show" , "1" , "0" )
		hud:AddCVar( "Clock on Top" , "sw_cl_clock_position" , "1" , "0" )
		hud:AddCVar( "24-Hour Clock" , "sw_cl_clock_style" , "1" , "0" )
		hud:AddCVar( "Screen effects" , "sw_cl_rain_screen" , "1" , "0" )
		hud:AddCVar( "Screen effects in vehicles" , "sw_cl_rain_vehicledrops" , "1" , "0" )
		hud:AddCVar( "Color Mod" , "sw_cl_colormod" , "1" , "0" )
		hud:AddCVar( "Color Mod while Indoors" , "sw_cl_colormod_indoors" , "1" , "0" )
		hud:AddCVar( "Always Outside" , "sw_sv_alwaysoutside" , "1" , "0" )

		m:AddSpacer( )

		m:AddCVar( "Pause Time", "sw_sv_enabletime" , "1" , "0" )
		m:AddCVar( "Real Time", "sw_sv_realtime" , "1" , "0" )

		local times = m:AddSubMenu( "Time..." )

		times:SetDeleteSelf( false )

		-- times:AddOption( "Real-Time", function( ) RunConsoleCommand( "sw_sv_realtime" ) end )
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

		timeoffset:AddOption( "-12", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-12" ) end )
		timeoffset:AddOption( "-11", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-11" ) end )
		timeoffset:AddOption( "-10", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-10" ) end )
		timeoffset:AddOption( "-9", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-9" ) end )
		timeoffset:AddOption( "-8", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-8" ) end )
		timeoffset:AddOption( "-7", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-7" ) end )
		timeoffset:AddOption( "-6", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-6" ) end )
		timeoffset:AddOption( "-5", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-5" ) end )
		timeoffset:AddOption( "-4", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-4" ) end )
		timeoffset:AddOption( "-3", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-3" ) end )
		timeoffset:AddOption( "-2", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-2" ) end )
		timeoffset:AddOption( "-1", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "-1" ) end )
		timeoffset:AddOption( "0", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "0" ) end )
		timeoffset:AddOption( "1", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "1" ) end )
		timeoffset:AddOption( "2", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "2" ) end )
		timeoffset:AddOption( "3", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "3" ) end )
		timeoffset:AddOption( "4", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "4" ) end )
		timeoffset:AddOption( "5", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "5" ) end )
		timeoffset:AddOption( "6", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "6" ) end )
		timeoffset:AddOption( "7", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "7" ) end )
		timeoffset:AddOption( "8", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "8" ) end )
		timeoffset:AddOption( "9", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "9" ) end )
		timeoffset:AddOption( "10", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "10" ) end )
		timeoffset:AddOption( "11", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "11" ) end )
		timeoffset:AddOption( "12", function( ) RunConsoleCommand( "sw_sv_realtime_offset" , "12" ) end )

		m:AddCVar( "Map Outputs", "sw_sv_mapoutputs" , "1" , "0" )

		m:AddSpacer( )

		local volume = m:AddSubMenu( "Sounds..." )

		volume:SetDeleteSelf( false )

		volume:AddCVar( "Sounds" , "sw_cl_sounds" , "1" , "0" )
		volume:AddOption( "Volume 33%", function( ) RunConsoleCommand( "sw_cl_fxvolume" , "0.3" ) end )
		volume:AddOption( "Volume 66%", function( ) RunConsoleCommand( "sw_cl_fxvolume" , "0.6" ) end )
		volume:AddOption( "Volume 100%", function( ) RunConsoleCommand( "sw_cl_fxvolume" , "1" ) end )

		local perf = m:AddSubMenu( "Performance..." )

		perf:SetDeleteSelf( false )

		perf:AddCVar( "Rain Impacts" , "sw_cl_rain_showimpact" , "1" , "0" )
		perf:AddCVar( "Rain Puffs" , "sw_cl_rain_showsmoke" , "1" , "0" )
		perf:AddCVar( "Lightning Flashes" , "sw_sv_lightning_flash" , "1" , "0" )
		perf:AddCVar( "Snow Stays" , "sw_cl_snow_stay" , "1" , "0" )

		local rainquality = perf:AddSubMenu( "Rain Quality..." )

		rainquality:SetDeleteSelf( false )

		rainquality:AddOption( "Low", function( ) RunConsoleCommand( "sw_cl_rain_quality" , "1" ) end )
		rainquality:AddOption( "Medium", function( ) RunConsoleCommand( "sw_cl_rain_quality" , "2" ) end )
		rainquality:AddOption( "High", function( ) RunConsoleCommand( "sw_cl_rain_quality" , "3" ) end )
		rainquality:AddOption( "Ultra", function( ) RunConsoleCommand( "sw_cl_rain_quality" , "4" ) end )

		m:AddSpacer( )

		local rng = m:AddSubMenu( "Start Weather..." )

		rng:SetDeleteSelf( false )

		rng:AddOption( "Fog", function( ) RunConsoleCommand( "sw_weather" , "fog" ) end )
		rng:AddOption( "Smog", function( ) RunConsoleCommand( "sw_weather" , "smog" ) end )
		rng:AddOption( "Sandstorm", function( ) RunConsoleCommand( "sw_weather" , "sandstorm" ) end )

		rng:AddSpacer( )

		rng:AddOption( "Rain", function( ) RunConsoleCommand( "sw_weather" , "rain" ) end )
		rng:AddOption( "Hail", function( ) RunConsoleCommand( "sw_weather" , "hail" ) end )
		rng:AddOption( "Thunderstorm", function( ) RunConsoleCommand( "sw_weather" , "storm" ) end )
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

		rng:AddCVar( "Enable", "sw_sv_autoweather" , "1" , "0" )

		rng:AddSpacer( )

		rng:AddCVar( "Fog", "sw_fog" , "1" , "0" )
		rng:AddCVar( "Smog", "sw_smog" , "1" , "0" )
		rng:AddCVar( "Sandstorm", "sw_sandstorm" , "1" , "0" )

		rng:AddSpacer( )

		rng:AddCVar( "Rain", "sw_rain" , "1" , "0" )
		rng:AddCVar( "Hail", "sw_hail" , "1" , "0" )
		rng:AddCVar( "Thunderstorm", "sw_storm" , "1" , "0" )
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
