--لا تلعب في شيييي

RegisterNetEvent('qb-DEAgarage:client:spawnvehicle', function(dacca)
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    local isused = QBCore.Functions.SpawnClear(Shorts.vehicle.coords, Shorts.vehicle.Coordsradius)
    local vehicle = dacca.vehicle
    local Grades = QBCore.Functions.GetPlayerData().job.grade.level
    local CopGrade = dacca.CopGrade
    if isused == true then
    for k, v in pairs(CopGrade) do
        print(v)
    if Grades == v then
        QBCore.Functions.Progressbar("Tkae", ' The Vehicleis Leaving The Garage ', 4000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            DoScreenFadeOut(500)
            Wait(1000)
        QBCore.Functions.SpawnVehicle(vehicle, function(veh)
            local plate = QBCore.Functions.GetPlate(veh)

            SetEntityHeading(veh, Shorts.vehicle.heading)
            SetVehicleModKit(veh, 0)
            TriggerEvent("vehiclekeys:client:SetOwner", plate)
            TriggerServerEvent('qb-DEAgarage:server:SaveVehicle', plate, vehicle)
            DoScreenFadeIn(500)
        end, Shorts.vehicle.coords, true)
    end)
    end
    end
    end
    end
end)
