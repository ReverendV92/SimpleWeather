if( CLIENT ) then
	
	include( "simpleweather/cl_init.lua" );
	
else
	
	AddCSLuaFile();
	include( "simpleweather/sv_init.lua" );
	
end
