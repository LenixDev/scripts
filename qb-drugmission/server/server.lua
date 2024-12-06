local QBCore = exports['qb-core']:GetCoreObject() 
local Cooldown = false

RegisterServerEvent('qb-methrun:server:startr', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money['crypto'] >= Config.RunCost then
		Player.Functions.RemoveMoney('crypto', Config.RunCost)
        Player.Functions.AddItem("casekey", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "add")
		TriggerClientEvent("qb-methrun:server:runactivate", src)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        TriggerEvent("qb-methrun:server:coolout")
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.you_dont_have_enough_money"), 'error')
	end
end)

RegisterServerEvent('qb-vpn:server:startr', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money['crypto'] >= Config.RunCostblack then
		Player.Functions.RemoveMoney('crypto', Config.RunCostblack)
        Player.Functions.AddItem("vpn_blackmarket", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["vpn_blackmarket"], "add")
		-- TriggerClientEvent("qb-methrun:server:runactivate", src)
        -- TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        TriggerEvent("qb-methrun:server:coolout")
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.you_dont_have_enough_money"), 'error')
	end
end)

RegisterServerEvent('qb-food:server:takepolicefood', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money['cash'] >= Config.RunCostfood then
		Player.Functions.RemoveMoney('cash', Config.RunCostfood)
        Player.Functions.AddItem("sandwich", 1)
        Player.Functions.AddItem("water_bottle", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sandwich"], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["water_bottle"], "add")
		-- TriggerClientEvent("qb-methrun:server:runactivate", src)
        -- TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        -- TriggerEvent("qb-food:server:coolout")
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.you_dont_have_enough_money"), 'error')
	end
end)

RegisterServerEvent('qb-laptop:server:startr', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money['cash'] >= Config.RunCostlaptop then
		Player.Functions.RemoveMoney('cash', Config.RunCostlaptop)
        Player.Functions.AddItem("laptop2", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["laptop2"], "add")
		-- TriggerClientEvent("qb-methrun:server:runactivate", src)
        -- TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        TriggerEvent("qb-methrun:server:coolout")
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.you_dont_have_enough_money"), 'error')
	end
end)

RegisterServerEvent('qb-hackerphone:server:startr', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money['crypto'] >= Config.HackerPhone then
		Player.Functions.RemoveMoney('crypto', Config.HackerPhone)
        Player.Functions.AddItem("hackerphone", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hackerphone"], "add")
		-- TriggerClientEvent("qb-methrun:server:runactivate", src)
        -- TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        TriggerEvent("qb-methrun:server:coolout")
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.you_dont_have_enough_money"), 'error')
	end
end)

-- cool down for job
RegisterServerEvent('qb-methrun:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

RegisterServerEvent('qb-food:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown2 * 0
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback("qb-methrun:server:coolc",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false) 
    end
end)

RegisterServerEvent('qb-methrun:server:unlock', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("securitycase", 1)
    Player.Functions.RemoveItem("casekey", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "remove")
end)


RegisterServerEvent('qb-methrun:server:givecaseitems', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local random = math.random(#Config.RandomKeys)

    Player.Functions.AddItem(Config.RandomKeys[random], 1)
    Player.Functions.RemoveItem("securitycase", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RandomKeys[random]], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "remove")
end)
