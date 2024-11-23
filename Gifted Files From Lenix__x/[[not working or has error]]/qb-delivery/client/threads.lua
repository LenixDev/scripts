--[[ Core Thread]]
CreateThread(function()
    while Koci.Framework == nil do
        Koci.Framework = Utils.Functions.GetFramework()
        Wait(100)
    end
end)

function Koci.Client.Functions.Thread_DeliveryDestinationTick()
    Koci.Client.Player.onDelivery = true
    CreateThread(function()
        local _infoNotif = false
        local isDrawTextUIOpen = false
        while Koci.Client.Player.onDelivery do
            local taskVehicle = NetToVeh(Koci.Client.Player.taskVehicleNetId)
            local sleep = 1000
            local _destination = Koci.Client.Player.currentDestination
            local PlayerPedId = PlayerPedId()
            local playerCoords = GetEntityCoords(PlayerPedId)
            local targetCoords = _destination.coords
            local distance = #(playerCoords - vec3(targetCoords.x, targetCoords.y, targetCoords.z))
            if distance < 25 then
                sleep = 1
                if distance < 1.5 and Koci.Client.Player.havePropInHand then
                    if not Koci.Client.Player.isBusy then
                        if Config.TextUIType == "drawtext" then
                            Koci.Utils.DrawText3D(
                                targetCoords,
                                "[E] " .. _t("game.target.deliver_cargo")
                            )
                        else
                            if not isDrawTextUIOpen then
                                isDrawTextUIOpen = true
                                Koci.Utils.DrawTextUI(
                                    "[E] " ..
                                    _t("game.target.deliver_cargo")
                                )
                            end
                        end
                        if IsControlJustPressed(0, 38) then
                            Koci.Client.Player.isBusy = true
                            Koci.Client.Functions.HandleTaskDestionCompleted_Delivery(_destination)
                            break
                        end
                    end
                else
                    if not _infoNotif then
                        _infoNotif = true
                        Koci.Client.Functions.SetTaskVehicleDoorOpen()
                        Koci.Client.SendNotify(_t("game.delivery.collect_box_back_of_vehicle"), "info")
                    end
                    local vBackPos     = Koci.Utils.GetVehicleBackPosition(taskVehicle)
                    local distFromBack = #(playerCoords - vBackPos)
                    if distFromBack < 1.5 and not Koci.Client.Player.havePropInHand then
                        if not Koci.Client.Player.isBusy then
                            if Config.TextUIType == "drawtext" then
                                Koci.Utils.DrawText3D(
                                    vBackPos,
                                    "[E] " .. _t("game.target.pickup_cargo")
                                )
                            else
                                if not isDrawTextUIOpen then
                                    isDrawTextUIOpen = true
                                    Koci.Utils.DrawTextUI(
                                        "[E] " .. _t("game.target.pickup_cargo")
                                    )
                                end
                            end
                            if IsControlJustPressed(0, 38) then
                                Koci.Client.Player.isBusy = true
                                Koci.Client.Functions.PickUpCargoFromTaskVehicle()
                                Wait(1000)
                            end
                        end
                    else
                        if isDrawTextUIOpen then
                            isDrawTextUIOpen = false
                            Koci.Utils.HideTextUI()
                        end
                    end
                end
            else
                if _infoNotif then
                    _infoNotif = false
                    Koci.Client.Functions.SetTaskVehicleDoorShut()
                end
                if isDrawTextUIOpen then
                    isDrawTextUIOpen = false
                    Koci.Utils.HideTextUI()
                end
            end
            Wait(sleep)
        end
        if isDrawTextUIOpen then
            isDrawTextUIOpen = false
            Koci.Utils.HideTextUI()
        end
    end)
end

