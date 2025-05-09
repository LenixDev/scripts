local QBCore = exports[Config.Core]:GetCoreObject()

CreateThread(function()
    local blip = AddBlipForCoord(Config.Blips.coords)
    SetBlipSprite(blip, Config.Blips.sprite)
    SetBlipDisplay(blip, Config.Blips.display)
    SetBlipScale(blip, Config.Blips.scale)
    SetBlipColour(blip, Config.Blips.color)
    SetBlipAsShortRange(blip, Config.Blips.short)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blips.name)
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    local pedModel = GetHashKey(Config.Ped.model)
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end
    local ped = CreatePed(4, pedModel, Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z, Config.Ped.coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports[Config.Target.type]:AddTargetEntity(ped, {
        options = {
            {
                type = "client",
                event = "pawnshop:openMenu",
                icon = "fas fa-box",
                label = Config.Text[Config.Language].OpenPawnShop
            },
            {
                type = "client",
                event = "pawnshop:openBossMenu",
                icon = "fas fa-user-tie",
                label = Config.Text[Config.Language].OpenBossMenu,
                job = Config.Job
            }
        },
        distance = Config.Ped.interactDist
    })
end)

RegisterNetEvent('pawnshop:openMenu', function()
    local options = {
        {
            title = Config.Text[Config.Language].SellItem,
            description = "Sell your item to the Pawn Shop",
            event = "pawnshop:sellItem"
        },
        {
            title = Config.Text[Config.Language].BuyItem,
            description = "Buy an item from the Pawn Shop",
            event = "pawnshop:openBuyMenu"
        },
        {
            title = Config.Text[Config.Language].ClaimMoney,
            description = "Claim your pending money",
            event = "pawnshop:claimMoney"
        },
        {
            title = Config.Text[Config.Language].Exit,
            description = "Exit the Pawn Shop",
            event = "pawnshop:exitMenu"
        }
    }
    lib.registerContext({
        id = 'pawnshop_menu',
        title = 'Pawn Shop',
        options = options
    })
    lib.showContext('pawnshop_menu')
end)

RegisterNetEvent('pawnshop:openBossMenu', function()
    TriggerServerEvent(Config.BossMenuEvent)
end)

RegisterNetEvent('pawnshop:openBuyMenu', function()
    TriggerServerEvent('pawnshop:server:fetchItemsForSale')
end)

RegisterNetEvent('pawnshop:claimMoney', function()
    TriggerServerEvent('pawnshop:server:fetchPendingPayments')
end)

RegisterNetEvent('pawnshop:client:displayPendingPayments', function(pendingPayments)
    local options = {}
    local totalAmount = 0
    if #pendingPayments == 0 then
        QBCore.Functions.Notify(Config.Text[Config.Language].NoPendingPayments, "error")
        return
    end
    for _, payment in pairs(pendingPayments) do
        local paymentAfterTax = payment.amount - (payment.amount * Config.TaxSystem)
        totalAmount = totalAmount + paymentAfterTax
        table.insert(options, {
            title = payment.item_name .. " - $" .. paymentAfterTax,
            description = Config.Text[Config.Language].Claim .. " $" .. paymentAfterTax .. " " .. Config.Text[Config.Language].For .. " " .. payment.item_name,
            event = "pawnshop:client:claimSinglePayment",
            args = { paymentId = payment.id, amount = paymentAfterTax }
        })
    end
    table.insert(options, {
        title = Config.Text[Config.Language].ClaimAll .. " ($" .. totalAmount .. ")",
        description = Config.Text[Config.Language].ClaimAllMoneyAfterTax,
        event = "pawnshop:client:claimAllPayments",
        args = { totalAmount = totalAmount }
    })
    lib.registerContext({
        id = 'pawnshop_claim_menu',
        title = Config.Text[Config.Language].ClaimPendingMoney,
        options = options
    })
    lib.showContext('pawnshop_claim_menu')
end)

