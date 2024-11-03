
WEATHER = WEATHER or {}
WEATHER.ID = "sandstorm"
WEATHER.ConVar = { "sw_sandstorm", "Sandstorm" }
WEATHER.Sound = "wind"
WEATHER.WindScale = 3
WEATHER.ShowEnvSun = true
WEATHER.ShowStars = false

WEATHER.FogStart = 0
WEATHER.FogEnd = 768
WEATHER.FogMaxDensity = 0.7
WEATHER.FogColor = Color( 230, 200, 120, 255 )

WEATHER.Announcement = "A Sandstorm is approaching the area. Extreme visibility reductions are expected.\nReduction of all non-essential travel is advised.\nAdvisory Level: 1"
WEATHER.Icon = Material( "icon16/weather_clouds.png" )
WEATHER.IconColor = Color( 255 , 190 , 0 , 255 )
WEATHER.Advisory = 1

function WEATHER:Think()

	SW.SandstormThink()

end
