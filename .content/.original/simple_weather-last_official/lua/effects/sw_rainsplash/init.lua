function EFFECT:Init( data )
	
	if( SW.Emitter2D ) then
		
		local p = SW.Emitter2D:Add( "simpleweather/snow", data:GetOrigin() );
		
		p:SetDieTime( 0.5 );
		p:SetStartAlpha( 15 );
		p:SetEndAlpha( 0 );
		p:SetStartSize( 2 );
		p:SetEndSize( 2 );
		p:SetColor( 255, 255, 255 );
		
	end
	
end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end
