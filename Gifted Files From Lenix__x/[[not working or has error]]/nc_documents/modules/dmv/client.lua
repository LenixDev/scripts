function CreatePhotoCam()
    local ped = PlayerPedId()
    local pos, heading = GetOffsetFromEntityInWorldCoords(ped, 0.01, Config.Photos.CameraDistance, 0.65), GetEntityHeading(ped)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, 0.0, 0.00, heading - 180.0, 45.00, false, 0)
	SetCamActive(cam, true)
	RenderScriptCams(true, true, 1, true, true)
    return cam
end

function DeletePhotoCam(cam)
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 1, true, true)
    DestroyCam(cam) 
end

function GetDirectionFromRotation(rot)
    local dm = (math.pi / 180)
    return vector3(-math.sin(dm * rot.z) * math.abs(math.cos(dm * rot.x)), math.cos(dm * rot.z) * math.abs(math.cos(dm * rot.x)), math.sin(dm * rot.x))
end

function RequestPhoto(cb, bool)
    if TakingPhoto then return end
    if bool == nil or bool == true then 
        TakingPhoto = true
        CreateThread(function()
            local ped = PlayerPedId()
            local lastCoords, lastHeading = GetEntityCoords(ped), GetEntityHeading(ped)
            DoScreenFadeOut(1000)
            Wait(1100)
            local coords = Config.Photos.Coords
            SetEntityCoords(ped, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, false)
            SetEntityHeading(ped, Config.Photos.Heading)
            FreezeEntityPosition(ped, true)
            local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0,  1.0, 1.65)
            local rot = GetEntityRotation(ped, 2)
            rot = vector3(rot.x, rot.y, rot.z - 180.0)
            local dir = GetDirectionFromRotation(rot)
            local cam = CreatePhotoCam()
            ClearPedTasksImmediately(ped)
            Wait(100)
            DoScreenFadeIn(1000)
            local photoURL
            repeat
                while true do 
                    Wait(0)
                    if (not ShowHelpNotification(_L("take_photo")) and IsControlJustPressed(1, 51)) then 
                        break
                    end
                end
                local url = nil
                SetTimeout(300, function()
                    exports['screenshot-basic']:requestScreenshotUpload(Config.Photos.UploadURL, Config.Photos.UploadProtocol, function(data)
                        local resp = json.decode(data)
                        url = Config.Photos.ResponseHandler(resp)
                    end)
                end)
                while not url do
                    Wait(0)
                    DrawSpotLight(pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, 255, 255, 255, 100.0, Config.Photos.Brightness, 0.0, 1000.0, 1.0)
                end
                Wait(100)
                for i=1, 10 do
                    Wait(0)
                    DrawSpotLight(pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, 255, 255, 255, 100.0, Config.Photos.Brightness, 0.0, 1000.0, 1.0)
                end
                Wait(100)
                for i=1, 10 do
                    Wait(0)
                    DrawSpotLight(pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, 255, 255, 255, 100.0, Config.Photos.Brightness, 0.0, 1000.0, 1.0)
                end
                local alert = lib.alertDialog({
                    header = 'Photo Taken',
                    content = '![Photo ID Image]('..url..')\n\nUse this image?',
                    centered = true,
                    cancel = true
                })
                if (alert == "confirm") then 
                    photoURL = url
                end
            until photoURL
            DoScreenFadeOut(1000)
            Wait(1100)
            DeletePhotoCam(cam)
            SetEntityCoords(ped, lastCoords.x, lastCoords.y, lastCoords.z, 0.0, 0.0, 0.0, false)
            SetEntityHeading(ped, lastHeading)
            FreezeEntityPosition(ped, false)
            Wait(100)
            DoScreenFadeIn(1000)
            TakingPhoto = false
            cb(photoURL)
        end)
    else
        cb(nil)
    end
end

function RequestFields(requiredFields, cb)
    if requiredFields then 
        local fields = nil
        repeat
            local success = true
            local input = lib.inputDialog(_L("dmv_form"), requiredFields)

            if input and #input == #requiredFields then 
                local arr = {}
                for i=1, #input do 
                    if input[i] == nil or input[i] == "" then
                        success = false
                    else
                        arr[requiredFields[i].metakey] = input[i]
                    end
                end 
                if success then 
                    fields = arr
                end 
            elseif not input then
                break
            end
            Wait(250)
        until fields
        cb(fields)
    else
        cb({})
    end
end

function OpenDMVMenu(index)
    local cfg = Config.Locations[index]
    local options = cfg.Options
    
    local menuOptions = {}
    local icons = {
        'fas fa-id-card',          
        'fas fa-gun',              
        'far fa-file-alt',         
        'fas fa-car',          
    }

    for i, option in ipairs(options) do
        table.insert(menuOptions, {
            header = option.label,
            txt = '',
            icon = icons[i] or 'far fa-file', 
            params = {
                event = 'nc_documents:dmv:selectOption',
                args = {
                    index = index,
                    selected = i
                }
            }
        })
    end

    table.insert(menuOptions, {
        header = "Close Menu",
        txt = '',
        icon = 'fas fa-times', 
        params = {
            event = 'qb-menu:client:closeMenu'
        }
    })

    TriggerEvent('qb-menu:client:openMenu', menuOptions)
end

RegisterNetEvent('nc_documents:dmv:selectOption')
AddEventHandler('nc_documents:dmv:selectOption', function(data)
    OpenSecondaryMenu(data.index, data.selected)
end)

function OpenSecondaryMenu(index, selected)
    local cfg = Config.Locations[index]
    local options = cfg.Options

    ServerCallback("nc_documents:dmv:requestOption", function(result)
        if result then 
            local doc = Config.Documents[options[selected].document]
            RequestFields(doc.RequiredFields, function(fields)
                if not fields then return end
                RequestPhoto(function(photoURL) 
                    fields.photoURL = photoURL
                    ServerCallback("nc_documents:dmv:finishProcessOption", function(result) 
                        if result then 
                            -- Handle success
                        end
                    end, index, selected, fields)
                end, doc.RequiresPhoto)
            end)
        end
    end, index, selected)
end


CreateThread(function()
    for i = 1, #Config.Locations do
        local cfg = Config.Locations[i]
        if (cfg.Blip) then
            cfg.Blip.Location = cfg.Coords
            CreateBlip(cfg.Blip)
        end
    end

    while true do
        local wait = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i = 1, #Config.Locations do
            local cfg = Config.Locations[i]
            local dist = #(cfg.Coords - coords)
            if (dist < 20.0) then
                wait = 0
                -- DrawMarker(2, cfg.Coords.x, cfg.Coords.y, cfg.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.15, 0.15, 0.15, 255, 255, 255, 127, false, true)
                if (dist < 0.5 and IsControlJustPressed(1, 51)) then
                    OpenDMVMenu(i)
                end
            end
        end
        Wait(wait)
    end
end)

exports("RequestPhoto", RequestPhoto)
exports("RequestFields", RequestFields)