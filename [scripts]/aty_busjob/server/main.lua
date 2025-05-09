Workers = {}


Functions.REGISTER_SERVER_CALLBACK("aty_busjob:getData", function(src, cb)
    local file = LoadResourceFile(GetCurrentResourceName(), 'database.json')
	data = json.decode(file)
    local playerData = Functions.GET_DATA(src)

    if not playerData then
        local avatar = Functions.GET_AVATAR(src)

        local temp = {
            license = Functions.GET_PLAYER_LICENSE(src),
            avatar = avatar,
            oldMissons = {},
            exp = 0,
        }

        table.insert(data, temp)
        SaveResourceFile(GetCurrentResourceName(), 'database.json', json.encode(data), -1)
        cb({data = temp, workers = Workers})
    else
        cb({data = playerData, workers = Workers})
    end
end)

                                                              
RegisterServerEvent("aty_busjob:updateWorker", function(place, name)
    local src = source
    local playerData = Functions.GET_DATA(src)
    local worker = Functions.CHECK_IS_WORKING(src)

    if worker then
        worker.place = place
    else
        table.insert(Workers, {avatar = playerData.avatar, name = name, place = place, src = src})
    end
end)

                                                              
RegisterServerEvent("aty_busjob:removeWorker", function()
    local src = source
    local worker = Functions.CHECK_IS_WORKING(src)

    if worker then
        for k, v in pairs(Workers) do
            if v.src == src then
                table.remove(Workers, k)
            end
        end
    end
end)

                                                              
RegisterServerEvent("aty_busjob:addExpedition", function(route)
    local src = source
    local routeName = route.RouteName
    local date = os.date("%m/%d/%Y %H:%M:%S")
    local temp = {routeName = routeName, date = date}

    local playerData = Functions.GET_DATA(src)

    if playerData then
        table.insert(playerData.oldMissons, temp)
        SaveResourceFile(GetCurrentResourceName(), 'database.json', json.encode(data), -1)
    end
end)

RegisterServerEvent("aty_busjob:givePrize", function(passengers, exp, ticketPrice)
    local src = source
    local playerData = Functions.GET_DATA(src)
    local xPlayer = Config.Framework == "qb" and Framework.Functions.GetPlayer(src) or Framework.GetPlayerFromId(src)

    if Config.Framework == "qb" then
        xPlayer.Functions.AddMoney("cash", passengers * ticketPrice, "Ticket sales")
    else
        xPlayer.addAccountMoney("money", passengers * ticketPrice)
    end

    if playerData then
        playerData.exp = playerData.exp + exp
        SaveResourceFile(GetCurrentResourceName(), 'database.json', json.encode(data), -1)
    end
end)

RegisterServerEvent("aty_busjob:removeMoney", function()
    local src = source
    local xPlayer = Config.Framework == "qb" and Framework.Functions.GetPlayer(src) or Framework.GetPlayerFromId(src)

    if Config.Framework == "qb" then
        local money = xPlayer.Functions.GetMoney("cash")
        if money >= Config.CrashFine then
            xPlayer.Functions.RemoveMoney("cash", Config.CrashFine, "Crash Fine")
        end
    else
        local money = xPlayer.getAccount("money").money
        if money >= Config.CrashFine then
            xPlayer.removeAccountMoney("money", Config.CrashFine)
        end
    end
end)

RegisterServerEvent("aty_busjob:giveSalary", function(salary)
    local src = source
    local xPlayer = Config.Framework == "qb" and Framework.Functions.GetPlayer(src) or Framework.GetPlayerFromId(src)

    if Config.Framework == "qb" then
        xPlayer.Functions.AddMoney("bank", salary, "Bus Job Salary")
    else
        xPlayer.addAccountMoney("bank", salary)
    end
end)