local QBCore = exports['qb-core']:GetCoreObject()
local Has = false
local Toggle = false
local DashboardToggle = false

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
        Playerjob = QBCore.Functions.GetPlayerData().job
        Wait(100)
        if Playerjob.name == "police" then
            TriggerServerEvent('qb-policehub:server:policejoined')
            IsCop = true
            SendNUIMessage({
                action = 'refreshmyinfo',
                UISoundEffects = false,
                mousestreet = false,
                boss = false,
                serverid = GetPlayerServerId(PlayerId()),
                myduty = QBCore.Functions.GetPlayerData().job.onduty,
                enablealerts = false,
                alertssound = false,
            })
        end
        isLoggedIn = true
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    Playerjob = QBCore.Functions.GetPlayerData().job
    Wait(100)
    if Playerjob.name == "police" then
        TriggerServerEvent('qb-policehub:server:policejoined')
        IsCop = true
        SendNUIMessage({
            action = 'refreshmyinfo',
            UISoundEffects = false,
            mousestreet = false,
            boss = false,
            serverid = GetPlayerServerId(PlayerId()),
            myduty = QBCore.Functions.GetPlayerData().job.onduty,
            enablealerts = false,
            alertssound = false,
        })
        isLoggedIn = true
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if IsCop then
        IsCop = false
        isLoggedIn = false
    end
end)

RegisterNetEvent(Config.JobUpdateEvent, function()
    if not isLoggedIn then
        return
    end
    if QBCore.Functions.GetPlayerData().job.name ~= "police" and IsCop then
        IsCop = false
        TriggerServerEvent('qb-policehub:server:policeremove')
    elseif QBCore.Functions.GetPlayerData().job.name == "police" and not IsCop then
        IsCop = true
        TriggerServerEvent('qb-policelist:server:ref')
    elseif QBCore.Functions.GetPlayerData().job.name == "police" then
        TriggerServerEvent('qb-policelist:server:ref')
    end
end)

RegisterNetEvent('qb-policehub:client:datanewplayer', function(data)
    Wait(50)
    SendNUIMessage({
        action = 'refreshhub',
        ['MenuText'] = Config.MenuText,
        officers = data,
    })
    Wait(50)
    SendNUIMessage({
        ['cams'] = Config.SecurityCameras,
        ['typing'] = 'all',
        ['action'] = 'showcamss',
    })
end)

RegisterCommand('hub', function()
    if IsCop and isLoggedIn then
        if not Toggle then
            Toggle = true
            SendNUIMessage({
                action = 'openhub',
                UISoundEffects = false,
                mousestreet = false,
                boss = false,
                serverid = GetPlayerServerId(PlayerId()),
                myduty = QBCore.Functions.GetPlayerData().job.onduty,
                enablealerts = false,
                alertssound = false,
            })
        else
            Toggle = false
            SendNUIMessage({
                action = 'closehub',
            })
        end
    end
end, false)

RegisterCommand('hub1', function()
    if IsCop and isLoggedIn and Toggle then
        if Has == true then
            Has = false
        else
            Has = true
        end
        SetNuiFocus(Has, Has)
        SendNUIMessage({
            action = 'mouses',
            data = Has,
        })
    end
end, false)


RegisterKeyMapping('hub1', 'Mark last police report', 'keyboard', "F11")
RegisterKeyMapping('hub', 'Open Phub', 'keyboard', "H")

RegisterNuiCallback('closenui', function(data, cb)
    if DashboardToggle then
        SendNUIMessage({ ['action'] = 'closecams' })
        return
    end
    Has = false
    SetNuiFocus(Has, Has)
    SendNUIMessage({
        action = 'mouses',
        data = Has,
    })
    cb(true)
end)

RegisterNetEvent('qb-policehub:client:openCams', function()
    if Toggle then
        SendNUIMessage({ action = 'opendashborad' })
        Wait(250)
        SetNuiFocus(DashboardToggle, DashboardToggle)
    else
        QBCore.Functions.Notify('You Must To Open The Police Hub First', 'error')
    end
end, false)

RegisterNuiCallback('SetPlayerPoint', function(Data, cb)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-policehub:server:GetPlayerLocation', function(data)
        p:resolve(data)
    end, Data.playerid)
    local position = Citizen.Await(p)
    SetNewWaypoint(position.x, position.y)
    QBCore.Functions.Notify("Waypoint set to this officer !", "success")
    cb(true)
end)

RegisterNuiCallback('SendRequest', function(Data, cb)
    TriggerServerEvent('PlayerSendRequest', Data)
    cb(true)
end)

RegisterNuiCallback('BodyCamHub', function(Data, cb)
    TriggerEvent('bcam:Watch', tonumber(Data['playeridnumber']))
    cb(true)
end)

