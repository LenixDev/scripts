ESX = nil
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/961952334575968310/6rhW3eYQw4I1zAVHRSSRfh9QRP8Kh8cP_dkcasbC01TdsOgLUNCqOOopQ4nBv1-gRxVB',
    ['name'] = 'rm_vangelicoheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

QBCore.Functions.CreateUseableItem(Config['VangelicoHeist']['gasmask']['itemName'], function(source)
    local src = source
    TriggerClientEvent('vangelicoheist:client:wearMask', src)
end)

QBCore.Functions.CreateCallback('vangelicoheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
      --  local player = ESX.GetPlayerFromId(players[i])
      --  if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['VangelicoHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
      --  TriggerClientEvent('vangelicoheist:client:showNotification', src, Strings['need_police'])
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'] , 'error', 3000)
    end
end)

QBCore.Functions.CreateCallback('vangelicoheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['VangelicoHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['VangelicoHeist']['nextRob'] - (os.time() - lastrob)
        --TriggerClientEvent('vangelicoheist:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'] , 'error', 3000)
        cb(false)
    else
        lastrob = os.time()
        start = true
       -- discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' started the Vangelico Heist!')
        discordLog(GetPlayerName(src) ..  ' - ' .. player.PlayerData.license, ' started the Vangelico Heist!')
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('vangelicoheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
       -- print('[rm_vangelicoheist] you need add required items to server database')
        TriggerClientEvent('QBCore:Notify', src, 'You missing items - Bag/Cutter' , 'error', 5000)
    end
end)
--[[
RegisterServerEvent('vangelicoheist:server:policeAlert')
AddEventHandler('vangelicoheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('vangelicoheist:client:policeAlert', players[i], coords)
        end
    end
end)
--]]

RegisterServerEvent('vangelicoheist:server:rewardItem')
AddEventHandler('vangelicoheist:server:rewardItem', function(item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local whitelistItems = {}

    if player then
        for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
            whitelistItems[v['item']] = true
        end

        for k, v in pairs(Config['VangelicoInside']['glassCutting']['rewards']) do
            whitelistItems[v['item']] = true
        end

        for k, v in pairs(Config['VangelicoInside']['painting']) do
            whitelistItems[v['rewardItem']] = true
        end

        if whitelistItems[item] then
           -- player.addInventoryItem(item, 1)
            player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        else
            print('[rm_vangelicoheist] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
        end
    end
end)

RegisterServerEvent('vangelicoheist:server:sellRewardItems')
AddEventHandler('vangelicoheist:server:sellRewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local totalMoney = 0

    if player then
        for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do

            if player.Functions.GetItemByName(v['item']) ~= nil then

            local playerItem = player.Functions.GetItemByName(v['item'])

            if playerItem.amount >= 1 then
                
                player.Functions.RemoveItem(v['item'], playerItem.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['item']], "remove")
                player.Functions.AddMoney("cash", playerItem.amount * v['price'])
                totalMoney = totalMoney + (playerItem.amount * v['price'])

              --player.removeInventoryItem(v['item'], playerItem.count)
              --player.addMoney(playerItem.count * v['price'])
            end
          end
        end

        for k, v in pairs(Config['VangelicoInside']['glassCutting']['rewards']) do

            if player.Functions.GetItemByName(v['item']) ~= nil then

            local playerItem = player.Functions.GetItemByName(v['item'])

            if playerItem.amount >= 1 then

                player.Functions.RemoveItem(v['item'], playerItem.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['item']], "remove")
                player.Functions.AddMoney("cash", playerItem.amount * v['price'])
                totalMoney = totalMoney + (playerItem.amount * v['price'])

             --player.removeInventoryItem(v['item'], playerItem.count)
             --player.addMoney(playerItem.count * v['price'])

            end
          end
        end

        for k, v in pairs(Config['VangelicoInside']['painting']) do

            if player.Functions.GetItemByName(v['rewardItem']) ~= nil then

            local playerItem = player.Functions.GetItemByName(v['rewardItem'])

            if playerItem.amount >= 1 then

                player.Functions.RemoveItem(v['rewardItem'], playerItem.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['rewardItem']], "remove")
                player.Functions.AddMoney("cash", playerItem.amount * v['paintingPrice'])
                totalMoney = totalMoney + (playerItem.amount * v['paintingPrice'])

                --player.removeInventoryItem(v['rewardItem'], playerItem.count)
                --player.addMoney(playerItem.count * v['paintingPrice'])
            end
          end
        end

        local chance = math.random(1, 100)
        if chance < 10 then
            Player.Functions.AddItem("cryptostick", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptostick"], "add")
        end

       -- discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain $' .. math.floor(totalMoney) .. ' on the Vangelico Heist Buyer!')
        discordLog(GetPlayerName(src) ..  ' - ' .. player.PlayerData.license, ' Gain $' .. math.floor(totalMoney) .. ' on the Vangelico Heist Buyer!')
       -- TriggerClientEvent('vangelicoheist:client:showNotification', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney))
        TriggerClientEvent('QBCore:Notify', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney), 'success', 3000)
    end
end)

RegisterServerEvent('radialmenu:resetVangelico')
AddEventHandler('radialmenu:resetVangelico', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local isGod = QBCore.Functions.HasPermission(src, 'god')
    
    if player then
      --  if player['job']['name'] == 'police' then
      if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) or isGod then
            if start then
                TriggerClientEvent('vangelicoheist:client:resetHeist', -1)
                TriggerClientEvent('QBCore:Notify', src, 'Cleared the robbery scene!', 'success', 3000)
                start = false
                TriggerEvent("qb-log:server:CreateLog", "heistreset", "Vangelico Reset", "green", "**"..GetPlayerName(source) .. "** used the reset on **Vangelico Heist**")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are not cop / not on duty', 'error', 3000)
        end
    end
end)

RegisterCommand('pdvangelico', function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local isGod = QBCore.Functions.HasPermission(src, 'god')
    
    if player then
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) or isGod then
            if start then
                TriggerClientEvent('vangelicoheist:client:resetHeist', -1)
                TriggerClientEvent('QBCore:Notify', src, 'Cleared the robbery scene!', 'success', 3000)
                start = false
                TriggerEvent("qb-log:server:CreateLog", "heistreset", "Vangelico Reset", "green", "**"..GetPlayerName(source) .. "** used the reset on **Vangelico Heist**")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are not cop / not on duty', 'error', 3000)
        end
    end
end)

RegisterServerEvent('vangelicoheist:server:startGas')
AddEventHandler('vangelicoheist:server:startGas', function()
    TriggerClientEvent('vangelicoheist:client:startGas', -1)
end)

RegisterServerEvent('vangelicoheist:server:insideLoop')
AddEventHandler('vangelicoheist:server:insideLoop', function()
    TriggerClientEvent('vangelicoheist:client:insideLoop', -1)
end)

RegisterServerEvent('vangelicoheist:server:lootSync')
AddEventHandler('vangelicoheist:server:lootSync', function(type, index)
    TriggerClientEvent('vangelicoheist:client:lootSync', -1, type, index)
end)

RegisterServerEvent('vangelicoheist:server:globalObject')
AddEventHandler('vangelicoheist:server:globalObject', function(obj, random)
    TriggerClientEvent('vangelicoheist:client:globalObject', -1, obj, random)
end)

RegisterServerEvent('vangelicoheist:server:smashSync')
AddEventHandler('vangelicoheist:server:smashSync', function(sceneConfig)
    TriggerClientEvent('vangelicoheist:client:smashSync', -1, sceneConfig)
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end