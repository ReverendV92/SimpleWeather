
WEATHER = WEATHER or {}
WEATHER.ID = "rain"
WEATHER.ConVar = { "sw_rain", "Rain" }
WEATHER.Sound = "rain"
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = false
WEATHER.ParticleSystem = "v92_weather_rain"

WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.1
WEATHER.RaindropMaxDelay = 0.4

WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

WEATHER.SkyColorTop = Color( 64 , 90 , 115 )
WEATHER.SkyColorBottom = Color( 25 , 25 , 25 )
WEATHER.SkyFadeBias = 0.3
WEATHER.SkyHDRScale = 0.66

-- WEATHER.DefaultSky = {
	-- ["TopColor"]		= Vector( 0.34 , 0.34 , 0.34 ) ,
	-- ["BottomColor"]		= Vector( 0.19 , 0.19 , 0.19 ) ,
	-- ["FadeBias"]		= 1 ,
	-- ["HDRScale"]		= 0.66 ,
	-- ["DuskIntensity"]	= 0 ,
	-- ["DuskScale"]		= 0 ,
	-- ["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["SunSize"]			= 0 ,
	-- ["SunColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["StarTexture"]		= "skybox/clouds" ,
	-- ["StarLayers"]		= 1 ,
	-- ["StarScale"]		= 3 ,
	-- ["StarFade"]		= 5 ,
	-- ["StarSpeed"]		= 0.05  
-- }

-- WEATHER.SkyColorsNight = {
	-- ["TopColor"]		= Vector( 0.02 , 0.02 , 0.02 ) ,
	-- ["BottomColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["FadeBias"]		= 1 ,
	-- ["HDRScale"]		= 0.66 ,
	-- ["DuskIntensity"]	= 0 ,
	-- ["DuskScale"]		= 0 ,
	-- ["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["SunSize"]			= 0 ,
	-- ["SunColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["StarTexture"]		= "skybox/clouds" ,
	-- ["StarLayers"]		= 1 ,
	-- ["StarScale"]		= 3 ,
	-- ["StarFade"]		= 5 ,
	-- ["StarSpeed"]		= 0.05
-- }

WEATHER.Icon = Material( "icon16/weather_rain.png" )
WEATHER.Announcement = "A Rain Shower is approaching the area."

function WEATHER:Think()

	SW.RainThink()

end