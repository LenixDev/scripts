local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Commands.Add('playersm', 'manage player', {}, false, function(source, args)
    TriggerClientEvent('playermanagement:client:openmenu', source)
end, 'admin')

QBCore.Functions.CreateCallback('playermanagement:server:getallgang', function(source, cb, args)
    local gangs = {}
    for k, v in pairs(QBCore.Shared.Gangs) do
        table.insert(gangs, {
            gang = k
        })
    end
    cb(gangs)
end)
QBCore.Functions.CreateCallback('playermanagement:server:getplayers', function(source, cb, args)
    local players = {}
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        table.insert(players, {
            firstname = v.PlayerData.charinfo.firstname,
            lastname = v.PlayerData.charinfo.lastname,
            job = v.PlayerData.job.name,
            grade = v.PlayerData.job.grade.name,
            cid = v.PlayerData.citizenid,
            gang = v.PlayerData.gang.name,
            ganggrade = v.PlayerData.gang.grade.name,
            rep = v.PlayerData.metadata['rep'],
            playerid = v.PlayerData.source

        })
    end
    cb(players)
end)
QBCore.Functions.CreateCallback('playermanagement:server:getalljobs', function(source, cb, args)
    local jobs = {}
    for k, v in pairs(QBCore.Shared.Jobs) do
        table.insert(jobs, {
            job = k
        })
    end
    cb(jobs)
end)
QBCore.Functions.CreateCallback('playermanagement:server:getganggrade', function(source, cb, gang)
    local ganggrades = {}
    if QBCore.Shared.Gangs[gang] then
        for grade, data in pairs(QBCore.Shared.Gangs[gang].grades) do
            table.insert(ganggrades, {
                grade = grade,
                name = data.name
            })
        end
    end
    cb(ganggrades)
end)
QBCore.Functions.CreateCallback('playermanagement:server:getallgradeofjob', function(source, cb, job)
    local grades = {}
    if QBCore.Shared.Jobs[job] then
        for grade, data in pairs(QBCore.Shared.Jobs[job].grades) do
            table.insert(grades, {
                grade = grade,
                name = data.name
            })
        end
    end
    cb(grades)
end)
RegisterNetEvent('playermanagement:server:kickplayer', function(id)
    local p = QBCore.Functions.GetPlayerByCitizenId(id)
    if p then
        DropPlayer(p.PlayerData.source, "حدث خطأً ما")
    end
end)
RegisterNetEvent('playermanagement;server:givecash', function(id, amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(id)
    if p then
        p.Functions.AddMoney('cash', amount)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'You gave ' .. p.PlayerData.charinfo.firstname .. " " .. amount .. " $",
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'you received ' .. amount .. " $ in cash",
            'top-center',
            'success')
    end
end)
RegisterNetEvent('playermanagement;server:giveBank', function(id, amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(id)
    if p then
        p.Functions.AddMoney('bank', amount)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'You gave ' .. p.PlayerData.charinfo.firstname .. " " .. amount .. " $",
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'you received ' .. amount .. " $ in Bank",
            'top-center',
            'success')
    end
end)
RegisterNetEvent('playermanagement:server:updategrade', function(job, grade, citizenid)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if p then
        p.Functions.SetJob(job, grade)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'Players Grade has been updated ',
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'your grade has been updated',
            'top-center',
            'success')
    end
end)
RegisterNetEvent('playermanagement:server:changejob', function(job, citizenid)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if p then
        p.Functions.SetJob(job, 0)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'Player job has been update to ' .. job,
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'your job has been updated',
            'top-center',
            'success')
    end
end)
RegisterNetEvent('playermanagement:server:changegang', function(gang, citizenid)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if p then
        p.Functions.SetGang(gang, 0)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'Player gang has been updated ',
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'your gang has been updated',
            'top-center',
            'success')
    end
end)

RegisterNetEvent('playermanagement:server:changeganggrade', function(gang, grade, citizenid)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if p then
        print(gang, grade)
        p.Functions.SetGang(gang, grade)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'Player gang grade has been updated  ',
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'your gang grade has been updated',
            'top-center',
            'success')
    end
end)
RegisterNetEvent('playermanagement:server:givelevel', function(amount, citizenid)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local p = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if p then
        p.Functions.SetMetaData("rep", p.PlayerData.metadata["rep"] + amount)
        TriggerClientEvent('gangsystem:client:notify', xPlayer.PlayerData.source,
            'the Player received ' .. amount .. " level",
            'top-center',
            'success')
        TriggerClientEvent('gangsystem:client:notify', p.PlayerData.source,
            'youre Drugs level has changed',
            'top-center',
            'success')
    end
end)
