local QBCore = exports['qb-core']:GetCoreObject() 

local VehicleCoords = nil
local CurrentCops = 0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)



--- Target Stuff
CreateThread(function() 
    exports['qb-target']:AddTargetModel('cs_taostranslator', {
        options = {
            { 
                type = "client",
                event = "qb-methrun:client:start",
                icon = "fas fa-circle",
                label = "Talk To Joseph (Cost: 5,000 Crypto)",
            },
        },
        distance = 3.0 
    })
    --
    exports['qb-target']:AddTargetModel('a_m_m_soucent_04', {
        options = {
            { 
                type = "client",
                event = "qb-shops:marketshop",
                icon = "fas fa-circle",
                label = "Open Dark Shop",
            },
            -- { 
            --     type = "client",
            --     event = "qb-vpn:client:start",
            --     icon = "fas fa-circle",
            --     label = "Talk To Niki And Buy a Black Market VPN (Cost: 1,000 Crypto)",
            -- },
            { 
                type = "client",
                event = "qb-hackerphone:client:start",
                icon = "fas fa-circle",
                label = "Talk To Niki And Buy a Hacker Phone (Cost: 1,500 Crypto - for 3 day use)",
            },
        },
        distance = 3.0 
    })
    ---
    exports['qb-target']:AddTargetModel('prop_security_case_01', {
        options = {
            {
                type = 'client',
                event = "qb-methrun:client:items",
                icon = "fas fa-circle",
                label = "Grab Goods",
                item = 'casekey',            
            },
        },
        distance = 2.5
    })
end)
---Phone msgs
function RunStart()
	Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender = Lang:t('mailstart.sender'),
	subject = Lang:t('mailstart.subject'),
	message = Lang:t('mailstart.message'),
	})
	Citizen.Wait(3000)
end

function Itemtimemsg()
    Citizen.Wait(2000)

	TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = Lang:t('mail.sender'),
	subject = Lang:t('mail.subject'),
	message = Lang:t('mail.message'),
	})
    QBCore.Functions.Notify('The Security Case will open in 5 seconds', 'success')
    Citizen.Wait(5000)
    TriggerServerEvent('qb-methrun:server:givecaseitems')
    QBCore.Functions.Notify('Security case has been unlocked', 'success')
