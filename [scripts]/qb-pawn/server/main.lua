local QBCore = exports['qb-core']:GetCoreObject()

local function exploitBan(id, reason)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        {
            GetPlayerName(id),
            QBCore.Functions.GetIdentifier(id, 'license'),
            QBCore.Functions.GetIdentifier(id, 'discord'),
            QBCore.Functions.GetIdentifier(id, 'ip'),
            reason,
            2147483647,
            'qb-Pawn'
        })
    TriggerEvent('qb-log:server:CreateLog', 'Pawn', 'Player Banned', 'red',
        string.format('%s was banned by %s for %s', GetPlayerName(id), 'qb-Pawn', reason), true)
    DropPlayer(id, 'You were permanently banned by the server for: Exploiting')
end

RegisterNetEvent('qb-Pawn:server:sellPawnItems', function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    for _, value in pairs(Config.PawnLocation) do
        dist = #(playerCoords - value.coords)
        if #(playerCoords - value.coords) < 2 then
            dist = #(playerCoords - value.coords)
            break
        end
    end
    if dist > 5 then
        exploitBan(src, 'sellPawnItems Exploiting')
        return
    end
    if exports['qb-inventory']:RemoveItem(src, itemName, tonumber(itemAmount), false, 'qb-Pawn:server:sellPawnItems') then
        if Config.BankMoney then
            Player.Functions.AddMoney('bank', totalPrice, 'qb-Pawn:server:sellPawnItems')
        else
            Player.Functions.AddMoney('cash', totalPrice, 'qb-Pawn:server:sellPawnItems')
        end
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sold', { value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice }), 'success')
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
    TriggerClientEvent('qb-Pawn:client:openMenu', src)
end)

RegisterNetEvent('qb-Pawn:server:meltItemRemove', function(itemName, itemAmount, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if exports['qb-inventory']:RemoveItem(src, itemName, itemAmount, false, 'qb-Pawn:server:meltItemRemove') then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
        local meltTime = (tonumber(itemAmount) * item.time)
        TriggerClientEvent('qb-Pawn:client:startMelting', src, item, tonumber(itemAmount), (meltTime * 60000 / 1000))
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.melt_wait', { value = meltTime }), 'primary')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
end)

RegisterNetEvent('qb-Pawn:server:pickupMelted', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    for _, value in pairs(Config.PawnLocation) do
        dist = #(playerCoords - value.coords)
        if #(playerCoords - value.coords) < 2 then
            dist = #(playerCoords - value.coords)
            break
        end
    end
    if dist > 5 then
        exploitBan(src, 'pickupMelted Exploiting')
        return
    end
    for _, v in pairs(item.items) do
        local meltedAmount = v.amount
        for _, m in pairs(v.item.reward) do
            local rewardAmount = m.amount
            if exports['qb-inventory']:AddItem(src, m.item, (meltedAmount * rewardAmount), false, false, 'qb-Pawn:server:pickupMelted') then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[m.item], 'add')
                TriggerClientEvent('QBCore:Notify', src, Lang:t('success.items_received', { value = (meltedAmount * rewardAmount), value2 = QBCore.Shared.Items[m.item].label }), 'success')
                TriggerClientEvent('qb-Pawn:client:resetPickup', src)
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.inventory_full', { value = QBCore.Shared.Items[m.item].label }), 'warning', 7500)
            end
        end
    end
    TriggerClientEvent('qb-Pawn:client:openMenu', src)
end)

QBCore.Functions.CreateCallback('qb-Pawn:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)

-- ar
exports['qb-core']:AddItems({
    -- Pawn
    ['moneyroll1'] = { name = 'moneyroll1', label = 'نقود', weight = 100, type = 'item', image = 'moneyroll1.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['moneyroll2'] = { name = 'moneyroll2', label = 'نقود', weight = 100, type = 'item', image = 'moneyroll2.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['moneyroll3'] = { name = 'moneyroll3', label = 'نقود', weight = 100, type = 'item', image = 'moneyroll3.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['moneyroll4'] = { name = 'moneyroll4', label = 'حزمة نقود', weight = 100, type = 'item', image = 'cashstack.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['stolenart'] = { name = 'stolenart', label = 'لوحة فنية', weight = 1000, type = 'item', image = 'stolenart.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolencoffee'] = { name = 'stolencoffee', label = 'آلة قهوة', weight = 1000, type = 'item', image = 'stolencoffee.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolencomputer'] = { name = 'stolencomputer', label = 'حاسوب', weight = 1000, type = 'item', image = 'stolencomputer.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolenmicrowave'] = { name = 'stolenmicrowave', label = 'ميكروويف', weight = 1000, type = 'item', image = 'stolenmicrowave.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolenmusic'] = { name = 'stolenmusic', label = 'آلة موسيقية', weight = 1000, type = 'item', image = 'stolenmusic.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolentv'] = { name = 'stolentv', label = 'تلفزيون', weight = 1000, type = 'item', image = 'stolentv.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
})

-- en
--[[ exports['qb-core']:AddItems({
    -- Pawn
    ['moneyroll1'] = { name = 'moneyroll1', label = 'Money', weight = 100, type = 'item', image = 'moneyroll1.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['moneyroll2'] = { name = 'moneyroll2', label = 'Money', weight = 100, type = 'item', image = 'moneyroll2.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['moneyroll3'] = { name = 'moneyroll3', label = 'Money', weight = 100, type = 'item', image = 'moneyroll3.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['moneyroll4'] = { name = 'moneyroll4', label = 'Money Roll', weight = 100, type = 'item', image = 'cashstack.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
    ['stolenart'] = { name = 'stolenart', label = 'Art', weight = 1000, type = 'item', image = 'stolenart.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolencoffee'] = { name = 'stolencoffee', label = 'Coffee Machine', weight = 1000, type = 'item', image = 'stolencoffee.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolencomputer'] = { name = 'stolencomputer', label = 'Computer', weight = 1000, type = 'item', image = 'stolencomputer.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolenmicrowave'] = { name = 'stolenmicrowave', label = 'Microwave', weight = 1000, type = 'item', image = 'stolenmicrowave.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolenmusic'] = { name = 'stolenmusic', label = 'Music Machine', weight = 1000, type = 'item', image = 'stolenmusic.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'مال؟' },
    ['stolentv'] = { name = 'stolentv', label = 'Television', weight = 1000, type = 'item', image = 'stolentv.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'نقد؟' },
}) ]]