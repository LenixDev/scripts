local peds = {}
local intalk
local camera

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('nc:pload:npctalk', function()
    CreateInterActivePeds()
end)

RegisterNetEvent('nc:talktonpc', function()
    local ped = PlayerPedId()   
    local pedCoords = GetEntityCoords(ped)
    
    for k, v in pairs(Config.Peds) do
        local distance = math.floor(#(pedCoords - vector3(v.coords.x, v.coords.y, v.coords.z)))
        if distance <= v.interactive.distance then
            openModal(k)
        end
    end 
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        CreateInterActivePeds()
    end
end)

-----------------------------------------------------------------------------------------
-- NUI CALLBACK'S --
-----------------------------------------------------------------------------------------

RegisterNUICallback('modalClose', function(data, cb)
    closeModal()
    cb('ok')
end)

RegisterNUICallback('modalCallback', function(data, cb)
    local option = Config.Peds[intalk]["options"][data.option]
    if option.server then
        TriggerServerEvent(option.event, option.argument)
    elseif option.client then
        TriggerEvent(option.event, option.argument)
    end
    closeModal()
    cb('ok')
end)

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

function CreateInterActivePeds()
    if next(peds) ~= nil then
        for k, v in pairs(peds) do
            -- ox_target:removeModel(v)
            DeleteEntity(v)
        end
    end

    for k, v in pairs(Config.Peds) do
        local hash = joaat(v.model)

        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(100)
        end

        ped = CreatePed(4, hash, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
        PlaceObjectOnGroundProperly(ped)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityAsMissionEntity(ped, false, false)
        SetPedCanPlayAmbientAnims(ped, false) 
        setPedAnimation(ped, v.animName, v.animDict, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)

        peds[k] = ped

        if v.interactive.type == "target" then
            if GetResourceState('ox_target') == 'started' then
                exports.ox_target:addModel(hash, {
                    [1] = {
                        name = 'talknpc',
                        event = 'nc:talktonpc',
                        icon = v.interactive.icon,
                        label = v.interactive.text,
                    }
                })
            elseif GetResourceState('qb-target') == 'started' then
                exports['qb-target']:AddTargetModel(hash, {
                    options = {
                        {
                            type = "client",
                            event = "nc:talktonpc",
                            icon = v.interactive.icon,
                            label = v.interactive.text,
                        },
                    },
                    distance = v.interactive.distance
                })
            end
        end
    end
end

function setPedAnimation(ped, name, dic, loop)
    RequestAnimDict(dic)
    while not HasAnimDictLoaded(dic) do
        Wait(500)
    end

    TaskPlayAnim(ped, dic, name, 8.0, 8.0, -1, 1, 0, false, false, false)
end

function openModal(index)
    intalk = index
    cameraAnimation(index)
    local ped = Config.Peds[index]
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "OPEN_MODAL",
        name = ped.name,
        job = ped.title,
        text = ped.question,
        buttons = ped.options,
    })
end

function closeModal()
    closeText(intalk)
    closeMarker(intalk)
    SetNuiFocus(false, false)
    SendNUIMessage({type = "CLOSE_MODAL"})
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(camera, false)
    camera = nil
    intalk = nil
end

function cameraAnimation(index)
    local p = promise:new()
    local npcCoords = Config.Peds[index].cam
    local playerCoords = GetEntityCoords(PlayerPedId())
    SetTimecycleModifier("int_extlight_small_sets")

    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", playerCoords, 0.0, 0.0, 0.0, 90.0, false, 2)
    SetCamActive(camera, true)
    RenderScriptCams(true, true, 550, true, true)
    SetCamUseShallowDofMode(camera, true)
    SetCamNearDof(camera, 0)
    SetCamFarDof(camera, 1.1)
    SetCamDofStrength(camera, 0.1)

    p:resolve(AnimateCameraToPosition(playerCoords, npcCoords, 250))
    return Citizen.Await(p)
end

function AnimateCameraToPosition(startcoords, targetCoords, duration)
    local startCoords = startcoords
    local startTime = GetGameTimer()
    local endTime = startTime + duration

    CreateThread(function()
        while GetGameTimer() < endTime do
            local progress = (GetGameTimer() - startTime) / duration
            local easingProgress = progress
            local x = Lerp(startCoords.x, targetCoords.x, easingProgress)
            local y = Lerp(startCoords.y, targetCoords.y, easingProgress)
            local z = Lerp(startCoords.z, targetCoords.z, easingProgress)
            SetCamCoord(camera, x, y, z)
            Wait(0)
        end
    end)

    SetCamRot(camera, 0.0, 0.0, targetCoords.w)
    return true
