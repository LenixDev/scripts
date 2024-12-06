local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    for id, zone in ipairs(HiveZones) do
        exports["nchub-polyzone"]:AddCircleZone("row-beekeeping:bee_zone", zone[1], zone[2],{
            zoneEvents={"row-beekeeping:trigger_zone"},
            data = {
                id = id,
            },
        })
    end
end)
