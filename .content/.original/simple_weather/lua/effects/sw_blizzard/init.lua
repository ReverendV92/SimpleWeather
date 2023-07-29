function EFFECT:Init( data )
	
	if( SW.Emitter2D ) then
		
		if( SW.Emitter2D:GetNumActiveParticles() + SW.Emitter3D:GetNumActiveParticles() > SW.MaxParticles ) then return end
		
		for i = 1, SW.BlizzardCount do
			
			local r = math.random( 0, SW.BlizzardRadius );
			local t = math.Rand( -math.pi, math.pi );
			local pos = data:GetOrigin() + Vector( math.cos( t ) * r, math.sin( t ) * r, math.Rand( -72, math.min( SW.BlizzardHeightMax, SW.HeightMin ) ) );
			
			if( SW.IsOutside( pos ) ) then
				
				local p = SW.Emitter2D:Add( "simpleweather/snow", pos );
				
				p:SetVelocity( Vector( 400 + math.random( -5, 5 ), 400 + math.random( -5, 5 ), -40 ) );
				p:SetRoll( math.random( -360, 360 ) );
				p:SetDieTime( SW.BlizzardDieTime );
				p:SetStartAlpha( 200 );
				p:SetStartSize( 1 );
				p:SetEndSize( 1 );
				p:SetColor( 255, 255, 255 );
				
				p:SetCollide( true );
				p:SetCollideCallback( function( p, pos, norm )
					
					p:SetDieTime( 0 );
					
				end );
				
			end
			
		end
		
	end
	
	if( SW.Emitter2D ) then
		
		local r = math.random( 0, SW.BlizzardRadius );
		local t = math.Rand( -math.pi, math.pi );
		local pos = data:GetOrigin() + Vector( math.cos( t ) * r, math.sin( t ) * r, math.Rand( -72, math.min( SW.BlizzardHeightMax, SW.HeightMin ) ) );
		
		if( SW.IsOutside( pos ) and bit.band( util.PointContents( pos ), CONTENTS_WATER ) != CONTENTS_WATER ) then
			
			local p = SW.Emitter2D:Add( "simpleweather/rainsmoke", pos );
			
			p:SetVelocity( Vector( 400 + math.random( -50, 50 ), 400 + math.random( -50, 50 ), -40 ) );
			p:SetDieTime( SW.BlizzardDieTime );
			p:SetStartAlpha( 100 );
			p:SetEndAlpha( 0 );
			p:SetStartSize( 200 );
			p:SetEndSize( 200 );
			p:SetColor( 200, 200, 200 );
			
			p:SetCollide( true );
			p:SetCollideCallback( function( p, pos, norm )
				
				p:SetDieTime( 0 );
				
			end );
			
		end
		
	end
	
end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end
