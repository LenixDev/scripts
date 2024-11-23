local function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

local function GetRepoRep(Player,CitizenId)
    if Framework == "ESX" then
        local Result = MySQL.query.await('SELECT * FROM pug_repojob WHERE citizenid = ?', {CitizenId})
        if Result[1] then
            return tonumber(Result[1].reporep)
        else
            MySQL.insert.await('INSERT INTO pug_repojob (citizenid, reporep) VALUES (?,?)', {
                CitizenId, 0
            })
            return 0
        end
    else
        return tonumber(Player.PlayerData.metadata['reporep'])
    end
end

RegisterNetEvent("Pug:Server:FinishReoJob", function(rank)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local RepoRank = Config.RepoProgression[rank]
    local Pay = math.random(Config.MinimalPay, Config.MaximumPay)
    local FinalPay = round(Pay * RepoRank.Multiplier)
    local CID = Player.PlayerData.citizenid
    Player.AddMoney('cash', FinalPay)
    local RepoRep = GetRepoRep(Player, CID)
    local RepPay = math.random(Config.EarnableRepMin, Config.EarnableRepMax)
    local FinalRep = round(RepPay + RepoRep)
    if Framework == "ESX" then
        local Result = MySQL.query.await('SELECT * FROM pug_repojob WHERE citizenid = ?', {CID})
        if Result[1] then
            MySQL.update('UPDATE pug_repojob SET reporep = ? WHERE citizenid = ?', { FinalRep, CID })
        end
    else
        Player.SetMetaData("reporep", FinalRep)
    end
    TriggerClientEvent('Pug:client:RepoNotifyEvent', src, '+'..RepPay..Config.LangT["RepoRep"], 'success')
end)

if Framework == "QBCore" then
    FWork.Commands.Add("tptow", "Garage 1 Teleport", {}, false, function(source)
        TriggerClientEvent('Pug-TpTow', source)
    end,"admin")
    FWork.Commands.Add("getrepo", "Request a repo/tow driver", {{name = "Message", help = "information"}}, false, function(source, args)
        if args[1] then
            local src = source
            local Player = Config.FrameworkFunctions.GetPlayer(src)
            local PlayerInfo = {
                FirstName = Player.PlayerData.charinfo.firstname,
                LastName = Player.PlayerData.charinfo.lastname,
                Source = src,
            }
            for _, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
                TriggerClientEvent("Pug:client:GetRepoWorker",v, args[1], PlayerInfo)
            end
        else
            TriggerClientEvent('Pug:client:RepoNotifyEvent', source, Config.LangT["MissingText"], 'error')
        end
    end)
else
    FWork.RegisterCommand('tptow', "admin", function(xPlayer, args, showError)
        xPlayer.triggerEvent("Pug-TpTow")
    end, true)
    FWork.RegisterCommand("getrepo", "Request a repo/tow driver", {{name = "Message", help = "information"}}, false, function(xPlayer, args, showError)
        if args[1] then
            local src = source
            local Player = Config.FrameworkFunctions.GetPlayer(src)
            local PlayerInfo = {
                FirstName = Player.PlayerData.charinfo.firstname,
                LastName = Player.PlayerData.charinfo.lastname,
                Source = src,
            }
            for _, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
                TriggerClientEvent("Pug:client:GetRepoWorker",v, args[1], PlayerInfo)
            end
        else
            TriggerClientEvent('Pug:client:RepoNotifyEvent', source, Config.LangT["MissingText"], 'error')
        end
    end)
end
RegisterNetEvent("Pug:server:SendPlayerRepoMessage", function(Ply, Message)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local PlayerInfo = {
        FirstName = Player.PlayerData.charinfo.firstname,
        LastName = Player.PlayerData.charinfo.lastname,
    }
    TriggerClientEvent("chatMessage",Ply, "TOW/REPO MESSAGE", "warning", " ID ["..src.."] ".. PlayerInfo.FirstName .. " " .. PlayerInfo.LastName.. " | "..Message)
end)

