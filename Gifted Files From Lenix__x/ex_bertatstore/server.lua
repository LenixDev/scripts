if Config.type == "ESX" then
ESX = exports['es_extended']:getSharedObject()
elseif Config.type == "QBCORE" then
QBCore = exports['qb-core']:GetCoreObject()
end
local resourceismi = tostring(GetCurrentResourceName())



setplayerskin = function(hangieleman ,data)

    local savebilgi = SaveResourceFile(resourceismi,  "playerskin/"..hangieleman..".json", data, -1)
    return savebilgi
end

getplayerskin = function(hangieleman)
    
    local loadbilgi = LoadResourceFile(resourceismi, "playerskin/"..hangieleman..".json")
    if loadbilgi then return loadbilgi else return "[]" end
end



setplayertattoo = function(hangieleman ,data)

    local savebilgi = SaveResourceFile(resourceismi,  "playertattoo/"..hangieleman..".json", data, -1)
    return savebilgi
end

getplayertattoo = function(hangieleman)
    
    local loadbilgi = LoadResourceFile(resourceismi, "playertattoo/"..hangieleman..".json")
    if loadbilgi then return loadbilgi else return "[]" end
end


RegisterServerEvent('ex_bertatstore:getinfos')
AddEventHandler('ex_bertatstore:getinfos', function()
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerskin = json.decode(getplayerskin(xPlayer.identifier))

        TriggerClientEvent('ex_bertatstore:setclothe', src, playerskin)
        
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local playerskin = json.decode(getplayerskin(Player.PlayerData.citizenid))

        TriggerClientEvent('ex_bertatstore:setclothe', src, playerskin)
    end
end)


