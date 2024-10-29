
WEATHER = WEATHER or {}
WEATHER.ID = "smog"
WEATHER.ConVar = { "sw_smog", "Smog" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = true

WEATHER.FogStart = 0
WEATHER.FogEnd = 512
WEATHER.FogMaxDensity = 0.97
WEATHER.FogColor = Color( 100, 100, 75, 255 )

WEATHER.Announcement = "A Smog Cloud is approaching the area.\nToxic air is expected.\nTaking shelter and limiting exposure to outside air is strongly advised.\nAdvisory Level: 2"
WEATHER.Icon = Material( "icon16/weather_clouds.png" )
WEATHER.IconColor = Color( 255 , 255 , 120 , 255 )
WEATHER.Advisory = 2

function WEATHER:Think()

	SW.SmogThink()

end
