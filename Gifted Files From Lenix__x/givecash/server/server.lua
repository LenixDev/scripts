local QBCore = exports[config.Core]:GetCoreObject()

QBCore.Functions.CreateCallback("qb-givecash:getplayers",function(source,cb,args) 
    local Players = {}
    for k,v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if v ~= source then
            Players[v] = {
                ped = GetEntityCoords(GetPlayerPed(v)),
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.lastname
            }
        end
        
    end
    cb(Players)
end)


RegisterServerEvent('qb-givecash:server:givemoney')
AddEventHandler('qb-givecash:server:givemoney', function(dialog)
    local amount = nil
    local Other = nil
    if dialog ~= nil then
        for k,v in pairs(dialog) do
            if k == 'amount' then
                amount = v
            end
            if k == 'player' then
                Other = v
            end
        end
        if tonumber(amount) < 0 then
            TriggerClientEvent('QBCore:Notify', source, "الخانة فارغة", "error")
            return
        end
        if QBCore.Functions.GetPlayer(tonumber(Other)) == nil then
            TriggerClientEvent('QBCore:Notify', source, "لم يتم العثور على اللاعب", "error")
            return
        end
        local Player = QBCore.Functions.GetPlayer(source)
        local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(Other))
        if Player.Functions.RemoveMoney("cash", tonumber(amount), "اعطاء نقود من قبل لاعب") then
            if OtherPlayer.Functions.AddMoney("cash", tonumber(amount), "حصل على نقود من قبل لاعب") then
                TriggerClientEvent('QBCore:Notify', source, "تم اعطاء اللاعب المبلغ : "..tonumber(amount), "success")
                TriggerClientEvent('QBCore:Notify', tonumber(Other), "لقد حصلت على مبلغ كاش من شخص : "..tonumber(amount), "success")
            end
        end
    end
end)
