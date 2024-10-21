QBCore = exports['qb-core']:GetCoreObject()

PlayerData = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
    end
end)

-- RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
--     PlayerData = QBCore.Functions.GetPlayerData()
--     QBCore.Functions.TriggerCallback('qb-properties:server:GetConfig', function(GlobalConfig)
--         Config = GlobalConfig
--     end)
-- end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
    PlayerData.job = jobInfo
end)