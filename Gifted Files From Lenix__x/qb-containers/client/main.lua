QBCore = exports['qb-core']:GetCoreObject()

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

{
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(888.96, -2968.37, 5.9) -- vector3(888.96, -2968.37, 5.9)
        SetBlipSprite(blip, 770)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 50)  
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Containers Area")
        EndTextCommandSetBlipName(blip)
    end)
    }