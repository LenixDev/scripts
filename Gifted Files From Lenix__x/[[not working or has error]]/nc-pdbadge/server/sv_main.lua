local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('badge:open')
AddEventHandler('badge:open', function(ID, targetID, type)
	local Player = QBCore.Functions.GetPlayer(ID)
	local data = {
		name = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname,
		grade = Player.PlayerData.job.grade.name,
		gender = Player.PlayerData.charinfo.gender,
		serial = Player.PlayerData.metadata["callsign"].. "#"
	}
	TriggerClientEvent('badge:open', targetID, data, type)
	TriggerClientEvent('badge:shot', targetID, source, type)
end)

QBCore.Functions.CreateUseableItem('pdbadge', function(source, item)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer and (xPlayer.PlayerData.job.name == 'police') then
    	TriggerClientEvent('badge:openPD', src, "lspd")
	else
		TriggerClientEvent('QBCore:Notify', src, "You are not an officer.", "error")
	end
end)

QBCore.Functions.CreateUseableItem('dojbadge', function(source, item)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer and (xPlayer.PlayerData.job.name == 'lawyer') then
    	TriggerClientEvent('badge:openPD', source, "doj")
	else
		TriggerClientEvent('QBCore:Notify', src, "You are not an doj.", "error")
	end
end)