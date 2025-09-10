
WEATHER = WEATHER or {}
WEATHER.ID = "desert"
WEATHER.ConVar = { "sw_desert" , "Desert" }
WEATHER.Sound = ""
WEATHER.WindScale = 2
WEATHER.ShowEnvSun = true
WEATHER.ShowStars = true

WEATHER.FogStart = -512
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 255 , 255 , 255 , 255 )

WEATHER.Announcement = "The weather has turned the area into a desert."
WEATHER.Icon = Material( "icon16/weather_snow.png" )
WEATHER.Advisory = 0
-- WEATHER.Broadcast = Sound("SW.EAS.Alert")

function WEATHER:Think()

	SW.DesertThink()

end

function WEATHER:OnStart()

	SW.SetDesertTextureSettings()

end

function WEATHER:OnEnd()

	SW.ResetWeatherTextureSettings()

end
