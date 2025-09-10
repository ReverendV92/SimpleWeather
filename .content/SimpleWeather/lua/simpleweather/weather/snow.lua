
WEATHER = WEATHER or {}
WEATHER.ID = "snow"
WEATHER.ConVar = { "sw_snow" , "Snow" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = false

WEATHER.FogStart = -512
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 255 , 255 , 255 , 255 )

WEATHER.Announcement = "Snowfall is expected in the area.\nAdvisory Level: 1"
WEATHER.Icon = Material( "icon16/weather_snow.png" )
WEATHER.Advisory = 1
WEATHER.Broadcast = Sound("SW.EAS.Alert")

function WEATHER:Think()

	SW.SnowThink()

end

function WEATHER:OnStart()

	SW.SetSnowTextureSettings()

end

function WEATHER:OnEnd()

	SW.ResetWeatherTextureSettings()

end
