local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent("give:lockpick", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveMoney("cash", 500) or Player.Functions.RemoveMoney("bank", 1976500) then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)
