--[[ Variables ]]
Koci           = {}
Koci.Framework = Utils.Functions.GetFramework()
Koci.Utils     = Utils.Functions
Koci.Callbacks = {}
Koci.Client    = {
    Player = {
        isBusy = false,
        characterName = nil,
        profile = nil,
        level = nil,
        exp = nil,
        nextLeveLExp = nil,
        onDuty = false,
        workingPoint = nil,
        TeamMate = {},
        onTask = false,
        currentTask = nil,
        lastCompletedTaskId = nil,
        isLeader = false,
        havePropInHand = nil,
        numberOfCargoInVehicle = 0,
        taskVehicleNetId = nil,
        onDelivery = false,
        currentDestination = nil,
    },
    startPoints = {},
    employerPeds = {},
    employerPedProps = {},
    currentTeamInvitation = {},
    createdVehicles = {},
    createdTargets = {},
    createdProps = {},
    createdPeds = {},
    blockInvitations = false,
    -- @ --
    Functions = {},
}

--[[ Core Functions ]]
function Koci.Client.TriggerServerCallback(key, callback, ...)
    if not callback then
        callback = function() end
    end
    Koci.Callbacks[key] = callback
    TriggerServerEvent("qb-delivery:Server:HandleCallback", key, ...)
end

function Koci.Client.SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

function Koci.Client.SendNotify(title, type, duration, icon, text)
    system = Config.NotifyType
    if system == "esx_notify" then
        if Config.FrameWork == "esx" then
            Koci.Framework.ShowNotification(title, type, duration)
        end
    elseif system == "qb_notify" then
        if Config.FrameWork == "qb" then
            Koci.Framework.Functions.Notify(title, type)
        end
    elseif system == "custom_notify" then
        Utils.Functions.CustomNotify(nil, title, type, text, duration, icon)
    end
end

function Koci.Client.GetPlayerData()
    if Config.FrameWork == "esx" then
        return Koci.Framework.GetPlayerData()
    elseif Config.FrameWork == "qb" then
        return Koci.Framework.Functions.GetPlayerData()
    end
end

function Koci.Client.IsPlayerLoaded()
    return Config.FrameWork == "esx" and
        Koci.Framework.IsPlayerLoaded() or
        LocalPlayer.state.isLoggedIn
end

--[[ Script Functions]]
function Koci.Client.Functions.DeleteCargoLoadTargets()
    local entities = Koci.Client.createdTargets
    local removedIndices = {}
    for key, value in pairs(entities) do
        if value.key == "cargo_load_target" then
            if Config.TargetType == "ox_target" then
                exports.ox_target:removeZone(value.id)
            elseif Config.TargetType == "qb_target" then
                exports["qb-target"]:RemoveZone(value.id)
            elseif Config.TargetType == "custom" then
                Koci.Utils.CustomTargetSystem.RemoveZone(value.id)
            end
            table.insert(removedIndices, key)
        end
    end
    for i = #removedIndices, 1, -1 do
        table.remove(entities, removedIndices[i])
    end
end

function Koci.Client.Functions.DeleteTargets()
    local entities = Koci.Client.createdTargets
    for key, value in pairs(entities) do
        if Config.TargetType == "ox_target" then
            exports.ox_target:removeZone(value.id)
        elseif Config.TargetType == "qb_target" then
            exports["qb-target"]:RemoveZone(value.id)
        elseif Config.TargetType == "custom" then
            Koci.Utils.CustomTargetSystem.RemoveZone(value.id)
        end
    end
    Koci.Client.createdTargets = {}
end

function Koci.Client.Functions.DeleteEmployerPedTargets()
    local entities = Koci.Client.employerPeds
    if Config.TargetType == "ox_target" then
        exports.ox_target:removeLocalEntity(entities)
    elseif Config.TargetType == "qb_target" then
        exports["qb-target"]:RemoveTargetEntity(entities)
    elseif Config.TargetType == "custom" then
        local groups = point.job
        Koci.Utils.CustomTargetSystem.RemoveTargetEntity(entities)
    end
end

function Koci.Client.Functions.DeleteEmployerPedProps()
    for index, value in pairs(Koci.Client.employerPedProps) do
        if DoesEntityExist(value) then
            DeleteEntity(value)
        end
    end
    Koci.Client.employerPedProps = {}
end

function Koci.Client.Functions.DeleteEmployerPeds()
    Koci.Client.Functions.DeleteEmployerPedProps()
    for index, value in pairs(Koci.Client.employerPeds) do
        if DoesEntityExist(value) then
            DeleteEntity(value)
        end
    end
    Koci.Client.employerPeds = {}
end

function Koci.Client.Functions.DeleteVehicles()
    for index, value in pairs(Koci.Client.createdVehicles) do
        if DoesEntityExist(value) then
            SetEntityAsMissionEntity(value, true, true)
            DeleteEntity(value)
        end
    end
    Koci.Client.createdVehicles = {}
end

function Koci.Client.Functions.DeleteProps()
    for index, value in pairs(Koci.Client.createdProps) do
        if DoesEntityExist(value.id) then
            DeleteEntity(value.id)
        end
    end
    Koci.Client.createdProps = {}
end

function Koci.Client.Functions.DeletePeds()
    for index, value in pairs(Koci.Client.createdPeds) do
        if DoesEntityExist(value) then
            DeleteEntity(value)
        end
    end
    Koci.Client.createdPeds = {}
end

function Koci.Client.Functions.DeleteLastBoxInVehicleBack()
    for key, value in pairs(Koci.Client.createdProps) do
        if value.key == "put_new_cargo_on_vehicle" then
            if DoesEntityExist(value.id) then
                DetachEntity(value.id, false, false)
                DeleteEntity(value.id)
            end
            table.remove(Koci.Client.createdProps, key)
            break
        end
    end
end

function Koci.Client.Functions.CreateEmployerPed(model, coords)
    local function _TaskPlayPedAnim(ped)
        Koci.Utils.LoadAnim("missfam4")
        TaskPlayAnim(ped, "missfam4", "base", 2.0, 2.0, -1, 0, 0, true, true, true)
        RemoveAnimDict("missfam4")
        local createdProp = Koci.Client.Functions.AddPropToPed(
            ped, "p_amb_clipboard_01", 36029,
            0.16, 0.08, 0.1,
            -130.0, -50.0, 0.0,
            false
        )
        if createdProp then
            table.insert(Koci.Client.employerPedProps, createdProp)
        end
    end
    if IsModelValid(model) then
        Koci.Utils.RequestModel(model)
        local createdPed = CreatePed(4, model,
            coords.x, coords.y, coords.z - 1, coords.w,
            false, false
        )
        if DoesEntityExist(createdPed) then
            SetPedDefaultComponentVariation(createdPed)
            SetPedDiesWhenInjured(createdPed, false)
            SetEntityInvincible(createdPed, true)
            FreezeEntityPosition(createdPed, true)
            TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
            SetBlockingOfNonTemporaryEvents(createdPed, true)
            SetModelAsNoLongerNeeded(model)
            table.insert(Koci.Client.employerPeds, createdPed)
            CreateThread(function()
                _TaskPlayPedAnim(createdPed)
            end)
            return createdPed
        end
    end
    return false
