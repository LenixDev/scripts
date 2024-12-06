local QBCore = exports['qb-core']:GetCoreObject()
GlobalInfo = {}

Citizen.CreateThread(function()
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        local citizenid = Player.PlayerData.citizenid
        local fullname = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ''
        local callsign = Player.PlayerData.metadata.callsign
		if Config and Config.UseRadio then
			GlobalInfo[v].radio_channel = 0
		end
		TriggerClientEvent('cd_dispatch:SendSourceName', v, fullname)
	end
end)
RegisterServerEvent('cd_dispatch:PlayerLoaded')
AddEventHandler('cd_dispatch:PlayerLoaded', function()
    local source = src
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local fullname = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local callsign = Player.PlayerData.metadata.callsign
	if Config and Config.UseRadio then
		GlobalInfo[_source].radio_channel = 0
	end
	TriggerClientEvent('cd_dispatch:SendSourceName', src, fullname)
end)
AddEventHandler("playerDropped", function()
	GlobalInfo[source] = nil
end)
RegisterServerEvent('cd_dispatch:AddNotification')
AddEventHandler('cd_dispatch:AddNotification', function(t)
	TriggerClientEvent('cd_dispatch:AddNotification', -1, t)
end)

RegisterServerEvent('cd_dispatch:AddResponding')
AddEventHandler('cd_dispatch:AddResponding', function(job, responding, count, SourceName2)
	TriggerClientEvent('cd_dispatch:AddResponding', -1, job, responding, count, SourceName2)
end)

RegisterServerEvent('cd_dispatch:RemoveResponding')
AddEventHandler('cd_dispatch:RemoveResponding', function(job, responding, count, SourceName2)
	TriggerClientEvent('cd_dispatch:RemoveResponding', -1, job, responding, count, SourceName2)
end)

RegisterServerEvent('cd_dispatch:GlobalInfo')
AddEventHandler('cd_dispatch:GlobalInfo', function(job)
	if Config and Config.UsingOnesync then
		GetGlobalCoords(job)
		local finaltable = SortTable(job)
		TriggerClientEvent('cd_dispatch:GlobalInfo', -1, job, finaltable)
	else
		TriggerClientEvent('cd_dispatch:GetNonOnesyncCoords', -1, job)
		Wait(1000)
		local finaltable = SortTable(job)
		TriggerClientEvent('cd_dispatch:GlobalInfo', -1, job, finaltable)
	end
end)

RegisterServerEvent('cd_dispatch:GetCoords')
AddEventHandler('cd_dispatch:GetCoords', function(job)
	if Config and Config.UsingOnesync then
		local coords = GetGlobalCoords2(job)
		Wait(500)
		TriggerClientEvent('cd_dispatch:GetCoords', -1, job, coords)
	else
		TriggerClientEvent('cd_dispatch:GetNonOnesyncCoords', -1, job)
		Wait(1000)
		local coords = GetGlobalCoords2(job)
		TriggerClientEvent('cd_dispatch:GetCoords', -1, job, coords)
	end
end)

RegisterServerEvent('cd_dispatch:GetNonOnesyncCoords')
AddEventHandler('cd_dispatch:GetNonOnesyncCoords', function(coords)
    local _source = source
    if GlobalInfo and GlobalInfo[_source] then
        GlobalInfo[_source].coords = {x = coords.x, y = coords.y}
    else
        print('dispatch - error 6844535')
    end
end)


function GetRoleplayInfo(cid)
        -- Should be a scalar?
    local result = MySQL.scalar.await('SELECT charinfo FROM players WHERE citizenid = @citizenid', { ['@citizenid'] = cid })
    if result ~= nil then
        local charinfo = json.decode(result)
        local fullname = charinfo['firstname']..' '..charinfo['lastname']
        return fullname
    else
        return nil
    end
    return result
end

