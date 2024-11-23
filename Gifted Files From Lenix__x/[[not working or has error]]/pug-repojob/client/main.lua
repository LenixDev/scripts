print"Pug-RepoJob 1.0.6"
local FlatBetData = {}
local ChangingBedState = false
local RandomVehicleSpawn = nil
local DoingRepoRun = false
local RepoVehicle = nil
local RepoPlate = nil
local TowTruckVehicle = nil
local spawnedRope = nil
local HookAtatched = false
local HasDrawnText = false
local WindingTow = false
local hookModel = "prop_rope_hook_01"
local TransVal = 0.0
local RepoRank
local MainTowTruckHook
local FlatBedModel
local HookedOnVehicle

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if Config.Target == "ox_target" then
            if DropOffPed then
                exports.ox_target:removeLocalEntity(DropOffPed,Config.LangT["SignRepoPaperwork"])
            end
            if Bench then
                exports.ox_target:removeLocalEntity(Bench,Config.LangT["CraftParts"])
            end
            if RepoMan then
                exports.ox_target:removeLocalEntity(RepoMan,Config.LangT["RepoJob"])
            end
        else
            if DropOffPed then
                exports[Config.Target]:RemoveTargetEntity(DropOffPed,Config.LangT["SignRepoPaperwork"])
            end
            if Bench then
                exports[Config.Target]:RemoveTargetEntity(Bench,Config.LangT["CraftParts"])
            end
            if RepoMan then
                exports[Config.Target]:RemoveTargetEntity(RepoMan, Config.LangT["RepoJob"])
            end
        end
    end
end)

-- Functions
-- Change this to your notification script if needed
function RepoJobNotify(msg, type, length)
	if Framework == "ESX" then
		FWork.ShowNotification(msg)
	elseif Framework == "QBCore" then
    	FWork.Functions.Notify(msg, type, length)
	end
end

RegisterNetEvent("Pug:client:RepoNotifyEvent", function(msg, type, length)
	RepoJobNotify(msg, type, length)
end)

-- Change this to whatever your server drawtext is.
function DrawTextRepoJob(text)
	if Framework == "QBCore" then
		exports[Config.CoreName]:DrawText(text, 'left')
	else
		FWork.TextUI(text, "error")
	end
end

-- Change this to whatever your server hidetext is.
function HideDrawTextRepoJob(text)
	if Framework == "QBCore" then
		exports[Config.CoreName]:HideText()
	else
		FWork.HideUI()
	end
end

-- Change this to your phone email script if needed
function RepoJobEmail(VehName)
	if Config.Phone == "renewed" or Config.Phone == "qb" then
		TriggerServerEvent('qb-phone:server:sendNewMail', {
			sender = Config.LangT["EmailSender"],
			subject = Config.LangT["EmailSubject"]..VehName,
			message = Config.LangT["EmailMessage1"] .. VehName .. Config.LangT["EmailMessage2"]..RepoPlate..".",
		})
	elseif Config.Phone == "quasar" then
		TriggerServerEvent('qb-phone:server:sendNewMail', {
			sender = Config.LangT["EmailSender"],
			subject = Config.LangT["EmailSubject"]..VehName,
			message = Config.LangT["EmailMessage1"] .. VehName .. Config.LangT["EmailMessage2"]..RepoPlate..".",
		})
    elseif Config.Phone == "lb" then
		TriggerServerEvent("Pug:Server:SendLbPhoneMailTowJob", VehName, RepoPlate)
	end
end

function GetItemsInformation(I, bool)
	if Framework == "QBCore" then
		if FWork.Shared.Items[I] ~= nil then
            if bool then
			    return FWork.Shared.Items[I].label
            else
                return FWork.Shared.Items[I]
            end
		else
			return I
		end
	else
		return I
	end
end

local function ChoppingToggleItem(bool, item, amount, info)
	return TriggerServerEvent("Pug:server:ToggleRepoItem", bool, item, amount, info)
end

local function PugLoadModel(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

local function LoadModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do Wait(1) end
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function TransInterperate(a, b, t)
	return a + (b - a) * t
end

local function RemoveRope()
	RopeUnloadTextures()
	DeleteRope(SpawnedRope)
	SpawnedRope = nil
end
local function HandleRopeProperly()
    local CurrentLength = RopeGetDistanceBetweenEnds(SpawnedRope)
    RopeForceLength(SpawnedRope, CurrentLength)
    SetRopeLengthChangeRate(SpawnedRope, 0.5)
    StartRopeWinding(SpawnedRope)
    Wait(100)
end

local function Trim(value)
	if not value then return nil end
	return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end
function GetPlate(vehicle)
	if vehicle == 0 then return end
    return Trim(GetVehicleNumberPlateText(vehicle))
end

local function PugSpawnVehicle(model, cb, coords, isnetworked, teleportInto)
    local ped = PlayerPedId()
    model = type(model) == 'string' and GetHashKey(model) or model
    if not IsModelInCdimage(model) then return end
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    isnetworked = isnetworked == nil or isnetworked
    PugLoadModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, isnetworked, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(netid, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehicleFuelLevel(veh, 100.0)
    SetModelAsNoLongerNeeded(model)
    if teleportInto then TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) end
    if cb then cb(veh) end
end

local function PugGetClosestVehicle()
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    local coords = GetEntityCoords(ped)
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

local function PugGetClosestTowTruck()
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    local coords = GetEntityCoords(ped)
    for i = 1, #vehicles, 1 do
        if GetEntityModel(vehicles[i]) == GetHashKey("flatbed3") then
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = #(vehicleCoords - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestVehicle = vehicles[i]
                closestDistance = distance
            end
        end
    end
    return closestVehicle, closestDistance
end

RegisterCommand("toggletow", function()
    if IsPedInAnyVehicle(PlayerPedId()) then
        local Vehicle = GetVehiclePedIsIn(PlayerPedId())
        if GetEntityModel(Vehicle) == GetHashKey("flatbed3") then
            MainTowTruckHook = Vehicle
            local Plate = GetPlate(Vehicle)
            if not FlatBetData[Plate] then
                FlatBetData[Plate] = {
                    FlatBed = nil,
                    status = 0,
                    Lowered = false,
                }
            end
            local state = FlatBetData[Plate].status
            if state == 0 then
                TriggerEvent("Pug:client:LowerTruck")
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "flatbedsound", 0.4)
                FlatBetData[Plate].status = 1
            else
                if state == 3 or not ChangingBedState then
                    if not ChangingBedState then
                        TriggerEvent("Pug:client:LowerTruck")
                        FlatBetData[Plate].status = 4
                        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "flatbedsound", 0.4)
                    else
                        RepoJobNotify(Config.LangT["Wait"], "error")
                    end
                else
                    RepoJobNotify(Config.LangT["NotLoweredOrRaised"], "error")
                end
            end
        end
    end
end)

