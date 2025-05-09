local Ox = require '@ox_core/lib/init'
local src = source
local Player = Ox.GetPlayer(src)

local playerPendingMoney = {}

local function addPendingMoney(citizenid, amount)
    if playerPendingMoney[citizenid] == nil then
        playerPendingMoney[citizenid] = 0
    end
    playerPendingMoney[citizenid] = playerPendingMoney[citizenid] + amount
end

RegisterNetEvent('pawnshop:server:claimMoney', function()
    MySQL.Async.fetchAll('SELECT * FROM pawnshop_payments WHERE citizenid = @citizenid', {['@citizenid'] = Player.PlayerData.citizenid}, function(payments)
        if #payments > 0 then
            local totalAmount = 0

            for _, payment in pairs(payments) do
                totalAmount = totalAmount + payment.amount
            end

            local taxAmount = totalAmount * Config.TaxSystem
            local finalAmount = totalAmount - taxAmount

            Player.Functions.AddMoney('cash', finalAmount)

            MySQL.Async.execute('DELETE FROM pawnshop_payments WHERE citizenid = @citizenid', {['@citizenid'] = Player.PlayerData.citizenid})

            TriggerEvent('pawnshop:server:logAction', Player.PlayerData.name, Player.PlayerData.citizenid, "Claimed Money", "N/A", 1, finalAmount)

            TriggerClientEvent('ox_lib:notify', src, {
                type = 'success',
                description = Config.Text[Config.Language].ClaimedMoney .. finalAmount .. " after tax."
            })
        else
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                description = Config.Text[Config.Language].NoPendingPayments
            })
        end
    end)
end)

RegisterNetEvent('pawnshop:server:sellItem', function(itemName, amount, pricePerItem)
    local item = Player.Functions.GetItemByName(itemName)
    if Config.BlacklistItem[itemName] then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = Config.Text[Config.Language].CannotSellItem
        })
        return
    end
    local itemImage = string.format(Config.inventoryImage, itemName .. ".png")
    if not item or item.amount < amount then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = Config.Text[Config.Language].NotEnoughItemsToSell
        })
        return
    end
    Player.Functions.RemoveItem(itemName, amount)
    MySQL.Async.execute('INSERT INTO pawnshop_items (seller_cid, item_name, item_label, amount, price) VALUES (@cid, @name, @label, @amount, @price)', {
        ['@cid'] = Player.PlayerData.citizenid,
        ['@name'] = itemName,
        ['@label'] = item.label,
        ['@amount'] = amount,
        ['@price'] = pricePerItem
    })
    TriggerEvent('pawnshop:server:logAction', Player.PlayerData.name, Player.PlayerData.citizenid, "Listed", itemName, amount, pricePerItem)
    TriggerClientEvent('ox_lib:notify', src, {
        type = 'inform',
        description = Config.Text[Config.Language].ItemListed
    })
end)

RegisterNetEvent('pawnshop:server:buyItem', function(itemId, amount)
    MySQL.Async.fetchAll('SELECT * FROM pawnshop_items WHERE id = @id', {['@id'] = itemId}, function(result)
        if result[1] then
            local item = result[1]
            if item.amount >= amount then
                local totalPrice = amount * item.price
                local taxAmount = totalPrice * Config.TaxSystem
                local finalPrice = totalPrice - taxAmount

                if Player.Functions.RemoveMoney('cash', totalPrice) then
                    Player.Functions.AddItem(item.item_name, amount)

                    local newAmount = item.amount - amount

                    if newAmount > 0 then
                        MySQL.Async.execute('UPDATE pawnshop_items SET amount = @amount WHERE id = @id', {
                            ['@amount'] = newAmount,
                            ['@id'] = itemId
                        })
                    else
                        MySQL.Async.execute('DELETE FROM pawnshop_items WHERE id = @id', {
                            ['@id'] = itemId
                        })
                    end

                    MySQL.Async.execute('INSERT INTO pawnshop_payments (citizenid, item_name, amount) VALUES (@citizenid, @item_name, @amount)', {
                        ['@citizenid'] = item.seller_cid,
                        ['@item_name'] = item.item_name,
                        ['@amount'] = totalPrice
                    })

                    TriggerEvent(Config.BossMenu.taxEvent, Config.BossMenu.account, taxAmount)

                    TriggerEvent('pawnshop:server:logAction', Player.PlayerData.name, Player.PlayerData.citizenid, "Bought", item.item_name, amount, totalPrice)

                    TriggerClientEvent('ox_lib:notify', src, {
                        type = 'inform',
                        description = Config.Text[Config.Language].ItemSold:format(amount, item.item_label .. totalPrice)
                    })
                else
                    TriggerClientEvent('ox_lib:notify', src, {
                        type = 'inform',
                        description = Config.Text[Config.Language].NotEnoughMoney
                    })
                end
            else
                TriggerClientEvent('ox_lib:notify', src, {
                    type = 'error',
                    description = Config.Text[Config.Language].NotEnoughItemsInStock
                })
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                description = Config.Text[Config.Language].ItemNotAvailable
            })
        end
    end)
