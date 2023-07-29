
AddCSLuaFile()

if CLIENT then
	
	include( "simpleweather/cl_init.lua" )
	
end

if SERVER then
	
	include( "simpleweather/sv_init.lua" )

	resource.AddWorkshop( 531458635 ) -- Add Simple Weather https://steamcommunity.com/sharedfiles/filedetails/?id=531458635
	

end
