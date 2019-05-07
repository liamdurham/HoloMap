--[[ Welcome to HMAP, a simple gridmap system designed for servers that need to prevent serverside lag as much as possible. 
This system is specifically designed for maps that contain multiple "planets" or otherwise require multiple maps for multiple coorindate areas.
 These can be defined by six terms, being the upper and lower x y and z coords.
 Currently, the map code supports up to four maps, but this can be increased very easily if you know how to code slightly. If you want less, you can just set all 6 values for the unused map to 0
 If you don't know how to add more and need to, you can contact me and I'll show you how.
 This method requires some legwork on the end of the person setting up the map system, specifically to create the "maps"
 
 FIRST, you should try to find the original map used before they were put into the multi-planet map. 
 Then, use the method outlined here https://developer.valvesoftware.com/wiki/Creating_a_working_mini-map to get a 1024x1024 picture of the map
 In my maps, i then mapped walkways with a white area, and houses/etc with a black area, and put a star over important locations.
 The grid overlay is automatic, but you can add your own in a different style if you want.
 So once you have your 1024x1024 map that you want to display, you just save it as a .png, 
 put it in the materials/hmap folder, and down in the settings change HMAP.hmapTopMap = Material( "hmap/YOUR MAP NAME.png" ) 
 Try to keep your .png's filesize as low as possible. 
 
 IF YOU CANT GET A GOOD PICTURE OF THE MAP FOR SOME REASON
 I just went and did stuff manually, including pertinent features only. Remember: the resulting map  marker of the player is based off of a grid system. How big the sqaures are will depend on how big your highx-lowx,highy-lowy is, so for example with a map that goes from 16000 to -16000, meaning 32000units^2, each square of the grid is 32000/8 so 400units^2. 
 Thus, if you have a river that starts at -16000, 16000 and ends at 0, 0 you would have a diagonal  line from the top left corner to the exact middle. You can thus estimate general areas of things and adjust them according with the map in game.
 
 This map system is meant, again, to be as streamlined as possible. 
 It has no serverside checking loops, and therefore should cause little to no lag, ever.
 If it does cause lag, let me know asap please and we can try to figure out why.
]]--

HMAP.swepName = "HoloMap"; 
HMAP.swepCategory = "HoloMap"; 
HMAP.author = "JFX";

-- Want a different sound? Add it here
HMAP.hmap_on = Sound("hmap/hmap_on.wav")
HMAP.hmap_off = Sound("hmap/hmap_off.wav")

-- Want a marker where the user is? 20x20ish
HMAP.hmapMarker = true
HMAP.hmapMarkerImg = Material( "hmap/hmap_marker.png" )

-- Compass in upper right corner? 60x60ish
HMAP.hmapCompass = true
HMAP.hmapCompassImg = Material( "hmap/hmap_marker.png" )

-- Grid Overlay?
HMAP.hmapGrid = true
HMAP.hmapGridImg = Material( "hmap/hmap_grid.png" )

-- want a different background behind your map? 1024x1024 base image
HMAP.hmapBG = Material( "hmap/hmap_overlay.png" )

-- Animated post-process to give it a holo-map feel. Here's a list of usable ones
-- https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/overlay.lua
HMAP.hmapEffect = Material("effects/tvscreen_noise002a")

-- 1024x1024 Maps, as Pngs, starting from the top most (by z, or height, value)
HMAP.hmapTopMap = Material( "hmap/GSbutton.png" )
HMAP.hmapSecondMap = Material( "hmap/hmap_tyt.png" )
HMAP.hmapThirdMap = Material( "hmap/GSbutton.png" )
HMAP.hmapFourthMap = Material( "hmap/GSbutton.png" )

-- Outside all maps? Default to this. In this case, I used a "No Available Map" Error, but you could draw circles where planets are and use that instead, etc.
HMAP.hmapNoMap = Material( "hmap/hmap_none.png" )

-- Background gradient. 1024x1024 base
HMAP.hmapBGgradient = Material( 'vgui/gradient_up' )

--First map coords
HMAP.TopMapTop = 10000
HMAP.TopMapBot = 5500
HMAP.TopMapHighX = 16000
HMAP.TopMapLowX = -16000
HMAP.TopMapHighY = 16000
HMAP.TopMapLowY = -16000

--Second Map Coords
HMAP.SecondMapTop = 4000
HMAP.SecondMapBot = -2000
HMAP.SecondMapHighX = 16000
HMAP.SecondMapLowX = -16000
HMAP.SecondMapHighY = 16000
HMAP.SecondMapLowY = -16000

-- Third Map Coords
HMAP.ThirdMapTop = -4000
HMAP.ThirdMapBot = -7500
HMAP.ThirdMapHighX = 16000
HMAP.ThirdMapLowX = -16000
HMAP.ThirdMapHighY = 16000
HMAP.ThirdMapLowY = -16000

--Fourth Map Coords
HMAP.FourthMapTop = -9000
HMAP.FourthMapBot = -14500
HMAP.FourthMapHighX = 16000
HMAP.FourthMapLowX = -16000
HMAP.FourthMapHighY = 16000
HMAP.FourthMapLowY = -16000

-- Suggest not disabling both - otherwise map will remain open when player dies + respawns
-- Turns off the map temporarily if the player moves
HMAP.offWhenMove = false 

-- Turns off map temporarily if player is hurt

HMAP.offWhenHurt = true

