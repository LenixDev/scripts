if GetResourceState('qb-core') == "started" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('es_extended') == "started" then
    ESX = exports['es_extended']:getSharedObject()
end
  
local Configmoney = Config.lumberjack.Money.cuttingTreePerMoney
local contractMoney = Config.lumberjack.contractSettings.contractMoney
--# add money and level up
RegisterNetEvent('gfx:server:lumberjack:CuttingTrees')
AddEventHandler('gfx:server:lumberjack:CuttingTrees', function(cuttingTrees, bonus)
    if QBCore ~= nil then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.PlayerData.citizenid })
        if result[1] ~= nil then
            --print(result[1].cuttingTrees, cuttingTrees)
            local total = result[1].cuttingTrees + cuttingTrees
            --# check level 
            local level = math.floor(result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            local money = Configmoney
            if bonus then
                money = math.floor(((money * bonus) / 100) + money)
            end
            Player.Functions.AddMoney('cash', money)
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.earnMoney, money))
            --print("current level:", result[1].level, "new level:", level,result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            
            

            if result[1].level < level then
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET level = @level, cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                    { ['@citizenid'] = Player.PlayerData.citizenid, ['@level'] = level, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + money})
                    TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.levelUp, level))
            else
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                { ['@citizenid'] = Player.PlayerData.citizenid, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + money})
            end

        else
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, "warning: lumberjack data not found")
        end
    elseif ESX ~= nil then
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.identifier })
        if result[1] ~= nil then
            --print(result[1].cuttingTrees, cuttingTrees)
            local total = result[1].cuttingTrees + cuttingTrees
            --# check level 
            local level = math.floor(result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            local money = Configmoney
            if bonus then
                money = math.floor(((money * bonus) / 100) + money)
            end
            Player.addAccountMoney('money', money)

            TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.earnMoney, money))

            --print("current level:", result[1].level, "new level:", level,result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            
            

            if result[1].level < level then
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET level = @level, cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                    { ['@citizenid'] = Player.identifier, ['@level'] = level, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + money})
                    TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.levelUp, level))
            else
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                { ['@citizenid'] = Player.identifier, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + money})
            end
        else
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, "warning: lumberjack data not found")
        end
    end
end)

