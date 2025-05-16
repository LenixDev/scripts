function Koci.Server:RegisterServerCallback(key, func)
    Koci.Callbacks[key] = func
end

function Koci.Server:TriggerCallback(key, source, payload, cb)
    if not cb then
        cb = function() end
    end
    if Koci.Callbacks[key] then
        Koci.Callbacks[key](source, payload, cb)
    end
end

function deepCompare(t1, t2)
    if t1 == t2 then return true end
    if type(t1) ~= "table" or type(t2) ~= "table" then return false end

    for key, value in pairs(t1) do
        if type(t2[key]) ~= type(value) or not deepCompare(value, t2[key]) then
            return false
        end
    end

    for key in pairs(t2) do
        if t1[key] == nil then return false end
    end

    return true
end

--- Function that executes database queries
---
--- @param query: The SQL query to execute
--- @param params: Parameters for the SQL query (in table form)
--- @param type ("insert" | "update" | "query" | "scalar" | "single" | "prepare"): Parameters for the SQL query (in table form)
--- @return query any Results of the SQL query
function Koci.Server:ExecuteSQLQuery(query, params, type)
    if type == "insert" then
        return MySQL.insert.await(query, params)
    elseif type == "update" then
        return MySQL.update.await(query, params)
    elseif type == "query" then
        return MySQL.query.await(query, params)
    elseif type == "scalar" then
        return MySQL.scalar.await(query, params)
    elseif type == "single" then
        return MySQL.single.await(query, params)
    elseif type == "prepare" then
        return MySQL.prepare.await(query, params)
    else
        error("Invalid queryType: " .. tostring(type or "?"))
    end
end

---@param system ("esx_notify" | "qb_notify" | "custom_notify") System to be used
---@param source number Player source id
---@param type string inform / success / error
---@param title string Notification text
---@param text? string (optional) description, custom notify.
---@param duration? number (optional) Duration in miliseconds, custom notify.
---@param icon? string (optional) icon.
function Koci.Server:SendNotify(source, type, title, text, duration, icon)
    system = Config.NotifyType
    if not duration then duration = 1000 end
    if system == "qb_notify" then
        if Config.FrameWork == "qb" then
            TriggerClientEvent("QBCore:Notify", source, title, type)
        else
            Utils.Functions:debugPrint("error", "QB not found.")
        end
    elseif system == "esx_notify" then
        if Config.FrameWork == "esx" then
            TriggerClientEvent("esx:showNotification", source, title, type, duration)
        else
            Utils.Functions:debugPrint("error", "ESX not found.")
        end
    elseif system == "custom_notify" then
        Utils.Functions:CustomNotify(source, title, type, text, duration, icon)
    else
        Utils.Functions:debugPrint("error", "An error occurred.")
    end
end

--- Gets a player by their source ID, based on the configured framework.
--- @param source number The source ID of the player.
--- @return table|nil Player The player data if found, or nil if not found.
function Koci.Server:GetPlayerBySource(source)
    if Config.FrameWork == "esx" then
        return Koci.Framework.GetPlayerFromId(source)
    elseif Config.FrameWork == "qb" then
        return Koci.Framework.Functions.GetPlayer(source)
    end
end

function Koci.Server:GetPlayerSource(xPlayer)
    if xPlayer then
        return Config.FrameWork == "esx" and xPlayer.source or xPlayer.PlayerData.source
    else
        return nil
    end
end

function Koci.Server:GetPlayerIdentity(xPlayer)
    return Config.FrameWork == "esx" and
        xPlayer.identifier
        or
        xPlayer.PlayerData.citizenid
end

function Koci.Server:GetPlayerInventory(xPlayer)
    local playerSource = self:GetPlayerSource(xPlayer)
    if Config.InventoryType == "ox_inventory" and Koci.Utils:hasResource(Config.InventoryType) then
        return exports.ox_inventory:GetInventoryItems(playerSource)
    else
        if Config.FrameWork == "esx" then
            return xPlayer.inventory
        elseif Config.FrameWork == "qb" then
            return xPlayer.PlayerData.items
        end
    end
