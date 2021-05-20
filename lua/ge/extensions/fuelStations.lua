local M = {}
log('I','[FuelStations]', "Initialising...")


local stations = nil
local fuelTypeMap = {}

local ePressed = false
local debug = false

local inactiveColorMap = { gas = ColorF(1,1,0,0.3), ev = ColorF(0,1,0,0.3), any = ColorF(0,0,1,0.3) }
local activeColorMap = { gas = ColorF(1,1,0,0.5), ev = ColorF(0,1,0,0.5), any = ColorF(0,0,1,0.5) }

local function loadMapStations(infopath)
	infopath = infopath or getMissionFilename()
	if infopath == "" then return false end

	local maproot = path.split(infopath) --infopath:sub(1,8+infopath:sub(9):find("/"))

	stations = jsonReadFile(maproot .. "fuelstations.json")

	return stations ~= nil
end

local function onClientPostStartMission(infopath)
	if loadMapStations(infopath) then
		log('I','[FuelStations]', "Loaded stations")
	else
		log('I','[FuelStations]', "Could not load stations for map "..infopath)
	end
end

local function IsEntityInsideArea(pos1, pos2, radius)
	return pos1:distance(pos2) < radius
end

local function addFuel()
	local veh = be:getPlayerVehicle(0)
	if veh then
		veh:queueLuaCommand("fuelStation.addFuel()")
	end
end

local function setFuelType(id, t)
	fuelTypeMap[id] = t
end

local function onUpdate()
	local canRefill = false
	if debug then
		local pos = be:getObject(0):getPosition()
		debugDrawer:drawTextAdvanced(pos, String(" "..tostring(pos).." "), ColorF(0/255, 0/255, 0/255, 255/255), true, false, ColorI(255,255,255,255))
		local topPos = vec3(pos) + vec3(0,0,3)
		debugDrawer:drawCylinder(pos, topPos:toPoint3F(), 0.05, ColorF(1,0.2,0.2,0.7)) --bottom, top, radius, color
	end

	if not stations then return end

	local activeVeh = be:getPlayerVehicle(0)
	local activeFuelType = "any"

	if activeVeh then -- prepare the vehicle
		if MPVehicleGE and (MPGameNetwork.connectionStatus() == 1) and not MPVehicleGE.isOwn(activeVeh:getID()) then
			activeVeh = nil
		else
			if fuelTypeMap[activeVeh:getID()] then
				activeFuelType = fuelTypeMap[activeVeh:getID()]
			else
				activeVeh:queueLuaCommand("fuelStation.getFuelType()")
			end
		end
	end

	for k, spot in pairs(stations) do -- loop through all spots on the current map
		local bottomPos = vec3(spot.location[1], spot.location[2], spot.location[3])
		local topPos = bottomPos + vec3(0,0,2) -- offset vec to get top position (2m tall)

		local spotInRange = false -- is this spot in range? used for color
		local spotCompatible = false -- is this spot compatible?

		if activeVeh then -- we have a car and its ours (if in mp)
			local vehPos = activeVeh:getPosition()

			spotInRange = IsEntityInsideArea(vec3(vehPos.x, vehPos.y,vehPos.z), bottomPos, 1.5)

			spotCompatible = activeFuelType == "any" or spot.type == "any" or activeFuelType == spot.type
			if spotInRange and spotCompatible then
				if debug then
					dump("activeFuelType",activeFuelType)
					dump("spot.type",spot.type)
					dump(fuelTypeMap)
				end
				canRefill = true
			end
		end

		local spotColor = (spotInRange and spotCompatible) and activeColorMap[spot.type] or inactiveColorMap[spot.type] or ColorF(1,1,1,0.5)


		debugDrawer:drawCylinder(bottomPos:toPoint3F(), topPos:toPoint3F(), 1, spotColor) --bottom, top, radius, color
	end

	if canRefill then
		ui_message("Hold E To Refuel", 1, "fuelStations")
		if ePressed then
			addFuel()
		end
	else
		ui_message("", 0, "fuelStations")
	end
end

--debug
M.debug						= function(d) debug = d end
M.savespot					= function(s)
	local pos = be:getObject(0):getPosition()
	local payload = pos.x.."|"..pos.y.."|"..pos.z.."|"..s
	local f = jsonReadFile("waypoints.json") or {}
	local mapname = getMissionFilename()
	f[mapname] = f[mapname] or {}
	table.insert(f[mapname], payload)
	jsonWriteFile("waypoints.json", f)
end

--events
M.onClientPostStartMission	= onClientPostStartMission
M.onUpdate					= onUpdate

--VE
M.ePress					= function(e) ePressed = e end
M.setFuelType				= setFuelType

log('I','[FuelStations]', "Loaded")
return M
