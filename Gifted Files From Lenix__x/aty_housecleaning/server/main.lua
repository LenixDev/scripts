Squads = {}

RegisterServerCallback('aty_housecleaning:getPlayerData', function (src, cb)
    local xPlayer = GetExtendedPlayer(src)
    local license = _GetPlayerLicense(src)
    local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
	local data = json.decode(file)
    local name = Config.Framework == "esx" and xPlayer.getName() or xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname

	if data[license] ~= nil then
        if data[license].name ~= name then
            data[license].name = name
            SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data), -1)
        end

        cb(data[license])
    else
        local avatar = GetPlayerAvatar(src)

        data[license] = {
            name = name,
            license = license,
            exp = 0,
            invites = true,
            image = avatar
        }

        cb(data[license])
        SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data), -1)
	end
end)

RegisterServerCallback('aty_housecleaning:toggleInvite', function (src, cb, val)
    local license = _GetPlayerLicense(src)
    local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
    local data = json.decode(file)
    
    if not data[license] then
        cb(false)
        return
    end
    
    data[license].invites = val
    SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data), -1)
    cb(true)
end)

RegisterServerCallback('aty_housecleaning:createSquad', function (src, cb)
    local license = _GetPlayerLicense(src)

    if Squads[license] then
        cb(false)
        Squads[license] = nil
        return
    else
        Squads[license] = {
            leader = _GetPlayerFromLicense(license, src),
            leaderSrc = src,
            members = {},
            mission = {},
            bucket = src..math.random(1, 9999999999)
        }

        cb(Squads[license])
    end
end)

RegisterServerCallback('aty_housecleaning:sendInvite', function (src, cb, id)
    local license = _GetPlayerLicense(src)
    local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
    local data = json.decode(file)

    if id == src or GetPlayerPed(id) == 0 then
        cb(false)
        return
    end
    
    local target = _GetPlayerFromSource(id)

    if not data[license] or not target then
        cb(false)
        return
    end

    if not target.invites then
        cb(false)
        return
    end

    if Squads[license] then
        for _, member in pairs(Squads[license].members) do
            if member.license == target.license then
                cb(false)
                return
            end
        end

        TriggerClientEvent('aty_housecleaning:receiveInvite', id, license)
    else
        cb(false)
    end
end)

RegisterServerCallback("aty_housecleaning:acceptInvite", function (src, cb, squad)
    local license = _GetPlayerLicense(src)
    local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
    local data = json.decode(file)

    if not data[license] then
        CreatePlayerData(src)
        file = LoadResourceFile(GetCurrentResourceName(), "database.json")
        data = json.decode(file)
    end

    if Squads[squad] then
        for _, member in pairs(Squads[squad].members) do
            if member.license == license then
                cb(false)
                return
            end
        end

        local newMember = _GetPlayerFromLicense(license, src)
        newMember.source = src

        table.insert(Squads[squad].members, newMember)
        cb(Squads[squad])

        for _, member in pairs(Squads[squad].members) do
            if not member.license == license then
                TriggerClientEvent('aty_housecleaning:refreshSquad', member.source, Squads[squad], false)
            end
        end

        TriggerClientEvent('aty_housecleaning:refreshSquad', Squads[squad].leaderSrc, Squads[squad], true)
    else
        cb(false)
    end
end)

