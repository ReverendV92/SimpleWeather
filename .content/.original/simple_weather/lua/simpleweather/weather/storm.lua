WEATHER.ID = "storm";
WEATHER.Sound = "rain";
WEATHER.Raindrops = true;
WEATHER.RaindropMinDelay = 0.05;
WEATHER.RaindropMaxDelay = 0.2;
WEATHER.Lightning = true;
WEATHER.FogStart = 0;
WEATHER.FogEnd = 1024;
WEATHER.FogMaxDensity = 0.8;
WEATHER.FogColor = Color( 100, 100, 100, 255 );
WEATHER.ConVar = { "sw_storm", "Storm" };

function WEATHER:Think()
	
	if( CLIENT ) then
		
		if( GetConVar( "sw_storm" ):GetBool() ) then
			
			local drop = EffectData();
				drop:SetOrigin( SW.ViewPos + Vector( -70, -70, 0 ) );
				drop:SetScale( 1 );
			util.Effect( "sw_rain", drop );
			
		end
		
	end
	
end