RegisterNetEvent('pawnshop:client:claimSinglePayment', function(data)
    TriggerServerEvent('pawnshop:server:claimPayment', data.paymentId, data.amount)
end)

RegisterNetEvent('pawnshop:client:claimAllPayments', function(data)
    TriggerServerEvent('pawnshop:server:claimAllPayments', data.totalAmount)
end)

RegisterNetEvent('pawnshop:sellItem', function()
    TriggerEvent('pawnshop:client:sellItem') 
end)

RegisterNetEvent('pawnshop:buyItem', function()
    TriggerEvent('pawnshop:client:buyItem')
end)

RegisterNetEvent('pawnshop:exitMenu', function()
end)

RegisterNetEvent('pawnshop:client:sellItem', function()
    local inventory = QBCore.Functions.GetPlayerData().items
    if inventory == nil or next(inventory) == nil then
        QBCore.Functions.Notify(Config.Text[Config.Language].NoItemsToSell, "error")
        return
    end
    local items = {}
    for _, item in pairs(inventory) do
        if item.amount > 0 then
            local itemImage = string.format(Config.inventoryImage, item.name .. ".png")
            table.insert(items, {
                title = item.label,
                description = Config.Text[Config.Language].Amount .. ": " .. item.amount,
                image = itemImage,
                event = 'pawnshop:client:sellSelectedItem',
                args = { itemName = item.name, amount = item.amount }
            })
        end
    end
    lib.registerContext({
        id = 'pawnshop_sell_menu',
        title = Config.Text[Config.Language].SelectItemToSell,
        options = items
    })
    lib.showContext('pawnshop_sell_menu')
end)

RegisterNetEvent('pawnshop:client:sellSelectedItem', function(data)
    local input = lib.inputDialog(Config.Text[Config.Language].EnterSaleDetails, {
        { type = 'number', label = Config.Text[Config.Language].AmountToSell, default = 1, min = 1, max = data.amount },
        { type = 'number', label = Config.Text[Config.Language].PricePerItem, default = 100 }
    })
    if input then
        local amountToSell = input[1]
        local pricePerItem = input[2]

        TriggerServerEvent('pawnshop:server:sellItem', data.itemName, amountToSell, pricePerItem)

        TriggerServerEvent('pawnshop:server:logAction', QBCore.Functions.GetPlayerData().citizenid, "Attempted to sell " .. amountToSell .. "x " .. data.itemName)
    end
end)

RegisterNetEvent('pawnshop:client:buyItem', function()
    TriggerServerEvent('pawnshop:server:fetchItemsForSale')
end)

RegisterNetEvent('pawnshop:client:displayItemsForSale', function(items)
    if #items == 0 then
        QBCore.Functions.Notify(Config.Text[Config.Language].NoItemsForSale, "error")
        return
    end
    local options = {}
    for _, item in pairs(items) do
        table.insert(options, {
            title = item.item_label,
            description = Config.Text[Config.Language].Price .. ": $" .. item.price .. " | " .. Config.Text[Config.Language].Amount .. ": " .. item.amount,
            image = item.image,
            event = "pawnshop:client:buySelectedItem",
            args = { item = item }
        })
    end
    lib.registerContext({
        id = 'pawnshop_buy_menu',
        title = Config.Text[Config.Language].BuyItemsFromPawnShop,
        options = options
    })
    lib.showContext('pawnshop_buy_menu')
end)

RegisterNetEvent('pawnshop:client:buySelectedItem', function(data)
    local item = data.item
    local confirmed = lib.inputDialog(Config.Text[Config.Language].ConfirmPurchase, {
        { type = 'number', label = Config.Text[Config.Language].HowManyToBuy, min = 1, max = item.amount, default = 1 }
    })
    if confirmed then
        local amountToBuy = confirmed[1]
        TriggerServerEvent('pawnshop:server:buyItem', item.id, amountToBuy)
        TriggerServerEvent('pawnshop:server:logAction', QBCore.Functions.GetPlayerData().citizenid, "Bought " .. amountToBuy .. "x " .. item.item_label)
    end
end)