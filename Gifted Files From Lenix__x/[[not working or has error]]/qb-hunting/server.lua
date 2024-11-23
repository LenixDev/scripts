QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('qb-hunting:skinReward')
AddEventHandler('qb-hunting:skinReward', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local randomAmount = math.random(1,30)
  local item = 'huntingcarcass4'

  if randomAmount > 1 and randomAmount < 30 then
    item = 'huntingcarcass1'
  elseif randomAmount > 15 and randomAmount < 50 then
    item = 'huntingcarcass2'
  elseif randomAmount > 23 and randomAmount < 20 then
    item = 'huntingcarcass3'
  end

  Player.Functions.AddItem(item, 1)
  TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
end)

RegisterServerEvent('qb-hunting:removeBait')
AddEventHandler('qb-hunting:removeBait', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  Player.Functions.RemoveItem("huntingbait", 1)
end)

RegisterServerEvent('remove:money')
AddEventHandler('remove:money', function(totalCash)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.PlayerData.money['cash'] >= (500) then
    Player.Functions.RemoveMoney('cash', 500)
    TriggerClientEvent("qb-hunting:setammo", src)
    TriggerClientEvent("QBCore:Notify", src, 'Reloaded.')
  else
    TriggerClientEvent("QBCore:Notify", src, 'Not enough cash on you.', 'error')
  end
end)

QBCore.Functions.CreateUseableItem("huntingbait", function(source, item)
  local Player = QBCore.Functions.GetPlayer(source)

  TriggerClientEvent('qb-hunting:usedBait', source)
end)


local carcasses = {
  huntingcarcass1 = 450,
  huntingcarcass2 = 800,
  huntingcarcass3 = 2100,
  huntingcarcass4 = 2600
}

RegisterServerEvent('qb-hunting:server:sell')
AddEventHandler('qb-hunting:server:sell', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local whatSold = {};
    local total = 0;

    for k,v in pairs(carcasses) do
        local item = Player.Functions.GetItemByName(k)
        if item ~= nil then
            if Player.Functions.RemoveItem(k, item.amount) then
                local price = v * item.amount;
                table.insert(whatSold, ('`%dx` %s - `$%d`'):format(item.amount, item.label, price));
                total = total + price;
            end
        end
    end

    Player.Functions.AddMoney('cash', total)

end)

RegisterNetEvent('qb-hunting:delete', function(netId)
  local ent = NetworkGetEntityFromNetworkId(netId)
  if DoesEntityExist(ent) then
    DeleteEntity(ent)
  end
end)