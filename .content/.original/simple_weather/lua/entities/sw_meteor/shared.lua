ENT.Type = "anim";
ENT.Base = "base_anim";

ENT.PrintName		= "Meteor";
ENT.Author			= "disseminate";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Category 		= "SimpleWeather";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

function ENT:SetupDataTables()
	
	self:NetworkVar( "Float", 0, "DieTime" );
	
end
