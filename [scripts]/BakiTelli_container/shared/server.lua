------------------------------------------------------------------------------------

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --

------------------------------------------------------------------------------------

local QBCore = exports['qb-core']:GetCoreObject()

-------------------------------- 

function getplayer(source)
	xPlayer = QBCore.Functions.GetPlayer
	return xPlayer
end

-------------------------------- 

function getmoney(source)
    local zrt = getplayer()
    local xPlayer = zrt(source)	
    if Config.Money == "cash" then 
        return xPlayer.PlayerData.money["cash"]
    else 
        return xPlayer.PlayerData.money["bank"]
    end 
end

-------------------------------- 

function removeitem(source,name,count)
    local src = source
    if Config.Inventory == "default" then
        local zrt = getplayer()
        local xPlayer = zrt(src)	
        xPlayer.Functions.RemoveItem(name, count)
    elseif Config.Inventory == "ox_inventory" then 
        exports.ox_inventory:RemoveItem(src, name, count)
    elseif Config.Inventory == "quasar" then 
        exports['qs-inventory']:RemoveItem(src, name, count)
    else
        -- Other Export
    end
end

-------------------------------- 

function getitem(source,item)
    local src = source
    if Config.Inventory == "default" then
        local zrt = getplayer()
        local xPlayer = zrt(src)	
        if xPlayer.Functions.GetItemByName(item) ~= nil then	
            item = xPlayer.Functions.GetItemByName(item).amount 
        else
            item = nil
        end
    elseif Config.Inventory == "ox_inventory" then 
        item = exports.ox_inventory:GetItemCount(src, item)
    elseif Config.Inventory == "quasar" then 
        item = exports['qs-inventory']:GetItemTotalAmount(src, item)
    else
        -- Other Export
    end
    if item == nil then 
        item = 0
    end
    return item 
end

-------------------------------- 

function additem(source,n,c)
    local src = source
    if Config.Inventory == "default" then
        local zrt = getplayer()
        local xPlayer = zrt(src)
        xPlayer.Functions.AddItem(n,c)
    elseif Config.Inventory == "ox_inventory" then 
        exports.ox_inventory:AddItem(src, n, c)
    elseif Config.Inventory == "quasar" then 
        exports['qs-inventory']:AddItem(src,n,c)
    else
        -- Other Export
    end
end

-------------------------------- 

function removeMoney(src, count)
    local zrt = getplayer()
    local xPlayer = zrt(src)	
    if Config.Money == "cash" then 
        xPlayer.Functions.RemoveMoney('cash', count, "Bank depost")
    else
        xPlayer.Functions.RemoveMoney('bank', count, "Bank depost")
    end
end

-------------------------------- 

function getidentifier(xPlayer)
	hex = xPlayer.PlayerData.citizenid
	return hex
end
