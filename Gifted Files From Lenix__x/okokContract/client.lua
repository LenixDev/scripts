local QBCore = exports["qb-core"]:GetCoreObject()
local prop = nil

RegisterNetEvent('okokContract:doRequest')
AddEventHandler('okokContract:doRequest', function()
	local closestPlayer, playerDistance = QBCore.Functions.GetClosestPlayer()
	
	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local closestPlayerID = GetPlayerServerId(closestPlayer)
		exports['okokRequests']:requestMenu(closestPlayerID, 10000, "<i class='fas fa-car'></i>&nbsp;BUY VEHICLE", "Do you want to buy this vehicle?", "okokContract:OpenContractInfo", "client")
	end
end)

RegisterNetEvent('okokContract:GetVehicleInfo')
AddEventHandler('okokContract:GetVehicleInfo', function(source_playername, date, description, price, source)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = QBCore.Functions.GetClosestPlayer()
	local sellerID = source
	target = GetPlayerServerId(closestPlayer)

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = QBCore.Functions.GetClosestVehicle(coords)
		local vehiclecoords = GetEntityCoords(vehicle)
		local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
		if DoesEntityExist(vehicle) and (vehDistance <= 3) then
			local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
			TriggerServerEvent('okokContract:Checker', vehProps.plate)
			QBCore.Functions.TriggerCallback("okokContract:GetTargetName", function(targetName)
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'openContractSeller',
					plate = vehProps.plate,
					model = GetDisplayNameFromVehicleModel(vehProps.model),
					source_playername = source_playername,
					sourceID = sellerID,
					target_playername = targetName,
					targetID = target,
					date = date,
					description = description,
					price = price
				})
			end, target, vehProps.plate)
		else
			ClearPedTasks(PlayerPedId())
			ClearPedSecondaryTask(PlayerPedId())
			DeleteObject(prop)
			exports['okokNotify']:Alert("VEHICLE", "You need to be near a vehicle in order to do that", 10000, 'error')
		end
	else
		ClearPedTasks(PlayerPedId())
		ClearPedSecondaryTask(PlayerPedId())
		DeleteObject(prop)
		exports['okokNotify']:Alert("VEHICLE", "You need to be near someone in order to do that ", 10000, 'error')
	end
end)

RegisterNetEvent('okokContract:OpenContractInfo')
AddEventHandler('okokContract:OpenContractInfo', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle = QBCore.Functions.GetClosestVehicle(coords)
	local vehiclecoords = GetEntityCoords(vehicle)
	local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
	if DoesEntityExist(vehicle) and (vehDistance <= 3) then
		local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		local isBlacklisted = false
		if Config.BlacklistedVehicles[1] ~= nil then
			for k,v in ipairs(Config.BlacklistedVehicles) do
				if GetDisplayNameFromVehicleModel(vehProps.model) == v then
					isBlacklisted = true
					break
				end
			end
		end

		if not isBlacklisted then
			QBCore.Functions.TriggerCallback("okokContract:checkIfOwnsVehicle", function(ownsVehicle)
				if ownsVehicle then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'openContractInfo'
					})
					TriggerEvent('okokContract:startContractAnimation')
				else
					exports['okokNotify']:Alert("VEHICLE", "You do not own this vehicle", 10000, 'error')
				end
			end, vehProps.plate)
		else
			exports['okokNotify']:Alert("VEHICLE", "You can't sell this vehicle!", 10000, 'error')
		end
	else
		exports['okokNotify']:Alert("VEHICLE", "You need to be near a vehicle in order to do that", 10000, 'error')
	end
end)

RegisterNetEvent('okokContract:OpenContractOnBuyer')
AddEventHandler('okokContract:OpenContractOnBuyer', function(data)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'openContractOnBuyer',
		plate = data.plateNumber,
		model = data.vehicleModel,
		source_playername = data.sourceName,
		sourceID = data.sourceID,
		target_playername = data.targetName,
		targetID = data.targetID,
		date = data.date,
		description = data.description,
		price = data.price
	})
end)

RegisterNUICallback("action", function(data, cb)
	if data.action == "submitContractInfo" then
		TriggerServerEvent("okokContract:SendVehicleInfo", data.vehicle_description, data.vehicle_price)
		SetNuiFocus(false, false)
	elseif data.action == "signContract1" then
		TriggerServerEvent("okokContract:SendContractToBuyer", data)
		ClearPedTasks(PlayerPedId())
		ClearPedSecondaryTask(PlayerPedId())
		DeleteObject(prop)
		SetNuiFocus(false, false)
	elseif data.action == "signContract2" then
		TriggerServerEvent("okokContract:changeVehicleOwner", data)
		ClearPedTasks(PlayerPedId())
		ClearPedSecondaryTask(PlayerPedId())
		DeleteObject(prop)
		SetNuiFocus(false, false)
	elseif data.action == "close" then
		ClearPedTasks(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        DeleteObject(prop)
		SetNuiFocus(false, false)
	end
	cb('ok')
end)

RegisterNetEvent('okokContract:startContractAnimation')
AddEventHandler('okokContract:startContractAnimation', function(player)
	local playerPed = PlayerPedId()
    while (not HasAnimDictLoaded("amb@code_human_wander_clipboard@male@base")) do
    	RequestAnimDict("amb@code_human_wander_clipboard@male@base")
    	Citizen.Wait(0) 
    end
    TaskPlayAnim(playerPed,"amb@code_human_wander_clipboard@male@base","static",8.0, 8.0, -1, 49, 1, 0, 0, 0)

    local coords = GetEntityCoords(ped)
	prop = CreateObject(GetHashKey("p_cs_clipboard"), coords, true, true, true)

	AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.2, 0.1, 0.05, -130.0, -45.0, 0.0, true, true, false, false, 1, true)
end)