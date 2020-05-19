local M = {}
print("Fuel Stations Initialising...")

local map = ""
local fuelType = ""
local debug = false
local cVeh = 0

local stations = {
  ["/levels/east_coast_usa/info.json"] = {
   {vec3(-778.813, 485.973, 23.4637), vec3(-778.813, 485.973, 25.4637), "Gas"},
   {vec3(-776.504, 488.427, 23.4637), vec3(-776.504, 488.427, 25.4637), "Gas"},
   {vec3(-775.036, 490.828, 23.4637), vec3(-775.036, 490.828, 25.4637), "Gas"},
   {vec3(-772.457, 493.484, 23.4637), vec3(-772.457, 493.484, 25.4637), "Gas"},
   {vec3(-770.871, 495.714, 23.4637), vec3(-770.871, 495.714, 25.4637), "Gas"},
   {vec3(-768.417, 498.436, 23.4637), vec3(-768.417, 498.436, 25.4637), "Gas"},
   {vec3(704.304, -23.125, 51.8), vec3(704.304, -23.125, 55.0), "Gas"},
   {vec3(708.497, -23.3151, 51.8), vec3(708.497, -23.3151, 55.0), "Gas"},
   {vec3(711.115, -23.5511, 51.8), vec3(711.115, -23.5511, 55.0), "Gas"},
   {vec3(714.968, -23.6462, 51.8), vec3(714.968, -23.6462, 55.0), "Gas"},
   {vec3(717.763, -23.9071, 51.8), vec3(717.763, -23.9071, 55.0), "Gas"},
   {vec3(721.414, -24.0725, 51.8), vec3(721.414, -24.0725, 55.0), "Gas"},
   {vec3(625.651, -183.448, 53.0), vec3(625.651, -183.448, 55.0), "EV"},
   {vec3(622.667, -186.129, 53.0), vec3(622.667, -186.129, 55.0), "EV"},
   {vec3(619.97, -189.098, 53.0), vec3(619.97, -189.098, 55.0), "EV"},
   {vec3(617.164, -192.107, 53.0), vec3(617.164, -192.107, 55.0), "EV"},
 },
 ["/levels/west_coast_usa/info.json"] = {
   {vec3(-480.495, 134.616, 100.212), vec3(-480.495, 134.616, 102.212), "Gas/EV"},
   {vec3(-476.888, 133.5, 100.212), vec3(-476.888, 133.5, 102.212), "Gas/EV"},
   {vec3(-478.933, 126.744, 100.212), vec3(-478.933, 126.744, 102.212), "Gas/EV"},
   {vec3(-482.54, 127.86, 100.212), vec3(-482.54, 127.86, 102.212), "Gas/EV"},
   {vec3(-490.042, 130.875, 100.212), vec3(-490.042, 130.875, 102.212), "Gas/EV"},
   {vec3(-487.997, 137.631, 100.212), vec3(-487.997, 137.631, 102.212), "Gas/EV"},
   {vec3(-484.39, 136.515, 100.212), vec3(-484.39, 136.515, 102.212), "Gas/EV"},
   {vec3(-486.435, 129.759, 100.212), vec3(-486.435, 129.759, 102.212), "Gas/EV"},
   {vec3(-492.171,138.235,100.211), vec3(-492.171,138.235,102.211), "Gas/EV"},
   {vec3(-495.778,139.350,100.211), vec3(-495.778,139.350,102.211), "Gas/EV"},
   {vec3(-497.824,132.595,100.211), vec3(-497.824,132.595,102.211), "Gas/EV"},
   {vec3(-494.217,131.479,100.211), vec3(-494.217,131.479,102.211), "Gas/EV"},
   {vec3(-800.910, 861.350, 74.800), vec3(-800.910, 861.350, 76.800), "Gas/EV"},
   {vec3(-794.05, 852.340, 74.800), vec3(-794.05, 852.340, 76.800), "Gas/EV"},
   {vec3(-800.636, 852.330, 74.800), vec3(-800.636, 852.330, 76.800), "Gas/EV"},
   {vec3(-794.05, 848.565, 74.800), vec3(-794.05, 848.565, 76.800), "Gas/EV"},
   {vec3(-800.582, 848.555, 74.800), vec3(-800.582, 848.555, 76.800), "Gas/EV"},
   {vec3(-800.856, 857.575, 74.800), vec3(-800.856, 857.575, 76.800), "Gas/EV"},
   {vec3(-793.745, 861.358, 74.800), vec3(-793.745, 861.358, 76.800), "Gas/EV"},
   {vec3(-793.691, 857.583, 74.800), vec3(-793.691, 857.583, 76.800), "Gas/EV"},
   {vec3(-193.984,522.874,74.830), vec3(-193.984,522.874,76.830), "Gas/EV"},
   {vec3(-183.978,516.118,74.830), vec3(-183.978,516.118,76.830), "Gas/EV"},
   {vec3(-180.021,522.874,74.830), vec3(-180.021,522.874,76.830), "Gas/EV"},
   {vec3(-180.021,516.118,74.830), vec3(-180.021,516.118,76.830), "Gas/EV"},
   {vec3(-200.020,516.517,74.830), vec3(-200.020,516.517,76.830), "Gas/EV"},
   {vec3(-183.978,522.874,74.830), vec3(-183.978,522.874,76.830), "Gas/EV"},
   {vec3(-203.978,516.517,74.830), vec3(-203.978,516.517,76.830), "Gas/EV"},
   {vec3(-200.020,522.781,74.830), vec3(-200.020,522.781,76.830), "Gas/EV"},
   {vec3(-203.978,522.781,74.830), vec3(-203.978,522.781,76.830), "Gas/EV"},
   {vec3(-190.027,522.874,74.830), vec3(-190.027,522.874,76.830), "Gas/EV"},
   {vec3(-190.019,515.983,74.830), vec3(-190.019,515.983,76.830), "Gas/EV"},
   {vec3(-193.976,515.983,74.830), vec3(-193.976,515.983,76.830), "Gas/EV"},
   {vec3(417.285,-229.916,145.066), vec3(417.285,-229.916,147.066), "Gas/EV"},
 },
 ["/levels/hirochi_raceway/info.json"] = {
   {vec3(-423.444, 327.058, 24.188), vec3(-423.444, 327.058, 26.188), "Gas/EV"},
   {vec3(-313.5, 62.4, 32), vec3(-313.5, 62.4, 34), "Gas/EV"},
   {vec3(-311, 60, 32), vec3(-311, 60, 34), "Gas/EV"},
 },
 ["/levels/utah/info.json"] = {
   {vec3(809.5, -158, 144.3), vec3(809.5, -158, 146.3), "Gas/EV"},
   {vec3(812.5, -157.6, 144.3), vec3(812.5, -157.6, 146.3), "Gas/EV"},
   {vec3(811.2, -150, 144.3), vec3(811.2, -150, 146.3), "Gas/EV"},
   {vec3(808.2, -150.6, 144.3), vec3(808.2, -150.6, 146.3), "Gas/EV"},
 },
 ["/levels/italy/info.json"] = {
   {vec3(-972.806, 948.605, 392.601), vec3(-972.806, 948.605, 394.601), "EV"},
   {vec3(-971.062, 950.279, 392.644), vec3(-971.062, 950.279, 394.644), "EV"},
   {vec3(-969.27, 952.026, 392.662), vec3(-969.27, 952.026, 394.662), "EV"},
   {vec3(-1105.25, 773.865, 378.202), vec3(-1105.25, 773.865, 380.202), "Gas"},
   {vec3(-1105.36, 768.871, 378.202), vec3(-1105.36, 768.871, 380.202), "Gas"},
   {vec3(-1101.64, 768.029, 378.203), vec3(-1101.64, 768.029, 380.203), "Gas"},
   {vec3(-1101.21, 773.291, 378.201), vec3(-1101.21, 773.291, 380.201), "Gas"},

   {vec3(1448.81, 1348.93, 147.298), vec3(1448.81, 1348.93, 149.498), "Gas"},
   {vec3(1453.59, 1349.92, 147.229), vec3(1453.59, 1349.92, 149.529), "Gas"},
   {vec3(1448.10, 1352.97, 147.26), vec3(1448.1, 1352.97, 149.56), "Gas"},
   {vec3(1453.08, 1353.72, 147.281), vec3(1453.08, 1353.72, 149.481), "Gas"},

   {vec3(-1611.84, 1523.47, 162.251), vec3(-1611.84, 1523.47, 164.251), "Gas"},
   {vec3(-1614.28, 1519.66, 162.256), vec3(-1614.28, 1519.66, 164.256), "Gas"},
   {vec3(-1617.71, 1521.93, 162.261), vec3(-1617.71, 1521.93, 164.261), "Gas"},
   {vec3(-1615.34, 1525.46, 162.256), vec3(-1615.34, 1525.46, 164.256), "Gas"},

   {vec3(-1626.79, 1527.72, 162.254), vec3(-1626.79, 1527.72, 164.254), "Gas"},
   {vec3(-1624.43, 1531.36, 162.256), vec3(-1624.43, 1531.36, 164.256), "Gas"},
   {vec3(-1623.26, 1525.68, 162.261), vec3(-1623.26, 1525.68, 164.261), "Gas"},
   {vec3(-1621.03, 1529.18, 162.256), vec3(-1621.03, 1529.18, 164.256), "Gas"},

   {vec3(-1758.49, 1324.84, 138.19), vec3(-1758.49, 1324.84, 140.19), "Gas"},
   {vec3(-1758.03, 1328.25, 138.188), vec3(-1758.03, 1328.25, 140.188), "Gas"},

   {vec3(1214.599,-810.765,145.173), vec3(1214.599,-810.765,147.173), "Gas"},
   {vec3(1216.699,-807.445,145.245), vec3(1216.699,-807.445,147.245), "Gas"},
   {vec3(1210.020,-807.812,145.234), vec3(1210.020,-807.812,147.234), "Gas"},
   {vec3(1212.060,-804.469,145.291), vec3(1212.060,-804.469,147.291), "Gas"},

   {vec3(1199.18,-797.823,145.786), vec3(1199.18,-797.823,147.786), "EV"},
   {vec3(1202.29,-793.992,145.764), vec3(1202.29,-793.992,147.764), "EV"},

   {vec3(1113.25, -686.448, 146.031), vec3(1113.25, -686.448, 147.531), "EV"},

   {vec3(1113.96, 1309.27, 143.007), vec3(1113.96, 1309.27, 145.007), "EV"},
   {vec3(1124.09, 1308.87, 143.007), vec3(1124.09, 1308.87, 145.007), "EV"},
   {vec3(1156.11, 1305.27, 143.788), vec3(1156.11, 1305.27, 145.788), "EV"},
   {vec3(1165.86, 1304.98, 143.981), vec3(1165.86, 1304.98, 145.981), "EV"},

   {vec3(-730.8, -1327.5, 142.65), vec3(-730.8, -1327.5, 144.65), "EV"},
   {vec3(-725.4, -1324.7, 142.65), vec3(-725.4, -1324.7, 144.65), "EV"},

   {vec3(-543.223, -210.488, 231.101), vec3(-543.223, -210.488, 233.501), "Gas"},
   {vec3(-547.45, -207.176, 231.119), vec3(-547.45, -207.176, 233.519), "Gas"},
   {vec3(-539.732, -206.318, 231.144), vec3(-539.732, -206.318, 233.444), "Gas"},
   {vec3(-543.518, -202.954, 231.179), vec3(-543.518, -202.954, 233.479), "Gas"},

   {vec3(624.425,1357.562,155.989),vec3(624.425,1357.562,157.989),"EV"},
   {vec3(616.339,1357.562,155.989),vec3(616.339,1357.562,157.989),"EV"},
   {vec3(620.269,1357.562,155.989),vec3(620.269,1357.562,157.989),"EV"},
   {vec3(612.114,1357.562,155.989),vec3(612.114,1357.562,157.989),"EV"},

   {vec3(-1065.38, -1353.31, 324.082), vec3(-1065.38, -1353.31, 326.482), "Gas"},
   {vec3(-1065.42, -1358.48, 324.082), vec3(-1065.42, -1358.48, 326.482), "Gas"},

   {vec3(634.715,1482.61,139.093), vec3(634.715,1482.61,141.093), "Gas"},
   {vec3(628.822,1482.6,139.093), vec3(628.822,1482.6,141.093), "Gas"},

   {vec3(679.646, 589.616, 173.998), vec3(679.646, 589.616, 175.998), "Gas"},
   {vec3(683.65, 585.714, 173.998), vec3(683.65, 585.714, 175.998), "Gas"},
   {vec3(686.265, 588.252, 173.996), vec3(686.265, 588.252, 175.996), "Gas"},
   {vec3(682.307, 592.144, 173.969), vec3(682.307, 592.144, 175.969), "Gas"},

   {vec3(1433.68, 1348.8,  147.182), vec3(1433.68, 1348.8,  149.182), "EV"},
   {vec3(1430.98, 1348.11, 147.165), vec3(1430.98, 1348.11, 149.165), "EV"},

   {vec3(462.431, 1276.049, 171.582), vec3(462.431, 1276.049, 173.682), "Gas"},
   {vec3(466.192, 1270.933, 171.507), vec3(466.192, 1270.933, 173.707), "Gas"},
   {vec3(467.250, 1274.760, 171.584), vec3(467.250, 1274.760, 173.684), "Gas"},
   {vec3(461.373, 1272.222, 171.504), vec3(461.373, 1272.222, 173.704), "Gas"},

   {vec3(137.447, -270.667, 193.566), vec3(137.447, -270.667, 195.766),"Gas"},
   {vec3(133.501, -265.860, 193.566), vec3(133.501, -265.860, 195.766),"Gas"},
   {vec3(137.447, -265.860, 193.566), vec3(137.447, -265.860, 195.766),"Gas"},
   {vec3(133.501, -270.667, 193.566), vec3(133.501, -270.667, 195.766),"Gas"},
 }
}

