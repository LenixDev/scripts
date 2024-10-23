---@diagnostic disable: undefined-global
local QBCore = exports[Config.core]:GetCoreObject()

RegisterServerEvent("revome.drill", function()
    print("done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.RemoveItem("drill", 1)

end)

RegisterServerEvent("add.vp7", function()
    print("Done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.AddItem('drill', 1, false, info)
end)

RegisterNetEvent("add.vp7_Client", function()
    print("Done")
    TriggerServerEvent("add.vp7")
end)


RegisterServerEvent("add.drill.sakn", function()
    print("done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.AddItem("skan", 1, "slot", "info")

end)

RegisterServerEvent("add.drill.done", function()
    print("done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.AddItem("drill", 1, "slot", "info")
end)


RegisterServerEvent("add.mask.done", function()
    print("done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.AddItem("weapon_knife", 1, "slot", "info")
end)

RegisterServerEvent("End_item", function()
    print("done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.AddItem(Config.item_end1, 7, "slot", "info")
    xPlayer.Functions.AddItem(Config.item_end2, 2, "slot", "info")
    xPlayer.Functions.AddItem(Config.item_end3, 1, "slot", "info")
end)


RegisterServerEvent("revome.mask", function()
    print("done")
    local sre = source
    local xPlayer = QBCore.Functions.GetPlayer(sre)
    xPlayer.Functions.RemoveItem("weapon_knife", 1)

end)


QBCore.Functions.CreateUseableItem('skan', function(source, item)
    local src = source
    local Name_ = {
        item_1 = "pistolammo_blueprint",
        item_2 = "sns_blueprint",
        item_3 = "snsmk_blueprint",
        item_4 = "pistol_blueprint",
        item_5 = "mk2_blueprint",
        item_6 = "50_blueprint",
        item_7 = "heavypistol_blueprint",
        item_8 = "vintag_blueprint",
    }
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local nu = math.random(0,8)
    if nu == 8 then
        Player.Functions.AddItem(Name_.item_1, 1, "slot", "info")
    elseif nu == 7 then
        Player.Functions.AddItem(Name_.item_2, 1, "slot", "info")
    elseif nu == 6 then
        Player.Functions.AddItem(Name_.item_3, 1, "slot", "info")
    elseif nu == 5 then
        Player.Functions.AddItem(Name_.item_4, 1, "slot", "info")
    elseif nu == 4 then
        Player.Functions.AddItem(Name_.item_5, 1, "slot", "info")
    elseif nu == 3 then
        Player.Functions.AddItem(Name_.item_6, 1, "slot", "info")
    elseif nu == 2 then
        Player.Functions.AddItem(Name_.item_7, 1, "slot", "info")
    elseif nu == 1 then
        Player.Functions.AddItem(Name_.item_8, 1, "slot", "info")
    else
        print("CR DEV")
    end
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('skan', 1)
end)

print("CR DEV :https://discord.gg/CR3")