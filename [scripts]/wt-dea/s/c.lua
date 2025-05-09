local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("megaphone", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('megaphone:Toggle', source, item)
end)

QBCore.Functions.CreateUseableItem("DEA", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('Cams', source, item)
end)

QBCore.Functions.CreateUseableItem("mdt", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('mdt', source, item)
end)



RegisterCommand("wt", function ()
    
end)

