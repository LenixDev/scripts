Framework = Config.CoreExport()
local Houses = {
    ["small"] = "modernhotel_shell",
    ["medium"] = "furnitured_midapart",
    ["big"] = "shell_michael",
}

function TriggerServerCallback(...)
    if Config.Framework == "qb" then
        Framework.Functions.TriggerCallback(...)
    else
        Framework.TriggerServerCallback(...)
    end
end

function CreateNPCBlip()
    Blip = AddBlipForCoord(Config.Ped.Position.x, Config.Ped.Position.y, Config.Ped.Position.z)
    SetBlipSprite(Blip, 40)
    SetBlipColour(Blip, 2)
    SetBlipScale(Blip, 0.8)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("House Cleaning Job")
    EndTextCommandSetBlipName(Blip)
end

function CreateMissionBlip()
    Mission.Blip = AddBlipForCoord(Mission.data.HouseEntrance.x, Mission.data.HouseEntrance.y, Mission.data.HouseEntrance.z)
    SetBlipSprite(Mission.Blip, 40)
    SetBlipColour(Mission.Blip, 3)
    SetBlipScale(Mission.Blip, 0.8)
    SetBlipAsShortRange(Mission.Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("House Cleaning Mission")
    EndTextCommandSetBlipName(Mission.Blip)
end

function DrawText(text, duration)
    AddTextEntry('esxHelpNotification', text)
    BeginTextCommandDisplayHelp('esxHelpNotification')
    EndTextCommandDisplayHelp(0, false, true, duration or -1)
end

function GetClosestCleaningPosition(coords)
    local closestDistance = -1
    local closestPosition = nil

    for _, position in pairs(Positions) do
        local distance = #(coords - position.coords)

        if closestDistance == -1 or closestDistance > distance then
            closestDistance = distance
            closestPosition = position
        end
    end

    return closestPosition
end

function StartJob()
    Mission.Started = true
    CreateProps(Positions)
end

function CreateProps()
    for _, position in pairs(Positions) do
        local model = position.type == "trash" and "prop_cs_rub_binbag_01" or position.type == "mop" and "prop_tool_mopbucket"

        if position.type == "trash" or position.type == "mop" then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(100)
            end
    
            local prop = CreateObject(model, position.coords.x, position.coords.y, position.coords.z - 1, false, false, false)
            FreezeEntityPosition(prop, true)
            SetEntityAsMissionEntity(prop, true, true)
            position.prop = prop
        end
    end
end

function EnterHouse()
    TriggerServerEvent("aty_housecleaning:enterHouse")

    DoScreenFadeOut(500)
    Wait(1000)
    CreateHouse()
    
    Mission.EnteredHouse = true
    local ped = PlayerPedId()
    RequestCollisionAtCoord(SpawnCoords.x, SpawnCoords.y, SpawnCoords.z)
    SetEntityCoords(ped, SpawnCoords.x, SpawnCoords.y, SpawnCoords.z)
    SetEntityHeading(ped, SpawnCoords.w)
    SetGameplayCamRelativeHeading(0.0)
    
    Wait(1000)
    DoScreenFadeIn(500)
end

function CreateHouse()
    local model = Houses[HouseType]

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    Mission.House = CreateObject(model, 272.39, -1894.31, -19.15, false, false, false)
    FreezeEntityPosition(Mission.House, true)
end

function FinishMission()
    Mission.Started = false
    Mission.Finisihed = false
    RemoveBlip(Mission.Blip)
    DeleteEntity(Mission.House)
    TriggerServerEvent("aty_housecleaning:finishMission")
    Mission.data = nil
    Mission.Blip = nil
    Mission.House = nil
    Config.Notify("You have finished the mission, you can start a new one.")
end

function PlayCleaningAnim(type)
    local anim = ""
    local dict = ""
    local length = 0
    local ped = PlayerPedId()

    if type == "mop" then
        dict = "move_mop"
        anim = "idle_scrub_small_player"
        length = 8000
        CreateMopProp()
    elseif type == "trash" then
        dict = "random@domestic"
        anim = "pickup_low"
        length = 1300
        HasTrash = true
    elseif type == "wipe" then
        dict = "amb@world_human_maid_clean@base"
        anim = "base"
        length = 5000
    end

    LoadAnimation(dict)

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, length, 1, 0, false, false, false)
    Wait(length)
    DeleteEntity(TrashProp)
    DeleteEntity(MopProp)
    if type == "trash" then
        TrashCaringAnim()
        Config.Notify("You have picked up the trash, throw it from the door.")
    end
end

function TrashCaringAnim()
    FreezeEntityPosition(PlayerPedId(), true)
    LoadAnimation("missfbi4prepp1")
    TaskPlayAnim(PlayerPedId(), 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    TrashProp = CreateObject(`prop_cs_rub_binbag_01`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(TrashProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
    FreezeEntityPosition(PlayerPedId(), false)
end

function CreateMopProp()
    local model = "prop_cs_mop_s"

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    MopProp = CreateObject(model, 0, 0, 0, true, true, true)
    AttachEntityToEntity(MopProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.1200, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

function LoadAnimation(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(100)
        end
    end
end

function CreatePedOnCoord(pedHash, x, y, z, w)
    local pedHashKey = GetHashKey(pedHash)

    RequestModel(pedHashKey)
    while not HasModelLoaded(pedHashKey) do
        Wait(0)
    end

    local ped = CreatePed(0, pedHashKey, x, y, z - 1, w, false, true)

    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end