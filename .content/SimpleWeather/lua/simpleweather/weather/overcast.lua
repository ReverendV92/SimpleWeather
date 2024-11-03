
WEATHER = WEATHER or {}
WEATHER.ID = "overcast"
WEATHER.ConVar = { "sw_overcast", "Overcast" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = false
WEATHER.ParticleSystem = ""

WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

-- WEATHER.SkyOverlayTexture = "skybox/clouds"
-- WEATHER.SkyOverlayLayers = 2
-- WEATHER.SkyOverlayScale = 3
-- WEATHER.SkyOverlayFade = 5
-- WEATHER.SkyOverlaySpeed = 0.03

WEATHER.Announcement = "An overcast cloud front is approaching the area."
WEATHER.Icon = Material( "icon16/weather_cloudy.png" )