RegisterServerEvent('ex_bertatstore:pay:server')
AddEventHandler('ex_bertatstore:pay:server', function(total,which, ordertattoo)
    local src = source
    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local cash = xPlayer.getAccount('money').money
        local bank = xPlayer.getAccount('bank').money
        local gettatto = json.decode(getplayertattoo(xPlayer.identifier))

        if which == "bank" then
       

            if tonumber(bank) >= tonumber(total) then
                
                

                if gettatto == nil or json.encode(gettatto) == "[]" then
                    gettatto.ZONE_HEAD = {}
                    gettatto.ZONE_LEFT_LEG = {}
                    gettatto.ZONE_LEFT_ARM = {}
                    gettatto.ZONE_RIGHT_LEG = {}
                    gettatto.ZONE_TORSO = {}
                    gettatto.ZONE_RIGHT_ARM = {}
                    
                    for k,v in pairs(ordertattoo) do
                       if v ~= nil then
                         table.insert(gettatto[k], v)
                       end
                    end

                    setplayertattoo(xPlayer.identifier, json.encode(gettatto))
                
                   
                else

                    for k,v in pairs(ordertattoo) do
                        if v ~= nil then
                          table.insert(gettatto[k], v)
                        end
                    end

                    setplayertattoo(xPlayer.identifier, json.encode(gettatto))

                end
                xPlayer.removeAccountMoney('bank', tonumber(total))
                TriggerClientEvent('ex_bertatstore:confirmbuy',src, gettatto)

                
                
            else
              
                TriggerClientEvent('ex_bertatstore:notify', src, "You Dont Have Money In Your Bank", 3000)
            end


        elseif which == "cash" then
            if tonumber(cash) >= tonumber(total) then

                if gettatto == nil or json.encode(gettatto) == "[]" then
                    gettatto.ZONE_HEAD = {}
                    gettatto.ZONE_LEFT_LEG = {}
                    gettatto.ZONE_LEFT_ARM = {}
                    gettatto.ZONE_RIGHT_LEG = {}
                    gettatto.ZONE_TORSO = {}
                    gettatto.ZONE_RIGHT_ARM = {}
                    
                    for k,v in pairs(ordertattoo) do
                       if v ~= nil then
                         table.insert(gettatto[k], v)
                       end
                    end

                    setplayertattoo(xPlayer.identifier, json.encode(gettatto))
                
                   
                else

                    for k,v in pairs(ordertattoo) do
                        if v ~= nil then
                          table.insert(gettatto[k], v)
                        end
                    end

                    setplayertattoo(xPlayer.identifier, json.encode(gettatto))

                end


                TriggerClientEvent('ex_bertatstore:confirmbuy',src, gettatto)

                xPlayer.removeMoney(tonumber(total))
            else
                TriggerClientEvent('ex_bertatstore:notify', src, "You Dont Have Money In Your Wallet", 3000)

            end
            
        end
    elseif Config.type == "QBCORE" then

        local Player = QBCore.Functions.GetPlayer(src)
        local cash = tonumber(Player.Functions.GetMoney('cash'))
        local bank = tonumber(Player.Functions.GetMoney('bank'))
        local gettatto = json.decode(getplayertattoo(Player.PlayerData.citizenid))

        if which == "bank" then
       

            if tonumber(bank) >= tonumber(total) then
                if gettatto == nil or json.encode(gettatto) == "[]" then
                    gettatto.ZONE_HEAD = {}
                    gettatto.ZONE_LEFT_LEG = {}
                    gettatto.ZONE_LEFT_ARM = {}
                    gettatto.ZONE_RIGHT_LEG = {}
                    gettatto.ZONE_TORSO = {}
                    gettatto.ZONE_RIGHT_ARM = {}
                    
                    for k,v in pairs(ordertattoo) do
                       if v ~= nil then
                         table.insert(gettatto[k], v)
                       end
                    end

                    setplayertattoo(Player.PlayerData.citizenid, json.encode(gettatto))
                
                   
                else

                    for k,v in pairs(ordertattoo) do
                        if v ~= nil then
                          table.insert(gettatto[k], v)
                        end
                    end

                    setplayertattoo(Player.PlayerData.citizenid, json.encode(gettatto))

                end

                TriggerClientEvent('ex_bertatstore:confirmbuy',src, gettatto)
                Player.Functions.RemoveMoney('bank', tonumber(total), 'clothingbuy')
                
            else
                TriggerClientEvent('ex_bertatstore:notify', src, "You Dont Have Money In Your Bank", 3000)
            end


        elseif which == "cash" then
            if tonumber(cash) >= tonumber(total) then


                if gettatto == nil or json.encode(gettatto) == "[]" then
                    gettatto.ZONE_HEAD = {}
                    gettatto.ZONE_LEFT_LEG = {}
                    gettatto.ZONE_LEFT_ARM = {}
                    gettatto.ZONE_RIGHT_LEG = {}
                    gettatto.ZONE_TORSO = {}
                    gettatto.ZONE_RIGHT_ARM = {}
                    
                    for k,v in pairs(ordertattoo) do
                       if v ~= nil then
                         table.insert(gettatto[k], v)
                       end
                    end

                    setplayertattoo(Player.PlayerData.citizenid, json.encode(gettatto))
                
                   
                else

                    for k,v in pairs(ordertattoo) do
                        if v ~= nil then
                          table.insert(gettatto[k], v)
                        end
                    end

                    setplayertattoo(Player.PlayerData.citizenid, json.encode(gettatto))

                end


                TriggerClientEvent('ex_bertatstore:confirmbuy',src,gettatto)

                Player.Functions.RemoveMoney('cash', tonumber(total), 'clothingbuy')
            else
                TriggerClientEvent('ex_bertatstore:notify', src, "You Dont Have Money In Your Wallet", 3000)
            end
            
        end
    end


end)



RegisterServerEvent('ex_bertatstore:saveownqb')
AddEventHandler('ex_bertatstore:saveownqb', function(skin)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    gofuckthisqbp(json.decode(result[1].skin),result[1].model,skin, Player)
 
   
end)

RegisterServerEvent('ex_bertatstore:saveownesx')
AddEventHandler('ex_bertatstore:saveownesx', function(skin, esxskin)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)




    gofuckthisesx(esxskin,skin, xPlayer)
 
   