RegisterCommand("towhook", function()
    local Ped = PlayerPedId()
    if not IsPedInAnyVehicle(Ped) then
        local IsHookOut = false
        for k, v in pairs(GetGamePool('CObject')) do
            if GetEntityModel(v) == GetHashKey(hookModel) then
                if IsEntityAttachedToEntity(PlayerPedId(), v) then
                    -- If the hook is already in the player hand
                    local PlyCoords = GetEntityCoords(Ped)
                    local Vehicle = PugGetClosestVehicle()
                    local bootDst = GetEntityBonePosition_2(Vehicle,25)
                    if #(PlyCoords - bootDst) <= 2.0 and GetEntityModel(Vehicle) == GetHashKey("flatbed3") then
                        -- Returning the hook to the flatbed
                        ClearPedTasksImmediately(Ped)
                        TaskTurnPedToFaceCoord(Ped, bootDst, 1500)
                        Wait(800)
                        DrawTextRepoJob(Config.LangT["GrabHook"], 'left')
                        loadAnimDict("random@domestic")
                        TaskPlayAnim(Ped, 'random@domestic' ,'pickup_low' ,8.0, -8.0, 10000, 16, 0, false, false, false)
                        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "lockpick", 5.0)
                        Wait(800)
                        RemoveRope()
                        SetEntityAsMissionEntity(v, true, true)
                        DeleteObject(v)
                        DeleteEntity(v)
                        HookAtatched = false
                        WindingTow = false
                    else
                        local FoundAbove = false
                        -- If there is a hood nearby attach the hook to the hood or drop it on the ground
                        local Vehicle = PugGetClosestVehicle()
                        local BoneCount = GetEntityBoneCount(Vehicle)
                        for i=1, BoneCount do
                            local bootDst = GetWorldPositionOfEntityBone(Vehicle, i)
                            local PlyCoords = GetEntityCoords(Ped)
                            if #(PlyCoords - bootDst) <= 1.0 then 
                                FoundAbove = true
                                ClearPedTasksImmediately(Ped)
                                TaskTurnPedToFaceCoord(Ped, bootDst, 1500)
                                Wait(700)
                                loadAnimDict("random@domestic")
                                TaskPlayAnim(Ped, 'random@domestic' ,'pickup_low' ,8.0, -8.0, 10000, 16, 0, false, false, false)
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "lockpick", 5.0)
                                Wait(800)
                                local HookCoords = bootDst
                                local FlatBedCoods = GetEntityBonePosition_2(MainTowTruckHook,25)
                                local CurrentLength = RopeGetDistanceBetweenEnds(SpawnedRope)
                                HandleRopeProperly()
                                local CurrentLength = RopeGetDistanceBetweenEnds(SpawnedRope)
                                AttachEntitiesToRope(SpawnedRope, Vehicle, FlatBedModel, HookCoords.x, HookCoords.y, HookCoords.z, FlatBedCoods.x, FlatBedCoods.y, FlatBedCoods.z, CurrentLength)
                                AttachEntityToEntity(v, Vehicle, GetEntityBoneIndexByName(Vehicle, "overheat"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                StopRopeWinding(SpawnedRope)
                                HookAtatched = true
                                WindingTow = false
                                HookedOnVehicle = Vehicle
                                if Config.AutomaticallHookVehicle then
                                    TriggerEvent("Pug:client:CheclVehicleOnBedStatus")
                                end
                                break
                            end
                        end
                        if not FoundAbove then
                            -- drop it on the ground
                            HandleRopeProperly()
                            DetachEntity(v, true, true)
                            Wait(500)
                            StopRopeWinding(SpawnedRope)
                            HookAtatched = false
                        end
                    end
                    IsHookOut = true
                    break
                else
                    -- pick the hook up if it is on a car or on the ground
                    local PlyCoords = GetEntityCoords(Ped)
                    local ItemCoords = GetEntityCoords(v)
                    if #(PlyCoords - ItemCoords) <= 2.0 then 
                        ClearPedTasksImmediately(Ped)
                        TaskTurnPedToFaceCoord(Ped, ItemCoords, 1500)
                        Wait(700)
                        loadAnimDict("random@domestic")
                        TaskPlayAnim(Ped, 'random@domestic' ,'pickup_low' ,8.0, -8.0, 10000, 16, 0, false, false, false)
                        if IsEntityAttachedToEntity(v, PugGetClosestVehicle()) then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "lockpick", 5.0)
                        end
                        Wait(800)
                        local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
                        local hookBone = GetPedBoneIndex(Ped, 57005) -- Right hand bone index
                        AttachEntityToEntity(v, Ped, hookBone, 0.15, 0.02, -0.03, -150.0, 40.0, 180.0, true, true, false, true, 1, true)
                        ItemCoords = GetEntityCoords(v)
                        HandleRopeProperly()
                        AttachEntitiesToRope(SpawnedRope, v, FlatBedModel, ItemCoords.x, ItemCoords.y, ItemCoords.z, bootDst.x, bootDst.y, bootDst.z, 1)
                        IsHookOut = true
                        Wait(500)
                        StopRopeWinding(SpawnedRope)
                        HookAtatched = false
                        WindingTow = false
                        break
                    end
                end
            end
        end
        if not IsHookOut then
            if not SpawnedRope then
                -- Pickup up ORIGINAL hook from the flatbed
                local PlyCoords = GetEntityCoords(Ped)
                local Vehicle = PugGetClosestTowTruck()
                if GetEntityModel(Vehicle) == GetHashKey("flatbed3") then
                    local Plate = GetPlate(Vehicle)
                    if FlatBetData[Plate] ~= nil then
                        local state = FlatBetData[Plate].status
                        if state == 3 then
                            MainTowTruckHook = Vehicle
                            local bootDst = GetEntityBonePosition_2(Vehicle,25)
                            if #(PlyCoords - bootDst) <= 2.9 then
                                DrawTextRepoJob(Config.LangT["ReturnHook"], 'left')
                                SpawnedRope = true
                                HookAtatched = false
                                WindingTow = false
                                ClearPedTasksImmediately(Ped)
                                TaskTurnPedToFaceCoord(Ped, bootDst, 1500)
                                Wait(800)
                                loadAnimDict("random@domestic")
                                TaskPlayAnim(Ped, 'random@domestic' ,'pickup_low' ,8.0, -8.0, 10000, 16, 0, false, false, false)
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "lockpick", 2.0)
                                Wait(800)
                                FlatBedModel = GetClosestObjectOfType(PlyCoords, 10.0, GetHashKey("inm_flatbed_base"), false, false, false)
                                local hook = CreateObject(GetHashKey(hookModel), 0.0, 0.0, 0.0, true, true, true)
                                while not DoesEntityExist(hook) do Wait(0) end
                                local hookBone = GetPedBoneIndex(Ped, 57005) -- Right hand bone index
                                AttachEntityToEntity(hook, Ped, hookBone, 0.15, 0.02, -0.03, -150.0, 40.0, 180.0, true, true, false, true, 1, true)
                                local HookCoords = GetEntityCoords(hook)
                                RopeLoadTextures() 
                                Wait(100)         --   X          Y          Z         rotx,roty,rotz,  mxlnth  ropeType  initLength  minLength  lengthChangeRate  onlyPPU  collisionOn lockFromFront
                                SpawnedRope = AddRope(bootDst.x, bootDst.y, bootDst.z,  0.0, 0.0, 0.0,   50.0,      4,       4.0,        1.0,            0.7,          0,        0,           0,        0, 0, 0)
                                SetRopeLengthChangeRate(SpawnedRope, 0.5)
                                AttachEntitiesToRope(SpawnedRope, hook, FlatBedModel, HookCoords.x, HookCoords.y, HookCoords.z, bootDst.x, bootDst.y, bootDst.z, 1)
                            end
                        end
                    end
                end
            end
        end
    end
end)
RegisterKeyMapping("towhook", "Toggle Tow Hook", "keyboard", 'E') 

RegisterKeyMapping("toggletow", "Toggle Tow", "keyboard", 'G') 


RegisterNetEvent("Pug:client:WindHitch", function()
    SetRopeLengthChangeRate(SpawnedRope, 0.7)
    StartRopeWinding(SpawnedRope)
    Wait(100)
    TriggerEvent("Pug:Clent:TowTruckRemoteMenu")
    WindingTow = true
    TriggerEvent("Pug:client:WindingTow")
end)
RegisterNetEvent("Pug:client:UnWindHitch", function()
    WindingTow = false
    StopRopeWinding(SpawnedRope)
    Wait(100)
    TriggerEvent("Pug:Clent:TowTruckRemoteMenu")
end)
RegisterNetEvent("Pug:client:WindingTow", function()
    while WindingTow do 
        if WindingTow then
            if HookAtatched then
                if #(GetEntityCoords(MainTowTruckHook) - GetEntityCoords(HookedOnVehicle)) >= 8.0 then
                    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "winchsound", 0.3)
                end
            else
                break
            end
        else
            break
        end
        Wait(1400)
    end
end)

RegisterNetEvent("Pug:client:CheclVehicleOnBedStatus", function(Vehicle)
    while HookAtatched do
        Wait(100)
        if HookAtatched then
            local VehCoords = GetEntityCoords(Vehicle)
            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
            if #(VehCoords - bootDst) <= 3.7 then
                if DoesEntityExist(FlatBedModel) then
                    if DoesEntityExist(Vehicle) and DoesEntityExist(FlatBedModel) then
                        local vehiclePos = GetEntityCoords(Vehicle)
                        local flatbedPos = GetEntityCoords(FlatBedModel)
                        local rotation = 180.0
                        if GetEntityHeading(MainTowTruckHook) + 35 >= GetEntityHeading(Vehicle) and GetEntityHeading(MainTowTruckHook) - 35 <= GetEntityHeading(Vehicle) then
                            rotation = 0.0
                        end
                        AttachEntityToEntity(Vehicle, FlatBedModel, 0, 0.0, 1.4, 0.38, 0.0, 0.0, rotation, false, false, false, true, 1, true)
                        HasDrawnText = false
                        HideDrawTextRepoJob()
                    end

                    HookAtatched = false
                    RemoveRope()
                    for _, v in pairs(GetGamePool('CObject')) do
                        if GetEntityModel(v) == GetHashKey(hookModel) then
                            if IsEntityAttachedToEntity(Vehicle, v) then
                                SetEntityAsMissionEntity(v, true, true)
                                DeleteObject(v)
                                DeleteEntity(v)
                            end
                        end
                    end
                    break
                end
            end
        end
    end
end)

RegisterNetEvent("Pug:client:AddVehicleToTruck", function(car)
    local Vehicle = car
    if GetEntityModel(Vehicle) == GetEntityModel(RepoVehicle) or GetEntityModel(Vehicle) == GetEntityModel(NetToVeh(RepoVehicle)) then
        print"updated"
        RepoVehicle = VehToNet(Vehicle)
    end
    local rotation = 180.0
    if GetEntityHeading(MainTowTruckHook) + 30 >= GetEntityHeading(Vehicle) and GetEntityHeading(MainTowTruckHook) - 30 <= GetEntityHeading(Vehicle) then
        rotation = 0.0
    end
    AttachEntityToEntity(Vehicle, FlatBedModel, 0, 0.0, 1.4, 0.38, 0.0, 0.0, rotation, true, true, false, true, 1, true)
    HookAtatched = false
    RemoveRope()
    for _, v in pairs(GetGamePool('CObject')) do
        if GetEntityModel(v) == GetHashKey(hookModel) then
            if IsEntityAttachedToEntity(Vehicle, v) then
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
                DeleteEntity(v)
            end
        end
    end
    Wait(100)
    TriggerEvent("Pug:Clent:TowTruckRemoteMenu")
end)

RegisterNetEvent("Pug:client:RemoveTowHook", function()
    HookAtatched = false
    WindingTow = false
    RemoveRope()
    for _, v in pairs(GetGamePool('CObject')) do
        if GetEntityModel(v) == GetHashKey(hookModel) then
            if IsEntityAttachedToEntity(HookedOnVehicle, v) then
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
                DeleteEntity(v)
            end
        end
    end
    Wait(100)
    TriggerEvent("Pug:Clent:TowTruckRemoteMenu")
end)

RegisterNetEvent("Pug:client:RemoveVehicleFromTruck", function(car)
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId())
    local CurrentPlate = GetPlate(PlayerVehicle)
    if FlatBetData[CurrentPlate].status == 3 then
        DetachEntity(car, true, true)
        Wait(100)
        TriggerEvent("Pug:Clent:TowTruckRemoteMenu")
        if GetEntityHeading(MainTowTruckHook) + 20 >= GetEntityHeading(car) and GetEntityHeading(MainTowTruckHook) - 20 <= GetEntityHeading(car) then
            SetVehicleForwardSpeed(car, -12.0)
        else
            SetVehicleForwardSpeed(car, 12.0)
        end
    else
        RepoJobNotify(Config.LangT["VehicleMustBeLowered"], "error")
    end
