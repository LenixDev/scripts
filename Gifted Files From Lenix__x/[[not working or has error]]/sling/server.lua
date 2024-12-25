local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("sling", "Change weapon sling position", {}, false, function(source, args)
	TriggerClientEvent("sling:client:changeSling", source)
end)
