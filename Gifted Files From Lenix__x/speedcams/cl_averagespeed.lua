local modelHash = `prop_speed_camera`
local detecting = false
local time = 0
local cameraId = 0
local mph = true
if main.useKmh ~= nil then
    if main.useKmh then
        mph = false
    end
end

Citizen.CreateThread(function()
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    for k, v in pairs(config) do
        config[k].cameraOne.prop = CreateObject(modelHash, v.cameraOne.coords.x, v.cameraOne.coords.y, v.cameraOne.coords.z - 1.0, false, false, true)
        while not DoesEntityExist(config[k].cameraOne.prop) do Wait(0) end
        PlaceObjectOnGroundProperly(config[k].cameraOne.prop)
        FreezeEntityPosition(config[k].cameraOne.prop, true)
        SetEntityHeading(config[k].cameraOne.prop, config[k].cameraOne.heading)
        config[k].cameraTwo.prop = CreateObject(modelHash, v.cameraTwo.coords.x, v.cameraTwo.coords.y, v.cameraTwo.coords.z - 1.0, false, false, true)
        while not DoesEntityExist(config[k].cameraTwo.prop) do Wait(0) end
        PlaceObjectOnGroundProperly(config[k].cameraTwo.prop)
        FreezeEntityPosition(config[k].cameraTwo.prop, true)
        SetEntityHeading(config[k].cameraTwo.prop, config[k].cameraTwo.heading)
        config[k].distance = #(v.cameraOne.coords - v.cameraTwo.coords)
    end
    SetModelAsNoLongerNeeded(modelHash)

    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local class = GetVehicleClass(vehicle)
                if main.exemptVehicleClasses ~= nil then
                    if main.exemptVehicleClasses[class] == nil then
                        local coords = GetEntityCoords(ped)
                        if not detecting then
                            for k, v in pairs(config) do
                                local distance = #(coords - v.cameraOne.coords)
                                if distance < main.detectionRadius then
                                    handleDetection(k)
                                    break
                                end
                            end
                        else
                            time = time + 0.05
                            local distance = #(coords - config[cameraId].cameraTwo.coords)
                            if distance < main.detectionRadius then
                                local speed = 0.0
                                if mph then
                                    speed = (config[cameraId].distance / time) * 2.236936
                                else
                                    speed = (config[cameraId].distance / time) * 3.6
                                end
                                if speed > (config[cameraId].limit + (config[cameraId].limit / main.addPercentage) + main.addLimit) then
                                    local roadName = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
                                    local roadNameString = GetStreetNameFromHashKey(roadName)
                                    local numberplate = tostring(GetVehicleNumberPlateText(vehicle))
                                    TriggerServerEvent("Server:AverageSpeedDetection", cameraId, speed, roadNameString, numberplate)
                                    if main.flashScreen ~= nil and main.flashScreen then
                                        PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", 1)
                                        StartScreenEffect("FocusOut", 0, false)
                                        Wait(2000)
                                        StopScreenEffect("FocusOut")
                                    end
                                end
                                detecting = false
                                time = 0
                                cameraId = 0
                            end
                        end
                    end
                end
            end
        end
        Wait(50)
    end
end)

function handleDetection(id)
    detecting = true
    cameraId = id
    time = 0
    Citizen.SetTimeout(40000, function()
        if detecting and cameraId == id then
            detecting = false
            time = 0
        end
    end)
end