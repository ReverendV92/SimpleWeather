
WEATHER = WEATHER or {}
WEATHER.ID = "meteor"
WEATHER.ConVar = { "sw_meteor", "Meteor" }
WEATHER.Sound = "siren"
WEATHER.WindScale = 1

WEATHER.Announcement = "A Meteor Storm is approaching.\nTake shelter underground or in hardened structures until the alarm has passed.\nAdvisory Level: 3"
WEATHER.Icon = Material( "icon16/sport_shuttlecock.png" )
WEATHER.Advisory = 3
WEATHER.Broadcast = Sound("SW.EAS.Alert")

local SpecialEntity = "sw_meteor"

function WEATHER:Think()

	SW.MeteorThink( SpecialEntity )

end
