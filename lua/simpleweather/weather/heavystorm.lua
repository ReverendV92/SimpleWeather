
WEATHER = WEATHER or {}
WEATHER.ID = "heavystorm"
WEATHER.ConVar = { "sw_heavystorm", "Heavy Storm" }
WEATHER.Sound = "rain"
WEATHER.WindScale = 3
WEATHER.ParticleSystem = "v92_weather_storm"

WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.05
WEATHER.RaindropMaxDelay = 0.2
WEATHER.Lightning = true

WEATHER.FogStart = 0
WEATHER.FogEnd = 1024
WEATHER.FogMaxDensity = 0.8
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

WEATHER.Announcement = "A Severe Storm is approaching the area.\nLightning storms, hail damage, torrential rain, and extreme winds are predicted.\nShelter and restriction of non-essential travel are strongly encouraged.\nAdvisory Level: 3"
WEATHER.Icon = Material( "icon16/weather_lightning.png" )
WEATHER.Advisory = 3
WEATHER.Broadcast = Sound("SW.EAS.Alert")

function WEATHER:Think()

	SW.RainThink()
	SW.LightningThink()
	SW.HailThink()

end

function WEATHER:OnStart()

	if SERVER then

		return false

	end

end
