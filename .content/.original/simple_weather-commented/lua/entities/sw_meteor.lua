
AddCSLuaFile( )

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Meteor"
ENT.Author = "disseminate"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

ENT.Category = "SimpleWeather"

ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize( )

	if CLIENT then return false end

	self:SetModel( "models/simpleweather/meteor/asteroid_0" .. math.random( 1, 8 ) .. ".mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( true )
	self:PrecacheGibs( )
	Gibbed = false

	self.DieTime = CurTime( ) + 60 -- No meteor should last longer than this!!

	local phys = self:GetPhysicsObject( )

	if( phys and phys:IsValid( ) ) then

		phys:Wake( )

		phys:AddAngleVelocity( Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -100, 100 ) ) )
		phys:SetDragCoefficient( 10 )

	else -- Why does this happen? They should never spawn in the skybox...

		SafeRemoveEntity( self )

	end

end

if CLIENT then

	language.Add( "sw_meteor", "Meteor" )

	function ENT:Draw( )
		
		local mul = 1
		
		if ( self:GetDieTime( ) > 0 ) then
			
			local d = CurTime( ) - self:GetDieTime( )
			
			if ( d < 1 ) then
				
				mul = 1 - d
				
			end
			
		end
		
		render.SetBlend( mul )
			self:DrawModel( )
		render.SetBlend( 1 )
		
		if ( !self.Emitter and self:GetDieTime( ) <= 0 ) then
			
			self.Emitter = ParticleEmitter( self:GetPos( ) , false )
			
		end
		
		if ( self.Emitter ) then
			
			if ( self:GetDieTime( ) <= 0 ) then
				
				local v , t , s , cv , p
				
				for i = 1 , 2 do
					
					v = self:GetPos( )
					
					t = math.Rand( -math.pi , math.pi )
					s = math.Rand( -math.pi , math.pi )
					cv = Vector( math.sin( t ) * math.cos( s ) , math.sin( t ) * math.sin( s ) , math.cos( t ) )
					
					v = v + cv * 150
					
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
						p:SetStartSize( 90 )
						
					end
					
				end
				
				v = self:GetPos( )
				
				t = math.Rand( -math.pi, math.pi )
				s = math.Rand( -math.pi, math.pi )
				cv = Vector( math.sin( t ) * math.cos( s ), math.sin( t ) * math.sin( s ), math.cos( t ) )
				
				v = v + cv * 150
				
				local p = self.Emitter:Add( "simpleweather/rainsmoke", v )
				
				if( p ) then
					
					p:SetAngles( Angle( math.random( -180, 180 ), math.random( -180, 180 ), math.random( -180, 180 ) ) )
					p:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) ) )
					p:SetCollide( false )
					p:SetColor( 255, 255, 255 )
					p:SetDieTime( 2 )
					p:SetEndAlpha( 0 )
					p:SetEndSize( 0 )
					p:SetLifeTime( 0 )
					p:SetRoll( math.Rand( -math.pi, math.pi ) )
					p:SetRollDelta( math.Rand( -math.pi, math.pi ) )
					p:SetStartAlpha( 255 )
					p:SetStartSize( 100 )
					
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

		if( self.Emitter ) then
		
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

	if not SERVER then return false end

	local trace = { }
	trace.start = data.HitPos
	trace.endpos = trace.start - data.HitNormal
	trace.filter = self
	local tr = util.TraceLine( trace )

	if ( tr.HitSky ) then return end

	if ( data.DeltaTime > 0.2 ) then

		if( data.Speed > 100 ) then

			self:EmitSound( Sound( "physics/concrete/boulder_impact_hard" .. math.random( 1 , 4 ) .. ".wav" ) , 100 , math.random( 90 , 110 ) , 0.6 )

			util.ScreenShake( data.HitPos , data.Speed / 100 , 100 , 1 , data.Speed * 3 )

		end

	end

	if ( self:GetDieTime( ) <= 0 and SW.MeteorFadeTime > -1 ) then

		self:SetDieTime( CurTime( ) + SW.MeteorFadeTime )

		local ed = EffectData( )
		ed:SetStart( data.HitPos )
		util.Effect( "sw_meteorimpact" , ed )

		local explo = ents.Create( "env_explosion" )
		explo:SetOwner( self:GetOwner( ) )
		explo:SetPos( self:GetPos( ) )
		explo:SetKeyValue( "iMagnitude" , "100" )
		explo:Spawn( )
		explo:Activate( )
		explo:Fire( "Explode" , "" , 0 )

	end

	self:GibBreakClient( Vector( 50 , 50 , 50 ) )
	timer.Simple( 0.1 , function( ) SafeRemoveEntity( self ) end )

end

function ENT:Think( )

	if not SERVER then return false end

	if ( self:GetDieTime( ) > 0 and CurTime( ) >= self:GetDieTime( ) ) then

		SafeRemoveEntity( self )

	end

	if ( CurTime( ) >= self.DieTime ) then

		SafeRemoveEntity( self )

	end

	if( SW.MeteorWhoosh and !self.PlayedWhoosh and self:GetDieTime() <= 0 ) then

		local trace = { }
		trace.start = self:GetPos()
		trace.endpos = trace.start + Vector( 0, 0, -32768 )
		trace.filter = self
		local tr = util.TraceEntity( trace, self )

		local dist = self:GetPos().z - tr.HitPos.z

		local vz = -self:GetPhysicsObject():GetVelocity().z

		if( dist / vz < 1.25 ) then

			self.PlayedWhoosh = true
			self:EmitSound( Sound( "weapons/mortar/mortar_shell_incomming1.wav" ), 100, math.random( 90, 110 ), 0.5 )

		else

			self:NextThink( CurTime( ) + 0.05 )
			return true

		end


	end

end
