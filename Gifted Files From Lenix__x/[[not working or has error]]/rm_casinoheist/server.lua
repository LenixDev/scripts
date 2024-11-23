QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

CasinoHeist = {
    ['start'] = false,
    ['lastHeist'] = 0,
    ['heistFriends'] = {},
    ['npcSpawned'] = false,
    ['finishedFriends'] = 0,
}

AddEventHandler('playerDropped', function (reason)
    local src = source
    for k, v in pairs(CasinoHeist['heistFriends']) do
        if tonumber(v) == src then
            table.remove(CasinoHeist['heistFriends'], k)
        end
    end
    if CasinoHeist['finishedFriends'] == #CasinoHeist['heistFriends'] then
        CasinoHeist['start'] = false
        CasinoHeist['npcSpawned'] = false
        CasinoHeist['heistFriends'] = {}
        CasinoHeist['finishedFriends'] = 0
    end
end)

QBCore.Functions.CreateCallback('casinoheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - CasinoHeist['lastHeist']) < Config['CasinoHeist']['nextHeist'] and CasinoHeist['lastHeist'] ~= 0 then
        local seconds = Config['CasinoHeist']['nextHeist'] - (os.time() - CasinoHeist['lastHeist'])
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextheist'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
		cb(false)
    else
        CasinoHeist['lastHeist'] = os.time()
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('casinoheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    end
end)

RegisterNetEvent('casinoheist:server:policeAlert')
AddEventHandler('casinoheist:server:policeAlert', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayers(src)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('casinoheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('casinoheist:server:startHeist')
AddEventHandler('casinoheist:server:startHeist', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayers(src)
    CasinoHeist['start'] = true
    CasinoHeist['npcSpawned'] = false
    CasinoHeist['heistFriends'] = {}
    CasinoHeist['finishedFriends'] = 0
    
    for i = 1, #players do
        local ped = GetPlayerPed(players[i])
        local pedCo = GetEntityCoords(ped)
        local dist = #(pedCo - coords)
        if dist <= 7.0 then
            CasinoHeist['heistFriends'][i] = players[i]
            TriggerClientEvent('casinoheist:client:startHeist', players[i])
        end
    end
end)

RegisterServerEvent('casinoheist:server:rappelBusy')
AddEventHandler('casinoheist:server:rappelBusy', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:rappelBusy', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:rewardItem')
AddEventHandler('casinoheist:server:rewardItem', function(reward)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        if CasinoHeist['start'] then
            if reward.item ~= nil then
				player.Functions.AddItem(reward.item, reward.count)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward.item], "add")
            else
                player.Functions.AddMoney('cash',reward.count,'casino')
            end
        end
    end
end)

RegisterServerEvent('casinoheist:server:sellRewardItems')
AddEventHandler('casinoheist:server:sellRewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        local rewardItems = Config['CasinoHeist']['rewardItems']
        local diamondCount = player.Functions.GetItemByName(rewardItems['diamondTrolly']['item']).amount
        local goldCount = player.Functions.GetItemByName(rewardItems['goldTrolly']['item']).amount
        local cokeCount = player.Functions.GetItemByName(rewardItems['cokeTrolly']['item']).amount

        if diamondCount > 0 then
            player.Functions.RemoveItem(rewardItems['diamondTrolly']['item'], diamondCount)
            player.Functions.AddMoney('cash', rewardItems['diamondTrolly']['sellPrice'] * diamondCount, 'casino')
        end
        if goldCount > 0 then
            player.Functions.RemoveItem(rewardItems['goldTrolly']['item'], goldCount)
            player.Functions.AddMoney('cash', rewardItems['goldTrolly']['sellPrice'] * goldCount, 'casino')
        end
        if cokeCount > 0 then
            player.Functions.RemoveItem(rewardItems['cokeTrolly']['item'], cokeCount)
            player.Functions.AddMoney('cash', rewardItems['cokeTrolly']['sellPrice'] * cokeCount, 'casino')
        end

        CasinoHeist['finishedFriends'] = CasinoHeist['finishedFriends'] + 1
        if CasinoHeist['finishedFriends'] == #CasinoHeist['heistFriends'] then
            CasinoHeist['start'] = false
            CasinoHeist['npcSpawned'] = false
            CasinoHeist['heistFriends'] = {}
            CasinoHeist['finishedFriends'] = 0
        end
    end
end)

RegisterServerEvent('casinoheist:server:nightVision')
AddEventHandler('casinoheist:server:nightVision', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:nightVision', v)
    end
end)

RegisterServerEvent('casinoheist:server:syncDoor')
AddEventHandler('casinoheist:server:syncDoor', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:syncDoor', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:vaultSync')
AddEventHandler('casinoheist:server:vaultSync', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:vaultSync', v)
    end
end)

RegisterServerEvent('casinoheist:server:drillSync')
AddEventHandler('casinoheist:server:drillSync', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:drillSync', v)
    end
end)

RegisterServerEvent('casinoheist:server:lockboxSync')
AddEventHandler('casinoheist:server:lockboxSync', function()
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:lockboxSync', v)
    end
end)

RegisterServerEvent('casinoheist:server:deleteLockbox')
AddEventHandler('casinoheist:server:deleteLockbox', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:deleteLockbox', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:lootSync')
AddEventHandler('casinoheist:server:lootSync', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:lootSync', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:vaultKeypadsSync')
AddEventHandler('casinoheist:server:vaultKeypadsSync', function(index)
    for k, v in pairs(CasinoHeist['heistFriends']) do
        TriggerClientEvent('casinoheist:client:vaultKeypadsSync', v, index)
    end
end)

RegisterServerEvent('casinoheist:server:npcSync')
AddEventHandler('casinoheist:server:npcSync', function()
    local src = source
    if CasinoHeist['npcSpawned'] then return end
    CasinoHeist['npcSpawned'] = true
    TriggerClientEvent('casinoheist:client:npcSync', src)
end)