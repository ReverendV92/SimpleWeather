
AddCSLuaFile( )

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Meteor"
ENT.Author = "disseminate/V92"
ENT.Contact = "Steam"
ENT.Purpose = ""
ENT.Instructions = ""

ENT.Category = "SimpleWeather"

ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize( )

	if CLIENT then

		return false 

	end

	self:SetModel( "models/props_junk/rock001a.mdl" )
	self:SetMaterial( "xeon133/slider_12x12x96" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( false )
	-- self:PrecacheGibs( )
	-- Gibbed = false

	self.DieTime = CurTime() + 8 -- No meteor should last longer than this!!

	local phys = self:GetPhysicsObject( )

	if phys and phys:IsValid( ) then

		phys:Wake( )
		phys:EnableDrag( false )
		phys:AddVelocity( Vector( math.random( -100 , 100 ), math.random( -100 , 100 ), math.random( -1 , 1 ) ) )
		phys:AddAngleVelocity( Vector( math.random( -100 , 100 ), math.random( -100 , 100 ), math.random( -150 , -50 ) ) )

	else -- Why does this happen? They should never spawn in the skybox...

		SafeRemoveEntity( self )

	end

end

if CLIENT then

	language.Add( "sw_meteor_small", "Meteor" )

	function ENT:Draw( )

		local mul = 1

		if self:GetDieTime( ) > 0 then

			local d = CurTime() - self:GetDieTime( )

			if ( d < 1 ) then

				mul = 1 - d

			end

		end

		render.SetBlend( mul )
			self:DrawModel( )
		render.SetBlend( 1 )

		if !self.Emitter and self:GetDieTime( ) <= 0 then

			self.Emitter = ParticleEmitter( self:GetPos( ) , false )

		end

		if self.Emitter then

			if self:GetDieTime( ) <= 0 then

				local v , t , s , cv , p

				for i = 1 , 2 do

					v = self:GetPos( )

					t = math.Rand( -math.pi , math.pi )
					s = math.Rand( -math.pi , math.pi )
					cv = Vector( math.sin( t ) * math.cos( s ) , math.sin( t ) * math.sin( s ) , math.cos( t ) )

					v = v + cv * 1

					p = self.Emitter:Add( "simpleweather/flamelet" .. math.random( 1 , 5 ) , v )

					if ( p ) then

						p:SetAngles( Angle( math.random( -180 , 180 ) , math.random( -180 , 180 ) , math.random( -180 , 180 ) ) )
						p:SetAngleVelocity( Angle( math.Rand( -5 , 5 ) , math.Rand( -5 , 5 ) , math.Rand( -5 , 5 ) ) )
						p:SetCollide( false )
						p:SetColor( 255 , 255 , 255 )
						p:SetDieTime( 2 )
						p:SetEndAlpha( 0 )
						p:SetEndSize( 0 )
						p:SetLifeTime( 0 )
						p:SetRoll( math.Rand( -math.pi , math.pi ) )
						p:SetRollDelta( math.Rand( -math.pi , math.pi ) )
						p:SetStartAlpha( 255 )
						p:SetStartSize( 15 )

					end

				end

				v = self:GetPos( )

				t = math.Rand( -math.pi, math.pi )
				s = math.Rand( -math.pi, math.pi )
				cv = Vector( math.sin( t ) * math.cos( s ), math.sin( t ) * math.sin( s ), math.cos( t ) )

				v = v + cv * 1

				local p = self.Emitter:Add( "simpleweather/rainsmoke", v )

				if p then

					p:SetAngles( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) )
					p:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) ) )
					p:SetCollide( false )
					p:SetColor( 255, 255, 255 )
					p:SetDieTime( 0 )
					p:SetEndAlpha( 0 )
					p:SetEndSize( 0 )
					p:SetLifeTime( 0 )
					p:SetRoll( math.Rand( -math.pi, math.pi ) )
					p:SetRollDelta( math.Rand( -math.pi, math.pi ) )
					p:SetStartAlpha( 255 )
					p:SetStartSize( 5 )

				end

			else

				self.Emitter:Finish()
				self.Emitter = nil

			end

		end

	end

end

function ENT:OnRemove( )

	if CLIENT then

		if self.Emitter then

			self.Emitter:Finish( )

		end

	end

end

function ENT:SetupDataTables( )

	self:NetworkVar( "Float" , 0 , "DieTime" )

end

