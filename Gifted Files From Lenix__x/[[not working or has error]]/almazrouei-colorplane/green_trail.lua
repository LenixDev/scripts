local fxDict = "scr_ar_planes"
local smokeEffectName = "scr_ar_trail_smoke"

local smokeActive = false
local leftSmokeEffect = nil
local rightSmokeEffect = nil


local allowedPlanes = Flash.AllowedPlanes

Citizen.CreateThread(function()
    RequestNamedPtfxAsset(fxDict)
    while not HasNamedPtfxAssetLoaded(fxDict) do
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleModel = GetEntityModel(vehicle)

        for _, allowedPlane in ipairs(allowedPlanes) do
            if IsPedInAnyVehicle(playerPed, false) and vehicleModel == GetHashKey(allowedPlane) then
                if IsControlJustReleased(1, 20) then
                    if smokeActive then

                        if leftSmokeEffect then
                            StopParticleFxLooped(leftSmokeEffect, false)
                            leftSmokeEffect = nil
                        end
                        if rightSmokeEffect then
                            StopParticleFxLooped(rightSmokeEffect, false)
                            rightSmokeEffect = nil
                        end
                        smokeActive = false
                    else

                        local leftOffsetX = -1.5
                        local rightOffsetX = 1.5
                        local offsetY = -1.5
                        local offsetZ = 0.5


                        UseParticleFxAssetNextCall(fxDict)


                        leftSmokeEffect = StartParticleFxLoopedOnEntity(smokeEffectName, vehicle, leftOffsetX, offsetY, offsetZ, 0, 0, 0, 1.0, false, false, false, false)
                        SetParticleFxLoopedColour(leftSmokeEffect, 1.0, 1.0, 1.0)

 
                        Citizen.Wait(100)


                        UseParticleFxAssetNextCall(fxDict)

                        rightSmokeEffect = StartParticleFxLoopedOnEntity(smokeEffectName, vehicle, rightOffsetX, offsetY, offsetZ, 0, 0, 0, 1.0, false, false, false, false)
                        SetParticleFxLoopedColour(rightSmokeEffect, 0.0, 1.0, 0.0) 

                        smokeActive = true
                    end
                end
            end
        end
    end
end)
