
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

local function gotoHighScores()
	composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end

local function gotoHelp()
	composer.gotoScene( "help", { time=800, effect="crossFade" } )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local background = display.newImageRect( sceneGroup, "Images/background.jpg", 360, 570 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
	-- title.x = display.contentCenterX
	-- title.y = 200

	-- local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, display.contentHeight - 100, native.systemFont, 36 )
	-- playButton:setFillColor( 0, 0, 0 )

	local playButton = display.newImageRect( sceneGroup, "Images/play.png", 160, 75 )
	playButton.x = display.contentCenterX
	playButton.y = display.contentHeight - 100

	local highScoresButton = display.newImageRect( sceneGroup, "Images/hs.png", 220, 70)
	highScoresButton.x = display.contentCenterX
	highScoresButton.y = display.contentHeight - 20

	local helpButton = display.newImageRect( sceneGroup, "Images/help.png", 50, 50)
	helpButton.x = display.contentWidth - 30
	helpButton.y = display.contentHeight - display.contentHeight - 10

	playButton:addEventListener( "tap", gotoGame )
	highScoresButton:addEventListener( "tap", gotoHighScores )
	helpButton:addEventListener( "tap", gotoHelp )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
