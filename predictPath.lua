 --theight must be fixed for logging turtle path correctly

--function to get turtle location. (future implementation will include front end gps equip features)
function getTurtleLocation()
  cx, cy, cz = gps.locate()
  return cx, cy, cz
end

function userGetLocation()
    x = tonumber(userInput.getUserInput("X Cord: "))
    y = tonumber(userInput.getUserInput("Y Cord: "))
    z = tonumber(userInput.getUserInput("Z Cord: "))
    return x, y, z
end

--function to set global variables
function setGobalVars(ntx, nty, ntz, cx, cy, cz)
  path = newPath or {}
  tx = ntx
  ty = nty - 1
  tz = ntz
  diffx = tx - cx
  diffy = ty - cy
  diffz = tz - cz
  diffhc = 250 - cy
  diffht = 250 - ty
end

--function to set global variables
function setGobalVars()
  
  cx, cy, cz = getTurtleLocation()
end

--function to increment the turtles simulated position. 
--Variable to increment is specified with a str under the name "dim"
--neg is used to determine direction on plane (example: if turtle is at y = 30 going to y = 20 turtle must decrement so neg = -1)
function incrementVar(dim, increment, neg)
  x = cx
  y = cy
  z = cz
  if dim == "x" then
    x = x + (increment * neg)
  elseif dim == "y" then
    y = y + (increment * neg)
  elseif dim == "z" then
    z = z + (increment * neg)
  end
  return x, y, z
end

--function to predict fuel cost and map out the turtle path in 1 dimension
function predict1D(dim, diff, fuelcost, path)
  neg = diff / math.abs(diff)
  for increment = 1, math.abs(diff) do
    x, y, z = incrementVar(dim, increment, neg)
    table.insert(path, {x, y, z})
    fuelcost = fuelcost + 1
  end
  return fuelcost, {x, y, z}, path
end

function predictLongPath(ntx, nty, ntz, newPath)
    cx, cy, cz = getTurtleLocation()
    fuelcost = 0
    setGobalVars(ntx, nty, ntz, cx, cy, cz)
    -- Go to Travel Height
    fuelcost, pos, path = predict1D("y", diffhc, fuelcost, path)
    cy = pos[2]
    fuelcost, pos, path = predict1D("x", diffx, fuelcost, path)
    cx = pos[1]
    fuelcost, pos, path = predict1D("z", diffz, fuelcost, path)
    cz = pos[3]
    --Go from Travel Height
    fuelcost, pos, path = predict1D("y", diffht, fuelcost, path)
    return fuelcost, path
end

function predictPath(ntx, nty, ntz, newPath)
  cx, cy, cz = getTurtleLocation()
  fuelcost = 0
  setGobalVars(ntx, nty, ntz, cx, cy, cz)
  fuelcost, pos, path = predict1D("y", diffy, fuelcost, path)
  cy = pos[2]
  fuelcost, pos, path = predict1D("x", diffx, fuelcost, path)
  cx = pos[1]
  fuelcost, pos, path = predict1D("z", diffz, fuelcost, path)
  return fuelcost, path
end
  