end

--- Gets the balance of a specific account type for a player, based on the configured framework.
--- @param type string The type of account for which the balance is requested.
--- @param Player table The player data.
--- @return number balance The account balance.
function Koci.Server:GetPlayerBalance(type, Player)
    if Config.FrameWork == "esx" then
        type = type == "cash" and "money" or type
        return tonumber(Player.getAccount(type).money)
    elseif Config.FrameWork == "qb" then
        return tonumber(Player.PlayerData.money[type])
    end
end

function Koci.Server:HasItem(source, itemName, count, metadata, strict)
    if Config.InventoryType == "ox_inventory" then
        local hasItem = exports.ox_inventory:GetItemCount(source, itemName, metadata, strict)
        return hasItem >= count
    elseif Config.InventoryType == "qb-inventory" then
        local hasItem = self:GetItemCount(source, itemName)
        return hasItem >= count
    elseif Config.InventoryType == "custom" then
        local hasItem = Koci.Utils.CustomInventory:GetItemCount(source, itemName, metadata, strict)
        return hasItem >= count
    end
    return false
end

function Koci.Server:GetItemCount(source, itemName, metadata, strict)
    if Config.InventoryType == "ox_inventory" then
        return exports.ox_inventory:GetItemCount(source, itemName, metadata, strict)
    elseif Config.InventoryType == "qb-inventory" then
        local xPlayer = Koci.Server:GetPlayerBySource(source)
        local count = 0
        local _items = xPlayer.Functions.GetItemsByName(itemName)
        for key, value in pairs(_items) do
            count = count + value.amount
        end
        return count
    elseif Config.InventoryType == "custom" then
        return Koci.Utils.CustomInventory:GetItemCount(source, itemName, metadata, strict)
    end
    return false
end

function Koci.Server:GetInventorySlotWithItem(source, itemName, metadata, strict)
    if Config.InventoryType == "ox_inventory" then
        return exports.ox_inventory:GetSlotWithItem(source, itemName)
    elseif Config.InventoryType == "qb-inventory" then
        local xPlayer = Koci.Server:GetPlayerBySource(source)
        if metadata then
            local _items = xPlayer.Functions.GetItemsByName(itemName)
            for _, item in pairs(_items) do
                local match = true
                for key, value in pairs(metadata) do
                    if strict and (item.info[key] == nil or not deepCompare(item.info[key], value)) then
                        match = false
                        break
                    elseif not strict and item.info[key] ~= value then
                        match = false
                        break
                    end
                end
                if match then
                    return item
                end
            end
        else
            return xPlayer.Functions.GetItemByName(itemName)
        end
    elseif Config.InventoryType == "custom" then
        return Koci.Utils.CustomInventory:GetSlotWithItem(source, itemName, metadata, strict)
    end
    return false
end

function Koci.Server:SetItemMetaData(source, slot, metaData)
    if Config.InventoryType == "ox_inventory" then
        return exports.ox_inventory:SetMetadata(source, slot, metaData)
    elseif Config.InventoryType == "qb-inventory" then
        local xPlayer = Koci.Server:GetPlayerBySource(source)
        local item = xPlayer.PlayerData.items[slot]
        item["info"] = metaData
        xPlayer.PlayerData.items[slot] = item
        xPlayer.Functions.SetPlayerData("items", xPlayer.PlayerData.items)
        return true
    elseif Config.InventoryType == "custom" then
        return Koci.Utils.CustomInventory:SetItemMetaData(source, slot, metaData)
    end
    return false
end

