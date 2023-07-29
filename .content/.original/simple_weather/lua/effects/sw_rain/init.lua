function EFFECT:Init( data )
	
	local s = data:GetScale();
	
	if( SW.Emitter3D ) then
		
		if( SW.Emitter2D:GetNumActiveParticles() + SW.Emitter3D:GetNumActiveParticles() > SW.MaxParticles ) then return end
		
		local n = SW.RainCount;
		
		if( s == 1 ) then
			n = SW.StormCount;
		end
		
		for i = 1, n do
			
			local r = math.random( 0, SW.RainRadius );
			if( s == 1 ) then
				r = math.random( 0, SW.StormRadius );
			end
			local t = math.Rand( -math.pi, math.pi );
			local pos = data:GetOrigin() + Vector( math.cos( t ) * r, math.sin( t ) * r, math.min( SW.RainHeightMax, SW.HeightMin ) );
			
			if( SW.IsOutside( pos ) ) then
				
				local p = SW.Emitter3D:Add( "simpleweather/water_drop", pos );
				
				if( s == 1 ) then
					p:SetVelocity( Vector( 200 + math.random( -50, 50 ), 200 + math.random( -50, 50 ), -1000 ) );
				else
					p:SetVelocity( Vector( 0, 0, -700 ) );
				end
				p:SetAngles( p:GetVelocity():Angle() + Angle( 90, 0, 90 ) );
				if( s == 1 ) then
					p:SetDieTime( SW.StormDieTime );
				else
					p:SetDieTime( SW.RainDieTime );
				end
				p:SetStartAlpha( 255 );
				p:SetStartSize( 4 );
				p:SetEndSize( 4 );
				p:SetColor( 255, 255, 255 );
				
				p:SetCollide( true );
				p:SetCollideCallback( function( p, pos, norm )
					
					local n;
					local cvar = GetConVar( "sw_rainimpactquality" ):GetInt();
					
					if( cvar == 1 ) then
						n = 60;
					elseif( cvar == 2 ) then
						n = 30;
					elseif( cvar == 3 ) then
						n = 10;
					elseif( cvar == 4 ) then
						n = 1;
					end
					
					if( SW.RainSplashes and GetConVar( "sw_showrainimpact" ):GetBool() and render.GetDXLevel() > 90 and math.random( 1, n ) == 1 ) then
						
						local ed = EffectData();
							ed:SetOrigin( pos );
						util.Effect( "sw_rainsplash", ed );
						
					end
					
					p:SetDieTime( 0 );
					
				end );
				
				p:SetThinkFunction( function( p, pos )
					
					if( bit.band( util.PointContents( p:GetPos() ), CONTENTS_WATER ) == CONTENTS_WATER ) then
						
						p:SetDieTime( 0 );
						
					end
					
					p:SetNextThink( CurTime() + 0.05 );
					
				end );
				p:SetNextThink( CurTime() + 0.05 );
				
			end
			
		end
		
	end
	
	if( !SW.RainSmoke ) then return end
	
	if( SW.Emitter2D ) then
		
		local n = 6;
		
		if( s == 1 ) then
			n = 2;
		end
		
		if( math.random( 1, n ) == 1 ) then
			
			local r = math.random( 0, SW.RainRadius );
			if( s == 1 ) then
				r = math.random( 0, SW.StormRadius );
			end
			local t = math.Rand( -math.pi, math.pi );
			local pos = data:GetOrigin() + Vector( math.cos( t ) * r, math.sin( t ) * r, math.min( SW.RainHeightMax, SW.HeightMin ) );
			
			if( SW.IsOutside( pos ) and bit.band( util.PointContents( pos ), CONTENTS_WATER ) != CONTENTS_WATER ) then
				
				local p = SW.Emitter2D:Add( "simpleweather/rainsmoke", pos );
				
				if( s == 1 ) then
					p:SetVelocity( Vector( 200 + math.random( -50, 50 ), 200 + math.random( -50, 50 ), -1500 ) );
				else
					p:SetVelocity( Vector( 0, 0, -700 ) );
				end
				if( s == 1 ) then
					p:SetDieTime( SW.StormDieTime );
				else
					p:SetDieTime( SW.RainDieTime );
				end
				p:SetStartAlpha( 6 );
				p:SetEndAlpha( 0 );
				p:SetStartSize( 166 );
				p:SetEndSize( 166 );
				p:SetColor( 150, 150, 200 );
				
				p:SetCollide( true );
				p:SetCollideCallback( function( p, pos, norm )
					
					p:SetDieTime( 0 );
					
				end );
				
				p:SetThinkFunction( function( p, pos )
					
					if( bit.band( util.PointContents( p:GetPos() ), CONTENTS_WATER ) == CONTENTS_WATER ) then
						
						p:SetDieTime( 0 );
						
					end
					
					p:SetNextThink( CurTime() + 0.05 );
					
				end );
				p:SetNextThink( CurTime() + 0.05 );
				
			end
			
		end
		
	end
	
end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end
