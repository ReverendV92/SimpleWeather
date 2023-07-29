WEATHER.ID = "snow";
WEATHER.Sound = "";
WEATHER.FogStart = -512
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 255, 255, 255, 255 );
WEATHER.ConVar = { "sw_snow", "Snow" };

function WEATHER:Think()
	
	if( CLIENT ) then

		-- if( SW.ShowWeather ) then
		if( GetConVarNumber("sw_cl_showweather") ) then

			if( GetConVarNumber( "sw_snow" ) == 1 ) then
				
				local drop = EffectData();
					drop:SetOrigin( SW.ViewPos );
				util.Effect( "sw_snow", drop );
				
			end
			
		end
		
	end
	
end