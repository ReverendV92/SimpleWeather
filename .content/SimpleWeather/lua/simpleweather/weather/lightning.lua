
WEATHER = WEATHER or {}
WEATHER.ID = "lightning"
WEATHER.ConVar = { "sw_lightning", "Lightning" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false

WEATHER.Lightning = true

WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

WEATHER.Announcement = "A Lightning Storm is approaching the area.\nLightning strikes are expected.\nShelter and reduction of non-essential travel are encouraged.\nAdvisory Level: 2"
WEATHER.Icon = Material( "icon16/lightning.png" )
WEATHER.Advisory = 2

function WEATHER:Think()
	
	SW.LightningThink()
	
end
