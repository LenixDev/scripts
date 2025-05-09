
if Config.type == "ESX" then
ESX = exports['es_extended']:getSharedObject()
elseif Config.type == "QBCORE" then
QBCore = exports['qb-core']:GetCoreObject()
end
local resourceismi = tostring(GetCurrentResourceName())




setplayerclothing = function(hangieleman ,data)

    local savebilgi = SaveResourceFile(resourceismi,  "playerclothing/"..hangieleman..".json", data, -1)
    return savebilgi
end

getplayerclothing = function(hangieleman)
    
    local loadbilgi = LoadResourceFile(resourceismi, "playerclothing/"..hangieleman..".json")
    if loadbilgi then return loadbilgi else return "[]" end
end


setplayerwardrobe = function(hangieleman ,data)

    local savebilgi = SaveResourceFile(resourceismi,  "playerwardrobe/"..hangieleman..".json", data, -1)
    return savebilgi
end

getplayerwardrobe = function(hangieleman)
    
    local loadbilgi = LoadResourceFile(resourceismi, "playerwardrobe/"..hangieleman..".json")
    if loadbilgi then return loadbilgi else return "[]" end
end


RegisterServerEvent('ex_clothingstore:pay:server')
AddEventHandler('ex_clothingstore:pay:server', function(order,total,which)
    local src = source
    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local cash = xPlayer.getAccount('money').money
        local bank = xPlayer.getAccount('bank').money

        if which == "bank" then
       

            if tonumber(bank) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)
                xPlayer.removeAccountMoney('bank', tonumber(total))
                
            else
              
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Bank", 3000)
            end


        elseif which == "cash" then
            if tonumber(cash) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)

                xPlayer.removeMoney(tonumber(total))
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Wallet", 3000)

            end
            
        end
    elseif Config.type == "QBCORE" then

        local Player = QBCore.Functions.GetPlayer(src)
        local cash = tonumber(Player.Functions.GetMoney('cash'))
        local bank = tonumber(Player.Functions.GetMoney('bank'))

        if which == "bank" then
       

            if tonumber(bank) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)
                Player.Functions.RemoveMoney('bank', tonumber(total), 'clothingbuy')
                
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Bank", 3000)
            end


        elseif which == "cash" then
            if tonumber(cash) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)

                Player.Functions.RemoveMoney('cash', tonumber(total), 'clothingbuy')
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Wallet", 3000)
            end
            
        end
    end


end)


function getserverskins(skinlist)
    local skinbeya = {}
    for k,v in pairs(skinlist) do
      
        local skinzero = v.itemvaluename:gsub('%_1', '')
        local text1 = tostring(skinzero.."_1")
        local text2 = tostring(skinzero.."_2")

        skinbeya[text1] = v.itemvalue
        skinbeya[text2] = v.texture

    end

    return skinbeya
end


RegisterServerEvent('ex_clothingstore:paywithsave:server')
AddEventHandler('ex_clothingstore:paywithsave:server', function(order,total,which, savingwardrobe)
    local src = source
    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local cash = xPlayer.getAccount('money').money
        local bank = xPlayer.getAccount('bank').money
        local playerwardrobe = json.decode(getplayerwardrobe(xPlayer.identifier))

        if which == "bank" then
       

            if tonumber(bank) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)
                xPlayer.removeAccountMoney('bank', tonumber(total))
                local newwardrobe = {}
                local getskins = getserverskins(order)
             
                newwardrobe.name = savingwardrobe
                newwardrobe.skin = getskins
                table.insert( playerwardrobe, newwardrobe )
                setplayerwardrobe(xPlayer.identifier, json.encode(playerwardrobe))
                
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Bank", 3000)
             
            end


        elseif which == "cash" then
            if tonumber(cash) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)

                xPlayer.removeMoney(tonumber(total))

                local newwardrobe = {}
                local getskins = getserverskins(order)
             
                newwardrobe.name = savingwardrobe
                newwardrobe.skin = getskins
                table.insert( playerwardrobe, newwardrobe )
                setplayerwardrobe(xPlayer.identifier, json.encode(playerwardrobe))
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Wallet", 3000)
            end
            
        end
    elseif Config.type == "QBCORE" then

        local Player = QBCore.Functions.GetPlayer(src)
        local cash = tonumber(Player.Functions.GetMoney('cash'))
        local bank = tonumber(Player.Functions.GetMoney('bank'))
        local playerwardrobe = json.decode(getplayerwardrobe(Player.PlayerData.citizenid))

        if which == "bank" then
       

            if tonumber(bank) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)
                Player.Functions.RemoveMoney('bank', tonumber(total), 'clothingbuy')
                local newwardrobe = {}
                local getskins = getserverskins(order)
             
                newwardrobe.name = savingwardrobe
                newwardrobe.skin = getskins
                table.insert( playerwardrobe, newwardrobe )
                setplayerwardrobe(xPlayer.identifier, json.encode(playerwardrobe))
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Bank", 3000)
            end


        elseif which == "cash" then
            if tonumber(cash) >= tonumber(total) then
                TriggerClientEvent('ex_clothingstore:confirmbuy',src, order)

                Player.Functions.RemoveMoney('cash', tonumber(total), 'clothingbuy')

                local newwardrobe = {}
                local getskins = getserverskins(order)
             
                newwardrobe.name = savingwardrobe
                newwardrobe.skin = getskins
                table.insert( playerwardrobe, newwardrobe )
                setplayerwardrobe(xPlayer.identifier, json.encode(playerwardrobe))
            else
                TriggerClientEvent('ex_clothingstore:notify', src, "You Dont Have Money In Your Wallet", 3000)
            end
            
        end
    end


end)