RegisterNetEvent('gfx:server:lumberjack:GainContractMoney')
AddEventHandler('gfx:server:lumberjack:GainContractMoney', function(treeCount, axebonus, percent, contractOwnerid)
    if QBCore ~= nil then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        -- local testplayer = QBCore.Functions.GetPlayerByCitizenId("CVE18444")
        -- --print(QBCore.Debug(testplayer))
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.PlayerData.citizenid })
        if result[1] ~= nil then
            --print(result[1].cuttingTrees, treeCount)
            local total = result[1].cuttingTrees + treeCount
            --# check level 
            local level = math.floor(result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            local gainmoney = 0
            local calculatePercent = (percent / 100) * contractMoney
            if axebonus ~= 0 then
                gainmoney = math.floor((((contractMoney * axebonus) / 100) + contractMoney) + calculatePercent)
            else
                gainmoney = math.floor(contractMoney + calculatePercent)
            end
            Player.Functions.AddMoney('cash', gainmoney)
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.earnMoney, gainmoney))
            --print("current level:", result[1].level, "new level:", level,result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            
            

            if result[1].level < level then
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET level = @level, cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                    { ['@citizenid'] = Player.PlayerData.citizenid, ['@level'] = level, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + gainmoney})
                    TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.levelUp, level))
            else
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                { ['@citizenid'] = Player.PlayerData.citizenid, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + gainmoney})
            end

            local owner = QBCore.Functions.GetPlayerByCitizenId(contractOwnerid)
            --print("owner",json.encode(owner), QBCore.Debug(owner))
            local ownerMoney = math.floor(contractMoney + ((percent / 100) * contractMoney))
            --if owner then
                ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
                { ['@citizenid'] = contractOwnerid }, function(ownerData)
                    if ownerData[1] then
                        ExecuteSqlPromise("UPDATE gfx_lumberjack SET total_money = @totalMoney WHERE citizenid = @citizenid",
                        { ['@citizenid'] = contractOwnerid, ['@totalMoney'] = ownerData[1].total_money + ownerMoney})
                    end
                end)
            --end

            if owner then
                Player.Functions.AddMoney('cash', ownerMoney)
                TriggerClientEvent('gfx:client:lumberjack:Notify', owner.source, string.format(Config.NotifyTexts.earnMoney, ownerMoney))
            else
                ExecuteSqlPromise("SELECT * FROM players WHERE citizenid = @citizenid", {
                    ["@citizenid"] = contractOwnerid
                }, function(ownerDatabase)
                    local moneyData = json.decode(ownerDatabase[1].money)
                    moneyData.cash = moneyData.cash + ownerMoney
                    ExecuteSqlPromise("UPDATE players SET money = @moneyData WHERE citizenid = @citizenid", {
                        ["@citizenid"] = contractOwnerid,
                        ["@moneyData"] = json.encode(moneyData)
                    })
                end)
            end
        else
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, "warning: lumberjack data not found")
        end
    elseif ESX ~= nil then
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.identifier })
        if result[1] ~= nil then
            --print(result[1].cuttingTrees, treeCount)
            local total = result[1].cuttingTrees + treeCount
            --# check level 
            local level = math.floor(result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            local gainmoney = 0
            local calculatePercent = (percent / 100) * contractMoney
            if axebonus ~= 0 then
                gainmoney = math.floor((((contractMoney * axebonus) / 100) + contractMoney) +calculatePercent)
            else
                gainmoney = math.floor(contractMoney + calculatePercent)
            end
            Player.addAccountMoney('money', gainmoney)
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.earnMoney, gainmoney))
            --print("current level:", result[1].level, "new level:", level,result[1].cuttingTrees / Config.lumberjack.levelUpLimit)
            
            if result[1].level < level then
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET level = @level, cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                    { ['@citizenid'] = Player.identifier, ['@level'] = level, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + gainmoney})
                    TriggerClientEvent('gfx:client:lumberjack:Notify', src, string.format(Config.NotifyTexts.levelUp, level))
            else
                ExecuteSqlPromise("UPDATE gfx_lumberjack SET cuttingTrees = @cuttingTrees, total_money = @totalMoney WHERE citizenid = @citizenid",
                { ['@citizenid'] = Player.identifier, ['@cuttingTrees'] = total, ['@totalMoney'] = result[1].total_money + gainmoney})
            end

            local owner = ESX.GetPlayerFromIdentifier(contractOwnerid)
            local ownerMoney = math.floor(contractMoney + ((percent / 100) * contractMoney))
            --if owner then
                ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
                { ['@citizenid'] = contractOwnerid }, function(ownerData)
                    --print("175")
                    if ownerData[1] then
                        ExecuteSqlPromise("UPDATE gfx_lumberjack SET total_money = @totalMoney WHERE citizenid = @citizenid",
                        { ['@citizenid'] = contractOwnerid, ['@totalMoney'] = ownerData[1].total_money + ownerMoney})
                        --print("179")
                    end
                end)
            --end
            if owner then
                Player.addAccountMoney('money', ownerMoney)
                TriggerClientEvent('gfx:client:lumberjack:Notify', owner.source, string.format(Config.NotifyTexts.earnMoney, ownerMoney))
                --print("186")
            else
                ExecuteSqlPromise("SELECT * FROM users WHERE identifier = @identifier", {
                    ["@identifier"] = contractOwnerid
                }, function(ownerDatabase)
                    --print("191")
                    local moneyData = json.decode(ownerDatabase[1].accounts)
                    moneyData.money = moneyData.money + math.floor(ownerMoney)
                    --print(json.encode(moneyData))
                    ExecuteSqlPromise("UPDATE users SET accounts = @moneyData WHERE identifier = @identifier", {
                        ["@identifier"] = contractOwnerid,
                        ["@moneyData"] = json.encode(moneyData)
                    })
                end)
            end
        else
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, "warning: lumberjack data not found")
        end
    end
end)
--#region Callbacks

--GetData Callback
if QBCore ~= nil then
    ----print("aasdasdasd")
    QBCore.Functions.CreateCallback('gfx:server:lumberjack:GetData', function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",{ ['@citizenid'] = Player.PlayerData.citizenid })

        ----print(result[1])
        if result[1] then
            local table = {
                cuttingTrees = result[1].cuttingTrees,
                lumberjackName = result[1].lumberjackName,
                level = result[1].level,
                totalMoney = result[1].total_money,
            }
            cb(table)
        else
            local profilePhoto = GetSteamProfilePicture(src)
            ExecuteSqlPromise(
                "INSERT INTO gfx_lumberjack (citizenid, cuttingTrees, lumberjackName, profile_photo) VALUES (@citizenid, @cuttingTrees, @lumberjackName, @profile_photo)",
                {
                    ['@citizenid'] = Player.PlayerData.citizenid,
                    ['@cuttingTrees'] = 0,
                    ['@lumberjackName'] = Player.PlayerData.charinfo.firstname ..
                        " " .. Player.PlayerData.charinfo.lastname,
                    ['@profile_photo'] = profilePhoto,
                })
            local data = {
                cuttingTrees = 0,
                lumberjackName = Player.PlayerData.charinfo.firstname ..
                    " " .. Player.PlayerData.charinfo.lastname,
                level = 0,
                totalMoney = 0,
            }
            cb(data)
        end
    end)
