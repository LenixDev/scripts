local QBCore = exports["qb-core"]:GetCoreObject()
local vehicle = nil
local numgears = nil
local topspeedGTA = nil
local topspeedms = nil
local acc = nil
local hash = nil
local selectedgear = 0 
local hbrake = nil
local manualon = false
local incar = false
local currspeedlimit = nil
local ready = false
local realistic = false
local isInVehicleModel = false

function GearSelecteds()
    return selectedgear
end

CreateThread(function()
    local hasBeenSet = false
    local vehicleModels = Config.ManualGearbox
    while true do
        Wait(100) 
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        local model = GetEntityModel(vehicle)
        isInVehicleModel = false
        for i, modelName in ipairs(vehicleModels) do
            if model == GetHashKey(modelName) then
                isInVehicleModel = true
                break
            end
        end
        if IsPedInAnyVehicle(player, false) and isInVehicleModel then
            if not hasBeenSet then
                manualon = true
                hasBeenSet = true
            end
        else
            manualon = false
            hasBeenSet = false
        end
    end
end)

function getinfo(gea)
    if isInVehicleModel then
        if gea == 0 then
            return "N"
        elseif gea == -1 then
            return "R"
        else
            return gea
        end
    else
        return "A"
    end
end

CreateThread(function()
    while true do
        Wait(100) 
        if Config.EngineStall then
            realistic = true
        else
            realistic = false
        end
    end
end)

CreateThread(function()
    while true do
        Wait(100) 
        local ped = PlayerPedId()
        local newveh = GetVehiclePedIsIn(ped,false)
        local class = GetVehicleClass(newveh)
        if newveh == vehicle then
        elseif newveh == 0 and vehicle ~= nil then
            resetvehicle()
        else
            if GetPedInVehicleSeat(newveh,-1) == ped then
                if class ~= 13 and class ~= 14 and class ~= 15 and class ~= 16 and class ~= 21 then
                    vehicle = newveh
                    hash = GetEntityModel(newveh)
                    if GetVehicleMod(vehicle,13) < 0 then
                        numgears = GetVehicleHandlingInt(newveh, "CHandlingData", "nInitialDriveGears")
                    else
                        numgears = GetVehicleHandlingInt(newveh, "CHandlingData", "nInitialDriveGears") + 1
                    end
                    hbrake = GetVehicleHandlingFloat(newveh, "CHandlingData", "fHandBrakeForce")
                    topspeedGTA = GetVehicleHandlingFloat(newveh, "CHandlingData", "fInitialDriveMaxFlatVel")
                    topspeedms = (topspeedGTA * 1.32)/3.6
                    acc = GetVehicleHandlingFloat(newveh, "CHandlingData", "fInitialDriveForce")
                    selectedgear = 0
                    Wait(50)
                    ready = true
                end
            end
        end

    end
end)

function resetvehicle()
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", acc)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel",topspeedGTA)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fHandBrakeForce", hbrake)
    SetVehicleHighGear(vehicle, numgears)
    ModifyVehicleTopSpeed(vehicle,1)
    SetVehicleHandbrake(vehicle, false)
    vehicle = nil
    numgears = nil
    topspeedGTA = nil
    topspeedms = nil
    acc = nil
    hash = nil
    hbrake = nil
    selectedgear = 0
    currspeedlimit = nil
    ready = false
end

CreateThread(function()
    while true do
        Wait(0) 
        if manualon == true and vehicle ~= nil then
        DisableControlAction(0, 52, true)
        DisableControlAction(0, 86, true)
        end
    end
end)

RegisterKeyMapping('+gearUp', 'Gear Up', 'keyboard', 'LSHIFT')
RegisterKeyMapping('+gearDown', 'Gear Down', 'keyboard', 'LCONTROL')

