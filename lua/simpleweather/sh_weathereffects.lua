
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

CreateConVar( "sw_acidrain_dmg_toggle" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should acid rain cause damage?" , "0" , "1" )
CreateConVar( "sw_acidrain_dmg_amount" , "5" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of damage acid rain does." , "1" , "100" )
CreateConVar( "sw_acidrain_dmg_delay" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between acid rain damage." , "1" , "30" )

function SW.AcidRainThink()

	if CLIENT and GetConVarNumber("sw_cl_weather_toggle") == 1 then

		local drop = EffectData()
		drop:SetOrigin( SW.ViewPos )
		drop:SetScale( 0 )
		util.Effect( "sw_acidrain", drop )

	end

	if SERVER and GetConVarNumber("sw_acidrain_dmg_toggle") != 0 then

		for _ , AcidRainTarget in pairs( player.GetAll() ) do

			if not ( AcidRainTarget:Alive() or AcidRainTarget:IsOutside() ) then

				return

			end

			if !AcidRainTarget.NextHit then

				AcidRainTarget.NextHit = 0

			end

			if CurTime() >= AcidRainTarget.NextHit then

				AcidRainTarget.NextHit = CurTime() + GetConVarNumber("sw_acidrain_dmg_delay")

				local AcidRainDMG = DamageInfo()
				AcidRainDMG:SetAttacker( game.GetWorld() )
				AcidRainDMG:SetInflictor( game.GetWorld() )
				AcidRainDMG:SetDamage( GetConVarNumber("sw_acidrain_dmg_amount") )
				AcidRainDMG:SetDamageForce( Vector() )
				AcidRainDMG:SetDamageType( DMG_ACID )

				AcidRainTarget:TakeDamageInfo( AcidRainDMG )

				AcidRainTarget:EmitSound( "player/pl_burnpain" .. math.random( 1, 3 ) .. ".wav", 75, math.random( 90 , 110 ) , 0.3 )

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

CreateClientConVar( "sw_blizzard_height", "100" , true , false , "(INT) Maximum height to make blizzard." , "0" , "2500" )
CreateClientConVar( "sw_blizzard_radius", "400" , true , false , "(INT) Radius of blizzard effect." , "0" , "2500" )
CreateClientConVar( "sw_blizzard_count", "10" , true , false , "(INT) Amount of particles in blizzard effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_blizzard_dietime", "5" , true , false , "(INT) Time in seconds until blizzard vanishes." , "0" , "16" )

CreateConVar( "sw_blizzard_dmg_toggle" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should blizzard cause damage?" , "0" , "1" )
CreateConVar( "sw_blizzard_dmg_safeareas" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should fire negate blizzard damage?" , "0" , "1" )
CreateConVar( "sw_blizzard_dmg_sound_toggle" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Toggle blizzard damage sounds." , "0" , "1" )
CreateConVar( "sw_blizzard_dmg_delay" , "10" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between blizzard damage." , "1" , "30" )
CreateConVar( "sw_blizzard_dmg_delayoffset" , "5" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between blizzard damage." , "1" , "30" )
CreateConVar( "sw_blizzard_dmg_amount" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of damage blizzard does." , "1" , "100" )

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

CreateConVar( "sw_hail_delay" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between hail spawns." , "1" , "30" )
CreateConVar( "sw_hail_delayoffset" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between hail spawns." , "1" , "30" )
CreateConVar( "sw_hail_lifetime" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Time for hail to fade after hitting the ground. -1 for never (not recommended)." , "-1" , "30" )
CreateConVar( "sw_hail_drag" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of drag to add to the hail. More = slower decent." , "0" , "20" )

SW.HailClassName = "sw_hail"

function SW.HailThink()

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

		local HailENT = ents.Create( SW.HailClassName )
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

CreateConVar( "sw_lightning_delay" , "10" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between lightning strikes." , "1" , "30" )
CreateConVar( "sw_lightning_delayoffset" , "5" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between lightning strikes." , "1" , "30" )

CreateConVar( "sw_lightning_damage" , "50" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Lightning damage to props/players." , "0" , "150" )
CreateConVar( "sw_lightning_force" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning propel props?" , "0" , "1" )
CreateConVar( "sw_lightning_force_amount" , "40" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) How much force to apply to props (default 40)." , "1" , "200" )
CreateConVar( "sw_lightning_ignite_world" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning ignites world on hit." , "0" , "1" )
CreateConVar( "sw_lightning_ignite_target" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning ignites target on hit." , "0" , "1" )
CreateConVar( "sw_lightning_ignite_duration" , "3" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Time lightning will ignites hit objects." , "1" , "15" )

CreateConVar( "sw_lightning_target_prop" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning strike props?" , "0" , "1" )
CreateConVar( "sw_lightning_target_player" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning strike players?" , "0" , "1" )
CreateConVar( "sw_lightning_target_npc" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should lightning strike NPCs?" , "0" , "1" )
CreateConVar( "sw_lightning_target_world" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning will strike the world as well as targets." , "0" , "1" )
CreateConVar( "sw_lightning_target_chance" , "85" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Chance lightning will strike the ground vs. targets." , "1" , "100" )

CreateConVar( "sw_lightning_fancyfx" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Show fancy effects for lightning." , "0" , "1" )
CreateConVar( "sw_lightning_dissolve" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Lightning dissolves target on kill." , "0" , "1" )

--CreateConVar( "sw_thunder_mindelay" , "10" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Minimum delay in seconds to cause lightning/thunder while stormy." , "1" , "30" )
--CreateConVar( "sw_thunder_maxdelay" , "30" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Maximum delay in seconds to cause lightning/thunder while stormy." , "1" , "30" )

CreateClientConVar( "sw_cl_screenfx_lightning" , "1" , true, false, "(BOOL) Enable lightning flashes." , "0" , "1" )

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

CreateConVar( "sw_meteor_delay" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between meteor spawns." , "1" , "30" )
CreateConVar( "sw_meteor_delayoffset" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between meteor spawns." , "1" , "30" )
CreateConVar( "sw_meteor_lifetime" , "2" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Time for meteor shards to fade after hitting the ground. -1 for never (not recommended)." , "-1" , "30" )
CreateConVar( "sw_meteor_drag" , "10" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of drag to add to the meteors. More = slower decent." , "0" , "50" )
CreateConVar( "sw_meteor_fancyfx" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Show fancy effects for meteors." , "0" , "1" )
CreateConVar( "sw_meteor_whoosh" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Meteors play a sound before impact." , "0" , "1" )

SW.MeteorClassName = "sw_meteor"

function SW.MeteorThink()

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

		local MeteorENT = ents.Create( SW.MeteorClassName )
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

CreateClientConVar( "sw_rain_dropsize_min", "20" , true , false , "(INT) Minimum size of the raindrops on screen." , "10" , "100" )
CreateClientConVar( "sw_rain_dropsize_max", "40" , true , false , "(INT) Maximum size of the raindrops on screen." , "10" , "100" )
CreateClientConVar( "sw_rain_showimpact", "1" , true , false , "(BOOL) Make rain splash particle effect." , "0" , "1" )
CreateClientConVar( "sw_rain_showsmoke", "1" , true , false , "(BOOL) Make rain steam particle effect." , "0" , "1" )
CreateClientConVar( "sw_rain_quality", "1" , true , false , "(INT) Rain impact quality." , "1" , "4" )

CreateClientConVar( "sw_rain_height", "300" , true , false , "(INT) Maximum height to make rain." , "0" , "2500" )
CreateClientConVar( "sw_rain_radius", "500" , true , false , "(INT) Radius of rain effect." , "0" , "2500" )
CreateClientConVar( "sw_rain_count", "20" , true , false , "(INT) Amount of particles in rain effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_rain_dietime", "3" , true , false , "(INT) Time in seconds until rain vanishes." , "0" , "16" )

CreateClientConVar( "sw_storm_height", "200" , true , false , "(INT) Maximum height to make storm rain." , "0" , "2500" )
CreateClientConVar( "sw_storm_radius", "500" , true , false , "(INT) Radius of storm rain effect." , "0" , "2500" )
CreateClientConVar( "sw_storm_count", "120" , true , false , "(INT) Amount of particles in storm rain effect. Make this smaller to increase performance." , "0" , "100" )
CreateClientConVar( "sw_storm_dietime", "3" , true , false , "(INT) Time in seconds until storm vanishes." , "0" , "16" )

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

CreateConVar( "sw_smog_dmg_sound_toggle" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Toggle smog coughing sounds." , "0" , "1" )
CreateConVar( "sw_smog_dmg_delay" , "10" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay between smog damage." , "1" , "30" )
CreateConVar( "sw_smog_dmg_delayoffset" , "5" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Delay variance between smog damage." , "1" , "30" )

CreateConVar( "sw_smog_dmg_toggle" , "1" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(BOOL) Should smog cause damage?" , "0" , "1" )
CreateConVar( "sw_smog_dmg_amount" , "3" , { FCVAR_ARCHIVE, FCVAR_REPLICATED } , "(INT) Amount of damage smog does." , "1" , "100" )

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

CreateClientConVar( "sw_snow_stay", "0" , true , false , "(BOOL) Leave snow on the ground." , "0" , "1" )
CreateClientConVar( "sw_snow_height", "100" , true , false , "(INT) Maximum height to make snow." , "0" , "2500" )
CreateClientConVar( "sw_snow_radius", "400" , true , false , "(INT) Radius of snow effect." , "0" , "2500" )
CreateClientConVar( "sw_snow_count", "5" , true , false , "(INT) Amount of particles in snow effect. Make this smaller to increase performance." , "0" , "5000" )
CreateClientConVar( "sw_snow_dietime", "5" , true , false , "(INT) Time in seconds until snow vanishes." , "0" , "16" )

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
-- This is some unfinished code from the cancelled 1.36 release of SimpleWeather. 
-- Disseminate left it unfinished, and right now I'm working on improving it.
------------------------------------------------------------

-- Sticking these here for reference
-- nature/snowfloor001a
-- nature/snowwall002a

-- Replace BOTH textures with snow
SW.GroundTextures = {
	"cs_assault/pavement001a",
	-- "de_chateau/bush01a",
	"dm_stad/floor/blendgrassgrass01",
	"gm_construct/grass_13",
	"gm_construct/flatgrass",
	"gm_construct/flatgrass_2",
	"gpoint/fixedgrass/dirtfloor006a",
	"ground/skybox_ground01_blend",
	"gulch/gulch_dirtgrass",
	"gulch/gulch_sandgrass",
	"maps/rp_unioncity_day/unioncity/natural/parkgrassleaves_wvt_patch",
	"models/props_gulch/grassfloor002a",
	"nature/anzio_grass_blend002",
	"nature/blendgrassgrass001a",
	"nature/blendgrassgravel01",
	"nature/blendgravelgravel01",
	"nature/blendmilground008_2",
	"nature/blendmilground008_2_plants",
	"nature/blendmilground008b_2",
	"nature/blendsandgrass008a",
	"nature/blendsandsand008a",
	"sgtsicktextures/blend_chipsgrass_001",
	"theprotextures/blendgrassgravel002a_gmfix",
	"unioncity/natural/parkgrassleaves",
}
-- Replace ONLY $basetexture with snow
SW.GroundTexturesOne = {
	"ajacks/ajacks_grass01",
	"cs_havana/groundd01",
	"de_aztec/ground02_blend_nobump",
	"de_cbble/grassdirt_blend",
	"de_cbble/grassfloor01",
	"de_chateau/brusha",
	"de_chateau/groundd",
	"de_chateau/groundd_blend",
	"de_chateau/groundl",
	"de_dust/groundsand_blend",
	"de_dust/groundsand03",
	"de_piranesi/pi_ground",
	"de_piranesi/pi_ground_blend",
	"de_train/blendgrassdirt001a",
	"dm_stad/floor/grass03",
	"freespace/terrain/freespace_dirtgravelblend01",
	"freespace/terrain/freespace_dirtrockblend01",
	"freespace/terrain/freespace_grassdirtblend01",
	"freespace/terrain/freespace_grassrockblend01",
	"freespace/terrain/freespace_skyboxterrainblend01",
	"gm_construct/grass-sand_13",
	"gm_vernrock/blends/blendgrassdirt001",
	"gm_vernrock/blends/blendgrassmud001",
	"ground/flash_ground_blend",
	"ground/flash_ground_skyboxtrees",
	"ground/hr_g/hr_gravel_grass_001_blend",
	"gulch/gulch_rockgrass",
	"gulch/gulch_rocksand",
	"lostcoast/nature/blendrockgravel002a",
	"maps/de_aztec/de_aztec/ground01_blend_-272_-960_-151",
	"maps/de_aztec/de_aztec/ground01_blend_-2689_259_-247",
	"maps/de_aztec/de_aztec/ground01_blend_-2705_-776_-161",
	"maps/de_aztec/de_aztec/ground02_blend_-272_-960_-151",
	"maps/de_aztec/de_aztec/ground02_blend_-424_-1484_-157",
	"maps/de_aztec/de_aztec/ground02_blend_-976_699_-119",
	"maps/dod_jagd/stone/blendcobblegrass002a_-2280_-392_-328",
	"maps/dod_jagd/stone/blendcobblegrass002a_496_-2176_-368",
	"maps/dod_jagd/stone/blendcobblegrass002a_2040_-872_-288",
	"maps/gs_camp_killpact_v1/freespace/terrain/freespace_grassdirtblend01_wvt_patch",
	"maps/gs_camp_killpact_v1/freespace/terrain/freespace_grassrockblend01_wvt_patch",
	"maps/rp_truenorth_v1a/statua/nature/blendgrassdirt01_wvt_patch",
	"models/statua/shared/blendgrassdirt01",
	"nature/argentan_blendcobblegrass",
	"nature/argentan_blendgrassdirt",
	"nature/argentan_blendgrassdirt_cheap",
	"nature/argentan_skygrasstrees",
	"nature/blendcobblegrass002",
	"nature/blendgrassdirt01",
	"nature/blendgrassdirt01_noprop",
	"nature/blendgrassdirt02",
	"nature/blendgrassdirt03",
	"nature/blendgrassgravel001a",
	"nature/blendgrassgravel001b",
	"nature/blendgrassgravel002b",
	"nature/blendgrassmud01",
	"nature/blendgrasspave01",
	"nature/blendgravelconc01",
	"nature/blendgravelgravel02",
	"nature/blendgravelmud01",
	"nature/blendgravelmud02",
	"nature/blendmilground008_4",
	"nature/blendmilground008_8b",
	"nature/dirtfloor006a",
	"nature/forest_grass_01",
	"nature/grassfloor001a",
	"nature/grassfloor002a",
	"nature/grassfloor003a",
	"nature/infblendgrassdirt001a",
	"nature/milground002",
	"rubble/blendrubblegrass001b_avalanche",
	"statua/nature/blendforest_01",
	"statua/nature/blendforest_02",
	"statua/nature/blendgrassdirt01",
	"statua/nature/blendgrasssand01",
	"statua/nature/farmblend1",
	"statua/nature/farmblend2",
	"statua/nature/farmblend3",
	"statua/nature/farmblend4",
	"statua/nature/rockfordgrass2_noprop",
	"trakpak/terrain/blendgrassballast",
	"unioncity2/floors/grass",
	"unioncity2/floors/parkcobbles",
}
-- Replace ONLY $basetexture2 with snow
SW.GroundTexturesTwo = {
	"de_chateau/rockf_blend",
	"de_dust/rockwall_blend",
	"de_nuke/nukblenddirtgrass",
	"de_nuke/nukblenddirtgrassb",
	"de_tides/blendgrassstonepath",
	"dm_stad/floor/blendgrassdirt02",
	"dm_stad/floor/blendgrassforest01",
	"fork/cliff04c",
	"fork/cliff04c_skybox",
	"gulch/gulch_cavegrass",
	"gulch/gulch_cavesand",
	"gulch/gulch_cavewall" ,
	"lostcoast/nature/blendpathweeds002a",
	"lostcoast/nature/blendstonepathweeds001a",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1824_-8_-328",
	"maps/dod_jagd/stone/blendcobbledirt002a_-2184_0_-328",
	"maps/dod_jagd/stone/blendcobbledirt002a_-312_-72_-232",
	"maps/dod_jagd/stone/blendcobbledirt002a_-464_-1088_-296",
	"maps/dod_jagd/stone/blendcobbledirt002a_-88_56_-232",
	"maps/dod_jagd/stone/blendcobbledirt002a_320_72_-232",
	"maps/dod_jagd/stone/blendcobbledirt002a_664_32_-232",
	"maps/dod_jagd/stone/blendcobbledirt002a_704_-352_-248",
	"maps/dod_jagd/stone/blendcobbledirt002a_720_-760_-248",
	"maps/dod_jagd/stone/blendcobbledirt002a_1008_-1176_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_1248_-1264_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_864_-992_-304",
	"maps/dod_jagd/stone/blendcobbledirt002a_-384_-1848_-336",
	"maps/dod_jagd/stone/blendcobbledirt002a_-768_-2048_-336",
	"maps/dod_jagd/stone/blendcobbledirt002a_-384_-2128_-336",
	"maps/dod_jagd/stone/blendcobbledirt002a_56_-2160_-368",
	"maps/dod_jagd/stone/blendcobbledirt002a_1280_-2032_-368",
	"maps/dod_jagd/stone/blendcobbledirt002a_1712_-576_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_1384_-384_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_1344_-96_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_1992_-320_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_1400_528_-288",
	"maps/dod_jagd/stone/blendcobbledirt002a_1384_912_-216",
	"maps/dod_jagd/stone/blendcobbledirt002a_1376_1208_-216",
	"maps/dod_jagd/stone/blendcobbledirt002a_1168_1216_-216",
	"maps/dod_jagd/stone/blendcobbledirt002a_1168_1440_-216",
	"maps/dod_jagd/stone/blendcobbledirt002a_1152_1712_-216",
	"maps/dod_jagd/stone/blendcobbledirt002a_864_1544_-216",
	"maps/dod_jagd/stone/blendcobbledirt002a_464_1704_-248",
	"maps/dod_jagd/stone/blendcobbledirt002a_128_1728_-248",
	"maps/dod_jagd/stone/blendcobbledirt002a_208_1144_-248",
	"maps/dod_jagd/stone/blendcobbledirt002a_680_640_-232",
	"maps/dod_jagd/stone/blendcobbledirt002a_184_856_-248",
	"maps/dod_jagd/stone/blendcobbledirt002a_-24_832_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-256_944_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-608_816_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-976_656_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1056_992_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-976_656_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-976_384_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-496_1024_-280",
	"maps/dod_jagd/stone/blendcobbledirt002a_-2280_-392_-328",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1280_-32_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1088_-272_-312",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1464_-684_-276",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1448_-752_-160",
	"maps/dod_jagd/stone/blendcobbledirt002a_-1072_80_-312",
	"maps/dod_jagd/stone/blendstonedirt001a_336_-1824_-336",
	"maps/dod_jagd/stone/blendstonedirt001a_1656_-1120_-288",
	"nature/anzio_skytrees",
	"nature/argentan_blendcliffgrass",
	"nature/blendcobbledirt001",
	"nature/blenddirtgrass008a",
	"nature/blenddirtgrass008b",
	"nature/blenddirtgrass008b_lowfriction",
	"nature/blenddirtgravel01",
	"nature/blendgrassgravel001c",
	"nature/blendgrassgravel003a",
	"nature/blendgravelgravel02b",
	"nature/blendmilground004_2",
	"nature/blendmilground005_2",
	"nature/blendmilground011_2",
	"nature/blendmilrock002_ground002",
	"nature/blendprodconcgrass",
	"nature/blendproddirtgrass",
	"nature/blendsandsand008b",
	"nature/blendsandsand008b_antlion",
	"nature/grass_whitemosspebbles_blend",
	"nature/red_grass",
	"nature/short_red_grass",
	"statua/nature/rockfordgrass1",
	"textures/enviroment/blendgrassgravel1",
	"textures/enviroment/blendsandgrass1",
	"unioncity/floorground/parkcobbles",
	"unioncity2/floors/parkdirttograss",
}

-- Replace BOTH textures with a cliff
SW.CliffTextures = {
}

-- Replace ONLY $basetexture with cliff
SW.CliffTexturesOne = {
	-- "gulch/gulch_rockwall",
	-- "models/props_gulch/gulch_rockwall",
}

-- Replace ONLY $basetexture2 with cliff
SW.CliffTexturesTwo = {
}

-- The reset table. Don't fucking touch!
SW.TextureResets = { }

function SW.ResetGroundTextures()
	
	for k, v in pairs( SW.TextureResets ) do
		
		local m = Material( k )
		if( v[1] ) then
			m:SetTexture( "$basetexture", v[1] )
			-- m:SetTexture( "$bumpmap", v[1] )
		end
		if( v[2] ) then
			m:SetTexture( "$basetexture2", v[2] )
			-- m:SetTexture( "$bumpmap2", v[2] )
		end
		
	end
	
end

-- function SW.CheckSnowTexture( mat, mattype, norm )

	-- if( norm:Dot( Vector( 0, 0, 1 ) ) < 0.99 ) then return end

	-- SW.SetGroundTextures()
	
-- end

function SW.SetGroundTextures()

	-- if( true ) then return end -- not working too well

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
		
		m:SetTexture( "$basetexture", "realworldtextures/newer/0/snow_0_01" );
		m:SetTexture( "$basetexture2", "realworldtextures/newer/0/snow_0_01" );

	end

	for k, v in pairs( SW.GroundTexturesOne ) do

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
		
		m:SetTexture( "$basetexture", "realworldtextures/newer/0/snow_0_01" );

	end

	for k, v in pairs( SW.GroundTexturesTwo ) do

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

		m:SetTexture( "$basetexture2", "realworldtextures/newer/0/snow_0_01" );

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
		
		m:SetTexture( "$basetexture", "cncr04s/rock/stonewall1snow" );
		m:SetTexture( "$basetexture2", "cncr04s/rock/stonewall1snow" );

	end

	for k, v in pairs( SW.CliffTexturesOne ) do

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
		
		m:SetTexture( "$basetexture", "cncr04s/rock/stonewall1snow" );
		m:SetTexture( "$basetexture2", "realworldtextures/newer/0/snow_0_01" );

	end

	for k, v in pairs( SW.CliffTexturesTwo ) do

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
		
		m:SetTexture( "$basetexture", "realworldtextures/newer/0/snow_0_01" );
		m:SetTexture( "$basetexture2", "cncr04s/rock/stonewall1snow" );

	end

	if string.lower( game.GetMap() ) == "de_train" then

		local materialSwap = {
			"de_train/blendgraveldirt001a",
		}

		for k, v in pairs( materialSwap ) do

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

			m:SetTexture( "$basetexture", "realworldtextures/newer/0/snow_0_01" )
			-- m:SetTexture( "$basetexture2", m2 );

			materialSwap = {}

		end

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
