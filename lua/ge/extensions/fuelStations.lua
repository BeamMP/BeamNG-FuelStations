local M = {}
print("Fuel Stations Initialising...")

local map = ""
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
end

local function onVehicleSpawned(gameVehicleID)
	--print("[BeamMP] Vehicle spawned : "..gameVehicleID)
	local veh = be:getObjectByID(gameVehicleID)
  veh:queueLuaCommand("extensions.addModulePath('lua/vehicle/extensions/FuelStation')") -- Load lua files
  veh:queueLuaCommand("extensions.loadModulesInDirectory('lua/vehicle/extensions/FuelStation')")
end

local function onUpdate()
  local atStation = false
  if debug then
    debugDrawer:drawTextAdvanced(be:getObject(0):getPosition(), String(" "..tostring(be:getObject(0):getPosition())), ColorF(194/255, 55/255, 55/255, 255/255), true, false, ColorI(0,0,0,127))
  end
  map = getMissionFilename()
  for k = 1, #stations[map] do
    local color = 0
    if stations[map][k][3] == "EV" then
      color = ColorF(0.0,0.9,0.1,0.5)
    else
      color = ColorF(0.9,0.1,0.1,0.5)
    end
    debugDrawer:drawCylinder(stations[map][k][1]:toPoint3F(), stations[map][k][2]:toPoint3F(), 1, color)
    for i = 0, be:getObjectCount() -1 do -- For each vehicle
      local veh = be:getObject(i) --  Get vehicle
      if IsEntityInsideArea(veh:getPosition(), stations[map][k][1]) then
        -- we are inside one of the filling areas of the map
        --ui_message("Press E To Refuel")
        atStation = true
        be:executeJS('fuelUIShowHide("true", "'..stations[map][k][3]..'")')
        break
      end
    end
  end
  if not atStation then -- We are not in a spot for filling then we should force the UI to be hidden
    be:executeJS('fuelUIShowHide("false")')
  end
end

M.onUpdate = onUpdate
M.addFuel = addFuel
M.onVehicleSwitched       = onVehicleSwitched
M.onVehicleSpawned        = onVehicleSpawned

print("Fuel Stations Loaded")
return M
