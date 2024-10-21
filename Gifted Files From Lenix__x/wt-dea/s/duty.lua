local QBCore = exports['qb-core']:GetCoreObject()

--لا تلعب في شي

local function UpdateBlips()
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "DEA") and v.PlayerData.job.onduty then
            local coords = GetEntityCoords(GetPlayerPed(v.PlayerData.source))
            local heading = GetEntityHeading(GetPlayerPed(v.PlayerData.source))
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name,
                location = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
            }
        end
    end
    TriggerClientEvent("DEA:client:UpdateBlips", -1, dutyPlayers)
end


RegisterNetEvent('DEA:server:UpdateBlips', function()
    
end)

CreateThread(function()
    while true do
        Wait(5000)
        UpdateBlips()
        
    end
end)