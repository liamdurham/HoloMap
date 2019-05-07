if(SERVER)then
	AddCSLuaFile("hmap_config.lua")
	AddCSLuaFile();
	--resource.AddWorkshop( "numbers here" )
    	local files = file.Find("materials/hmap/*.png", "GAME");
	
	for _, png in pairs(files) do
		resource.AddFile("materials/hmap/"..png);
	end
end
HMAP = {};
include( "hmap_config.lua" )
SWEP.Author =  HMAP.Author
SWEP.PrintName =  HMAP.swepName
SWEP.Instructions = "Left mouse to bring up hmap"
SWEP.CanDeploy = true  
SWEP.Primary.Ammo = "none"
SWEP.HoldType = "normal"
SWEP.Category = HMAP.swepCategory
SWEP.UseHands = false
SWEP.Primary.Automatic= false
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false 
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Icon = HMAP.hmapGrid
hmapIsOn = false

if CLIENT then
SWEP.CanHolster = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.PrintName = "Holo Map"
SWEP.WepSelectIcon = HMAP.hmapGridImg
SWEP.DrawWeaponInfoBox = false
end   

function SWEP:PrimaryAttack()
self:SetNextPrimaryFire(CurTime() + .25)
    print("Fired") 
        if ( !self.Owner:GetNWBool("HmapOn") ) then
        hmapIsOn = true
        self.Owner:SetNWBool("HmapOn",hmapIsOn)
        self:EmitSound(HMAP.hmap_on, 70,50,1,CHAN_WEAPON)
        else
        hmapIsOn = false
        self.Owner:SetNWBool("HmapOn",hmapIsOn)
        self:EmitSound(HMAP.hmap_off, 70,100,1,CHAN_WEAPON) 
        end
end

