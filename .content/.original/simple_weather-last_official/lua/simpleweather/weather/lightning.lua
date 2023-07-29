WEATHER.ID = "lightning"
WEATHER.Sound = ""

SW.LightningMinDelay 		= 1	-- Minimum delay in seconds between lightning strikes
SW.LightningMaxDelay		= 10	-- Maximum delay in seconds between lightning strikes

SW.LightningPropDamage		= true	-- Should lightning damage props?
SW.LightningPlayerDamage 	= true	-- Should lightning strike/damage players?
SW.LightningForce			= true	-- Should lightning propel props?
SW.LightningForceAmount		= 40	-- How much force to apply to props (default 40)
SW.LightningIgnite			= true	-- Should lightning ignite props?
SW.LightningIgniteTime		= 10	-- Amount of time in seconds to ignite props
SW.LightningDamage			= 50	-- Lightning damage to props/players

SW.LightningHitGround		= true	-- Should lightning hit random spots on the ground?
SW.LightningGroundChance	= 2/3	-- This is the chance lightning hits the ground vs. hitting a player/prop

function WEATHER:Think()
	
	if( SERVER ) then
		
		if( !SW.NextLightning ) then
			
			SW.NextLightning = CurTime()
			
		end
		
		if( CurTime() >= SW.NextLightning ) then
			
			SW.NextLightning = CurTime() + math.random( SW.LightningMinDelay, SW.LightningMaxDelay )
			
			if( math.Rand( 0, 1 ) <= 1 - SW.LightningGroundChance or !SW.LightningHitGround ) then
				
				local tab = ents.FindByClass( "prop_physics" )
				table.Merge( tab, ents.FindByClass( "prop_physics_multiplayer" ) )
				if( SW.LightningPlayerDamage ) then
					table.Merge( tab, player.GetAll() )
				end
				
				local otab = { }
				
				for k, v in pairs( tab ) do
					
					if( v:IsOutside() ) then
						
						table.insert( otab, v )
						
					end
					
				end
				
				if( #otab == 0 ) then return end
				
				local targ = table.Random( otab )
				local pos = targ:GetPos()
				
				net.Start( "SW.LightningBolt" )
					net.WriteVector( pos )
					net.WriteEntity( targ )
				net.SendPVS( pos )
				
				if( targ:GetClass() == "prop_physics" or targ:GetClass() == "prop_physics_multiplayer" ) then
					
					local a = math.Rand( -math.pi, math.pi )
					local v = Vector( math.cos( a ), math.sin( a ), 0 )
					
					local dmg = DamageInfo()
					dmg:SetAttacker( game.GetWorld() )
					dmg:SetDamage( SW.LightningDamage )
					dmg:SetDamageForce( v * math.random( SW.LightningForceAmount, SW.LightningForceAmount * 3 ) + Vector( 0, 0, math.random( 0, SW.LightningForceAmount ) ) )
					dmg:SetDamagePosition( pos + Vector( 0, 0, 2048 ) )
					dmg:SetDamageType( DMG_SHOCK )
					dmg:SetInflictor( game.GetWorld() )
					
					if( SW.LightningPropDamage ) then
						targ:TakeDamageInfo( dmg )
					end
					if( SW.LightningForce ) then
						targ:TakePhysicsDamage( dmg )
					end
					if( SW.LightningIgnite and SW.LightningIgniteTime > 0 ) then
						targ:Ignite( SW.LightningIgniteTime, 16 )
					end
					
				elseif( SW.LightningPlayerDamage ) then
					
					targ:TakeDamage( SW.LightningDamage, game.GetWorld(), game.GetWorld() )
					
				end
				
			else
				
				if( #SW.SkyPositions == 0 ) then return end
				
				local hp = table.Random( SW.SkyPositions )
				
				local trace = { }
				trace.start = hp
				trace.endpos = trace.start + Vector( 0, 0, -32768 )
				trace.filter = { }
				local tr = util.TraceLine( trace )
				
				if( tr.Hit ) then
					
					net.Start( "SW.LightningBolt" )
						net.WriteVector( tr.HitPos )
						net.WriteEntity( game.GetWorld() )
					net.SendPVS( tr.HitPos )
					
				end
				
			end
			
		end
		
	end
	
end

if( CLIENT ) then

	SW.LightningMat = Material( "effects/blueblacklargebeam" )

	function SW.LightningChildren( spos, alpha, level )
		
		if( math.random( 1, 3 ) != 1 or level == 0 ) then return end
		
		local mainbeama = math.Rand( -math.pi, math.pi )
		local mainbeamt = math.Rand( 0, math.pi )
		local r = math.random( 0, 100 )
		
		local mainvec = r * Vector( 0.5 * math.sin( mainbeama ) * math.cos( mainbeamt ), 0.5 * math.sin( mainbeama ) * math.sin( mainbeamt ), 0 )
		
		local ss = spos
		
		for i = 1, math.random( 2, 4 ) * level do
			
			local newh = math.Rand( 15, 40 ) * level
			local a = math.Rand( -math.pi, math.pi )
			local c = math.cos( a )
			local s = math.sin( a )
			
			local r = math.random( -15, 15 )
			local addvec = Vector( c * r * level, s * r * level, -newh )
			
			local trace = { }
			trace.start = ss
			trace.endpos = ss + addvec + mainvec
			trace.filter = { }
			local tr = util.TraceLine( trace )
			
			if( tr.Hit ) then
				break
			end
			
			render.SetMaterial( SW.LightningMat )
			render.DrawBeam( ss, tr.HitPos, 3 * level, 0, 1, Color( 255, 255, 255, 255 * alpha ) )
			
			SW.LightningChildren( ss, alpha, level - 1 )
			
			ss = tr.HitPos
			
		end
		
	end

	function SW.LightningBolt( seed, filter, pos, alpha )
		
		math.randomseed( seed )
		
		local hittop = false
		local whilecatch = 0
		
		local start = pos
		local cstart = start
		
		local mainbeama = math.Rand( -math.pi, math.pi )
		local mainbeamt = math.Rand( -math.pi, math.pi )
		local r = math.random( 50, 100 )
		
		local mainvec = r * Vector( 0.5 * math.sin( mainbeama ) * math.cos( mainbeamt ), 0.5 * math.sin( mainbeama ) * math.sin( mainbeamt ), math.cos( mainbeama ) )
		
		local whilecatch = 0
		while( !hittop and whilecatch < 50 ) do
			
			whilecatch = whilecatch + 1 -- just in case..
			
			local newh = math.random( 50, 150 )
			local a = math.Rand( -math.pi, math.pi )
			local c = math.cos( a )
			local s = math.sin( a )
			
			local addvec = Vector( c * math.random( -30, 30 ), s * math.random( -30, 30 ), newh )
			
			local trace = { }
			trace.start = cstart
			trace.endpos = cstart + addvec + mainvec
			trace.filter = filter
			local tr = util.TraceLine( trace )
			
			render.SetMaterial( SW.LightningMat )
			render.DrawBeam( cstart, tr.HitPos, 30, 0, 1, Color( 255, 255, 255, 255 * alpha ) )
			
			if( tr.HitWorld or tr.HitSky ) then
				
				hittop = true
				
			elseif( cstart.z - start.z > 100 ) then
				
				SW.LightningChildren( tr.HitPos, alpha, 2 )
				
			end
			
			cstart = tr.HitPos
			
		end
		
		math.randomseed( os.time() )
		
	end

	function SW.LightningBoltDraw( depth, sky )
		
		if( SW.LightningStart and CurTime() - SW.LightningStart < 1 ) then
			
			SW.LightningBolt( SW.LightningSeed, SW.LightningFilter, SW.LightningPos, 1 - ( CurTime() - SW.LightningStart ) )
			
		end
		
	end
	hook.Add( "PostDrawOpaqueRenderables", "SW.LightningBoltDraw", SW.LightningBoltDraw )
	
	local function LightningBolt( len )
		
		local vec = net.ReadVector()
		local ent = net.ReadEntity()
		
		SW.LightningStart = CurTime()
		SW.LightningSeed = math.random( 1, 1000 )
		if( ent == game.GetWorld() ) then
			SW.LightningFilter = { }
		else
			SW.LightningFilter = { ent }
		end
		SW.LightningPos = vec
		
		sound.Play( "simpleweather/thunder" .. math.random( 1, 3 ) .. ".mp3", SW.ViewPos, 160, 100, SW.VolumeMultiplier )
		sound.Play( "simpleweather/lightning" .. math.random( 1, 4 ) .. ".mp3", SW.ViewPos, 160, 100, SW.VolumeMultiplier )
		
	end
	net.Receive( "SW.LightningBolt", LightningBolt )
	
else
	
	util.AddNetworkString( "SW.LightningBolt" )
	
end