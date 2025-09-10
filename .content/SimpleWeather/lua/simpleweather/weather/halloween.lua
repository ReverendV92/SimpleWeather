
WEATHER = WEATHER or {}
WEATHER.ID = "halloween"
WEATHER.ConVar = { "sw_halloween", "Halloween" }
WEATHER.Sound = ""
WEATHER.WindScale = 2
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = true

WEATHER.Announcement = "Something Wicked This Way Comes..."
WEATHER.Icon = Material( "icon16/weather_cloudy.png" )
WEATHER.IconColor = Color( 150 , 255 , 150 , 255 )
WEATHER.Advisory = 0
WEATHER.Broadcast = Sound("vo/ravenholm/madlaugh04.wav")

WEATHER.FogStart = 512
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.9
WEATHER.FogColor = Color( 15 , 50 , 15 , 255 )

WEATHER.LightStyleDay = 8
WEATHER.LightStyleNight = 1

-- WEATHER.DefaultSky = {
	-- ["TopColor"]		= Vector( 0.1 , 0.15 , 0.0 ) ,
	-- ["BottomColor"]		= Vector( 0.12 , 0.27 , 0.11 ) ,
	-- ["FadeBias"]		= 0.25 ,
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
	-- ["TopColor"]		= Vector( 0.0 , 0.02 , 0.0 ) ,
	-- ["BottomColor"]		= Vector( 0.02 , 0.15 , 0 ) ,
	-- ["FadeBias"]		= 0.25 ,
	-- ["HDRScale"]		= 0.66 ,
	-- ["DuskIntensity"]	= 0 ,
	-- ["DuskScale"]		= 0 ,
	-- ["DuskColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["SunSize"]			= 0 ,
	-- ["SunColor"]		= Vector( 0 , 0 , 0 ) ,
	-- ["StarTexture"]		= "skybox/starfield" ,
	-- ["StarLayers"]		= 1 ,
	-- ["StarScale"]		= 3 ,
	-- ["StarFade"]		= 5 ,
	-- ["StarSpeed"]		= 0.05
-- }

-- local SpecialEntity = "sw_meteor_small"

-- function WEATHER:Think()

	-- SW.MeteorThink( SpecialEntity )

-- end