if CLIENT then
	local cModify = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = .1,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}
    local hmapSizeY = 1024
    local hmapSizeX = 1024
    local hmapY = (ScrH()-((ScrH()/2)+512))
    local hmapX = (ScrW()-((ScrW()/2)+512))
    local hmapbgsY = 1070
    local hmapbgsX = 1072
    local hmapbgY = ((ScrH()/2)-547)
    local hmapbgX = ((ScrW()/2)-537)
    local displayRenderMap = "default"
    local dynamicSizeX = 4000
    local dynamicSizeY = 4000
    
    local function DrawHmapEffect()
        
		if LocalPlayer():GetNWBool("HmapOn") then
          
        local pz = LocalPlayer():GetPos().z
        local lpx = LocalPlayer():GetPos().x
        local lpy = LocalPlayer():GetPos().y    

        if ( pz <= HMAP.TopMapTop && pz >= HMAP.TopMapBot && lpx <= HMAP.TopMapHighX && lpx >= HMAP.TopMapLowX && lpy <= HMAP.TopMapHighY && lpy >= HMAP.TopMapLowY)  then
            displayRenderMap = HMAP.hmapTopMap
            dynamicSizeX = (math.abs(HMAP.TopMapHighX)+math.abs(HMAP.TopMapLowX))  
            dynamicSizeY = (math.abs(HMAP.TopMapHighY)+math.abs(HMAP.TopMapLowY))      
        elseif (pz <= HMAP.SecondMapTop && pz >= HMAP.SecondMapBot && lpx <= HMAP.SecondMapHighX && lpx >= HMAP.SecondMapLowX && lpy <= HMAP.SecondMapHighY && lpy >= HMAP.SecondMapLowY) then          displayRenderMap = HMAP.hmapSecondMap
                 dynamicSizeX = (math.abs(HMAP.SecondMapHighX)+math.abs(HMAP.SecondMapLowX))  
                 dynamicSizeY = (math.abs(HMAP.SecondMapHighY)+math.abs(HMAP.SecondMapLowY))
        elseif (pz <= HMAP.ThirdMapTop && pz >= HMAP.ThirdMapBot && lpx <= HMAP.ThirdMapHighX && lpx >= HMAP.ThirdMapLowX && lpy <= HMAP.ThirdMapHighY && lpy >= HMAP.ThirdMapLowY) then
            displayRenderMap = HMAP.hmapThirdMap
            dynamicSizeX = (math.abs(HMAP.ThirdMapHighX)+math.abs(HMAP.ThirdMapLowX))  
            dynamicSizeY = (math.abs(HMAP.ThirdMapHighY)+math.abs(HMAP.ThirdMapLowY))    
        elseif (pz <= HMAP.FourthMapTop && pz >= HMAP.FourthMapBot && lpx <= HMAP.FourthMapHighX && lpx >= HMAP.FourthMapLowX && lpy <= HMAP.FourthMapHighY && lpy >= HMAP.FourthMapLowY) then
            displayRenderMap = HMAP.hmapFourthMap
            dynamicSizeX = (math.abs(HMAP.FourthMapHighX)+math.abs(HMAP.FourthMapLowX))  
            dynamicSizeY = (math.abs(HMAP.FourthMapHighY)+math.abs(HMAP.FourthMapLowY))    
        else
            displayRenderMap = HMAP.hmapNoMap -- If no map, default  to...?
            dynamicSizeX = 32000 -- Max size for when outside other maps
            dynamicSizeY = 32000 -- Max size for when outside other maps     
        end
        local px = ((LocalPlayer():GetPos().x)/(dynamicSizeX/1024))
        local py = ((LocalPlayer():GetPos().y)/(dynamicSizeY/1024))    
        local xx = (ScrW()/2)+px
        local yy = ((ScrH()/2)+(py*-1))
        local pAngle = ((LocalPlayer():GetAimVector():Angle().yaw)-90)
            local marker = {
	       { x = xx, y = yy },
	       { x = xx-5, y = yy-15 },
	       { x = xx+5, y = yy-15 }
                }
             local emitterL = {
            { x = ((ScrW()/2)-552), y = 0 },    
	        { x = ((ScrW()/2)-537), y = 0 },
            { x = ((ScrW()/2)-537), y = (ScrH()) },
            { x = ((ScrW()/2)-587), y = (ScrH()) }   

                }
             local emitterR = {
            { x = (((ScrW()/2)-537)+1072), y = 0 },    
            { x = (((ScrW()/2)-537)+1087), y = 0 },         
            { x = (((ScrW()/2)-537)+1122), y = (ScrH()) },     
            { x = (((ScrW()/2)-537)+1072), y = (ScrH()) }       
                }
             local emitterB = {
            { x = ((ScrW()/2)-587), y = (ScrH()) },    
            { x = ((ScrW()/2)-537), y = (((ScrH()/2)-547)+1070) },         
            { x = (((ScrW()/2)-537)+1072), y = (((ScrH()/2)-547)+1070) },     
            { x = (((ScrW()/2)-537)+1122), y = (ScrH()) }       
                }
    
        if(HMAP.offWhenMove) then  
            if(LocalPlayer():GetVelocity():Length() > 5) then
               print("Canceled due to movement")
               LocalPlayer():SetNWBool("HmapOn", false)
               hmapIsOn = false    
               LocalPlayer():EmitSound(HMAP.hmap_off, 70,75,1,CHAN_WEAPON)    
            end
        end
           if(HMAP.offWhenHurt) then          
                gameevent.Listen( "player_hurt" )
                hook.Add( "player_hurt", "player_hurt_usingHmap", function( data )
                local victim = Player(data.userid)
	            if (victim == LocalPlayer()) then			
               print("Hmap Canceled due to Damage")
               hmapIsOn = false             
               LocalPlayer():SetNWBool("HmapOn", false)  
               LocalPlayer():EmitSound(HMAP.hmap_off, 70,75,1,CHAN_WEAPON)
            end              
          end ) 
        end        
         --   DrawColorModify(cModify)
			DrawToyTown(2,ScrH()/2)
            DrawSobel( 0.75 )
            surface.SetDrawColor(Color(20,60,120,100))
            surface.SetMaterial(HMAP.hmapEffect)
            surface.DrawTexturedRect(hmapbgX,hmapbgY,hmapbgsX,hmapbgsY+50)
            
            surface.SetDrawColor(Color(0,0,255,30))
            surface.SetMaterial(HMAP.hmapBG)
            surface.DrawTexturedRect(hmapbgX,hmapbgY,hmapbgsX,hmapbgsY)
            
            surface.SetDrawColor(Color(0,0,120,50))
            surface.SetMaterial(HMAP.hmapBGgradient)
            surface.DrawTexturedRect(hmapbgX,hmapbgY,hmapbgsX,hmapbgsY+50)
            
            surface.SetDrawColor(Color(0,0,255,245))
            surface.SetMaterial(displayRenderMap)
	        surface.DrawTexturedRect(hmapX,hmapY,hmapSizeX,hmapSizeY)
            
            surface.SetDrawColor(Color(32,32,32,225))
            draw.NoTexture()
	        surface.DrawPoly(emitterL)
            surface.DrawPoly(emitterR)
            surface.DrawPoly(emitterB)
            
            if (HMAP.hmapMarker) then
            surface.SetDrawColor(Color(0,255,0,200))          
            surface.SetMaterial(HMAP.hmapMarkerImg)      
            surface.DrawTexturedRectRotated((xx),(yy),16,20,pAngle)
            end
            if (HMAP.hmapCompass) then
            surface.SetDrawColor(Color(0,55,255,200))    
            surface.SetMaterial(HMAP.hmapCompassImg) 
            surface.DrawTexturedRectRotated((hmapX+954),(hmapY+60),60,60,pAngle)
            end
            if (HMAP.hmapGrid) then
            surface.SetDrawColor(Color(255,255,255,255))
            surface.SetMaterial(HMAP.hmapGridImg)
	        surface.DrawTexturedRect(hmapX,hmapY,hmapSizeX,hmapSizeY)    
            end
		end
	end
    hook.Add("RenderScreenspaceEffects","DrawHmapEffects",DrawHmapEffect)   
end 
function SWEP:SecondaryAttack()
	return
end
function SWEP:Holster()
   hmapIsOn = false             
   self.Owner:SetNWBool("HmapOn", false)  
   self.Owner:EmitSound(HMAP.hmap_off, 70,75,1,CHAN_WEAPON)
	return true
end
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end
function SWEP:Deploy()
	self.Owner:DrawViewModel(false)
end
function SWEP:DrawWorldModel()
	return false
end
function SWEP:ShouldDropOnDie()
    return false
end
function SWEP:Reload()
end


-- Copyright 2018 David Anderson DND 