end)
local RemoteBeingUsed = false
RegisterNetEvent("Pug:Clent:TowTruckRemoteMenu", function()
    if not RemoteBeingUsed then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            RemoteBeingUsed = true
            local Ped = PlayerPedId()
            local RemoteBone = GetPedBoneIndex(Ped, 28422) -- Right hand bone index
            local Remote = CreateObject(GetHashKey("v_res_tre_remote"), GetEntityCoords(Ped))
            AttachEntityToEntity(Remote, Ped, RemoteBone, 0.0, 0.0, 0.0, -90.0, -190.0, 140.0, true, true, false, true, 1, true)
            loadAnimDict("cellphone@")
            TaskPlayAnim(Ped, 'cellphone@' ,'cellphone_text_read_base' ,8.0, -8.0, 10000, 51, 0, false, false, false)
        end
    end
    local DisableRemove = true
    local DisableAttach = true
    local MyVehicle = nil
    local model = Config.LangT["NoVehicle"]
    if Config.Menu == "ox_lib" then
        local menu = {}
        for _, v in pairs(GetGamePool('CVehicle')) do
            local VehCoords = GetEntityCoords(v)
            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
            if #(VehCoords - bootDst) <= 3.7 then
                if not IsEntityAttachedToEntity(v, FlatBedModel) then
                    if DoesEntityExist(FlatBedModel) then
                        model = GetDisplayNameFromVehicleModel(GetEntityModel(v))
                        DisableAttach = false
                        MyVehicle = v
                    end
                end
            end
        end
        menu[#menu+1] = {
            title = Config.LangT["AttachVehicle"],
            description = model,
            icon = "fa-solid fa-link",
            disabled = DisableAttach,
            event = "Pug:client:AddVehicleToTruck",
            args = MyVehicle
        }
        for _, v in pairs(GetGamePool('CVehicle')) do
            local VehCoords = GetEntityCoords(v)
            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
            if #(VehCoords - bootDst) <= 3.7 then
                if IsEntityAttachedToEntity(v, FlatBedModel) then
                    if v == MainTowTruckHook then
                    else
                        if DoesEntityExist(FlatBedModel) then
                            model = GetDisplayNameFromVehicleModel(GetEntityModel(v))
                            MyVehicle = v
                            DisableRemove = false
                        end
                    end
                end
            end
        end
        menu[#menu+1] = {
            title = Config.LangT["UnAttachVehicle"],
            description = model,
            icon = "fa-solid fa-link-slash",
            disabled = DisableRemove,
            event = "Pug:client:RemoveVehicleFromTruck",
            args = MyVehicle
        }
        if HookAtatched and SpawnedRope then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(HookedOnVehicle))
            if not WindingTow then
                menu[#menu+1] = {
                    title = Config.LangT["WindHitch"],
                    description = model,
                    icon = "fa-solid fa-wind",
                    event = "Pug:client:WindHitch",
                }
            end
            if WindingTow then
                menu[#menu+1] = {
                    title = Config.LangT["UnWindHitch"],
                    description = model,
                    icon = "fa-solid fa-code-pull-request",
                    event = "Pug:client:UnWindHitch",
                }
            end
            menu[#menu+1] = {
                title = Config.LangT["RemoveTowHook"],
                description = model,
                icon = "fa-solid fa-minus",
                event = "Pug:client:RemoveTowHook",
            }
        end
        menu[#menu+1] = {
            title = Config.LangT["PutRemoteAway"],
            icon = "fa-solid fa-xmark",
            description = "",
            event = "Pug:client:CloseTowMenu",
        }
        lib.registerContext({
            id = 'TowRemote',
            title = Config.LangT["TowRemote"],
            options = menu
        })
        lib.showContext('TowRemote')
    else
        local menu = {
            {
                isMenuHeader = true,
                header = Config.LangT["TowRemote"],
                icon = "fa-solid fa-truck-ramp-box",
                txt = "",
            },
        }
        for _, v in pairs(GetGamePool('CVehicle')) do
            local VehCoords = GetEntityCoords(v)
            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
            if #(VehCoords - bootDst) <= 3.7 then
                if not IsEntityAttachedToEntity(v, FlatBedModel) then
                    if DoesEntityExist(FlatBedModel) then
                        model = GetDisplayNameFromVehicleModel(GetEntityModel(v))
                        DisableAttach = false
                        MyVehicle = v
                    end
                end
            end
        end
        menu[#menu+1] = {
            header = Config.LangT["AttachVehicle"],
            txt = model,
            icon = "fa-solid fa-link",
            disabled = DisableAttach,
            params = {
                event = "Pug:client:AddVehicleToTruck",
                args = MyVehicle
            }
        }
        for _, v in pairs(GetGamePool('CVehicle')) do
            local VehCoords = GetEntityCoords(v)
            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
            if #(VehCoords - bootDst) <= 3.7 then
                if IsEntityAttachedToEntity(v, FlatBedModel) then
                    if v == MainTowTruckHook then
                    else
                        if DoesEntityExist(FlatBedModel) then
                            model = GetDisplayNameFromVehicleModel(GetEntityModel(v))
                            MyVehicle = v
                            DisableRemove = false
                        end
                    end
                end
            end
        end
        menu[#menu+1] = {
            header = Config.LangT["UnAttachVehicle"],
            txt = model,
            icon = "fa-solid fa-link-slash",
            disabled = DisableRemove,
            params = {
                event = "Pug:client:RemoveVehicleFromTruck",
                args = MyVehicle
            }
        }
        if HookAtatched and SpawnedRope then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(HookedOnVehicle))
            if not WindingTow then
                menu[#menu+1] = {
                    header = Config.LangT["WindHitch"],
                    txt = model,
                    icon = "fa-solid fa-wind",
                    params = {
                        event = "Pug:client:WindHitch",
                    }
                }
            end
            if WindingTow then
                menu[#menu+1] = {
                    header = Config.LangT["UnWindHitch"],
                    txt = model,
                    icon = "fa-solid fa-code-pull-request",
                    params = {
                        event = "Pug:client:UnWindHitch",
                    }
                }
            end
            menu[#menu+1] = {
                header = Config.LangT["RemoveTowHook"],
                txt = model,
                icon = "fa-solid fa-minus",
                params = {
                    event = "Pug:client:RemoveTowHook",
                }
            }
        end
        menu[#menu+1] = {
            header = Config.LangT["PutRemoteAway"],
            icon = "fa-solid fa-xmark",
            txt = "",
            params = {
                event = "Pug:client:CloseTowMenu",
            }
        }
        exports[Config.Menu]:openMenu(menu)
    end
end)
RegisterNetEvent("Pug:client:CloseTowMenu", function()
    local HasHookInHand = false
    for _, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(v, PlayerPedId()) then
            if GetEntityModel(v) == GetHashKey(hookModel) then
                HasHookInHand = true
            else
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
                DeleteEntity(v)
            end
        end
    end
    if not HasHookInHand then
        TriggerEvent("Pug:ReloadGuns:sling")
    end
    if not IsPedInAnyVehicle(PlayerPedId()) then
        ClearPedTasksImmediately(PlayerPedId())
    end
    RemoteBeingUsed = false
end)

CreateThread(function()
    blip = AddBlipForCoord(Config.BlipLocation)
    SetBlipSprite(blip, Config.BlipSprite)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, Config.BlipScale)
    SetBlipColour(blip, Config.BlipColor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipLabel)
    EndTextCommandSetBlipName(blip)
    LoadModel("gr_prop_gr_bench_03a")
    Bench = CreateObject(GetHashKey("gr_prop_gr_bench_03a"), Config.CraftingBenchLocation)
    SetEntityHeading(Bench,-90.0)
    FreezeEntityPosition(Bench, true)
    RepoManModel = Config.RepoPedModel
    LoadModel(RepoManModel)
    RepoMan = CreatePed(2, RepoManModel, Config.RepoPedLocation, false, false)
    SetPedFleeAttributes(RepoMan, 0, 0)
    SetPedDiesWhenInjured(RepoMan, false)
    SetPedKeepTask(RepoMan, true)
    SetBlockingOfNonTemporaryEvents(RepoMan, true)
    SetEntityInvincible(RepoMan, true)
    FreezeEntityPosition(RepoMan, true)
    if Config.Target == "ox_target" then
        exports.ox_target:addLocalEntity(Bench, {
            {
                name= "CraftRepoPartsMenu",
                icon = "fas fa-screwdriver",
                label = Config.LangT["CraftParts"],
                event = "Pug:Clent:CraftRepoPartsMenu",
            }
        })
        exports.ox_target:addLocalEntity(RepoMan, {
            {
                name = "RepoJobMenu",
                icon = "fa-solid fa-car",
                label = Config.LangT["RepoJob"],
                event = "Pug:client:RepoJobMenu",
            }
        })
    else
        exports[Config.Target]:AddTargetEntity(RepoMan, {
            options = {
                { 
                    type = "client",
                    icon = "fa-solid fa-car",
                    label = Config.LangT["RepoJob"],
                    event = "Pug:client:RepoJobMenu",
                },
            },
            distance = 1.5
        })
        exports[Config.Target]:AddTargetEntity(Bench, {
            options = {
                { 
                    event = "Pug:Clent:CraftRepoPartsMenu",
                    icon = "fas fa-screwdriver",
                    label = Config.LangT["CraftParts"],
                },
            },
            distance = 1.5
        })
    end
    while true do
        Wait(500)
        local Ped = PlayerPedId()
        local PlyCoords = GetEntityCoords(Ped)
        local Vehicle = PugGetClosestTowTruck()
        if #(GetEntityCoords(Vehicle) - PlyCoords) <= 10.0 then
            if GetEntityModel(Vehicle) == GetHashKey("flatbed3") then
                local Plate = GetPlate(Vehicle)
                if FlatBetData[Plate] ~= nil then
                    local state = FlatBetData[Plate].status
                    if state == 3 then
                        local bootDst = GetEntityBonePosition_2(Vehicle,25)
                        if #(PlyCoords - bootDst) <= 2.0 then
                            if not HasDrawnText then
                                HasDrawnText = true
                                MainTowTruckHook = Vehicle
                                local HoldingHook = false
                                for _, v in pairs(GetGamePool('CObject')) do
                                    if GetEntityModel(v) == GetHashKey(hookModel) then
                                        if IsEntityAttachedToEntity(PlayerPedId(), v) then
                                            HoldingHook = true
                                        end
                                    end
                                end
                                if HoldingHook then
                                    DrawTextRepoJob(Config.LangT["ReturnHook"], 'left')
                                else
                                    DrawTextRepoJob(Config.LangT["GrabHook"], 'left')
                                end
                            end
                        else
                            if HasDrawnText then
                                HideDrawTextRepoJob()
                                HasDrawnText = false
                            end
                        end
                    else
                        if HasDrawnText then
                            HideDrawTextRepoJob()
                            HasDrawnText = false
                        end
                    end
                end
            else
                if HasDrawnText then
                    HideDrawTextRepoJob()
                    HasDrawnText = false
                end
                Wait(1500)
            end
        else
            if HasDrawnText then
                HideDrawTextRepoJob()
                HasDrawnText = false
            end
            Wait(1500)
        end
    end