function Koci.Client.Functions.Thread_CollectingDestinationTick()
    Koci.Client.Player.onDelivery = true
    CreateThread(function()
        local _infoNotif = false
        local isDrawTextUIOpen = false
        while Koci.Client.Player.onDelivery do
            local taskVehicle  = NetToVeh(Koci.Client.Player.taskVehicleNetId)
            local sleep        = 1000
            local _destination = Koci.Client.Player.currentDestination
            local PlayerPedId  = PlayerPedId()
            local playerCoords = GetEntityCoords(PlayerPedId)
            local targetCoords = _destination.coords
            local distance     = #(playerCoords - vec3(targetCoords.x, targetCoords.y, targetCoords.z))
            local vBackPos     = Koci.Utils.GetVehicleBackPosition(taskVehicle)
            local distFromBack = #(playerCoords - vBackPos)
            if Koci.Client.Player.havePropInHand and distFromBack < 1.5 then
                sleep = 1
                if not Koci.Client.Player.isBusy then
                    if Config.TextUIType == "drawtext" then
                        Koci.Utils.DrawText3D(
                            vBackPos,
                            "[E] " ..
                            _t("game.target.put_cargo",
                                Koci.Client.Player.numberOfCargoInVehicle,
                                Koci.Client.Player.currentTask.goal)
                        )
                    else
                        if not isDrawTextUIOpen then
                            isDrawTextUIOpen = true
                            Koci.Utils.DrawTextUI(
                                "[E] " ..
                                _t("game.target.put_cargo",
                                    Koci.Client.Player.numberOfCargoInVehicle,
                                    Koci.Client.Player.currentTask.goal)
                            )
                        end
                    end
                    if IsControlJustPressed(0, 38) then
                        Koci.Client.Player.isBusy = true
                        Koci.Client.Functions.HandleTaskDestionCompleted_Collecting(_destination)
                        isDrawTextUIOpen = false
                        Koci.Utils.HideTextUI()
                        Wait(1000)
                    end
                end
            end
            if not Koci.Client.Player.havePropInHand and distance < 25 then
                sleep = 1
                if not _infoNotif then
                    _infoNotif = true
                    Koci.Client.SendNotify(_t("game.delivery.collect_box_back_of_vehicle"), "info")
                end
                if distance < 1.5 then
                    if not Koci.Client.Player.isBusy then
                        if Config.TextUIType == "drawtext" then
                            Koci.Utils.DrawText3D(
                                targetCoords,
                                "[E] " .. _t("game.target.pickup_cargo")
                            )
                        else
                            if not isDrawTextUIOpen then
                                isDrawTextUIOpen = true
                                Koci.Utils.DrawTextUI(
                                    "[E] " .. _t("game.target.pickup_cargo")
                                )
                            end
                        end
                        if IsControlJustPressed(0, 38) then
                            Koci.Client.Player.isBusy = true
                            Koci.Client.Functions.PickUpCargoFromDestinationPed()
                            isDrawTextUIOpen = false
                            Koci.Utils.HideTextUI()
                            Koci.Client.Functions.SetTaskVehicleDoorOpen()
                            Wait(1000)
                        end
                    end
                else
                    if isDrawTextUIOpen then
                        isDrawTextUIOpen = false
                        Koci.Utils.HideTextUI()
                    end
                end
            else
                if _infoNotif then
                    _infoNotif = false
                end
            end
            Wait(sleep)
        end
        if isDrawTextUIOpen then
            isDrawTextUIOpen = false
            Koci.Utils.HideTextUI()
        end
    end)
end

function Koci.Client.Functions.Thread_OnPlayerHasPropInHand()
    CreateThread(function()
        while Koci.Client.Player.havePropInHand do
            DisableControlAction(0, 24, true)  -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true)  -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1

            DisableControlAction(0, 45, true)  -- Reload
            DisableControlAction(0, 22, true)  -- Jump
            DisableControlAction(0, 44, true)  -- Cover
            DisableControlAction(0, 37, true)  -- Select Weapon
            DisableControlAction(0, 23, true)  -- Also 'enter'?

            DisableControlAction(0, 288, true) -- Disable phone
            DisableControlAction(0, 289, true) -- Inventory
            DisableControlAction(0, 170, true) -- Animations
            DisableControlAction(0, 167, true) -- Job

            DisableControlAction(0, 26, true)  -- Disable looking behind
            DisableControlAction(0, 73, true)  -- Disable clearing animation
            DisableControlAction(2, 199, true) -- Disable pause screen

            DisableControlAction(0, 59, true)  -- Disable steering in vehicle
            DisableControlAction(0, 71, true)  -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true)  -- Disable reversing in vehicle

            DisableControlAction(2, 36, true)  -- Disable going stealth

            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)
            Wait(1)
        end
    end)
