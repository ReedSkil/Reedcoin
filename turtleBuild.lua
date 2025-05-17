os.loadAPI("findBlocks.lua")
os.loadAPI("userInput.lua")
slot = 1

-- Function to build a floor
function placeDown()
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

function getBlocks(blockname)
	slot = findBlocks.findBlock(blockname)
	while slot == nil do
		print("Please input more ")
		print(blockname)
		userInput.getUserInput("Type Anything to Continue")
	end
	return slot
end

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

function buildFloor(newlength, newwidth)
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

function buildFloorBlock(newlength, newwidth, blockname)
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

function buildWalls(newlength, newwidth, height)
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

function buildWallsBlock(newlength, newwidth, height, blockname)
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

function buildSupportBeam(height)
		turtle.up()
        for j = 1, height do
           placeDown()
           if j < height then
                turtle.up()
           end
        end
end

function buildSupportBeamBlock(height, blockname)
		turtle.up()
        for j = 1, height do
           smartPlaceDown(blockname)
           if j < height then
                turtle.up()
           end
        end
end

function buildSupportBeams(height, orientation)
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

function buildSupportBeamsBlock(height, orientation, blockname)
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

function setOrientation(newwidth)
	orientation = 0
	if newwidth % 2 == 1 then
		orientation = 0
	else
		orientation = 1
	end
end
