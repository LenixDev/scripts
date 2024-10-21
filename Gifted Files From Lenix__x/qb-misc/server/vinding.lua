

RegisterNetEvent("vending:buyDrink", function(machine)
  local source = source
  local Player = QBCore.Functions.GetPlayer(source)
  Player.Functions.RemoveMoney('cash', Config.VindingModels[machine].price)
end)

QBCore.Functions.CreateCallback("vending:canBuyDink", function(source, cb, machine)
  local Player = QBCore.Functions.GetPlayer(source)
  local retval = false
  if Player.PlayerData.money.cash >= Config.VindingModels[machine].price then 
    retval = true 
  end
  cb(retval)
end)

