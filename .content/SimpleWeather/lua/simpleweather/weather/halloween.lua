
WEATHER = WEATHER or {}
WEATHER.ID = "halloween"
WEATHER.ConVar = { "sw_halloween", "Halloween" }
WEATHER.Sound = ""
WEATHER.WindScale = 2
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = true

WEATHER.Announcement = "Something Wicked This Way Comes..."
WEATHER.Icon = Material( "icon16/weather_clouds.png" )
WEATHER.Advisory = 0

-- WEATHER.Raindrops = true
-- WEATHER.RaindropMinDelay = 0.1
-- WEATHER.RaindropMaxDelay = 0.4

WEATHER.FogStart = 512
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.97
WEATHER.FogColor = Color( 14 , 127 , 6 , 255 )

-- WEATHER.SkyColorTop = Color( 0 , 0 , 0 )
-- WEATHER.SkyColorBottom = Color( 12 , 127 , 5 )
-- WEATHER.SkyFadeBias = 0.25
-- WEATHER.SkyHDRScale = 0.66

WEATHER.LightStyleDay = 8
WEATHER.LightStyleNight = 1

WEATHER.DefaultSky = {
	["TopColor"]		= Vector( 0.0 , 0.0 , 0.0 ) ,
	["BottomColor"]		= Vector( 0.05 , 0.05 , 0.02 ) ,
	["FadeBias"]		= 0.25 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0 ,
	["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	["SunSize"]			= 0 ,
	["SunColor"]		= Vector( 0 , 0 , 0 ) ,
	["StarTexture"]		= "skybox/clouds" ,
	["StarLayers"]		= 1 ,
	["StarScale"]		= 3 ,
	["StarFade"]		= 5 ,
	["StarSpeed"]		= 0.05  
}

WEATHER.SkyColorsNight = {
	["TopColor"]		= Vector( 0.0 , 0.02 , 0.0 ) ,
	["BottomColor"]		= Vector( 0.02 , 0.15 , 0 ) ,
	["FadeBias"]		= 0.25 ,
	["HDRScale"]		= 0.66 ,
	["DuskIntensity"]	= 0 ,
	["DuskScale"]		= 0 ,
	["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	["SunSize"]			= 0 ,
	["SunColor"]		= Vector( 0 , 0 , 0 ) ,
	["StarTexture"]		= "skybox/clouds" ,
	["StarLayers"]		= 1 ,
	["StarScale"]		= 3 ,
	["StarFade"]		= 5 ,
	["StarSpeed"]		= 0.05
}
