
WEATHER = WEATHER or {}
WEATHER.ID = "rain"
WEATHER.ConVar = { "sw_rain", "Rain" }
WEATHER.Sound = "rain"
WEATHER.WindScale = 1
WEATHER.ParticleSystem = "v92_weather_rain"

WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.1
WEATHER.RaindropMaxDelay = 0.4

WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

WEATHER.Icon = Material( "icon16/weather_rain.png" )
WEATHER.Announcement = "A Rain Shower is approaching the area."
