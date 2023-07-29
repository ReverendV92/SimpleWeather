WEATHER.ID = "acidrain"
WEATHER.Sound = "rain"
WEATHER.FogStart = 0
WEATHER.FogEnd = 4096
WEATHER.FogMaxDensity = 0.5
WEATHER.FogColor = Color( 255, 255, 100, 255 )
WEATHER.Raindrops = true
WEATHER.RaindropMinDelay = 0.1
WEATHER.RaindropMaxDelay = 0.4

SW.AcidDamage	= 5	-- Damage acid rain should do (0 for no damage)
SW.AcidDelay	= 2	-- Delay between damaging players

function WEATHER:Think()
	
	if( CLIENT ) then
		
		if( GetConVar( "sw_showweather" ):GetBool() ) then
			
			if( GetConVar( "sw_rain" ):GetBool() ) then
				
				local drop = EffectData()
					drop:SetOrigin( SW.ViewPos )
					drop:SetScale( 0 )
				util.Effect( "sw_acidrain", drop )
				
			end
			
		end
		
	else
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:Alive() and v:IsOutside() ) then
				
				if( !v.NextAcidRain ) then
					v.NextAcidRain = 0
				end
				
				if( CurTime() >= v.NextAcidRain ) then
					
					v.NextAcidRain = CurTime() + SW.AcidDelay
					
					local dmg = DamageInfo()
					dmg:SetAttacker( game.GetWorld() )
					dmg:SetInflictor( game.GetWorld() )
					dmg:SetDamage( SW.AcidDamage )
					dmg:SetDamageForce( Vector() )
					dmg:SetDamageType( DMG_ACID )
					
					v:TakeDamageInfo( dmg )
					
					v:EmitSound( "player/pl_burnpain" .. math.random( 1, 3 ) .. ".wav", 75, 100, 0.3 )
					
				end
				
			end
			
		end
		
	end
	
end