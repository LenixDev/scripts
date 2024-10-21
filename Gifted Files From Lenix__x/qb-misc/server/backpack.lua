

QBCore.Functions.CreateUseableItem("backpack", function(source, item)
    if not item.info then return end 
    if not item.info.id then return end 
    if not item.info.maxweight then return end 
    if not item.info.slots then return end 
    if item.info.id then 
        TriggerClientEvent('qb-backpack:client:openbackpack', source, item.info.id, item.info.maxweight, item.info.slots)
    end
end)

QBCore.Functions.CreateUseableItem("backpackgirl", function(source, item)
    if not item.info then return end 
    if not item.info.id then return end 
    if not item.info.maxweight then return end 
    if not item.info.slots then return end 
    if item.info.id then 
        TriggerClientEvent('qb-backpack:client:openbackpack', source, item.info.id, item.info.maxweight, item.info.slots)
    end
end)