local function distance (pos1, pos2, useZ)
  local dx = pos1.x - pos2.x
  local dy = pos1.y - pos2.y
  local dz = pos1.z - pos2.z
  if useZ then
    return math.sqrt ( dx * dx + dy * dy + dz * dz )
  else
    return math.sqrt ( dx * dx + dy * dy )
  end
end

local function IsEntityInsideArea(pos1, pos2)
  if distance(pos1, pos2, true) < 1 then
    return true
  else
    return false
  end
end

local function addFuel()
  --print("Should i add fuel?")
  local veh = be:getObjectByID(cVeh)
  if veh then
    print("[Fuel Stations] [GE] Calling Add Fuel VE")
    veh:queueLuaCommand("fuelStation.addFuel()")
  end
end

local function onVehicleSwitched(oldID, newID)
	print("[Fuel Stations] Active Vehicle Switched : "..oldID.." - "..newID)
	cVeh = newID
  local veh = be:getObjectByID(newID)
  veh:queueLuaCommand("fuelStation.getFuelType()")
end

local function onVehicleSpawned(gameVehicleID)
	--print("[BeamMP] Vehicle spawned : "..gameVehicleID)
	local veh = be:getObjectByID(gameVehicleID)
  cVeh = gameVehicleID
  veh:queueLuaCommand("extensions.addModulePath('lua/vehicle/extensions/FuelStation')") -- Load lua files
  veh:queueLuaCommand("extensions.loadModulesInDirectory('lua/vehicle/extensions/FuelStation')")
  veh:queueLuaCommand("fuelStation.getFuelType()")
