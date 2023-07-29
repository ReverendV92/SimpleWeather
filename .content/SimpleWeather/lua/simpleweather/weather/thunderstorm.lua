
WEATHER = WEATHER or {}
WEATHER.ID = "thunderstorm"
WEATHER.ConVar = { "sw_thunderstorm", "Thunderstorm" }
WEATHER.Sound = "rain"
WEATHER.WindScale = 3
WEATHER.ParticleSystem = "v92_weather_storm"

WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.1
WEATHER.RaindropMaxDelay = 0.4
WEATHER.Lightning = true

WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

WEATHER.Announcement = "A Thunderstorm is approaching the area.\nStrong showers and lightning are anticipated.\nShelter and reduction of non-essential travel are advised.\nAdvisory Level: 2"
WEATHER.Icon = Material( "icon16/weather_lightning.png" )
WEATHER.Advisory = 2
WEATHER.Broadcast = Sound("SW.EAS.Alert")

function WEATHER:Think()

	SW.RainThink()
	SW.LightningThink()

end
