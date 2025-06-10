Framework = Config.Framework == "qb" and exports["qb-core"]:GetCoreObject() or exports['es_extended']:getSharedObject()

Functions = {
	TRIGGER_SERVER_CALLBACK = function(...)
		if Config.Framework == "qb" then
			Framework.Functions.TriggerCallback(...)
		else
			Framework.TriggerServerCallback(...)
		end
	end,

	CHECK_JOB = function()
		if Config.JobRequirement then
			if PlayerData.job.name == Config.Job then
				return true
			else
				return false
			end
		else
			return true
		end
	end,

	DRAW_TEXT_3D = function(text, x, y, z, scaleX, scaleY)
		local onScreen = World3dToScreen2d(x, y, z)
	
		if onScreen then		
			local px,py,pz=table.unpack(GetGameplayCamCoords())
			local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
		
			local scale = (1/dist)*20
			local fov = (1/GetGameplayCamFov())*100
			local scale = scale*fov
		
			SetTextScale(scaleX*scale, scaleY*scale)
			SetTextCentre(1)
			SetTextProportional(1)
			SetTextOutline()
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(2, 0, 0, 0, 150)
	
			SetTextEntry("STRING")
			AddTextComponentString(text)
			SetDrawOrigin(x, y, z)
			EndTextCommandDisplayText(0.0, 0.0)
			ClearDrawOrigin()
		end
	end,

	CREATE_VEHICLE = function(coords)
		local model = GetHashKey(Config.Vehicle)

		RequestModel(model)

		while not HasModelLoaded(model) do
			Wait(1)
		end

		local vehicle = CreateVehicle(model, coords, true, false)

		SetVehicleOnGroundProperly(vehicle)
		SetVehicleNumberPlateText(vehicle, "RENTAL")
		SetVehicleColours(vehicle, 111, 111)
		SetVehicleExtraColours(vehicle, 111, 111)
		SetVehicleWindowTint(vehicle, 1)
		SetVehicleEngineOn(vehicle, true, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleDirtLevel(vehicle, 0.0)
		SetVehicleLivery(vehicle, 1)
		SetVehicleFuelLevel(vehicle, 100.0)

		if Config.Framework == "qb" then TriggerEvent("vehiclekeys:client:SetOwner", Framework.Functions.GetPlate(vehicle)) end

		return vehicle
	end,

	FIND_EMPTY_LOT = function()
		for _, emptySpace in pairs(Config.ParkingLots) do
			if not IsPositionOccupied(emptySpace.x, emptySpace.y, emptySpace.z, 2.0, 0, 1, 1, 0, 0, 0, 0) then
				return emptySpace
			end
		end

		return false
	end,

	GET_NEXT_STOP = function()
		if stopId > #CurrentJob.Stops or CurrentJob.Stops[stopId].Level > level then
			stopId = 1
			goinBack = true
			Config.Notify(Translation[Config.Locale].GOING_BACK, "success", 5000)
		end

		if stopBlip then
			RemoveBlip(stopBlip)
		end

		local stop = CurrentJob.Stops[stopId]

		ClearGpsMultiRoute()
		StartGpsMultiRoute(6, true, true)
		AddPointToGpsMultiRoute(stop.StopCoords.x, stop.StopCoords.y, stop.StopCoords.z)
		SetGpsMultiRouteRender(true)

		stopBlip = Functions.CREATE_BLIP(
			stop.StopCoords.x,
			stop.StopCoords.y, 
			stop.StopCoords.z, 
			stop.StopBlip.Sprite, 
			stop.StopBlip.Color, 
			stop.StopBlip.Text, 
			stop.StopBlip.Scale
		)

		local nextStop = ""
		local oldStop = CurrentJob.Stops[stopId-1] and CurrentJob.Stops[stopId-1].StopName or "Garage"

		if stopId+1 > #CurrentJob.Stops or CurrentJob.Stops[stopId+1].Level > level then
			nextStop = CurrentJob.Stops[1]
		else
			nextStop = CurrentJob.Stops[stopId+1]
		end

		SendNUIMessage({
			action = "updateStops",
			oldStop = oldStop,
			activeStop = stop.StopName,
			nextStop = nextStop.StopName,
		})

		TriggerServerEvent("aty_busjob:updateWorker", stop.StopName)
		createdPassengers = Functions.CREATE_PASSENGERS(stop)
		return stop
	end,

	CREATE_PASSENGERS = function(stop)
		local maxPassengers = math.random(stop.MinPassengers, stop.MaxPassengers)

		for i = 1, maxPassengers do
			local randomNumber = math.random(0, 100)
			local randomNumber2 = math.random(0, 100)
			local randomPed = math.random(1, #Config.PassengerPeds)

			local pedHashKey = GetHashKey(Config.PassengerPeds[randomPed])
	
			RequestModel(pedHashKey)
			while not HasModelLoaded(pedHashKey) do
				Wait(0)
			end

			local ped = CreatePed(0, pedHashKey, stop.PassengerWaitCoords.x + (randomNumber / 100), stop.PassengerWaitCoords.y + (randomNumber2 / 100), stop.PassengerWaitCoords.z - 1, stop.PassengerWaitCoords.w, false, true)
			
			SetBlockingOfNonTemporaryEvents(ped, true)
			SetPedDiesWhenInjured(ped, false)
			SetPedCanPlayAmbientAnims(ped, false)
			SetPedCanRagdollFromPlayerImpact(ped, false)
			SetEntityInvincible(ped, true)
			SetEntityAsMissionEntity(ped, true, true)
			FreezeEntityPosition(ped, true)

			for _, passenger in pairs(passengers) do
				if passenger.ped == ped then
					SetEntityNoCollisionEntity(ped, passenger.ped, true)
				end
			end

			table.insert(passengers, {ped = ped, inVeh = false, changed = false})
		end

		return maxPassengers
	end,

	TASK_MAKE_RANDOM_PEDS_LEAVE_VEH = function(ped, vehicle)
		if stopId == 1 then
			for _, passenger in pairs(passengers) do
				if passenger.inVeh then
					TaskLeaveVehicle(passenger.ped, vehicle, 0)
					TaskWanderStandard(passenger.ped, 10.0, 10)
					table.remove(passengers, _)
					Citizen.SetTimeout(5000, function()
						SetPedAsNoLongerNeeded(passenger.ped)
						DeletePed(passenger.ped)
					end)
				end
			end
		else
			for _, passenger in pairs(passengers) do
				if passenger.ped == ped and passenger.inVeh then
					TaskLeaveVehicle(passenger.ped, vehicle, 0)
					TaskWanderStandard(passenger.ped, 10.0, 10)
					table.remove(passengers, _)
					Citizen.SetTimeout(5000, function()
						SetPedAsNoLongerNeeded(passenger.ped)
						DeletePed(passenger.ped)
					end)
				end
			end
		end
	end,

	IS_ALL_PEDS_IN = function()
		local allIn = true

		for _, passenger in pairs(passengers) do
			if not passenger.inVeh then
				allIn = false
			end
		end

		return allIn
	end,

	FIND_FREE_SEAT = function(seats, busySeats)
		local randomSeat = math.random(1, seats)

		if busySeats then
			for _, seat in pairs(busySeats) do
				if randomSeat == seat then
					return Functions.FIND_FREE_SEAT(seats, busySeats)
				end
			end
		end

		if IsVehicleSeatFree(CurrentJob.Vehicle, randomSeat) and randomSeat ~= 2 and randomSeat ~= 1 then
			return randomSeat
		else
			return Functions.FIND_FREE_SEAT(seats)
		end
	end,

	CREATE_PED_ON_COORD = function()
		local pedHashKey = GetHashKey(Config.NPC.hash)
	
		RequestModel(pedHashKey)
		while not HasModelLoaded(pedHashKey) do
			Wait(0)
		end

		local ped = CreatePed(0, pedHashKey, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 1, Config.NPC.heading, false, true)
		
		SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedDiesWhenInjured(ped, false)
		SetPedCanPlayAmbientAnims(ped, false)
		SetPedCanRagdollFromPlayerImpact(ped, false)
		SetEntityInvincible(ped, true)
		FreezeEntityPosition(ped, true)
		SetEntityAsMissionEntity(ped, true, true)

		return ped
	end,

	CREATE_BLIP = function(x, y, z, sprite, color, text, scale)
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, sprite)
		SetBlipDisplay(blip, 2)
		SetBlipScale(blip, scale)
		SetBlipColour(blip, color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)

		return blip
	end,

	CANCEL_JOB = function()
		if DoesEntityExist(CurrentJob.Vehicle) then
			DeleteEntity(CurrentJob.Vehicle)
		end

		if DoesBlipExist(stopBlip) then
			RemoveBlip(stopBlip)
		end

		for _, passenger in pairs(passengers) do
			if DoesEntityExist(passenger.ped) then
				DeleteEntity(passenger.ped)
			end
		end

		TriggerServerEvent("aty_busjob:removeWorker")

		ClearGpsMultiRoute()
		CurrentJob = {}
		jobStarted = false
		entered = false
		stopId = 1
		passengers = {}
		createdPassengers = 0

		SendNUIMessage({
			action = "hideTimer",
		})

		SendNUIMessage({
			action = "hideStops",
		})
	end,
}