end)

RegisterNetEvent("Pug:Clent:CraftRepoPartsMenu", function()
    local canshow = true
    local Rep = 0
    local HaseChanged = false
    Config.FrameworkFunctions.TriggerCallback('Pug:server:GetReopRep', function(result)
        Rep = result
        HaseChanged = true
    end)
    while not HaseChanged do Wait(0) end
    if Config.Menu == "ox_lib" then
        local menu = {
            {
                isMenuHeader = true,
                title = Config.LangT["VehicleParts"]..Rep..Config.LangT["XRep"],
                icon = "fas fa-car",
                description = "",
            },
        }
        for k,v in pairs(Config.CraftingParts) do
            if Rep >= v.rep then
                canshow = false
            else
                canshow = true
            end
            menu[#menu+1] = {
                title = GetItemsInformation(k, true) .. " | "..v.rep.."x rep",
                description = v.part1.amount..'x '..v.part1.part..' | '..v.part2.amount..'x '..v.part2.part..' | '..v.part3.amount..'x '..v.part3.part..' | '..v.part4.amount..'x '..v.part4.part,
                icon = "fa-solid fa-screwdriver-wrench",
                disabled = canshow,
                serverEvent = "Pug:server:CraftRepoParts",
                args = {
                    item = k
                }
            }
        end
        menu[#menu+1] = {
            title = Config.LangT["Close"],
            description = "",
            icon = "fa-solid fa-xmark",
            event = "Pug:client:CloseTowMenu",
        }
        lib.registerContext({
            id = 'VehicleParts',
            title = Config.LangT["VehicleParts"],
            options = menu
        })
        lib.showContext('VehicleParts')
    else
        local menu = {
            {
                isMenuHeader = true,
                header = Config.LangT["VehicleParts"]..Rep..Config.LangT["XRep"],
                txt = "",
            },
        }
        for k,v in pairs(Config.CraftingParts) do
            if Rep >= v.rep then
                canshow = false
            else
                canshow = true
            end
            menu[#menu+1] = {
                header = GetItemsInformation(k, true) .. " | "..v.rep.."x rep",
                txt = v.part1.amount..'x '..v.part1.part..'x | '..v.part2.amount..'x '..v.part2.part..'x | '..v.part3.amount..'x '..v.part4.part..' | '..v.part4.amount..'x '..v.part4.part,
                disabled = canshow,
                icon = "fa-solid fa-screwdriver-wrench",
                params = {
                    isServer = true,
                    event = "Pug:server:CraftRepoParts",
                    args = {
                        item = k
                    }
                }
            }
        end
        menu[#menu+1] = {
            header = Config.LangT["Close"],
            icon = "fa-solid fa-xmark",
            txt = "",
            event = "Pug:client:CloseTowMenu",
        }
        exports[Config.Menu]:openMenu(menu)
    end
end)

RegisterNetEvent("Pug:client:CraftRepoParts", function(data)
    local MainItem = Config.CraftingParts[data.item]
    loadAnimDict("mini@repair")
    TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, 4400, 51, 0, false, false, false)
    if Framework == "QBCore" then
        FWork.Functions.Progressbar("crafting-part", Config.LangT["Crafting"]..GetItemsInformation(data.item, true), 5000, false, true, { 
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {},{}, {}, function() -- Done
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingToggleItem(true, data.item, 1)
        end, function() -- Cancel
            ChoppingToggleItem(true, MainItem.part1.part, MainItem.part1.amount)
            ChoppingToggleItem(true, MainItem.part2.part, MainItem.part2.amount)
            ChoppingToggleItem(true, MainItem.part3.part, MainItem.part3.amount)
            ChoppingToggleItem(true, MainItem.part4.part, MainItem.part4.amount)
            ClearPedTasksImmediately(PlayerPedId())
            RepoJobNotify(Config.LangT["Canceled"], "error")
        end)
    else
        FWork.Progressbar(Config.LangT["Crafting"]..GetItemsInformation(data.item), 5000, {FreezePlayer = true, onFinish = function()
            ClearPedTasksImmediately(PlayerPedId())
            ChoppingToggleItem(true, data.item, 1)
        end, onCancel = function()
            ChoppingToggleItem(true, MainItem.part1.part, MainItem.part1.amount)
            ChoppingToggleItem(true, MainItem.part2.part, MainItem.part2.amount)
            ChoppingToggleItem(true, MainItem.part3.part, MainItem.part3.amount)
            ChoppingToggleItem(true, MainItem.part4.part, MainItem.part4.amount)
            ClearPedTasksImmediately(PlayerPedId())
            RepoJobNotify(Config.LangT["Canceled"], "error")
        end})
    end
end)

local function CloseMenuFull()
    if Framework == "QBCore" and Config.Menu == "qb-menu" then
        exports[Config.Menu]:closeMenu()
    end
end