function Koci.Server:SetItemDurability(source, slot, durability, itemName)
    if Config.InventoryType == "ox_inventory" then
        return exports.ox_inventory:SetDurability(source, slot, durability)
    elseif Config.InventoryType == "qb-inventory" then
        local item = exports["qb-inventory"]:GetItemBySlot(source, slot)
        local itemMetadata = item.info
        itemMetadata.quality = durability
        return exports["qb-inventory"]:SetItemData(source, itemName, "info", itemMetadata)
    elseif Config.InventoryType == "custom" then
        return Koci.Utils.CustomInventory:SetItemDurability(source, slot, durability, itemName)
    end
    return false
end

function Koci.Server:RemoveItem(source, itemName, count, metadata, slot)
    if Config.InventoryType == "ox_inventory" then
        return exports.ox_inventory:RemoveItem(source, itemName, count, metadata, slot)
    elseif Config.InventoryType == "qb-inventory" then
        local xPlayer = Koci.Server:GetPlayerBySource(source)
        return xPlayer.Functions.RemoveItem(itemName, count)
    elseif Config.InventoryType == "custom" then
        return Koci.Utils.CustomInventory:RemoveItem(source, itemName, count, metadata, slot)
    end
    return false
end

function Koci.Server:AddItem(source, itemName, count, metadata, slot)
    if Config.InventoryType == "ox_inventory" then
        return exports.ox_inventory:AddItem(source, itemName, count, metadata, slot)
    elseif Config.InventoryType == "qb-inventory" then
        local xPlayer = Koci.Server:GetPlayerBySource(source)
        return xPlayer.Functions.AddItem(itemName, count, nil, metadata)
    elseif Config.InventoryType == "custom" then
        return Koci.Utils.CustomInventory:AddItem(source, itemName, count, metadata, slot)
    end
    return false
end

function Koci.Server.Craft:CanItemBeCraftable(xPlayer, item, craftableItem)
    local bankBalance = Koci.Server:GetPlayerBalance("bank", xPlayer)
    local itemPrice = tonumber(item.price) or 0
    local ingredients = craftableItem.ingredients
    if not ingredients then
        return false, bankBalance >= itemPrice
    end
    for _item, need in pairs(ingredients) do
        if need < 1 then
            local slotData = Koci.Server:GetInventorySlotWithItem(source, _item)
            if not slotData then
                return false, false
            end
            local itemMetadata = slotData.metadata or slotData.info
            if not itemMetadata then
                return false, false
            end
            local itemDurability = itemMetadata.durability or itemMetadata.quality or 0
            if itemDurability == 0 or itemDurability < need then
                return false, false
            end
        else
            local count = Koci.Server:GetItemCount(Koci.Server:GetPlayerSource(xPlayer), _item)
            if count and count < need then
                return false, false
            end
        end
    end
    return true, bankBalance >= itemPrice
end

function Koci.Server.Craft:RemoveCraftableItemsFromInv(source, item, craftableItem)
    local ingredients = craftableItem.ingredients
    if not ingredients then
        return false
    end
    local anyError = false
    local prefix = "weapon_"
    for itemName, count in pairs(ingredients) do
        if count < 1 then
            local slotData = Koci.Server:GetInventorySlotWithItem(source, itemName)
            if slotData then
                local itemMetadata = slotData.metadata or slotData.info
                if not itemMetadata then
                    anyError = true
                else
                    local itemDurability = itemMetadata.durability or itemMetadata.quality or 0
                    if itemDurability > 0 then
                        local newDurability = itemDurability - count
                        if newDurability < 0 then
                            newDurability = 0
                        end
                        Koci.Server:SetItemDurability(source, slotData.slot, newDurability, itemName)
                    end
                end
            end
        else
            local success = Koci.Server:RemoveItem(source, itemName, count)
            if not success then
                anyError = true
            end
        end
    end
    if anyError then
        return false
    end
    return true
end

function Koci.Server.Craft:InsertQueueToDB(xPlayer, item, canItBeCraftable)
    if Koci.ResmonLib then
        local _id = Koci.ResmonLib.Craft.InsertQueueToDB(xPlayer, item, canItBeCraftable)
        return _id
    else
        return -1
    end
end
