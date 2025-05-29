--TO DO:
-- Fix infamous width/length reverse issue
-- Comments
-- Overloaded functionality with other quarry options (smartquarry, etc.)

os.loadAPI("TurtleFuel.lua")
os.loadAPI("TurtlePredict.lua")

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

function fuelcheckandmine(length, width, depth, start)
  fuelcost = TurtlePredict.predictSimpleQuarry(length, width, depth, start)
  if fuelcost > turtle.getFuelLevel() then
    if not refuel(fuelcost) then
      return false
    end
  end
  return true
  TurtleQuarry.quarry(length, width, depth, start)
end

function getUserInput()
  invalid = true
    while invalid do
      clearScreen()
      print("Enter Length: ")
      width = tonumber(read())
      print("Enter Width: ")
      length = tonumber(read())
      print("Enter Depth: ")
      depth = tonumber(read())
      print("Return to Start? (1 for yes, 2 for no)")
      start = tonumber(read())
      if width == nil or width == 0 then
        print("Invalid Length!")
      elseif length == nil or length == 0 then
        print("Invalid Width!")
      elseif depth == nil or depth == 0 then
        print("Invalid Depth!")
      elseif start ~= 1 and start ~= 2 then
        print("Invalid Start Choice!")
      else
        invalid = false
      end
    end
    if start == 1 then
      start = "return"
    else
      start = ""
    end
    return length, width, depth, start
end

function finalChecks(volume)
  choice = 0
  print("Volume: " .. volume .. " blocks")
  if volume > 800 then
    print("WARNING! Volume over 800")
    print("Max is 1024 with Empty Inventory")
    print("With Stacks of 64.")
  end
  print("Proceed?")
  print("Yes = 1, No = 2")
  choice = tonumber(read())
  if choice == 1 then
    return true
  else
    return false
  end
end
 
function quarry()
  while not check do
    length, width, depth, start = getUserInput()
    volume = length * width * depth 
    check = finalChecks(volume)
      if check then
        fuelcheckandmine(length, width, depth, start)
      end
    end
end
