local M = {}
print("[Fuel Stations] [VE] Loaded")

local function addFuel()
	print("[Fuel Stations] [VE] Add Fuel Called")
	if energyStorage.getStorage('mainTank') ~= nil then
	  local Tank = energyStorage.getStorage('mainTank').remainingRatio
		if Tank < 1 then
			local Level = Tank + 0.005
			print("Adding Fuel: "..Level)
			energyStorage.getStorage('mainTank'):setRemainingRatio(Level)
		else
			energyStorage.getStorage('mainTank'):setRemainingRatio(1.0)
		end
	end

	if energyStorage.getStorage('mainBattery') ~= nil then
	  local Battery = energyStorage.getStorage('mainBattery').remainingRatio
		if Battery < 1 then
			local Level = Battery + 0.005
			print("Adding Fuel: "..Level)
			energyStorage.getStorage('mainBattery'):setRemainingRatio(Level)
		else
			energyStorage.getStorage('mainBattery'):setRemainingRatio(1.0)
		end
	end

	if energyStorage.getStorage('mainTankL') ~= nil then
	  local Tank = energyStorage.getStorage('mainTankL').remainingRatio
		if Tank < 1 then
			local Level = Tank + 0.005
			print("Adding Fuel: "..Level)
			energyStorage.getStorage('mainTankL'):setRemainingRatio(Level)
		else
			energyStorage.getStorage('mainTankL'):setRemainingRatio(1.0)
		end
	end

	if energyStorage.getStorage('mainTankR') ~= nil then
	  local Tank = energyStorage.getStorage('mainTankR').remainingRatio
		if Tank < 1 then
			local Level = Tank + 0.005
			print("Adding Fuel: "..Level)
			energyStorage.getStorage('mainTankR'):setRemainingRatio(Level)
		else
			energyStorage.getStorage('mainTankR'):setRemainingRatio(1.0)
		end
	end
end

M.addFuel = addFuel

return M
