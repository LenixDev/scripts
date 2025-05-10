local getMetadata = function(itemData)
    if not itemData then return nil end
    local encodedData = json.encode(itemData)
    if it.inventory == 'ox' then
        return itemData.metadata or nil
    elseif it.core == "qb-core" then
        return itemData.info or nil
    elseif it.core == "esx" then
        return itemData.metadata or nil
    end
end

for plant, _ in pairs(Config.Plants) do
    it.createUsableItem(plant, function(source, data)
        local src = source
        if it.hasItem(src, plant, 1) then
            local metadata = getMetadata(data)
            if Config.Debug then lib.print.info('Plant metadata', metadata) end
            TriggerClientEvent('drugs:client:useSeed', src, plant, metadata)
        end
    end)
end

if Config.EnableProcessing then
    for prTable, _ in pairs(Config.ProcessingTables) do
        it.createUsableItem(prTable, function(source, data)
            local src = source
            if it.hasItem(src, prTable, 1) then
                local metadata = getMetadata(data)
                if Config.Debug then lib.print.info('Table metadata', metadata) end
                TriggerClientEvent('drugs:client:placeProcessingTable', src, prTable, metadata)
            end
        end)
    end
end

if Config.EnableDrugs then

    if it.inventory ~= "ox" then
        for drug, _ in pairs(Config.Drugs) do
            it.createUsableItem(drug, function(source, data)
                local src = source
                if it.hasItem(src, drug, 1) then
                    local currentDrug = lib.callback.await('drugs:client:getCurrentDrugEffect', src)
                    if Config.Debug then lib.print.info('currentDrug', currentDrug) end
                    if not currentDrug then

                        local isDrugOnCooldown = lib.callback.await('drugs:client:isDrugOnCooldown', src, drug)
                        if isDrugOnCooldown then
                            ShowNotification(src, _U('NOTIFICATION__DRUG__COOLDOWN'), "info")
                            return
                        end

                        local metadata = getMetadata(data)
                        if it.removeItem(src, drug, 1, metadata) then
                            TriggerClientEvent('drugs:client:takeDrug', src, drug)
                        else
                            if Config.Debug then lib.print.error('Failed to remove item') end
                        end
                    else
                        ShowNotification(src, _U('NOTIFICATION__DRUG__ALREADY'), "info")
                    end
                end
            end)
        end
    else
        for drug, _ in pairs(Config.Drugs) do
            exports(drug, function(event, item, inventory, slot, data)
                if event == 'usedItem' or event == 'usingItem' then -- EVENT MIGHT BE usingItem
                    local src = inventory.id
                    local currentDrug = lib.callback.await('drugs:client:getCurrentDrugEffect', src)
                    if Config.Debug then lib.print.info('currentDrug', currentDrug) end
                    if not currentDrug then

                        local isDrugOnCooldown = lib.callback.await('drugs:client:isDrugOnCooldown', src, drug)
                        if isDrugOnCooldown then
                            ShowNotification(src, _U('NOTIFICATION__DRUG__COOLDOWN'), "info")
                            return
                        end

                        TriggerClientEvent('drugs:client:takeDrug', src, drug)
                        exports.ox_inventory:RemoveItem(src, item, 1, nil, slot) -- ADDED THIS ONE TO REMOVE ITEM, on ox_inventory consume = 0
                       
                    else
                        ShowNotification(src, _U('NOTIFICATION__DRUG__ALREADY'), "info")
                    end
                end
            end)
        end
    end
end

exports['qb-core']:AddItems({
    ['watering_can'] = { name = 'watering_can', label = 'Watering can', weight = 500, type = 'item', image = 'watering_can.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'simple watering can' },
    ['fertilizer'] = { name = 'fertilizer', label = 'fertilizer', weight = 500, type = 'item', image = 'fertilizer.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'fertilizer' },
    ['advanced_fertilizer'] = { name = 'advanced_fertilizer', label = 'Advanced Fertilizer', weight = 500, type = 'item', image = 'advanced_fertilizer.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Fertilizer with the little extra' },
    ['liquid_fertilizer'] = { name = 'liquid_fertilizer', label = 'Liquid Fertilizer', weight = 200, type = 'item', image = 'liquid_fertilizer.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Basically water with nutrients' },
    ['weed_lemonhaze_seed'] = { name = 'weed_lemonhaze_seed', label = 'Weed Lemonhaze Seed', weight = 20, type = 'item', image = 'weed_lemonhaze_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Weed Lemonhaze Seed' },
    ['weed_lemonhaze'] = { name = 'weed_lemonhaze', label = 'Weed Lemonhaze', weight = 20, type = 'item', image = 'weed_lemonhaze.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Weed Lemonhaze' },
    ['weed_og_seed'] = { name = 'weed_og_seed', label = 'Weed Og Seed', weight = 20, type = 'item', image = 'weed_og_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Weed Og Seed' },
    ['weed_og'] = { name = 'weed_og', label = 'Weed Og', weight = 20, type = 'item', image = 'weed_og.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Weed Og' },
    ['weed_purple_haze_seed'] = { name = 'weed_purple_haze_seed', label = 'Weed Purple Haze Seed', weight = 20, type = 'item', image = 'weed_purple_haze_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Weed Purple Haze Seed' },
    ['weed_purple_haze'] = { name = 'weed_purple_haze', label = 'Weed Purple Haze', weight = 20, type = 'item', image = 'weed_purple_haze.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Weed Purple Haze' },
    ['weed_white_widow_seed'] = { name = 'weed_white_widow_seed', label = 'Weed White Widow Seed', weight = 20, type = 'item', image = 'weed_white_widow_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Weed White Widow Seed' },
    ['weed_white_widow'] = { name = 'weed_white_widow', label = 'Weed White Widow', weight = 20, type = 'item', image = 'weed_white_widow.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Weed White Widow' },
    ['weed_blueberry_seed'] = { name = 'weed_blueberry_seed', label = 'Weed Blueberry Seed', weight = 20, type = 'item', image = 'weed_blueberry_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Weed Blueberry Seed' },
    ['weed_blueberry'] = { name = 'weed_blueberry', label = 'Weed Blueberry', weight = 20, type = 'item', image = 'weed_blueberry.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Weed Blueberry' },
    ['coca_seed'] = { name = 'coca_seed', label = 'Coca Seed', weight = 20, type = 'item', image = 'coca_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Coca Seed' },
    ['coca'] = { name = 'coca', label = 'Coca', weight = 20, type = 'item', image = 'coca.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'Coca' },
    ['paper'] = { name = 'paper', label = 'Paper', weight = 50, type = 'item', image = 'paper.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Paper' },
    ['cocaine'] = { name = 'cocaine', label = 'Cocaine', weight = 20, type = 'item', image = 'cocaine.png', unique = false, useable = true, shouldClose = false, combinable = nil, description = 'Small bag of cocaine' },
    ['weed_processing_table'] = { name = 'weed_processing_table', label = 'Weed Processing Table', weight = 1000, type = 'item', image = 'weed_processing_table.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Process some weed' },
    ['cocaine_processing_table'] = { name = 'cocaine_processing_table', label = 'Cocaine Processing Table', weight = 1000, type = 'item', image = 'cocaine_processing_table.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Process some cocaine' },
})