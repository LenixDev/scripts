RegisterNUICallback("nui:hideFrame", function(_, cb)
    Koci.Client.Craft.isTheShopOpen = false
    Koci.Client.Craft.openedShop = nil
    Koci.Client.Craft:DestroyCam()
    Koci.Client.Craft:DeleteWeaponObjects()
    Koci.Client.Craft:DeleteCraftableItemObjects()
    SetNuiFocus(false, false)
    SetEntityVisible(PlayerPedId(), true)
    DisplayRadar(true)
    Koci.Utils:OpenHud()
    cb(true)
end)

RegisterNUICallback("nui:loadLocaleFile", function(_, cb)
    Wait(1)
    Koci.Client:SendReactMessage("ui:setLocale", locales.ui)
    cb(true)
end)

RegisterNUICallback("nui:ChangedActivePage", function(page, cb)
    if page == "crafting" then
        Koci.Client.Craft:DeleteWeaponObjects()
    elseif page == "personal" then
        Koci.Client.Craft:DeleteCraftableItemObjects()
    end
    cb(true)
end)

RegisterNUICallback("nui:GetPlayerOwnedAttachmentsByWeapon", function(nui_data, cb)
    Koci.Client:TriggerServerCallback("craft:server:GetPlayerInventory", nil, function(data)
        local inventory = data.inventory
        local attachments = Koci.Client.Craft:GetPlayerOwnedAttachmentsByWeapon(nui_data.weapon, inventory)
        cb(attachments)
    end)
end)

RegisterNUICallback("nui:LoadSelectedWeaponOnMiddle", function(data, cb)
    local weapon = data.weapon
    if weapon then
        local _object = Koci.Client.Craft:LoadWeaponOnTable(weapon)
        cb(_object)
        return
    end
    cb(false)
end)

RegisterNUICallback("nui:LoadSelectedCraftableOnMiddle", function(data, cb)
    local item = data.item
    if item then
        local _object = Koci.Client.Craft:LoadPropOnTable(item)
        cb(_object)
        return
    end
    cb(false)
end)

RegisterNUICallback("nui:UpdateSelectedWeaponRotation", function(data, cb)
    local weapon = Koci.Client.Craft.createdWeaponObjectOnTable
    if weapon then
        local selectedWeapon = Koci.Client.Craft.selectedWeapon
        local _oldRot = GetEntityRotation(weapon)
        SetEntityRotation(weapon,
            _oldRot.x,
            _oldRot.y + data.y,
            _oldRot.z + data.x
        )
        Koci.Client.Craft:LoadAttachmentBoxes(selectedWeapon)
        cb(true)
        return
    end
    cb(false)
end)

RegisterNUICallback("nui:UpdateSelectedCraftableItemRotation", function(data, cb)
    local item = Koci.Client.Craft.createdItemObjectOnTable
    if item then
        local _oldRot = GetEntityRotation(item)
        SetEntityRotation(item,
            _oldRot.x,
            _oldRot.y + data.y,
            _oldRot.z + data.x
        )
        cb(true)
        return
    end
    cb(false)
end)

RegisterNUICallback("nui:AddAttachmentToSelectedWeapon", function(data, cb)
    local _selectedItem = data.weapon
    local _newAttachment = data.attachment
    Koci.Client.Craft:AddAttachmentToWeapon(_selectedItem, _newAttachment, cb)
end)

RegisterNUICallback("nui:RemoveAttachmentToSelectedWeapon", function(data, cb)
    local _selectedItem = data.weapon
    local _attachment = data.attachment
    Koci.Client.Craft:RemoveAttachmentToWeapon(_selectedItem, _attachment, cb)
end)

RegisterNUICallback("nui:GetPlayerOwnedItemsByIngredients", function(nui_data, cb)
    Koci.Client:TriggerServerCallback("craft:server:GetPlayerOwnedItemsByIngredients", {
        item = nui_data.item,
        craftableItems = Koci.Client.Craft.openedShop.craftableItems
    }, function(data)
        local ingredients = data.ingredients
        local canItBeCraftable = data.canItBeCraftable
        cb({
            ingredients = ingredients,
            canItBeCraftable = canItBeCraftable
        })
    end)
end)

RegisterNUICallback("nui:AddSelectedItemToCraftingQueue", function(nui_data, cb)
    Koci.Client:TriggerServerCallback("craft:server:AddSelectedItemToCraftingQueue", {
        item = nui_data.item,
        craftableItems = Koci.Client.Craft.openedShop.craftableItems
    }, function(data)
        local response = data
        if response.error then
            Koci.Client:SendNotify(response.error, "error")
            cb(false)
            return
        end
        local tableIndex = #Koci.Client.Craft.CraftingQueues + 1
        Koci.Client.Craft.CraftingQueues[tableIndex] = nui_data.item
        Koci.Client.Craft.CraftingQueues[tableIndex].index = tableIndex
        Koci.Client.Craft.CraftingQueues[tableIndex].db_index = response.index
        Koci.Client.Craft:StartQueueThread()
        cb(true)
    end)
end)

RegisterNUICallback("nui:ItemPickUpFromQueue", function(nui_data, cb)
    local queue = nui_data.queue
    Koci.Client:TriggerServerCallback("craft:server:ItemPickUpFromQueue", queue, function(data)
        local response = data
        if response.error then
            Koci.Client:SendNotify(response.error, "error")
            cb(false)
            return
        end
        Koci.Client.Craft:RemoveQueueToTable(queue)
        Koci.Client:SendNotify(_t("game.pick_up_item"), "success")
        cb(true)
    end)
end)