if Framework == "QBCore" then
    FWork.Functions.CreateUseableItem("reponote", function(source, item)
        local src = source
        local pCoords = GetEntityCoords(GetPlayerPed(src))
        for _, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
            local Player = Config.FrameworkFunctions.GetPlayer(v)
            if Player ~= nil then
                local tCoords = GetEntityCoords(GetPlayerPed(v))
                local dist = #(pCoords - tCoords)
                if dist <= 4.0 then
                    TriggerClientEvent('chat:addMessage', v,  {
                        template = '<div class="chat-message advert"><div class="chat-message-body"><strong>[Repo Verification Note]</strong><br> <strong>Repo Worker:</strong> {0} {1}<br><strong>Vehicle Plate:</strong> {2} <br><strong>Vehicle Model:</strong> {3}',
                        args = {
                            item.info.firstname,
                            item.info.lastname,
                            item.info.vehiclePlate,
                            item.info.vehicleModel
                        }
                    })
                end
            end
        end
    end)
    FWork.Functions.CreateUseableItem("towremote", function(source, item)
        local src = source
        TriggerClientEvent("Pug:Clent:TowTruckRemoteMenu", src)
    end)
elseif Framework == "ESX" then
    FWork.RegisterUsableItem("reponote", function(source, item)
        local src = source
        local pCoords = GetEntityCoords(GetPlayerPed(src))
        for _, v in pairs(Config.FrameworkFunctions.GetPlayers()) do
            local Player = Config.FrameworkFunctions.GetPlayer(v)
            if Player ~= nil then
                local tCoords = GetEntityCoords(GetPlayerPed(v))
                local dist = #(pCoords - tCoords)
                if dist <= 5.0 then
                    TriggerClientEvent('chat:addMessage', v,  {
                        template = '<div class="chat-message advert"><div class="chat-message-body"><strong>[Repo Verification Note]</strong><br> <strong>Repo Worker:</strong> {0} {1}<br><strong>Vehicle Plate:</strong> {2} <br><strong>Vehicle Model:</strong> {3}',
                        args = {
                            item.info.firstname,
                            item.info.lastname,
                            item.info.vehiclePlate,
                            item.info.vehicleModel
                        }
                    })
                end
            end
        end
	end)
	FWork.RegisterUsableItem("towremote", function(source, item)
        local src = source
        TriggerClientEvent("Pug:Clent:TowTruckRemoteMenu", src)
	end)
end

RegisterNetEvent("Pug:server:ToggleTruckDeposite", function(bool)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Player ~= nil then
        if bool then
            Player.RemoveMoney('bank', Config.RepoTruckDeposit)
        else
            Player.AddMoney('bank', Config.RepoTruckDeposit)
        end
    end
end)

RegisterServerEvent('Pug:server:ToggleRepoItem', function(bool, item, amount, info)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
	if bool then
        if amount then
            Player.AddItem(item, amount, false, info)
        else
            Player.AddItem(item, 1, false, info)
        end
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "add")
        end
    else
        if amount then
            Player.RemoveItem(item, amount)
        else
            Player.RemoveItem(item, 1)
        end
        if Framework == "QBCore" then
		    TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items[item], "remove")
        end
	end
end)


RegisterNetEvent("Pug:server:AddRepoItem", function(plate, model)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local info = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        vehiclePlate = plate,
        vehicleModel = model,
    }
    Player.AddItem("reponote", 1, info)
    Player.AddItem("towremote", 1)
    if Framework == "QBCore" then
        TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["reponote"], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["towremote"], "add")
    end
end)

