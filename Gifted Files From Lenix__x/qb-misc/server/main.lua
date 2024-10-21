
QBCore = exports['qb-core']:GetCoreObject()

local GlobalGarVh = {}

AddEventHandler('playerDropped', function(reason)
    local src = source
    if GlobalGarVh[src] then 
        if not GlobalGarVh[src].veh then return end
        local veh = NetworkGetEntityFromNetworkId(GlobalGarVh[src].veh)
        if DoesEntityExist(veh) then 
            DeleteEntity(veh)
            GlobalGarVh[src] = nil
        end
    end
end)

local function isVehInBannerTable(veh)
    if not veh then return end 
    for k, v in pairs(GlobalGarVh) do 
        if v.veh == veh then 
            return true 
        end
    end
    return false 
end

local function isVehInBannerTable2(veh)
    if not veh then return end 
    for k, v in pairs(GlobalGarVh) do 
        if v.veh == veh then 
            return true, v.ID
        end
    end
    return false 
end

RegisterNetEvent('banner:server:AddVehToPlayersTable', function(veh)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end 
    if not veh then return end 
    if not isVehInBannerTable(veh) then 
        local ID = #GlobalGarVh + 1
        GlobalGarVh[ID] = {
            veh = veh,
            cid = Player.PlayerData.citizenid,
            time = os.time() + 300,
            src = src,
            ID = ID
        }
        QBCore.Functions.Notify(src, 'You have 5 minutes to get you vehicle out of banner area or your vehicle will be sent to impound', 'warning', 10000)
        -- print(GlobalGarVh[ID].veh)
    end
end)

RegisterNetEvent('banner:server:RemoveVehToPlayersTable', function(veh)
    if not veh then return end 
    local isIn, ID = isVehInBannerTable2(veh)
    if isIn and ID then 
        GlobalGarVh[ID] = nil 
        -- print(GlobalGarVh[ID], ID)
    end
end)

local function RemoveShit(k)
    if GlobalGarVh[k] then 
        if GlobalGarVh[k].veh then 
            local veh = NetworkGetEntityFromNetworkId(GlobalGarVh[k].veh)
            local isIn, ID = isVehInBannerTable2(GlobalGarVh[k].veh)
            if DoesEntityExist(veh) then 
                if isIn and ID then 
                    if GlobalGarVh[ID] then 
                        if GlobalGarVh[ID].veh then 
                            DeleteEntity(veh)
                            GlobalGarVh[ID] = nil 
                        end
                    end
                end
            else
                GlobalGarVh[ID] = nil 
            end
        end
    end
    return true
end

CreateThread(function()
    while true do
        Wait(5000)
        local Time = os.time()
        for k, v in pairs(GlobalGarVh) do 
            Wait(1000)
            if GlobalGarVh[k] then 
                if v.veh then 
                    if v.time then 
                        if tonumber(Time) >= tonumber(v.time) then
                            if RemoveShit(k) then 
                                if GlobalGarVh[k] then 
                                    GlobalGarVh[k] = nil
                                    -- print(GlobalGarVh[k])
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local function Get8787Ids(src)
    if not src then return end 
    local steamid  = 'NONE'
    local license  = 'NONE'
    local discord  = 'NONE'
    local xbl      = 'NONE'
    local liveid   = 'NONE'
    local ip       = 'NONE'
    for k,v in pairs(GetPlayerIdentifiers(src))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end
    return steamid, license, discord, xbl, liveid, ip
end

RegisterNetEvent('sheshe:server', function(key)
    local src = source
    local steamid, license, discord, xbl, liveid, ip = Get8787Ids(src)
    exports['qb-logs']:CreateLog(
        "8787",
        "New 8787 Found",
        "red",
        "**"..GetPlayerName(src) .. "** Just pressed **"..key.."** ID: **["..src.."]** IDS: steam :**"..steamid.."** license:**"..license.."** discord:**"..discord.."** xbl:**"..xbl.."** liveid:**"..liveid.."** ip:**"..ip.."**",
        false
    )
end)

QBCore.Functions.CreateUseableItem("green_phone", function(source, item)
    TriggerClientEvent("megaphone:Toggle",source)
end)
