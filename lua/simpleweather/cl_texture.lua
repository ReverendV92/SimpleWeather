-- WIP! If this appears in a release it's accidental :)

SW.GroundTextures = {
	
}

function SW.CheckSnowTexture( mat, mattype, norm )
	--[[
	if( SW.GroundTextures[mat] ) then return end
	if( norm:Dot( Vector( 0, 0, 1 ) ) < 0.99 ) then return end
	
	if( mat != "**displacement**" ) then
		
		local m = Material( mat )
		
		SW.GroundTextures[mat] = m:GetString( "$basetexture" )
		m:SetTexture( "$basetexture", Material( "nature/snowfloor002a" ):GetTexture( "$basetexture" ) )
		
	end
	--]]
end

function SW.ResetGroundTextures()
	
	for k, v in pairs( SW.GroundTextures ) do
		
		Material( k ):SetTexture( "$basetexture", v )
		
	end
	
	SW.GroundTextures = { }
	
end