RegisterNetEvent("Pug:server:RemoveRepoLetter", function()
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    if Config.FrameworkFunctions.GetItemByName(src, "reponote", 1) then
        Player.RemoveItem("reponote", 1)
        if Framework == "QBCore" then
            TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["reponote"], "remove")
            TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["towremote"], "remove")
        end
    end
    if Config.FrameworkFunctions.GetItemByName(src, "towremote", 1) then
        Player.RemoveItem("towremote", 1)
        if Framework == "QBCore" then
            TriggerClientEvent('inventory:client:ItemBox', src, FWork.Shared.Items["towremote"], "remove")
        end
    end
end)

Config.FrameworkFunctions.CreateCallback('Pug:server:GetReopRep', function(source, cb)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    local Rep = GetRepoRep(Player,CID)
    cb(Rep)
end)

RegisterNetEvent("Pug:server:CraftRepoParts", function(data)
    local src = source
    local Player = Config.FrameworkFunctions.GetPlayer(src)
    local MainItem = Config.CraftingParts[data.item]
    local Item1 = Config.FrameworkFunctions.GetItemByName(src, MainItem.part1.part, 1)
    local Item2 = Config.FrameworkFunctions.GetItemByName(src, MainItem.part2.part, 1)
    local Item3 = Config.FrameworkFunctions.GetItemByName(src, MainItem.part3.part, 1)
    local Item4 = Config.FrameworkFunctions.GetItemByName(src, MainItem.part4.part, 1)
    local Amount1 = 0 
    local Amount2 = 0 
    local Amount3 = 0 
    local Amount4 = 0 
    if Item1 then
        if Framework == "QBCore" then
            Amount1 = Item1.amount
        else
            Amount1 = Item1.count
        end
        if Amount1 >= MainItem.part1.amount then
            if Item2 then
                if Framework == "QBCore" then
                    Amount2 = Item2.amount
                else
                    Amount2 = Item2.count
                end
                if Amount2 >= MainItem.part2.amount then
                    if Item3 then
                        if Framework == "QBCore" then
                            Amount3 = Item3.amount
                        else
                            Amount3 = Item3.count
                        end
                        if Amount3 >= MainItem.part3.amount then
                            if Item4 then
                                if Framework == "QBCore" then
                                    Amount4 = Item4.amount
                                else
                                    Amount4 = Item4.count
                                end
                                if Amount4 >= MainItem.part4.amount then
                                    Player.RemoveItem(MainItem.part1.part, MainItem.part1.amount)
                                    Player.RemoveItem(MainItem.part2.part, MainItem.part2.amount)
                                    Player.RemoveItem(MainItem.part3.part, MainItem.part3.amount)
                                    Player.RemoveItem(MainItem.part4.part, MainItem.part4.amount)
                                    TriggerClientEvent("Pug:client:CraftRepoParts", src,data)
                                else
                                    TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part4.amount - Amount4.."x "..MainItem.part4.part, 'error')
                                end
                            else
                                TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part4.part, 'error')
                            end
                        else
                            TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part3.amount - Amount3.."x "..MainItem.part3.part, 'error')
                        end
                    else
                        TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part3.part, 'error')
                    end
                else
                    TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part2.amount - Amount2.."x "..MainItem.part2.part, 'error')
                end
            else
                TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part2.part, 'error')
            end
        else
            TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part1.amount - Amount1.."x "..MainItem.part1.part, 'error')
        end
    else
        TriggerClientEvent('Pug:client:RepoNotifyEvent', src, Config.LangT["Missing"]..MainItem.part1.part, 'error')
    end
end)

-- lb-phone email event support
RegisterNetEvent("Pug:Server:SendLbPhoneMail", function(VehName, LicensePlate)
    local src = source
    local MyNumber = exports["lb-phone"]:GetEquippedPhoneNumber(src)
    local MyEmail = exports["lb-phone"]:GetEmailAddress(MyNumber)
    local success, id = exports["lb-phone"]:SendMail({
        to = MyEmail,
        subject = Config.LangT["EmailSender"],
        message = Config.LangT["EmailMessage1"] .. VehName .. Config.LangT["EmailMessage2"]..LicensePlate..".",
    })
end)