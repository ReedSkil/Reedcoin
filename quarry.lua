--todo:
--implement smart quarry (ie quarry that mines only a specific block, this type of quarry MUST backtrack as it is designed for sand/gravel)
--implement ejection of materials code (ie inventory space reserved for specified materials/quarrying equipment)


-- Function to dig out a block
-- temp note: blockname no longer needed, however this should be replaced with itemlist and equivalent code structure for material ejection feature
function dig(down, blockname)
  if blockname == nil then
    if down then
      turtle.digDown()
      turtle.down()
    else
      turtle.digUp()
      turtle.up()
    end
  else
    if down then
      turtle.digDown()
      turtle.down()
    else
      turtle.digUp()
      turtle.up()
    end
  end
end

-- Function to Mine to Depth
-- temp note: blockname no longer needed, however this should be replaced with itemlist and equivalent code structure for material ejection feature
function mineColumn(down, newblockname)
  for i = 1, depth do
    dig(down, newblockname)
  end
  if down:
    down = false
  else:
    down = true
  end
end
 
-- Function to quarry mine a various sized hole
-- temp note: blockname no longer needed, however this should be replaced with itemlist and equivalent code structure for material ejection feature
function mine(width, length, newblockname)
  blockname = newblockname or nil
  down = true
  for i = 1, length do
    for j = 1, width do
      mineColumn(down, blockname)
      turtleForward.moveForward()
    end
    if i < length then
      mineColumn(down, blockname)
      if i % 2 == 1 then
        turtle.turnRight()
        turtleForward.moveForward()
        turtle.turnRight()
      else
        turtle.turnLeft()
        turtleForward.moveForward()
        turtle.turnLeft()
      end
    end
  end
end

------------------------------------------------------------------
--smartMine is used to dig out an area only of a specific block
-- this is done to preserve turtle inventory space, avoid unecessary block damage, and maximize output of specific resources (sand, gravel, etc)

--checks if block below turtle is the block to mine
function isBlockBelow(blockName)
    if turtle.detectDown() then
        local success, blockInfo = turtle.inspectDown()
        if success and blockInfo.name == blockName then
            return true
        else
            return false
        end
    else
        return false
    end
end
 
-- Function to Mine to Depth until the specific block is found, then it backtracks to the top
--unlike mine, this turtle backtracks to avoid mining unecessary blocks
--a detection system can be programmed here to avoid backtracking (however this may never be done as the turtle cannot retain memory of ALL community blocks that behave like gravel/sand)
function smartMineDepth(blockname)
  i = 1
  while i ~= depth do
    if turtle.down() then
        i = i + 1
    else
        if isBlockBelow(blockname) then
            turtle.digDown()
        else
            break
        end
    end
  end
  i = i - 1
  for j = 1, i do
    turtle.up()
  end
end

-- Function to quarry out an area of a specific bloc
function smartMine(blockname)
  for i = 1, length do
    for j = 1, width do
      smartMineDepth(blockname)
      turtleForward.moveForward()
    end
    if i < length then
      if i % 2 == 1 then
        smartMineDepth(blockname)
        turtle.turnRight()
        turtleForward.moveForward()
        turtle.turnRight()
      else
        smartMineDepth(blockname)
        turtle.turnLeft()
        turtleForward.moveForward()
        turtle.turnLeft()
      end
    end
  end
end
