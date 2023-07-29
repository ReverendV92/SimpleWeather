SW = SW or { }

function SW.LoadWeathers()
	
	if( !SW.Weathers ) then
		SW.Weathers = { }
	end
	
	if( CLIENT and !SW.ConVars ) then
		
		SW.ConVars = { }
		
	end
	
	local tab = file.Find( "simpleweather/weather/*.lua", "LUA" )
	
	for _, v in pairs( tab ) do

		WEATHER = { }

		include( "simpleweather/weather/" .. v )

		SW.Weathers[WEATHER.ID] = WEATHER

		if( CLIENT and WEATHER.ConVar ) then

			CreateClientConVar( WEATHER.ConVar[1], "1" )
			table.insert( SW.ConVars, table.Copy( WEATHER.ConVar ) )

		end

		WEATHER = nil
		
	end
	
end

function SW.GetCurrentWeather()
	
	if( !SW.Weathers ) then
		SW.Weathers = { }
	end
	
	if( !SW.Weathers[SW.WeatherMode] ) then
		return { }
	end
	
	return SW.Weathers[SW.WeatherMode]
	
end

function SW.Initialize()
	
	SW.LoadWeathers()
	
end
hook.Add( "Initialize", "SW.Initialize", SW.Initialize )

include( "cl_clock.lua" )
include( "cl_daynight.lua" )
include( "cl_texture.lua" )
include( "simpleweather_config.lua" )
include( "sh_admin.lua" )

SW.WeatherMode = ""
SW.CurrentParticles = 0

local function nSetWeather()
	
	SW.WeatherMode = net.ReadString()
	
end
net.Receive( "SW.nSetWeather", nSetWeather )

local function nRedownloadLightmaps()
	
	render.RedownloadAllLightmaps()
	
end
net.Receive( "SW.nRedownloadLightmaps", nRedownloadLightmaps )

SW.NextLightning = 0
SW.ViewPos = Vector()
SW.ViewAng = Angle()
SW.SkyboxVisible = false
SW.IsOutsideFrame = false

if( SW.Emitter2D ) then
	
	SW.Emitter2D:Finish()
	
end

if( SW.Emitter3D ) then
	
	SW.Emitter3D:Finish()
	
end

SW.Emitter2D = nil
SW.Emitter3D = nil

function SW.Think()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		if( LocalPlayer():GetViewEntity() == LocalPlayer() ) then
			
			local s = hook.Call( "CalcView", GAMEMODE, LocalPlayer(), LocalPlayer():EyePos(), LocalPlayer():EyeAngles(), 75 )
			if( s and s.origin and s.angles ) then
				
				SW.ViewPos = s.origin
				SW.ViewAng = s.angles
				
			end
			
		else
			
			SW.ViewPos = LocalPlayer():GetViewEntity():GetPos()
			SW.ViewAng = LocalPlayer():GetViewEntity():GetAngles()
			
		end
		
		if( !SW.ViewPos or !SW.ViewAng ) then
			
			SW.ViewPos = LocalPlayer():EyePos()
			SW.ViewAng = LocalPlayer():EyeAngles()
			
		end
		
		SW.SkyboxVisible = util.IsSkyboxVisibleFromPoint( SW.ViewPos )
		SW.IsOutsideFrame = SW.IsOutside( SW.ViewPos )
		
		if( SW.WeatherMode == "" ) then
			
			if( SW.Emitter2D ) then
				
				SW.Emitter2D:Finish()
				SW.Emitter2D = nil
				
			end
			
			if( SW.Emitter3D ) then
				
				SW.Emitter3D:Finish()
				SW.Emitter3D = nil
				
			end
			
		else
			
			if( !SW.Emitter2D ) then
				
				SW.Emitter2D = ParticleEmitter( SW.ViewPos )
				
			else
				
				SW.Emitter2D:SetPos( SW.ViewPos )
				
			end
			
			if( !SW.Emitter3D ) then
				
				SW.Emitter3D = ParticleEmitter( SW.ViewPos, true )
				
			else
				
				SW.Emitter3D:SetPos( SW.ViewPos )
				
			end
			
		end
		
		if( SW.Emitter2D and SW.Emitter3D ) then
			
			if( !SW.SkyboxVisible ) then
				
				SW.Emitter2D:SetNoDraw( true )
				
			else
				
				SW.Emitter2D:SetNoDraw( false )
				
			end
			
		end
		
		if( SW.GetCurrentWeather().Think ) then
			
			SW.GetCurrentWeather():Think()
			
		end
		
		if( SW.GetCurrentWeather().Lightning ) then
			
			if( CurTime() >= SW.NextLightning ) then
				
				if( SW.IsOutsideFrame and bit.band( util.PointContents( SW.ViewPos ), CONTENTS_WATER ) != CONTENTS_WATER ) then
					
					SW.Lightning( 0.8, 0.3 )
					
				else
					
					if( SW.SkyboxVisible ) then
						
						SW.Lightning( 0.3, 0.05 )
						
					else
						
						SW.Lightning( 0.5, 0, true )
						
					end
					
				end
				
				-- SW.NextLightning = CurTime() + math.random( SW.ThunderMinDelay, SW.ThunderMaxDelay )
				SW.NextLightning = CurTime() + math.random( GetConVarNumber("sw_sv_thunder_mindelay") , GetConVarNumber("sw_sv_thunder_maxdelay") )
				
			end
			
		end
		
		SW.SoundThink()
		SW.DayNightThink()
		
	end
	
