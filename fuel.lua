function displayFuelInfo()
  local fuellevel = turtle.getFuelLevel()
  local maxfuellevel = turtle.getFuelLimit()
  
  if fuellevel == "unlimited" then
    print("Fuel level: Unlimited")
  else
    local fuelpercentage = (fuellevel / maxfuellevel) * 100
    print("Fuel level: " .. fuellevel)
    print("Max fuel level: " .. maxfuellevel)
    print("Fuel percentage: " .. string.format("%.2f", fuelpercentage) .. "%")
  end
  return fuellevel
end


function refuel()
  local fuellevel = turtle.getFuelLevel()
  for slot = 1, 16 do
    turtle.select(slot)  
    local item = turtle.getItemDetail()  
    if not item then
      --do nothing
    elseif item.name == "minecraft:lava_bucket" or item.name == "minecraft:charcoal" or item.name == "minecraft:coal" or item.name == "minecraft:coal_block" then
      turtle.refuel()
  end
  turtle.select(1)
  return fuellevel
end