CreateThread(function()
    while true do
        Wait(0) 
        if manualon == true and vehicle ~= nil then
            if vehicle ~= nil then
                RegisterCommand('+gearUp', function()
                    if isInVehicleModel and ready == true and selectedgear <= numgears - 1 then
                        DisableControlAction(0, 71, true)
                        selectedgear = selectedgear + 1
                        DisableControlAction(0, 71, false)
                        SimulateGears()
                    end
                end, false)
                RegisterCommand('+gearDown', function()
                    if isInVehicleModel and ready == true and selectedgear > -1 then
                        DisableControlAction(0, 71, true)
                        selectedgear = selectedgear - 1
                        DisableControlAction(0, 71, false)
                        SimulateGears()
                    end
                end, false)
            end
        end
    end
end)

function SimulateGears()
    local engineup = GetVehicleMod(vehicle,11)
    if selectedgear > 0 then
        local ratio 
        if Config.vehicles[hash] ~= nil then
            if selectedgear ~= 0 and selectedgear ~= nil  then
                if numgears ~= nil and selectedgear ~= nil then
                    ratio = Config.vehicles[hash][numgears][selectedgear] * (1/0.9)
                else
		    ratio = Config.gears[numgears][selectedgear] * (1/0.9)
                end
            end
        else
            if selectedgear ~= 0 and selectedgear ~= nil then
                if numgears ~= nil and selectedgear ~= nil then
                    ratio = Config.gears[numgears][selectedgear] * (1/0.9)
                else
                end
            end
        end
        if ratio ~= nil then
            SetVehicleHighGear(vehicle,1)
            newacc = ratio * acc
            newtopspeedGTA = topspeedGTA / ratio
            newtopspeedms = topspeedms / ratio
            SetVehicleHandbrake(vehicle, false)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", newacc)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel", newtopspeedGTA)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fHandBrakeForce", hbrake)
            ModifyVehicleTopSpeed(vehicle,1)
            currspeedlimit = newtopspeedms 
        end
    elseif selectedgear == 0 then
    elseif selectedgear == -1 then
            SetVehicleHandbrake(vehicle, false)
            SetVehicleHighGear(vehicle,numgears)    
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", acc)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel", topspeedGTA)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fHandBrakeForce", hbrake)
            ModifyVehicleTopSpeed(vehicle,1)
    end
    SetVehicleMod(vehicle,11,engineup,false)
end

CreateThread(function()
    while true do
        Wait(0)
        if manualon == true and vehicle ~= nil then
            if selectedgear == -1 then
                if GetVehicleCurrentGear(vehicle) == 1 then
                    DisableControlAction(0, 71, true)
                end
            elseif selectedgear > 0 then
                if GetEntitySpeedVector(vehicle,true).y < 0.0 then   
                    DisableControlAction(0, 72, true)
                end
            elseif selectedgear == 0 then
                SetVehicleHandbrake(vehicle, true)
                if IsControlPressed(0, 76) == false then
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fHandBrakeForce", 0.0)
                else
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fHandBrakeForce", hbrake)
                end
            end
        else
            Wait(100) 
        end
    end
end)

local disable = false
    
CreateThread(function()
    while true do
        Wait(0)
        if realistic == true then
            if manualon == true and vehicle ~= nil then
                if selectedgear > 1 then
                    if IsControlPressed(0,71) then
                        local speed = GetEntitySpeed(vehicle) 
                        local minspeed = currspeedlimit / 7 
                        if speed < minspeed then
                            if GetVehicleCurrentRpm(vehicle) < 0.4 then
                                disable = true
                            end
                        end
                    end
                end
            else
                Wait(100) 
            end  
        else
            Wait(100) 
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if disable == true then
            SetVehicleEngineOn(vehicle,false,true,false)
            Wait(1000)
            disable = false
        end   

    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if vehicle ~= nil and selectedgear ~= 0 then 
            local speed = GetEntitySpeed(vehicle) 
            if currspeedlimit ~= nil then
                if speed >= currspeedlimit then
                    if Config.enginebrake == true then
                        if speed / currspeedlimit > 1.1 then
                        local hhhh = speed / currspeedlimit
                        SetVehicleCurrentRpm(vehicle,hhhh)
                        SetVehicleCheatPowerIncrease(vehicle,-100.0)
                        else
                        SetVehicleCheatPowerIncrease(vehicle,0.0)
                        end
                    else
                        SetVehicleCheatPowerIncrease(vehicle,0.0)
                    end
                end
            else
                if speed >= topspeedms then
                    SetVehicleCheatPowerIncrease(vehicle,0.0)
                else  
                end
            end
        end
    end
end)

