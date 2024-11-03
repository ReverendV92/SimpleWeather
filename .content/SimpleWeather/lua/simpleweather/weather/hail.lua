
WEATHER = WEATHER or {}
WEATHER.ID = "hail"
WEATHER.ConVar = { "sw_hail" , "Hail" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false
WEATHER.ShowStars = false

WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100 , 100 , 100 , 255 )

WEATHER.Announcement = "A Hail Storm is approaching the area.\nOvercast skies, slightly elevated winds, and potential damages are expected.\nShelter and reduction of non-essential travel are encouraged.\nAdvisory Level: 2"
WEATHER.Icon = Material( "icon16/sport_golf.png" )
WEATHER.Advisory = 2
WEATHER.Broadcast = Sound("SW.EAS.Alert")

local SpecialEntity = "sw_hail"

function WEATHER:Think( )

	SW.HailThink( SpecialEntity )

end
