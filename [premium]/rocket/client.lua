-- Define the coordinates where the interaction will happen
local interactionCoords = vector3(453.05, -1024.36, 28.48)  -- New coordinates for the interaction

-- Define the rocket parameters
local rocketModel = "w_lr_homing_rocket" -- Model of the rocket
local rocketLaunchCoords1 = vector3(418.31, -1024.47, 29.46) -- Launch coordinates of the first rocket (adjust as needed)
local rocketLaunchCoords2 = vector3(418.31, -1024.47, 29.46) -- Launch coordinates of the second rocket (adjust as needed)
local explosionCoords1 = rocketLaunchCoords1 -- Explosion location for the first rocket
local explosionCoords2 = rocketLaunchCoords2 -- Explosion location for the second rocket

-- Function to throw rockets and create explosions
local function throwRockets()
    RequestModel(rocketModel)
    while not HasModelLoaded(rocketModel) do
        Wait(500)
    end

    -- Launch the first rocket
    local rocket1 = CreateObject(GetHashKey(rocketModel), rocketLaunchCoords1, true, true, true)
    SetEntityAsMissionEntity(rocket1, true, true)
    ApplyForceToEntity(rocket1, 1, 0.0, 50.0, 100.0, 0, 0, 0, false, true, true, true, true, true)

    -- Launch the second rocket
    local rocket2 = CreateObject(GetHashKey(rocketModel), rocketLaunchCoords2, true, true, true)
    SetEntityAsMissionEntity(rocket2, true, true)
    ApplyForceToEntity(rocket2, 1, 0.0, 50.0, 100.0, 0, 0, 0, false, true, true, true, true, true)

    -- Wait for a short time before creating the explosions
    Citizen.Wait(0) -- Adjust this value to match the rockets' flight duration

    -- Create explosions
    AddExplosion(explosionCoords1.x, explosionCoords1.y, explosionCoords1.z, 2, 200.0, true, false, 1.0)
    AddExplosion(explosionCoords2.x, explosionCoords2.y, explosionCoords2.z, 2, 200.0, true, false, 1.0)
    
    -- Optionally delete the rocket objects if no longer needed
    DeleteObject(rocket1)
    DeleteObject(rocket2)
end

-- Create a thread to add qb-target interaction using specific coordinates
Citizen.CreateThread(function()
    Citizen.Wait(500) -- Small delay to ensure everything is loaded properly

    -- Add qb-target interaction using coordinates
    exports['qb-target']:AddBoxZone("rocket_launch_zone", interactionCoords, 1.0, 1.0, {
        name = "rocket_launch_zone",
        heading = 0,
        debugPoly = false, -- Enable this to visualize the zone and debug if it's being created correctly
        minZ = 27.48,  -- Adjust these values to match your desired height range
        maxZ = 29.48,  -- Adjust these values to match your desired height range
    }, {
        options = {
            {
                type = "client",
                event = "rocket:throwRockets",
                icon = "fas fa-rocket",
                label = "أطلق",
                job = {
                    ["police"] = 18,
                }
            },
        },
        distance = 1.5 -- Interaction distance
    })
end)

-- Event handler for throwing rockets
RegisterNetEvent('rocket:throwRockets')
AddEventHandler('rocket:throwRockets', function()
    throwRockets()
end)
