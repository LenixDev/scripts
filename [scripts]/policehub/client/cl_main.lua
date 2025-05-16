local QBCore = exports['qb-core']:GetCoreObject()
local isOpened = false

-- // Main \\ --

RegisterNetEvent('policehub:clint:update', function(data)
    if data.type == 'add' then
        SendNUIMessage({
            action = 'addOfficer',
            officer = data.officer
        })
    end
    if data.type == 'remove' then
        SendNUIMessage({
            action = 'deleteofiro',
            citizenid = data.officer
        })
    end
    if data.type == 'update' then
        SendNUIMessage({
            action = 'ofiro',
            officers = data.officers,
            count = data.count
        })
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name == 'police' then
        TriggerServerEvent('policehub:server:addOfficer')
    end
end)

AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name == 'police' then
        TriggerServerEvent('policehub:server:deleteofiro')
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData.job.name == 'police' then
            TriggerServerEvent('policehub:server:UpdateHub', 'all')
        end
    end
end)

-- // Nui CallBacks \\ --

RegisterNuiCallback('fucs', function(data, cb)
    if isOpened then
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'fucs',
            fucs = false
        })
    end
    cb(true)
end)

RegisterNUICallback("joinradio", function(channel, cb)
    local channel = tonumber(channel)
    if channel then
        exports["pma-voice"]:setRadioChannel(0)
        exports['pma-voice']:addPlayerToRadio(channel, "Radio", "radio")
        QBCore.Functions.Notify("connected to Radio " .. channel .. "!", "success")
    else
        QBCore.Functions.Notify("This officer not in radio channel!", "error")
    end
    cb(true)
end)

RegisterNUICallback("waypoint", function(cid, cb)
    QBCore.Functions.TriggerCallback('policehub:server:GetCoords', function(coords)
        if coords ~= nil then
            SetNewWaypoint(coords.x, coords.y)
            QBCore.Functions.Notify("Waypoint Set", "success")
        end
    end, cid)
    cb(true)
end)

RegisterNUICallback("duty", function(duty, cb)
    TriggerServerEvent('policehub:server:duty', duty)
    QBCore.Functions.Notify('Duty Changed', 'success')
    cb(true)
end)

RegisterNUICallback("dispatch", function(dispatch, cb)
    TriggerServerEvent('policehub:server:dispatch', dispatch)
    cb(true)
end)


RegisterNUICallback("callsign", function(callsign, cb)
    TriggerServerEvent('policehub:server:callsign', callsign)
    cb(true)
end)

-- // Commands \\ --
RegisterCommand('phub', function()
    TriggerServerEvent('policehub:server:UpdateHub')
    Wait(50)
    local image = exports['MugShotBase64']:GetMugShotBase64(GetPlayerPed(-1), false)
    while (not image) do
        Wait(0)
    end
    SendNUIMessage({
        action = 'toggle',
        PlayerData = QBCore.Functions.GetPlayerData(),
        MugShot = image
    })
    isOpened = not isOpened
end, false)

RegisterCommand('phube', function(source, args, rawCommand)
    if isOpened then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'fucs',
            fucs = true
        })
    end
end, false)

RegisterKeyMapping('phube', 'description', 'keyboard', 'F11')

RegisterKeyMapping('phub', 'description', 'keyboard', 'EQUALS')