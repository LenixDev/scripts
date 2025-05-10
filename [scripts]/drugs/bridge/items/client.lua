function it.hasItem(itemName, amount)
    local hasItem = lib.callback.await('lib:hasItem', false, itemName, amount)
    return hasItem
end

function it.removeItem(itemName, amount, metadata)
    local removed = lib.callback.await('drugs:server:removeItem', false, itemName, amount, metadata)
    return removed
end

function it.giveItem(itemName, amount, metadata)
    local given = lib.callback.await('drugs:server:giveItem', false, itemName, amount, metadata)
    return given
end

function it.getItemLabel(itemName)
    local itemLabel
    if it.inventory == 'ox' then
        local items = exports.ox_inventory:Items()
        return items[itemName].label
    end

    if it.inventory == 'origen' or it.inventory == 'codem' then
        return lib.callback.await('lib:server:getItemLabel', false, itemName)
    end
    if it.core == 'ox_core' then
        if Config.Debug then
            if Config.Inventory == 'ox_inventory' then
                print('items label are handled by ox_inventory')
            end
        end
    end
    if it.core == 'qb-core' then
        local item = CoreObject.Shared.Items[itemName]
        if item then
            itemLabel = item.label
        end
    end
    if it.core == 'esx' then
        itemLabel = lib.callback.await('lib:server:getItemLabel', false, itemName)
    end
    if not itemLabel then
        lib.print.error('[bridge | getItemLabel] Unable to find item labe for the item: ' .. itemName)
        lib.print.error('[bridge | getItemLabel] Please make sure that the item exists in the inventory.')
    end
    return itemLabel or itemName
end

lib.callback.register('lib:client:getItemLabel', function(itemName)
    local items = exports.ox_inventory:Items()
    return items[itemName].label
end)

function it.getItemCount(itemName)
    local itemCount = lib.callback.await('lib:getItemCount', false, itemName)
    return itemCount
end

function it.toggleItem(toggle, name, amount, metadata)
    TriggerServerEvent('lib:toggleItem', toggle, name, amount, metadata)
end