local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k, entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			nearbyEntities[#nearbyEntities+1] = isPlayerEntities and k or entity
		end
	end
	return nearbyEntities
end

local function GetVehiclesInArea(coords, maxDistance) -- Vehicle inspection in designated area
	return EnumerateEntitiesWithinDistance(GetGamePool('CVehicle'), false, coords, maxDistance) 
end

local function IsSpawnPointClear(coords, maxDistance) -- Check the spawn point to see if it's empty or not:
	return #GetVehiclesInArea(coords, maxDistance) == 0 
end

RegisterNetEvent("Pug:client:AddTargetToPed", function(Ped,Text,Event)
    if Config.Target == "ox_target" then
        exports.ox_target:addLocalEntity(Ped, {
            {
                name = Event,
                icon = "fa-solid fa-car",
                label = Text,
                event = Event,
            }
        })
    else
        exports[Config.Target]:AddTargetEntity(Ped, {
            options = {
                { 
                    type = "client",
                    icon = "fa-solid fa-car",
                    label = Text,
                    event = Event,
                },
            },
            distance = 1.5
        })
    end
end)

local function RemoveRepoBlips()
    if DoesBlipExist(blip1) then
        RemoveBlip(blip1)
    end
    if DoesBlipExist(blip2) then
        RemoveBlip(blip2)
    end
    if DoesBlipExist(blip3) then
        RemoveBlip(blip3)
    end
end

local function findVehFromPlateAndLocate(plate)
    local gameVehicles = GetGamePool('CVehicle')
    for i = 1, #gameVehicles do
        local vehicle = gameVehicles[i]
        if DoesEntityExist(vehicle) then
            if GetVehicleNumberPlateText(vehicle) == plate then
                return true
            end
        end
    end
end
local function MakePedHatePlayer(Npc1)
    local RandomPedWeapon = math.random(1,#Config.RandomAngryPedWeapon)
    GiveWeaponToPed(Npc1, GetHashKey(Config.RandomAngryPedWeapon[RandomPedWeapon]), 0, false, false)
    SetPedAmmo(Npc1, GetHashKey(Config.RandomAngryPedWeapon[RandomPedWeapon]), 1000)
    SetCurrentPedWeapon(Npc1, GetHashKey(Config.RandomAngryPedWeapon[RandomPedWeapon]), true)
    SetPedMaxHealth(Npc1, 500)
    SetPedArmour(Npc1, 200)
    SetCanAttackFriendly(Npc1, false, true)
    TaskCombatPed(Npc1, PlayerPedId(), 0, 16)
    SetPedCombatAttributes(Npc1, 46, true)
    SetPedCombatAttributes(Npc1, 0, false)
    SetPedCombatAbility(Npc1, 100)
    SetPedAsCop(Npc1, true)
    SetPedRelationshipGroupHash(Npc1, `HATES_PLAYER`)
    SetPedAccuracy(Npc1, 60)
    SetPedFleeAttributes(Npc1, 0, 0)
    SetPedKeepTask(Npc1, true)
    SetBlockingOfNonTemporaryEvents(Npc1, true)
end
local function GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		return 0.0
	end
end
local function ReturnLeftHandCoords(Entity, Distance, Heading)
	local Coordinates = GetEntityCoords(Entity, false)
	local Head = (GetEntityHeading(Entity) + (Heading or 0.0)) * math.pi / 180.0
	return {x = Coordinates.x + Distance * math.sin(-3.0 * Head), y = Coordinates.y + Distance * math.cos(-3.0 * Head), z = Coordinates.z}
end
local function ReturnRightHandCoords(Entity, Distance, Heading)
	local Coordinates = GetEntityCoords(Entity, false)
	local Head = (GetEntityHeading(Entity) + (Heading or 0.0)) * math.pi / 180.0
	return {x = Coordinates.x + Distance * math.sin(3.0 * Head), y = Coordinates.y + Distance * math.cos(3.0 * Head), z = Coordinates.z}
end
RegisterNetEvent("Pug:client:CreateDefencePeds", function()
    if math.random(1, 100) <= Config.AngryPed1Chance then
        -- Spawn Ped 1
        local RandomPed1Model = math.random(1,#Config.RandomAngryPedModle)
        local LeftSideCoordinates = ReturnLeftHandCoords(NetToVeh(RepoVehicle) or RepoVehicle, 3.0, 90.0)
        local pedPosition = vector3(LeftSideCoordinates.x,LeftSideCoordinates.y,RandomVehicleSpawn.z)
        local Npc1 = CreatePed(4, Config.RandomAngryPedModle[RandomPed1Model], pedPosition.x, pedPosition.y, RandomVehicleSpawn.z+1, 0, true, false)
        Wait(1000)
        if DoesEntityExist(Npc1) then
            MakePedHatePlayer(Npc1)
        end
        if math.random(1, 100) <= Config.AngryPed2Chance then
            -- Spawn Ped 2
            local RandomPed2Model = math.random(1,#Config.RandomAngryPedModle)
            local RightSideCoordinates = ReturnRightHandCoords(NetToVeh(RepoVehicle) or RepoVehicle, 3.0, 90.0)
            local SecondPedCoords = vector3(RightSideCoordinates.x,RightSideCoordinates.y,RandomVehicleSpawn.z)
            local Npc2 = CreatePed(4, Config.RandomAngryPedModle[RandomPed2Model], SecondPedCoords.x, SecondPedCoords.y, RandomVehicleSpawn.z+1, 0, true, false)
            Wait(1000)
            if DoesEntityExist(Npc2) then
                MakePedHatePlayer(Npc2)
            end
        end
    end
end)
RegisterNetEvent("Pug:client:StartRepoRunLoop", function()
    local SpawnedPeds = false
    while DoingRepoRun do
        Wait(100)
        if DoingRepoRun then
            local pos = GetEntityCoords(PlayerPedId())
            local dist = #(pos - vector3(RandomVehicleSpawn.x, RandomVehicleSpawn.y, RandomVehicleSpawn.z))
            if dist <= 90 then
                if findVehFromPlateAndLocate(RepoPlate) then 
                    Wait(2)
                else
                    Wait(1000)
                    PugSpawnVehicle(vehicle, function(veh)
                        RepoVehicle = VehToNet(veh)
                        SetEntityHeading(veh, RandomVehicleSpawn.w)
                        SetVehicleEngineOn(veh, false, false)
                        SetVehicleOnGroundProperly(veh)
                        SetVehicleNeedsToBeHotwired(veh, false)
                        SetVehicleColours(vehicle, 0, 0)
                        SetVehicleFuelLevel(veh, 100.0)
                        if Config.SetVehiclesLocked then
                            SetVehicleDoorsLocked(veh, 2)
                        end
                        for i = 0, 5 do
                            SetVehicleDoorShut(veh, i, true)
                        end
                    end, RandomVehicleSpawn, true)
                    Wait(500)
                end
                if dist <= 150 then
                    if not SpawnedPeds then
                        if DoesEntityExist(RepoVehicle) or DoesEntityExist(NetToVeh(RepoVehicle)) then
                            SpawnedPeds = true
                            TriggerEvent("Pug:client:CreateDefencePeds")
                        end
                    end
                end
                if dist <= 15 then
                    RemoveRepoBlips()
                    TriggerEvent("Pug:client:TakeRepoVehicleToDropOff")
                    break
                end
            end
        else
            break
        end
    end
end)
local function MakeDropOffPed(coords)
    local ped_hash = GetHashKey(Config.DropOffPed)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Wait(1)
	end	
	DropOffPed = CreatePed(1, ped_hash, coords.x, coords.y, coords.z-1)
    SetEntityHeading(DropOffPed,coords.w)
	SetBlockingOfNonTemporaryEvents(DropOffPed, true)
	SetPedDiesWhenInjured(DropOffPed, false)
	SetPedCanPlayAmbientAnims(DropOffPed, true)
	SetPedCanRagdollFromPlayerImpact(DropOffPed, false)
	SetEntityInvincible(DropOffPed, true)
	FreezeEntityPosition(DropOffPed, true)
end

RegisterNetEvent("Pug:client:TakeRepoVehicleToDropOff", function()
    local RandomDrop = math.random(1, #Config.DropoffPedLocation)
    local RandomDropLoc = Config.DropoffPedLocation[RandomDrop].Truck
    local DropOffPedLoc = Config.DropoffPedLocation[RandomDrop].Ped
    local textsetup = false
    DropOffBlip = AddBlipForCoord(RandomDropLoc)
    SetBlipSprite(DropOffBlip, 409)
    SetBlipColour(DropOffBlip, 37)
    SetBlipRoute(DropOffBlip, true)
    SetBlipRouteColour(DropOffBlip, 37)
    MakeDropOffPed(DropOffPedLoc)
    while true do
        if DoesEntityExist(RepoVehicle) or DoesEntityExist(NetToVeh(RepoVehicle)) then
            print(NetToVeh(RepoVehicle), "Does exist")
            break
        end
        print(NetToVeh(RepoVehicle), "Does not exist")
        Wait(100)
    end
    while DoingRepoRun do
        Wait(5)
        if #(GetEntityCoords(PlayerPedId()) - vector3(RandomDropLoc.x,RandomDropLoc.y,RandomDropLoc.z)) < 50.0 then
            if IsPedInAnyVehicle(PlayerPedId()) then
                local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId())
                if GetEntityHeading(PlayerVehicle) + 20 >= RandomDropLoc.w and GetEntityHeading(PlayerVehicle) - 20 <= RandomDropLoc.w and #(GetEntityCoords(NetToVeh(RepoVehicle)) - vector3(RandomDropLoc.x,RandomDropLoc.y,RandomDropLoc.z)) < 10.5 then
                    if IsEntityAttachedToEntity(RepoVehicle, FlatBedModel) or IsEntityAttachedToEntity(NetToVeh(RepoVehicle), FlatBedModel) then
                        DrawMarker(30,RandomDropLoc.x,RandomDropLoc.y,RandomDropLoc.z-0.6,0,0,0,90.0,RandomDropLoc.w,0.0,3.0,1.0,8.0,0,255,0,50,0,0,0,0)
                        if DoesBlipExist(DropOffBlip) then
                            RemoveBlip(DropOffBlip)
                        end
                        if not textsetup then
                            textsetup = true
                            DrawTextRepoJob(Config.LangT["DropOffVehicle"], 'left')
                        end
                        if IsControlJustPressed(0, 38) then
                            local CurrentPlate = GetPlate(PlayerVehicle)
                            if FlatBetData[CurrentPlate].status == 0 then
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "flatbedsound", 0.4)
                                TriggerEvent("Pug:client:LowerTruck")
                                FlatBetData[CurrentPlate].status = 1
                                HideDrawTextRepoJob()
                                if Framework == "QBCore" then
                                    FWork.Functions.Progressbar("repoing_vehicle", Config.LangT["LoweringVehicle"], 6300, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {},{}, {}, function() -- Done
                                        for _, v in pairs(GetGamePool('CVehicle')) do
                                            local VehCoords = GetEntityCoords(v)
                                            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
                                            if #(VehCoords - bootDst) <= 3.7 then
                                                if IsEntityAttachedToEntity(v, FlatBedModel) then
                                                    if GetEntityModel(v) == GetHashKey("flatbed3") then
                                                    else
                                                        if DoesEntityExist(FlatBedModel) then
                                                            DetachEntity(v, true, true)
                                                            SetEntityCoords(v, vector3(VehCoords.x,VehCoords.y,VehCoords.z+0.5))
                                                            if GetEntityHeading(RepoVehicle) + 20 >= RandomDropLoc.w and GetEntityHeading(RepoVehicle) - 20 <= RandomDropLoc.w or GetEntityHeading(NetToVeh(RepoVehicle)) + 20 >= RandomDropLoc.w and GetEntityHeading(NetToVeh(RepoVehicle)) - 20 <= RandomDropLoc.w then
                                                                SetVehicleForwardSpeed(v, -12.0)
                                                            else
                                                                SetVehicleForwardSpeed(v, 12.0)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        TriggerEvent("Pug:client:AddTargetToPed", DropOffPed, Config.LangT["SignRepoPaperwork"], "Pug:client:TurnInRepoCar")
                                        RepoJobNotify(Config.LangT["VehicleLowered"], "success")
                                        TaskLeaveVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(PlayerPedId(), 1))
                                    end, function() -- Cancel
                                        RepoJobNotify(Config.LangT["Failed"])
                                    end)
                                else
                                    FWork.Progressbar(Config.LangT["LoweringVehicle"], 6300, {FreezePlayer = true, onFinish = function()
                                        for _, v in pairs(GetGamePool('CVehicle')) do
                                            local VehCoords = GetEntityCoords(v)
                                            local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
                                            if #(VehCoords - bootDst) <= 3.7 then
                                                if IsEntityAttachedToEntity(v, FlatBedModel) then
                                                    if GetEntityModel(v) == GetHashKey("flatbed3") then
                                                    else
                                                        if DoesEntityExist(FlatBedModel) then
                                                            DetachEntity(v, true, true)
                                                            SetEntityCoords(v, vector3(VehCoords.x,VehCoords.y,VehCoords.z+0.5))
                                                            if GetEntityHeading(RepoVehicle) + 20 >= RandomDropLoc.w and GetEntityHeading(RepoVehicle) - 20 <= RandomDropLoc.w or GetEntityHeading(NetToVeh(RepoVehicle)) + 20 >= RandomDropLoc.w and GetEntityHeading(NetToVeh(RepoVehicle)) - 20 <= RandomDropLoc.w then
                                                                SetVehicleForwardSpeed(v, -12.0)
                                                            else
                                                                SetVehicleForwardSpeed(v, 12.0)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        TriggerEvent("Pug:client:AddTargetToPed", DropOffPed, Config.LangT["SignRepoPaperwork"], "Pug:client:TurnInRepoCar")
                                        RepoJobNotify(Config.LangT["VehicleLowered"], "success")
                                        TaskLeaveVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(PlayerPedId(), 1))
                                    end, onCancel = function()
                                        RepoJobNotify(Config.LangT["Failed"])
                                    end})
                                end
                                Wait(5000)
                                break
                            else
                                for _, v in pairs(GetGamePool('CVehicle')) do
                                    local VehCoords = GetEntityCoords(v)
                                    local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
                                    if #(VehCoords - bootDst) <= 3.7 then
                                        if IsEntityAttachedToEntity(v, FlatBedModel) then
                                            if GetEntityModel(v) == GetHashKey("flatbed3") then
                                            else
                                                if DoesEntityExist(FlatBedModel) then
                                                    DetachEntity(v, true, true)
                                                    SetEntityCoords(v, vector3(VehCoords.x,VehCoords.y,VehCoords.z+0.5))
                                                    if GetEntityHeading(RepoVehicle) + 20 >= RandomDropLoc.w and GetEntityHeading(RepoVehicle) - 20 <= RandomDropLoc.w or GetEntityHeading(NetToVeh(RepoVehicle)) + 20 >= RandomDropLoc.w and GetEntityHeading(NetToVeh(RepoVehicle)) - 20 <= RandomDropLoc.w then
                                                        SetVehicleForwardSpeed(v, -12.0)
                                                    else
                                                        SetVehicleForwardSpeed(v, 12.0)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                TriggerEvent("Pug:client:AddTargetToPed", DropOffPed, Config.LangT["SignRepoPaperwork"], "Pug:client:TurnInRepoCar")
                                RepoJobNotify(Config.LangT["VehicleLowered"], "success")
                                TaskLeaveVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(PlayerPedId(), 1))
                            end
                        end
                    end
                else
                    if textsetup then
                        textsetup = false
                        HideDrawTextRepoJob()
                    end
                    DrawMarker(30,RandomDropLoc.x,RandomDropLoc.y,RandomDropLoc.z-0.6,0,0,0,90.0,RandomDropLoc.w,0.0,3.0,1.0,8.0,255,0,0,50,0,0,0,0)
                end
            end
        end
    end
end)

