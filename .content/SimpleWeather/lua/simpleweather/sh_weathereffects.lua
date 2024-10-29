
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
-- SIMPLE WEATHER
-- WEATHER EFFECT LIBRARY
----------------------------------------
----------------------------------------
-- This file controls all the weather effects 
-- for Simple Weather so that they can be 
-- called upon as needed in multiple weather 
-- classes with minimal duplicate code.
----------------------------------------
----------------------------------------
-- Weathers are sorted alphabetically.
----------------------------------------
----------------------------------------

----------------------------------------
----------------------------------------
-- COMMON
----------------------------------------
----------------------------------------

local function SWPhysgunPickup( ply , weatherENT )

	if weatherENT and weatherENT:IsValid( ) and weatherENT:GetClass( ) == ( SW.MeteorClassName or SW.HailClassName ) then 

		return false 

	end
	
end
hook.Add( "PhysgunPickup", "SW.PhysgunPickup", SWPhysgunPickup )

----------------------------------------
----------------------------------------
-- ACID RAIN
----------------------------------------
-- Shared. AVFX.
-- Acid DOT.
----------------------------------------
----------------------------------------

CreateConVar( "sw_acidrain_dmg_toggle" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should acid rain cause damage?" , 0 , 1 )
CreateConVar( "sw_acidrain_dmg_prop_toggle" , 0 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should acid rain cause damage to props?" , 0 , 1 )
CreateConVar( "sw_acidrain_dmg_npc_toggle" , 0 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should acid rain cause damage to NPCs?" , 0 , 1 )
CreateConVar( "sw_acidrain_dmg_amount" , 5 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of damage acid rain does." , 1 , 100 )
CreateConVar( "sw_acidrain_dmg_delay" , 5 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between acid rain damage." , 1 , 30 )

function SW.AcidRainThink()

	if CLIENT and GetConVarNumber("sw_cl_weather_toggle") == 1 and GetConVarNumber("sw_func_particle_type") == 0 then

		local drop = EffectData()
		drop:SetOrigin( SW.ViewPos )
		drop:SetScale( 0 )
		util.Effect( "sw_acidrain", drop )

	end
	
	if SERVER and GetConVarNumber("sw_acidrain_dmg_toggle") != 0 then

		local AcidRainTarget = {}

		for k , v in pairs( ents.FindByClass( "prop_*" ) ) do

			table.insert( AcidRainTarget , v )

		end

		for k , v in pairs( ents.FindByClass( "npc_*" ) ) do

			table.insert( AcidRainTarget , v )

		end

		for k , v in pairs( ents.FindByClass( "monster_*" ) ) do

			table.insert( AcidRainTarget , v )

		end

		for k , v in pairs( player.GetAll() ) do

			table.insert( AcidRainTarget , v )

		end

		for _ , DamageTarget in pairs( AcidRainTarget ) do

			if !DamageTarget.NextHit then

				DamageTarget.NextHit = 0

			end

			if CurTime() >= DamageTarget.NextHit then

				DamageTarget.NextHit = CurTime() + GetConVarNumber("sw_acidrain_dmg_delay")

				if ( DamageTarget:IsPlayer() and not ( DamageTarget:Alive() or DamageTarget:InVehicle() ) ) or !DamageTarget:IsOutside() then

					return

				end

				if DamageTarget:IsPlayer() or ( DamageTarget:IsNPC() and GetConVarNumber( "sw_acidrain_dmg_npc_toggle" ) != 0 ) then

					DamageTarget:EmitSound( "player/pl_burnpain" .. math.random( 1 , 3 ) .. ".wav", 75, math.random( 90 , 110 ) , 0.3 )

					local AcidRainDMG = DamageInfo()
					AcidRainDMG:SetAttacker( game.GetWorld() )
					AcidRainDMG:SetInflictor( game.GetWorld() )
					AcidRainDMG:SetDamage( GetConVarNumber("sw_acidrain_dmg_amount") )
					AcidRainDMG:SetDamageForce( Vector() )
					AcidRainDMG:SetDamageType( DMG_ACID )
					DamageTarget:TakeDamageInfo( AcidRainDMG )

				end

				if GetConVarNumber( "sw_acidrain_dmg_prop_toggle" ) != 0 and not ( DamageTarget:IsPlayer() or DamageTarget:IsNPC() ) then

					DamageTarget:EmitSound( "ambient/levels/canals/toxic_slime_sizzle3.wav", 75, math.random( 90 , 110 ) , 0.3 )

					DamageTarget:TakeDamage( GetConVarNumber("sw_acidrain_dmg_amount") , game.GetWorld() , game.GetWorld() )

				end

print("damage target: " .. DamageTarget:GetClass())

			end
			
		end
		
	end

end

----------------------------------------
----------------------------------------
-- BLIZZARD
----------------------------------------
-- Server. AVFX.
-- Cold DOT.
----------------------------------------
----------------------------------------

CreateConVar( "sw_blizzard_height", 100 , { FCVAR_ARCHIVE } , "(INT) Maximum height to make blizzard." , 0 , 2500 )
CreateConVar( "sw_blizzard_radius", 400 , { FCVAR_ARCHIVE } , "(INT) Radius of blizzard effect." , 0 , 2500 )
CreateConVar( "sw_blizzard_count", 10 , { FCVAR_ARCHIVE } , "(INT) Amount of particles in blizzard effect. Make this smaller to increase performance." , 0 , 100 )
CreateConVar( "sw_blizzard_dietime", 5 , { FCVAR_ARCHIVE } , "(INT) Time in seconds until blizzard vanishes." , 0 , 16 )

CreateConVar( "sw_blizzard_dmg_toggle" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should blizzard cause damage?" , 0 , 1 )
CreateConVar( "sw_blizzard_dmg_safeareas" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should fire negate blizzard damage?" , 0 , 1 )
CreateConVar( "sw_blizzard_dmg_sound_toggle" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Toggle blizzard damage sounds." , 0 , 1 )
CreateConVar( "sw_blizzard_dmg_delay" , 10 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between blizzard damage." , 1 , 30 )
CreateConVar( "sw_blizzard_dmg_delayoffset" , 5 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between blizzard damage." , 1 , 30 )
CreateConVar( "sw_blizzard_dmg_amount" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of damage blizzard does." , 1 , 100 )

function SW.BlizzardThink()

	if CLIENT then

		return false

	end

	if ( GetConVarNumber("sw_blizzard_dmg_sound_toggle") or GetConVarNumber("sw_blizzard_dmg_toggle") ) != 0 then

		for _ , BlizzardTarget in pairs( player.GetAll() ) do

			if not ( BlizzardTarget:Alive() or BlizzardTarget:IsOutside() ) then

				return

			end

			if !BlizzardTarget.NextHit then

				BlizzardTarget.NextHit = CurTime() + math.random( GetConVarNumber("sw_blizzard_dmg_delay") , GetConVarNumber("sw_blizzard_dmg_delay") + GetConVarNumber("sw_blizzard_dmg_delayoffset") )

			end

			if CurTime() >= BlizzardTarget.NextHit then

				-- if GetConVarNumber("sw_blizzard_dmg_safeareas") == 1 then

					-- local HeatCheck = ents.FindInSphere( BlizzardTarget:GetPos() , 128 )

					-- if table.HasValue( HeatCheck , "env_fire" ) then
					
						-- print("fire found")
						-- table.Empty( HeatCheck )

					-- end

				-- end

					if GetConVarNumber("sw_blizzard_dmg_sound_toggle") == 1 then

						BlizzardTarget:EmitSound( Sound( "ambient/voices/cough" .. math.random( 1 , 4 ) .. ".wav" ) )

					end

					if GetConVarNumber("sw_blizzard_dmg_toggle") == 1 then

						local BlizzardDMG = DamageInfo()
						BlizzardDMG:SetAttacker( game.GetWorld() )
						BlizzardDMG:SetInflictor( game.GetWorld() )
						BlizzardDMG:SetDamage( GetConVarNumber("sw_blizzard_dmg_amount") )
						BlizzardDMG:SetDamageForce( Vector() )
						BlizzardDMG:SetDamageType( DMG_RADIATION )

						BlizzardTarget:TakeDamageInfo( BlizzardDMG )

					end

				-- end

				BlizzardTarget.NextHit = CurTime() + math.random( GetConVarNumber("sw_blizzard_dmg_delay") , GetConVarNumber("sw_blizzard_dmg_delay") + GetConVarNumber("sw_blizzard_dmg_delayoffset") )

			end

		end

	end

end

----------------------------------------
----------------------------------------
-- HAIL
----------------------------------------
-- Server. VFX.
-- Rocks fall from sky.
----------------------------------------
----------------------------------------

CreateConVar( "sw_hail_delay" , 2 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between hail spawns." , 1 , 30 )
CreateConVar( "sw_hail_delayoffset" , 2 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between hail spawns." , 1 , 30 )
CreateConVar( "sw_hail_lifetime" , 2 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Time for hail to fade after hitting the ground. -1 for never (not recommended)." , -1 , 30 )
CreateConVar( "sw_hail_drag" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of drag to add to the hail. More = slower decent." , 0 , 20 )

function SW.HailThink( hailEnt )

	if CLIENT then

		return false

	end

	if !SW.SkyPositions then

		SW.SkyPositions = { }

	end

	if #SW.SkyPositions == 0 then

		return

	end

	if !SW.NextHail then

		SW.NextHail = CurTime()

	end

	if CurTime() >= SW.NextHail then

		SW.NextHail = CurTime() + math.random( GetConVarNumber("sw_hail_delay") , GetConVarNumber("sw_hail_delay") + GetConVarNumber("sw_hail_delayoffset") )

		if( #SW.SkyPositionsTall == 0 ) then return end

		local hp = table.Random( SW.SkyPositionsTall )

		local HailENT = ents.Create( hailEnt )
		HailENT:SetPos( hp - Vector( 0 , 0 , 100 ) )
		HailENT:DrawShadow( false )
		HailENT:SetMaterial( "ice" )
		HailENT:Spawn()
		HailENT:Activate()

		local phys = HailENT:GetPhysicsObject( )

		if phys and phys:IsValid() then
			
			local a = math.Rand( -math.pi , math.pi )
			local v = Vector( math.cos( a ) , math.sin( a ) , 0 )
			phys:AddVelocity( v * math.random( -500 , 500 ) )
			
		end

	end

end

----------------------------------------
----------------------------------------
-- LIGHTNING
----------------------------------------
-- Shared. AVFX.
-- Lightning strikes randomly.
----------------------------------------
----------------------------------------

CreateConVar( "sw_lightning_delay" , 10 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between lightning strikes." , 1 , 30 )
CreateConVar( "sw_lightning_delayoffset" , 5 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between lightning strikes." , 1 , 30 )

CreateConVar( "sw_lightning_damage" , 50 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Lightning damage to props/players." , 0 , 150 )
CreateConVar( "sw_lightning_force" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning propel props?" , 0 , 1 )
CreateConVar( "sw_lightning_force_amount" , 40 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) How much force to apply to props (default 40)." , 1 , 200 )
CreateConVar( "sw_lightning_ignite_world" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning ignites world on hit." , 0 , 1 )
CreateConVar( "sw_lightning_ignite_target" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning ignites target on hit." , 0 , 1 )
CreateConVar( "sw_lightning_ignite_duration" , 3 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Time lightning will ignites hit objects." , 1 , 15 )

CreateConVar( "sw_lightning_target_prop" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning strike props?" , 0 , 1 )
CreateConVar( "sw_lightning_target_player" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning strike players?" , 0 , 1 )
CreateConVar( "sw_lightning_target_npc" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning strike NPCs?" , 0 , 1 )
CreateConVar( "sw_lightning_target_world" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning will strike the world as well as targets." , 0 , 1 )
CreateConVar( "sw_lightning_target_chance" , 85 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Chance lightning will strike the ground vs. targets." , 1 , 100 )

CreateConVar( "sw_lightning_fancyfx" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Show fancy effects for lightning." , 0 , 1 )
CreateConVar( "sw_lightning_dissolve" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning dissolves target on kill." , 0 , 1 )

CreateConVar( "sw_cl_screenfx_lightning" , 1 , { FCVAR_ARCHIVE } , "(BOOL) Enable lightning flashes." , 0 , 1 )

function SW.LightningThink()

	if CLIENT then
	
		return false
		
	end

	util.AddNetworkString( "SW.LightningBolt" )

	if !SW.NextLightning then

		SW.NextLightning = CurTime()

	end

	if CurTime() >= SW.NextLightning then

		SW.NextLightning = CurTime() + math.random( GetConVarNumber("sw_lightning_delay") , GetConVarNumber("sw_lightning_delay") + GetConVarNumber("sw_lightning_delayoffset") )

		local StrikeTargetPosition

		if math.Rand( 0 , 1 ) <= (1 / GetConVarNumber("sw_lightning_target_chance")) or GetConVarNumber("sw_lightning_target_world") == 0 and ( GetConVarNumber("sw_lightning_target_prop") or GetConVarNumber("sw_lightning_target_player") or GetConVarNumber("sw_lightning_target_npc") ) == 1 then

			-- print("target")
			local TargetTable = {}

			if GetConVarNumber("sw_lightning_target_prop") == 1 then

				for k , v in pairs( ents.FindByClass( "prop_*" ) ) do

					table.insert( TargetTable , v )

				end

			end

			if GetConVarNumber("sw_lightning_target_player") == 1 then

				table.Merge( TargetTable , player.GetAll() )

			end

			if GetConVarNumber("sw_lightning_target_npc") == 1 then

				for k , v in pairs( ents.FindByClass( "npc_*" ) ) do

					table.insert( TargetTable , v )

				end

				for k , v in pairs( ents.FindByClass( "monster_*" ) ) do

					table.insert( TargetTable , v )

				end

			end

			local IsOutsideTable = { }

			for _ , outsiders in pairs( TargetTable ) do

				if outsiders:IsOutside() then

					-- print(tostring(outsiders:GetClass()))
					table.insert( IsOutsideTable , outsiders )

				end

			end

			if #IsOutsideTable == 0 then 

				return 

			end

			local OutsideTarget = table.Random( IsOutsideTable )

			local pos = OutsideTarget:GetPos()

			net.Start( "SW.LightningBolt" )
				net.WriteVector( pos )
				net.WriteEntity( OutsideTarget )
			net.SendPVS( pos )

			local a = math.Rand( -math.pi , math.pi )
			local v = Vector( math.cos( a ) , math.sin( a ) , 0 )

			local LightningDMG = DamageInfo()
			LightningDMG:SetAttacker( game.GetWorld() )
			LightningDMG:SetInflictor( game.GetWorld() )
			LightningDMG:SetDamage( GetConVarNumber("sw_lightning_damage") )
			LightningDMG:SetDamageForce( v * math.random( GetConVarNumber("sw_lightning_force_amount") , GetConVarNumber("sw_lightning_force_amount") * 3 ) + Vector( 0 , 0 , math.random( 0 , GetConVarNumber("sw_lightning_force_amount") ) ) )
			LightningDMG:SetDamagePosition( pos + Vector( 0 , 0 , 2048 ) )
			if GetConVarNumber("sw_lightning_dissolve") == 1 then
				LightningDMG:SetDamageType( DMG_DISSOLVE )
			else
				LightningDMG:SetDamageType( DMG_SHOCK )
			end

			OutsideTarget:TakeDamageInfo( LightningDMG )

			if GetConVarNumber("sw_lightning_force") == 1 then

				OutsideTarget:TakePhysicsDamage( LightningDMG )

			end

			if GetConVarNumber("sw_lightning_ignite_target") == 1 then

				OutsideTarget:Ignite( GetConVarNumber("sw_lightning_ignite_duration") , 64 )

			end

			StrikeTargetPosition = OutsideTarget:GetPos()

		else

			-- print("ground")
			if not SW.SkyPositions or #SW.SkyPositions == 0 then 

				return 

			end

			--PrintTable(SW.SkyPositions)

			local hp = table.Random( SW.SkyPositions )

			local trace = { }
			trace.start = hp
			trace.endpos = trace.start + Vector( 0 , 0 , -32768 )
			trace.filter = { }
			local tr = util.TraceLine( trace )

			if tr.Hit then
				
				net.Start( "SW.LightningBolt" )
					net.WriteVector( tr.HitPos )
					net.WriteEntity( game.GetWorld() )
				net.SendPVS( tr.HitPos )

			end

			StrikeTargetPosition = tr.HitPos

		end

		if GetConVarNumber("sw_lightning_fancyfx") == 1 then

			local LightningFXSparks = EffectData()
			LightningFXSparks:SetOrigin( StrikeTargetPosition )
			LightningFXSparks:SetNormal( Vector( 0 , 0 , 1 ) )
			LightningFXSparks:SetMagnitude( 1 )
			LightningFXSparks:SetScale( 1 )
			LightningFXSparks:SetRadius( 1 )
			util.Effect( "Sparks", LightningFXSparks )

			local LightningFXGlow = ents.Create("env_lightglow")
			LightningFXGlow:SetPos( StrikeTargetPosition )
			LightningFXGlow:SetKeyValue( "rendercolor" , "55 55 255" )
			LightningFXGlow:SetKeyValue( "verticalglowsize" , "8" )
			LightningFXGlow:SetKeyValue( "horizontalglowsize" , "8" )
			LightningFXGlow:SetKeyValue( "mindist" , "0")
			LightningFXGlow:SetKeyValue( "maxdist" , "1500")
			LightningFXGlow:Spawn()
			LightningFXGlow:Fire( "kill" , "" , 1 )

			local LightningFXPhysExplosion = ents.Create("env_physexplosion")
			LightningFXPhysExplosion:SetPos( StrikeTargetPosition )
			LightningFXPhysExplosion:SetKeyValue( "magnitude" , "505" )
			LightningFXPhysExplosion:SetKeyValue( "radius" , "64" )
			LightningFXPhysExplosion:SetKeyValue( "spawnflags" , "23" )
			LightningFXPhysExplosion:Spawn()
			LightningFXPhysExplosion:Fire( "explodeandremove" , "" , 0 )
			LightningFXPhysExplosion:Fire( "kill" , "" , 5 )
			LightningFXPhysExplosion:EmitSound( "ambient/energy/spark" .. math.random( 1 , 4 ) .. ".wav" , 75 , math.random( 90 , 110 ) , 0.75 , CHAN_STATIC , 128 , 20 )

			local LightningFXExplosion = ents.Create("env_explosion")
			LightningFXExplosion:SetPos( StrikeTargetPosition )
			LightningFXExplosion:SetKeyValue( "imagnitude" , "32" )
			LightningFXExplosion:SetKeyValue( "rendermode" , "5" )
			LightningFXExplosion:SetKeyValue( "spawnflags" , "26693" )
			LightningFXExplosion:Spawn()
			LightningFXExplosion:Fire( "explode" , "" , 0 )

		end

	end
	
end

if CLIENT then

	SW.LightningMat = Material( "effects/blueblacklargebeam" )

	function SW.LightningChildren( spos, alpha, level )

		if math.random( 1 , 3 ) != 1 or level == 0 then

			return 

		end

		local mainbeama = math.Rand( -math.pi , math.pi )
		local mainbeamt = math.Rand( 0 , math.pi )
		local r = math.random( 0 , 100 )

		local mainvec = r * Vector( 0.5 * math.sin( mainbeama ) * math.cos( mainbeamt ) , 0.5 * math.sin( mainbeama ) * math.sin( mainbeamt ) , 0 )

		local ss = spos

		for i = 1 , math.random( 2 , 4 ) * level do

			local newh = math.Rand( 15 , 40 ) * level
			local a = math.Rand( -math.pi , math.pi )
			local c = math.cos( a )
			local s = math.sin( a )

			local r = math.random( -15 , 15 )
			local addvec = Vector( c * r * level , s * r * level , -newh )

			local trace = { }
			trace.start = ss
			trace.endpos = ss + addvec + mainvec
			trace.filter = { }
			local tr = util.TraceLine( trace )

			if tr.Hit then

				break

			end

			render.SetMaterial( SW.LightningMat )
			render.DrawBeam( ss , tr.HitPos , 3 * level , 0 , 1 , Color( 255 , 255 , 255 , 255 * alpha ) )

			SW.LightningChildren( ss , alpha , level - 1 )

			ss = tr.HitPos

		end

	end

	function SW.LightningBolt( seed , filter , pos , alpha )

		math.randomseed( seed )

		local hittop = false
		local whilecatch = 0

		local start = pos
		local cstart = start

		local mainbeama = math.Rand( -math.pi , math.pi )
		local mainbeamt = math.Rand( -math.pi , math.pi )
		local r = math.random( 50 , 100 )

		local mainvec = r * Vector( 0.5 * math.sin( mainbeama ) * math.cos( mainbeamt ) , 0.5 * math.sin( mainbeama ) * math.sin( mainbeamt ) , math.cos( mainbeama ) )

		local whilecatch = 0

		while !hittop and whilecatch < 50 do

			whilecatch = whilecatch + 1 -- just in case...

			local newh = math.random( 50 , 150 )
			local a = math.Rand( -math.pi , math.pi )
			local c = math.cos( a )
			local s = math.sin( a )

			local addvec = Vector( c * math.random( -30 , 30 ) , s * math.random( -30 , 30 ) , newh )

			local trace = { }
			trace.start = cstart
			trace.endpos = cstart + addvec + mainvec
			trace.filter = filter
			local tr = util.TraceLine( trace )

			render.SetMaterial( SW.LightningMat )
			render.DrawBeam( cstart , tr.HitPos , 30 , 0 , 1 , Color( 255 , 255 , 255 , 255 * alpha ) )

			if tr.HitWorld or tr.HitSky then

				hittop = true

			elseif cstart.z - start.z > 100 then

				SW.LightningChildren( tr.HitPos , alpha , 2 )

			end

			cstart = tr.HitPos

		end

		math.randomseed( os.time() )

	end

	function SW.LightningBoltDraw( depth, sky )

		if SW.LightningStart and CurTime() - SW.LightningStart < 1 then

			SW.LightningBolt( SW.LightningSeed , SW.LightningFilter , SW.LightningPos , 1 - ( CurTime() - SW.LightningStart ) )

		end

	end
	hook.Add( "PostDrawOpaqueRenderables" , "SW.LightningBoltDraw" , SW.LightningBoltDraw )

	local function LightningBolt( len )

		local vec = net.ReadVector()
		local ent = net.ReadEntity()

		SW.LightningStart = CurTime()
		SW.LightningSeed = math.random( 1 , 1000 )

		if ent == game.GetWorld() then

			SW.LightningFilter = { }

		else

			SW.LightningFilter = { ent }

		end

		SW.LightningPos = vec

		sound.Play( "simpleweather/thunder" .. math.random( 1 , 3 ) .. ".mp3" , SW.ViewPos , 160 , 100 , GetConVarNumber("sw_cl_sound_volume") )
		sound.Play( "simpleweather/lightning" .. math.random( 1 , 4 ) .. ".mp3" , SW.ViewPos , 160 , 100 , GetConVarNumber("sw_cl_sound_volume") )

	end
	net.Receive( "SW.LightningBolt" , LightningBolt )

end

----------------------------------------
----------------------------------------
-- METEOR STORM
----------------------------------------
-- Server. AVFX.
-- Meteor entities spawn from sky.
----------------------------------------
----------------------------------------

CreateConVar( "sw_meteor_delay" , 2 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between meteor spawns." , 1 , 30 )
CreateConVar( "sw_meteor_delayoffset" , 2 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between meteor spawns." , 1 , 30 )
CreateConVar( "sw_meteor_lifetime" , 2 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Time for meteor shards to fade after hitting the ground. -1 for never (not recommended)." , -1 , 30 )
CreateConVar( "sw_meteor_drag" , 10 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of drag to add to the meteors. More = slower decent." , 0 , 50 )
CreateConVar( "sw_meteor_fancyfx" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Show fancy effects for meteors." , 0 , 1 )
CreateConVar( "sw_meteor_whoosh" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Meteors play a sound before impact." , 0 , 1 )

function SW.MeteorThink( metEnt )

	if CLIENT then

		return false

	end

	if !SW.SkyPositions then

		SW.SkyPositions = { }

	end

	if #SW.SkyPositions == 0 then

		return

	end

	if !SW.NextMeteor then

		SW.NextMeteor = CurTime()

	end

	if CurTime() >= SW.NextMeteor then

		SW.NextMeteor = CurTime() + math.random( GetConVarNumber("sw_meteor_delay") , GetConVarNumber("sw_meteor_delay") + GetConVarNumber("sw_meteor_delayoffset") )

		if #SW.SkyPositionsTall == 0 then 

			return 

		end

		local hp = table.Random( SW.SkyPositionsTall )

		local MeteorENT = ents.Create( metEnt )
		MeteorENT:SetPos( hp - Vector( 0 , 0 , 100 ) ) -- bbox is 140, 140, 140 x -140, -140, -140
		MeteorENT:Spawn()
		MeteorENT:Activate()

		local phys = MeteorENT:GetPhysicsObject()

		if phys and phys:IsValid() then

			local a = math.Rand( -math.pi , math.pi )
			local v = Vector( math.cos( a ) , math.sin( a ) , 0 )
			phys:AddVelocity( v * math.random( -500 , 500 ) )

		end

	end

end

----------------------------------------
----------------------------------------
-- RAIN
----------------------------------------
----------------------------------------
-- Basic rain shower.
-- Client. AVFX.
----------------------------------------
----------------------------------------

CreateConVar( "sw_rain_dropsize_min", 20 , { FCVAR_ARCHIVE } , "(INT) Minimum size of the raindrops on screen." , 10 , 100 )
CreateConVar( "sw_rain_dropsize_max", 40 , { FCVAR_ARCHIVE } , "(INT) Maximum size of the raindrops on screen." , 10 , 100 )
CreateConVar( "sw_rain_showimpact", 1 , { FCVAR_ARCHIVE } , "(BOOL) Make rain splash particle effect." , 0 , 1 )
CreateConVar( "sw_rain_showsmoke", 1 , { FCVAR_ARCHIVE } , "(BOOL) Make rain steam particle effect." , 0 , 1 )
CreateConVar( "sw_rain_quality", 1 , { FCVAR_ARCHIVE } , "(INT) Rain impact quality." , 1 , 4 )

CreateConVar( "sw_rain_height", 300 , { FCVAR_ARCHIVE } , "(INT) Maximum height to make rain." , 0 , 2500 )
CreateConVar( "sw_rain_radius", 500 , { FCVAR_ARCHIVE } , "(INT) Radius of rain effect." , 0 , 2500 )
CreateConVar( "sw_rain_count", 20 , { FCVAR_ARCHIVE } , "(INT) Amount of particles in rain effect. Make this smaller to increase performance." , 0 , 100 )
CreateConVar( "sw_rain_dietime", 3 , { FCVAR_ARCHIVE } , "(INT) Time in seconds until rain vanishes." , 0 , 16 )

function SW.RainThink()

	if CLIENT and GetConVarNumber("sw_cl_weather_toggle") == 1 and GetConVarNumber("sw_func_particle_type") == 0 then

		local drop = EffectData()
		drop:SetOrigin( SW.ViewPos )
		drop:SetScale( 0 )
		util.Effect( "sw_rain", drop )

	end

end

----------------------------------------
----------------------------------------
-- SANDSTORM
----------------------------------------
----------------------------------------

function SW.SandstormThink()

	if SERVER then

		return false

	end

	-- If show weather effects is on...
	if GetConVarNumber("sw_cl_weather_toggle") then

		local drop = EffectData()
			drop:SetOrigin( SW.ViewPos )
		util.Effect( "sw_sandstorm", drop )

	end

end

----------------------------------------
----------------------------------------
-- SMOG
----------------------------------------
----------------------------------------

CreateConVar( "sw_smog_dmg_sound_toggle" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Toggle smog coughing sounds." , 0 , 1 )
CreateConVar( "sw_smog_dmg_delay" , 10 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between smog damage." , 1 , 30 )
CreateConVar( "sw_smog_dmg_delayoffset" , 5 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between smog damage." , 1 , 30 )

CreateConVar( "sw_smog_dmg_toggle" , 1 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should smog cause damage?" , 0 , 1 )
CreateConVar( "sw_smog_dmg_amount" , 3 , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of damage smog does." , 1 , 100 )

function SW.SmogThink()

	if CLIENT then

		return false

	end

	if ( GetConVarNumber("sw_smog_dmg_sound_toggle") or GetConVarNumber("sw_smog_dmg_toggle") ) != 0 then

		for _, v in pairs( player.GetAll() ) do

			if !v.NextSmogCough then

				v.NextSmogCough = CurTime() + math.random( GetConVarNumber("sw_smog_dmg_delay") , GetConVarNumber("sw_smog_dmg_delay") + GetConVarNumber("sw_smog_dmg_delayoffset") )

			end

			if CurTime() >= v.NextSmogCough then

				if GetConVarNumber("sw_smog_dmg_sound_toggle") == 1 then

					v:EmitSound( Sound( "ambient/voices/cough" .. math.random( 1, 4 ) .. ".wav" ) )

				end

				if GetConVarNumber("sw_smog_dmg_toggle") == 1 then

					local SmogDMG = DamageInfo()
					SmogDMG:SetAttacker( game.GetWorld() )
					SmogDMG:SetInflictor( game.GetWorld() )
					SmogDMG:SetDamage( GetConVarNumber("sw_smog_dmg_amount") )
					SmogDMG:SetDamageForce( Vector() )
					SmogDMG:SetDamageType( DMG_NERVEGAS )

					v:TakeDamageInfo( SmogDMG )

				end

				v.NextSmogCough = CurTime() + math.random( GetConVarNumber("sw_smog_dmg_delay") , GetConVarNumber("sw_smog_dmg_delay") + GetConVarNumber("sw_smog_dmg_delayoffset") )

			end

		end

	end

end

----------------------------------------
----------------------------------------
-- SNOW
----------------------------------------
----------------------------------------

CreateConVar( "sw_snow_stay", 1 , { FCVAR_ARCHIVE } , "(BOOL) Leave snow on the ground." , 0 , 1 )
CreateConVar( "sw_snow_height", 100 , { FCVAR_ARCHIVE } , "(INT) Maximum height to make snow." , 0 , 2500 )
CreateConVar( "sw_snow_radius", 400 , { FCVAR_ARCHIVE } , "(INT) Radius of snow effect." , 0 , 2500 )
CreateConVar( "sw_snow_count", 5 , { FCVAR_ARCHIVE } , "(INT) Amount of particles in snow effect. Make this smaller to increase performance." , 0 , 5000 )
CreateConVar( "sw_snow_dietime", 5 , { FCVAR_ARCHIVE } , "(INT) Time in seconds until snow vanishes." , 0 , 16 )

function SW.SnowThink()

	if SERVER then

		return false

	end

	if GetConVarNumber("sw_cl_weather_toggle") == 1 then

		local drop = EffectData()
		drop:SetOrigin( SW.ViewPos )
		util.Effect( "sw_snow", drop )

	end

end

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
-- TEXTURE REPLACEMENT SYSTEMS
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

-- Sticking these here for reference
-- nature/snowfloor001a
-- nature/snowwall002a

------------------------------------------------------------
-- Replacement table
-- Args: 
-- 1: material to find
-- 2: replacement method (0=replace both, 1=only $basetexture, 2=only $basetexture2, 3=make invisible)
-- 3: material to replace with
------------------------------------------------------------

SW.SnowTextureSettings = {

	-- GMod
	{ "gm_construct/grass_13" , 0 },
	{ "gm_construct/flatgrass" , 0 },
	{ "gm_construct/flatgrass_2" , 0 },
	{ "gm_construct/grass-sand_13" , 1 },
	{ "maxofs2d/grass_01" , 1 },

	-- Misc. Customs
	{ "ajacks/ajacks_grass-dirt01" , 1 },
	{ "ajacks/ajacks_grass-sand01" , 1 },
	{ "ajacks/ajacks_grass01" , 1 },
	{ "blend/blend_conf_pavementgrass" , 2 },
	{ "blend/blend_conf_dirtgrass" , 2 },
	{ "blend/blend_conf_acliffgrass" , 2 },
	{ "customtext/gc textures/blends/grass_dirt_blend04" , 1 },
	{ "maps/gm_apehouse_summer_day/nature/blendgrassdirt01_wvt_patch" , 1 },
	{ "maps/gm_iremia/nature/blendgrassdirt02_noprop_wvt_patch" , 0 },
	{ "nature/grass_whitemosspebbles_blend" , 2 },
	{ "nature/nijo_grasstogravel_ivy" , 2 },
	{ "nature/nijo_grasstogravel2_ivy" , 2 },
	{ "nature/pinkleaftograssblend_ivy" , 2 },

	{ "theprotextures/blendgrassgravel002a_gmfix" , 0 },
	{ "textures/enviroment/blendgrassgravel1" , 2 },
	{ "textures/enviroment/blendsandgrass1" , 2 },

	-- dm_stad
	{ "dm_stad/floor/grass03" , 1 },
	{ "dm_stad/floor/blendgrassgrass01" , 0 },
	{ "dm_stad/floor/blendgrassdirt02" , 2 },
	{ "dm_stad/floor/blendgrassforest01" , 2 },

	-- gm_fork
	{ "fork/cliff04c" , 2 },
	{ "fork/cliff04c_skybox" , 2 },

	-- gs
	{ "freespace/terrain/freespace_dirtgravelblend01" , 1 },
	{ "freespace/terrain/freespace_dirtrockblend01" , 1 },
	{ "freespace/terrain/freespace_grassdirtblend01" , 1 },
	{ "freespace/terrain/freespace_grassrockblend01" , 1 },
	{ "freespace/terrain/freespace_skyboxterrainblend01" , 1 },
	{ "maps/gs_camp_killpact_v1/freespace/terrain/freespace_grassdirtblend01_wvt_patch" , 1 },
	{ "maps/gs_camp_killpact_v1/freespace/terrain/freespace_grassrockblend01_wvt_patch" , 1 },

	-- gm_vernrock
	{ "gm_vernrock/blends/blendgrassdirt001" , 1 },
	{ "gm_vernrock/blends/blendgrassmud001" , 1 },
	{ "gpoint/fixedgrass/dirtfloor006a" , 0 },
	{ "ground/flash_ground_blend" , 1 },
	{ "ground/flash_ground_skyboxtrees" , 1 },
	{ "ground/skybox_ground01_blend" , 0 },
	{ "ground/hr_g/hr_gravel_grass_001_blend" , 1 },

	-- Lost Coast
	{ "lostcoast/nature/blendpathweeds002a" , 2 },
	{ "lostcoast/nature/blendrockgravel002a" , 1 },
	{ "lostcoast/nature/blendstonepathweeds001a" , 2 },

	-- Insurgency MIC
	{ "majoris/buhriz_lightsand_01" , 1 },
	{ "majoris/buhriz_darksand_01" , 1 },
	{ "majoris/buhriz_sandrock_01" , 1 },
	{ "majoris/buhriz_sandgrass_02" , 1 },
	{ "maps/karam/blend_grass_road" , 1 },
	{ "maps/karam/blend_grass_sand" , 1 },
	{ "maps/karam/blend_riverbed_grass" , 2 },
	{ "maps/karam/blend_rock_grass2" , 2 },
	{ "maps/karkar/blend_sand_road" , 1 },
	{ "maps/karkar/blend_sand_road_skybox" , 1 },
	{ "maps/karkar/blend_sand_gravel" , 2 },
	{ "maps/karkar/blend_rock_sand" , 2 },
	{ "maps/karkar/blend_rock_sand_skybox" , 2 },
	{ "maps/karkar/blend_sand_coal" , 2 },
	{ "maps/road/asphalt_sand_blend02" , 2 },
	{ "maps/road/blend_sand_road_vil" , 2 },
	{ "maps/road/blendsand01road_fmp" , 2 },
	{ "maps/road/ramadisandroad_dirt" , 1 },
	{ "maps/road/ramadisandsidewalk_oog" , 2 },
	{ "maps/terrain/baghdad_blend_07" , 2 },
	{ "maps/terrain/blend_dirt_sand_1024_era2_detail" , 2 },
	{ "maps/terrain/blend_cobble_sand_1024_era1_detail" , 2 },
	{ "maps/terrain/blend_road_sand_1024_era2" , 2 },
	{ "maps/terrain/blend_dirt_sand_1024_era2_curb" , 2 },
	{ "maps/terrain/blend_dirt_sand_1024_era2" , 2 },
	{ "maps/terrain/blend_road_sand_1024_era1" , 2 },
	{ "maps/terrain/blend_rubble_sand_1024_era1" , 2 },
	{ "maps/terrain/blend_stone_sand_1024_era1" , 2 },
	{ "maps/terrain/blend_tile_sand_1024_era1" , 2 },
	{ "maps/terrain/baghdad_blend_01" , 0 },
	{ "maps/terrain/baghdad_blend_02" , 0 },
	{ "maps/terrain/blend_grass_sand_1024_era1" , 0 },
	{ "maps/terrain/sand_grass_blend_mino" , 0 },
	{ "maps/terrain/baghdad_blend_03" , 1 },
	{ "maps/terrain/blend_sand_rock_mino" , 1 },
	{ "maps/terrain/sand_blend01_mino" , 1 },
	{ "maps/terrain/sand_blend02_mino" , 1 },
	{ "maps/terrain/sand_sidewalk_blend_mino" , 1 },
	{ "maps/terrain/sand_sidewalk02_blend_mino" , 1 },
	{ "maps/terrain/grass_sand_01blend_stw" , 1 },
	{ "maps/terrain/stones_sand_01blend_stw" , 1 },
	{ "maps/terrain/blend_grass_dirt_1024_era1_detail" , 1 },
	{ "maps/terrain/sand01a_mino" , 1 },

	-- rp_trainingcenter
	{ "trainingyard/dirtroad" , 2 },
	{ "trainingyard/newsandblend" , 2 },
	{ "trainingyard/newdirtblend" , 0 },

	-- gm_kleinercomcenter
	{ "maps/gm_kleinercomcenter/nature/comc_grassmudblend_nodetail_wvt_patch" , 1 },
	{ "maps/gm_kleinercomcenter/nature/comc_grassmudblend_wvt_patch" , 1 },
	{ "nature/comc_grasssand" , 1 },
	{ "nature/comc_grassmudblend" , 1 },
	{ "nature/comc_grassgravelblend" , 1 },

	-- DoD:S
	
	-- dod_anzio
	{ "nature/anzio_grass_blend002" , 0 },
	{ "nature/anzio_skytrees" , 2 },

	-- dod_argentan
	{ "nature/argentan_blendcliffgrass" , 2 },
	{ "nature/argentan_blendcobblegrass" , 1 },
	{ "nature/argentan_blendgrassdirt" , 1 },
	{ "nature/argentan_blendgrassdirt_cheap" , 1 },
	{ "nature/argentan_skygrasstrees" , 1 },

	-- dod_avalanche
	{ "rubble/blendrubblegrass001b_avalanche" , 1 },

	-- dod_jagd
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1824_-8_-328" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-2184_0_-328" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-312_-72_-232" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-464_-1088_-296" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-88_56_-232" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_320_72_-232" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_664_32_-232" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_704_-352_-248" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_720_-760_-248" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1008_-1176_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1248_-1264_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_864_-992_-304" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-384_-1848_-336" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-768_-2048_-336" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-384_-2128_-336" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_56_-2160_-368" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1280_-2032_-368" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1712_-576_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1384_-384_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1344_-96_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1992_-320_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1400_528_-288" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1384_912_-216" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1376_1208_-216" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1168_1216_-216" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1168_1440_-216" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_1152_1712_-216" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_864_1544_-216" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_464_1704_-248" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_128_1728_-248" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_208_1144_-248" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_680_640_-232" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_184_856_-248" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-24_832_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-256_944_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-608_816_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-976_656_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1056_992_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-976_656_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-976_384_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-496_1024_-280" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-2280_-392_-328" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1280_-32_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1088_-272_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1464_-684_-276" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1448_-752_-160" , 2 },
	{ "maps/dod_jagd/stone/blendcobbledirt002a_-1072_80_-312" , 2 },
	{ "maps/dod_jagd/stone/blendcobblegrass002a_-2280_-392_-328" , 1 },
	{ "maps/dod_jagd/stone/blendcobblegrass002a_496_-2176_-368" , 1 },
	{ "maps/dod_jagd/stone/blendcobblegrass002a_2040_-872_-288" , 1 },
	{ "maps/dod_jagd/stone/blendstonedirt001a_336_-1824_-336" , 2 },
	{ "maps/dod_jagd/stone/blendstonedirt001a_1656_-1120_-288" , 2 },

	-- HL2
	{ "nature/blendcobbledirt001" , 2 },
	{ "nature/blendcobblegrass002" , 1 },

	{ "nature/blenddirtgrass001a" , 2 },
	{ "nature/blenddirtgrass001b" , 2 },
	{ "nature/blenddirtgrass008a" , 2 },
	{ "nature/blenddirtgrass008b" , 2 },
	{ "nature/blenddirtgrass008b_lowfriction" , 2 },
	{ "nature/blenddirtgravel01" , 2 },

	{ "nature/blendgrassdirt01" , 1 },
	{ "nature/blendgrassdirt01_noprop" , 1 },
	{ "nature/blendgrassdirt02" , 1 },
	{ "nature/blendgrassdirt02_noprop" , 1 },
	{ "nature/blendgrassdirt03" , 1 },
	{ "nature/blendgrassgrass001a" , 0 },
	{ "nature/blendgrassgravel01" , 0 },
	{ "nature/blendgrassgravel001a" , 1 },
	{ "nature/blendgrassgravel001b" , 1 },
	{ "nature/blendgrassgravel001c" , 2 },
	{ "nature/blendgrassgravel002b" , 1 },
	{ "nature/blendgrassgravel003a" , 2 },
	{ "nature/blendgrassmud01" , 1 },
	{ "nature/blendgrasspave01" , 1 },

	{ "nature/blendgravelconc01" , 1 },
	{ "nature/blendgravelgravel01" , 0 },
	{ "nature/blendgravelgravel02" , 1 },
	{ "nature/blendgravelgravel02b" , 2 },
	{ "nature/blendgravelmud01" , 1 },
	{ "nature/blendgravelmud02" , 1 },
	
	{ "nature/blend_ivy1" , 0 },
	{ "nature/blendrockgrass004a" , 2 },
	{ "nature/blendrocksgrass006a" , 2 },
	{ "nature/blendsandgrass008a" , 0 },
	{ "nature/blendsandsand008a" , 0 },
	{ "nature/blendsandsand008b" , 2 },
	{ "nature/blendsandsand008b_antlion" , 2 },

	{ "nature/dirtfloor006a" , 1 },
	{ "nature/grassfloor001a" , 1 },
	{ "nature/grassfloor002a" , 1 },
	{ "nature/grassfloor003a" , 1 },
	{ "nature/red_grass" , 2 },
	{ "nature/red_grass_thin" , 2 },
	{ "nature/rocks_red_grass" , 2 },
	{ "nature/rockwall1_grass_ivy" , 2 },
	{ "nature/short_red_grass" , 2 },

	-- CS:S

	-- cs_assault
	-- { "cs_assault/pavement001a" , 1 },

	-- cs_havana
	{ "cs_havana/ground01grass" , 1 },
	{ "cs_havana/groundd01" , 1 },

	-- cs_militia
	{ "nature/blendmilground004_2" , 2 },
	{ "nature/blendmilground005_2" , 2 },
	{ "nature/blendmilground008_2" , 0 },
	{ "nature/blendmilground008_2_plants" , 0 },
	{ "nature/blendmilground008_4" , 1 },
	{ "nature/blendmilground008_8b" , 1 },
	{ "nature/blendmilground008b_2" , 0 },
	{ "nature/blendmilground011_2" , 2 },
	{ "nature/blendmilrock002_ground002" , 2 },
	{ "nature/milground002" , 1 },

	-- de_aztec
	-- { "de_aztec/ground02_blend_nobump" , 1 },
	{ "maps/de_aztec/de_aztec/ground01_blend_-272_-960_-151" , 1 },
	{ "maps/de_aztec/de_aztec/ground01_blend_-2689_259_-247" , 1 },
	{ "maps/de_aztec/de_aztec/ground01_blend_-2705_-776_-161" , 1 },
	{ "maps/de_aztec/de_aztec/ground02_blend_-272_-960_-151" , 1 },
	{ "maps/de_aztec/de_aztec/ground02_blend_-424_-1484_-157" , 1 },
	{ "maps/de_aztec/de_aztec/ground02_blend_-976_699_-119" , 1 },

	-- de_cbble
	{ "de_cbble/grassdirt_blend" , 1 },
	{ "de_cbble/grassfloor01" , 1 },

	-- de_chateau
	{ "de_chateau/brusha" , 1 },
	{ "de_chateau/groundd" , 1 },
	{ "de_chateau/groundd_blend" , 1 },
	{ "de_chateau/groundl" , 1 },
	{ "de_chateau/rockf_blend" , 2 },

	-- de_dust
	{ "de_dust/groundsand_blend" , 1 },
	{ "de_dust/groundsand03" , 1 },
	{ "de_dust/rockwall_blend" , 2 },

	-- de_inferno
	{ "nature/infblendgrassdirt001a" , 1 },

	-- de_nuke
	{ "de_nuke/nukblenddirtgrass" , 2 },
	{ "de_nuke/nukblenddirtgrassb" , 2 },

	-- de_piranesi
	{ "de_piranesi/pi_ground" , 1 },
	{ "de_piranesi/pi_ground_blend" , 1 },

	-- de_prodigy
	{ "nature/blendprodconcgrass" , 2 },
	{ "nature/blendproddirtgrass" , 2 },

	-- de_tides
	{ "de_tides/blendgrassstonepath" , 2 },
	{ "de_tides/tides_grass_a" , 1 },

	-- de_train
	{ "de_train/blendgrassdirt001a" , 1 },

	-- HL2 EP2
	{ "nature/forest_grass_01" , 1 },

	-- EvoCity
	{ "sgtsicktextures/blend_chipsgrass_001" , 0 },
	{ "maps/rp_evocity2_v5p/nature/blendgrassdirt01_noprop_wvt_patch" , 1 },
	{ "maps/rp_evocity2_v5p/nature/blendgrassdirt02_noprop_wvt_patch" , 1 },

	-- Rockford
	{ "statua/nature/blendforest_01" , 1 },
	{ "statua/nature/blendforest_02" , 1 },
	{ "statua/nature/blendgrassdirt01" , 1 },
	{ "statua/nature/blendgrasssand01" , 1 },
	{ "statua/nature/farmblend1" , 1 },
	{ "statua/nature/farmblend2" , 1 },
	{ "statua/nature/farmblend3" , 1 },
	{ "statua/nature/farmblend4" , 1 },
	{ "statua/nature/rockfordgrass2_noprop" , 1 },
	{ "statua/nature/rockfordgrass1" , 2 },
	{ "maps/rp_truenorth_v1a/statua/nature/blendgrassdirt01_wvt_patch" , 1 },
	{ "models/statua/shared/blendgrassdirt01" , 1 },

	-- Union City
	{ "unioncity/floorground/parkcobbles" , 2 },
	{ "unioncity/natural/parkgrassleaves" , 0 },
	{ "unioncity2/floors/grass" , 1 },
	{ "unioncity2/floors/parkcobbles" , 1 },
	{ "unioncity2/floors/parkdirttograss" , 2 },
	{ "maps/rp_unioncity_day/unioncity/natural/parkgrassleaves_wvt_patch" , 0 },

	-- TrakPak
	{ "gulch/gulch_cavegrass" , 2 },
	{ "gulch/gulch_cavesand" , 2 },
	{ "gulch/gulch_cavewall"  , 2 },
	{ "gulch/gulch_dirtgrass" , 0 },
	{ "gulch/gulch_rockgrass" , 1 },
	{ "gulch/gulch_rocksand" , 1 },
	{ "gulch/gulch_sandgrass" , 0 },
	{ "models/props_gulch/grassfloor002a" , 0 },
	{ "trakpak/terrain/blendgrassballast" , 1 },

	-- Things to hide
	-- { "de_chateau/bush01a" , 3 },
	-- { "models/cliffs/ferns01" , 3 },
	-- { "models/props_foliage/bush" , 3 },
	-- { "models/props_foliage/grass_clusters" , 3 },
	-- { "models/props_foliage/grass3" , 3 },
	-- { "models/props_foliage/rocks_vegetation" , 3 },
	-- { "models/props_forest/fern01" , 3 },

}

SW.SnowModelSettings = {

	-- { "apehouse/nolight_skybox_farms_summer" , "xmas_apehouse/skybox_farms_winter_nolights" }, -- gm_apehouse
	-- { "apehouse/mountain_blend" , 0 , "xmas_apehouse/snow_mountain_blend" }, -- gm_apehouse
	-- { "models/fork/tree_pine04_lowdetail_cluster_card" , "models/props_foliage/tree_pine_cards_01_snow" }, -- needs custom texture
	-- { "models/fork_gs/tree_pine04_lowdetail_cluster_card" , "models/props_foliage/tree_pine_cards_01_snow" }, -- needs custom texture

	{ "models/props_foliage/arbre01" , "models/props_foliage/arbre01_snow" },
	{ "models/props_foliage_gs/arbre01" , "models/props_foliage/arbre01_snow" },
	{ "models/fork/tree_pine04_lowdetail_cluster" , "models/props_foliage/arbre01_snow" },
	{ "models/fork_gs/tree_pine04_lowdetail_cluster" , "models/props_foliage/arbre01_snow" },
	{ "models/props_foliage/arbre01_b" , "models/props_foliage/arbre01_b_snow" },
	{ "models/props_foliage/hedge_128" , "models/props_foliage/hedgesnow_128" },
	{ "models/props_foliage_gs/hedge_128" , "models/props_foliage/hedgesnow_128" },
	{ "models/props_foliage/tree_pine_cards_01" , "models/props_foliage/tree_pine_cards_01_snow" }

}

SW.SnowSettings = { "simpleweather/textures/snow_0_01" , "simpleweather/textures/snow_0_01_normal" , "snow" , ""}

-- The reset table. Don't fucking touch!
SW.SnowTextureResets = { }
SW.SnowModelResets = { }

function SW.ResetSnowTextureSettings()

	for k, originals in pairs( SW.SnowTextureResets ) do

		local m = Material( k )

		if originals[1] then
			m:SetTexture( "$basetexture", originals[1] )
		end

		if originals[2] then
			m:SetTexture( "$basetexture2", originals[2] )
		end

		if originals[3] then
			m:SetTexture( "$bumpmap", originals[3] )
		end

		if originals[4] then
			m:SetTexture( "$bumpmap2", originals[4] )
		end

	end

	for k, originals in pairs( SW.SnowModelResets ) do

		local m = Material( k )

		if originals[1] then
			m:SetTexture( "$basetexture", originals[1] )
		end

	end

	-- table.Empty( SW.SnowTextureResets )
	-- table.Empty( SW.SnowModelResets )

end
hook.Add( "InitPostEntity", "SW.ResetSnowTextureSettings", SW.ResetSnowTextureSettings )


-- function SW.CheckSnowTexture( mat, mattype, norm )

	-- if( norm:Dot( Vector( 0, 0, 1 ) ) < 0.99 ) then return end

	-- SW.SetSnowTextureSettings()
	
-- end

function SW.SetSnowTextureSettings()

	if GetConVarNumber("sw_func_textures") != 1 or CLIENT then return end

	for k, modelTexture in pairs( SW.SnowModelSettings ) do

		local originalMaterial = string.lower( modelTexture[1] )

		local m = Material( originalMaterial )

		if( !SW.SnowModelResets[originalMaterial] ) then

			local t1 = m:GetTexture( "$basetexture" )

			if t1 and t1 != "" then
				o_t1 = string.lower( t1:GetName() )
			end

		end

		local replacement = string.lower( modelTexture[2] )
		local m_replacement = Material( replacement )

		if ( m_replacement:GetTexture( "$basetexture" ) == nil ) then print( "[SW] Snow Replacement $basetexture: " .. tostring( m_replacement ) .. " is not valid." ) return end
		m:SetTexture( "$basetexture", m_replacement:GetTexture( "$basetexture" ) )

		SW.SnowModelResets[originalMaterial] = { o_t1 }

		-- if GetConVarNumber("sw_debug") == 1 then print("simpleweather/sh_weathereffects::SW.SetSnowTextureSettings::Model Relacement::" .. tostring(m) .. " is now " .. tostring(m_replacement) ) end

	end

	for k, v in pairs( SW.SnowTextureSettings ) do

		originalMaterial = string.lower( v[1] )

		local m = Material( originalMaterial )

		if( !SW.SnowTextureResets[originalMaterial] ) then
			local t1 = m:GetTexture( "$basetexture" )
			local t2 = m:GetTexture( "$basetexture2" )
			local b1 = m:GetTexture( "$bumpmap" )
			local b2 = m:GetTexture( "$bumpmap2" )

			if t1 and t1 != "error" then
				o_t1 = string.lower( t1:GetName() )
			end

			if t2 and t2 != "error" then
				o_t2 = string.lower( t2:GetName() )
			end

			if b1 and b1 != "error" then
				-- print(tostring(o_b1))
				o_b1 = string.lower( b1:GetName() )
			else
				o_b1 = string.lower( "dev/bump_normal" )
			end

			if b2 and b2 != "error"  then
				-- print(tostring(o_b2))
				o_b2 = string.lower( b2:GetName() )
			else
				o_b2 = string.lower( "dev/bump_normal" )
			end

			SW.SnowTextureResets[originalMaterial] = { o_t1 , o_t2 , o_b1 , o_b2 }

		end

		if v[2] == 0 then

			m:SetTexture( "$basetexture", SW.SnowSettings[1] )
			-- m:SetTexture( "$bumpmap", SW.SnowSettings[2] )

			m:SetTexture( "$basetexture2", SW.SnowSettings[1] )
			-- m:SetTexture( "$bumpmap2", SW.SnowSettings[2] )

		end

		if v[2] == 1 then

			m:SetTexture( "$basetexture", SW.SnowSettings[1] )
			-- m:SetTexture( "$bumpmap", SW.SnowSettings[2] )

		end

		if v[2] == 2 then

			m:SetTexture( "$basetexture2", SW.SnowSettings[1] )
			-- m:SetTexture( "$bumpmap2", SW.SnowSettings[2] )

		end

		-- de_train has SPECIAL gravel!
		if string.lower( game.GetMap() ) == "de_train" then

			local materialSwap = {
				"de_train/blendgraveldirt001a",
			}

			for k , v in pairs( materialSwap ) do

				v = string.lower( v )

				local m = Material( v )

				if( !SW.SnowTextureResets[v] ) then
					local t1 = m:GetTexture( "$basetexture" )
					local t2 = m:GetTexture( "$basetexture2" )

					local m1, m2
					if( t1 and t1 != "" ) then
						m1 = string.lower( t1:GetName() )
					end

					if( t2 and t2 != "" ) then
						m2 = string.lower( t2:GetName() )
					end

					SW.SnowTextureResets[v] = { m1, m2 }

				end

				m:SetTexture( "$basetexture", SW.SnowSettings[1] )

				materialSwap = {}

			end

		end

	end

end

function SW.SnowPlayerFootstep( ply, pos, foot, sound, vol, filt )

	local w = SW:GetCurrentWeather()

	if( w and w.SnowFootsteps and false ) then
		
		local trace = { }
		trace.start = ply:GetPos() + Vector( 0, 0, 32 )
		trace.endpos = trace.start + Vector( 0, 0, -64 )
		trace.filter = ply
		local tr = util.TraceLine( trace )

		if( tr.Hit and tr.HitWorld ) then

			if( tr.HitTexture == "**displacement**" or table.HasValue( SW.SnowTextureSettings, string.lower( tr.HitTexture ) ) ) then

				ply:EmitSound( Sound( "player/footsteps/snow" .. math.random( 1, 6 ) .. ".wav" ) )
				return true

			end

		end

	end

end
hook.Add( "PlayerFootstep", "SW.SnowPlayerFootstep", SW.SnowPlayerFootstep )