end
hook.Add( "Think", "SW.Think", SW.Think )

SW.Sound = nil

SW.HeightMin = 0

function SW.IsOutside( pos )
	
	local trace = { }
	trace.start = pos
	trace.endpos = trace.start + Vector( 0, 0, 32768 )
	trace.mask = MASK_VISIBLE
	local tr = util.TraceLine( trace )
	
	SW.HeightMin = ( tr.HitPos - trace.start ):Length()
	
	-- if( SW.AlwaysOutside ) then return true end
	if GetConVarNumber("sw_sv_alwaysoutside") == 1 then return true end
	
	if( tr.StartSolid ) then return false end
	if( tr.HitSky or tr.HitNoDraw ) then return true end
	
	return false
	
end

function SW.RainSoundThink()
	
	if( GetConVarNumber( "sw_cl_sounds" ) == 0 ) then
		
		if( SW.Sound and SW.SoundVolume != 0 ) then
			
			SW.Sound:ChangeVolume( 0, 1 )
			SW.SoundVolume = 0
			
		end
		
		return
		
	end
	
	if( !SW.Sound ) then
		
		SW.Sound = CreateSound( LocalPlayer(), "simpleweather/rain.wav" )
		SW.Sound:SetSoundLevel( 160 )
		SW.Sound:PlayEx( 0, 100 )
		
	end
	
	if( SW.IsOutsideFrame and SW.SoundVolume != 0.3 ) then
		
		-- SW.Sound:ChangeVolume( 0.3 * SW.VolumeMultiplier, 1 )
		SW.Sound:ChangeVolume( 0.3 * GetConVarNumber("sw_cl_fxvolume"), 1 )
		SW.SoundVolume = 0.3
		
	elseif( !SW.IsOutsideFrame ) then
		
		if( SW.SkyboxVisible and SW.SoundVolume != 0.15 ) then
			
			-- SW.Sound:ChangeVolume( 0.15 * SW.VolumeMultiplier, 1 )
			SW.Sound:ChangeVolume( 0.15 * GetConVarNumber("sw_cl_fxvolume"), 1 )
			SW.SoundVolume = 0.15
			
		elseif( !SW.SkyboxVisible and SW.SoundVolume != 0 ) then
			
			SW.Sound:ChangeVolume( 0, 1 )
			SW.SoundVolume = 0
			
		end
		
	end
	
end

function SW.WindSoundThink()
	
	if( GetConVarNumber( "sw_cl_sounds" ) == 0 ) then return end
	
	if( !SW.NextWindSnippet ) then SW.NextWindSnippet = CurTime() end
	
	if( CurTime() >= SW.NextWindSnippet ) then
		
		LocalPlayer():EmitSound( "ambient/wind/wind_med" .. math.random( 1, 2 ) .. ".wav" )
		SW.NextWindSnippet = CurTime() + 12
		
	end
	
end

function SW.SirenSoundThink()
	
	if( GetConVarNumber( "sw_cl_sounds" ) == 0 ) then
		
		if( SW.SirenSound and SW.SirenSoundVolume != 0 ) then
			
			SW.SirenSound:ChangeVolume( 0, 1 )
			SW.SirenSoundVolume = 0
			
		end
		
		return
		
	end
	
	if( !SW.SirenSound ) then
		
		SW.SirenSound = CreateSound( LocalPlayer(), "ambient/alarms/alarm_citizen_loop1.wav" )
		SW.SirenSound:SetSoundLevel( 160 )
		SW.SirenSound:PlayEx( 0, 100 )
		
	end
	
	if( !SW.SirenSoundVolume ) then
		
		SW.SirenSoundVolume = -1
		
	end
	
	if( SW.IsOutsideFrame and SW.SirenSoundVolume != 0.3 ) then
		
		-- SW.SirenSound:ChangeVolume( 0.3 * SW.VolumeMultiplier, 1 )
		SW.SirenSound:ChangeVolume( 0.3 * GetConVarNumber("sw_cl_fxvolume"), 1 )
		SW.SirenSoundVolume = 0.3
		
	elseif( !SW.IsOutsideFrame ) then
		
		if( SW.SkyboxVisible and SW.SirenSoundVolume != 0.15 ) then
			
			-- SW.SirenSound:ChangeVolume( 0.15 * SW.VolumeMultiplier, 1 )
			SW.SirenSound:ChangeVolume( 0.15 * GetConVarNumber("sw_cl_fxvolume"), 1 )
			SW.SirenSoundVolume = 0.15
			
		elseif( !SW.SkyboxVisible and SW.SirenSoundVolume != 0 ) then
			
			SW.SirenSound:ChangeVolume( 0, 1 )
			SW.SirenSoundVolume = 0
			
		end
		
	end
	
