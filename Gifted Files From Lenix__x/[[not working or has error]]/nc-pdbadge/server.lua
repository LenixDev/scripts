local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-pdbadge:showTargetPoliceBadge')
AddEventHandler('qb-pdbadge:showTargetPoliceBadge', function(sentId, callsign, firstname, lastname, job, rank, picture)
	if GetPlayerPing(sentId) > 0 then
		TriggerClientEvent('qb-pdbadge:showTargetPoliceBadge', sentId, callsign, firstname, lastname, job, rank, picture)
	end
end)

RegisterNetEvent('qb-pdbadge:server:createbadge', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local info = {}
    local callsign = player.PlayerData.metadata.callsign
    local firstname = player.PlayerData.charinfo.firstname
    local lastname = player.PlayerData.charinfo.lastname
    local rank = player.PlayerData.job.grade.name
    local citizenid = player.PlayerData.citizenid
    info.callsign = callsign
    info.firstname = firstname
    info.lastname = lastname
    info.job = ''
    info.rank = rank
    
    local result = exports.oxmysql:fetchSync('SELECT pfp FROM mdt_data WHERE cid=@citizenid', {['@citizenid'] = citizenid})
    
    if result and result[1] and result[1]['pfp'] then
        info.picture = result[1]['pfp']
        player.Functions.AddItem('pdbadge', 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['pdbadge'], 'add')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have a picture in the MDT')
    end
end)


QBCore.Functions.CreateUseableItem("pdbadge", function(source, item)
    TriggerClientEvent("qb-pdbadge:showPoliceBadge", source, item.info)   
end)

RegisterNetEvent('qb-badge:server:createbadge', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local info = {}
    local callsign = player.PlayerData.metadata.callsign
    local firstname = player.PlayerData.charinfo.firstname
    local lastname = player.PlayerData.charinfo.lastname
    local rank = player.PlayerData.job.grade.name
    local id = player.PlayerData.citizenid
    -- local result = SQL('SELECT * FROM players WHERE citizenid = @citizenid', {['@citizenid'] = id})
    -- local picture = result[1].pp
    info.callsign = callsign
    info.firstname = firstname
    info.lastname = lastname
    info.job = ''
    info.rank = rank
    info.picture = picture
    print(picture)
    player.Functions.AddItem('pdbadge', 1, nil, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['pdbadge'], 'add')
end)