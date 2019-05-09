
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


local widget = require( "widget" )

-- ScrollView listener
local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end
 
    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
 
    return true
end

local function gotoMenu()
    composer.gotoScene( "menu", { time=800, effect="slideRight" } )
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	
	local background = display.newImageRect( sceneGroup, "Images/background.jpg", 360, 570  )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    
	local backgroundtrans = display.newImageRect( sceneGroup, "Images/bgtrans1.png", 300, 520  )
    backgroundtrans.x = display.contentCenterX 
	backgroundtrans.y = display.contentCenterY - 15
	
    
	local menuButton = display.newImageRect( sceneGroup, "Images/menu.png", 190, 80  )
    menuButton.x = display.contentCenterX
    menuButton.y = display.contentHeight - 3
	menuButton:addEventListener( "tap", gotoMenu )

	-- local help1 = display.newText( "Just tap the hot air balloon as many as you can. Remember the more you tap the more the hot air balloon goes up and the thrilling part is you need to catch it as it goes down. ", display.contentCenterX, display.contentHeight - 300, 240, 300, native.systemFont, 20 )
	-- help1:setFillColor(1,1, 1 )
	-- local help2 = display.newText( "Don't let the hot air balloon touch the ground and the birds. ", display.contentCenterX, display.contentCenterY + 120, 240, 300, native.systemFont, 20 )
	-- help1:setFillColor(1,1, 1 )
	-- local help3 = display.newText( "Tap as many as you can to get the high score. ", display.contentCenterX, display.contentCenterY + 200, 240, 300, native.systemFont, 20 )
	-- help1:setFillColor(1,1, 1 )
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
