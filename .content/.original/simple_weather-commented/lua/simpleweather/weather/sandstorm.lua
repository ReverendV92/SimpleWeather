WEATHER.ID = "sandstorm";
WEATHER.Sound = "wind";
WEATHER.FogStart = 0
WEATHER.FogEnd = 768
WEATHER.FogMaxDensity = 0.7
WEATHER.FogColor = Color( 230, 200, 120, 255 );
WEATHER.ConVar = { "sw_sandstorm", "Sandstorm" };

function WEATHER:Think()
	
	if( CLIENT ) then

		-- if( SW.ShowWeather ) then
		if( GetConVarNumber("sw_cl_showweather") ) then

			if( GetConVarNumber( "sw_sandstorm" ) == 1 ) then
				
				local drop = EffectData();
					drop:SetOrigin( SW.ViewPos );
				util.Effect( "sw_sandstorm", drop );
				
			end
			
		end
		
	end

end