RegisterServerEvent('ex_clothingstore:getinfos')
AddEventHandler('ex_clothingstore:getinfos', function()
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerclothing = json.decode(getplayerclothing(xPlayer.identifier))

        TriggerClientEvent('ex_clothingstore:setclothe', src, playerclothing)
        
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local playerclothing = json.decode(getplayerclothing(Player.PlayerData.citizenid))

        TriggerClientEvent('ex_clothingstore:setclothe', src, playerclothing)
    end
end)



RegisterServerEvent('ex_clothingstore:saveown')
AddEventHandler('ex_clothingstore:saveown', function(skin)
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        setplayerclothing(xPlayer.identifier, json.encode(skin))
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        setplayerclothing(Player.PlayerData.citizenid, json.encode(skin))
    end
end)


RegisterServerEvent('ex_clothingstore:saveownqb')
AddEventHandler('ex_clothingstore:saveownqb', function(skin)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    gofuckthisqbp(json.decode(result[1].skin),result[1].model,skin, Player)
 
   
end)


RegisterServerEvent('ex_clothingstore:saveownesx')
AddEventHandler('ex_clothingstore:saveownesx', function(skin, esxskin)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    gofuckthisesx(esxskin,skin, xPlayer)
 
   
end)



function gofuckthisesx(esxskin, skin , xPlayer)
    for k,v in pairs(skin) do
        esxskin[k] = v
    end


    MySQL.update('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(esxskin),
		['@identifier'] = xPlayer.identifier
	})
    
end

function gofuckthisqbp(qbskin,qbmodel, skin , Player)
   
    for k,v in pairs(skin) do
        if k == "torso_1" then
            qbskin.torso2.item = v
        elseif k == "torso_2" then
            qbskin.torso2.texture = v

        elseif k == "tshirt_1" then
            qbskin["t-shirt"].item = v
        
        elseif k == "tshirt_2" then
            qbskin["t-shirt"].texture = v
        elseif k == "pants_1" then
            qbskin.pants.item = v
        elseif k == "pants_2" then
            qbskin.pants.texture = v

        elseif k == "shoes_1" then
            qbskin.shoes.item = v
        elseif k == "shoes_2" then
            qbskin.shoes.texture = v

        elseif k == "mask_1" then
            qbskin.mask.item = v

        elseif k == "mask_2" then
            qbskin.mask.texture = v

        elseif k == "bags_1" then
            qbskin.bag.item = v

        elseif k == "bags_2" then
            qbskin.bag.texture = v

        elseif k == "helmet_1" then
            qbskin.hat.item = v

        elseif k == "helmet_2" then
            qbskin.hat.texture = v

        elseif k == "glasses_1" then
            qbskin.glass.item = v

        elseif k == "glasses_2" then
            qbskin.glass.texture = v

        elseif k == "arms" then
            qbskin.arms.item = v

        elseif k == "arms_2" then
            qbskin.arms.texture = v

        elseif k == "vest_1" then

            qbskin.vest.item = v

        elseif k == "vest_2" then

            qbskin.vest.texture = v

        elseif k == "bracelets_1" then
            qbskin.bracelet.item = v

        elseif k == "bracelets_2" then

            qbskin.bracelet.texture = v

        elseif k == "chain_1" then
            qbskin.accessory.item = v
        elseif k == "chain_2" then
            qbskin.accessory.texture = v

        elseif k == "watches_1" then
            qbskin.watch.item = v

        elseif k == "watches_2" then
            qbskin.watch.texture = v

        end

    end


    MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid }, function()
        MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
            Player.PlayerData.citizenid,
            qbmodel,
            json.encode(qbskin),
            1
        })
    end)
    
end



RegisterServerEvent('ex_clothingstore:wardrobeinfo')
AddEventHandler('ex_clothingstore:wardrobeinfo', function()
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerwardrobe = json.decode(getplayerwardrobe(xPlayer.identifier))
        TriggerClientEvent('ex_clothingstore:openwardrobenui', src,playerwardrobe)
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local playerwardrobe = json.decode(getplayerwardrobe(Player.PlayerData.citizenid))

        TriggerClientEvent('ex_clothingstore:openwardrobenui', src,playerwardrobe)

    end
end)


RegisterServerEvent('ex_clothingstore:useward')
AddEventHandler('ex_clothingstore:useward', function(data)
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerwardrobe = json.decode(getplayerwardrobe(xPlayer.identifier))
        for i=1,#playerwardrobe do
            if i == data then
                TriggerClientEvent('ex_clothingstore:useward:client', src ,playerwardrobe[i])
                break
            end
        end
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local playerwardrobe = json.decode(getplayerwardrobe(Player.PlayerData.citizenid))

        for i=1,#playerwardrobe do
            if i == data then
                TriggerClientEvent('ex_clothingstore:useward:client', src ,playerwardrobe[i])
                break
            end
        end

    end
end)


RegisterServerEvent('ex_clothingstore:deleteward')
AddEventHandler('ex_clothingstore:deleteward', function(data)
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerwardrobe = json.decode(getplayerwardrobe(xPlayer.identifier))
        for i=1,#playerwardrobe do
            if i == data then
                table.remove( playerwardrobe, i )
                setplayerwardrobe(xPlayer.identifier, json.encode(playerwardrobe))
                TriggerClientEvent('ex_clothingstore:sendnewwardrobe',src, playerwardrobe)
                break
            end
        end
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local playerwardrobe = json.decode(getplayerwardrobe(Player.PlayerData.citizenid))

        for i=1,#playerwardrobe do
            if i == data then
                table.remove( playerwardrobe, i )
                setplayerwardrobe(Player.PlayerData.citizenid, json.encode(playerwardrobe))
                TriggerClientEvent('ex_clothingstore:sendnewwardrobe',src, playerwardrobe)
                break
            end
        end

    end
end)






