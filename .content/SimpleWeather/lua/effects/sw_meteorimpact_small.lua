function EFFECT:Init( data )
	
	local start = data:GetStart()
	local a, s, c, avec, pos, p
	
	self.Emitter = ParticleEmitter( start, false )
	
	-- for i = 0, 30 do
		
		-- a = ( i / 50 ) * math.pi * 2
		-- s = math.sin( a )
		-- c = math.cos( a )
		
		-- avec = Vector( c, s, 0 )
		
		-- pos = start + avec * math.random( 2, 8 )
		
		-- p = self.Emitter:Add( "simpleweather/rainsmoke", pos )

		-- if( p ) then

			-- p:SetAngles( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) )
			-- p:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) ) )
			-- p:SetCollide( false )
			-- p:SetColor( 160, 160, 160 )
			-- p:SetDieTime( math.Rand( 1.5, 3 ) )
			-- p:SetEndAlpha( 0 )
			-- p:SetEndSize( math.random( 24, 32 ) )
			-- p:SetLifeTime( 0 )
			-- p:SetRoll( math.Rand( -math.pi, math.pi ) )
			-- p:SetRollDelta( math.Rand( -math.pi, math.pi ) )
			-- p:SetStartAlpha( 255 )
			-- p:SetStartSize( math.random( 64, 96 ) )
			-- p:SetAirResistance( 200 )
			-- p:SetVelocity( avec * 200 + Vector( 0, 0, 1000 ) )
			-- p:SetGravity( Vector( 0, 0, -300 ) )

		-- end

	-- end
	
	for i = 0, 10 do
		
		a = math.Rand( -math.pi, math.pi )
		s = math.sin( a )
		c = math.cos( a )
		
		avec = Vector( c, s, math.Rand( 0.1, 1 ) )
		
		pos = start + avec * math.random( 2, 8 )
		
		p = self.Emitter:Add( "simpleweather/rainsmoke", pos )
		
		if( p ) then
			
			p:SetAngles( Angle( math.random( -180 , 180 ), math.random( -180 , 180 ), math.random( -180 , 180 ) ) )
			p:SetAngleVelocity( Angle( math.Rand( -2 , 2 ), math.Rand( -2 , 2 ), math.Rand( -2 , 2 ) ) )
			p:SetCollide( false )
			p:SetColor( 160 , 160 , 160 )
			p:SetDieTime( 5 )
			p:SetEndAlpha( 0 )
			p:SetEndSize( math.random( 24, 32 ) )
			p:SetLifeTime( 0 )
			p:SetRoll( math.Rand( -math.pi, math.pi ) )
			p:SetRollDelta( math.Rand( -math.pi, math.pi ) )
			p:SetStartAlpha( 255 )
			p:SetStartSize( math.random( 64, 96 ) )
			p:SetVelocity( Vector( 0, 0, 100 ) )
			p:SetGravity( Vector( 0, 0, -200 ) )
			
		end
		
	end
	
	self.Emitter:Finish()
	self.Emitter = nil
	
end

function EFFECT:Think()
	
	return false
	
end

function EFFECT:Render()
	
	
	
end
