local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('police:server:servicescheck', function(source, cb, playerCitiz, ischeck)
    local Player = QBCore.Functions.GetPlayer(source)
    local Player2 = QBCore.Functions.GetPlayerByCitizenId(playerCitiz)
    local status = ""
    if Player2 ~= nil then
        cb(Player2.PlayerData.metadata["isstopservices"])
        if ischeck then
            if Player2.PlayerData.metadata["isstopservices"] then status = "غير مفعلة" else status = "مفعلة" end
            TriggerEvent("qb-log:server:CreateLog", "stopservices", "تحقق من إيقاف الخدمات | ".. Player.PlayerData.charinfo.firstname.." ".. Player.PlayerData.charinfo.lastname.." - "..Player.PlayerData.job.label.." ", "green", "**"..Player2.PlayerData.charinfo.firstname.." ".. Player2.PlayerData.charinfo.lastname.." ["..Player2.PlayerData.citizenid.."] :تم التحقق من خدمات المواطن** \n **حالة خدماته: "..status.."**", false)
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "!رقم الهوية المدخل غير صالح", 'error')
    end
end)

RegisterServerEvent('police:server:manageservices', function(playerCitiz, istrue)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local Player2 = QBCore.Functions.GetPlayerByCitizenId(playerCitiz)
    local status = ""
    if istrue then
        Player2.Functions.SetMetaData("isstopservices", true)
        TriggerClientEvent('QBCore:Notify', Player2.PlayerData.source, "!تم إيقاف خدماتك من قبل الشرطة", 'success')
        TriggerClientEvent('QBCore:Notify', src, "! " .. Player2.PlayerData.charinfo.firstname .. " " .. Player2.PlayerData.charinfo.lastname.. " تم إيقاف خدمات المواطن", 'success')
        status = "غير مفعلة"
        TriggerEvent("qb-log:server:CreateLog", "stopservices", "إيقاف خدمات مواطن | ".. Player.PlayerData.charinfo.firstname.." ".. Player.PlayerData.charinfo.lastname.." - "..Player.PlayerData.job.label.." ", "green", "**"..Player2.PlayerData.charinfo.firstname.." ".. Player2.PlayerData.charinfo.lastname.." ["..Player2.PlayerData.citizenid.."] :تم إيقاف خدمات المواطن** \n **حالة خدماته: "..status.."**", false)
    else
        Player2.Functions.SetMetaData("isstopservices", false)
        TriggerClientEvent('QBCore:Notify', Player2.PlayerData.source, "!تم إلغاء إيقاف خدماتك من قبل الشرطة", 'success')
        TriggerClientEvent('QBCore:Notify', src, "! " .. Player2.PlayerData.charinfo.firstname .. " " .. Player2.PlayerData.charinfo.lastname.. " تم إلغاء إيقاف خدمات المواطن", 'success')
        status = "مفعلة"
        TriggerEvent("qb-log:server:CreateLog", "stopservices", "إلغاء إيقاف خدمات مواطن | ".. Player.PlayerData.charinfo.firstname.." ".. Player.PlayerData.charinfo.lastname.." - "..Player.PlayerData.job.label.." ", "green", "**"..Player2.PlayerData.charinfo.firstname.." ".. Player2.PlayerData.charinfo.lastname.." ["..Player2.PlayerData.citizenid.."] :تم إلغاء إيقاف خدمات المواطن** \n **حالة خدماته: "..status.."**", false)
    end
end)

QBCore.Functions.CreateCallback('qb-stopservices:server:servicescheck', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    cb(Player.PlayerData.metadata["isstopservices"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)