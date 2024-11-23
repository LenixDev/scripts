local QBCore = exports['qb-core']:GetCoreObject()

local OfficersArray = {}
local Table = {}
local dispatch = nil

AddEventHandler('playerDropped', function(reason)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        if xPlayer.PlayerData.job.name == "police" then
            Wait(250)
            TriggerEvent('qb-policelist:server:ref', -1)
        end
    end
end)


RegisterServerEvent('qb-policehub:server:policejoined')
AddEventHandler('qb-policehub:server:policejoined', function()
    Wait(250)
    TriggerEvent('qb-policelist:server:ref', -1)
end)

RegisterServerEvent('qb-policehub:server:changeCallsign')
AddEventHandler('qb-policehub:server:changeCallsign', function(data)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local fullname = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    for k, v in pairs(OfficersArray) do
        for t, i in ipairs(v) do
            if i.name == fullname then
                if i.source == xPlayer.PlayerData.source then
                    i.callSign = data
                    xPlayer.Functions.SetMetaData("callsign", data)
                end
            end
        end
    end
    TriggerEvent('qb-policelist:server:ref', -1)
end)

RegisterServerEvent('qb-policehub:server:policeremove')
AddEventHandler('qb-policehub:server:policeremove', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        if xPlayer.PlayerData.job.name == "police" then
            TriggerEvent('qb-policelist:server:ref', -1)
        end
    end
end)

QBCore.Functions.CreateCallback('qb-policehub:server:GetPlayerLocation', function(source, cb, id)
    local playerPed = GetPlayerPed(id)
    local location = GetEntityCoords(playerPed)

    cb(location)
end)


function GetRadioChannel(source)
    if Player(source).state['radioChannel'] ~= nil then
        return Player(source).state['radioChannel']
    end
    return 0
end

RegisterNetEvent('qb-policehub:server:updatestatus', function(status)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if not xPlayer then return end
    local fullname = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    for k, v in pairs(OfficersArray) do
        for t, i in ipairs(v) do
            if i.name == fullname then
                if i.source == xPlayer.PlayerData.source then
                    i.duty = status
                    xPlayer.Functions.SetJobDuty(status)
                end
            end
        end
    end
    if status == false then
        TriggerClientEvent(Config.NotifyEvent, src, 'You are now off duty!')
    else
        TriggerClientEvent(Config.NotifyEvent, src, 'You are now on duty!')
    end
    TriggerClientEvent(Config.SetDutyEvent, src, xPlayer.PlayerData.job.onduty)
    Wait(250)
    TriggerEvent('qb-policelist:server:ref', -1)
end)

RegisterNetEvent('qb-policehub:server:updateDispatch', function(status)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if not xPlayer then return end
    local fullname = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    if dispatch then
        TriggerEvent('QBCore:Notify', 'There is a dispatch already', 'error')
    end
    for k, v in pairs(OfficersArray) do
        for t, i in ipairs(v) do
            if i.name == fullname then
                if i.source == xPlayer.PlayerData.source then
                    if status == true then
                        dispatch = fullname
                    else
                        dispatch = nil
                    end
                end
            end
        end
    end
    Wait(250)
    TriggerEvent('qb-policelist:server:ref', -1)
end)

RegisterNetEvent('PlayerSendRequest', function(data)
    TriggerClientEvent('PlayerSendRequest', data.playerid, data.text)
end)

RegisterNetEvent('qb-policelist:server:ref', function(_, cb)
    local policeCount = {}
    OfficersArray = {}
    Table = {}
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v and v.PlayerData.job.name == "police" then
            policeCount[#policeCount + 1] = {
                ['radio'] = GetRadioChannel(v.PlayerData.source),
                ['inVehicle'] = false,
                ['gender'] = 0,
                ['dispatch'] = isDispatch(v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname),
                ['name'] = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname,
                ['callSign'] = v.PlayerData.metadata.callsign,
                ['source'] = v.PlayerData.source,
                ['dutyColor'] = GetColor(v.PlayerData.job.onduty),
                ['y'] = GetEntityCoords(GetPlayerPed(v.PlayerData.source), true).x,
                ['x'] = GetEntityCoords(GetPlayerPed(v.PlayerData.source), true).x,
                ['gradeName'] = v.PlayerData.job.grade.name,
            }
        end
    end
    Wait(250)
    table.insert(OfficersArray, policeCount)
    TriggerClientEvent('qb-policehub:client:datanewplayer', -1, policeCount)
end)


local camPlayers = {}

RegisterNetEvent('messy:camstatus')
AddEventHandler('messy:camstatus', function(ison)
    local src = source
    if camPlayers[source] == nil then
        camPlayers[source] = true
        TriggerClientEvent(Config.NotifyEvent, src, "Bodycam Turned On", "success")
        TriggerClientEvent("bcam:UpdateWatch", -1, camPlayers)
    else
        camPlayers[source] = not camPlayers[source]
        if camPlayers[source] then
            TriggerClientEvent(Config.NotifyEvent, src, "Bodycam Turned On", "success")
            TriggerClientEvent("bcam:UpdateWatch", -1, camPlayers)
        else
            TriggerClientEvent(Config.NotifyEvent, src, "Bodycam Turned Off", "success")
            TriggerClientEvent("bcam:UpdateWatch", -1, camPlayers)
        end
    end
end)

QBCore.Functions.CreateCallback('bcam:getplayers', function(source, cb, arg)
    cb(QBCore.Functions.GetPlayers())
end)

QBCore.Functions.CreateCallback('bcam:getplayer', function(source, cb, arg)
    local tped = GetPlayerPed(arg)
    cb({ targetped = tped, coords = GetEntityCoords(tped), pednid = NetworkGetNetworkIdFromEntity(tped) })
end)

QBCore.Functions.CreateCallback('bcam:getpopos', function(source, cb)
    local popos = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v and v.PlayerData.job.name == "police" then
            popos[#popos + 1] = {
                name = v.PlayerData.name,
                fname = v.PlayerData.charinfo.firstname,
                lname = v.PlayerData.charinfo.lastname,
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name,
                camon = camPlayers[v.PlayerData.source]
            }
        end
    end
    cb(popos)
end)


QBCore.Functions.CreateCallback('get time data', function(source, cb)
    local startLua = tostring(os.time()):sub(-10)
    local milliseconds = tostring(os.time()):sub(-3)

    cb(tonumber(startLua .. milliseconds))
end)

GetColor = function(duty)
    if duty == true then
        return 'green'
    else
        return 'red'
    end
end

isDispatch = function(name)
    if name == dispatch then
        return true
    end
end