end

function Koci.Client.Functions.Thread_HandOverTaskVehicle()
    Koci.Client.SendNotify(_t("game.delivery.hand_over_task_vehicle"), "info")
    CreateThread(function()
        local _infoNotif = false
        local targetCoords = Koci.Client.Player.workingPoint.employerPed.spawnCoords
        SetNewWaypoint(targetCoords.x, targetCoords.y)
        while Koci.Client.Player.onTask do
            local sleep = 1000
            local playerPedId = PlayerPedId()
            local pedVehicleIsIn = GetVehiclePedIsIn(playerPedId, false)
            if DoesEntityExist(pedVehicleIsIn) and
                GetEntityModel(pedVehicleIsIn) == GetHashKey(Koci.Client.Player.workingPoint.taskVehicle.model) and
                GetPedInVehicleSeat(pedVehicleIsIn, -1) == playerPedId
            then
                local vehicleCoords = GetEntityCoords(pedVehicleIsIn)
                local distance = #(vehicleCoords - vec3(targetCoords.x, targetCoords.y, targetCoords.z))
                if distance < 25 and not Koci.Client.Player.isBusy then
                    sleep = 1
                    if not _infoNotif then
                        _infoNotif = true
                        Koci.Client.SendNotify(_t("game.delivery.can_deliver_getting_out_vehicle"), "info", 5000)
                    end
                    DrawMarker(1,
                        targetCoords.x, targetCoords.y, targetCoords.z - 1.0,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        15.0, 15.0, 1.0,
                        168, 255, 202, 100,
                        false, true, 2, nil, nil, false
                    )
                    if IsControlJustPressed(0, 75) then
                        SetEntityAsMissionEntity(pedVehicleIsIn, true, true)
                        DeleteVehicle(pedVehicleIsIn)
                        Koci.Client.Functions.CompleteTask()
                        return
                    end
                else
                    _infoNotif = false
                end
            end
            Wait(sleep)
        end
    end)
end

function Koci.Client.Functions.Thread_LoadCargoIntoVehicle()
    CreateThread(function()
        local isDrawTextUIOpen = false
        while Koci.Client.Player.onTask and
            Koci.Client.Player.havePropInHand and
            Koci.Client.Player.numberOfCargoInVehicle < Koci.Client.Player.currentTask.goal
        do
            local taskVehicle = NetToVeh(Koci.Client.Player.taskVehicleNetId)
            local sleep = 1000
            if not DoesEntityExist(taskVehicle) then
                return
            end
            local PlayerPedId = PlayerPedId()
            local playerCoords = GetEntityCoords(PlayerPedId)
            local vBackPos = Koci.Utils.GetVehicleBackPosition(taskVehicle)
            local distFromBack = #(playerCoords - vBackPos)
            if distFromBack < 1.5 then
                sleep = 1
                if Config.TextUIType == "drawtext" then
                    Koci.Utils.DrawText3D(
                        vBackPos,
                        "[E] " ..
                        _t("game.target.put_cargo", Koci.Client.Player.numberOfCargoInVehicle,
                            Koci.Client.Player.currentTask.goal)
                    )
                else
                    if not isDrawTextUIOpen then
                        isDrawTextUIOpen = true
                        Koci.Utils.DrawTextUI(
                            "[E] " ..
                            _t("game.target.put_cargo", Koci.Client.Player.numberOfCargoInVehicle,
                                Koci.Client.Player.currentTask.goal)
                        )
                    end
                end
                if IsControlJustPressed(0, 38) then
                    Koci.Client.Functions.PutNewCargoInVehicle()
                    break
                end
            else
                if isDrawTextUIOpen then
                    isDrawTextUIOpen = false
                    Koci.Utils.HideTextUI()
                end
            end
            Wait(sleep)
        end
        if isDrawTextUIOpen then
            Koci.Utils.HideTextUI()
        end
    end)
end
