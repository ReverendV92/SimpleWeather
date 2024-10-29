
WEATHER = WEATHER or {}
WEATHER.ID = "meteorshower"
WEATHER.ConVar = { "sw_meteorshower", "Meteor Shower" }
WEATHER.Sound = ""
WEATHER.WindScale = 1
WEATHER.ShowEnvSun = false
WEATHER.DefaultSky = true

WEATHER.Announcement = "A Meteor Shower is approaching.\nOvercast skies, slightly elevated winds, and potential damages are expected.\nShelter and reduction of non-essential travel are encouraged.\nAdvisory Level: 2"
WEATHER.Icon = Material( "icon16/sport_shuttlecock.png" )
WEATHER.Advisory = 2
-- WEATHER.Broadcast = Sound("SW.EAS.Alert")

local SpecialEntity = "sw_meteor_small"

function WEATHER:Think()

	SW.MeteorThink( SpecialEntity )

end
