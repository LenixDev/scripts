local QBCore = exports['qb-core']:GetCoreObject()

PlayerData = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
    PlayerData.job = jobInfo
end)


CreateThread(function()
    local Blip = AddBlipForCoord(Config.Locations)
    SetBlipSprite (Blip, 677)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 0.7)
    SetBlipColour(Blip, 20)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Containers")
    EndTextCommandSetBlipName(Blip)
end)