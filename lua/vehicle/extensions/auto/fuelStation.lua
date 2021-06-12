local M = {}

local eState = input.keys.E

local function updateGFX()
	if input.keys.E ~= eState then
		eState = (input.keys.E == true)
		obj:queueGameEngineLua("if fuelStations then fuelStations.ePress("..tostring(eState)..") end")
	end
end

local function addFuel()
	--log('I',"[Fuel Stations]", "Add Fuel Called")

	local storageType = nil

	for name, storage in pairs(energyStorage.getStorages()) do
		if storage.remainingRatio < 1 then
			storageType = storage.type
			storage:setRemainingRatio(math.min(storage.remainingRatio+0.005, 1))
			--log('I',"[Fuel Stations]", "refueled ".. name)
		end
	end

	if storageType and storageType == "fuelTank" and electrics.values.engineRunning == 1 then
		if math.random() < 0.002 then
			beamstate.breakAllBreakgroups()
			fire.explodeVehicle()
			ui_message("Turn off your engine!", 5, "fuelStationsBoom")
		end
	end
end

local function getFuelType()
	if tableSize(energyStorage.getStorages()) == 0 then
		log('I',"[Fuel Stations]", "did not find any fuel sources")
		obj:queueGameEngineLua("if fuelStations then fuelStations.setFuelType("..obj:getID()..",'none') end")
		return
	end
	for _, storage in pairs(energyStorage.getStorages()) do
		if storage.type == "fuelTank" then
			--log('I',"[Fuel Stations]", "found gas tank")
			obj:queueGameEngineLua("if fuelStations then fuelStations.setFuelType("..obj:getID()..",'gas') end")
			return
		elseif storage.type == "electricBattery" then
			--log('I',"[Fuel Stations]", "found ev battery")
			obj:queueGameEngineLua("if fuelStations then fuelStations.setFuelType("..obj:getID()..",'ev') end") 
			return
		end
	end
	log('I',"[Fuel Stations]", "found other fuel source")
	obj:queueGameEngineLua("if fuelStations then fuelStations.setFuelType("..obj:getID()..",'any') end") 
end

local function repairVehicle()
	local fuelAmounts = {}
	for name, storage in pairs(energyStorage.getStorages()) do
		fuelAmounts[name] = storage.remainingRatio
	end
	
	guihooks.reset()

	damageTracker.reset()
	wheels.reset()
	electrics.reset()
	powertrain.reset()
	energyStorage.reset()
	controller.reset()
	wheels.resetSecondStage()
	controller.resetSecondStage()
	drivetrain.reset()

	for name, ratio in pairs(fuelAmounts) do
		energyStorage.getStorage(name):setRemainingRatio(ratio)
	end
end


M.repairVehicle = repairVehicle

M.addFuel = addFuel
M.getFuelType = getFuelType
M.onReset = getFuelType

M.updateGFX = updateGFX

log('I',"[Fuel Stations]", "Script loaded")

return M