RegisterNuiCallback('ChangeCallsign', function(Data, cb)
    TriggerServerEvent('qb-policehub:server:changeCallsign', Data.callsign)
    cb(true)
end)

RegisterNuiCallback('ChangeDuty', function(Data, cb)
    TriggerServerEvent('qb-policehub:server:updatestatus', Data.status)
    cb(true)
end)


RegisterNetEvent('PlayerSendRequest', function(message, cb)
    SendNUIMessage({
        action = 'newmessage',
        message = message,
    })
    cb(true)
end)


RegisterNUICallback("joinradiofreq", function(data, cb)
    if data.number then
        exports[Config.VoiceScript]:setVoiceProperty("radioEnabled", true)
        exports[Config.VoiceScript]:setRadioChannel(0)
        exports[Config.VoiceScript]:setRadioChannel(data.number)
        QBCore.Functions.Notify("connected to Radio " .. data.number .. "!", "success")
    else
        QBCore.Functions.Notify("This Officer Not In Radio !", "error")
    end
    cb(true)
end)


local cam = nil
local ctest = false
local watchedped = nil
local watching = false
local watchsource = nil
local popocam = false
local isincar = false
local camPlayers = {}

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, 50)
end

function ShowNotification(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0, 1)
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

local currAnim = nil
local currAnimDict = nil

function WatchinAnim()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local head = GetEntityHeading(ped)

    dict = 'anim@amb@board_room@diagram_blueprints@'
    name = 'look_around_02_amy_skater_01'
    loadAnimDict(dict)

    TaskPlayAnimAdvanced(ped, dict, name, pos.x, pos.y, pos.z, 0.0, 0.0, head, 1.0, 1.0, -1, 1, 0.0, 0, 0)
    currAnim = name
    currAnimDict = dict
end

function StopWatchin()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local head = GetEntityHeading(ped)

    dict = 'anim@amb@board_room@diagram_blueprints@'
    name = 'look_around_02_amy_skater_01'
    loadAnimDict(dict)

    StopAnimTask(ped, dict, name, 1.0)
end

local data = {}

function CreateACam(coords)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    RenderScriptCams(true, true, 0, true, false)
    SetCamCoord(cam, coords)
    Wait(100)
end

function CancelCam()
    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    RenderScriptCams(false, true, 0, true, false)
    DestroyCam(cam, false)
    SetFocusEntity(PlayerPedId())
    cteston = false

    DoScreenFadeIn(250)
end

function getpopos()
    local tdata
    QBCore.Functions.TriggerCallback('bcam:getpopos', function(killa)
        tdata = killa
    end)
    while tdata == nil do
        Wait(10)
    end
    return tdata
end

function getps()
    local tdata
    QBCore.Functions.TriggerCallback('bcam:getplayers', function(killa)
        tdata = killa
    end)
    while tdata == nil do
        Wait(10)
    end
    return tdata
end

function getp(daplayer)
    local tdata
    QBCore.Functions.TriggerCallback('bcam:getplayer', function(killa)
        tdata = killa
    end, daplayer)
    while tdata == nil do
        Wait(10)
    end
    return tdata
end

