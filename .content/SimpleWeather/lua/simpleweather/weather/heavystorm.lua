
WEATHER = WEATHER or {}
WEATHER.ID = "heavystorm"
WEATHER.ConVar = { "sw_heavystorm", "Heavy Storm" }
WEATHER.Sound = "rain"
WEATHER.WindScale = 3
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = false
WEATHER.ParticleSystem = "v92_weather_storm"

WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.05
WEATHER.RaindropMaxDelay = 0.2

WEATHER.FogStart = 0
WEATHER.FogEnd = 1024
WEATHER.FogMaxDensity = 0.8
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

-- WEATHER.SkyColorTop = Color( 25 , 25 , 25 )
-- WEATHER.SkyColorBottom = Color( 25 , 50 , 75 )
-- WEATHER.SkyFadeBias = 0.3
-- WEATHER.SkyHDRScale = 0.66

-- WEATHER.SkyOverlayTexture = "skybox/clouds"
-- WEATHER.SkyOverlayLayers = 3
-- WEATHER.SkyOverlayScale = 3
-- WEATHER.SkyOverlayFade = 5
-- WEATHER.SkyOverlaySpeed = 0.05

WEATHER.Announcement = "A Severe Storm is approaching the area.\nLightning storms, hail damage, torrential rain, and extreme winds are predicted.\nShelter and restriction of non-essential travel are strongly encouraged.\nAdvisory Level: 3"
WEATHER.Icon = Material( "icon16/weather_lightning.png" )
WEATHER.Advisory = 3
WEATHER.Broadcast = Sound("SW.EAS.Alert")

local SpecialEntity = "sw_hail"

function WEATHER:Think()

	SW.RainThink()
	SW.LightningThink()
	SW.HailThink( SpecialEntity )

end

function WEATHER:OnStart()

	if SERVER then

		return false

	end

end