RegisterNetEvent("Pug:client:TurnInRepoCar", function()
	FreezeEntityPosition(DropOffPed, false)
	loadAnimDict("gestures@m@standing@casual")
	TaskPlayAnim(DropOffPed, 'gestures@m@standing@casual' ,'gesture_shrug_hard' ,8.0, -8.0, 10000, 51, 0, false, false, false)
    TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(DropOffPed))
	TaskTurnPedToFaceCoord(DropOffPed, GetEntityCoords(PlayerPedId()))
	SetPedTalk(DropOffPed)
	PlayAmbientSpeech1(DropOffPed, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
    Wait(700)
    loadAnimDict("missfam4")
    TaskPlayAnim(PlayerPedId(), "missfam4", "base", 2.0, 2.0, 4400, 51, 0, false, false, false)
    local ClipBoard = CreateObject(GetHashKey("p_amb_clipboard_01"), GetEntityCoords(PlayerPedId()))
    AttachEntityToEntity(ClipBoard, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 36029), 0.16, 0.08, 0.1, -130.0, -50.0, 0.0, true, true, false, true, 1, true)
    if Config.Target == "ox_target" then
        exports.ox_target:removeLocalEntity(DropOffPed,Config.LangT["SignRepoPaperwork"])
    else
        exports[Config.Target]:RemoveTargetEntity(DropOffPed,Config.LangT["SignRepoPaperwork"])
    end
    if Framework == "QBCore" then
        FWork.Functions.Progressbar("towing_vehicle", Config.LangT["SigningPaperWork"], 3000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {},{}, {}, function() -- Done
            TriggerEvent("Pug:client:CloseTowMenu")
            ClearPedTasks(DropOffPed)
            SetPedAsNoLongerNeeded(DropOffPed)
            TriggerEvent("FullyDeleteRepoVehicle",RepoVehicle)
            TriggerEvent("FullyDeleteRepoVehicle",NetToVeh(RepoVehicle))
            TriggerServerEvent("Pug:server:RemoveRepoLetter")
            ActiveTow = nil
            DoingRepoRun = false
            RepoJobNotify(Config.LangT["VehicleRepoed"], "success")
            TriggerServerEvent("Pug:Server:FinishReoJob", RepoRank)
            if Config.ShowMenuWhenFinished then
                TriggerEvent("Pug:client:RepoJobMenu")
            end
            Wait(25000)
            if DoesEntityExist(DropOffPed) then
                DeleteEntity(DropOffPed)
            end
        end, function() -- Cancel
            TriggerEvent("Pug:client:CloseTowMenu")
            RepoJobNotify(Config.LangT["Canceled"], "error")
            if Config.Target == "ox_target" then
                exports.ox_target:addLocalEntity(DropOffPed, {
                    {
                        name = Event,
                        icon = "fa-solid fa-car",
                        label = Config.LangT["SignRepoPaperwork"],
                        event = "Pug:client:TurnInRepoCar",
                    }
                })
            else
                exports[Config.Target]:AddTargetEntity(DropOffPed, {
                    options = {
                        { 
                            type = "client",
                            icon = "fa-solid fa-car",
                            label = Config.LangT["SignRepoPaperwork"],
                            event = "Pug:client:TurnInRepoCar",
                        },
                    },
                    distance = 1.5
                })
            end
        end)
    else
        FWork.Progressbar(Config.LangT["SigningPaperWork"], 3000, {FreezePlayer = true, onFinish = function()
            TriggerEvent("Pug:client:CloseTowMenu")
            ClearPedTasks(DropOffPed)
            SetPedAsNoLongerNeeded(DropOffPed)
            TriggerEvent("FullyDeleteRepoVehicle",RepoVehicle)
            TriggerEvent("FullyDeleteRepoVehicle",NetToVeh(RepoVehicle))
            TriggerServerEvent("Pug:server:RemoveRepoLetter")
            ActiveTow = nil
            DoingRepoRun = false
            RepoJobNotify(Config.LangT["VehicleRepoed"], "success")
            TriggerServerEvent("Pug:Server:FinishReoJob", RepoRank)
            if Config.ShowMenuWhenFinished then
                TriggerEvent("Pug:client:RepoJobMenu")
            end
            Wait(25000)
            if DoesEntityExist(DropOffPed) then
                DeleteEntity(DropOffPed)
            end
        end, onCancel = function()
            TriggerEvent("Pug:client:CloseTowMenu")
            RepoJobNotify(Config.LangT["Canceled"], "error")
            if Config.Target == "ox_target" then
                exports.ox_target:addLocalEntity(DropOffPed, {
                    {
                        name = Event,
                        icon = "fa-solid fa-car",
                        label = Config.LangT["SignRepoPaperwork"],
                        event = "Pug:client:TurnInRepoCar",
                    }
                })
            else
                exports[Config.Target]:AddTargetEntity(DropOffPed, {
                    options = {
                        { 
                            type = "client",
                            icon = "fa-solid fa-car",
                            label = Config.LangT["SignRepoPaperwork"],
                            event = "Pug:client:TurnInRepoCar",
                        },
                    },
                    distance = 1.5
                })
            end
        end})
    end
	Wait(1200)
