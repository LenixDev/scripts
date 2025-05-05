local QBCore = exports['qb-core']:GetCoreObject()

local display = false

function SetDisplay(bool) -- kann true oder false sein
    display = bool
    SetNuiFocus(bool, bool) -- true/false cursor
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNetEvent("openui", function()
    SetDisplay(not display)
end)

RegisterCommand("openui", function(source, args)
    SetDisplay(not display)
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

Citizen.CreateThread(function(data)
    exports['qb-target']:AddBoxZone("elv0", vector3(-1096.78, -848.21, 4.88), 0.5, 0.5, {
        name = "elv0",
        heading = 335,
        debugPoly = false,
        minZ = 2.68,
        maxZ = 41.44,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 1', vector3(-1096.74, -848.25, 10.28), 1.0, 1, {
        heading = 335,
        minZ = 8.08,
        maxZ = 22.83,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 2', vector3(-1096.73, -848.25, 13.69), 1.0, 1, {
        heading = 335,
        minZ = 11.69,
        maxZ = 27.8,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 3', vector3(-1096.74, -848.23, 19.0), 1.0, 1, {
        heading = 335,
        minZ = 17.4,
        maxZ = 32.57,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 4', vector3(-1096.82, -848.15, 23.04), 1.0, 1, {
        heading = 335,
        minZ = 21.24,
        maxZ = 38.57,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 5', vector3(-1096.81, -848.13, 26.83), 1.0, 1, {
        heading = 335,
        minZ = 25.23,
        maxZ = 43.57,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 6', vector3(-655.99, -1111.85, 45.68), 1.0, 1, {
        heading = 335,
        minZ = 42.88,
        maxZ = 46.88,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 7', vector3(-655.99, -1111.85, 45.68), 1.0, 1, {
        heading = 335,
        minZ = 42.88,
        maxZ = 46.88,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone('elv 8', vector3(-655.99, -1111.85, 45.68), 1.0, 1, {
        heading = 335,
        minZ = 42.88,
        maxZ = 46.88,
    }, {
        options = {
            {
                type = "client",
                event = "openui",
                icon = "fas fa-circle",
                label = "المصعد",
            },
        },
        distance = 1.5
    })
end)


Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)

        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride

    end
end)


RegisterNUICallback('Floor0ToFloor1', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1096.01, -850.51, 4.88), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
        SetDisplay(false)
        SetNuiFocus(false, false)
    end)
end)

RegisterNUICallback('Floor1ToFloor0', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1096.01, -850.51, 10.28), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
        SetDisplay(false)
        SetNuiFocus(false, false)
    end)
end)

RegisterNUICallback('Floor1ToFloor2', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1096.01, -850.51, 13.69), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
end)
RegisterNUICallback('Floor2ToFloor3', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1096.01, -850.51, 19.0), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
end)
    
RegisterNUICallback('Floor3ToFloor4', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1096.01, -850.51, 23.04), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
end)

RegisterNUICallback('Floor4ToFloor5', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1095.99, -850.52, 26.83), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
    end)
RegisterNUICallback('Floor5ToFloor6', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1095.99, -850.52, 30.76), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
end)

RegisterNUICallback('Floor6ToFloor7', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1095.99, -850.52, 34.36), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
end)

RegisterNUICallback('Floor7ToFloor8', function()
    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    QBCore.Functions.Progressbar("Waiting For The Elevator", "usingleft", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        Wait(1000)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "LiftSoundRingBell", 0.2)
        SetEntityCoords(ped, vector3(-1095.99, -850.52, 38.24), false, false, false, true)
        SetEntityHeading(ped, 60.58)
        Wait(1000)
        DoScreenFadeIn(600)
    end)
end)