
WEATHER = WEATHER or {}
WEATHER.ID = "fog"
WEATHER.ConVar = { "sw_fog", "Fog" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowStars = true

WEATHER.Announcement = "A fog bank is approaching the area.\nLow visibility is expected.\nReduction of non-essential travel is encouraged.\nAdvisory Level: 1"
WEATHER.Icon = Material( "icon16/weather_clouds.png" )
WEATHER.Advisory = 1

WEATHER.FogStart = 0
WEATHER.FogEnd = 1024
WEATHER.FogMaxDensity = 0.97
WEATHER.FogColor = Color( 255 , 255 , 255 , 255 )
