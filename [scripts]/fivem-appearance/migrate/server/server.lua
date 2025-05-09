local QBCore = exports['qb-core']:GetCoreObject()
local continue = false

local function MigrateFivemAppearance(source)
    local allPlayers = MySQL.Sync.fetchAll('SELECT * FROM players')
    local playerSkins = {}
    for i=1, #allPlayers, 1 do
        if allPlayers[i].skin then
            playerSkins[#playerSkins+1] = {
                citizenID = allPlayers[i].citizenid,
                skin = allPlayers[i].skin
            }
        end
    end

    for i=1, #playerSkins, 1 do
        MySQL.Async.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
            playerSkins[i].citizenID,
            json.decode(playerSkins[i].skin).model,
            playerSkins[i].skin,
            1
        })
    end
    TriggerClientEvent("QBCore:Notify", source, "+ " .. tostring(#playerSkins) .. " تم انتهاء منه", "success")
end

local function MigrateQBClothing(source)
    local allPlayerSkins = MySQL.Sync.fetchAll('SELECT * FROM playerskins')
    local migrated = 0
    for i=1, #allPlayerSkins, 1 do
        if not tonumber(allPlayerSkins[i].model) then
            TriggerClientEvent("QBCore:Notify", source, "تخطي الملابس")
        else
            TriggerClientEvent("fivem-appearance:client:migration:load-qb-clothing-skin", source, allPlayerSkins[i])
            while not continue do
                Wait(10)
            end
            continue = false
            migrated = migrated + 1
        end
    end
    TriggerClientEvent("fivem-appearance:client:reloadSkin", source)
    TriggerClientEvent("QBCore:Notify", source, "+ " .. migrated .. " تم الانتهاء منه", "success")
end

RegisterNetEvent("fivem-appearance:server:migrate-qb-clothing-skin", function(citizenid, appearance)
    local src = source
    MySQL.Async.execute('DELETE FROM playerskins WHERE citizenid = ?', { citizenid }, function()
        MySQL.Async.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
            citizenid,
            appearance.model,
            json.encode(appearance),
            1
        })
        continue = true
        TriggerClientEvent("QBCore:Notify", src, "تم تحويله", "success")
    end)
end)

QBCore.Commands.Add('migrateskins', 'fivem-appearance تحويل ملابس', {{name='type', help='fivem-appearance / qb-clothing'}}, false, function(source, args)
    local type = tostring(args[1])
    if type == "fivem-appearance" then
        MigrateFivemAppearance(source)
    elseif type == "qb-clothing" then
        CreateThread(function()
            MigrateQBClothing(source)
        end)
    else
        TriggerClientEvent("QBCore:Notify", source, "نوع غير صالح", "error")
    end
end, 'god')
