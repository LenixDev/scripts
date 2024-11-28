local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent('plist:server:createNUI')
AddEventHandler('plist:server:createNUI', function(draggable)
    local src = source
    local players = QBCore.Functions.GetPlayers()
    local draggable = draggable.draggable
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = QBCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "police" and GetDiscord(player.source) then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end
    TriggerClientEvent('plist:client:createNUI', src, CopsInfo, draggable)
end)

 

RegisterServerEvent('plist:server:updateOfficers')
AddEventHandler('plist:server:updateOfficers', function()
    local players = QBCore.Functions.GetPlayers()
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = QBCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "police" and GetDiscord(player.source) then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end

    TriggerClientEvent('plist:client:updateOfficers', -1, CopsInfo)
end)

 

QBCore.Commands.Add('plist', 'Check the active officers', {{name = '1 - تفعيل تعطيل | 2 - تعديل المكان'}}, false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    
    if xPlayer.PlayerData.job.name == "police" then
        local draggable = tonumber(args[1]) ~= nil and tonumber(args[1]) or 0

        local src = source
        local players = QBCore.Functions.GetPlayers()
        local CopsInfo = {}
        for k, v in pairs(players) do
            local player = QBCore.Functions.GetPlayer(v).PlayerData
            if player.job.name == "police" and GetDiscord(player.source) then
                local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
                table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
            end
        end
        TriggerClientEvent('plist:client:createNUI', src, CopsInfo, draggable)
        TriggerEvent('qb-logs:server:createLog', 'emergency', 'Command "plist"', "Used the command **plist** type " .. tostring(draggable), src)
    end
end)

 

function GetDiscord(src)
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if v == 'discord:change_me' then
            --return false
        end
    end
    return true
end