end)
RegisterNetEvent("Pug:client:RepoJobMenu", function()
    local RepoRep = 0
    local HaseChanged = false
    Config.FrameworkFunctions.TriggerCallback('Pug:server:GetReopRep', function(result)
        RepoRep = result
        HaseChanged = true
    end)
    while not HaseChanged do Wait(0) end
    local tier = 0
    for k, v in pairs(Config.RepoProgression) do
        if RepoRep >= v.RepRequired then
            RepoRank = k
        end
    end
    Wait(200)
    if RepoRank == 3 then
        tier = Config.LangT["Max"]
    else
        tier = Config.RepoProgression[RepoRank+1].RepRequired
    end
    if Config.Menu == "ox_lib" then
        local menu = {
            {
                title = Config.LangT["LevelingSystem"]..RepoRank,
                description = Config.LangT["CurrentPay"] .. Config.RepoProgression[RepoRank].Multiplier .. "\n" .. Config.LangT["TotalXPEarned"] .. RepoRep .. "\n" .. Config.LangT["NextTier"] .. tier,
                icon = "fa-solid fa-pen-to-square",
            },
            {
                title = Config.LangT["GetNewRepoJob"],
                icon = "fa-solid fa-person-digging",
                description = Config.LangT["Deposit"],
                event = "Pug:client:startRepoRun",
            },
        }
        if RepoVehicle or TowTruckVehicle then
            menu[#menu+1] = {
                title = Config.LangT["ParkFlatbed"],
                icon = "fa-solid fa-truck-ramp-box",
                txt = " ",
                event = "Pug:client:PutFlatbedAway",
            }
        end
        menu[#menu+1] = {
            title = Config.LangT["Close"],
            icon = "fa-solid fa-xmark",
            description = "",
            event = "Pug:client:CloseTowMenu",
        }
        lib.registerContext({
            id = 'RepoJobMenu',
            title = Config.LangT["RepoCompany"]..RepoRep.."xp |",
            options = menu
        })
        lib.showContext('RepoJobMenu')
    else
        local menu = {
            {
                isHeader = true,
                header = Config.LangT["RepoCompany"]..RepoRep.."xp |",
                icon = "fas fa-car",
                txt = "",
            },
            {
                header = Config.LangT["LevelingSystem"]..RepoRank,
                txt = Config.LangT["CurrentPay"]..Config.RepoProgression[RepoRank].Multiplier .. Config.LangT["TotalXPEarned"]..RepoRep .. Config.LangT["NextTier"]..tier,
                icon = "fa-solid fa-pen-to-square",
                params = {
                    event = " ",
                }
            },
            {
                header = Config.LangT["GetNewRepoJob"],
                icon = "fa-solid fa-person-digging",
                txt = Config.LangT["Deposit"],
                params = {
                    event = "Pug:client:startRepoRun",
                }
            },
        }
        if RepoVehicle or TowTruckVehicle then
            menu[#menu+1] = {
                header = Config.LangT["ParkFlatbed"],
                icon = "fa-solid fa-truck-ramp-box",
                txt = " ",
                params = {
                    event = "Pug:client:PutFlatbedAway",
                }
            }
        end
        menu[#menu+1] = {
            header = Config.LangT["Close"],
            txt = "",
            icon = "fa-solid fa-xmark",
            params = {
                event = "Pug:client:CloseTowMenu",
            }
        }
        exports[Config.Menu]:openMenu(menu)
    end
end)

RegisterNetEvent("Pug:client:PutFlatbedAway", function()
    if DoesEntityExist(RepoVehicle) or DoesEntityExist(NetToVeh(RepoVehicle))  then
        TriggerEvent("FullyDeleteRepoVehicle",RepoVehicle)
        TriggerEvent("FullyDeleteRepoVehicle",NetToVeh(RepoVehicle))
    end
    if DoesEntityExist(TowTruckVehicle) then
        TriggerEvent("FullyDeleteRepoVehicle",TowTruckVehicle)
    end
    if DoesEntityExist(FlatBedModel) then
        TriggerEvent("FullyDeleteRepoVehicle",FlatBedModel)
    end
    TriggerServerEvent("Pug:server:RemoveRepoLetter", true)
    TowTruckVehicle = nil
    RepoVehicle = nil
    RemoveRepoBlips()
    ActiveTow = nil
    TriggerServerEvent("Pug:server:ToggleTruckDeposite")
    DoingRepoRun = false
    if Config.Target == "ox_target" then
        exports.ox_target:removeLocalEntity(DropOffPed,Config.LangT["SignRepoPaperwork"])
    else
        exports[Config.Target]:RemoveTargetEntity(DropOffPed,Config.LangT["SignRepoPaperwork"])
    end
    if DoesEntityExist(DropOffPed) then
        DeleteEntity(DropOffPed)
    end
    if DoesBlipExist(DropOffBlip) then
        RemoveBlip(DropOffBlip)
    end
end)