end

function Koci.Client.Functions.CreateStartPointDrawTexts(points)
    if next(points) then
        CreateThread(function()
            local isDrawTextUIOpen = false
            while true do
                local sleep = 2000
                local playerCoord = GetEntityCoords(PlayerPedId())
                for key, point in pairs(points) do
                    if point.active then
                        local spawnCoords = point.employerPed.spawnCoords
                        local distance = #(playerCoord - vector3(spawnCoords.x, spawnCoords.y, spawnCoords.z))
                        if distance <= 2.5 then
                            sleep = 1
                            if Config.TextUIType == "drawtext" then
                                Koci.Utils.DrawText3D(spawnCoords, "[E] " .. _t("game.target.toggle_job_duty"))
                            else
                                if not isDrawTextUIOpen then
                                    isDrawTextUIOpen = true
                                    Koci.Utils.DrawTextUI("[E] " .. _t("game.target.toggle_job_duty"))
                                end
                            end
                            if IsControlJustPressed(0, 38) then
                                Koci.Client.Functions.ToggleDeliveryJobDuty(point)
                                Wait(2000)
                            end
                        else
                            if isDrawTextUIOpen then
                                isDrawTextUIOpen = false
                                Koci.Utils.HideTextUI()
                            end
                        end
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
end

function Koci.Client.Functions.CreateCargoLoadDrawTexts(points)
    if next(points) then
        CreateThread(function()
            local isDrawTextUIOpen = false
            local currentZone = nil
            while Koci.Client.Player.onTask and
                Koci.Client.Player.numberOfCargoInVehicle < Koci.Client.Player.currentTask.goal
            do
                local sleep = 2000
                local playerCoord = GetEntityCoords(PlayerPedId())
                local inAnyRange = false
                for key, point in pairs(points) do
                    local spawnCoords = point
                    local distance = #(playerCoord - vector3(spawnCoords.x, spawnCoords.y, spawnCoords.z))
                    if distance <= 2.5 then
                        if not Koci.Client.Player.isBusy then
                            sleep = 1
                            inAnyRange = true
                            if not currentZone then
                                currentZone = key
                            end
                            if Config.TextUIType == "drawtext" then
                                Koci.Utils.DrawText3D(spawnCoords, "[E] " .. _t("game.target.pickup_cargo"))
                            else
                                if not isDrawTextUIOpen then
                                    isDrawTextUIOpen = true
                                    Koci.Utils.DrawTextUI("[E] " .. _t("game.target.pickup_cargo"))
                                end
                            end
                            if currentZone == key and IsControlJustPressed(1, 38) then
                                Koci.Client.Player.isBusy = true
                                Koci.Client.Functions.PickUpNewCargoFromCargoLoad()
                                Wait(1000)
                            end
                        end
                    end
                end
                if not inAnyRange and currentZone then
                    currentZone = nil
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
end

function Koci.Client.Functions.CreateCargoLoadTargets(points)
    if next(points) then
        if Config.TargetType == "ox_target" then
            if Koci.Utils.hasResource("ox_target") then
                for key, coords in pairs(points) do
                    local id = exports.ox_target:addBoxZone({
                        coords = coords,
                        size = vec3(2, 2, 2),
                        options = {
                            {
                                icon = "fa-solid fa-dolly",
                                label = _t("game.target.pickup_cargo"),
                                onSelect = function()
                                    Koci.Client.Functions.PickUpNewCargoFromCargoLoad()
                                end,
                                distance = 2.0,
                            },
                        }
                    })
                    table.insert(Koci.Client.createdTargets, {
                        id = id,
                        key = "cargo_load_target"
                    })
                end
            end
        elseif Config.TargetType == "qb_target" then
            for key, coords in pairs(points) do
                local zoneName = "qb-delivery:CreateCargoLoadTarget:" .. key
                exports["qb-target"]:AddBoxZone(zoneName, coords, 2.0, 2.0, {
                    name = zoneName,
                    heading = 12.0,
                    debugPoly = false,
                    minZ = coords.z - 1.0,
                    maxZ = coords.z + 2.0,
                }, {
                    options = {
                        {
                            icon = "fa-solid fa-dolly",
                            label = _t("game.target.pickup_cargo"),
                            action = function()
                                Koci.Client.Functions.PickUpNewCargoFromCargoLoad()
                            end,
                        },
                    },
                    distance = 2.5,
                })
                table.insert(Koci.Client.createdTargets, {
                    id = zoneName,
                    key = "cargo_load_target"
                })
            end
        elseif Config.TargetType == "custom" then
            local size = vec3(2, 2, 2)
            for key, coords in pairs(points) do
                local id = Koci.Utils.CustomTargetSystem.AddTargetCoords(coords, size, {
                    icon = "fa-solid fa-dolly",
                    label = _t("game.target.pickup_cargo"),
                }, function()
                    Koci.Client.Functions.PickUpNewCargoFromCargoLoad()
                end)
                table.insert(Koci.Client.createdTargets, {
                    id = id,
                    key = "cargo_load_target"
                })
            end
        end
    end
end

function Koci.Client.Functions.CreateEmployerPedBlip(entity, blip)
    local createdBlip = AddBlipForEntity(entity)
    SetBlipSprite(createdBlip, blip.sprite)
    SetBlipColour(createdBlip, blip.color)
    SetBlipScale(createdBlip, blip.scale)
    SetBlipAsShortRange(createdBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blip.title)
    EndTextCommandSetBlipName(createdBlip)
end

function Koci.Client.Functions.CreateEmployerPedTarget(entity, point)
    if Config.TargetType == "ox_target" then
        if Koci.Utils.hasResource("ox_target") then
            local groups = point.job
            exports.ox_target:addLocalEntity(entity, {
                {
                    icon = "fa-solid fa-truck-ramp-box",
                    label = _t("game.target.toggle_job_duty"),
                    groups = groups,
                    onSelect = function()
                        Koci.Client.Functions.ToggleDeliveryJobDuty(point)
                    end,
                    distance = 2.5
                }
            })
        end
    elseif Config.TargetType == "qb_target" then
        local groups = point.job
        exports["qb-target"]:AddTargetEntity(entity, {
            options = {
                {
                    icon = "fa-solid fa-truck-ramp-box",
                    label = _t("game.target.toggle_job_duty"),
                    job = groups,
                    action = function()
                        Koci.Client.Functions.ToggleDeliveryJobDuty(point)
                    end,
                },
            },
            distance = 2.5
        })
    elseif Config.TargetType == "custom" then
        local groups = point.job
        Koci.Utils.CustomTargetSystem.AddTargetEntity(entity, {
            icon = "fa-solid fa-truck-rump-box",
            label = _t("game.target.toggle_job_duty"),
            groups = groups
        }, function()
            Koci.Client.Functions.ToggleDeliveryJobDuty(point)
        end)
    end
end

function Koci.Client.Functions.CreateEmployerPedWaisDialog(entity, point)
    Koci.Utils.AddWaisExtraDialog(entity, point)
end

function Koci.Client.Functions.CreateTaskVehicle(workingPoint)
    local vehicle = workingPoint.taskVehicle
    local spawnPoint = Koci.Client.Functions.FindClearSpawnCoord(vehicle.spawnCoords)
    if spawnPoint then
        Koci.Utils.RequestModel(vehicle.model)
        local veh = CreateVehicle(vehicle.model,
            spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.w,
            true, true
        )
        if DoesEntityExist(veh) then
            table.insert(Koci.Client.createdVehicles, veh)
            Koci.Utils.debugPrint("Task vehicle created.")
            local vehicleNetId = VehToNet(veh)
            Koci.Client.Player.taskVehicleNetId = vehicleNetId
            SetVehicleHasBeenOwnedByPlayer(veh, true)
            SetVehicleOnGroundProperly(veh)
            SetVehicleNeedsToBeHotwired(veh, false)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetVehicleColours(veh, 111, 80)
            SetVehicleFuelLevel(veh, 100.0)
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleDeformationFixed(veh)
            SetModelAsNoLongerNeeded(vehicle.model)
            SetPedIntoVehicle(PlayerPedId(), veh, -1)
            Wait(1000)
            Koci.Client.SendNotify(_t("game.delivery.vehicle_created_task_started"), "success")
            if Koci.Client.Player.currentTask.type == "delivery" then
                Koci.Client.Functions.SetTaskVehicleDoorOpen()
            end
            TriggerServerEvent("qb-delivery:Server:OnCreatedTaskVehicle",
                vehicleNetId, spawnPoint, vehicle.plate
            )
        else
            Koci.Client.SendNotify(_t("game.delivery.failed_create_task_vehicle."), "error")
        end
    else
        Koci.Client.SendNotify(_t("game.delivery.notAvailableSpawnPoint"), "error")
    end
end

function Koci.Client.Functions.OnTaskVehicleCreated(netId, plate, coords)
    Wait(1000)
    local vehicle = 0
    local vehicleNetId = netId
    if not NetworkDoesEntityExistWithNetworkId(vehicleNetId) then
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        vehicleNetId = VehToNet(vehicle)
        Koci.Client.SendNotify(_t("game.delivery.error_task_vehicle_net_id"), "info")
    else
        vehicle = NetToVeh(vehicleNetId)
        Koci.Client.SendNotify(_t("game.delivery.vehicle_created_task_started"), "success")
    end
    Koci.Client.Player.taskVehicleNetId = vehicleNetId
    Koci.Client.Functions.GiveTaskVehicleKey(plate, vehicle)
end

function Koci.Client.Functions.CreateRandomTaskCustomers(task)
    local function getStreetName(pos)
        local street1, street2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        street1 = GetStreetNameFromHashKey(street1)
        street2 = GetStreetNameFromHashKey(street2)
        return street1 .. " " .. street2
    end
    local function randomCargoContent()
        local c = { _t("game.delivery.cargo_type_1"),
            _t("game.delivery.cargo_type_2"),
            _t("game.delivery.cargo_type_3"),
            _t("game.delivery.cargo_type_4") }
        return c[math.random(1, #c)]
    end
    local function randomProfile()
        return "profile_" .. math.random(6)
    end
    local function randomCustName()
        local names = { "John", "Alice", "Michael", "Emma", "David", "Sarah", "James", "Emily", "Daniel", "Olivia",
            "Matthew", "Sophia", "Christopher", "Ava", "Andrew", "Isabella" }
        local lastNames = { "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore",
            "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris" }

        local randomNameIndex = math.random(1, #names)
        local randomLastNameIndex = math.random(1, #lastNames)

        local randomName = names[randomNameIndex]
        local randomLastName = lastNames[randomLastNameIndex]

        return randomName .. " " .. randomLastName
    end

    task = Koci.Utils.deepCopy(task)
    local newDestinations = {}
    for key, value in pairs(task.destinations) do
        table.insert(newDestinations, {
            id = key,
            coords = value.coords,
            delivered = false,
            info = {
                profile = randomProfile(),
                customerName = randomCustName(),
                street = getStreetName(value.coords),
                cargoContent = randomCargoContent(),
            }
        })
    end
    return newDestinations
end

function Koci.Client.Functions.LoadPlayerSkin()
    if Config.FrameWork == "esx" then
        if Koci.Utils.hasResource("esx_skin") then
            Koci.Framework.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                if skin then
                    TriggerEvent("skinchanger:loadSkin", skin)
                end
            end)
        end
    elseif Config.FrameWork == "qb" then
        if Koci.Utils.hasResource("qb-clothing") then
            TriggerServerEvent("qb-clothes:loadPlayerSkin")
        end
    end
end

function Koci.Client.Functions.LoadPointSkin(uniforms)
    if Config.FrameWork == "esx" then
        if Koci.Utils.hasResource("esx_skin") and Koci.Utils.hasResource("skinchanger") then
            Koci.Framework.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                if skin then
                    local data = nil
                    if skin.sex == 1 then
                        data = uniforms.male
                    else
                        data = uniforms.female
                    end
                    TriggerEvent("skinchanger:loadClothes", skin, data)
                end
            end)
        end
    elseif Config.FrameWork == "qb" then
        if Koci.Utils.hasResource("qb-clothing") then
            local xPlayer = Koci.Client.GetPlayerData()
            if xPlayer and xPlayer.charinfo then
                local gender = xPlayer.charinfo.gender
                if gender == 0 then
                    TriggerEvent("qb-clothing:Client:loadOutfit", uniforms.male)
                else
                    TriggerEvent("qb-clothing:Client:loadOutfit", uniforms.female)
                end
            end
        end
    end
end

function Koci.Client.Functions.StopCurrentTask()
    if not Koci.Client.Player.onTask then return end
    ClearPedTasksImmediately(PlayerPedId())
    if Koci.Client.Player.currentDestination and
        DoesBlipExist(Koci.Client.Player.currentDestination.blip)
    then
        RemoveBlip(Koci.Client.Player.currentDestination.blip)
    end
    Koci.Client.Player.currentDestination = nil
    Koci.Client.Player.currentTask = nil
    Koci.Client.Functions.DeleteProps()
    Koci.Client.Functions.DeleteVehicles()
    Koci.Client.Functions.DeletePeds()
    Koci.Client.Functions.DeleteTargets()
    Koci.Client.Player.onDelivery = false
    Koci.Client.Player.onTask = false
    Koci.Client.Player.numberOfCargoInVehicle = 0
    Koci.Client.SendNotify(_t("game.delivery.stoppedTask"), "info")
    Koci.Client.SendReactMessage("ui:setCurrentTask", { clear = true })
    TriggerServerEvent("qb-delivery:Server:StopTask")
end

function Koci.Client.Functions.GetOnDuty(point)
    if point.uniforms.active then
        Koci.Client.Functions.LoadPointSkin(point.uniforms)
    end
    Koci.Client.Player.workingPoint = point
    Koci.Client.Player.onDuty = true
    Koci.Client.SendNotify(_t("game.delivery.getOnDuty"), "success")
    TriggerServerEvent("qb-delivery:Server:GetOnDuty")
end

function Koci.Client.Functions.LeaveDuty()
    Koci.Client.Functions.LeaveAllTeams()
    Koci.Client.Functions.LoadPlayerSkin()
    Koci.Client.Functions.StopCurrentTask()
    Koci.Client.Player.onDuty = false
    Koci.Client.Player.workingPoint = nil
    Koci.Client.currentTeamInvitation = {}
    Koci.Client.SendNotify(_t("game.delivery.leaveDuty"), "info")
    TriggerServerEvent("qb-delivery:Server:LeaveDuty")
end

function Koci.Client.Functions.ToggleDeliveryJobDuty(point)
    if Koci.Client.Player.onDuty then
        Koci.Client.Functions.LeaveDuty()
        return
    end
    Koci.Client.Functions.GetOnDuty(point)
end

function Koci.Client.Functions.SetTaskVehicleDoorShut(n)
    CreateThread(function()
        if not n then Wait(1000) end
        local vehicle = NetToVeh(Koci.Client.Player.taskVehicleNetId)
        for i = 2, 3 do
            SetVehicleDoorShut(vehicle, i, false)
        end
    end)
end

function Koci.Client.Functions.SetTaskVehicleDoorOpen(n)
    CreateThread(function()
        if not n then Wait(1000) end
        local vehicle = NetToVeh(Koci.Client.Player.taskVehicleNetId)
        for i = 2, 3 do
            SetVehicleDoorOpen(vehicle, i, false, false)
        end
    end)
end

function Koci.Client.Functions.AddPropToPed(ped, prop1, bone, off1, off2, off3, rot1, rot2, rot3, network)
    local coords = GetEntityCoords(ped)
    Koci.Utils.RequestModel(prop1)
    local createdProp = CreateObject(GetHashKey(prop1), coords.x, coords.y, coords.z + 0.2, network, network, false)
    if DoesEntityExist(createdProp) then
        if network then
            local netId = ObjToNet(createdProp)
            SetNetworkIdExistsOnAllMachines(netId, true)
            NetworkUseHighPrecisionBlending(netId, true)
            SetNetworkIdCanMigrate(netId, false)
        end
        AttachEntityToEntity(createdProp, ped, GetPedBoneIndex(ped, bone),
            off1, off2, off3,
            rot1, rot2, rot3,
            true, true, false, true, 0, true
        )
        SetModelAsNoLongerNeeded(prop1)
        return createdProp
    end
    return nil
end

function Koci.Client.Functions.AddPropToTaskVehicle(prop, pos, rot)
    local taskVehicle = NetToVeh(Koci.Client.Player.taskVehicleNetId)
    local coords = GetEntityCoords(taskVehicle)
    Koci.Utils.RequestModel(prop)
    local createdProp = CreateObject(GetHashKey(prop), coords.x, coords.y, coords.z + 0.2, false, false, false)
    if DoesEntityExist(createdProp) then
        table.insert(Koci.Client.createdProps, {
            id = createdProp,
            key = "put_new_cargo_on_vehicle"
        })
        AttachEntityToEntity(createdProp, taskVehicle, nil,
            pos,
            rot,
            false, false, false, false, 0, true
        )
        SetModelAsNoLongerNeeded(prop)
        return createdProp
    end
    return nil
end

function Koci.Client.Functions.RemovePropFromPedHand(ped, propEntity)
    ped = ped or PlayerPedId()
    propEntity = propEntity or
        (Koci.Client.Player.havePropInHand and Koci.Client.Player.havePropInHand.entity or nil)
    if not propEntity then return end
    if DoesEntityExist(propEntity) then
        ClearPedTasksImmediately(ped)
        DeleteEntity(propEntity)
        if ped == PlayerPedId() then
            Koci.Client.Player.havePropInHand = nil
        end
        return true
    end
    return false
end

function Koci.Client.Functions.PutBoxInPedHand(_ped, prop, isNetwork)
    if type(isNetwork) ~= "boolean" then
        isNetwork = true
    end
    local ped = _ped or PlayerPedId()
    if ped == PlayerPedId() and Koci.Client.Player.havePropInHand then
        Koci.Client.SendNotify(_t("game.delivery.already_have_prop"), "error")
        return false, nil
    end
    ClearPedTasksImmediately(ped)
    Koci.Utils.LoadAnim("anim@heists@box_carry@")
    TaskPlayAnim(ped, "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
    local taskProp = prop or Koci.Utils.GetRandomTaskProp()
    Koci.Utils.RequestModel(taskProp.model)
    local createdProp = Koci.Client.Functions.AddPropToPed(ped, taskProp.model, 57005,
        taskProp.coords.x, taskProp.coords.y, taskProp.coords.z,
        taskProp.rot.x, taskProp.rot.y, taskProp.rot.z, isNetwork
    )
    if createdProp then
        local insert_prop = {
            id = createdProp,
            key = "put_box_in_ped_hand",
            model = taskProp.model,
        }
        table.insert(Koci.Client.createdProps, insert_prop)
        if ped == PlayerPedId() then
            Koci.Client.Player.havePropInHand = {
                entity = createdProp,
                model = taskProp.model
            }
            Koci.Client.Functions.Thread_OnPlayerHasPropInHand()
        end
        return true, insert_prop
    else
        ClearPedTasksImmediately(ped)
    end
    return false, nil
end

function Koci.Client.Functions.TickDeliveredDestionById(id)
    for key, value in pairs(Koci.Client.Player.currentTask.destinations) do
        if key == id then
            Koci.Client.Player.currentTask.destinations[key].delivered = true
            return true
        end
    end
    return false
end

function Koci.Client.Functions.OnTaskDestionCompleted(prop)
    if Koci.Client.Player.currentTask.type == "delivery" then
        if Koci.Client.Player.havePropInHand then
            Koci.Client.Functions.RemovePropFromPedHand()
        end
        local destination = Koci.Client.Player.currentDestination
        local result, _prop = Koci.Client.Functions.PutBoxInPedHand(destination.ped, prop, false)
        Koci.Client.Functions.TickDeliveredDestionById(Koci.Client.Player.currentDestination.id)
        Koci.Client.Player.currentTask.completed_goal =
            Koci.Client.Player.currentTask.completed_goal + 1
        Koci.Client.Player.onDelivery = false
        Koci.Client.Player.currentDestination = nil
        Koci.Client.Functions.SetTaskVehicleDoorShut()
        if DoesBlipExist(destination.blip) then
            RemoveBlip(destination.blip)
        end
        Koci.Client.SendNotify(_t("game.delivery.cargo_delivered"), "info")
        CreateThread(function()
            local ped = destination.ped
            local coords = GetEntityCoords(ped)
            FreezeEntityPosition(ped, false)
            Wait(1000)
            TaskWanderInArea(ped, coords.x, coords.y, coords.z, 100.0, 2.0, 5.0)
            Wait(20000)
            ClearPedTasksImmediately(ped)
            DeleteEntity(_prop.id)
            SetPedAsNoLongerNeeded(ped)
        end)
    elseif Koci.Client.Player.currentTask.type == "collecting" then
        local destination = Koci.Client.Player.currentDestination
        Koci.Client.Functions.TickDeliveredDestionById(Koci.Client.Player.currentDestination.id)
        Koci.Client.Player.currentTask.completed_goal =
            Koci.Client.Player.currentTask.completed_goal + 1
        Koci.Client.Player.onDelivery = false
        Koci.Client.Player.currentDestination = nil
        if DoesBlipExist(destination.blip) then
            RemoveBlip(destination.blip)
        end
        Koci.Client.SendNotify(_t("game.delivery.cargo_received"), "info")
        CreateThread(function()
            local ped = destination.ped
            local coords = GetEntityCoords(ped)
            FreezeEntityPosition(ped, false)
            Wait(1000)
            TaskWanderInArea(ped, coords.x, coords.y, coords.z, 100.0, 2.0, 5.0)
            Wait(20000)
            SetPedAsNoLongerNeeded(ped)
        end)
    end
    Koci.Client.SendReactMessage("ui:setCurrentTask", { task = Koci.Client.Player.currentTask })
end

function Koci.Client.Functions.HandleTaskDestionCompleted_Delivery(destination)
    local handProp = Koci.Client.Player.havePropInHand
    local prop = Koci.Utils.GetTaskProp(handProp.model)
    Koci.Client.SendNotify(_t("game.delivery.cargo_being_delivered"), "info", 500)
    Wait(500)
    Koci.Client.TriggerServerCallback("qb-delivery:Server:HandleTaskDestionCompleted", function(response)
        if response.error then
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
        Koci.Client.Player.isBusy = false
    end, prop)
end

function Koci.Client.Functions.HandleTaskDestionCompleted_Collecting(destination)
    Koci.Client.Functions.PutNewCargoInVehicle()
    Koci.Client.TriggerServerCallback("qb-delivery:Server:HandleTaskDestionCompleted", function(response)
        if response.error then
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
        Koci.Client.Player.isBusy = false
    end, nil)
end

function Koci.Client.Functions.OnCargoPickUpFromTaskVehicle(playerSource)
    Koci.Client.Player.numberOfCargoInVehicle = Koci.Client.Player.numberOfCargoInVehicle - 1
    Koci.Client.Functions.DeleteLastBoxInVehicleBack()
end

function Koci.Client.Functions.PickUpCargoFromTaskVehicle()
    Koci.Client.TriggerServerCallback("qb-delivery:Server:PickUpCargoFromTaskVehicle", function(response)
        if not response.error then
            local response, _ = Koci.Client.Functions.PutBoxInPedHand()
            if response then
                Koci.Client.Player.numberOfCargoInVehicle =
                    Koci.Client.Player.numberOfCargoInVehicle - 1
                Koci.Client.Functions.DeleteLastBoxInVehicleBack()
            end
        else
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
        Koci.Client.Player.isBusy = false
    end)
end

function Koci.Client.Functions.OnCargoPickUpFromDestinationPed()
    local destination = Koci.Client.Player.currentDestination
    Koci.Client.Functions.RemovePropFromPedHand(destination.ped, destination.prop.id)
end

function Koci.Client.Functions.PickUpCargoFromDestinationPed()
    local destination = Koci.Client.Player.currentDestination
    Koci.Client.TriggerServerCallback("qb-delivery:Server:PickUpCargoFromDestinationPed", function(response)
        if not response.error then
            local response = Koci.Client.Functions.RemovePropFromPedHand(destination.ped, destination.prop.id)
            if response then
                local _prop = Koci.Utils.GetTaskProp(destination.prop.model)
                Koci.Client.Functions.PutBoxInPedHand(PlayerPedId(), _prop)
            end
        else
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
        Koci.Client.Player.isBusy = false
    end)
end

function Koci.Client.Functions.StartTaskDestination(destination, pedModel)
    local function destinationBlip(coords)
        if DoesBlipExist(Koci.Client.Player.currentDestination.blip) then
            RemoveBlip(Koci.Client.Player.currentDestination.blip)
        end
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 280)
        SetBlipColour(blip, 49)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Customer #" .. destination.id)
        EndTextCommandSetBlipName(blip)
        SetBlipRoute(blip, true)
        SetBlipRouteColour(blip, 32)
        return blip
    end
    local function destinationPed(coords)
        if DoesEntityExist(Koci.Client.Player.currentDestination.ped) then
            DeleteEntity(Koci.Client.Player.currentDestination.ped)
        end
        local model = pedModel
        if IsModelValid(model) then
            Koci.Utils.RequestModel(model)
            local createdPed = CreatePed(4, model,
                coords.x, coords.y, coords.z - 1, coords.w,
                false, false
            )
            if DoesEntityExist(createdPed) then
                SetPedDefaultComponentVariation(createdPed)
                SetPedDiesWhenInjured(createdPed, false)
                SetEntityInvincible(createdPed, true)
                FreezeEntityPosition(createdPed, true)
                TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
                SetBlockingOfNonTemporaryEvents(createdPed, true)
                SetModelAsNoLongerNeeded(model)
                table.insert(Koci.Client.createdPeds, createdPed)
                return createdPed
            end
            return nil
        end
    end
    Koci.Client.Player.currentDestination = destination
    Koci.Client.Player.currentDestination.blip = destinationBlip(destination.coords)
    Koci.Client.Player.currentDestination.ped = destinationPed(destination.coords)
    if Koci.Client.Player.currentTask.type == "collecting" then
        local randomProp = Koci.Utils.GetRandomTaskProp()
        local response, prop = Koci.Client.Functions.PutBoxInPedHand(Koci.Client.Player.currentDestination.ped,
            randomProp, false)
        if response then
            Koci.Client.Player.currentDestination.prop = prop
        end
        if not Koci.Client.Player.onDelivery then
            Koci.Client.Functions.Thread_CollectingDestinationTick()
        end
    elseif Koci.Client.Player.currentTask.type == "delivery" then
        if not Koci.Client.Player.onDelivery then
            Koci.Client.Functions.Thread_DeliveryDestinationTick()
        end
    end
    Koci.Client.Player.onDelivery = true
    Koci.Client.SendNotify(_t("game.delivery.started_new_destination"), "info")
end

function Koci.Client.Functions.OnCargoPutOnTaskVehicle(playerSource)
    local model = "prop_cs_cardbox_01"
    local point = Koci.Client.Player.workingPoint
    local holdCoords = point.taskVehicle.cargoHoldCoords
    local newHoldCoords = holdCoords[Koci.Client.Player.numberOfCargoInVehicle + 1]
    if newHoldCoords then
        Koci.Client.Functions.AddPropToTaskVehicle(model, newHoldCoords.pos, newHoldCoords.rot)
    end
    Koci.Client.Player.numberOfCargoInVehicle = Koci.Client.Player.numberOfCargoInVehicle + 1
    if Koci.Client.Player.numberOfCargoInVehicle >= Koci.Client.Player.currentTask.goal then
        Koci.Client.SendNotify(_t("game.delivery.all_boxes_in_vehicle"), "info")
        if Koci.Client.Player.currentTask.type == "delivery" then
            Koci.Client.Functions.DeleteCargoLoadTargets()
        end
        Koci.Client.Functions.RemovePropFromPedHand()
    end
end

function Koci.Client.Functions.PutNewCargoInVehicle()
    if Koci.Client.Player.numberOfCargoInVehicle >= Koci.Client.Player.currentTask.goal then
        Koci.Client.Functions.RemovePropFromPedHand()
        return
    end
    Koci.Client.TriggerServerCallback("qb-delivery:Server:CanLoadCargoInVehicle", function(response)
        if not response.error then
            Koci.Client.Functions.RemovePropFromPedHand()
            local model = "prop_cs_cardbox_01"
            local point = Koci.Client.Player.workingPoint
            local holdCoords = point.taskVehicle.cargoHoldCoords
            local newHoldCoords = holdCoords[Koci.Client.Player.numberOfCargoInVehicle + 1]
            if newHoldCoords then
                Koci.Client.Functions.AddPropToTaskVehicle(model, newHoldCoords.pos, newHoldCoords.rot)
            end
            Koci.Client.Player.numberOfCargoInVehicle = Koci.Client.Player.numberOfCargoInVehicle + 1
            Koci.Client.SendNotify(_t("game.delivery.placed_in_vehicle"), "success")
            TriggerServerEvent("qb-delivery:Server:OnCargoPutOnTaskVehicle")
            if Koci.Client.Player.numberOfCargoInVehicle >= Koci.Client.Player.currentTask.goal then
                Koci.Client.SendNotify(_t("game.delivery.all_boxes_in_vehicle"), "info")
                if Koci.Client.Player.currentTask.type == "delivery" then
                    Koci.Client.Functions.DeleteCargoLoadTargets()
                end
                Koci.Client.Functions.SetTaskVehicleDoorShut()
            end
        else
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
    end)
end

function Koci.Client.Functions.PickUpNewCargoFromCargoLoad()
    if Koci.Client.Player.numberOfCargoInVehicle >= Koci.Client.Player.currentTask.goal then
        Koci.Client.Player.isBusy = false
        return
    end
    Koci.Client.TriggerServerCallback("qb-delivery:Server:PickUpCargoFromCargoLoad", function(response)
        if not response.error then
            local propSpawned, _ = Koci.Client.Functions.PutBoxInPedHand()
            if propSpawned then
                Koci.Client.SendNotify(_t("game.delivery.picked_up_cargo_from_cargo_load"), "success")
                Koci.Client.SendNotify(_t("game.delivery.load_cargo_into_vehicle"), "info")
                Koci.Client.Functions.Thread_LoadCargoIntoVehicle()
            end
        else
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
        Koci.Client.Player.isBusy = false
    end)
end

function Koci.Client.Functions.CheckJob(newJob)
    if Koci.Client.Player.onDuty then
        local pointJob = Koci.Client.Player.workingPoint.job
        if pointJob and type(pointJob) ~= "table" then
            pointJob = { pointJob }
        end
        if pointJob and not pointJob[newJob] then
            Koci.Client.Functions.LeaveDuty()
        end
    end
end

function Koci.Client.Functions.UpdatePlayerProfile(newProfile)
    Koci.Client.Player.profile = newProfile
    TriggerServerEvent("qb-delivery:Server:UpdatePlayerProfile", newProfile)
end

function Koci.Client.Functions.InvitePlayerToTeam(invited)
    if GetPlayerServerId(PlayerId()) == invited then
        Koci.Client.SendNotify(_t("game.delivery.not_invitation_yourself"), "error")
        return
    end
    if Koci.Client.Functions.GetMateCount() ~= 0 then
        Koci.Client.SendNotify(_t("game.delivery.already_in_team"), "error")
        return
    end
    Koci.Client.TriggerServerCallback("qb-delivery:Server:SendInvitationToPlayer", function(response)
        if response.status then
            Koci.Client.SendNotify(_t("game.delivery.invitation_sent"), "info")
        else
            Koci.Client.SendNotify(_t("game.delivery.not_invitation_sent", response.error), "error")
        end
    end, invited)
end

function Koci.Client.Functions.WatchInvitationStatus()
    CreateThread(function()
        while not Koci.Client.blockInvitations and Koci.Client.currentTeamInvitation.invitingId and Koci.Client.Player.onDuty do
            Wait(10000)
            if not Koci.Client.blockInvitations and Koci.Client.currentTeamInvitation.invitingId and Koci.Client.Player.onDuty then
                local _name = Koci.Client.currentTeamInvitation.invitingName
                Koci.Client.SendNotify(
                    _t("game.delivery.new_team_invitation", _name),
                    "info"
                )
            end
        end
        Koci.Client.currentTeamInvitation = {}
    end)
end

function Koci.Client.Functions.HandleNewInvitation(invitingSource, invitingName)
    if Koci.Client.blockInvitations or
        not Koci.Client.Player.onDuty or
        Koci.Client.Player.onTask or
        Koci.Client.currentTeamInvitation.invitingId
    then
        return
    end
    Koci.Client.SendNotify(_t("game.delivery.new_team_invitation", invitingName), "info")
    Koci.Client.currentTeamInvitation = {
        invitingId = invitingSource,
        invitingName = invitingName
    }
    Koci.Client.Functions.WatchInvitationStatus()
end

function Koci.Client.Functions.AcceptLastInvitation()
    if not Koci.Client.currentTeamInvitation.invitingId then return end
    if not Koci.Client.Player.onDuty then return end
    if Koci.Client.Player.onTask then return end
    if Koci.Client.Functions.GetMateCount() ~= 0 then return end
    local inviting = Koci.Client.currentTeamInvitation.invitingId
    Koci.Client.TriggerServerCallback("qb-delivery:Server:PlayerAcceptedInvitation", function(mateData)
        if mateData then
            mateData.nextLeveLExp = Koci.Client.Functions.GetPlayerNextLevelExp(mateData.level)
            Koci.Client.Functions.AddTeamMate(inviting, mateData)
            Koci.Client.SendReactMessage("ui:LoadTeamMateData", {
                id = inviting,
                data = mateData,
            })
        end
        Koci.Client.currentTeamInvitation = {}
    end, inviting)
end

function Koci.Client.Functions.DenyLastInvitation()
    if not Koci.Client.currentTeamInvitation.invitingId then return end
    Koci.Client.SendNotify(_t("game.delivery.declined_team_invitation"), "info")
    TriggerServerEvent("qb-delivery:Server:PlayerDeclinedInvitation",
        Koci.Client.currentTeamInvitation.invitingId)
    Koci.Client.currentTeamInvitation = {}
end

function Koci.Client.Functions.BlockInvitations()
    Koci.Client.blockInvitations = not Koci.Client.blockInvitations
    if Koci.Client.blockInvitations then
        Koci.Client.SendNotify(_t("game.delivery.blocked_invitations"), "info")
    else
        Koci.Client.SendNotify(_t("game.delivery.unblocked_invitations"), "info")
    end
end

function Koci.Client.Functions.LeaveAllTeams()
    if Koci.Client.Functions.GetMateCount() == 0 then return end
    TriggerServerEvent("qb-delivery:Server:LeaveAllTeams")
    Koci.Client.Player.TeamMate = {}
    Koci.Client.SendNotify(_t("game.delivery.leavedTeams"), "info")
    Koci.Client.SendReactMessage("ui:LoadTeamMateData", { left = true })
    Koci.Client.SendReactMessage("ui:setPlayerProfile", Koci.Client.Player)
end

function Koci.Client.Functions.LeaveCurrentTeam()
    if Koci.Client.Functions.GetMateCount() == 0 then return end
    Koci.Client.Functions.LeaveAllTeams()
end

function Koci.Client.Functions.GetMateCount()
    local count = 0
    for key, value in pairs(Koci.Client.Player.TeamMate) do
        if value then
            count = count + 1
        end
    end
    return count
end

function Koci.Client.Functions.FindTaskById(id)
    if id == -1 then return false end
    for key, value in pairs(Config.AcceptableTasks) do
        if value.unique_id == id then
            return value
        end
    end
    return false
end

function Koci.Client.Functions.SendNewTaskRequest(taskId, _task)
    if not Koci.Client.Player.onDuty then return end
    local task = Koci.Client.Functions.FindTaskById(taskId)
    if not task then
        Koci.Client.SendNotify(_t("game.delivery.task_invalid", taskId), "error")
        return
    end
    if Koci.Client.Player.onTask then
        Koci.Client.SendNotify(_t("game.delivery.already_doing_task"), "error")
        return
    end
    if Koci.Client.Player.lastCompletedTaskId == taskId then
        Koci.Client.SendNotify(_t("game.delivery.before_completed_task"), "error")
        return
    end
    local sc = Koci.Client.Player.workingPoint.employerPed.spawnCoords
    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - vec3(sc.x, sc.y, sc.z))
    if distance > 35.0 then
        Koci.Client.SendNotify(_t("game.delivery.error_far_from_start_point"), "error")
        return
    end
    Koci.Client.TriggerServerCallback("qb-delivery:Server:StartTaskWithTeamMates", function(response)
        if response.error then
            Koci.Client.SendNotify(_t("game.error_occurred", response.error), "error")
        end
    end, taskId)
end

function Koci.Client.Functions.FindClearSpawnCoord(coords)
    for k, v in pairs(coords) do
        if not IsAnyVehicleNearPoint(v.x, v.y, v.z, 1.0) then
            return vec4(v.x, v.y, v.z, v.w)
        end
    end
    return false
end

function Koci.Client.Functions.GiveTaskVehicleKey(plate, vehicle)
    Koci.Utils.GiveVehicleKey(plate, vehicle)
end

function Koci.Client.Functions.SetupCargoBoxesLoadCoords(point)
    if Config.InteractType == "drawtext" then
        Koci.Client.Functions.CreateCargoLoadDrawTexts(point.taskVehicle.cargoBoxesLoadCoords)
    elseif Config.InteractType == "target" or Config.InteractType == "wais-npcdialog" then
        Koci.Client.Functions.CreateCargoLoadTargets(point.taskVehicle.cargoBoxesLoadCoords)
    end
    Koci.Client.SendNotify(_t("game.delivery.loading_points_created"), "info")
end

function Koci.Client.Functions.SetupCollectingTask()
    TriggerServerEvent("qb-delivery:Server:StartNewTaskDestination")
end

function Koci.Client.Functions.SendTaskCustomers(newDestinations)
    Koci.Client.Player.currentTask.destinations = newDestinations
    Wait(500)
    Koci.Client.SendReactMessage("ui:setCurrentTask", {
        task = Koci.Client.Player.currentTask,
        destinations = newDestinations
    })
end

function Koci.Client.Functions.StartNewTask(taskId, isLeader)
    local Task = Koci.Client.Functions.FindTaskById(taskId)
    if Task then
        Koci.Client.Player.onTask = true
        Koci.Client.Player.currentTask = Task
        Koci.Client.Player.currentTask.completed_goal = 0
        Koci.Client.Player.numberOfCargoInVehicle = 0
        Koci.Client.Player.isLeader = isLeader
        Koci.Client.Player.onDelivery = false
        Koci.Client.Player.currentDestination = nil
        local newDestinations = Task.destinations
        if isLeader then
            Koci.Client.Functions.CreateTaskVehicle(Koci.Client.Player.workingPoint)
            Koci.Client.Functions.GiveTaskVehicleKey(Koci.Client.Player.workingPoint.taskVehicle.plate)
            newDestinations = Koci.Client.Functions.CreateRandomTaskCustomers(Task)
            Koci.Client.Player.currentTask.destinations = newDestinations
            TriggerServerEvent("qb-delivery:Server:UpdateCurrentTaskCustomers", newDestinations)
        end
        Koci.Client.SendReactMessage("ui:setCurrentTask", {
            task = Task,
            destinations = newDestinations
        })
        if Task.type == "delivery" then
            Koci.Client.Functions.SetupCargoBoxesLoadCoords(Koci.Client.Player.workingPoint)
        elseif Task.type == "collecting" then
            if isLeader then
                Koci.Client.Functions.SetupCollectingTask()
            end
        end
    end
end

function Koci.Client.Functions.OnTaskCompleted(newLevel, newExp)
    Koci.Client.Player.isBusy = false
    Koci.Client.Player.lastCompletedTaskId =
        Koci.Utils.deepCopy(Koci.Client.Player.currentTask.unique_id)
    Koci.Client.Player.exp = newExp
    Koci.Client.Player.level = newLevel
    Koci.Client.Player.nextLeveLExp =
        Koci.Client.Functions.GetPlayerNextLevelExp(Koci.Client.Player.level)
    Koci.Client.Player.isLeader = false
    Koci.Client.Player.numberOfCargoInVehicle = 0
    Koci.Client.Player.onDelivery = false
    Koci.Client.Player.currentDestination = nil
    Koci.Client.Player.onTask = false
    Koci.Client.Player.currentTask = nil
    Koci.Client.Player.taskVehicleNetId = nil
    Koci.Client.Functions.DeleteProps()
    Koci.Client.Functions.DeletePeds()
    Koci.Client.Functions.DeleteVehicles()
    Koci.Client.Functions.DeleteTargets()
    Koci.Client.SendNotify(_t("game.delivery.task_is_completed"), "success")
    Koci.Client.SendReactMessage("ui:setCurrentTask", { clear = true })
    Koci.Client.SendReactMessage("ui:setPlayerProfile", Koci.Client.Player)
end

function Koci.Client.Functions.CompleteTask()
    if IsWaypointActive() then
        SetWaypointOff()
    end
    if not Koci.Client.Player.onTask then return end
    Koci.Client.Player.isBusy = true
    Koci.Client.TriggerServerCallback("qb-delivery:Server:OnTaskCompleted", function()
        Koci.Client.Player.isBusy = false
    end)
end

function Koci.Client.Functions.GetPlayerNextLevelExp(level)
    return Config.JobOptions.ranks[level + 1] or Config.JobOptions.ranks[#Config.JobOptions.ranks]
end

function Koci.Client.Functions.LoadPlayerData()
    Koci.Client.TriggerServerCallback("qb-delivery:Server:LoadPlayerData", function(data)
        Koci.Client.Player.characterName = data.characterName
        Koci.Client.Player.profile = data.profile
        Koci.Client.Player.level = data.level
        Koci.Client.Player.exp = data.exp
        Koci.Client.Player.nextLeveLExp = Koci.Client.Functions.GetPlayerNextLevelExp(data.level)
        Koci.Client.SendReactMessage("ui:setPlayerProfile", Koci.Client.Player)
    end)
end

function Koci.Client.Functions.SetupStartPoints()
    local Points = Config.JobOptions.startPoints
    for index, point in pairs(Points) do
        if point.active then
            local startPoint = Koci.Utils.deepCopy(point)
            startPoint.index = index
            local createdPed = Koci.Client.Functions.CreateEmployerPed(point.employerPed.model,
                point.employerPed.spawnCoords)
            if createdPed then
                Koci.Client.Functions.CreateEmployerPedBlip(createdPed, point.employerPed.blip)
                if Config.InteractType == "target" then
                    Koci.Client.Functions.CreateEmployerPedTarget(createdPed, startPoint)
                elseif Config.InteractType == "wais-npcdialog" then
                    Koci.Client.Functions.CreateEmployerPedWaisDialog(createdPed, startPoint)
                end
                table.insert(Koci.Client.startPoints, startPoint)
            end
        end
    end
    if Config.InteractType == "drawtext" then
        Koci.Client.Functions.CreateStartPointDrawTexts(Koci.Client.startPoints)
    end
end

function Koci.Client.Functions.SetupUI()
    Koci.Client.SendReactMessage("ui:setLocale", locales.ui)
    Koci.Client.SendReactMessage("ui:setAcceptableTasks", Config.AcceptableTasks)
end

function Koci.Client.Functions.Debug()
    local dbg = false
    if not dbg then return end
    Koci.Client.SendNotify("Debug 1 saniye içinde çalışacak !", "info")
    CreateThread(function()
        Wait(1000)
        Koci.Client.Functions.ToggleDeliveryJobDuty(Config.JobOptions.startPoints[1])
        -- Koci.Client.Functions.SendNewTaskRequest(2, Config.AcceptableTasks[2])
    end)
end

function Koci.Client.Functions.AddTeamMate(source, data)
    local found = false
    for key, value in pairs(Koci.Client.Player.TeamMate) do
        if value.source == source then
            value = data
            value.source = source
            found = true
            break
        end
    end
    if not found then
        local _v = data
        _v.source = source
        Koci.Client.Player.TeamMate[#Koci.Client.Player.TeamMate + 1] = _v
    end
end

function Koci.Client.Functions.LeavedTeamMate(targetSource)
    for index, value in pairs(Koci.Client.Player.TeamMate) do
        if value.source == targetSource then
            table.remove(Koci.Client.Player.TeamMate, index)
            break
        end
    end
end

function Koci.Client.Functions.HasTowTruck()
    if Config.HasTowTruck then
        if Koci.Utils.hasResource("0r-towtruck") then
            Koci.Client.SendReactMessage("ui:InstallTowTruck", true)
        end
    end
end

-- @ --

function Koci.Client.StartCore()
    Wait(1000)
    Koci.Client.Functions.LoadPlayerData()
    Koci.Client.Functions.SetupStartPoints()
    Koci.Client.Functions.SetupUI()
    Koci.Client.Functions.Debug()
    Koci.Client.Functions.HasTowTruck()
end

function Koci.Client.StopCore()
    Koci.Utils.HideTextUI()
    ClearPedTasksImmediately(PlayerPedId())
    Koci.Client.Functions.DeleteProps()
    Koci.Client.Functions.DeletePeds()
    Koci.Client.Functions.DeleteVehicles()
    Koci.Client.Functions.DeleteEmployerPeds()
    Koci.Client.Functions.DeleteTargets()
    Koci.Client.Functions.LeaveAllTeams()
    Koci.Client.startPoints = {}
    Koci.Client.currentTeamInvitation = {}
    Koci.Client.Player = {
        isBusy = false,
        characterName = nil,
        profile = nil,
        level = nil,
        exp = nil,
        nextLeveLExp = nil,
        onDuty = false,
        workingPoint = nil,
        TeamMate = {},
        onTask = false,
        currentTask = nil,
        lastCompletedTaskId = nil,
        isLeader = false,
        havePropInHand = nil,
        numberOfCargoInVehicle = 0,
        taskVehicleNetId = nil,
        onDelivery = false,
        currentDestination = nil,
    }
end
