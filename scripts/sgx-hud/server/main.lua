local QBCore = exports['qb-core']:GetCoreObject()
local ResetStress = false

RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('QBCore:Notify', src, Lang:t('error.gain_stress'), 'error', 1500)
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('QBCore:Notify', src, Lang:t('error.relax_stress'))
end)

QBCore.Commands.Add("cash", "Check your cash balance", {}, false, function(source, args)
	local src = source
	TriggerClientEvent('sgx-hud:client:DisplayCash', src)
end)

QBCore.Commands.Add("bank", "Check your bank balance", {}, false, function(source, args)
	local src = source
	TriggerClientEvent('sgx-hud:client:DisplayBank', src)
end)

-- QBCore.Commands.Add("devmode", "Check your cash balance", {}, false, function(source, args)
-- 	local src = source
-- 	TriggerClientEvent('sgx-hud:client:DisplayCash', src)
-- end)

-- QBCore.Commands.Add("bank", "Check your bank balance", {}, false, function(source, args)
-- 	local src = source
-- 	TriggerClientEvent('sgx-hud:client:DisplayBank', src)
-- end)