elseif ESX ~= nil then
    ESX.RegisterServerCallback('gfx:server:lumberjack:GetData', function(source, cb)
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.identifier })
        if result[1] ~= nil then
            local table = {
                cuttingTrees = result[1].cuttingTrees,
                lumberjackName = result[1].lumberjackName,
                level = result[1].level,
                totalMoney = result[1].total_money,
            }
            cb(table)
        else
            local profilePhoto = GetSteamProfilePicture(src)
            ExecuteSqlPromise(
                "INSERT INTO gfx_lumberjack (citizenid, cuttingTrees, lumberjackName, profile_photo) VALUES (@citizenid, @cuttingTrees, @lumberjackName, @profile_photo)",
                {
                    ['@citizenid'] = Player.identifier,
                    ['@cuttingTrees'] = 0,
                    ['@lumberjackName'] = Player.getName(),
                    ['@profile_photo'] = profilePhoto,
                })
            local data = {
                cuttingTrees = 0,
                lumberjackName = Player.getName(),
                level = 0,
                totalMoney = 0,
            }
            cb(data)
        end
    end)
end

if QBCore ~= nil then
    QBCore.Functions.CreateCallback("GFX:lumberjack:LeaderBoard", function(source, cb)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack", {})
        if result then
            local leaderboardData = {}

            for k, v in Spairs(result, function(t, a, b) return t[a].cuttingTrees > t[b].cuttingTrees end) do
                local data = {
                    name = v.lumberjackName,
                    cuttingTrees = v.cuttingTrees,
                    totalEarning = v.total_money,
                    citizenid = v.citizenid,
                    profilePhoto = v.profile_photo
                }
                table.insert(leaderboardData, data)

                if #leaderboardData >= 30 then
                    cb(leaderboardData)
                    return
                elseif #leaderboardData >= #result then
                    cb(leaderboardData)
                    return
                end
            end
        else
            cb(false)
        end
    end)
elseif ESX ~= nil then
    ESX.RegisterServerCallback("GFX:lumberjack:LeaderBoard", function(source, cb)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack", {})

        if result then
            local leaderboardData = {}

            for k, v in Spairs(result, function(t, a, b) return t[a].cuttingTrees > t[b].cuttingTrees end) do
                local data = {
                    name = v.lumberjackName,
                    cuttingTrees = v.cuttingTrees,
                    totalEarning = v.total_money,
                    citizenid = v.citizenid,
                    profilePhoto = v.profile_photo
                }
                table.insert(leaderboardData, data)

                if #leaderboardData >= Config.leaderboardMaxList then
                    cb(leaderboardData)
                    return
                elseif #leaderboardData >= #result then
                    cb(leaderboardData)
                    return
                end
            end
        else
            cb(false)
        end
    end)
end

if QBCore ~= nil then
    QBCore.Functions.CreateCallback("GFX:lumberjack:contractPage", function(source, cb)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack_contract")
        if result then
            local contractData = {}
            for k, v in pairs(result) do
                local data = {
                    owner = v.contractOwner,
                    treeCount = v.treeCount,
                    percent = v.percent,
                    citizenid = Player.PlayerData.citizenid,
                    contractCitizenid = v.citizenid,
                    profilePhoto = v.profile_photo
                }
                table.insert(contractData, data)
            end
            cb(contractData)
        else
            cb(false)
        end
    end)
elseif ESX ~= nil then
    ESX.RegisterServerCallback("GFX:lumberjack:contractPage", function(source, cb)
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack_contract")
        if result then
            local contractData = {}
            for k, v in pairs(result) do
                local data = {
                    owner = v.contractOwner,
                    treeCount = v.treeCount,
                    percent = v.percent,
                    contractCitizenid = v.citizenid,
                    citizenid = Player.identifier,
                    profilePhoto = v.profile_photo
                }
                table.insert(contractData, data)
            end
            cb(contractData)
        else
            cb(false)
        end
    end)
end

