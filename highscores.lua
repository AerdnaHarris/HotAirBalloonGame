
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local json = require( "json" )
 
local scoresTable = {}
 
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )

local function loadScores()
 
    local file = io.open( filePath, "r" )
 
    if file then
        local contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end
 
    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    end
end


local function saveScores()
 
    for i = #scoresTable, 11, -1 do
        table.remove( scoresTable, i )
    end
 
    local file = io.open( filePath, "w" )
 
    if file then
        file:write( json.encode( scoresTable ) )
        io.close( file )
    end
end

local function gotoMenu()
    composer.gotoScene( "menu", { time=800, effect="slideLeft" } )
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	loadScores()

	-- Insert the saved score from the last game into the table, then reset it
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
	composer.setVariable( "finalScore", 0 )
	
	-- Sort the table entries from highest to lowest
    local function compare( a, b )
        return a > b
    end
	table.sort( scoresTable, compare )
	
	-- Save the scores
	saveScores()
	
	local background = display.newImageRect( sceneGroup, "Images/background.jpg", 360, 570  )
    background.x = display.contentCenterX
	background.y = display.contentCenterY
	
	local backgroundtrans = display.newImageRect( sceneGroup, "Images/bgtrans.png", 280, 520  )
    backgroundtrans.x = display.contentCenterX 
    backgroundtrans.y = display.contentCenterY - 15
	
	local rankNum = {}
	-- local highScoresHeader = display.newText( sceneGroup, "High Scores", display.contentCenterX, 10, native.systemFont, 44 )
	-- highScoresHeader:setFillColor( 1, 0.8, 0.01)
	for i = 1, 10 do
        if ( scoresTable[i] ) then
            local yPos = 10 + ( i * 40 )
			rankNum[i] = display.newImageRect( sceneGroup, "Images/medal" .. i .. ".png", 40,40)
			rankNum[i].x = display.contentCenterX - 30
			rankNum[i].y = yPos
            -- rankNum:setFillColor(0,0,0 )
            -- rankNum.anchorX = 1
 
            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX, yPos, native.systemFont, 22 )
            thisScore.anchorX = 0
        end
	end

	local menuButton = display.newImageRect( sceneGroup, "Images/menu.png", 190, 80  )
    menuButton.x = display.contentCenterX
    menuButton.y = display.contentHeight - 3
	menuButton:addEventListener( "tap", gotoMenu )
	
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
		composer.removeScene( "highscores" )
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
