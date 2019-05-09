
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
-- physics.setGravity( 0, 0 )


-- Initialize variables
local score = 0
local died = false


local balloon
local ground
local scoreText
local countDown
local gameoverImg

local backGroup
local mainGroup
local uiGroup

local timerSrc --Blocks timer
local createBirds = {}
local blocks = {}
local yPos = {90, 140, 180} --Possible positions for the blocks
-- events
 
local function pushBalloon()
    balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
    -- Increase score
    score = score + 1
    scoreText.text = score
end

function createBirds()
    local b
    local rnd = math.floor(math.random() * 4) + 1
    local valueY = yPos[math.floor(math.random() * 3)+1]
    b = display.newImage('Images/bird2.png', display.contentWidth, valueY)

    b.myName = 'block'
    -- Block physics
    physics.addBody(b, 'static')
    b.isSensor = true
    blocks:insert(b)

    local randomTime = math.random(2000, 5000)
    transition.moveTo( b, { x=-50, y=valueY, time=randomTime } )

    print("create birds" .. rnd)

    print("current score: " .. score)
  end

local function endGame()
	composer.setVariable( "finalScore", score )
    composer.gotoScene( "highscores", { time=800, effect="slideLeft" } )
    timer.cancel(timerSrc)
    timerSrc = nil
end

local function onCollision( event )

	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		if ((obj1.myName == "grass" and obj2.myName == "balloon") or
			 (obj1.myName == "balloon" and obj2.myName == "grass")) then
			if ( died == false ) then
				died = true
                transition.moveTo(balloon, {x=display.contentCenterX, y=display.contentCenterY, time=3000 } )
                timer.performWithDelay( 2000, endGame )
				print("Game Over")
            end
        elseif ((obj1.myName == "block" and obj2.myName == "balloon") or
        (obj1.myName == "balloon" and obj2.myName == "block")) then
            if ( died == false ) then
				died = true
                transition.moveTo(balloon, {x=display.contentCenterX, y=display.contentCenterY - 200, time=3000 } )
                timer.performWithDelay( 2000, endGame )
				print("Game Over by Birds")
            end
        end 
        gameoverImg.isVisible = true
        balloon:removeEventListener( "tap", pushBalloon )
	end
end


-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    physics.pause()  -- Temporarily pause the physics engine

	-- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

	uiGroup = display.newGroup()    -- Display group for UI objects like the score
    sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
    
    local background = display.newImageRect( backGroup, "Images/background.jpg", 360, 570 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    balloon = display.newImageRect( mainGroup, "Images/balloon.png", 100, 120 )
    balloon.x = display.contentCenterX
    balloon.y = display.contentCenterY
    balloon.alpha = 0.8
    balloon.myName = "balloon"

    ground = display.newImageRect( mainGroup, "Images/grass.png", 320, 70 )
    ground.x = display.contentCenterX
    ground.y = display.contentHeight+10
    ground.myName = "grass"

    scoreText = display.newText( uiGroup, score, 400, 80, native.systemFont, 36 )
    scoreText.x = display.contentCenterX
    scoreText.y = display.contentHeight - display.contentHeight + 10
    scoreText.isVisible = false

    countDown = display.newText( uiGroup, score, 400, 80, native.systemFont, 60 )
    countDown.x = display.contentCenterX
    countDown.y = display.contentCenterY - 100
    countDown:setFillColor( 0, 0, 0)
    countDown.text = 0


    gameoverImg = display.newImageRect( backGroup, "Images/gameover.png", 300, 400 )
    gameoverImg.x = display.contentCenterX
    gameoverImg.y = display.contentHeight - 180
    gameoverImg.isVisible = false

    -- balloon:addEventListener( "tap", pushBalloon )
    blocks = display.newGroup()
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        
        physics.start()
        timer.performWithDelay(1000, function()
            countDown.text = 1
        end )
        timer.performWithDelay(2000, function()
            countDown.text = 2
        end )
        timer.performWithDelay(3000, function()
            countDown.text = 3
        end )
        timer.performWithDelay( 3000, function()
            scoreText.isVisible = true
            countDown.isVisible = false
            balloon:addEventListener( "tap", pushBalloon )
            physics.addBody( ground, "static" )
            physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )
        end )
        -- physics.addBody( ground, "static" )
        -- physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )
        Runtime:addEventListener( "collision", onCollision )
        timerSrc = timer.performWithDelay(8500, createBirds, 0)
        -- gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
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
        Runtime:removeEventListener( "collision", onCollision )
		physics.pause()
		composer.removeScene( "game" )
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
