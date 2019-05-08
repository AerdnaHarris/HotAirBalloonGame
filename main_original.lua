-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local tapCount = 0

local background = display.newImageRect( "Images/background.jpg", 360, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )
tapText:setFillColor( 0, 0, 0 )
tapText.isVisible = false

local balloon = display.newImageRect( "Images/balloon.png", 150, 175 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local play = display.newImageRect( "Images/play_button.png", 100, 100 )
play.x = display.contentCenterX
play.y = display.contentHeight-80

local resetBtn = display.newImageRect( "Images/reset.png", 100, 100 )
resetBtn.x = display.contentCenterX
resetBtn.y = display.contentHeight-80
resetBtn.isVisible = false

local ground = display.newImageRect( "Images/grass.png", 320, 70 )
ground.x = display.contentCenterX
ground.y = display.contentHeight+10

local physics = require( "physics" )


local function pushBalloon()
    balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
    tapCount = tapCount + 1
    tapText.text = tapCount
end

local function playButton()
    physics.start()
    physics.addBody( ground, "static" )
    physics.addBody( balloon, "dynamic", { radius=50, bounce=0.2 } )
    play.isVisible = false
    tapText.isVisible = true
end

local function reset()
    print('click')
    play.isVisible = true
    resetBtn.isVisible = false
    tapCount = 0
    
end

local function onCollision( event )
    tapText.text = "GAME OVER"
    physics.pause()
    resetBtn.isVisible = true

    transition.moveTo(balloon, {x=display.contentCenterX, y=display.contentCenterY, time=3000 } )
    print("Collision")
end



balloon:addEventListener( "tap", pushBalloon )
play:addEventListener( "tap", playButton )
Runtime:addEventListener("collision",onCollision)
resetBtn:addEventListener("tap",reset)