--pathing in the following code is used to project turtle pathways to ensure
--1. Un-nessesary enviorment damage
--2. Potential turtle colision
--3. Log pathways to retrieve malfunctioning/lost turtles

--function to get turtle location. (future implementation will include smart front-end gps equip features)
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

--function to set global variables that calculate travel distances and target coordinates
function setGobalVars(ntx, nty, ntz, cx, cy, cz, newpath)
  path = newpath or {}
  tx = ntx
  ty = nty - 1
  tz = ntz
  diffx = tx - cx
  diffy = ty - cy
  diffz = tz - cz
  diffhc = 250 - cy
  diffht = 250 - ty
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

--function to predict fuel cost and map out the turtle path in 1 dimension. Also returns the simulated end position of the turtle
function predict1D(dim, diff, fuelcost, path)
  neg = diff / math.abs(diff)
  for increment = 1, math.abs(diff) do
    x, y, z = incrementVar(dim, increment, neg)
    table.insert(path, {x, y, z})
    fuelcost = fuelcost + 1
  end
  return fuelcost, {x, y, z}, path
end

--function to predict fuel cost and map out the turtle path for a 1 way trip.
function predict1Path(ntx, nty, ntz, newpath)
  cx, cy, cz = getTurtleLocation()
  fuelcost = 0
  setGobalVars(ntx, nty, ntz, cx, cy, cz, newpath)
  fuelcost, pos, path = predict1D("y", diffy, fuelcost, path)
  cy = pos[2]
  fuelcost, pos, path = predict1D("x", diffx, fuelcost, path)
  cx = pos[1]
  fuelcost, pos, path = predict1D("z", diffz, fuelcost, path)
  return fuelcost, path
end

--function to predict fuel cost and map out the turtle path for a 1 way trip that elevates to cruising altitude.
--cruising altitude is at 250 blocks and implemented to prevent uncessesary enviorment damage and un-impeded travel.
function predict1LongPath(ntx, nty, ntz, newpath)
  cx, cy, cz = getTurtleLocation()
  fuelcost = 0
  setGobalVars(ntx, nty, ntz, cx, cy, cz, newpath)
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

--function to calculate a turtles trajectory, to and from a location
--(restating and reversing the path may be unnecessary, however its completed now and future adaptations of the code may prove fruitful)
function roundPath(onepath)
  local twopath = {}
  for i = 1, #onepath do
    table.insert(twopath, onepath[i])
  end
  for i = #onepath, 1, -1 do
    table.insert(twopath, onepath[i])
  end
  return twopath
end

--function to predict the fuel cost and pathing for the round trip a turtle may make
function predictRoundPath(ntx, nty, ntz, newpath)
  fuelcost, path = predict1Path(ntx, nty, ntz, newpath)
  fuelcost = fuelcost * 2
  path = roundPath(path)
  return fuelcost, path
end

--function to predict the fuel cost and pathing for the round trip a turtle may make that elevates to cruising altitude.
--cruising altitude is at 250 blocks and implemented to prevent uncessesary enviorment damage and un-impeded travel.
function predictRoundLongPath(ntx, nty, ntz, newpath)
  fuelcost, path = predict1LongPath(ntx, nty, ntz, newpath)
  fuelcost = fuelcost * 2
  path = roundPath(path)
  return fuelcost, path
end
  
