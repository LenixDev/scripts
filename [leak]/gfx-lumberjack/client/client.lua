if GetResourceState('qb-core') == "started" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('es_extended') == "started" then
    ESX = exports['es_extended']:getSharedObject()
end
  
local jobstarted = false
local currentTree = nil
local checkpoint = nil
local axeModel = nil
local isCutting = false
local axe = nil
local axePos = nil
local bonus = 0
local workTime = nil
local tutorial = false
local tree = nil
local contractJob = false
local contractOwner = nil
local mustCuttedTree = nil
local contractPercent = nil
local nextblip = nil
local cuttedtree = 0
local earnedmoney = 0
local contractMoney = Config.lumberjack.contractSettings.contractMoney
local money = Config.lumberjack.Money.cuttingTreePerMoney
local openedUI = false

Citizen.CreateThread(function ()
    -- #region interaction
        if Config.target == "qb-target" then
            exports[Config.target]:AddTargetModel(Config.lumberjack.ped, {
                options = {{
                    event = 'gfx:client:LumberjackNui',
                    icon = "fas fa-tree",
                    label = "Start Lumberjack"
                    -- duty = false,
                }},
                -- model = Config.lumberjack.ped,
                distance = 2.5
            })
        elseif Config.target == "ox_target" then
            exports[Config.target]:addModel(Config.lumberjack.ped, {
                name = 'lumberjack',
                event = 'gfx:client:LumberjackNui',
                icon = "fas fa-tree",
                label = "Cut Tree"
            })
        elseif Config.target == "drawtext" then
            Citizen.CreateThread(function()
                while true do
                --print("drawtext")
                    local playerPed = PlayerPedId()
                    local sleep = 1000
                    local coords = GetEntityCoords(playerPed)
                    local v = Config.lumberjack.pos
                    local distance = #(coords - v)
                    if distance < 2.5 then
                        sleep = 1
                        DrawText3D(v.x, v.y, v.z + 1, 1.0, Config.NotifyTexts.interaction)
                        if IsControlJustPressed(0, Config.interactionKey) then
                            TriggerEvent('gfx:client:LumberjackNui')
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
    -- #endregion
    end)
    
-- #region Events
RegisterNetEvent('gfx:client:LumberjackNui', function()
    if QBCore ~= nil then
        -- print(QBCore)
        QBCore.Functions.TriggerCallback('gfx:server:lumberjack:GetData', function(returnValue)
            -- print(returnValue)
            OpenNui(returnValue)
        end)
    elseif ESX ~= nil then
        ESX.TriggerServerCallback('gfx:server:lumberjack:GetData', function(returnValue)
            OpenNui(returnValue)
        end)
    end
end)
-- #endregion

-- #region nuı callbaks
RegisterNuiCallback("gfx:client:lumberjack:closeUI", function(data, cb)
    NuiFocus(data)
end)
RegisterNuiCallback("gfx:client:lumberjack:startJob", function(data, cb)
    if jobstarted then
        Notify(Config.NotifyTexts.alreadystartjob)
        -- print("zaten işin var")
        return
    end
    jobstarted = data.bool
    tutorial = data.tutorial
    -- print(data.cuttedTree, data.bool, type(data.cuttedTree), type(data.bool))
    if tutorial == nil then
        if data.cuttedTree >= Config.lumberjack.axe.tier3axeUpgradeLimit then
            axeModel = GetHashKey(Config.lumberjack.axe.tier3axe)
            axePos = "tier3axePos"
            bonus = Config.lumberjack.axe.tier3axeBonusPercent
        elseif data.cuttedTree >= Config.lumberjack.axe.tier2axeUpgradeLimit then
            axeModel = GetHashKey(Config.lumberjack.axe.tier2axe)
            axePos = "tier2axePos"
            bonus = Config.lumberjack.axe.tier2axeBonusPercent
        else
            axeModel = GetHashKey(Config.lumberjack.axe.tier1axe)
            axePos = "tier1axePos"
            bonus = 0
        end
    end
    Notify(Config.NotifyTexts.startjob)
    StartLumberJack()
    NuiFocus(false)
    workTime = GetGameTimer()
end)
RegisterNuiCallback("gfx:client:lumberjack:stopJob", function(data, cb)
    jobstarted = data
    Notify(Config.NotifyTexts.stopjob)
    DeleteCheckpoint(checkpoint)
    RemoveBlip(nextblip)
    if blip1 ~= nil then
        RemoveBlip(blip1)
        RemoveBlip(blip2)
        blip1 = nil
        blip2 = nil
    end
    DeleteEntity(axe)
    currentTree = nil
    checkpoint = nil
    axe = nil
    workTime = nil
    nextblip = nil

    NuiFocus(false)
end)
RegisterNuiCallback("lumberjack:LeaderBoard", function(data, cb)
    if QBCore ~= nil then
        QBCore.Functions.TriggerCallback('GFX:lumberjack:LeaderBoard', function(returnValue)
            cb(returnValue)
        end)
    elseif ESX ~= nil then
        ESX.TriggerServerCallback('GFX:lumberjack:LeaderBoard', function(returnValue)
            cb(returnValue)
        end)
    end
end)
RegisterNuiCallback("gfx:client:lumberjack:contractPage", function(data, cb)
    if QBCore ~= nil then
        QBCore.Functions.TriggerCallback('GFX:lumberjack:contractPage', function(returnValue)
            cb(returnValue)
        end)
    elseif ESX ~= nil then
        ESX.TriggerServerCallback('GFX:lumberjack:contractPage', function(returnValue)
            cb(returnValue)
        end)
    end
end)
RegisterNuiCallback("gfx:client:lumberjack:makeContract", function(data, cb)
    if QBCore ~= nil then
        QBCore.Functions.TriggerCallback('GFX:lumberjack:makeContract', function(returnValue)
            cb(returnValue)
        end, data)
    elseif ESX ~= nil then
        ESX.TriggerServerCallback('GFX:lumberjack:makeContract', function(returnValue)
            cb(returnValue)
        end, data)
    end
end)
RegisterNuiCallback("gfx:client:lumberjack:deleteContract", function(data, cb)
    if QBCore ~= nil then
        QBCore.Functions.TriggerCallback('GFX:lumberjack:deleteContract', function(returnValue)
            -- cb(returnValue)
        end, data.contractCitizenid)
    elseif ESX ~= nil then
        ESX.TriggerServerCallback('GFX:lumberjack:deleteContract', function(returnValue)
            -- cb(returnValue)
        end, data.contractCitizenid)
    end
end)
RegisterNuiCallback("gfx:client:lumberjack:takeContract", function(data, cb)
    if QBCore ~= nil then
        QBCore.Functions.TriggerCallback('GFX:lumberjack:takeContract', function(returnValue)
            contractOwner = data.ownerid
            mustCuttedTree = data.treeCount
            contractPercent = data.percent
            contractJob = data.contractJob
            jobstarted = data.startJob

            if data.cuttedTree >= Config.lumberjack.axe.tier3axeUpgradeLimit then
                axeModel = GetHashKey(Config.lumberjack.axe.tier3axe)
                axePos = "tier3axePos"
                bonus = Config.lumberjack.axe.tier3axeBonusPercent
            elseif data.cuttedTree >= Config.lumberjack.axe.tier2axeUpgradeLimit then
                axeModel = GetHashKey(Config.lumberjack.axe.tier2axe)
                axePos = "tier2axePos"
                bonus = Config.lumberjack.axe.tier2axeBonusPercent
            else
                axeModel = GetHashKey(Config.lumberjack.axe.tier1axe)
                axePos = "tier1axePos"
                bonus = 0
            end
            StartLumberJack()
            NuiFocus(false)
            workTime = GetGameTimer()
        end, data.ownerid)
    elseif ESX ~= nil then
        ESX.TriggerServerCallback('GFX:lumberjack:takeContract', function(returnValue)
            contractOwner = data.ownerid
            mustCuttedTree = data.treeCount
            contractPercent = data.percent
            contractJob = data.contractJob
            jobstarted = data.startJob

            if data.cuttedTree >= Config.lumberjack.axe.tier3axeUpgradeLimit then
                axeModel = GetHashKey(Config.lumberjack.axe.tier3axe)
                axePos = "tier3axePos"
                bonus = Config.lumberjack.axe.tier3axeBonusPercent
            elseif data.cuttedTree >= Config.lumberjack.axe.tier2axeUpgradeLimit then
                axeModel = GetHashKey(Config.lumberjack.axe.tier2axe)
                axePos = "tier2axePos"
                bonus = Config.lumberjack.axe.tier2axeBonusPercent
            else
                axeModel = GetHashKey(Config.lumberjack.axe.tier1axe)
                axePos = "tier1axePos"
                bonus = 0
            end
            StartLumberJack()
            NuiFocus(false)
            workTime = GetGameTimer()
        end, data.ownerid)
    end

end)
RegisterNuiCallback("gfx:client:lumberjack:getConfig", function(data, cb)
    cb(Config.lumberjack)
end)
-- #endregion

-- #region functions
function OpenNui(data)
    SendNUIMessage({
        action = "gfx:lumberjack:openUI",
        database = data,
        jobstatus = jobstarted,
        -- passingTime = workTime ~= nil and GetGameTimer() - workTime or 0,
        axeData = Config.lumberjack.axe
    })
    NuiFocus(true)
end

function NuiFocus(data)
    SetNuiFocus(data, data)
    openedUI = data
end

CreateThread(function()
    Jobped = CreateNpc(Config.lumberjack.ped, Config.lumberjack.pos, Config.lumberjack.heading)
    CreateBlipEntity(Jobped, Config.lumberjack.blip.sprite, Config.lumberjack.blip.color, Config.lumberjack.blip.name,
        false, Config.lumberjack.blip.scale)
end)

CreateThread(function()
    while true do
        if jobstarted and not openedUI then
            SendNUIMessage({
                action = "gfx:lumberjack:updateTime",
                passingTime = GetGameTimer() - workTime,
                cuttedtree = cuttedtree,
                earnedmoney = earnedmoney
            })
        end
        Wait(1000)
    end
end)

function StartLumberJack()
    Citizen.CreateThread(function()

        if tutorial == false or tutorial == nil then
            local playerPed = PlayerPedId()
            GetTools(axeModel, playerPed, axePos)
            currentTree = SelectNextTree(Config.lumberjack.TreeLocations)

            while jobstarted == true do
                local sleep = 1000
                local coords = GetEntityCoords(playerPed)
                local distance = #(currentTree - coords)

                if distance < 1.5 and isCutting == false and not IsPedInAnyVehicle(playerPed, false) then
                    if contractJob then
                        sleep = 1
                        mustCuttedTree = mustCuttedTree - 1
                        isCutting = true
                        PlayerAnim()
                        FreezePlayer(playerPed)
                        Wait(Config.lumberjack.CuttingTreeTime)
                        ClearPlayer(playerPed)
                        isCutting = false
                        DeleteCheckpoint(checkpoint)
                        AddCuttingTreeContract(1, bonus, contractPercent, contractOwner)
                        currentTree = SelectNextTree(Config.lumberjack.TreeLocations)
                        cuttedtree = cuttedtree + 1
                        local calculatePercent = (contractPercent / 100) * contractMoney
                        earnedmoney = math.floor((((contractMoney * bonus) / 100) + contractMoney) + calculatePercent) +
                                          earnedmoney
                        if mustCuttedTree == 0 then
                            contractJob = false
                            contractOwner = nil
                            mustCuttedTree = nil
                            contractPercent = nil
                            jobstarted = false
                            DeleteCheckpoint(checkpoint)
                            RemoveBlip(nextblip)
                            DeleteEntity(axe)
                            nextblip = nil
                            currentTree = nil
                            checkpoint = nil
                            axe = nil
                            workTime = nil
                            tutorial = false
                            tree = nil
                            earnedmoney = 0
                            cuttedtree = 0
                            Notify(Config.NotifyTexts.completeContract)
                        end
                    else
                        sleep = 1
                        isCutting = true
                        PlayerAnim()
                        FreezePlayer(playerPed)
                        Wait(Config.lumberjack.CuttingTreeTime)
                        ClearPlayer(playerPed)
                        isCutting = false
                        DeleteCheckpoint(checkpoint)
                        AddCuttingTree(1, bonus)
                        currentTree = SelectNextTree(Config.lumberjack.TreeLocations)
                        cuttedtree = cuttedtree + 1
                        earnedmoney = math.floor(((money * bonus) / 100) + money) + earnedmoney
                    end
                end
                Citizen.Wait(sleep)
            end
        else
            local playerPed = PlayerPedId()
            local carrying = false
            local coords = GetEntityCoords(playerPed)
            local distance = #(coords - Config.lumberjack.tutorialSection.startPos)
            local endDistance = #(coords - Config.lumberjack.tutorialSection.endPos)
            local logModel = GetHashKey(Config.lumberjack.tutorialSection.propmodel)
            repeat
                RequestModel(logModel)
                -- print("model yükleniyor")
                Wait(0)
            until HasModelLoaded(logModel)

            tree = CreateObject(logModel, Config.lumberjack.tutorialSection.startPos.x,
                Config.lumberjack.tutorialSection.startPos.y, Config.lumberjack.tutorialSection.startPos.z, false,
                false, true)
            FreezeEntityPosition(tree, true)
            blip1 = CreateBlipCoord(Config.lumberjack.tutorialSection.endPos, 1, 5, "End Point", 0.8)
            blip2 = CreateBlipCoord(Config.lumberjack.tutorialSection.startPos, 1, 5, "Start Point", 0.8)
            CreateCheckpoint(47, Config.lumberjack.tutorialSection.startPos.x,
                Config.lumberjack.tutorialSection.startPos.y, Config.lumberjack.tutorialSection.startPos.z, 0, 0, 0,
                2.0, 76, 153, 0, 150, 0, 0, 100, 0, 0, 0)
            CreateCheckpoint(47, Config.lumberjack.tutorialSection.endPos.x, Config.lumberjack.tutorialSection.endPos.y,
                Config.lumberjack.tutorialSection.endPos.z, 0, 0, 0, 2.0, 76, 153, 0, 150, 0, 0, 100, 0, 0, 0)

            while jobstarted == true do
                local sleep = 1000
                coords = GetEntityCoords(playerPed)
                distance = #(coords - Config.lumberjack.tutorialSection.startPos)
                endDistance = #(coords - Config.lumberjack.tutorialSection.endPos)
                if distance < 3 and not carrying then
                    carrying = true -- {0.715,0.04,-0.185,-430.5,-213.5,164.5,}
                    local xPos, yPos, zPos, xRot, yRot, zRot = table.unpack(Config.lumberjack.tutorialSection.attachedCoords)
                    AttachEntityToEntity(tree, playerPed, GetPedBoneIndex(playerPed, 57005), xPos, yPos, zPos, xRot, yRot, zRot,
                    true, false, false, false, 2, true) -- 0.13, 0.055, 0.0, -304.5, 0.0, -196.0
                    CarryAnim()
                end
                if carrying and endDistance < 3 then
                    cuttedtree = cuttedtree + 1
                    earnedmoney = math.floor(((Config.lumberjack.tutorialSection.moneyPerCarriyngLog * bonus) / 100) +
                                                    Config.lumberjack.tutorialSection.moneyPerCarriyngLog) + earnedmoney
                    carrying = false
                    DeleteEntity(tree)
                    ClearPlayer(playerPed)
                    AddCuttingTree(1, bonus)
                    tree = CreateObject(logModel, Config.lumberjack.tutorialSection.startPos.x,
                        Config.lumberjack.tutorialSection.startPos.y, Config.lumberjack.tutorialSection.startPos.z,
                        false, false, true)
                    FreezeEntityPosition(tree, true)
                end
                Citizen.Wait(sleep)
            end
        end
    end)
end

function AddCuttingTree(count, bonus)
    -- print(count, type(count), bonus, type(bonus))
    TriggerServerEvent('gfx:server:lumberjack:CuttingTrees', count, bonus)
end

function AddCuttingTreeContract(count, bonus, percent, contractOwner)
    -- print(count, type(count), bonus, type(bonus))
    TriggerServerEvent('gfx:server:lumberjack:GainContractMoney', count, bonus, percent, contractOwner)
end

function SelectNextTree(coordList)
    local treeCoord -- = coordList[math.random(1, #coordList)]
    local playerCoord = GetEntityCoords(PlayerPedId())
    repeat
        treeCoord = coordList[math.random(1, #coordList)]
        -- print("yeni koordinat hesaplandı".. "yeni koordinat yakınlığı ".. #(treeCoord - playerCoord))
    until #(treeCoord - playerCoord) > 3

    checkpoint = CreateCheckpoint(47, treeCoord.x, treeCoord.y, treeCoord.z, 0, 0, 0, 2.0, 76, 153, 0, 150, 0, 0, 100,
        0, 0, 0)
    if nextblip ~= nil or jobstarted == false then
        RemoveBlip(nextblip)
    end
    nextblip = CreateBlipCoord(treeCoord, 1, 5, "Next Tree", true, 0.8)

    return treeCoord
end

function GetTools(tool, playerPed, axeModelPos)
    RequestModel(tool)
    while not HasModelLoaded(tool) do
        -- print("model yükleniyor")
        Wait(1)
    end
    axe = CreateObject(tool, 1.0, 1.0, 1.0, true, true, false)
    local axepos = Config.lumberjack.axe[axeModelPos]
    AttachEntityToEntity(axe, playerPed, GetPedBoneIndex(playerPed, 57005), axepos[1], axepos[2], axepos[3], axepos[4],
        axepos[5], axepos[6], true, false, false, false, 2, true)
    -- AttachEntityToEntity(axe, playerPed, GetPedBoneIndex(playerPed, 57005), 0.13, 0.055, 0.0, -304.5, 0.0, -196.0, true,
    --     false, false, false, 2, true)
    -- print(GetEntityRotation(axe), GetEntityCoords(axe))
end

function PlayerAnim()
    local playerPed = PlayerPedId()
    local animDict = "melee@large_wpn@streamed_core"
    local animName = "car_down_attack"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        -- print("anim yükleniyor")
        Wait(1)
    end
    TaskPlayAnim(playerPed, animDict, animName, 8.0, 1.0, -1, 49, 0, true, true, true)
end

function CarryAnim()
    local playerPed = PlayerPedId()
    local animDict = "anim@heists@box_carry@"
    local animName = "idle"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        -- print("anim yükleniyor")
        Wait(1)
    end
    TaskPlayAnim(playerPed, animDict, animName, 8.0, 1.0, -1, 49, 0, false, false, false)
end

function FreezePlayer(player)
    FreezeEntityPosition(player, true)
end

function ClearPlayer(player)
    ClearPedTasks(player)
    FreezeEntityPosition(player, false)
end

function CreateNpc(npcHash, npcCoord, h)
    local model = GetHashKey(npcHash)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    local h = h ~= nil and h or math.random(0, 359) + .0

    local npc = CreatePed(4, model, npcCoord.x, npcCoord.y, npcCoord.z, h, false, true)
    SetPedCanBeTargetted(npc, false)
    SetPedCanPlayAmbientAnims(npc, true)
    SetPedCanRagdollFromPlayerImpact(npc, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetModelAsNoLongerNeeded(model)
    SetPedCombatAttributes(npc, 46, true)
    SetPedFleeAttributes(npc, 0, 0)
    SetEntityAsMissionEntity(npc, true, true)
    SetPedCanRagdoll(npc, false)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedDiesWhenInjured(npc, false)
    SetPedCanPlayInjuredAnims(npc, false)
    SetPedGeneratesDeadBodyEvents(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    return npc
end

-- #endregion

-- #region events
RegisterNetEvent('gfx:lumberjack:cutTree')
AddEventHandler('gfx:lumberjack:cutTree', function()
    jobstarted = true
    StartLumberJack()
end)

RegisterNetEvent('gfx:client:lumberjack:Notify', function(msg)
    Notify(msg)
end)
-- #endregion

  

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(axe)
        DeleteEntity(tree)
        DeleteCheckpoint(checkpoint)
        RemoveBlip(blip1)
        RemoveBlip(blip2)
        RemoveBlip(nextblip)
        jobstarted = false
        currentTree = nil
        checkpoint = nil
        isCutting = false
        axe = nil
        bonus = 0
        workTime = nil
        tutorial = false
        tree = nil
        blip1 = nil
        blip2 = nil
        nextblip = nil
        ClearPedTasks(PlayerPedId())
    end
end)