end)

RegisterNetEvent('pawnshop:server:fetchItemsForSale', function()
    MySQL.Async.fetchAll('SELECT * FROM pawnshop_items', {}, function(result)
        local items = {}
        for _, row in pairs(result) do
            local itemImage = string.format(Config.inventoryImage, row.item_name .. ".png")
            table.insert(items, {
                id = row.id,
                item_name = row.item_name,
                item_label = row.item_label,
                amount = row.amount,
                price = row.price,
                image = itemImage
            })
        end
        TriggerClientEvent('pawnshop:client:displayItemsForSale', src, items)
    end)
end)

RegisterNetEvent('pawnshop:server:fetchPendingPayments', function()
    local citizenid = Player.PlayerData.citizenid
    MySQL.Async.fetchAll('SELECT * FROM pawnshop_payments WHERE citizenid = @citizenid', {
        ['@citizenid'] = citizenid
    }, function(result)
        local pendingPayments = {}

        for _, row in pairs(result) do
            table.insert(pendingPayments, {
                id = row.id,
                item_name = row.item_name,
                amount = row.amount
            })
        end
        TriggerClientEvent('pawnshop:client:displayPendingPayments', src, pendingPayments)
    end)
end)

RegisterNetEvent('pawnshop:server:claimPayment', function(paymentId, amount)
    MySQL.Async.execute('DELETE FROM pawnshop_payments WHERE id = @id', {
        ['@id'] = paymentId
    }, function(rowsChanged)
        if rowsChanged > 0 then
            Player.Functions.AddMoney('cash', amount)
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'success',
                description = Config.Text[Config.Language].Claim .. " $" .. amount .. " " .. Config.Text[Config.Language].successfully
            })
        end
    end)
end)

RegisterNetEvent('pawnshop:server:claimAllPayments', function(totalAmount)
    local citizenid = Player.PlayerData.citizenid
    MySQL.Async.execute('DELETE FROM pawnshop_payments WHERE citizenid = @citizenid', {
        ['@citizenid'] = citizenid
    }, function(rowsChanged)
        if rowsChanged > 0 then
            Player.Functions.AddMoney('cash', totalAmount)
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'success',
                description = Config.Text[Config.Language].Claim .. " $" .. totalAmount .. " " .. Config.Text[Config.Language].successfully
            })
        end
    end)
end)

RegisterNetEvent('pawnshop:server:logAction', function(playerName, citizenid, action, itemName, amount, price)
    if price == nil or amount == nil or action == nil or itemName == nil then
        return
    end
    local webhook = Config.Discord.webhook
    local name = Config.Discord.name
    local image = Config.Discord.image
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        username = name,
        avatar_url = image,
        embeds = {
            {
                color = 3447003,
                title = "Pawn Shop Log",
                description = playerName .. " (ID: " .. citizenid .. ") " .. action .. " " .. amount .. "x " .. itemName .. " " .. Config.Text[Config.Language].For .. " $" .. price,
                footer = {
                    text = os.date('%Y-%m-%d %H:%M:%S'),
                },
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end)