end

local function setFuelType(t)
  fuelType = t
end

local function onUpdate()
  local atStation = false
  if debug then
    debugDrawer:drawTextAdvanced(be:getObject(0):getPosition(), String(" "..tostring(be:getObject(0):getPosition())), ColorF(194/255, 55/255, 55/255, 255/255), true, false, ColorI(0,0,0,127))
  end
  map = getMissionFilename()
  for k = 1, #stations[map] do
    --print("Using Map: "..tostring(stations[map][k][3]))
    local color = 0
    if stations[map][k][3] == "EV" then
      color = ColorF(0.1,0.9,0.1,0.5)
    elseif stations[map][k][3] == "Gas/EV" then
      color = ColorF(0.1,0.8,1.0,0.5)
    else
      color = ColorF(0.9,0.1,0.1,0.5)
    end
    debugDrawer:drawCylinder(stations[map][k][1]:toPoint3F(), stations[map][k][2]:toPoint3F(), 1, color)
    for i = 0, be:getObjectCount() -1 do -- For each vehicle
      local veh = be:getObject(i) --  Get vehicle
      if IsEntityInsideArea(veh:getPosition(), stations[map][k][1]) then
        if stations[map][k][3] == "Gas/EV" or stations[map][k][3] == fuelType then
          -- we are inside one of the filling areas of the map
          --ui_message("Press E To Refuel")
          atStation = true
          be:executeJS('fuelUIShowHide("true", "'..fuelType..'")')
          break
        end
      end
    end
  end
  if not atStation then -- We are not in a spot for filling then we should force the UI to be hidden
    be:executeJS('fuelUIShowHide("false")')
  end
end

M.onUpdate = onUpdate
M.addFuel = addFuel
M.setFuelType = setFuelType
M.onVehicleSwitched       = onVehicleSwitched
M.onVehicleSpawned        = onVehicleSpawned

print("Fuel Stations Loaded")
return M
