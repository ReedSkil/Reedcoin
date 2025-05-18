os.loadAPI("findBlocks.lua")
os.loadAPI("userInput.lua")
slot = 1

function getBlocks(blockname)
	slot = findBlocks.findBlock(blockname)
	while slot == nil do
		print("Please input more ")
		print(blockname)
		userInput.getUserInput("Type Anything to Continue")
	end
	return slot
end

function setOrientation(newwidth)
	orientation = 0
	if newwidth % 2 == 1 then
		orientation = 0
	else
		orientation = 1
	end
end

-- Function to place down any blocks within the turtle
function basicPlaceDown()
	while not turtle.placeDown() do
		if slot == 16 then
			slot = 1
			turtle.select(slot)
			print("Out of Materials")
			print("Please Insert Blocks")
			userInput.getUserInput("Type Anything to Continue")
		else
			slot = slot + 1
			turtle.select(slot)
		end
	end
end

-- Function to place down a specific block
function smartPlaceDown(blockname)
	local itemDetail = turtle.getItemDetail(slot)
	if itemDetail and itemDetail.name ~= blockName then
		slot = getBlocks(blockname)
		if slot ~= nil then
			turtle.select(slot)
		end
	end
	while not turtle.placeDown() do
		slot = getBlocks(blockname)
		if slot ~= nil then
			turtle.select(slot)
		end
	end
	return slot
end

-- Function to build a floor (using ANY materials in turtle)
function basicBuildFloor(newlength, newwidth)
    width = newwidth
	length = newlength
	for i = 1, length do
        for j = 1, width do
            placeDown()
            if j < width then
                turtle.forward()
            end
        end
        if i < length then
            if i % 2 == 0 then
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
            else
		turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
            end
        end
    end
end

-- Function to build a floor using only a specific blocktype in the turtles inventory
function blockBuildFloor(newlength, newwidth, blockname)
	width = newwidth
	length = newlength
	for i = 1, length do
        	for j = 1, width do
        		smartPlaceDown(blockname)
        		if j < width then
                		turtle.forward()
            		end
        	end
        	if i < length then
            		if i % 2 == 0 then
                		turtle.turnLeft()
                		turtle.forward()
                		turtle.turnLeft()
            		else
				turtle.turnRight()
                		turtle.forward()
                		turtle.turnRight()
            		end
        	end
	end
end

--Function to build a wall (using ANY materials in turtle)
function basicBuildWall(newlength, height)
	length = newlength
	for i = 1, height do
        	turtle.up()
        end
	for j = 1, length do
		buildSupportBeam(height)
		turtle.forward()
		for k = 1, height do
        		turtle.down()
            	end
	end
end

--Function to build a wall using only a specific blocktype in the turtles inventory
function blockBuildWall(newlength, height, blockname)
	length = newlength
	for i = 1, height do
        	turtle.up()
        end
	for j = 1, length do
		buildSupportBeamBlock(height, blockname)
		turtle.forward()
		for k = 1, height do
        		turtle.down()
            	end
	end
end

--Function to build 4 walls for a tower. This does not include corners for design choices
--(using ANY materials in turtle)
function basicBuildWallsTower(newlength, newwidth, height)
	width = newwidth - 2
	length = newlength - 2 
	distance = 0
	for i = 1, 4 do
		if i % 2 == 1 then
			distance = length
		else
			distance = width
		end

		for j = 1, distance do
			turtle.forward()
			for k = 1, height do
            			turtle.down()
            		end
			buildSupportBeam(height)
		end
		turtle.forward()
		turtle.turnRight()
	end
end

--Function to build 4 walls for a tower. This does not include corners for design choices
--(using only a specific blocktype in the turtles inventory)
function blockBuildWallsTower(newlength, newwidth, height, blockname)
	width = newwidth - 2
	length = newlength - 2 
	distance = 0
	for i = 1, 4 do
		if i % 2 == 1 then
			distance = length
		else
			distance = width
		end

		for j = 1, distance do
			turtle.forward()
			for k = 1, height do
            			turtle.down()
            		end
			buildSupportBeamBlock(height, blockname)
		end
		turtle.forward()
		turtle.turnRight()
	end
end

