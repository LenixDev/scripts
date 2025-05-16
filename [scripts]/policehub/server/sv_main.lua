local QBCore = exports['qb-core']:GetCoreObject()
local dispatchCid = nil

RegisterNetEvent('policehub:server:addOfficer', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local Officer = { type = 'add' }
    if xPlayer then
        Officer.officer = '<div class="Playrbox" id="officer-' .. xPlayer.PlayerData.citizenid .. '">' ..
            '<i class="' ..
            GetDuty(xPlayer.PlayerData.source, 'dispatch') ..
            ' fa-solid fa-circle" style="left: 5px; top: 6px; color: ' ..
            GetDuty(xPlayer.PlayerData.source, 'duty') .. ';"></i>' ..
            '<span class="callsin-namepolice">' ..
            xPlayer.PlayerData.metadata.callsign ..
            ' ' .. xPlayer.PlayerData.charinfo.firstname .. xPlayer.PlayerData.charinfo.lastname .. '</span>' ..
            '<span class="radio">' .. GetRadioChannel(xPlayer.PlayerData.source) ..
            ' </span><i class="icon2 fa-solid fa-signal-stream" id="Radio"></i>' ..
            '<i class="icon2 fa-solid fa-location-dot" id="Coords"></i>\n</div>'
    end
    Wait(250)
    TriggerClientEvent('policehub:clint:update', -1, Officer)
end)

RegisterNetEvent('policehub:server:deleteofiro', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Officer = { type = 'remove' }
    Officer.officer = Player.PlayerData.citizenid
    Wait(250)
    TriggerClientEvent('policehub:clint:update', -1, Officer)
end)

RegisterNetEvent('policehub:server:UpdateHub', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Officers = ''
    local count = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local xPlayer = QBCore.Functions.GetPlayer(v)
        if xPlayer and (xPlayer.PlayerData.job.name == 'police') then
            Officers = Officers .. '<div class="Playrbox" id="officer-' .. xPlayer.PlayerData.citizenid .. '">' ..
                '<i class="' ..
                GetDuty(xPlayer.PlayerData.source, 'dispatch') ..
                ' fa-solid fa-circle" style="left: 5px; top: 6px; color: ' ..
                GetDuty(xPlayer.PlayerData.source, 'duty') .. ';"></i>' ..
                '<span class="callsin-namepolice">' ..
                xPlayer.PlayerData.metadata.callsign ..
                ' ' .. xPlayer.PlayerData.charinfo.firstname .. xPlayer.PlayerData.charinfo.lastname .. '</span>' ..
                '<span class="radio">' .. GetRadioChannel(xPlayer.PlayerData.source) ..
                ' </span><i class="icon2 fa-solid fa-signal-stream" id="Radio"></i>' ..
                '<i class="icon2 fa-solid fa-location-dot" id="Coords"></i>\n</div>'
            count = count + 1
        end
    end
    Wait(250)
    if type and type == 'all' then
        TriggerClientEvent('policehub:clint:update', -1, { type = 'update', officers = Officers, count = count })
    else
        TriggerClientEvent('policehub:clint:update', src, { type = 'update', officers = Officers, count = count })
    end
end)

RegisterNetEvent('policehub:server:dispatch', function(duty)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not dispatchCid then
        dispatchCid = Player.PlayerData.citizenid
    else
        if Player.PlayerData.citizenid == dispatchCid then
            dispatchCid = nil
        end
    end
    TriggerEvent('policehub:server:UpdateHub', 'all')
end)

RegisterNetEvent('policehub:server:duty', function(duty)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetJobDuty(duty)
    TriggerEvent('policehub:server:UpdateHub', 'all')
end)

RegisterNetEvent('policehub:server:callsign', function(newSign)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.SetMetaData("callsign", newSign)
    TriggerEvent('policehub:server:UpdateHub', 'all')
end)

QBCore.Functions.CreateCallback('policehub:server:GetCoords', function(source, cb, citizenid)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)

    if xPlayer then
        local playerPed = GetPlayerPed(xPlayer.PlayerData.source)
        local location = GetEntityCoords(playerPed)
        cb(location)
    else
        cb(nil)
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Officer = { type = 'remove' }
    Officer.officer = Player.PlayerData.citizenid
    if Player.PlayerData.citizenid == dispatchCid then
        dispatchCid = nil
    end
    Wait(250)
    TriggerClientEvent('policehub:clint:update', -1, Officer)
end)

GetDuty = function(source, data)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if data and data == 'dispatch' then
        if xPlayer.PlayerData.citizenid == dispatchCid then
            return 'dispatch'
        else
            return ''
        end
    elseif data == 'duty' then
        if xPlayer.PlayerData.job.onduty then
            return Config.DutyColors['on']
        else
            return Config.DutyColors['off']
        end
    end
end

function GetRadioChannel(source)
    if Player(source).state['radioChannel'] and Player(source).state['radioChannel'] > 0 then
        return Player(source).state['radioChannel']
    else
        return '?'
    end
end
