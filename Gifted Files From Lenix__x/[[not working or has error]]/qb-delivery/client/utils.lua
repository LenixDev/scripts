Utils.Functions.CustomTargetSystem = {}

function Utils.Functions.CustomTargetSystem.AddTargetEntity(entity, options, func)
    --[[
        The following variables will help you.
        Integrate them according to your own target script.
    ]]
    local icon = options.icon
    local label = options.label
    local jobs = options.groups
    local onSelect = func
    --[[
        example:
        exports.ox_target:addLocalEntity(entity, {
            {
                icon = icon,
                label = label,
                groups = jobs,
                onSelect = onSelect,
                distance = 2.5
            }
        })
    ]]
end

function Utils.Functions.CustomTargetSystem.AddTargetCoords(coords, size, options, func)
    --[[
        The following variables will help you.
        Integrate them according to your own target script.
        !!! return created target id ! for it to be removable
    ]]
    local icon = options.icon
    local label = options.label
    local onSelect = func
    --[[
        example:
        return exports.ox_target:addBoxZone({
            coords = coords,
            size = size,
            {
                icon = icon,
                label = label,
                onSelect = onSelect,
                distance = 2.5
            }
        })
    ]]
end

function Utils.Functions.CustomTargetSystem.RemoveTargetEntity(entities)
    --[[
        The following variables will help you.
        Integrate them according to your own target script.
    ]]
    --[[
        example:
        exports.ox_target:removeLocalEntity(entities)
    ]]
end

function Utils.Functions.CustomTargetSystem.RemoveZone(zone)
    -- zone:string or number | zone ID
    --[[
        example:
        exports.ox_target:removeZone(zone)
    ]]
end

-- @ --

function Utils.Functions.GiveVehicleKey(plate, vehicle)
    TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(vehicle, plate))
end

function Utils.Functions.AddWaisExtraDialog(entity, point)
    if Koci.Utils.hasResource("wais-npcdialog") then
        exports["wais-npcdialog"]:addExtraDialog({
            entity = entity,
            label = "qb-delivery:toggleDuty",
            coords = vector4(
                point.employerPed.waisDialog.coords.x,
                point.employerPed.waisDialog.coords.y,
                point.employerPed.waisDialog.coords.z,
                point.employerPed.waisDialog.coords.w
            ),
            distance = 2.0,
            markerdistance = 2.0,
            modal_style = "warning",
            interactive = {
                type = 38,
                label = "Interact",
                key_label = "E",
                icon = "fa-solid fa-people-arrows",
            },
            name = {
                firstname = "Frank",
                lastname = "Miller",
            },
            title = "Delivery",
            question =
            "Hello, are you ready to join our delivery team and get started?",
            options = {
                option1 = {
                    button = 1,
                    label = "Yes, Start as an assistant.",
                    trigger = "qb-delivery:Client:ToggleDeliveryJobDuty",
                    eventType = "client",
                    selected = false,
                },
                option2 = {
                    button = 2,
                    label = "Leave...",
                    selected = false,
                    trigger = "qb-delivery:Client:ToggleDeliveryJobDuty",
                    eventType = "client",
                },
            },
        })
    end
end

function Utils.Functions.RequestModel(model)
    if HasModelLoaded(GetHashKey(model)) then return end
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function Utils.Functions.LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function Utils.Functions.DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 70, 134, 123, 75)
    ClearDrawOrigin()
end

function Utils.Functions.DrawTextUI(text)
    if Config.TextUIType == "ox_textui" then
        lib.hideTextUI()
        lib.showTextUI(text)
    elseif Config.TextUIType == "qb_textui" then
        exports["qb-core"]:DrawText(text, "right")
    end
end

function Utils.Functions.HideTextUI()
    if Config.TextUIType == "ox_textui" then
        lib.hideTextUI()
    elseif Config.TextUIType == "qb_textui" then
        exports["qb-core"]:HideText()
    end
end

function Utils.Functions.GetVehicleBackPosition(Vehicle)
    local function rotateRect(angle, ox, oy, x, y, w, h)
        local xAx = math.cos(angle);
        local xAy = math.sin(angle);
        x -= ox;
        y -= oy;
        local res = {}
        res[1] = {}
        res[1][1] = (x + w) * xAx - (y + h) * xAy + ox;
        res[1][2] = (x + w) * xAy + (y + h) * xAx + oy;

        res[2] = {}
        res[2][1] = x * xAx - (y + h) * xAy + ox;
        res[2][2] = x * xAy + (y + h) * xAx + oy;
        return res
    end

    local min, max = GetModelDimensions(GetEntityModel(Vehicle))
    local vehicleRotation = GetEntityRotation(Vehicle, 2)
    local Xwidth = (0 - min.x) + (max.x)
    local Ywidth = (0 - min.y) + (max.y)
    local degree = (vehicleRotation.z + 180) * math.pi / 180
    local position = GetEntityCoords(Vehicle)

    local newDegrees = rotateRect(degree, position.x, position.y, position.x - max.x, position.y - max.y,
        Xwidth, Ywidth)

    local bottomX = newDegrees[1][1] + ((newDegrees[2][1] - newDegrees[1][1]) / 2)
    local bottomY = newDegrees[1][2] + ((newDegrees[2][2] - newDegrees[1][2]) / 2)

    return vec3(bottomX, bottomY, position.z)
end

