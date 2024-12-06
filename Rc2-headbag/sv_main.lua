

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("Rc2-headbag:getClosestPlayer", function(closestPlayer)
    getPlayer = closestPlayer;
    local name = GetPlayerName(getPlayer);
    TriggerClientEvent("StartThread", getPlayer);
end)

RegisterNetEvent("Rc2-headbag:getClosestPlayer2", function()
    TriggerClientEvent("RemoveHeadBag", getPlayer);
end)

QBCore.Functions.CreateUseableItem("head_bag", function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source);
    if xPlayer.Functions.GetItemByName("head_bag") ~= nil then
        TriggerClientEvent("CheckThread", source);
    end
end)