local function SpawnRepoFlatbed()
    local coords = nil
    for _, v in pairs(Config.FlatBedSpawns) do
        if IsSpawnPointClear(vector3(v.x, v.y, v.z), 4.5) then
            coords = v
        end
    end
    if coords then
        PugSpawnVehicle(Config.RepoVehicleModel, function(veh)
            TowTruckVehicle = veh
            SetVehicleLivery(veh, 5)
            SetVehicleNumberPlateText(veh, "REPO"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            SetVehicleFuelLevel(veh, 100.0)
            SetEntityAsMissionEntity(veh, true, true)
            CloseMenuFull()
            local LicensePlate = GetPlate(veh)
            TriggerEvent(Config.VehilceKeysGivenToPlayerEvent, LicensePlate)
            TriggerServerEvent("Pug:server:ToggleTruckDeposite", true)
            SetVehicleEngineOn(veh, true, true)
            if Config.WarpPlayerToVehicle then
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            end
            for i = 1, 9, 1 do
                SetVehicleExtra(veh, i, 0)
            end
        end, coords, true)
    else
        RepoJobNotify(Config.LangT["AreaNotClear"], "error")
    end
end
local SpamcoolDown = false
RegisterNetEvent("Pug:client:startRepoRun", function()
    if not DoesEntityExist(RepoVehicle) then
        if not SpamcoolDown then
            SpamcoolDown = true
            TriggerEvent("Pug:client:StartRepocooldown")
            RemoveRepoBlips()
            TriggerServerEvent("Pug:server:RemoveRepoLetter", true)
            RepoJobNotify(Config.LangT["GetToRepoing"], "success")
            local random1 = math.random(1,#Config.RandomCarSpawns - 3)
            local random2 = random1 + 1
            local random3 = random2 + 1
            local randomspawn = math.random(1,3)
            if randomspawn == 1 then
                RandomVehicleSpawn = Config.RandomCarSpawns[random1]
            elseif randomspawn == 2 then
                RandomVehicleSpawn = Config.RandomCarSpawns[random2]
            elseif randomspawn == 3 then
                RandomVehicleSpawn = Config.RandomCarSpawns[random3]
            end
            local randomcar = math.random(1,#Config.RandomCarList)
            if not DoesEntityExist(TowTruckVehicle) then
                TriggerEvent("Pug:client:CheckDistFlatbedLoop")
            end
            if not DoesEntityExist(TowTruckVehicle) then
                SpawnRepoFlatbed()
            end
            PugSpawnVehicle(Config.RandomCarList[randomcar], function(veh)
                RepoVehicle = VehToNet(veh)
                RepoPlate = GetPlate(veh)
                local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                RepoJobEmail(model)
                SetEntityHeading(veh, RandomVehicleSpawn.w)
                SetVehicleEngineOn(veh, false, false)
                SetVehicleOnGroundProperly(veh)
                SetVehicleNeedsToBeHotwired(veh, false)
                if Config.SetVehiclesLocked then
                    SetVehicleDoorsLocked(veh, 2)
                end
                SetVehicleFuelLevel(veh, 100.0)
                local VehModel = GetDisplayNameFromVehicleModel(Config.RandomCarList[randomcar])
                TriggerServerEvent("Pug:server:AddRepoItem", RepoPlate, VehModel)
                for i = 0, 5 do
                    SetVehicleDoorShut(veh, i, true)
                end
                if Config.Debug then
                    SetNewWaypoint(RandomVehicleSpawn.x, RandomVehicleSpawn.y)
                end
            end, RandomVehicleSpawn, true)
            -- blip1
            blip1 = AddBlipForCoord(Config.RandomCarSpawns[random1])
            SetBlipSprite(blip1, 161)
            SetBlipDisplay(blip1, 4)
            SetBlipScale(blip1, 0.75)
            SetBlipColour(blip1, 3)
            SetBlipAsShortRange(blip1, false)
            -- blip2
            blip2 = AddBlipForCoord(Config.RandomCarSpawns[random2])
            SetBlipSprite(blip2, 161)
            SetBlipDisplay(blip2, 4)
            SetBlipScale(blip2, 0.75)
            SetBlipColour(blip2, 3)
            SetBlipAsShortRange(blip2, false)
            -- blip2
            blip3 = AddBlipForCoord(Config.RandomCarSpawns[random3])
            SetBlipSprite(blip3, 161)
            SetBlipDisplay(blip3, 4)
            SetBlipScale(blip3, 0.75)
            SetBlipColour(blip3, 3)
            SetBlipAsShortRange(blip3, false)
            DoingRepoRun = true
            TriggerEvent("Pug:client:StartRepoRunLoop")
        else
            RepoJobNotify(Config.LangT["NoSpam"], "error")
        end
    else
        RepoJobNotify(Config.LangT["AlreadyDoingRun"], "error")
    end
end)

RegisterNetEvent("Pug:client:StartRepocooldown", function()
    Wait(20000)
    SpamcoolDown = false
end)

RegisterNetEvent("Pug:client:CheckDistFlatbedLoop", function()
    while true do
        Wait(1000)
        if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(TowTruckVehicle)) >= 50.0 then
            if TowTruckVehicle then
                RepoJobNotify(Config.LangT["TooFarFromTruck"], "error")
                TriggerEvent("Pug:client:PutFlatbedAway")
                break
            else
                break
            end
        end
    end
end)

RegisterNetEvent("Pug-TpTow", function()
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(PlayerPedId(), -201.08, -1166.78, 22.16, 0, 0, 0)
    SetEntityHeading(PlayerPedId(), 243.67)
    DoScreenFadeIn(500)
end)

RegisterNetEvent("Pug:client:LowerTruck", function()
    ChangingBedState = true
    TriggerEvent("Pug:client:TowCoolDown")
    LoadModel("inm_flatbed_base")
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, true)
    local SpawnedNewFlatBed = false
    MainTowTruckHook = veh
    while ChangingBedState do
        if ChangingBedState then
            local Plate = GetPlate(veh)
            if veh and DoesEntityExist(veh) and GetEntityModel(veh) == GetHashKey("flatbed3") and NetworkHasControlOfEntity(veh) then
                if not FlatBetData[Plate].FlatBed then
                    SpawnedNewFlatBed = true
                    local VehCoords = GetEntityCoords(veh)
                    local ThisFlatBedModel = GetClosestObjectOfType(VehCoords, 4.5, GetHashKey("inm_flatbed_base"), false, false, false)
                    if ThisFlatBedModel then
                        if IsEntityAttachedToEntity(ThisFlatBedModel, veh) then
                            TriggerEvent("FullyDeleteRepoVehicle", ThisFlatBedModel)
                        end
                    end
                    FlatBetData[Plate].FlatBed = CreateObject(GetHashKey('inm_flatbed_base'), VehCoords, true, true, false)
                    FlatBedModel = FlatBetData[Plate].FlatBed
                else
                    SetVehicleExtra(veh, 1, 1)
                    if not SpawnedNewFlatBed then
                        local VehicleAttached = false
                        SpawnedNewFlatBed = true
                        if FlatBedModel then
                            for _, v in pairs(GetGamePool('CVehicle')) do
                                local VehCoords = GetEntityCoords(v)
                                local bootDst = GetEntityBonePosition_2(MainTowTruckHook,25)
                                if #(VehCoords - bootDst) <= 3.7 then
                                    if IsEntityAttachedToEntity(v, FlatBedModel) then
                                        if GetEntityModel(v) == GetHashKey("flatbed3") then
                                        else
                                            if DoesEntityExist(FlatBedModel) then
                                                VehicleAttached = v
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        local VehCoords = GetEntityCoords(veh)
                        local ThisFlatBedModel = GetClosestObjectOfType(VehCoords, 4.5, GetHashKey("inm_flatbed_base"), false, false, false)
                        if ThisFlatBedModel then
                            if IsEntityAttachedToEntity(ThisFlatBedModel, veh) then
                                TriggerEvent("FullyDeleteRepoVehicle", ThisFlatBedModel)
                            end
                        end
                        FlatBetData[Plate].FlatBed = CreateObject(GetHashKey('inm_flatbed_base'), VehCoords, true, true, false)
                        local BedToNet2 = ObjToNet(FlatBetData[Plate].FlatBed)
                        FlatBetData[Plate].BedNet = NetToObj(BedToNet2)
                        AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), vector3(0.0, -3.8, 0.45), vector3(0.0, 0.0, 0.0), 0, 0, 1, 0, 0, 1)
                        FlatBedModel = FlatBetData[Plate].FlatBed
                        if VehicleAttached then
                            local rotation = 180.0
                            if GetEntityHeading(MainTowTruckHook) + 30 >= GetEntityHeading(VehicleAttached) and GetEntityHeading(MainTowTruckHook) - 30 <= GetEntityHeading(VehicleAttached) then
                                rotation = 0.0
                            end
                            AttachEntityToEntity(VehicleAttached, FlatBedModel, 0, 0.0, 1.4, 0.38, 0.0, 0.0, rotation, true, true, false, true, 1, true)
                        end
                    end
                end
                local BedToNet = ObjToNet(FlatBetData[Plate].FlatBed)
                if BedToNet ~= 0 then
                    if not FlatBetData[Plate].Lowered then
                        FlatBetData[Plate].Lowered = true
                    end
                    if not FlatBetData[Plate].status then
                        FlatBetData[Plate].status = true
                    end
                    if not FlatBetData[Plate].BedNet then
                        FlatBetData[Plate].BedNet = NetToObj(BedToNet)
                    end
                    if FlatBetData[Plate].status == 0 then
                        if FlatBetData[Plate].Lowered then
                            AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), vector3(0.0, -3.8, 0.45), vector3(0.0, 0.0, 0.0), 0, 0, 1, 0, 0, 1)
                            FlatBetData[Plate].Lowered = false
                        end
                    elseif FlatBetData[Plate].status == 1 then
                        local offsetPos = vector3(0.0, -3.8, 0.45)
                        local offsetRot = vector3(0.0, 0.0, 0.0)
                        offsetPos = offsetPos + vector3(TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, -4.0, TransVal), TransInterperate(0.0, 0.0, TransVal))
                        offsetRot = offsetRot + vector3(TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal))
                        AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                        TransVal = TransVal + (1.0 * Timestep()) / 4.0
                        if TransVal >= 1.0 then
                            FlatBetData[Plate].status = FlatBetData[Plate].status + 1
                            TransVal = 0.0
                        end
                    elseif FlatBetData[Plate].status == 2 then
                        local offsetPos = vector3(0.0, -3.8, 0.45) + vector3(0.0, -4.0, 0.0)
                        local offsetRot = vector3(0.0, 0.0, 0.0) + vector3(0.0, 0.0, 0.0)
                        offsetPos = offsetPos + vector3(TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, -0.4, TransVal), TransInterperate(0.0, -1.0, TransVal))
                        offsetRot = offsetRot + vector3(TransInterperate(0.0, 12.0, TransVal), TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal))
                        AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                        TransVal = TransVal + (1.0 * Timestep()) / 2.0
                        if TransVal >= 1.0 then
                            FlatBetData[Plate].status = FlatBetData[Plate].status + 1
                            TransVal = 0.0
                        end
                    elseif FlatBetData[Plate].status == 3 then
                        if not FlatBetData[Plate].Lowered then
                            local offsetPos = vector3(0.0, -3.8, 0.45) + vector3(0.0, -4.0, 0.0) + vector3(0.0, -0.4, -1.0)
                            local offsetRot = vector3(0.0, 0.0, 0.0) + vector3(0.0, 0.0, 0.0) + vector3(12.0, 0.0, 0.0)
                            AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                            FlatBetData[Plate].Lowered = true
                        end
                    elseif FlatBetData[Plate].status == 4 then
                        local offsetPos = vector3(0.0, -3.8, 0.45) + vector3(0.0, -4.0, 0.0)
                        local offsetRot = vector3(0.0, 0.0, 0.0) + vector3(0.0, 0.0, 0.0)
                        offsetPos = offsetPos + vector3(TransInterperate(0.0, 0.0, TransVal), TransInterperate(-0.4, 0.0, TransVal), TransInterperate(-1.0, 0.0, TransVal))
                        offsetRot = offsetRot + vector3(TransInterperate(12.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal))
                        AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                        TransVal = TransVal + (1.0 * Timestep()) / 2.0
                        if TransVal >= 1.0 then
                            FlatBetData[Plate].status = FlatBetData[Plate].status + 1
                            TransVal = 0.0
                        end
                    elseif FlatBetData[Plate].status == 5 then
                        local offsetPos = vector3(0.0, -3.8, 0.45)
                        local offsetRot = vector3(0.0, 0.0, 0.0)
                        offsetPos = offsetPos + vector3(TransInterperate(0.0, 0.0, TransVal), TransInterperate(-4.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal))
                        offsetRot = offsetRot + vector3(TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal), TransInterperate(0.0, 0.0, TransVal))
                        AttachEntityToEntity(FlatBetData[Plate].BedNet, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                        TransVal = TransVal + (1.0 * Timestep()) / 4.0
                        if TransVal >= 1.0 then
                            FlatBetData[Plate].status = 0
                            TransVal = 0.0
                        end
                    else
                        FlatBetData[Plate].status = 0
                    end
                end
            end
        else
            break
        end
        Wait(0)
    end
end)

RegisterNetEvent("Pug:client:TowCoolDown", function()
    Wait(6200)
    ChangingBedState = false
end)

RegisterNetEvent("FullyDeleteRepoVehicle", function(vehicle)
    local entity = nil
    if vehicle then
        entity = vehicle
    else
        entity = PugGetClosestVehicle()
    end
    local ped = PlayerPedId()
    if IsEntityAMissionEntity(entity) then
        Citizen.Trace("BEFORE: Entity IS a mission entity")
    else
        Citizen.Trace("BEFORE: Entity IS NOT a mission entity")
    end


    NetworkRequestControlOfEntity(entity)

    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)

    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    if IsEntityAMissionEntity(entity) then
        Citizen.Trace("Entity IS a mission entity")
    else
        Citizen.Trace("Entity IS NOT a mission entity")
    end

    Citizen.Trace("Owner of entity: "..GetPlayerServerId(NetworkGetEntityOwner(entity)))
    Citizen.Trace("NETID of entity: "..NetworkGetNetworkIdFromEntity(entity))

    if NetworkHasControlOfEntity(entity) then
        Citizen.Trace("Entity IS in my control")
    else
        Citizen.Trace("Entity IS NOT in my control")
    end

    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )

    if ( DoesEntityExist( entity ) ) then 
        Citizen.Trace("Entity FAILED to delete! If you see this please contact a developer!")	
        DeleteEntity(entity)
        if ( DoesEntityExist( entity ) ) then 
            Citizen.Trace("Entity FAILED to delete on attempt 2! If you see this please contact a developer!")            
            return false
        else 
            return true
        end
    else 
        return true
    end 
end)
-- Repo Request setup
local MostRecentRequest = nil
RegisterNetEvent("Pug:client:GetRepoWorker", function(Message, PlayerInfo)
    if TowTruckVehicle then
        MostRecentRequest = PlayerInfo.Source
        TriggerEvent("chatMessage", "TOW/REPO REQUEST", "warning", " ID ["..PlayerInfo.Source.."] ".. PlayerInfo.FirstName .. " " .. PlayerInfo.LastName.. " | "..Message)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end
end)
RegisterCommand("reporeply", function(source, args, rawCommand)
    local Msg = rawCommand:sub(10)
    if MostRecentRequest then
        if Msg then
            TriggerServerEvent("Pug:server:SendPlayerRepoMessage", MostRecentRequest, Msg)
        else
            RepoJobNotify(Config.LangT["MissingText"], "error")
        end
    else
        RepoJobNotify(Config.LangT["NoRecentRequest"], "error")
    end
end)
TriggerEvent('chat:addSuggestion', '/reporeply', 'Reply to most recent repo/tow request.', {{ name="message", help="Message to the most recent requester."}})