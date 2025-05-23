AddEventHandler("BakiTelli:container:getplayerdetail")
RegisterNetEvent("BakiTelli:container:getplayerdetail", function ()
    src = source
    details = {
        key = getitem(src, Config.KeyItem),
        money = getmoney(src)
    } 
    TriggerClientEvent("BakiTelli:container:cl:getplayerdetail", src, details)
end)



AddEventHandler("BakiTelli:container:SetPlayerRoutingBucket")
RegisterNetEvent("BakiTelli:container:SetPlayerRoutingBucket", function (cancel)
    if cancel then
            SetPlayerRoutingBucket(source, 0)
        else
            SetPlayerRoutingBucket(source, source)
    end
end)

AddEventHandler("Bakitelli:container:opencase")
RegisterNetEvent("Bakitelli:container:opencase", function (containerno)
    cn = Config.Containers[containerno] 
    avb = false 
    src = source
    totalproduct = #cn.Products
    random = math.random(1, totalproduct)
    if cn.CasePriceTyp == "money" then 
      if getmoney(src) >= cn.CasePriceAmount then 
          removeMoney(src, cn.CasePriceAmount)
          avb = true
       end 
    else 
        if getitem(src, Config.KeyItem) >= cn.CasePriceAmount then
            removeitem(src, Config.KeyItem, cn.CasePriceAmount)
            avb = true
        end   
    end 
    if avb then 
        TriggerClientEvent("Bakitelli:container:opencase:cl", src, containerno, random)

        additem(src, Config.Containers[containerno].Products[random].itemname, Config.Containers[containerno].Products[random].itemcount)
    end
end)