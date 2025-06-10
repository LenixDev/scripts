Koci.Server:RegisterServerCallback("craft:server:GetPlayerInventory", function(source, data, cb)
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({ inventory = nil })
        return
    end
    local playerInventory = Koci.Server:GetPlayerInventory(xPlayer)
    cb({ inventory = playerInventory })
end)

Koci.Server:RegisterServerCallback("craft:server:AddAttachmentData", function(source, data, cb)
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({ error = _t("game.unknown_player") })
        return
    end
    local weapon = data.weapon
    local attachment = data.attachment
    local hasItem = Koci.Server:HasItem(src, string.lower(attachment.name), 1)
    if not hasItem then
        cb({
            status = false,
            error = _t("game.dont_have_item", attachment.name)
        })
        return
    end
    local slotWithItem = Koci.Server:GetInventorySlotWithItem(src, weapon._item.name, weapon._item.metadata, true)
    if not slotWithItem then
        cb({
            status = false,
            error = _t("game.dont_have_item", weapon._item.name)
        })
        return
    end
    local weaponMetadata = slotWithItem.metadata or slotWithItem.info
    if weaponMetadata then
        local getWeaponConfigData = Config.Weapons[weapon.name]
        if not getWeaponConfigData then
            cb({ error = _t("game.unknown_error", "not getWeaponConfigData") })
            return
        end
        local usedAttachmentType = attachment.type
        if Config.InventoryType == "ox_inventory" then
            if not weaponMetadata.components then
                weaponMetadata.components = {}
            end
            for _, component in pairs(weaponMetadata.components or {}) do
                for _, configComponent in pairs(getWeaponConfigData.components) do
                    if component == configComponent.item then
                        if configComponent.type == usedAttachmentType then
                            cb({ error = _t("game.component_already_attached") })
                            return
                        end
                    end
                end
            end
            weaponMetadata.components[#weaponMetadata.components + 1] = attachment.name
        elseif Config.InventoryType == "qb-inventory" then
            if not weaponMetadata.attachments then
                weaponMetadata.attachments = {}
            end
            for _, vComponent in pairs(weaponMetadata.attachments or {}) do
                for _, configComponent in pairs(getWeaponConfigData.components) do
                    if vComponent.component == GetHashKey(configComponent.hash) then
                        if configComponent.type == usedAttachmentType then
                            cb({ error = _t("game.component_already_attached") })
                            return
                        end
                    end
                end
            end
            weaponMetadata.attachments[#weaponMetadata.attachments + 1] = {
                component = GetHashKey(attachment.hash)
            }
        elseif Config.InventoryType == "custom" then
            local _customInvNewMetadata = Koci.Utils.CustomInventory:SetWeaponMetadataForComponents(
                attachment,
                weaponMetadata,
                getWeaponConfigData
            )
            if not _customInvNewMetadata then
                cb({ error = _t("You failed to attach the component.") })
                return
            end
            weaponMetadata = _customInvNewMetadata
        end
        Koci.Server:SetItemMetaData(src, slotWithItem.slot, weaponMetadata)
        Koci.Server:RemoveItem(src, attachment.name, 1)
        cb({ status = true, newMetadata = weaponMetadata })
        return
    end
    cb({
        status = false,
        error = _t("game.no_metadata_weapon")
    })
end)

Koci.Server:RegisterServerCallback("craft:server:RemoveAttachmentData", function(source, data, cb)
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({ error = _t("game.unknown_player") })
        return
    end
    local weapon = data.weapon
    local attachment = data.attachment
    local slotWithItem = Koci.Server:GetInventorySlotWithItem(src, weapon._item.name, weapon._item.metadata, true)
    if not slotWithItem then
        cb({
            status = false,
            error = _t("game.dont_have_item", weapon._item.name)
        })
        return
    end
    local weaponMetadata = slotWithItem.metadata or slotWithItem.info
    if weaponMetadata then
        if Config.FrameWork == "esx" then
            if weaponMetadata.components then
                local newWeaponMetaDataComponents = {}
                for i = 1, #weaponMetadata.components do
                    if weaponMetadata.components[i] ~= attachment.name then
                        newWeaponMetaDataComponents[#newWeaponMetaDataComponents + 1] = weaponMetadata.components[i]
                    end
                end
                weaponMetadata.components = newWeaponMetaDataComponents
            else
                cb({
                    status = false,
                    error = _t("no, weaponMetadata.components:callbacks:105")
                })
                return
            end
        elseif Config.FrameWork == "qb" then
            if weaponMetadata.attachments then
                local newWeaponMetaDataComponents = {}
                for i = 1, #weaponMetadata.attachments do
                    if weaponMetadata.attachments[i].component ~= GetHashKey(attachment.hash) then
                        newWeaponMetaDataComponents[#newWeaponMetaDataComponents + 1] = weaponMetadata.attachments[i]
                            .component
                    end
                end
                weaponMetadata.attachments = newWeaponMetaDataComponents
            else
                cb({
                    status = false,
                    error = _t("no, weaponMetadata.attachments:callbacks:130")
                })
                return
            end
        end
        Koci.Server:SetItemMetaData(src, slotWithItem.slot, weaponMetadata)
        Koci.Server:AddItem(src, attachment.name, 1)
        cb({ status = true, newMetadata = weaponMetadata })
    else
        cb({
            status = false,
            error = _t("game.no_metadata_weapon")
        })
    end
end)

Koci.Server:RegisterServerCallback("craft:server:GetPlayerOwnedItemsByIngredients", function(source, data, cb)
    local item = data.item
    local craftableItems = data.craftableItems
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({ ownedItems = {}, canItBeCraftable = false })
        return
    end
    local ownedItems = {}
    local canItBeCraftable = true
    local _index = 1
    local prefix = "weapon_"
    local ingredients = craftableItems[item.name].ingredients
    if not ingredients then
        cb({
            ingredients = {},
            canItBeCraftable = false
        })
        return
    end
    for _item, need in pairs(ingredients) do
        local itemLabel = _item
        if tostring(itemLabel):lower():sub(1, #prefix) == prefix then
            itemLabel = tostring(itemLabel):lower():sub(#prefix + 1)
        else
            itemLabel = tostring(_item):lower():gsub("_", " ")
        end
        local count = 0
        if need < 1 then
            canItBeCraftable = false
            local slotData = Koci.Server:GetInventorySlotWithItem(src, _item)
            if slotData then
                local itemMetaData = slotData.metadata or slotData.info
                if itemMetaData then
                    local _durability = itemMetaData.durability or itemMetaData.quality
                    count = tonumber(string.format("%.1f", _durability)) or 0
                    if count and count > need and not canItBeCraftable then
                        canItBeCraftable = true
                    end
                end
            end
        else
            count = Koci.Server:GetItemCount(src, _item)
            if count and count < need and canItBeCraftable then
                canItBeCraftable = false
            end
        end
        ownedItems[#ownedItems + 1] = {
            index = _index,
            name = _item,
            label = itemLabel,
            need = need,
            count = count,
        }
        _index = _index + 1
    end
    cb({
        ingredients = ownedItems,
        canItBeCraftable = canItBeCraftable
    })
end)

Koci.Server:RegisterServerCallback("craft:server:AddSelectedItemToCraftingQueue", function(source, data, cb)
    local item = data.item
    local craftableItems = data.craftableItems
    local craftableItem = data.craftableItems[item.name]
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({ error = _t("game.unknown_player") })
        return
    end
    local response, isMoneyEnough = Koci.Server.Craft:CanItemBeCraftable(xPlayer, item, craftableItem)
    if not response then
        cb({ error = _t("game.donot_have_enough_items") })
        return
    end
    if not isMoneyEnough then
        cb({ error = _t("game.donot_have_enough_money") })
        return
    end
    local removed = Koci.Server.Craft:RemoveCraftableItemsFromInv(src, item, craftableItem)
    if not removed then
        cb({ error = _t("game.items_couldnot_be_removed") })
        return
    end
    local _index = Koci.Server.Craft:InsertQueueToDB(xPlayer, item, (response and isMoneyEnough))
    if not _index then
        cb({
            error = _t("game.error_InsertQueueToDB")
        })
        return
    end
    cb({ error = false, index = _index })
end)

Koci.Server:RegisterServerCallback("craft:server:GetPlayerQueueDB", function(source, item, cb)
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({})
        return
    end
    local _query = "SELECT * FROM `crafting_queue` WHERE user = ?"
    local playerIdentifier = Koci.Server:GetPlayerIdentity(xPlayer)
    local playerQueues = Koci.Server:ExecuteSQLQuery(_query, { playerIdentifier }, "query")
    local queues = {}
    for j = 1, #playerQueues do
        local queue = playerQueues[j]
        local tableIndex = #queues + 1
        queues[tableIndex] = {
            index = tableIndex,
            db_index = queue.id,
            name = queue.name,
            label = queue.label,
            count = queue.count,
            duration = queue.duration,
            image = queue.image,
            ingredients = json.decode(queue.ingredients),
            propModel = queue.propModel,
            price = queue.price,
            canItBeCraftable = queue.canItBeCraftable,
            remaining = 0
        }
    end
    cb(queues)
end)

Koci.Server:RegisterServerCallback("craft:server:ItemPickUpFromQueue", function(source, queue, cb)
    local src = source
    local xPlayer = Koci.Server:GetPlayerBySource(src)
    if not xPlayer then
        cb({ error = _t("game.unknown_player") })
        return
    end
    local queue = queue
    Koci.Server:AddItem(src, queue.name, queue.count)
    local _query = "DELETE FROM `crafting_queue` WHERE id = ?"
    Koci.Server:ExecuteSQLQuery(_query, { queue.db_index }, "query")
    cb({
        error = false
    })
end)
