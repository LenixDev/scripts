local QBCore = exports['qb-core']:GetCoreObject()

-- وظيفة لتفقد إذا كان اللاعب من عصابة المافيا
local function isInMafiaGang(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        local gangName = Player.PlayerData.gang.name
        return gangName == 'gangleaders'
    end
    return false
end

-- وظيفة لإضافة العتاد إلى المخزن
RegisterNetEvent('lootgenerator:addItem', function(itemName, itemAmount)
    local playerId = source
    if isInMafiaGang(playerId) then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            Player.Functions.AddItem(itemName, itemAmount)
            TriggerClientEvent('QBCore:Notify', playerId, 'تم أخذ ' .. itemAmount .. ' من ' .. itemName, 'success')
            TriggerClientEvent('inventory:client:ItemBox', playerId, QBCore.Shared.Items[itemName], 'add')
        end
    else
        TriggerClientEvent('QBCore:Notify', playerId, 'ليس لديك الصلاحية للوصول إلى هذا المخزن', 'error')
    end
end)