function ENT:SpawnFunction( ply, tr, class )

	local trace = { }
	trace.start = tr.HitPos
	trace.endpos = trace.start + Vector( 0 , 0 , 32768 )
	trace.mask = MASK_PLAYERSOLID_BRUSHONLY
	local tr = util.TraceLine( trace )

	local ent = ents.Create( class )
	ent:SetPos( tr.HitPos )
	ent:Spawn( )
	ent:Activate( )

	return ent

end

function ENT:PhysicsCollide( data, phys )

	if CLIENT then 

		return false 

	end

	local trace = { }
	trace.start = data.HitPos
	trace.endpos = trace.start - data.HitNormal
	trace.filter = self
	local tr = util.TraceLine( trace )

	if tr.HitSky then 

		return 

	end

	if ( data.DeltaTime > 0.2 ) then

		if( data.Speed > 100 ) then

			self:EmitSound( Sound( "physics/concrete/rock_impact_soft" .. math.random( 1 , 3 ) .. ".wav" ) , 100 , math.random( 90 , 110 ) , 0.6 )

			-- util.ScreenShake( data.HitPos , data.Speed / 100 , 100 , 1 , data.Speed * 3 )

		end

	end

	if self:GetDieTime( ) <= 0 and GetConVarNumber("sw_meteor_lifetime") > -1 and GetConVarNumber("sw_meteor_fancyfx") == 1 then

		self:SetDieTime( CurTime() + GetConVarNumber("sw_meteor_lifetime") )

		local ed = EffectData( )
		ed:SetStart( data.HitPos )
		util.Effect( "sw_meteorimpact_small" , ed )

		local MeteorFXExplosion = ents.Create("env_explosion")
		MeteorFXExplosion:SetOwner( self:GetOwner( ) )
		MeteorFXExplosion:SetPos( tr.HitPos )
		MeteorFXExplosion:SetKeyValue( "imagnitude" , "32" )
		MeteorFXExplosion:SetKeyValue( "spawnflags" , "5077" )
		MeteorFXExplosion:SetKeyValue( "rendermode" , "5" )
		MeteorFXExplosion:Spawn()
		MeteorFXExplosion:Activate( )
		MeteorFXExplosion:Fire( "explode" , "" , 0 )

		local physboom = ents.Create("env_physexplosion")
		physboom:SetPos( tr.HitPos )
		physboom:SetKeyValue( "magnitude" , "32" )
		physboom:SetKeyValue( "spawnflags" , "22" )
		physboom:Spawn()
		physboom:Activate()
		physboom:Fire( "explodeandremove" , "" , 0 )
		physboom:Fire( "kill" , "" , 5 )

		-- self:EmitSound( Sound("weapons/mortar/mortar_explode" .. math.random( 1 , 3 ) .. ".wav") , 140 , math.random( 90 , 110 ) , 1 , CHAN_BODY )

		-- Not that great. Redo?
		-- self:GibBreakClient( Vector( 50 , 50 , 50 ) )

		local craterENT = ents.Create("prop_dynamic")
		craterENT:SetPos( tr.HitPos )
		craterENT:SetModel( Model("models/simpleweather/crater.mdl") )
		craterENT:SetModelScale( 0.2 )
		craterENT:SetColor( Color( 75 , 75 , 75 ) )
		craterENT:DrawShadow( false )
		craterENT:Spawn()
		craterENT:Activate()

		timer.Simple( 5 , function()

			if IsValid( craterENT ) then craterENT:Remove() end

		end)

	end

	timer.Simple( 0.1 , function( ) 

		SafeRemoveEntity( self ) 

	end )

end

function ENT:Think( )

	if CLIENT then 

		return false 

	end

	if self:GetDieTime( ) > 0 and CurTime() >= self:GetDieTime( ) then

		SafeRemoveEntity( self )

	end

	if CurTime() >= self.DieTime then

		SafeRemoveEntity( self )

	end

	-- if GetConVarNumber("sw_meteor_whoosh") != 0 and !self.PlayedWhoosh and self:GetDieTime() <= 0 then

		-- local trace = { }
		-- trace.start = self:GetPos()
		-- trace.endpos = trace.start + Vector( 0, 0, -32768 )
		-- trace.filter = self
		-- local tr = util.TraceEntity( trace, self )

		-- local dist = self:GetPos().z - tr.HitPos.z

		-- local vz = -self:GetPhysicsObject():GetVelocity().z

		-- if( dist / vz < 1.25 ) then

			-- self.PlayedWhoosh = true
			-- self:EmitSound( Sound( "weapons/mortar/mortar_shell_incomming1.wav" ) , 100 , math.random( 90 , 110 ) , 0.5 )

		-- else

			-- self:NextThink( CurTime() + 0.05 )
			-- return true

		-- end


	-- end

end