RegisterNetEvent("messy:camtoggle")
AddEventHandler('messy:camtoggle', function()
    popocam = not popocam
    PlayerData = QBCore.Functions.GetPlayerData()

    QBCore.Functions.Progressbar("bcamming", "Turning on Bodycam.", 1250, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "clothingtie",
        anim = "try_tie_neutral_d",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "clothingtie", "try_tie_neutral_d", 1.0)
        TriggerServerEvent("messy:camstatus")
    end, function() -- Cancel
        StopAnimTask(ped, "clothingtie", "try_tie_neutral_d", 1.0)

        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

local currped = nil
RegisterNetEvent("bcam:Watch")
AddEventHandler('bcam:Watch', function(arg)
    local ithim = getp(arg)
    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    SetFocusArea(ithim.coords.x, ithim.coords.y, ithim.coords.z, 0.0, 0.0, 0.0)
    CreateACam(ithim.coords)

    WatchinAnim()
    Wait(100)
    watching = true
    watchsource = arg

    while NetworkDoesEntityExistWithNetworkId(ithim.pednid) == false do
        Wait(100)
    end

    local netpedid = NetworkGetEntityFromNetworkId(ithim.pednid)
    currped = netpedid

    local bone = GetPedBoneIndex(netpedid, 31086)
    SetFocusEntity(netpedid)
    local head = GetEntityHeading(netpedid)

    AttachCamToPedBone(cam, netpedid, bone, 0.0, 0.48, 0.40, GetEntityHeading(netpedid))
    SetCamFov(cam, 95.0)
    SetCamNearClip(cam, 0.05)
    cteston = true
    SetCamRot(cam, vector3(-130.0, 0.0, head))
    watchedped = netpedid
    DoScreenFadeIn(250)
end)

RegisterNetEvent("bcam:UpdateWatch")
AddEventHandler("bcam:UpdateWatch", function(d)
    local src = source
    camPlayers = d
end)

RegisterNetEvent("inventory:client:UpdatePlayerInventory")
AddEventHandler("inventory:client:UpdatePlayerInventory", function(t, i)
    local src = source
end)



CreateThread(function()
    while true do
        if cteston then
            if IsPedInAnyVehicle(currped, false) and isincar == false then
                isincar = true
                local bone = GetPedBoneIndex(currped, 31086)
                local head = GetEntityHeading(currped)
                AttachCamToPedBone(cam, currped, bone, 0.0, 0.48, 0.60, GetEntityHeading(currped))
                SetCamRot(cam, vector3(0.0, 0.0, head))
            elseif IsPedInAnyVehicle(currped, false) == false and isincar == true then
                isincar = false
                local bone = GetPedBoneIndex(currped, 31086)
                local head = GetEntityHeading(currped)
                AttachCamToPedBone(cam, currped, bone, 0.0, 0.48, 0.40, GetEntityHeading(currped))
                SetCamRot(cam, vector3(-130.0, 0.0, head))
            end
            ShowHelpNotification("Press ~INPUT_CELLPHONE_CANCEL~ to Cancel.")
            if (IsControlJustPressed(0, 177) or IsControlJustPressed(0, 200) or IsControlJustPressed(0, 202)) then
                StopWatchin()
                watching = false
                CancelCam()
            end
            if watching then
                if IsEntityPlayingAnim(PlayerPedId(), currAnimDict, currAnim, 3) == false then
                    StopWatchin()
                    watching = false
                    CancelCam()
                end
                if camPlayers[watchsource] == false then
                    StopWatchin()
                    watching = false

                    CancelCam()
                    watchsource = nil
                end
            end

            ped = watchedped
            pos = GetEntityCoords(watchedped)
            local ghead = GetEntityHeading(watchedped)
            SetCamRot(cam, vector3(-10.0, 0.0, ghead))
        end

        Wait(1)
    end
end)


RegisterNUICallback("OpenCam", function(this, cb)
    SetUpCams(this)
    cb(true)
end)

RegisterNUICallback("Gettablecams", function(this, cb)
    cb(Config.SecurityCameras[this.cam + 1])
end)

RegisterNUICallback("TakeBusy", function(this, cb)
    TriggerServerEvent('qb-policehub:server:updateDispatch', this.status)
    cb(true)
end)

RegisterNUICallback("GetTime", function(this, cb)
    QBCore.Functions.TriggerCallback('get time data', function(Time)
        cb(Time)
    end)
end)
RegisterNUICallback("dashboardstate", function(this, cb)
    DashboardToggle = this.state
    cb(true)
end)

function SetUpCams(mydata)
    if mydata.close then
        ToggleCarSpeed = false
        Wait(80)
        ClearTimecycleModifier("helicamfirst", 4.2)
        RenderScriptCams(false)
        SetFocusEntity(GetPlayerPed(-1))
        return
    end
    SavedRx = 324.768662452698
    SavedRz = Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].h
    SavedFov = 88.00
    CurrentRx = 324.768662452698
    CurrentRz = Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].h
    CurrentFov = 88.00
    WhichCategory = Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].Type
    CameraCoords = vector3(Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].x,
        Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].y,
        Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1]
        .z)
    CurrentX = Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].x
    CurrentY = Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].y
    CurrentZ = Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].z

    SetTransitionTimecycleModifier(Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].CamType, 0)
    SetTimecycleModifierStrength(2.28)
    local pcoords = GetEntityCoords(PlayerPedId())
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pcoords.x, pcoords.y, pcoords.z, 355.22, 0.0, 20.52, 50.00, true,
        2)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",
        Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].x,
        Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].y,
        Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].z, 324.768662452698, 0.0,
        Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1].h, 88.00, false, 0)
    RenderScriptCams(1, 1, 0, 0, 0)
    SetCamActiveWithInterp(cam2, cam, 0, 10, 2)
    SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
    SetTimecycleModifierStrength(json.decode(Config.SecurityCameras[tonumber(mydata.locate)].cams[mydata.camnumber + 1]
        .CamStrength))
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '' .. k .. '' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

-- #discord.gg/2q8eaAynAf
 -- #discord.gg/2q8eaAynAf
   -- #discord.gg/2q8eaAynAf
    -- #discord.gg/2q8eaAynAf
      -- #discord.gg/2q8eaAynAf
    -- #discord.gg/2q8eaAynAf
  -- #discord.gg/2q8eaAynAf
   -- #discord.gg/2q8eaAynAf
    -- #discord.gg/2q8eaAynAf
 -- #discord.gg/2q8eaAynAf
   -- #discord.gg/2q8eaAynAf
     -- #discord.gg/2q8eaAynAf