end

function SW.SoundThink()
	
	if( SW.GetCurrentWeather().Sound == "rain" ) then
		
		SW.RainSoundThink()
		
	elseif( SW.GetCurrentWeather().Sound == "wind" and SW.IsOutsideFrame ) then
		
		SW.WindSoundThink()
		
	elseif( SW.GetCurrentWeather().Sound == "siren" and SW.IsOutsideFrame ) then
		
		SW.SirenSoundThink()
		
	elseif( SW.SoundVolume and SW.SoundVolume > 0 and SW.Sound ) then
		
		SW.Sound:ChangeVolume( 0, 1 )
		SW.SoundVolume = 0
		
	elseif( SW.SirenSoundVolume and SW.SirenSoundVolume > 0 and SW.SirenSound ) then
		
		SW.SirenSound:ChangeVolume( 0, 1 )
		SW.SirenSoundVolume = 0
		
	end
	
end

function SW.Lightning( vol, a, far )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( GetConVarNumber( "sw_cl_sounds" ) != 0 ) then
		
		if( far ) then
			
			-- sound.Play( "simpleweather/thunderfar" .. math.random( 1, 2 ) .. ".mp3", SW.ViewPos, 160, 100, vol * SW.VolumeMultiplier )
			sound.Play( "simpleweather/thunderfar" .. math.random( 1, 2 ) .. ".mp3", SW.ViewPos, 160, 100, vol * GetConVarNumber("sw_cl_fxvolume") )
			
		elseif( vol > 0 ) then
			
			-- sound.Play( "simpleweather/thunder" .. math.random( 1, 3 ) .. ".mp3", SW.ViewPos, 160, 100, vol * SW.VolumeMultiplier )
			sound.Play( "simpleweather/thunder" .. math.random( 1, 3 ) .. ".mp3", SW.ViewPos, 160, 100, vol * GetConVarNumber("sw_cl_fxvolume") )
			-- sound.Play( "simpleweather/lightning" .. math.random( 1, 4 ) .. ".mp3", SW.ViewPos, 160, 100, vol * SW.VolumeMultiplier )
			sound.Play( "simpleweather/lightning" .. math.random( 1, 4 ) .. ".mp3", SW.ViewPos, 160, 100, vol * GetConVarNumber("sw_cl_fxvolume") )
			
		end
		
	end
	
	-- if( SW.LightningEnabled and a > 0 ) then
	if( GetConVarNumber("sw_sv_lightning_flash") == 1 and a > 0 ) then
		
		table.insert( SW.HUDLightning, { c = CurTime(), a = a } )
		
	end
	
end

SW.HUDRainDrops = { }
SW.NextHUDRain = 0
SW.HUDRainMatID = surface.GetTextureID( "simpleweather/warp_ripple3" )

SW.HUDLightning = { }