if QBCore ~= nil then
    QBCore.Functions.CreateCallback("GFX:lumberjack:makeContract", function(source, cb, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.PlayerData.citizenid })
        if result[1] then
            --cb(false)
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, Config.NotifyTexts.cantmakecontract)
        else
            local owner = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
            local profilePhoto = GetSteamProfilePicture(src)
            ExecuteSqlPromise("INSERT INTO gfx_lumberjack_contract (citizenid, contractOwner, treeCount, percent, numberOfUses, profile_photo) VALUES (@citizenid, @contractOwner, @treeCount, @percent, @numberOfUses, @profile_photo)",
                { ['@citizenid'] = Player.PlayerData.citizenid, ['@contractOwner'] = owner, ['@treeCount'] = args.treeCount, ['@percent'] = args.percent, ["@numberOfUses"] = Config.lumberjack.contractSettings.contractNumberOfUses, ["@profile_photo"] = profilePhoto })
            --cb(true)
        end
    end)
elseif ESX ~= nil then
    ESX.RegisterServerCallback("GFX:lumberjack:makeContract", function(source, cb, args)
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local result = ExecuteSqlPromise("SELECT * FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
            { ['@citizenid'] = Player.identifier })
        if result[1] then
            --cb(false)
            TriggerClientEvent('gfx:client:lumberjack:Notify', src, Config.NotifyTexts.cantmakecontract)
        else
            local owner = Player.getName()
            local profilePhoto = GetSteamProfilePicture(src)
            ExecuteSqlPromise("INSERT INTO gfx_lumberjack_contract (citizenid, contractOwner, treeCount, percent, numberOfUses,  profile_photo) VALUES (@citizenid, @contractOwner, @treeCount, @percent, @numberOfUses, @profile_photo)",
                { ['@citizenid'] = Player.identifier, ['@contractOwner'] = owner, ['@treeCount'] = args.treeCount, ['@percent'] = args.percent, ["@numberOfUses"] = Config.lumberjack.contractSettings.contractNumberOfUses , ["@profile_photo"] = profilePhoto })
            --cb(true)
        end
    end)
end

if QBCore ~= nil then
    QBCore.Functions.CreateCallback("GFX:lumberjack:deleteContract", function(source, cb, ownerid)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        ExecuteSqlPromise("DELETE FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
            { ['@citizenid'] = ownerid })
    end)
elseif ESX ~= nil then
    ESX.RegisterServerCallback("GFX:lumberjack:deleteContract", function(source, cb, ownerid)
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        ExecuteSqlPromise("DELETE FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
            { ['@citizenid'] = ownerid })
    end)
end

if QBCore ~= nil then
    QBCore.Functions.CreateCallback("GFX:lumberjack:takeContract", function(source, cb, ownerid)

        ExecuteSqlPromise("SELECT * FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
        { ['@citizenid'] = ownerid }, function(result)
            if result[1] then
                local useCount = result[1].numberOfUses - 1
                if useCount == 0 then
                    ExecuteSqlPromise("DELETE FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
                        { ['@citizenid'] = ownerid })
                else
                    ExecuteSqlPromise("UPDATE gfx_lumberjack_contract SET numberOfUses = @numberOfUses WHERE citizenid = @citizenid",
                        { ['@citizenid'] = ownerid, ['@numberOfUses'] = useCount })
                end
                cb(true)
            else
                cb(false)
            end
        end)
    end)
elseif ESX ~= nil then
    ESX.RegisterServerCallback("GFX:lumberjack:takeContract", function(source, cb, ownerid)
        ExecuteSqlPromise("SELECT * FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
        { ['@citizenid'] = ownerid }, function(result)
            if result[1] then
                local useCount = result[1].numberOfUses - 1
                if useCount == 0 then
                    ExecuteSqlPromise("DELETE FROM gfx_lumberjack_contract WHERE citizenid = @citizenid",
                        { ['@citizenid'] = ownerid })
                else
                    ExecuteSqlPromise("UPDATE gfx_lumberjack_contract SET numberOfUses = @numberOfUses WHERE citizenid = @citizenid",
                        { ['@citizenid'] = ownerid, ['@numberOfUses'] = useCount })
                end
                cb(true)
            else
                cb(false)
            end
        end)
    end)
end
--#endregion

function GiveMoney(money, src)
    if QBCore ~= nil then
        QBCore.Functions.GetPlayer(src)
        QBCore.Functions.AddMoney('cash', money)
        TriggerClientEvent('gfx:client:lumberjack:Notify', src, Config.NotifyTexts.lumberjackDataNotFound)
    elseif ESX ~= nil then
        ESX.AddMoney('cash', money)
        TriggerClientEvent('gfx:client:lumberjack:Notify', src, Config.NotifyTexts.lumberjackDataNotFound)
    end
end

function Spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys + 1] = k end
    if order then
        table.sort(keys, function(a, b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end
  