function round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

local playanim = true
local currentGear = 0
local LanimationDict = "veh@driveby@first_person@passenger_rear_right_handed@smg" 
local LanimationName = "outro_90r"
local RanimationDict = "veh@driveby@first_person@passenger_rear_left_handed@smg" 
local RanimationName = "outro_90l"
local animationDuration = Config.animationDuration

function LPlayGearChangeAnimation(gear)
if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
    RequestAnimDict(LanimationDict)
    while not HasAnimDictLoaded(LanimationDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), LanimationDict, LanimationName, 8.0, 1.0, animationDuration, 16, 0, 0, 0, 0)

    Wait()
    StopAnimTask(PlayerPedId(), LanimationDict, LanimationName, 1.0)
end
end

function RPlayGearChangeAnimation(gear)
if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
    RequestAnimDict(RanimationDict)
    while not HasAnimDictLoaded(RanimationDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), RanimationDict, RanimationName, 8.0, 1.0, animationDuration, 16, 0, 0, 0, 0)

    Wait(animationDuration)
    StopAnimTask(PlayerPedId(), RanimationDict, RanimationName, 1.0)
end
end

function OnGearChange(newGear, rhd, blacklist)
if blacklist == false then 
    if newGear ~= currentGear then
        currentGear = newGear
      if rhd == true then 
        RPlayGearChangeAnimation(currentGear)
      else 
        LPlayGearChangeAnimation(currentGear)
      end
    end
end
end

RegisterNetEvent("gearChange")
AddEventHandler("gearChange", OnGearChange)

function DetectGearChange()
    local ped = PlayerPedId()
    local rhd = false
    local vehicle = GetVehiclePedIsIn(ped, false)
    local blacklist = false
    local vehclass = GetVehicleClass(vehicle)
    local vehicleName = GetEntityModel(vehicle)
if vehicle ~= 0 then
    if vehclass ~= 8 and vehclass ~= 13 and playanim == true then
      for k, v in ipairs(Config.RHDCars) do
        if vehicleName == GetHashKey(v) then
            rhd = true
            break 
        end
      end
      for k, v in ipairs(Config.BlacklistCars) do
        if vehicleName == GetHashKey(v) then
            blacklist = true
            break 
        end
      end
        local newGear = GetVehicleCurrentGear(vehicle)
        if newGear ~= currentGear then
            TriggerEvent("gearChange", newGear, rhd, blacklist)
        end
      end
    else
        if currentGear ~= 0 then
            currentGear = 0
            StopAnimTask(PlayerPedId(), LanimationDict, LanimationName, 1.0)
            StopAnimTask(PlayerPedId(), RanimationDict, RanimationName, 1.0)
            ClearPedTasks(PlayerPedId())
        end
    end
end

CreateThread(function()
    while true do
        DetectGearChange()
        Wait(100)
    end
end)

function Notify(text)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(text)
        DrawNotification(0,1)
end

RegisterCommand(Config.CommandName, function()

   if playanim == true then 
    QBCore.Functions.Notify(Lang:t('notify.playanim_disabled'), 'error', 5000)
    playanim = false
   else 
    QBCore.Functions.Notify(Lang:t('notify.playanim_enabled'), 'success', 5000)
    playanim = true  
   end

end)