function GetGlobalCoords(job)
    if GlobalInfo then
        for k, v in pairs(GlobalInfo) do
            local Player = QBCore.Functions.GetPlayer(v.source)
            local getjob = Player.PlayerData.job.name
            
            if getjob ~= nil then
                if getjob == job then
                    local coords = GetEntityCoords(GetPlayerPed(v.source))
                    if GlobalInfo[v.source] ~= nil then
                        GlobalInfo[v.source].coords = {x = coords.x, y = coords.y}
                    else
                        print('dispatch - error 6874968')
                    end
                end
            else
                print('dispatch - error 6874558')
            end
        end
        Wait(500)
    else
        print('dispatch - error 468536')
    end
end

function GetGlobalCoords2(job)
    local CoordsTable = {}
    if GlobalInfo then
        if Config and Config.UsingOnesync then
            for k, v in pairs(GlobalInfo) do
                local Player = QBCore.Functions.GetPlayer(v.source)
                local getjob = Player.PlayerData.job.name
                if getjob ~= nil then
                    if getjob == job then
                        local coords = GetEntityCoords(GetPlayerPed(v.source))
                        if GlobalInfo[v.source] and GlobalInfo[v.source].rp_name and coords then
                            table.insert(CoordsTable, {rp_name = GlobalInfo[v.source].rp_name, x = coords.x, y = coords.y})
                        else
                            print('dispatch - error 7896523')
                        end
                    end
                else
                    print('dispatch - error 1235456')
                end
            end
            Wait(500)
            return CoordsTable
        else
            for k, v in pairs(GlobalInfo) do
                local Player = QBCore.Functions.GetPlayer(v.source)
                local getjob = Player.PlayerData.job.name
                local fullname = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
                local callsign = Player.PlayerData.metadata.callsign
        
                if getjob ~= nil then
                    if getjob == job then
                        if GlobalInfo[v.source] and fullname and GlobalInfo[v.source].coords and GlobalInfo[v.source].coords.x and GlobalInfo[v.source].coords.y then
                            table.insert(CoordsTable, {rp_name = fullname, x = GlobalInfo[v.source].coords.x, y = GlobalInfo[v.source].coords.y})
                        else
                            print('dispatch - error 2135488')
                        end
                    end
                else
                    print('dispatch - error 9844654')
                end
            end
            Wait(500)
            return CoordsTable
        end
    else
        print('dispatch - error 1354685')
    end
end

function SortTable(job)
    local Table = {}
    if GlobalInfo then
        for k, v in pairs(GlobalInfo) do
            local Player = QBCore.Functions.GetPlayer(v.source)
            local getjob = Player.PlayerData.job.name
            local fullname = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
            local callsign = Player.PlayerData.metadata.callsign
            if getjob ~= nil then
                if getjob == job then
                    if Config and Config.DefaultCallsignColour and Config.CallsignData and type(Config.CallsignData) == 'table' then
                        local blipcolour = Config.DefaultCallsignColour
                        if v.callsign ~= nil then
                            for i=1, #Config.CallsignData, 1 do
                                if Config.CallsignData[i] and Config.CallsignData[i].blipname and Config.CallsignData[i].blipcolour then
                                    if string.sub(v.callsign, 1, 1) == string.sub(Config.CallsignData[i].blipname, 1, 1) then
                                        blipcolour = Config.CallsignData[i].blipcolour
                                    end
                                else
                                    print('dispatch - error 14654514')
                                end
                            end
                        else
                            print('dispatch - error 4978764')
                        end
                        table.insert(Table, {
                            rp_name = fullname,
                            callsign = callsign,
                            blipcolour = blipcolour,
                            coords = GlobalInfo[v.source].coords,
                            radio_channel = GlobalInfo[v.source].radio_channel,
                        })
                    else
                        print('dispatch - error 1635684')
                    end
                end
            else
                print('dispatch - error 684698')
            end
        end
        Wait(500)
        return Table
    else
        print('dispatch - error 984464')
    end
end

function GetSteamID(source)
    if source and type(source) == 'number' then
        return QBCore.Functions.GetPlayerByCitizenId(source)[1]
    else
        print('dispatch - error 6587446')
    end
end

function ErrorLocale(locale1)
    print('^3['..GetCurrentResourceName()..'] - ERROR - This locale is missing or incorrect ('..locale1..')^0')
end


AddEventHandler('onResourceStart', function(resourcesname)
    if resourcesname == "cd_dispatch" then
    end
end)
 