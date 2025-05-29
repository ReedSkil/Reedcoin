--TO DO:
-- Fix infamous width/length reverse issue
-- Comments
-- Overloaded functionality with other quarry options (smartquarry, etc.)

os.loadAPI("TurtleFuel.lua")

local function clearScreen()
  term.clear()
  term.setCursorPos(1, 1)
end

function refuel(fuelcost)
  choice = 0
  while choice ~= 1 then
    TurtleFuel.displayFuelInfo()
    print("Quarry Fuel Cost = " .. fuelcost)
    print("Fuel too Low to Start, Please Insert Buckets")
    print("Type 1 to Refuel, Type 2 to Re-select Quarry")
    choice = tonumber(read())
    TurtleFuel.refuel()
    if choice == 2 then
      return false
    end
  end
  return true
end

function fuelcheckandmine(width, length, depth)
  predictSimpleQuarry.predict(width, length, depth)
  fuelcost = predictSimpleQuarry.getFuelCost()
  if fuelcost > turtle.getFuelLevel() then
    if not refuel(fuelcost) then
      return false
    end
  end
  return true
  simpleQuarry.quarry(width, length, depth)
end

function getUserInput()
  invalid = true
    while invalid do
      clearScreen()
      width = tonumber(userInput.getUserInput("Enter Length: "))
      length = tonumber(userInput.getUserInput("Enter Width: "))
      depth = tonumber(userInput.getUserInput("Enter Depth"))
      if width == nil or width == 0 then
        print("Invalid Length!")
      elseif length == nil or length == 0 then
        print("Invalid Width!")
      elseif depth == nil or depth == 0 then
        print("Invalid Depth!")
      else
        invalid = false
      end
    end
    return length, width, depth
end
 
function quarry()
  choice = 0
  while choice ~= 1 do
    length, width, depth = getUserInput()
    
    volume = length * width * depth  
    print("Volume: " .. volume .. " blocks")
    if volume > 800 then
      print("WARNING! Volume over 800")
      print("Max is 1024 with Empty Inventory")
      print("With Stacks of 64.")
    end
    max = volume > 9000
    if not max then
      print("Proceed?")
      choice = tonumber(userInput.getUserInput("Yes = 1, No = 2"))
      fuelcheckandmine(width, length, depth)
    else
      print("Volume = " .. volume)
      print("Volume Over 5000, Please Reselect Size Constraints")
      print("continue?")
      choice = tonumber(userInput.getUserInput("Yes = 1, No = 2"))
      if choice == 1 then
        fuelcheckandmine(width, length, depth)
      end
    end
end
