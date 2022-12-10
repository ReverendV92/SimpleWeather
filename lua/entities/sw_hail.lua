
AddCSLuaFile( )

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Hail"
ENT.Author = "V92"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

ENT.Category = "SimpleWeather"

ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize( )

	if CLIENT then return false end

	-- self:SetModel( "models/props_phx/misc/egg.mdl" )
	self:SetModel( "models/props_junk/rock001a.mdl" )
	self:SetMaterial( "xeon133/slider_12x12x96" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DrawShadow( false )
	self:PrecacheGibs( )
	Gibbed = false

	self.DieTime = CurTime() + 60 -- No Hail should last longer than this!!

	local phys = self:GetPhysicsObject( )

	if( phys and phys:IsValid( ) ) then

		phys:Wake( )

		phys:AddAngleVelocity( Vector( math.random( -150, 150 ), math.random( -150, 150 ), math.random( -150, 150 ) ) )
		phys:SetDragCoefficient( GetConVarNumber("sw_hail_drag") )

	else -- Why does this happen? They should never spawn in the skybox...

		SafeRemoveEntity( self )

	end

end

if CLIENT then

	language.Add( "sw_hail", "Hail" )

	function ENT:Draw( )

		local mul = 1

		if ( self:GetDieTime( ) > 0 ) then

			local d = CurTime() - self:GetDieTime( )

			if ( d < 1 ) then

				mul = 1 - d

			end

		end

		render.SetBlend( mul )
			self:DrawModel( )
		render.SetBlend( 1 )

	end

end

function ENT:OnRemove( )

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

			self:EmitSound( Sound( "physics/concrete/concrete_impact_soft" .. math.random( 1 , 3 ) .. ".wav" ) , 100 , math.random( 90 , 110 ) , 0.6 )

		end

	end

	-- self:GibBreakClient( Vector( 50 , 50 , 50 ) )
	timer.Simple( 3 , function( ) SafeRemoveEntity( self ) end )

end

function ENT:Think( )

	if not SERVER then return false end

	if ( self:GetDieTime( ) > 0 and CurTime() >= self:GetDieTime( ) ) then

		SafeRemoveEntity( self )

	end

	if ( CurTime() >= self.DieTime ) then

		SafeRemoveEntity( self )

	end

end
