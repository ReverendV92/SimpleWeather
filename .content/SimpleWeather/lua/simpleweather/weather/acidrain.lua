
WEATHER = WEATHER or {}
WEATHER.ID = "acidrain"
WEATHER.ConVar = { "sw_acidrain" , "Acid Rain" }
WEATHER.Sound = "rain"
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false
WEATHER.ParticleSystem = "v92_weather_rain"

WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.1
WEATHER.RaindropMaxDelay = 0.4

WEATHER.FogStart = 0
WEATHER.FogEnd = 4096
WEATHER.FogMaxDensity = 0.5
WEATHER.FogColor = Color( 255 , 255 , 100 , 255 )

WEATHER.Announcement = "An Acid Rain front is approaching the area.\nBurning rain and slightly elevated winds are expected.\nShelter and restriction of non-essential travel are strongly encouraged.\nAdvisory Level: 3"
WEATHER.Icon = Material( "icon16/weather_rain.png" )
WEATHER.IconColor = Color( 190 , 255 , 120 , 255 )
WEATHER.Advisory = 3
WEATHER.Broadcast = Sound("SW.EAS.Alert")

function WEATHER:Think()

	SW.AcidRainThink()

end
