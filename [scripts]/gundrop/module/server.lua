RegisterNetEvent("gundrop:server:showTarget", function(netId)
    TriggerClientEvent('gundrop:client:showTarget', -1, netId)
end)

RegisterNetEvent("gundrop:server:openCrate", function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then DeleteEntity(entity) end
    TriggerClientEvent('gundrop:client:removeTarget', -1, netId)
    local items = GetRandomItemData()
    for _, data in pairs(items) do
        if AddItem(source, data.name, data.amount, data.metadata) then
            Notify(Config.Lang["item_recieved"] .. " " .. data.amount .. 'x ' .. data.name)
        end
    end
end)