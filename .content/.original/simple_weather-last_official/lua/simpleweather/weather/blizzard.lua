WEATHER.ID = "blizzard";
WEATHER.Sound = "wind";
WEATHER.FogStart = -256;
WEATHER.FogEnd = 512;
WEATHER.FogMaxDensity = 0.7;
WEATHER.FogColor = Color( 255, 255, 255, 255 );
WEATHER.ConVar = { "sw_blizzard", "Blizzard" };
WEATHER.SnowFootsteps = true;

function WEATHER:Think()
	
	if( CLIENT ) then
		
		if( GetConVar( "sw_showweather" ):GetBool() ) then
			
			if( GetConVar( "sw_blizzard" ):GetBool() ) then
				
				local drop = EffectData();
					drop:SetOrigin( SW.ViewPos );
				util.Effect( "sw_blizzard", drop );
				
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