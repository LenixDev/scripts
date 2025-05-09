QBCore = exports['qb-core']:GetCoreObject()

--لا تلعب في شييي

RegisterServerEvent('YWT:DEV:Data', function(info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('id_card', 1 , false , info)
    TriggerClientEvent("QBCore:Notify", src, "You Are Get Your Fake ID Card", "success")
end)