--builds a small 1 block pillar (using ANY materials in turtle)
function basicBuildSupportBeam(height)
	turtle.up()
	for j = 1, height do
        	placeDown()
        	if j < height then
        		turtle.up()
           	end
        end
end

--builds a small 1 block pillar using only a specific blocktype in the turtles inventory
function blockBuildSupportBeam(height, blockname)
	turtle.up()
        for j = 1, height do
        	smartPlaceDown(blockname)
        	if j < height then
        		turtle.up()
           	end
        end
end

--builds the 4 corners of the BuildWallsTower function. (using ANY materials in turtle)
function basicBuildSupportBeams(height, orientation)
	width = width - 1
	length = length - 1
	for i = 1, 4 do
		buildSupportBeam(height)
		if orientation == 0 then
			turtle.turnLeft()
		else 
			turtle.turnRight()
		end

		distance = 0
		if i % 2 == 1 and i ~= 4 then
			distance = length
		end
		if i % 2 == 0 and i ~= 4 then
			distance = width
		end

		for j = 1, distance do
			turtle.forward()
		end
		for k = 1, height do
                    turtle.down()
                end
	end
	if orientation == 0 then
		turtle.turnLeft()
		for l = 1, length do
			turtle.forward()
		end
		turtle.turnRight()
	else 
		for l = 1, width do
			turtle.forward()
		end

		turtle.turnRight()

		for m = 1, length do
			turtle.forward()
		end

		turtle.turnRight()
	end
end

--builds the 4 corners of the BuildWallsTower function using only a specific blocktype in the turtles inventory.
function blockBuildSupportBeams(height, orientation, blockname)
	width = width - 1
	length = length - 1
	for i = 1, 4 do
		buildSupportBeamBlock(height, blockname)
		if orientation == 0 then
			turtle.turnLeft()
		else 
			turtle.turnRight()
		end

		distance = 0
		if i % 2 == 1 and i ~= 4 then
			distance = length
		end
		if i % 2 == 0 and i ~= 4 then
			distance = width
		end

		for j = 1, distance do
			turtle.forward()
		end
		for k = 1, height do
	                turtle.down()
                end
	end
	if orientation == 0 then
		turtle.turnLeft()
		for l = 1, length do
			turtle.forward()
		end
		turtle.turnRight()
	else 
		for l = 1, width do
			turtle.forward()
		end

		turtle.turnRight()

		for m = 1, length do
			turtle.forward()
		end

		turtle.turnRight()
	end
end

-- THE FOLLOWING FUNCTIONS ARE USED TO SIMULATE OVERLOADED FUNCTIONS IN LUA FOR THE ABOVE FUNCTIONS

function placeDown(newblockname)
	blockname = newblockname or false
	if blockname then
		smartPlaceDown(blockname)
	else
		basicPlaceDown()
	end
end

function buildFloor(newlength, newwidth, newblockname)
	--this was included incase I want a default value for future use
	length = newlength
	width = newwidth
	blockname = newblockname or false
	if blockname then
		blockBuildFloor(length, width, blockname)
	else
		basicBuildFloor(length, width)
	end
end

function buildWall(newlength, newheight, newblockname)
	--this was included incase I want a default value for future use
	length = newlength
	height = newheight
	blockname = newblockname or false
	if blockname then
		blockBuildWall(length, height, blockname)
	else
		basicBuildWall(length, height)
	end
end

function buildWallsTower(newlength, newwidth, newheight, newblockname)
	--this was included incase I want a default value for future use
	length = newlength
	width = newwidth
	height = newheight
	blockname = newblockname or false
	if blockname then
		blockbuildWallsTower(length, width, blockname)
	else
		basicbuildWallsTower(length, width, height)
	end
end

function buildSupportBeam(newheight, newblockname)
	--this was included incase I want a default value for future use
	height = newheight
	blockname = newblockname or false
	if blockname then
		blockBuildSupportBeam(height, blockname)
	else
		basicBuildSupportBeam(height)
	end
end

function blockBuildSupportBeams(newheight, neworientation, newblockname)
	--this was included incase I want a default value for future use
	height = newheight
	orientation = neworientation
	blockname = newblockname or false
	if blockname then
		blockBuildSupportBeams(height, orientation, blockname)
	else
		basicBuildSupportBeams(height, orientation)
	end
end


