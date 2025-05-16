Utils = {}
Utils.Functions = {}
Utils.CustomInventory = {}

---@param source number Player server id
---@param itemName string item name
---@param metadata? table|string metadata
---@param strict? boolean strict
---@return number itemCount
function Utils.CustomInventory:GetItemCount(source, itemName, metadata, strict)
    -- local itemCount = exports.["CustomInventory"]:GetItemCount(source, itemName, metadata, strict)
    -- return itemCount
end

function Utils.CustomInventory:GetItem(source, itemName, metadata, returnsCount)
    -- local item = exports.["CustomInventory"]:GetItem(source, itemName, metadata, returnsCount)
    -- return item
end

function Utils.CustomInventory:GetItemCount(source, itemName, metadata, strict)
    -- local item = exports.["CustomInventory"]:GetItemCount(source, itemName, metadata, strict)
    -- return item
end

function Utils.CustomInventory:GetSlotWithItem(source, itemName, metadata, strict)
    -- return exports.["CustomInventory"]:GetSlotWithItem(source, itemName, metadata, strict)
end

function Utils.CustomInventory:SetItemMetaData(source, slot, metaData)
    -- return exports.["CustomInventory"]:SetItemMetaData(source, slot, metaData)
end

function Utils.CustomInventory:RemoveItem(source, itemName, count, metadata, slot)
    -- return exports.["CustomInventory"]:RemoveItem(source, itemName, count, metadata, slot)
end

function Utils.CustomInventory:AddItem(source, itemName, count, metadata, slot)
    -- return exports.["CustomInventory"]:AddItem(source, itemName, count, metadata, slot)
end

function Utils.CustomInventory:SetItemDurability(source, slot, durability, itemName)
    -- return exports.["CustomInventory"]:SetItemDurability(source, slot, durability)
end

--[[
    The "itemMetadata" data gives the current metadata of the item you want to attach the component to
    The "newAttachment" data gives the properties of the component the player wants to attach.
        newAttachment = {item= item name, type= component type, hash= component hash}
    The "componentsForThisWeapon" data gives the data of the components that you are allowed to install. Pulled from the Config.Weapons table
    What you need to do is to learn how the metadata component data of the inventory script you are using is processed and send the metadata to your item in that way.
    If you "return false" you will not allow the player to attach that component to the weapon.
    If all is well, you should return the new metadata.
]]
function Utils.CustomInventory:SetWeaponMetadataForComponents(newAttachment, itemMetadata, componentsForThisWeapon)
    --[[
        The following codes are written to give you an idea. You should edit them according to your own inventory script.
        Here's what you need to do:
        check if the component the player wants to attach -newAttachment- is already attached, save this data in the metadata of the player's item.
        And return the new version of the metadata.
    ]]
    local itemNewMetadata = itemMetadata
    local itemCurrentComponents = itemNewMetadata.components or itemNewMetadata.attachments
    if not itemCurrentComponents then
        itemCurrentComponents = {}
    end
    -- Check if the component is already attached
    for _, attachedComponent in pairs(itemCurrentComponents or {}) do
        -- You have to organize it according to your own inventory !
        local attachedComponentItemName = attachedComponent
        -- You have to organize it according to your own inventory !
        local attachedComponentHash = attachedComponent.component or attachedComponent.hash
        for _, attachableComponent in pairs(componentsForThisWeapon) do
            if attachedComponentItemName == attachableComponent.item
                or
                attachedComponentHash == newAttachment.hash
            then
                if attachableComponent.type == newAttachment.type then
                    return false -- false is returned because the item component is already attached.
                end
            end
        end
    end
    -- You have to organize it according to your own inventory !
    if itemNewMetadata.components then
        itemNewMetadata.components[#itemNewMetadata.components + 1] = newAttachment.name
    elseif itemNewMetadata.attachments then
        itemNewMetadata.attachments[#itemNewMetadata.attachments + 1] = {
            component = newAttachment.hash
        }
    end
    return itemNewMetadata
end

--- Prints the contents of a table with optional indentation.
---
--- @param table (table) The table to be printed.
--- @param indent? (number, optional) The level of indentation for formatting.
function Utils.Functions:printTable(table, indent)
    indent = indent or 0
    if type(table) == "table" then
        for k, v in pairs(table) do
            local tblType = type(v)
            local formatting = ("%s ^3%s:^0"):format(string.rep("  ", indent), k)
            if tblType == "table" then
                print(formatting)
                Utils.Functions:printTable(v, indent + 1)
            elseif tblType == "boolean" then
                print(("%s^1 %s ^0"):format(formatting, v))
            elseif tblType == "function" then
                print(("%s^9 %s ^0"):format(formatting, v))
            elseif tblType == "number" then
                print(("%s^5 %s ^0"):format(formatting, v))
            elseif tblType == "string" then
                print(("%s ^2%s ^0"):format(formatting, v))
            else
                print(("%s^2 %s ^0"):format(formatting, v))
            end
        end
    else
        print(("%s ^0%s"):format(string.rep("  ", indent), table))
    end
end

--- A simple debug print function that is dependent on a convar
--- will output a nice prettfied message if debugMode is on
function Utils.Functions:debugPrint(tbl, indent)
    if not Config.DebugPrint then return end
    print(("\x1b[ %s : DEBUG]\x1b"):format("craft"))
    Utils.Functions:printTable(tbl, indent)
    print("\x1b [ END DEBUG ] \x1b")
end

---@param name string resource name
---@return boolean
function Utils.Functions:hasResource(name)
    return GetResourceState(name):find("start") ~= nil
end

function Utils.Functions:GetResmonLib()
    if self:hasResource("0r_lib") then
        return exports["0r_lib"]:GetCoreObject().Lib
    else
        CreateThread(function()
            Wait(30000)
            --self:printTable("^1!!! The installation could not be done because the 0r_lib could not be found !!!")
        end)
        return false
    end
end

--- Get framework used by the server
--- @return object
function Utils.Functions:GetFramework()
    if Utils.Functions:hasResource("es_extended") then
        Config.FrameWork = "esx"
        return exports["es_extended"]:getSharedObject()
    elseif Utils.Functions:hasResource("qb-core") then
        Config.FrameWork = "qb"
        return exports["qb-core"]:GetCoreObject()
    else
        self:printTable("!!! The installation could not be done because the framework could not be found !!!")
        return nil
    end
end

---@param model number | string
function Utils.Functions:LoadModel(model)
    if HasModelLoaded(model) then
        return
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

---@param model number | string
function Utils.Functions:LoadWeaponAsset(model)
    local modelHash = GetHashKey(model)
    if HasWeaponAssetLoaded(modelHash) then
        return
    end
    RequestWeaponAsset(modelHash, 31, 0)
    while not HasWeaponAssetLoaded(modelHash) do Wait(10) end
end

-- Draws 3D text at the specified world coordinates.
---@param x (number) The X-coordinate of the text in the world.
---@param y (number) The Y-coordinate of the text in the world.
---@param z (number) The Z-coordinate of the text in the world.
---@param text (string) The text to be displayed.
function Utils.Functions:DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 70, 134, 123, 75)
    ClearDrawOrigin()
end

---@param source number | nil Player server id or nil, if value is nil, Trigger client event.
---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
function Utils.Functions:CustomNotify(source, title, type, text, duration, icon)
    if source and source > 0 then -- Server Notify
        -- TriggerClientEvent("EventName", source, ?, ?, ?, ?)
    else                          -- Client Notify
        -- exports["ExportName"]:Alert(?, ?, ?, ?)
    end
end
