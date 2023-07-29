WEATHER.ID = "sandstorm";
WEATHER.Sound = "wind";
WEATHER.FogStart = 0;
WEATHER.FogEnd = 768;
WEATHER.FogMaxDensity = 0.7;
WEATHER.FogColor = Color( 230, 200, 120, 255 );
WEATHER.ConVar = { "sw_sandstorm", "Sandstorm" };

function WEATHER:Think()
	
	if( CLIENT ) then
		
		if( GetConVar( "sw_showweather" ):GetBool() ) then
			
			if( GetConVar( "sw_sandstorm" ):GetBool() ) then
				
				local drop = EffectData();
					drop:SetOrigin( SW.ViewPos );
				util.Effect( "sw_sandstorm", drop );
				
			end
			
		end
		
	end
	
end