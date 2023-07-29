AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

function ENT:Initialize()
	
	self:SetModel( "models/nomad/asteroid0" .. math.random( 1, 8 ) .. ".mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetMoveType( MOVETYPE_VPHYSICS );
	self:SetSolid( SOLID_VPHYSICS );
	
	self.DieTime = CurTime() + 60; -- No meteor should last longer than this!!
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
		phys:AddAngleVelocity( Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -100, 100 ) ) );
		phys:SetDragCoefficient( 30 );
		
	else -- Why does this happen? They should never spawn in the skybox...
		
		self:Remove();
		
	end
	
end

function ENT:SpawnFunction( ply, tr, class )
	
	local trace = { };
	trace.start = tr.HitPos;
	trace.endpos = trace.start + Vector( 0, 0, 32768 );
	trace.mask = MASK_PLAYERSOLID_BRUSHONLY;
	local tr = util.TraceLine( trace );
	
	local ent = ents.Create( class );
	ent:SetPos( tr.HitPos );
	ent:Spawn();
	ent:Activate();
	
	return ent;
	
end

function ENT:PhysicsCollide( data, phys )
	
	local trace = { };
	trace.start = data.HitPos;
	trace.endpos = trace.start - data.HitNormal;
	trace.filter = self;
	local tr = util.TraceLine( trace );
	
	if( tr.HitSky ) then return end
	
	if( data.DeltaTime > 0.2 ) then
		
		if( data.Speed > 100 ) then
			
			self:EmitSound( Sound( "physics/concrete/boulder_impact_hard" .. math.random( 1, 4 ) .. ".wav" ), 100, math.random( 90, 110 ), 0.6 );
			
			util.ScreenShake( data.HitPos, data.Speed / 100, 100, 1, data.Speed * 3 );
			
		end
		
	end
	
	if( self:GetDieTime() <= 0 and SW.MeteorFadeTime > -1 ) then
		
		self:SetDieTime( CurTime() + SW.MeteorFadeTime );
		
		local ed = EffectData();
		ed:SetStart( data.HitPos );
		util.Effect( "sw_meteorimpact", ed );
		
	end
	
end

function ENT:Think()
	
	if( self:GetDieTime() > 0 and CurTime() >= self:GetDieTime() ) then
		
		self:Remove();
		
	end
	
	if( CurTime() >= self.DieTime ) then
		
		self:Remove();
		
	end
	
	if( SW.MeteorWhoosh and !self.PlayedWhoosh and self:GetDieTime() <= 0 ) then
		
		local trace = { };
		trace.start = self:GetPos();
		trace.endpos = trace.start + Vector( 0, 0, -32768 );
		trace.filter = self;
		local tr = util.TraceEntity( trace, self );
		
		local dist = self:GetPos().z - tr.HitPos.z;
		
		local vz = -self:GetPhysicsObject():GetVelocity().z;
		
		if( dist / vz < 1.25 ) then
			
			self.PlayedWhoosh = true;
			self:EmitSound( Sound( "weapons/mortar/mortar_shell_incomming1.wav" ), 100, math.random( 90, 110 ), 0.5 );
			
		else
			
			self:NextThink( CurTime() + 0.05 );
			return true;
			
		end
		
	end
	
end