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
      if i % 2 == 1 then
        mineColumn(down, blockname)
        turtle.turnRight()
        turtleForward.moveForward()
        turtle.turnRight()
      else
        mineColumn(down, blockname)
        turtle.turnLeft()
        turtleForward.moveForward()
        turtle.turnLeft()
      end
    end
  end
end