end
---
RegisterNetEvent('qb-methrun:client:start', function ()
    if CurrentCops >= Config.MinimumMethJobPolice then
        QBCore.Functions.TriggerCallback("qb-methrun:server:coolc",function(isCooldown)
            if not isCooldown then
                TriggerEvent('animations:client:EmoteCommandStart', {"idle11"})
                QBCore.Functions.Progressbar("start_job", Lang:t('info.talking_to_boss'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('qb-methrun:server:startr')
                    TriggerServerEvent('qb-logs:server:createLog', 'joseph', 'Player Start/Found The Drug Mission Of Joseph', "", src)

                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
    end
end)

RegisterNetEvent('qb-food:client:start', function(itemName)
    local player = PlayerId()
    local playerPed = PlayerPedId()

    -- בדיקה אם השחקן הוא "police"
    if QBCore.Functions.GetPlayerData().job.name == "police" then
        -- אם הוא "police", תעשה משהו (לדוגמה תשלח הודעה שלא ניתן להשתמש באובייקט כרגע)
        QBCore.Functions.Notify('This meal is not for you, you are officer', 'error')
        return
    end

    -- אם התפקיד של השחקן אינו "police", נמשיך עם הקוד כרגיל
    exports["wsemotes"]:EmoteCommandStart("foodtraya", 1)

    QBCore.Functions.Progressbar("start_job", Lang:t('info.food'), 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        exports["wsemotes"]:EmoteCommandStart("c", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('qb-food:server:takepolicefood')
    end)
end)
---
RegisterNetEvent('qb-vpn:client:start', function ()
    if CurrentCops >= Config.MinimumMethJobPolice then
        QBCore.Functions.TriggerCallback("qb-methrun:server:coolc",function(isCooldown)
            if not isCooldown then
                TriggerEvent('animations:client:EmoteCommandStart', {"idle11"})
            
                QBCore.Functions.Progressbar("start_job", Lang:t('info.talking_to_niki'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('qb-vpn:server:startr')
                    TriggerServerEvent('qb-logs:server:createLog', 'blackmarketshop', 'Player Bought/Found The Black Market VPN', "", src)

                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
    end
end)
---
RegisterNetEvent('qb-laptop:client:start', function ()
    if CurrentCops >= Config.MinimumMethJobPolice then
        QBCore.Functions.TriggerCallback("qb-methrun:server:coolc",function(isCooldown)
            if not isCooldown then
                TriggerEvent('animations:client:EmoteCommandStart', {"idle11"})
            
                QBCore.Functions.Progressbar("start_job", Lang:t('info.talking_to_niki'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('qb-laptop:server:startr')
                    -- TriggerServerEvent('qb-logs:server:createLog', 'blackmarketshop', 'Player Bought/Found The Black Market VPN', "", src)

                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
    end
end)

RegisterNetEvent('qb-hackerphone:client:start', function ()
    if CurrentCops >= Config.MinimumMethJobPolice then
        QBCore.Functions.TriggerCallback("qb-methrun:server:coolc",function(isCooldown)
            if not isCooldown then
                TriggerEvent('animations:client:EmoteCommandStart', {"idle11"})
            
                QBCore.Functions.Progressbar("start_job", Lang:t('info.talking_to_niki'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('qb-hackerphone:server:startr')
                    TriggerServerEvent('qb-logs:server:createLog', 'blackmarketshop', 'Player Bought/Found The Hacker Phone', "", src)

                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
    end
end)

RegisterNetEvent('ori:waypoint', function()
    SetNewWaypoint(-443.5334, 5601.5947, 68.376182, 3.0711429)
end)

RegisterNetEvent('ori:waypoint:weed', function()
    SetNewWaypoint(-1001.386, 4847.3598, 275.00701, 184.00666)
end)

RegisterNetEvent('ori:waypoint:meth', function()
    SetNewWaypoint(3309.8994, 5189.9511, 19.711425, 230.4598)
end)

RegisterNetEvent('qb-methrun:server:runactivate', function()
RunStart()
local DrawCoord = 1
    if DrawCoord == 1 then
    VehicleCoords = Config.Carspawn
end

RequestModel(`slamvan2`)
    while not HasModelLoaded(`slamvan2`) do
Citizen.Wait(0)
end

SetNewWaypoint(VehicleCoords.x, VehicleCoords.y)
ClearAreaOfVehicles(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 15.0, false, false, false, false, false)
transport = CreateVehicle(`slamvan2`, VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 52.0, true, true)
SpawnGuards()
spawncase()
end)

function spawncase()
    local case = CreateObject(`prop_security_case_01`, 3828.87, 4471.85, 3.0, true,  true, true)
    CreateObject(case)
    SetEntityHeading(case, 176.02)
    FreezeEntityPosition(case, true)
    SetEntityAsMissionEntity(case)
    case = AddBlipForEntity(case)
    SetBlipSprite(case, 586)
    SetBlipColour(case, 2)
    SetBlipFlashes(case, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Case')
    EndTextCommandSetBlipName(case)
end

methguards = {
    ['npcguards'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuards()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('npcguards')

    for k, v in pairs(Config['methguards']['npcguards']) do
        loadModel(v['model'])
        methguards['npcguards'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(methguards['npcguards'][k])
        networkID = NetworkGetNetworkIdFromEntity(methguards['npcguards'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(methguards['npcguards'][k], 0)
        SetPedRandomProps(methguards['npcguards'][k])
        SetEntityAsMissionEntity(methguards['npcguards'][k])
        SetEntityVisible(methguards['npcguards'][k], true)
        SetPedRelationshipGroupHash(methguards['npcguards'][k], `npcguards`)
        SetPedAccuracy(methguards['npcguards'][k], 75)
        SetPedArmour(methguards['npcguards'][k], 100)
        SetPedCanSwitchWeapon(methguards['npcguards'][k], true)
        SetPedDropsWeaponsWhenDead(methguards['npcguards'][k], false)
        SetPedFleeAttributes(methguards['npcguards'][k], 0, false)
        GiveWeaponToPed(methguards['npcguards'][k], `WEAPON_HEAVYPISTOL`, 255, false, false)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(methguards['npcguards'][k], 10.0, 10.0, 1)
        end
    end

    SetRelationshipBetweenGroups(0, `npcguards`, `npcguards`)
    SetRelationshipBetweenGroups(5, `npcguards`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `npcguards`)
end

RegisterNetEvent('qb-methrun:client:items', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerEvent("qb-dispatch:methjob")
            exports["memorygame"]:thermiteminigame(8, 3, 2, 20,
            function() -- Success
                TriggerEvent('animations:client:EmoteCommandStart', {"type3"})
                QBCore.Functions.Progressbar("grab_case", Lang:t('info.unlocking_case'), 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    RemoveBlip(case)
                    TriggerServerEvent('qb-methrun:server:unlock')

                    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
                    local case = GetClosestObjectOfType(playerPedPos, 10.0, `prop_security_case_01`, false, false, false)
                    if (IsPedActiveInScenario(PlayerPedId()) == false) then
                    SetEntityAsMissionEntity(case, 1, 1)
                    DeleteEntity(case)
                    QBCore.Functions.Notify(Lang:t("success.you_removed_first_security_case"), 'success')
                    Itemtimemsg()
                end
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            end,
            function() -- Fail thermite game
                QBCore.Functions.Notify(Lang:t("error.you_failed"), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.you_cannot_do_this"), 'error')
        end

    end, "casekey")
end)

