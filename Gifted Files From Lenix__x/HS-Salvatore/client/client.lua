local QBCore = exports['qb-core']:GetCoreObject()

--MADE-BY-CA

function GetOffsetFromCoordsAndHeading(coords, heading, offsetX, offsetY, offsetZ)
    local headingRad = math.rad(heading)
    local x = offsetX * math.cos(headingRad) - offsetY * math.sin(headingRad)
    local y = offsetX * math.sin(headingRad) + offsetY * math.cos(headingRad)
    local z = offsetZ

    local worldCoords = vector4(
        coords.x + x,
        coords.y + y,
        coords.z + z,
        heading
    )

    return worldCoords
end

function CamCreate(npc)
	cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
	local coordsCam = GetOffsetFromCoordsAndHeading(npc, npc.w, 0.0, 0.9, 1.60)
	local coordsPly = npc
	SetCamCoord(cam, coordsCam)
	PointCamAtCoord(cam, coordsPly['x'], coordsPly['y'], coordsPly['z']+1.60)
	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)
end

function DestroyCamera()
    RenderScriptCams(false, true, 500, 1, 0)
    DestroyCam(cam, false)
    SendNUIMessage({
        action = "close",
    })
end

local function loaded(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

CreateThread(function()   
        local coord = vector4(1379.57, 1147.29, 113.33, 98.82)
        local hash = 'u_m_o_tramp_01'
        loaded(hash)
        ped = CreatePed(4, hash, coord.x, coord.y, coord.z, coord.w, true, false)
        FreezeEntityPosition(ped, true)
        TaskWanderStandard(ped, 10, 10)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_DRINKING", 0, 1)
        exports['qb-target']:AddTargetEntity(ped, { -- The specified entity number
            options = {
                {
                    type = "client",
                    event = "salv:atore",
                    icon = "fas fa-building",
                    label = " GANG STORE ",
                    job = "all",
                },
            },
            distance = 2.5
        })
end)

RegisterNetEvent("salv:atore",function() 
    TriggerScreenblurFadeIn(1000)
    SendNUIMessage({
        action = "open",
        title = "Salvatore",
        des = "متأكد انو ماأحد",
    })
    SetNuiFocus(true,true)
    CamCreate(vector4(1378.16, 1147.28, 113.19, 88.25))
end)

RegisterNUICallback("givekey1", function (data)
    print(data.item)
    TriggerServerEvent("give:key1", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("givedrill", function (data)
    print(data.item)
    TriggerServerEvent("give:drill", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("givearmor", function (data)
    print(data.item)
    TriggerServerEvent("give:armor", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("giveweapon_pistol_mk2", function (data)
    print(data.item)
    TriggerServerEvent("give:weapon_pistol_mk2", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("cancel", function ()
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("givepistol_ammo", function (data)
    print(data.item)
    TriggerServerEvent("give:pistol_ammo", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("givesmg_ammo", function (data)
    print(data.item)
    TriggerServerEvent("give:smg_ammo", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("giverifle_ammo", function (data)
    print(data.item)
    TriggerServerEvent("give:rifle_ammo", data.item)
    TriggerEvent("exitSalvatore")
end)

RegisterNUICallback("cancel", function ()
    TriggerEvent("exitSalvatore")
    TriggerScreenblurFadeOut(1000)
end)

RegisterKeyMapping('exitSalvatore', 'Exit Salvatore', 'keyboard', 'Escape')

RegisterNetEvent("exitSalvatore", function ()
    SetNuiFocus(false, false)
    DestroyCamera()
end)


















--MADE-BY-ca