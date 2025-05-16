RegisterNetEvent("craft:server:HandleCallback", function(key, payload)
    local src = source
    if Koci.Callbacks[key] then
        Koci.Callbacks[key](src, payload, function(cb)
            TriggerClientEvent("craft:client:HandleCallback", src, key, cb)
        end)
    end
end)

RegisterNetEvent("craft:server:ErrorHandle", function(error)
    Koci.Utils:printTable(error)
end)
