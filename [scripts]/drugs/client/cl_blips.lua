local blips = {}
local dealerBlips = {}
local adminBlips = {}

local function calculateCenterPoint(coords)
    -- Initialize variables
    local avgX = 0
    local avgY = 0
    local numCoords = #coords

    -- Iterate through coordinates and accumulate sums
    for i = 1, numCoords do
        avgX = avgX + coords[i].x
        avgY = avgY + coords[i].y
    end

    -- Calculate averages
    avgX = avgX / numCoords
    avgY = avgY / numCoords

    -- Create and return center point vector2
    return vector2(avgX, avgY)
end

AddAdminBlip = function(id, coords, lable, type)
    if adminBlips[id] then
        RemoveBlip(adminBlips[id])
    end

    local currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipDisplay(currentBlip, 4)
    SetBlipScale(currentBlip, 0.5)
    SetBlipAsShortRange(currentBlip, true)

    if type == 'plant' then
        SetBlipSprite(currentBlip, 496)
        SetBlipColour(currentBlip, 2)
    elseif type == 'processing' then
        SetBlipSprite(currentBlip, 514)
        SetBlipColour(currentBlip, 5)
    end

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(lable)
    EndTextCommandSetBlipName(currentBlip)

    adminBlips[id] = currentBlip
end

RemoveAdminBlip = function(id)
    if not adminBlips[id] then return end
    RemoveBlip(adminBlips[id])
    adminBlips[id] = nil
end

AddDealerBlip = function(coords, sprite, color, text)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.4)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    table.insert(dealerBlips, blip)
end

RemoveDealerBlip = function(coords)
    for i, v in ipairs(dealerBlips) do
        local blipCoords = GetBlipInfoIdCoord(v)
        if blipCoords.x == coords.x and blipCoords.y == coords.y then
            RemoveBlip(v)
            table.remove(dealerBlips, i)
            break
        end
    end
end

RemoveDealerBlips = function()
    for _, v in ipairs(dealerBlips) do
        RemoveBlip(v)
    end
    dealerBlips = {}
end

CreateThread(function()
    for k, v in pairs(Config.Zones) do
        if v.blip.display then
            local center = calculateCenterPoint(v.points)

            local blip = AddBlipForCoord(center.x, center.y, 200)
            SetBlipSprite(blip, v.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.4)
            SetBlipColour(blip, v.blip.displayColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blip.displayText)
            EndTextCommandSetBlipName(blip)
            table.insert(blips, blip)
        end
    end
end)

-- Remove Blips on Resource Stop
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, v in pairs(blips) do
            RemoveBlip(v)
        end

        for _, v in pairs(adminBlips) do
            RemoveBlip(v)
        end

        for _, v in pairs(dealerBlips) do
            RemoveBlip(v)
        end
    end
end)

--[[ local locations = {
    {x = 69.69, y = -1832.37, z = 25.27, radius = 200.0},
    {x = -1253.32, y = -1464.75, z = 4.26, radius = 200.0},
    {x = 332.09, y = 16.33, z = 84.99, radius = 350.0}
}

function createRadiusBlip(location)
    local blip = AddBlipForRadius(location.x, location.y, location.z, location.radius)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 20)

    local centerBlip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(centerBlip, 310)
    SetBlipColour(centerBlip, 1)
    SetBlipScale(centerBlip, 0.4)
    SetBlipAsShortRange(centerBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Anonymous")
    EndTextCommandSetBlipName(centerBlip)
end

for _, location in pairs(locations) do
    createRadiusBlip(location)
end ]]