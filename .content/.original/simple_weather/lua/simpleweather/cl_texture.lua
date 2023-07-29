SW.GroundTextures = {
	"gm_construct/grass_13",
	"gm_construct/grass-sand_13",
	"gm_construct/flatgrass",
	"gm_construct/flatgrass_2",
	"cs_assault/pavement001a",
	"nature/dirtfloor006a",
	"nature/grassfloor001a",
	"nature/grassfloor002a",
	"nature/grassfloor003a",
	"de_chateau/bush01a",
	"nature/blendmilground004_2",
	"theprotextures/blendgrassgravel002a_gmfix",
	"nature/blend_milltowngrass01wet",
	"ajacks/ajacks_grass01",
	"nature/blendgrassdirt001a",
	"nature/blendgrassdirt01",
	"nature/blendgrassgrass001a",
	"sgtsicktextures/blend_chipsgrass_001",
	"nature/blend_alleydirt_leaves",
	"nature/blendgrassgravel01",
	"nature/blendgrassdirt01_noprop",
	"nature/blendpavedirt01",
	"nature/blendgrassdirt02_noprop",
	"maps/terrain/grass_01_day",
	"nature/blendsandsand008a",
	"gpoint/fixedgrass/dirtfloor006a",
};

SW.CliffTextures = {
	"nature/cliffface001a",
	"nature/cliffface002a",
};

SW.TextureResets = { };

function SW.ResetGroundTextures()
	
	for k, v in pairs( SW.TextureResets ) do
		
		local m = Material( k );
		if( v[1] ) then
			m:SetTexture( "$basetexture", v[1] );
		end
		if( v[2] ) then
			m:SetTexture( "$basetexture2", v[2] );
		end
		
	end
	
end

function SW.SetGroundTextures()

	if( true ) then return end -- not working too well

	for k, v in pairs( SW.GroundTextures ) do

		v = string.lower( v );

		local m = Material( v );

		if( !SW.TextureResets[v] ) then
			local t1 = m:GetTexture( "$basetexture" );
			local t2 = m:GetTexture( "$basetexture2" );

			local m1, m2;
			if( t1 and t1 != "" ) then
				m1 = string.lower( t1:GetName() );
			end

			if( t2 and t2 != "" ) then
				m2 = string.lower( t2:GetName() );
			end

			SW.TextureResets[v] = { m1, m2 };
		end
		
		m:SetTexture( "$basetexture", "nature/snowfloor001a" );
		m:SetTexture( "$basetexture2", "nature/snowfloor001a" );

	end

	for k, v in pairs( SW.CliffTextures ) do

		v = string.lower( v );

		local m = Material( v );

		if( !SW.TextureResets[v] ) then
			local t1 = m:GetTexture( "$basetexture" );
			local t2 = m:GetTexture( "$basetexture2" );

			local m1, m2;
			if( t1 and t1 != "" ) then
				m1 = string.lower( t1:GetName() );
			end

			if( t2 and t2 != "" ) then
				m2 = string.lower( t2:GetName() );
			end

			SW.TextureResets[v] = { m1, m2 };
		end
		
		m:SetTexture( "$basetexture", "nature/snowwall002a" );
		--m:SetTexture( "$basetexture2", "nature/snowwall002a" );

	end

end

function SW.PlayerFootstep( ply, pos, foot, sound, vol, filt )

	local w = SW:GetCurrentWeather();

	if( w and w.SnowFootsteps and false ) then
		
		local trace = { };
		trace.start = ply:GetPos() + Vector( 0, 0, 32 );
		trace.endpos = trace.start + Vector( 0, 0, -64 );
		trace.filter = ply;
		local tr = util.TraceLine( trace );

		if( tr.Hit and tr.HitWorld ) then

			if( tr.HitTexture == "**displacement**" or table.HasValue( SW.GroundTextures, string.lower( tr.HitTexture ) ) ) then

				ply:EmitSound( Sound( "player/footsteps/snow" .. math.random( 1, 6 ) .. ".wav" ) );
				return true;

			end

		end

	end

end
hook.Add( "PlayerFootstep", "SW.PlayerFootstep", SW.PlayerFootstep );
