function EFFECT:Init( data )
	
	if( SW.Emitter2D ) then
		
		if( SW.Emitter2D:GetNumActiveParticles() + SW.Emitter3D:GetNumActiveParticles() > SW.MaxParticles ) then return end
		
		for i = 1, SW.SnowCount do
			
			local r = math.random( 0, SW.SnowRadius );
			local t = math.Rand( -math.pi, math.pi );
			local pos = data:GetOrigin() + Vector( math.cos( t ) * r, math.sin( t ) * r, math.min( SW.SnowHeightMax, SW.HeightMin ) );
			
			if( SW.IsOutside( pos ) ) then
				
				local p = SW.Emitter2D:Add( "simpleweather/snow", pos );
				
				p:SetVelocity( Vector( 20 + math.random( -5, 5 ), 20 + math.random( -5, 5 ), -80 ) );
				p:SetRoll( math.random( -360, 360 ) );
				p:SetDieTime( SW.SnowDieTime );
				p:SetStartAlpha( 200 );
				p:SetStartSize( 1 );
				p:SetEndSize( 1 );
				p:SetColor( 255, 255, 255 );
				
				p:SetCollide( true );
				p:SetCollideCallback( function( p, pos, norm )
					
					local trace = { };
					trace.start = pos;
					trace.endpos = trace.start - norm;
					trace.filter = { };
					local tr = util.TraceLine( trace );
					
					if( !SW.LeaveSnowOnGround ) then
						
						p:SetDieTime( 0 );
						
					end
					
				end );
				
			end
			
		end
		
	end
	
end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end