end)

function gofuckthisesx(esxskin, skin , xPlayer)
    for k,v in pairs(skin) do
        if k == "makeup_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "blemishes_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "beard_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "eyebrows_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "lipstick_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "blush_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "complexion_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "sun_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "moles_2" then
            esxskin[k] = tonumber(v) * 10
        elseif k == "chest_2" then
            esxskin[k] = tonumber(v) * 10

        else
            esxskin[k] = v
        end
        
    end


    MySQL.update('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(esxskin),
		['@identifier'] = xPlayer.identifier
	})
    
end


function gofuckthisqbp(qbskin,qbmodel, skin , Player)
    for k,v in pairs(skin) do
        if k == "hair_1" then
            qbskin.hair.item = v
        elseif k == "hair_color_1" then
            qbskin.hair.texture = v

        elseif k == "eyebrows_1" then
            qbskin["eyebrows"].item = v
        
        elseif k == "eyebrows_3" then
            qbskin["eyebrows"].texture = v
        elseif k == "beard_1" then
            qbskin.beard.item = v
        elseif k == "beard_3" then
            qbskin.beard.texture = v

        elseif k == "blush_1" then
            qbskin.blush.item = v
        elseif k == "blush_3" then
            qbskin.blush.texture = v

        elseif k == "lipstick_1" then
            qbskin.lipstick.item = v

        elseif k == "lipstick_3" then
            qbskin.lipstick.texture = v

        elseif k == "makeup_1" then
            qbskin.makeup.item = v

        elseif k == "makeup_3" then
            qbskin.makeup.texture = v

        elseif k == "moles_1" then
            qbskin.moles.item = v

        elseif k == "moles_3" then
            qbskin.moles.texture = v

        elseif k == "eye_color" then
            qbskin.eye_color.item = v

       

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


RegisterServerEvent('ex_bertatstore:saveown')
AddEventHandler('ex_bertatstore:saveown', function(skin)
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        setplayerskin(xPlayer.identifier, json.encode(skin))
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        setplayerskin(Player.PlayerData.citizenid, json.encode(skin))
    end
end)


RegisterNetEvent('ex_bertatstore:getattooinfo')
AddEventHandler('ex_bertatstore:getattooinfo', function()
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playertatt = json.decode(getplayertattoo(xPlayer.identifier))
        TriggerClientEvent('ex_bertatstore:settattoo', src, playertatt)
    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local playertatt = json.decode(getplayertattoo(Player.PlayerData.citizenid))
        TriggerClientEvent('ex_bertatstore:settattoo', src, playertatt)

    end
end)


if Config.type == "ESX" then
    ESX.RegisterServerCallback('ex_bertatstore:gettattoinfos', function(playerId, cb)
    
        local src = playerId
        local xPlayer = ESX.GetPlayerFromId(src)
        local playertatt = json.decode(getplayertattoo(xPlayer.identifier))
        cb(playertatt, Config.dovmeliste)

    end)
elseif Config.type == "QBCORE" then

    QBCore.Functions.CreateCallback('ex_bertatstore:gettattoinfos', function(playerId, cb)
    
        local src = playerId
        local Player = QBCore.Functions.GetPlayer(src)
        local playertatt = json.decode(getplayertattoo(Player.PlayerData.citizenid))
        cb(playertatt, Config.dovmeliste)

    end)
end


RegisterServerEvent('ex_bertatstore:cleartatto')
AddEventHandler('ex_bertatstore:cleartatto', function()
    local src = source

    if Config.type == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local gettatto = json.decode(getplayertattoo(xPlayer.identifier))
        gettatto = {}

        setplayertattoo(xPlayer.identifier, json.encode(gettatto))

    elseif Config.type == "QBCORE" then
        local Player = QBCore.Functions.GetPlayer(src)
        local gettatto = json.decode(getplayertattoo(Player.PlayerData.citizenid))
        gettatto = {}

        setplayertattoo(Player.PlayerData.citizenid, json.encode(gettatto))
    end
end)
