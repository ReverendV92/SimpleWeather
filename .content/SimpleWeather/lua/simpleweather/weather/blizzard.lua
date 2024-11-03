
WEATHER = WEATHER or {}
WEATHER.ID = "blizzard"
WEATHER.ConVar = { "sw_blizzard", "Blizzard" }
WEATHER.Sound = "wind"
WEATHER.WindScale = 2
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = false
-- WEATHER.ParticleSystem = "v92_weather_blizzard"

WEATHER.FogStart = -256
WEATHER.FogEnd = 512
WEATHER.FogMaxDensity = 0.7
WEATHER.FogColor = Color( 255 , 255 , 255 , 255 )

WEATHER.Announcement = "A blizzard is approaching the area.\nLow visibility due to whiteout and moderately elevated winds are expected. Damage due to cold is expected.\nShelter and reduction of non-essential travel are advised.\nAdvisory Level: 2"
WEATHER.Icon = Material( "icon16/weather_snow.png" )
WEATHER.IconColor = Color( 200 , 200 , 255 , 255 )
WEATHER.Advisory = 2
WEATHER.Broadcast = Sound("SW.EAS.Alert")

function WEATHER:Think()

	SW.SnowThink()
	-- Server-side DOT
	SW.BlizzardThink()

end

function WEATHER:OnStart()

	-- if SERVER then

		-- return false

	-- end

	SW.SetSnowTextureSettings()

end

function WEATHER:OnEnd()

	SW.ResetSnowTextureSettings()

end
