function GetFrameworkObject()
    local object = nil

    if Config.frameworkObject == "esx" then
        -- Use the new method to get the ESX object (recommended)
        object = exports['es_extended']:getSharedObject()

    elseif Config.frameworkObject == "infinity" then
        -- Use the ESX Infinity framework method
        object = exports["esx_infinity"]:GetObject()

    elseif Config.frameworkObject == "newqb" then
        -- Use the new QBCore method
        object = exports["qb-core"]:GetCoreObject()

    elseif Config.frameworkObject == "oldqb" then
        -- Fallback to the old QBCore method
        while object == nil do
            TriggerEvent('QBCore:GetObject', function(obj) object = obj end)
            Citizen.Wait(200)
        end
    end

    return object
end