end

function Lerp(start, stop, amount)
    return start + (stop - start) * amount
end

function GetScreenPosition(entity, bool, distance)
    if bool then
        local entityCoord = GetEntityCoords(entity)
        local min, max = GetModelDimensions(GetEntityModel(entity))
        local height = (max.y - min.y) / 2
        local onScreen, coordX, coordY = GetHudScreenPositionFromWorldPosition(entityCoord.x, entityCoord.y + height, entityCoord.z)
        return onScreen, coordX -0.035, coordY -0.08, entity, distance
    else
        local entityCoord = GetEntityCoords(entity)
        local min, max = GetModelDimensions(GetEntityModel(entity))
        local height = (max.y - min.y) / 2
        local onScreen, coordX, coordY = GetHudScreenPositionFromWorldPosition(entityCoord.x, entityCoord.y + height, entityCoord.z)
        return onScreen, coordX -0.01, coordY -0.01, entity, distance
    end
end

function uiMarker(_, x, y, i, distance)
    SendNUIMessage({
        type = "ADD_MARKER",
        position = {
            x = x, 
            y = y,
            d = distance
        },
        index = tostring(i)
    })
end

function uiText(_, x, y, i, text, label)
    SendNUIMessage({
        type = "ADD_TEXT",
        content = {
            x = x, 
            y = y,
            t = text,
            l = label
        },
    })
end

function closeMarker(i)
    Config.Peds[i].interactive.markerState = false
    SendNUIMessage({
        type = "REMOVE_MARKER",
        index = tostring(peds[i])
    })    
end

function closeText(i)
    Config.Peds[i].interactive.interactiveState = false
    SendNUIMessage({
        type = "REMOVE_TEXT",
        index = tostring(peds[i])
    })
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.20, 0.20)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- THREAD'S --
-----------------------------------------------------------------------------------------

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        if intalk ~= nil then
            sleep = 7
            DisableAllControlActions()
            local coords = GetEntityCoords(ped)
            local distance = math.floor(#(coords - vector3(Config.Peds[intalk].coords.x, Config.Peds[intalk].coords.y, Config.Peds[intalk].coords.z)))
            if GetEntityHealth(ped) <= 0 or IsPedRagdoll(ped) then
                if (intalk) and distance > Config.Peds[intalk].interactive.distance then
                    closeModal()
                end
                closeModal()
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 550
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        if intalk == nil then
            for k, v in pairs(Config.Peds) do
                local distance = math.floor(#(pedCoords - vector3(v.coords.x, v.coords.y, v.coords.z)))
                if distance <= v.interactive.drawmarker_distance then
                    sleep = 7
                    if v.interactive.uiMarker then
                        if not v.interactive.interactiveState then
                            uiMarker(GetScreenPosition(peds[k], false, distance))
                            v.interactive.markerState = true
                        else
                            closeMarker(k)
                        end
                    else
                        if not HasStreamedTextureDictLoaded("marker") then
                            RequestStreamedTextureDict("marker", true)
                            while not HasStreamedTextureDictLoaded("marker") do
                                Wait(1)
                            end
                            return
                        end

                        if not v.interactive.interactiveState then
                            local markerWidth = (distance / v.interactive.drawmarker_math) * 1.5
                            DrawMarker(9, v.markerCoord.x, v.markerCoord.y, v.markerCoord.z, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, markerWidth, markerWidth, markerWidth, 255, 255, 255, 255, false, true, 0, false, "marker", "interactive", false)
                        end
                    end

                    if v.interactive.type ~= "target" then
                        if distance <= v.interactive.distance then
                            if v.interactive.uiDrawText then
                                v.interactive.interactiveState = true
                                local _, x, y, e, d = GetScreenPosition(peds[k], true, distance)
                                uiText(nil, x, y, k, v.interactive.text, v.interactive.key_label)
                            else
                                DrawText3D(v.markerCoord.x, v.markerCoord.y, v.markerCoord.z, v.interactive.text)
                            end
                            if IsControlJustPressed(0, v.interactive.type) then
                                openModal(k)
                            end
                        elseif v.interactive.interactiveState then
                            closeText(k)
                        end
                    end
                elseif v.interactive.markerState then
                    closeMarker(k)
                end
            end
        end

        Wait(sleep)
    end
end)
