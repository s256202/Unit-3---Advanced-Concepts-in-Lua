-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"
-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local scrollXSpeed = 0
local scrollYSpeed = 1
local jungleSounds = audio.loadSound("Sounds/The more you know.mp3")
local jungleSoundsChannel

-- make sound
local lampPull = audio.loadSound("Sounds/lamppull.mp3")
local lampPullSoundChannel
local textSound = audio.loadSound("Sounds/sparkle.mp3")
local textSoundChannel

-- make images
local companyImageBeforeGlow = display.newImage("Images/CompanyLogo2EthanL.png", 512, 384)
local companyImageAfterGlow = display.newImage("Images/CompanyLogoEthanL.png", 512, 384)

companyImageBeforeGlow:scale(0.5, 0.5)
companyImageAfterGlow:scale(0.5, 0.5)

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the beetleship across the screen
local function moveCompanyLogo1()
    companyImageBeforeGlow.x = companyImageBeforeGlow.x + scrollXSpeed
    companyImageBeforeGlow.y = companyImageBeforeGlow.y + scrollYSpeed
    companyImageBeforeGlow:scale(1.01^0.5, 1.01^0.5)
end

local function moveCompanyLogo2()
    companyImageAfterGlow.x = companyImageAfterGlow.x + scrollXSpeed
    companyImageAfterGlow.y = companyImageAfterGlow.y + scrollYSpeed
    companyImageAfterGlow:scale(1.01^0.5, 1.01^0.5)
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- make text
local companyText = display.newImage("Images/nightTimeText.png", 500, 500, 500)
companyText.isVisible = false

companyImageBeforeGlow:scale(0.3, 0.3)
companyImageAfterGlow:scale(0.3, 0.3)

companyImageBeforeGlow.isVisible = true
companyImageAfterGlow.isVisible = false
companyImageBeforeGlow.alpha = 0

local function turnLampOn()
    companyImageBeforeGlow.alpha = companyImageBeforeGlow.alpha + 0.01

    if (companyImageBeforeGlow.alpha == 1) then
        companyImageBeforeGlow.isVisible = false
        companyImageAfterGlow.isVisible = true
    end
end

local function lampSound()
    if (companyImageAfterGlow.alpha == 1) then
        lampPullSoundChannel = audio.play(lampPull)
    end
end

local function soundText()
    companyText.isVisible = true
    textSoundChannel = audio.play(textSound)
end

local function checkSize()

    if (companyImageBeforeGlow.y == 384) then
        companyImageBeforeGlow:scale(1, 1)
end
    if (companyImageAfterGlow.y == 384) then
        companyImageAfterGlow:scale(1, 1)
        
end
end

Runtime:addEventListener("enterFrame", checkSize)        
timer.performWithDelay(2800, lampSound)
Runtime:addEventListener("enterFrame", turnLampOn)
timer.performWithDelay(4000, soundText)

-- function to kill logo
local function destroyLogo()
    companyImageBeforeGlow.alpha = 0
    companyImageAfterGlow.alpha = 0
    companyText.alpha = 0
end
timer.performWithDelay(5000, destroyLogo)
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- set the initial x and y position of the beetleship
    companyImageBeforeGlow.x = 512
    companyImageBeforeGlow.y = display.contentHeight/2

    -- set the initial x and y position of the beetleship
    companyImageAfterGlow.x = 512
    companyImageAfterGlow.y = display.contentHeight/2

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( companyImageBeforeGlow )
    sceneGroup:insert( companyImageAfterGlow )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        jungleSoundsChannel = audio.play(jungleSounds)

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveCompanyLogo1)
        Runtime:addEventListener("enterFrame", moveCompanyLogo2)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 5000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(jungleSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
