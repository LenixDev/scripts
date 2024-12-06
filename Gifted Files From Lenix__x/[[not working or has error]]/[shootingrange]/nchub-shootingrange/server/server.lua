local QBCore = exports['qb-core']:GetCoreObject()
local Busy = false
local timer = 0

QBCore.Functions.CreateUseableItem(Config.CaseItemName, function(source, item)
    local src = source
    TriggerClientEvent("nchub-shootingrange:client:UseCaseItem", src)
end)

QBCore.Functions.CreateCallback('nchub-shootingrange:server:GetCheckMoney', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local MoneyType = Ply.PlayerData.money
    if not Busy then
        if MoneyType.cash >= Config.StartPrice then
            Ply.Functions.RemoveMoney('cash', Config.StartPrice, "Shooting")
            cb(true)
        elseif MoneyType.bank >= Config.StartPrice then
            Ply.Functions.RemoveMoney('bank', Config.StartPrice, "Shooting")
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'The shooting range is full', 'error')
    end
    cb(false)
end)

RegisterServerEvent('nchub-shootingrange:server:AddedItem')
AddEventHandler('nchub-shootingrange:server:AddedItem', function(item , amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddItem(item, amount)
end)

RegisterServerEvent('Nchub-additem:shooting')
AddEventHandler('Nchub-additem:shooting', function(item , amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local randomItem = Config.CaseLoot[math.random(1, #Config.CaseLoot)]
    local Player = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddItem(randomItem)
    Player.Functions.RemoveItem("shootingtoken", 1)
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[randomItem], "add", randomItem)
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["shootingtoken"], "remove", 1)
end)

RegisterNetEvent('nchub-shootingrange:server:StartServerSideTimer', function(Timer)
    timer = Timer
    CreateThread(function()
        while Busy do
            Wait(1000)
            timer = timer - 1
            if timer <= 0 then
                Busy = false
            end
        end
    end)
end)

RegisterNetEvent('nchub-shootingrange:server:SetBusy', function(Toggle)
    Busy = Toggle
end)