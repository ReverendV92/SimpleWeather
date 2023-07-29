WEATHER.ID = "rain";
WEATHER.Sound = "rain";
WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.1
WEATHER.RaindropMaxDelay = 0.4
WEATHER.FogStart = 0
WEATHER.FogEnd = 2048
WEATHER.FogMaxDensity = 0.6
WEATHER.FogColor = Color( 100, 100, 100, 255 );
WEATHER.ConVar = { "sw_rain", "Rain" };

function WEATHER:Think()
	
	if( CLIENT ) then

		-- if( SW.ShowWeather ) then
		if( GetConVarNumber("sw_cl_showweather") ) then

			if( GetConVarNumber( "sw_rain" ) == 1 ) then
				
				local drop = EffectData();
					drop:SetOrigin( SW.ViewPos );
					drop:SetScale( 0 );
				util.Effect( "sw_rain", drop );
				
			end
			
		end
		
	end
	
end