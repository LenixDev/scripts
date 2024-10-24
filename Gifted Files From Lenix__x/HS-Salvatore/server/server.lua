local QBCore = exports['qb-core']:GetCoreObject()

--MADE-BY-CA

RegisterServerEvent("give:key1", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 50)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)

RegisterServerEvent("give:armor", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 5)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)

RegisterServerEvent("give:weapon_pistol_mk2", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 150)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)

RegisterServerEvent("give:drill", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 20)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)

RegisterServerEvent("give:pistol_ammo", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 5)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)

RegisterServerEvent("give:smg_ammo", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 5)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)

RegisterServerEvent("give:rifle_ammo", function (item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.Functions.RemoveItem("cash_stack", 5)  then
        QBCore.Functions.Notify(source, "تم سحب المبلغ وتم اعطاك المنتج", 'info')
     

        Player.Functions.AddItem(item,1)
    else
        QBCore.Functions.Notify(source, "لايمكنك الشراء", "error" , 5000)
    end
end)
















































--MADE-BY-CA