WEATHER.ID = "snow";
WEATHER.Sound = "";
WEATHER.FogStart = -512;
WEATHER.FogEnd = 2048;
WEATHER.FogMaxDensity = 0.6;
WEATHER.FogColor = Color( 255, 255, 255, 255 );
WEATHER.ConVar = { "sw_snow", "Snow" };
WEATHER.SnowFootsteps = true;

function WEATHER:Think()
	
	if( CLIENT ) then
		
		if( GetConVar( "sw_showweather" ):GetBool() ) then
			
			if( GetConVar( "sw_snow" ):GetBool() ) then
				
				local drop = EffectData();
					drop:SetOrigin( SW.ViewPos );
				util.Effect( "sw_snow", drop );
				
			end
			
		end
		
	end
	
end

function WEATHER:OnStart()

	if( CLIENT ) then
		
		SW.SetGroundTextures();

	end

end

function WEATHER:OnEnd()

	if( CLIENT ) then
		
		SW.ResetGroundTextures();

	end

end