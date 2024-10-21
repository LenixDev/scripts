

GlobalState['Pink'] = {}


Citizen.CreateThread(function()
    exports['oxmysql']:execute("SELECT * FROM `pinkcage`", function(result)
        if result[1] then 
            local ToDay = os.date("%A")
            local CutDay = {
                -- ["Sunday"] = true,
                ["Friday"] = true,
            }

            local Pink = result
            local bag = GlobalState.Pink

            if CutDay[ToDay] then 
                for i = 1, (#Pink), 1 do
                    Wait(100)
                    if tonumber(Pink[i].flag) == 0 then 
                        local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where citizenid = ?', { Pink[i].owner })
                        if tonumber(Pink[i].total) < Config.Pink.TotalRent then 
                            if PlayerData then 
                                PlayerData.money = json.decode(PlayerData.money)
                                if PlayerData.money then 
                                    if tonumber(PlayerData.money.bank) >= Config.Pink.Rent then 
                                        PlayerData.money.bank = PlayerData.money.bank - Config.Pink.Rent
                                        MySQL.Async.prepare('UPDATE players SET money = ? WHERE citizenid = ?', { json.encode(PlayerData.money), Pink[i].owner })
                                        Wait(50)
                                        Pink[i].total += Config.Pink.Rent
                                        MySQL.Async.prepare('UPDATE pinkcage SET flag = ?, total = ? WHERE id = ?', { tonumber('1'), Pink[i].total, Pink[i].id })
    
                                        if Config.Pink.Appartment[Pink[i].id] then 
                                            Config.Pink.Appartment[Pink[i].id].isOwned = true
                                            Config.Pink.Appartment[Pink[i].id].Owner = Pink[i].owner
                                            Config.Pink.Appartment[Pink[i].id].Total = Pink[i].total
                                            if Pink[i].keyholders then 
                                                Pink[i].keyholders = json.decode(Pink[i].keyholders)
                                                for key, holder in pairs(Pink[i].keyholders) do 
                                                    Config.Pink.Appartment[Pink[i].id].KeyHolders[#Config.Pink.Appartment[Pink[i].id].KeyHolders + 1] = {
                                                        name = holder.name,
                                                        cid = holder.cid,
                                                    }
                                                end
                                                bag[Pink[i].id] = {
                                                    KeyHolders = Config.Pink.Appartment[Pink[i].id].KeyHolders
                                                }
                                                GlobalState['Pink'] = bag
                                            end
                                        end
                                    else
                                        MySQL.query("DELETE FROM pinkcage WHERE id = ?", {
                                            Pink[i].id
                                        })
                                    end
                                else
                                    MySQL.query("DELETE FROM pinkcage WHERE id = ?", {
                                        Pink[i].id
                                    })
                                end
                            else
                                MySQL.query("DELETE FROM pinkcage WHERE id = ?", {
                                    Pink[i].id
                                })
                            end
                        elseif tonumber(Pink[i].total) >= Config.Pink.TotalRent then 
                            if Config.Pink.Appartment[Pink[i].id] then 
                                Config.Pink.Appartment[Pink[i].id].isOwned = true
                                Config.Pink.Appartment[Pink[i].id].Owner = Pink[i].owner
                                Config.Pink.Appartment[Pink[i].id].Total = Pink[i].total
                                if Pink[i].keyholders then 
                                    Pink[i].keyholders = json.decode(Pink[i].keyholders)
                                    for key, holder in pairs(Pink[i].keyholders) do 
                                        Config.Pink.Appartment[Pink[i].id].KeyHolders[#Config.Pink.Appartment[Pink[i].id].KeyHolders + 1] = {
                                            name = holder.name,
                                            cid = holder.cid,
                                        }
                                    end
                                    bag[Pink[i].id] = {
                                        KeyHolders = Config.Pink.Appartment[Pink[i].id].KeyHolders
                                    }
                                    GlobalState['Pink'] = bag
                                end
                            end
                        end
                    else
                        if Config.Pink.Appartment[Pink[i].id] then 
                            Config.Pink.Appartment[Pink[i].id].isOwned = true
                            Config.Pink.Appartment[Pink[i].id].Owner = Pink[i].owner
                            Config.Pink.Appartment[Pink[i].id].Total = Pink[i].total
                            if Pink[i].keyholders then 
                                Pink[i].keyholders = json.decode(Pink[i].keyholders)
                                for key, holder in pairs(Pink[i].keyholders) do 
                                    Config.Pink.Appartment[Pink[i].id].KeyHolders[#Config.Pink.Appartment[Pink[i].id].KeyHolders + 1] = {
                                        name = holder.name,
                                        cid = holder.cid,
                                    }
                                end
                                bag[Pink[i].id] = {
                                    KeyHolders = Config.Pink.Appartment[Pink[i].id].KeyHolders
                                }
                                GlobalState['Pink'] = bag
                            end
                        end
                    end
                end
            else
                for i = 1, (#Pink), 1 do
                    Wait(50)
                    if tonumber(Pink[i].flag) == 1 then 
                        MySQL.Async.prepare('UPDATE pinkcage SET flag = ? WHERE id = ?', { tonumber('0'), Pink[i].id })
                    end
                    if Config.Pink.Appartment[Pink[i].id] then 
                        Config.Pink.Appartment[Pink[i].id].isOwned = true
                        Config.Pink.Appartment[Pink[i].id].Owner = Pink[i].owner
                        Config.Pink.Appartment[Pink[i].id].Total = Pink[i].total
                        if Pink[i].keyholders then 
                            Pink[i].keyholders = json.decode(Pink[i].keyholders)
                            for key, holder in pairs(Pink[i].keyholders) do 
                                Config.Pink.Appartment[Pink[i].id].KeyHolders[#Config.Pink.Appartment[Pink[i].id].KeyHolders + 1] = {
                                    name = holder.name,
                                    cid = holder.cid,
                                }
                            end
                            bag[Pink[i].id] = {
                                KeyHolders = Config.Pink.Appartment[Pink[i].id].KeyHolders
                            }
                            GlobalState['Pink'] = bag
                        end
                    end
                end
            end
            Wait(1000)
            TriggerClientEvent('qb-Pink:client:UpdatePink', -1, Config.Pink)
        end
    end)
end)

QBCore.Functions.CreateCallback('qb-Pink:server:GetPinkConfig', function(source, cb)
	cb(Config.Pink)
end)

RegisterNetEvent('qb-Pink:server:RentAppart', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local CanBuy = true
    if Player then 
        local Bank = Player.PlayerData.money.bank
        if Bank then 
            if Bank >= Config.Pink.Rent then 
                Wait(500)
                if not Config.Pink.Appartment[data.appartment].isOwned then 
                    for k, v in pairs(Config.Pink.Appartment) do 
                        if v.Owner == Player.PlayerData.citizenid then 
                            QBCore.Functions.Notify(src, 'You Can\'t Have More Than One Pinkcage Apartment', 'error', 7500)
                            CanBuy = false
                            return
                        end
                    end
                    if CanBuy then 
                        if not Config.Pink.Appartment[data.appartment].isOwned then 
                            if Player.Functions.RemoveMoney('bank', tonumber(Config.Pink.FirstPayment), 'pinkcage-appartmnet-rent') then 
                                Config.Pink.Appartment[data.appartment].isOwned = true
                                Config.Pink.Appartment[data.appartment].Owner = Player.PlayerData.citizenid
                                Config.Pink.Appartment[data.appartment].Total = Config.Pink.FirstPayment
                                Config.Pink.Appartment[data.appartment].KeyHolders = {}
                                Config.Pink.Appartment[data.appartment].KeyHolders[#Config.Pink.Appartment[data.appartment].KeyHolders + 1] = {
                                    name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                                    cid = Player.PlayerData.citizenid,
                                }
                                local bag = GlobalState.Pink
                                bag[data.appartment] = {
                                    KeyHolders = Config.Pink.Appartment[data.appartment].KeyHolders
                                }
                                GlobalState['Pink'] = bag
                                MySQL.Async.insert('INSERT INTO pinkcage (id, owner, keyholders, flag, total) VALUES (:id, :owner, :keyholders, :flag, :total) ON DUPLICATE KEY UPDATE id = :id, owner = :owner, keyholders = :keyholders, flag = :flag, total = :total', {
                                    id = Config.Pink.Appartment[data.appartment].id,
                                    owner = Player.PlayerData.citizenid,
                                    keyholders = json.encode(Config.Pink.Appartment[data.appartment].KeyHolders),
                                    flag = 0,
                                    total = Config.Pink.FirstPayment,
                                })
                                QBCore.Functions.Notify(src, 'You have rented appartment # '..data.appartment..'', 'success', 7500)
                                TriggerClientEvent('qb-Pink:client:UpdatePink', -1, Config.Pink)
                            else
                                QBCore.Functions.Notify(src, 'You don\'t have money', 'error', 7500)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify(src, 'This appartmnet is already sold', 'error', 7500)
                end
            else
                QBCore.Functions.Notify(src, 'You don\'t have money', 'error', 7500)
            end
        end
    end
end)

RegisterNetEvent('qb-Pink:server:Key', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local players = {}
    local MyPed = GetPlayerPed(src)
    local MyCoords = GetEntityCoords(MyPed)
    local QBPlayers = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(QBPlayers) do
        if v.PlayerData.source ~= src then 
            local targetped = GetPlayerPed(v.PlayerData.source)
            local TargetCoords = GetEntityCoords(targetped)
            if #(MyCoords - TargetCoords) <= 7 then 
                players[#players+1] = {
                    name = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname,
                    id = v.PlayerData.source,
                    citizenid = v.PlayerData.citizenid,
                }
            end
        end
    end
    if #players > 0 then 
        TriggerClientEvent('qb-Pink:client:Key', src, data, players)
    else
        QBCore.Functions.Notify(src, 'No One Here', 'error', 7500)
    end
end)

RegisterNetEvent('qb-Pink:server:GiveKey', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Target = QBCore.Functions.GetPlayerByCitizenId(data.cid)
    if Player then 
        if not data then return end
        if not data.id then return end
        if not Config.Pink.Appartment[data.id] then return end
        if Config.Pink.Appartment[data.id].Owner == Player.PlayerData.citizenid then 
            if Target then 
                for key, holder in pairs(Config.Pink.Appartment[data.id].KeyHolders) do 
                    if holder.cid == data.cid then 
                        QBCore.Functions.Notify(src, 'This One Already Have Key', 'error', 7500)
                        return
                    end
                end
                Config.Pink.Appartment[data.id].KeyHolders[#Config.Pink.Appartment[data.id].KeyHolders + 1] = {
                    name = Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname,
                    cid = data.cid,
                }
                local bag = GlobalState.Pink
                bag[data.id] = {
                    KeyHolders = Config.Pink.Appartment[data.id].KeyHolders
                }
                GlobalState['Pink'] = bag
                MySQL.Async.prepare('UPDATE pinkcage SET keyholders = ? WHERE id = ?', { json.encode(Config.Pink.Appartment[data.id].KeyHolders), data.id })
                QBCore.Functions.Notify(src, 'Key Have Been Gived To '..Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname..'', 'success', 7500)
                QBCore.Functions.Notify(Target.PlayerData.source, 'You Got New Key For This Appartment', 'success', 7500)
                TriggerClientEvent('qb-Pink:client:UpdatePink', Target.PlayerData.source, Config.Pink)
            end
        else
            QBCore.Functions.Notify(Target.PlayerData.source, 'You Don\'t Have Access', 'error', 7500)
        end
    end
end)

RegisterNetEvent('qb-Pink:server:RemoveKeyList', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local players = {}
    if Player then 
        if not data then return end
        if not data.id then return end
        if not Config.Pink.Appartment[data.id] then return end
        if Config.Pink.Appartment[data.id].Owner == Player.PlayerData.citizenid then 
            for key, holder in pairs(Config.Pink.Appartment[data.id].KeyHolders) do 
                if holder.cid ~= Player.PlayerData.citizenid then 
                    players[#players+1] = {
                        name = holder.name,
                        citizenid = holder.cid,
                    }
                end
            end
        else
            QBCore.Functions.Notify(Target.PlayerData.source, 'You Don\'t Have Access', 'error', 7500)
        end
        Wait(500)
        if #players > 0 then 
            TriggerClientEvent('qb-Pink:client:RemoveKeyList', src, data, players)
        else
            QBCore.Functions.Notify(src, 'No Key Holders', 'error', 7500)
        end
    end
end)

RegisterNetEvent('qb-Pink:server:Transfer', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local players = {}
    local MyPed = GetPlayerPed(src)
    local MyCoords = GetEntityCoords(MyPed)
    local QBPlayers = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(QBPlayers) do
        if v.PlayerData.source ~= src then 
            local targetped = GetPlayerPed(v.PlayerData.source)
            local TargetCoords = GetEntityCoords(targetped)
            if #(MyCoords - TargetCoords) <= 7 then 
                players[#players+1] = {
                    name = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname,
                    id = v.PlayerData.source,
                    citizenid = v.PlayerData.citizenid,
                }
            end
        end
    end
    if #players > 0 then 
        TriggerClientEvent('qb-Pink:client:Transfer', src, data, players)
    else
        QBCore.Functions.Notify(src, 'No One Here', 'error', 7500)
    end
end)

RegisterNetEvent('qb-Pink:server:TransferConfirm', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayerByCitizenId(data.cid)
    if Target then 
        data.Or = ''..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..''
        data.Owner = Player.PlayerData.citizenid
        TriggerClientEvent('qb-Pink:client:TransferConfirm', Target.PlayerData.source, data)
    end
end)

RegisterNetEvent('qb-Pink:server:TransferAccept', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player then 
        if not data then return end
        if not data.id then return end
        if not Config.Pink.Appartment[data.id] then return end
        local Target = QBCore.Functions.GetPlayerByCitizenId(data.Owner)
        if Target then 
            if Config.Pink.Appartment[data.id].Owner == Target.PlayerData.citizenid then 
                for k, v in pairs(Config.Pink.Appartment) do 
                    if v.Owner == Player.PlayerData.citizenid then 
                        QBCore.Functions.Notify(src, 'You Can\'t Have More Than One Pinkcage Apartment', 'error', 7500)
                        QBCore.Functions.Notify(Target.PlayerData.source, 'Can not transferred to this person', 'error', 7500)
                        CanBuy = false
                        return
                    end
                end
                Config.Pink.Appartment[data.id].Owner = Player.PlayerData.citizenid
                Config.Pink.Appartment[data.id].KeyHolders = {}
                Config.Pink.Appartment[data.id].KeyHolders[#Config.Pink.Appartment[data.id].KeyHolders + 1] = {
                    name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                    cid = Player.PlayerData.citizenid,
                }
                local bag = GlobalState.Pink
                bag[data.id] = {
                    KeyHolders = Config.Pink.Appartment[data.id].KeyHolders
                }
                GlobalState['Pink'] = bag
                MySQL.Async.prepare('UPDATE pinkcage SET owner = ?, keyholders = ? WHERE id = ?', {
                    Player.PlayerData.citizenid,
                    json.encode(Config.Pink.Appartment[data.id].KeyHolders),
                    data.id 
                })
                QBCore.Functions.Notify(src, 'Apartment have been transferred', 'success', 7500)
                QBCore.Functions.Notify(Target.PlayerData.source, 'Apartment have been transferred', 'success', 7500)
                TriggerClientEvent('qb-Pink:client:UpdatePink', -1, Config.Pink)
            end
        end
    end
end)

RegisterNetEvent('qb-Pink:server:Cancel', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local players = {}
    if Player then 
        if not data then return end
        if not data.id then return end
        if not Config.Pink.Appartment[data.id] then return end
        if Config.Pink.Appartment[data.id].Owner == Player.PlayerData.citizenid then 
            Config.Pink.Appartment[data.id].isOwned = false
            Config.Pink.Appartment[data.id].Owner = nil
            Config.Pink.Appartment[data.id].Total = 0
            Config.Pink.Appartment[data.id].KeyHolders = {}
            local bag = GlobalState.Pink
            bag[data.id] = nil
            GlobalState['Pink'] = bag
            MySQL.query("DELETE FROM pinkcage WHERE id = ?", {
                data.id
            })
            QBCore.Functions.Notify(src, 'You have canceled your apartment # '..data.id..' contract', 'success', 7500)
            TriggerClientEvent('qb-Pink:client:UpdatePink', -1, Config.Pink)
        end
    end
end)

RegisterNetEvent('qb-Pink:server:RemoveKey', function(data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player then 
        if not data then return end
        if not data.id then return end
        if not Config.Pink.Appartment[data.id] then return end
        if Config.Pink.Appartment[data.id].Owner == Player.PlayerData.citizenid then 
            for key, holder in pairs(Config.Pink.Appartment[data.id].KeyHolders) do 
                if holder.cid == data.cid then 
                    table.remove(Config.Pink.Appartment[data.id].KeyHolders, key)
                    local bag = GlobalState.Pink
                    bag[data.id] = {
                        KeyHolders = Config.Pink.Appartment[data.id].KeyHolders
                    }
                    GlobalState['Pink'] = bag
                    MySQL.Async.prepare('UPDATE pinkcage SET keyholders = ? WHERE id = ?', { json.encode(Config.Pink.Appartment[data.id].KeyHolders), data.id })
                    QBCore.Functions.Notify(src, 'Key Removed Key Ftom '..data.name..'', 'success', 7500)
                    local Target = QBCore.Functions.GetPlayerByCitizenId(data.cid)
                    if Target then 
                        QBCore.Functions.Notify(Target.PlayerData.source, 'Your Key For Pinkcage Appartment # '..data.id..' Have Been Removed By Owner', 'warning', 7500)
                        TriggerClientEvent('qb-Pink:client:UpdatePink', Target.PlayerData.source, Config.Pink)
                    end
                    return
                end
            end
        else
            QBCore.Functions.Notify(Target.PlayerData.source, 'You Don\'t Have Access', 'error', 7500)
        end
    end
end)