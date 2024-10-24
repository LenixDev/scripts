local QBCore = exports['qb-core']:GetCoreObject()

--- MU 𝐃𝐞𝐩𝐚𝐫𝐭𝐦𝐞𝐧𝐭

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
        local coord = vector4(-427.01, -1667.78, 18.03, 204.79)
        local hash = 's_m_y_dealer_01'
        loaded(hash)
        ped = CreatePed(4, hash, coord.x, coord.y, coord.z, coord.w, true, false)
        FreezeEntityPosition(ped, true)
        TaskWanderStandard(ped, 10, 10)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, 1)
        exports['qb-target']:AddTargetEntity(ped, { -- The specified entity number
            options = {
                {
                    type = "client",
                    event = "big:david",
                    icon = "fas fa-building",
                    label = "Big David",
                    job = "all",
                },
            },
            distance = 2.5
        })

end)


RegisterNetEvent("big:david",function() 
    SendNUIMessage({
        action = "open",
        title = "Big David",
        des = "Hello There"
    })
    SetNuiFocus(true,true)
    CamCreate(vector4(-427.01, -1667.78, 18.03, 204.79))
end)


RegisterNUICallback("givelockpick", function (data)
    print(data.item)
    TriggerServerEvent("give:lockpick", data.item)
    TriggerEvent("exitbigdavid")
end)
RegisterNUICallback("cancel", function ()
    TriggerEvent("exitbigdavid")
end)

RegisterKeyMapping('exitbigdavid', 'Exit Big David', 'keyboard', 'Escape')



RegisterNetEvent("exitbigdavid", function ()
    
    SetNuiFocus(false, false)
    DestroyCamera()
end)