RegisterServerCallback('aty_housecleaning:startMission', function(src, cb, mission)
    local license = _GetPlayerLicense(src)
    local selectedPositions = {}
    local coppied = table.copy(Config.HouseTypes[mission.HouseType].CleaningPositions or Config.HouseTypes["small"])

    if Squads[license].leader.license ~= license then
        cb(false)
        return
    end

    cb(true)

    local diffMultiplier = mission.Difficulty == 1 and 5 or mission.Difficulty == 2 and 4 or 5
    local difficulty = mission.Difficulty * diffMultiplier > #coppied and #coppied or mission.Difficulty * diffMultiplier

    for i = 1, difficulty do
        local pos = math.random(1, #coppied)
        
        table.insert(selectedPositions, {
            coords = coppied[pos].coords,
            type = coppied[pos].type,
            selected = true,
        })

        Squads[license].mission = mission
        table.remove(coppied, pos)
    end

    if Squads[license] then
        TriggerClientEvent('aty_housecleaning:startMission', Squads[license].leaderSrc, mission, selectedPositions)

        for _, member in pairs(Squads[license].members) do
            TriggerClientEvent('aty_housecleaning:startMission', member.source, mission, selectedPositions)
        end
    end
end)

RegisterServerEvent('aty_housecleaning:leftSquad', function (src)
    local src = src or source
    local license = _GetPlayerLicense(src)

    if Squads[license] then
        for _, member in pairs(Squads[license].members) do
            TriggerClientEvent('aty_housecleaning:deleteSquad', member.source)
        end

        Squads[license] = nil
    else
        for _, squad in pairs(Squads) do
            for _, member in pairs(squad.members) do
                if member.license == license then
                    table.remove(squad.members, _)
                    TriggerClientEvent('aty_housecleaning:refreshSquad', member.source, squad, false)
                    TriggerClientEvent('aty_housecleaning:refreshSquad', squad.leaderSrc, squad, true)
                    break
                end
            end
        end
    end
end)

RegisterServerEvent('aty_housecleaning:enterHouse', function ()
    local src = source
    local license = _GetPlayerLicense(src)

    if Squads[license] then
        Squads[license].leader.oldBucket = GetPlayerRoutingBucket(src)
        SetPlayerRoutingBucket(src, Squads[license].bucket)
    else
        for _, squad in pairs(Squads) do
            for _, member in pairs(squad.members) do
                if member.license == license then
                    member.oldBucket = GetPlayerRoutingBucket(member.source)
                    SetPlayerRoutingBucket(member.source, Squads[license].bucket)
                    break
                end
            end
        end
    end
end)

RegisterServerEvent('aty_housecleaning:leaveHouse', function ()
    local src = source
    local license = _GetPlayerLicense(src)

    if Squads[license] then
        SetPlayerRoutingBucket(src, Squads[license].leader.oldBucket)
    else
        for _, squad in pairs(Squads) do
            for _, member in pairs(squad.members) do
                if member.license == license then
                    SetPlayerRoutingBucket(member.source, member.oldBucket)
                    break
                end
            end
        end
    end
end)

RegisterServerEvent('aty_housecleaning:fetchPositions', function (pos)
    local src = source
    local license = _GetPlayerLicense(src)

    if Squads[license] then
        TriggerClientEvent('aty_housecleaning:fetchPositions', Squads[license].leaderSrc, pos)

        for _, member in pairs(Squads[license].members) do
            TriggerClientEvent('aty_housecleaning:fetchPositions', member.source, pos)
        end
    else
        local squad = GetPlayerSquad(license)

        if squad then
            TriggerClientEvent('aty_housecleaning:fetchPositions', squad.leaderSrc, pos)
            
            for _, member in pairs(squad.members) do
                TriggerClientEvent('aty_housecleaning:fetchPositions', member.source, pos)
            end
        end
    end
end)

RegisterServerEvent('aty_housecleaning:finishMission', function ()
    local src = source
    local license = _GetPlayerLicense(src)

    if Squads[license] then
        AddMoneyToPlayer(src, Squads[license].mission.Salary, Squads[license].mission.Exp)

        if #Squads[license].members == 0 then
            Squads[license] = nil
        end
    else
        for _, squad in pairs(Squads) do
            for _, member in pairs(squad.members) do
                if member.license == license then
                    AddMoneyToPlayer(member.source, squad.mission.Salary, squad.mission.Exp)
                    table.remove(squad.members, _)

                    if #squad.members == 0 then
                        Squads[_] = nil
                    end

                    break
                end
            end
        end
    end
end)

RegisterServerEvent("aty_housecleaning:kick", function(license)
    for _, squad in pairs(Squads) do
        for _, member in pairs(squad.members) do
            if member.license == license then
                TriggerClientEvent('aty_housecleaning:closeMenu', member.source)
                table.remove(squad.members, _)

                TriggerClientEvent('aty_housecleaning:refreshSquad', squad.leaderSrc, squad, true)
                
                for _, memberr in pairs(squad.members) do
                    TriggerClientEvent('aty_housecleaning:refreshSquad', memberr.source, squad, false)
                end

                break
            end
        end
    end
end)

RegisterServerEvent("aty_housecleaning:changeImage", function(img)
    local src = source
    local license = _GetPlayerLicense(src)
    local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
    local data = json.decode(file)

    if not data[license] then
        CreatePlayerData(src)
        file = LoadResourceFile(GetCurrentResourceName(), "database.json")
        data = json.decode(file)
    end

    data[license].image = img
    SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data), -1)

    Squads[license] = nil
end)

AddEventHandler('playerDropped', function ()
    local src = source
    TriggerEvent('aty_housecleaning:leftSquad', src)
end)