function SW.HUDPaint()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		for k, v in pairs( SW.HUDLightning ) do
			
			if( CurTime() - v.c > 0.4 ) then
				table.remove( SW.HUDLightning, k )
				continue
			end
			
			surface.SetDrawColor( 255, 255, 255, 255 * ( 0.4 - ( CurTime() - v.c ) ) * v.a )
			surface.DrawRect( 0, 0, ScrW(), ScrH() )
			
		end
		
		-- if( !SW.RainOnScreen ) then return end
		if GetConVarNumber("sw_cl_rain_screen") == 0 then return end
		
		if( SW.GetCurrentWeather().Raindrops and SW.IsOutsideFrame and SW.ViewAng.p < 15 and LocalPlayer():WaterLevel() < 3 ) then
			
			-- if( ( LocalPlayer():GetVehicle() and LocalPlayer():GetVehicle():IsValid() and SW.VehicleRaindrops ) or LocalPlayer():GetVehicle() == NULL ) then
			if( ( LocalPlayer():GetVehicle() and LocalPlayer():GetVehicle():IsValid() and GetConVarNumber("sw_cl_rain_vehicledrops") ) or LocalPlayer():GetVehicle() == NULL ) then
				
				if( CurTime() > SW.NextHUDRain ) then
					
					SW.NextHUDRain = CurTime() + math.Rand( SW.GetCurrentWeather().RaindropMinDelay, SW.GetCurrentWeather().RaindropMaxDelay )
					
					local t = { }
					t.x = math.random( 0, ScrW() )
					t.y = math.random( 0, ScrH() )
					-- t.r = math.random( SW.RainOnScreenMinSize, SW.RainOnScreenMaxSize )
					t.r = math.random( GetConVarNumber("sw_cl_rain_dropsize_min"), GetConVarNumber("sw_cl_rain_dropsize_max") )
					t.c = CurTime()
					
					table.insert( SW.HUDRainDrops, t )
					
				end
				
			end
			
		end
		
		for k, v in pairs( SW.HUDRainDrops ) do
			
			if( CurTime() - v.c > 1 ) then
				table.remove( SW.HUDRainDrops, k )
				continue
			end
			
			surface.SetDrawColor( 255, 255, 255, 255 * ( 1 - ( CurTime() - v.c ) ) )
			surface.SetTexture( SW.HUDRainMatID )
			surface.DrawTexturedRect( v.x, v.y, v.r, v.r )
			
		end
		
	end
	
end
hook.Add( "HUDPaint", "SW.HUDPaint", SW.HUDPaint )

SW.ScreenspaceMul = 0

function SW.RenderScreenspaceEffects()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		local indoorc = true
		
		if( !SW.ColormodIndoors and !SW.IsOutsideFrame ) then
			
			indoorc = false
			
		end
		
		if( SW.WeatherMode != "" and SW.SkyboxVisible and indoorc ) then
			
			SW.ScreenspaceMul = math.min( SW.ScreenspaceMul + FrameTime() / 2, 1 )
			
		else
			
			SW.ScreenspaceMul = math.max( SW.ScreenspaceMul - FrameTime() / 2, 0 )
			
		end
		
		if( SW.ColormodEnabled ) then
			
			local tab = { }
			
			tab[ "$pp_colour_addr" ] 		= 0
			tab[ "$pp_colour_addg" ] 		= 0
			tab[ "$pp_colour_addb" ] 		= 0
			tab[ "$pp_colour_brightness" ] 	= -0.05 * SW.ScreenspaceMul
			tab[ "$pp_colour_contrast" ] 	= 1 - 0.15 * SW.ScreenspaceMul
			tab[ "$pp_colour_colour" ] 		= 1 - 0.25 * SW.ScreenspaceMul
			tab[ "$pp_colour_mulr" ] 		= 0
			tab[ "$pp_colour_mulg" ] 		= 0
			tab[ "$pp_colour_mulb" ] 		= 0
			
			DrawColorModify( tab )
			
		end

		if( SW.GetCurrentWeather().RenderScreenspaceEffects ) then
			
			SW.GetCurrentWeather():RenderScreenspaceEffects()
			
		end
		
	end
	
end
hook.Add( "RenderScreenspaceEffects", "SW.RenderScreenspaceEffects", SW.RenderScreenspaceEffects )

function SW.InitPostEntity()
	
	if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
		
		render.RedownloadAllLightmaps()
		
		-- if( SW.DisplayAtStart ) then
		if( GetConVarNumber("sw_cl_startupdisplay") == 1 ) then
			
			-- chat.AddText( Color( 255, 255, 255, 255 ), "This server is running ", Color( 76, 128, 255, 255 ), "SimpleWeather 1.35", Color( 255, 255, 255, 255 ), ". Type ", Color( 76, 128, 255, 255 ), SW.ChatCommand , Color( 255, 255, 255, 255 ), " to open the config menu." )
			-- chat.AddText( Color( 255, 255, 255, 255 ), "This server is running ", Color( 76, 128, 255, 255 ), "SimpleWeather 1.35", Color( 255, 255, 255, 255 ), ". Type ", Color( 76, 128, 255, 255 ), GetConVarString("sw_sv_chatcommand") , Color( 255, 255, 255, 255 ), " to open the config menu." )
			chat.AddText( Color( 255, 255, 255, 255 ), "This server is running ", Color( 76, 128, 255, 255 ), "SimpleWeather", Color( 255, 255, 255, 255 ), ". Check the ", Color( 76, 128, 255, 255 ), "Options Panels" , Color( 255, 255, 255, 255 ), " to edit the configuration." )
			
		end
		
	end
	
end
hook.Add( "InitPostEntity", "SW.InitPostEntity", SW.InitPostEntity )
