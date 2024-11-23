local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end
	for k, v in pairs(Crafting) do for i = 1, #v do
			for l, b in pairs(v[i]) do if not QBCore.Shared.Items[l] then print("^5Debug^7: ^6Crafting^7: ^2Missing Item from ^4QBCore^7.^4Shared^7.^4Items^7: '^6"..l.."^7'") end
				for j, c in pairs(b) do if not QBCore.Shared.Items[j] then print("^5Debug^7: ^6Crafting^7: ^2Missing Item from ^4QBCore^7.^4Shared^7.^4Items^7: '^6"..j.."^7'") end end end end end
	for i = 1, #Config.DrinkItems.items do
		if not QBCore.Shared.Items[Config.DrinkItems.items[i].name] then print("^5Debug^7: ^6Store^7: ^2Missing Item from ^4QBCore^7.^4Shared^7.^4Items^7: '^6"..Config.DrinkItems.items[i].name.."^7'") end
	end
	for i = 1, #Config.FoodItems.items do
		if not QBCore.Shared.Items[Config.FoodItems.items[i].name] then print("^5Debug^7: ^6Store^7: ^2Missing Item from ^4QBCore^7.^4Shared^7.^4Items^7: '^6"..Config.FoodItems.items[i].name.."^7'") end
	end
	for i = 1, #Config.WineItems.items do
		if not QBCore.Shared.Items[Config.WineItems.items[i].name] then print("^5Debug^7: ^6Store^7: ^2Missing Item from ^4QBCore^7.^4Shared^7.^4Items^7: '^6"..Config.WineItems.items[i].name.."^7'") end
	end
	for i = 1, #Config.FreezerItems.items do
		if not QBCore.Shared.Items[Config.FreezerItems.items[i].name] then print("^5Debug^7: ^6Store^7: ^2Missing Item from ^4QBCore^7.^4Shared^7.^4Items^7: '^6"..Config.FreezerItems.items[i].name.."^7'") end
	end
	if not QBCore.Shared.Jobs["pizza"] then print("Error: Job role not found - 'pizzathis'") end
end)

--Consumables
CreateThread(function()
	local wines = { "amarone", "barbera", "dolceto", "housered", "housewhite", "rosso" }
    for _, v in pairs(wines) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:DrinkAlcohol', source, item.name) end) end

	local beers = { "ambeer", "dusche", "logger", "pisswasser", "pisswasser2", "pisswasser3" }
    for _, v in pairs(beers) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:DrinkAlcohol', source, item.name) end) end

	local drink = { "sprunk", "sprunklight", "ecola", "ecolalight" }
    for _, v in pairs(drink) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:Drink', source, item.name) end) end

	local food = { "tiramisu", "gelato", "medfruits", "capricciosa", "diavola", "marinara", "margherita", "prosciuttio", "vegetariana", "bolognese", "calamari", "meatball", "alla", "pescatore" }
    for _, v in pairs(food) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-pizzathis:client:Eat', source, item.name) end) end

	local boxes = { "capricciosabox", "diavolabox", "marinarabox", "margheritabox", "prosciuttiobox", "vegetarianabox" }
    for _, v in pairs(boxes) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerEvent('jim-pizzathis:OpenBox', source, item.name) end) end
end)

RegisterServerEvent('jim-pizzathis:OpenBox', function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if item == "capricciosabox" then slices = "capricciosa"
	elseif item == "diavolabox" then slices = "diavola"
	elseif item == "marinarabox" then slices = "marinara"
	elseif item == "margheritabox" then slices = "margherita"
	elseif item == "prosciuttiobox" then slices = "prosciuttio"
	elseif item == "vegetarianabox" then slices = "vegetariana" end
	--This removes the box
	TriggerEvent("jim-pizzathis:server:toggleItem", false, item, 1, src)
	Wait(600)
	--This gives the slices
	TriggerEvent("jim-pizzathis:server:toggleItem", true, QBCore.Shared.Items[slices].name, 6, src)

end)

---Crafting
RegisterServerEvent('jim-pizzathis:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	local amount = 1
	if craftable then
		if craftable["amount"] then amount = craftable["amount"] end
		for k, v in pairs(craftable[ItemMake]) do TriggerEvent("jim-pizzathis:server:toggleItem", false, tostring(k), v, src) end
	end
	--This should give the item, while the rest removes the requirements
	TriggerEvent("jim-pizzathis:server:toggleItem", true, ItemMake, amount, src)
end)

RegisterNetEvent('jim-pizzathis:server:toggleItem', function(give, item, amount, newsrc)
	local src = newsrc or source
	if give == 0 or give == false then
		if HasItem(src, item, amount or 1) then -- check if you still have the item
			if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount or 1) then
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount or 1)
				if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
			end
		else TriggerEvent("jim-pizzathis:server:DupeWarn", item, src) end -- if not boot the player
	else
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount or 1)
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
		end
	end
end)

RegisterNetEvent("jim-pizzathis:server:DupeWarn", function(item, newsrc)
	local src = newsrc or source
	local P = QBCore.Functions.GetPlayer(src)
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Tried to remove item ^7('^3"..item.."^7')^2 but it wasn't there^7")
	DropPlayer(src, "Kicked for attempting to duplicate items")
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Dropped from server for item duplicating^7")
end)

function HasItem(source, items, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = #items
    local count = 0
    local kvIndex = 2
    if isTable and not isArray then
        totalItems = 0
        for _ in pairs(items) do totalItems += 1 end
        kvIndex = 1
    end
    if isTable then
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player^7(^6"..source.."^7)^2 has items^7") end
        for k, v in pairs(items) do
            local itemKV = {k, v}
            local item = Player.Functions.GetItemByName(itemKV[kvIndex])
            if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
                count += 1
            end
        end
        if count == totalItems then
			if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items FOUND^7") end
            return true
        end
    else -- Single item as stringHasItem(v, 1)
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player^7(^6"..source.."^7)^2 has items^7") end
		local item = Player.Functions.GetItemByName(items)
        if item and (not amount or (item and amount and item.amount >= amount)) then
            return true
        end
    end
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items Not FOUND^7") end
    return false
end