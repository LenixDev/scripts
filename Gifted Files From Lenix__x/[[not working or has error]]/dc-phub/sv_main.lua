local QBCore = exports['qb-core']:GetCoreObject()
local dispatchCID = nil
local commanderCID = nil
local breakedOfficers = {}

local function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end

RegisterNetEvent('qb-phub:server:refresh', function(JobName)
    local src = source
    -- local Player = QBCore.Functions.GetPlayer(src)
    local data = {}
    local count = 0
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local xPlayer = QBCore.Functions.GetPlayer(v)
        if xPlayer then
            if xPlayer.PlayerData.job.name == JobName then
                data[xPlayer.PlayerData.citizenid] = {
                    Break = GetUnits(xPlayer.PlayerData.citizenid, 'break'),
                    Duty = xPlayer.PlayerData.job.onduty,
                    Radio = GetRadioChannel(v) or '?',
                    OfficerName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname,
                    CallSign = xPlayer.PlayerData.metadata.callsign,
                    CitizenId = xPlayer.PlayerData.citizenid,
                }
                TriggerClientEvent('qb-phub:client:refresh', -1, data, getTableSize(data),
                    GetUnits(xPlayer.PlayerData.citizenid, 'dispatch'),
                    GetUnits(xPlayer.PlayerData.citizenid, 'commander'))
            end
        end
    end
end)

RegisterNetEvent('qb-phub:server:openhub', function()
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local src = source
    if xPlayer then
        if xPlayer.PlayerData.job.name == "police" then
    TriggerClientEvent('qb-phub:client:open', src, 'toggle')
    end
end
end)

RegisterNetEvent('qb-phub:client:break', function(isit)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if isit then
        breakedOfficers[Player.PlayerData.citizenid] = true
        if dispatchCID == Player.PlayerData.citizenid then
            dispatchCID = nil
        elseif commanderCID == Player.PlayerData.citizenid then
            commanderCID = nil
        end
        Player.Functions.SetJobDuty(false)
    else
        breakedOfficers[Player.PlayerData.citizenid] = false
        Player.Functions.SetJobDuty(true)
    end
    Wait(50)
    TriggerEvent('qb-phub:server:refresh', Player.PlayerData.job.name)
end)

RegisterNetEvent('qb-phub:cl:changecallsign', function(callsign)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", callsign)
    Wait(50)
    TriggerEvent('qb-phub:server:refresh', Player.PlayerData.job.name)
end)

RegisterNetEvent('qb-phub:client:dispatch', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Dispatch = QBCore.Functions.GetPlayerByCitizenId(dispatchCID)
    if dispatchCID ~= Player.PlayerData.citizenid then
        if not dispatchCID or dispatchCID == nil and not Dispatch then
            dispatchCID = Player.PlayerData.citizenid
        else
            TriggerClientEvent('QBCore:Notify', source, Dispatch.PlayerData.charinfo.firstname .. ' ' .. Dispatch.PlayerData.charinfo.lastname .. ' Is The Dispatch Now', 'error')
        end
    else
        dispatchCID = nil
    end
    Wait(50)
    TriggerEvent('qb-phub:server:refresh', Player.PlayerData.job.name)
end)

RegisterNetEvent('qb-phub:client:commander', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Commander = QBCore.Functions.GetPlayerByCitizenId(commanderCID)
    if commanderCID ~= Player.PlayerData.citizenid then
        if not commanderCID or commanderCID == nil and not Commander then
            commanderCID = Player.PlayerData.citizenid
        else
            TriggerClientEvent('QBCore:Notify', source, Commander.PlayerData.charinfo.firstname .. ' ' .. Commander.PlayerData.charinfo.lastname .. ' Is The Commander Now', 'error')
        end
    else
        commanderCID = nil
    end
    Wait(50)
    TriggerEvent('qb-phub:server:refresh', Player.PlayerData.job.name)
end)

function GetRadioChannel(source)
    if Player(source).state['radioChannel'] then
        return Player(source).state['radioChannel']
    else
        return '?'
    end
end

function GetUnits(cid, type)
    local src = source
    local Player = QBCore.Functions.GetPlayerByCitizenId(cid)
    if type == 'dispatch' and cid == dispatchCID then
        return cid
    end
    if type == 'commander' and cid == commanderCID then
        return cid
    end
    if type == 'break' then
        if breakedOfficers[cid] == true then
            return true
        end
    end
    return false
end
