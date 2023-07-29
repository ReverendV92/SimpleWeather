include( "shared.lua" );

language.Add( "sw_meteor", "Meteor" );

function ENT:Draw()
	
	local mul = 1;
	
	if( self:GetDieTime() > 0 ) then
		
		local d = CurTime() - self:GetDieTime();
		
		if( d < 1 ) then
			
			mul = 1 - d;
			
		end
		
	end
	
	render.SetBlend( mul );
		self:DrawModel();
	render.SetBlend( 1 );
	
	if( !self.Emitter and self:GetDieTime() <= 0 ) then
		
		self.Emitter = ParticleEmitter( self:GetPos(), false );
		
	end
	
	if( self.Emitter ) then
		
		if( self:GetDieTime() <= 0 ) then
			
			local v, t, s, cv, p;
			
			for i = 1, 2 do
				
				v = self:GetPos();
				
				t = math.Rand( -math.pi, math.pi );
				s = math.Rand( -math.pi, math.pi );
				cv = Vector( math.sin( t ) * math.cos( s ), math.sin( t ) * math.sin( s ), math.cos( t ) );
				
				v = v + cv * 150;
				
				p = self.Emitter:Add( "simpleweather/flamelet" .. math.random( 1, 5 ), v );
				
				if( p ) then
					
					p:SetAngles( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) );
					p:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) ) );
					p:SetCollide( false );
					p:SetColor( 255, 255, 255 );
					p:SetDieTime( 2 );
					p:SetEndAlpha( 0 );
					p:SetEndSize( 0 );
					p:SetLifeTime( 0 );
					p:SetRoll( math.Rand( -math.pi, math.pi ) );
					p:SetRollDelta( math.Rand( -math.pi, math.pi ) );
					p:SetStartAlpha( 255 );
					p:SetStartSize( 90 );
					
				end
				
			end
			
			v = self:GetPos();
			
			t = math.Rand( -math.pi, math.pi );
			s = math.Rand( -math.pi, math.pi );
			cv = Vector( math.sin( t ) * math.cos( s ), math.sin( t ) * math.sin( s ), math.cos( t ) );
			
			v = v + cv * 150;
			
			local p = self.Emitter:Add( "simpleweather/rainsmoke", v );
			
			if( p ) then
				
				p:SetAngles( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) );
				p:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) ) );
				p:SetCollide( false );
				p:SetColor( 255, 255, 255 );
				p:SetDieTime( 2 );
				p:SetEndAlpha( 0 );
				p:SetEndSize( 0 );
				p:SetLifeTime( 0 );
				p:SetRoll( math.Rand( -math.pi, math.pi ) );
				p:SetRollDelta( math.Rand( -math.pi, math.pi ) );
				p:SetStartAlpha( 255 );
				p:SetStartSize( 100 );
				
			end
			
		else
			
			self.Emitter:Finish();
			self.Emitter = nil;
			
		end
		
	end
	
end

function ENT:OnRemove()
	
	if( self.Emitter ) then
		
		self.Emitter:Finish();
		
	end
	
end
