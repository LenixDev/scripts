-- Core init
local venom = exports[Venom.CoreName]:GetCoreObject()


Citizen.CreateThread(function()
    exports[Venom.TargetName]:AddBoxZone("venom1", vector3(-659.3, -1111.25, 15.06), 0.4, 0.6, {
        name = "venom1",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    exports[Venom.TargetName]:AddBoxZone("venom2", vector3(-655.83, -1111.58, 21.83), 0.2, 0.8, {
        name = "venom2",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    exports[Venom.TargetName]:AddBoxZone("venom4", vector3(-655.83, -1111.58, 26.6), 0.5, 0.9, {
        name = "venom4",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    exports[Venom.TargetName]:AddBoxZone("venom3", vector3(-655.83, -1111.58, 31.57), 0.5, 0.9, {
        name = "venom3",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    exports[Venom.TargetName]:AddBoxZone("venom5", vector3(-655.83, -1111.58, 36.57), 0.5, 0.9, {
        name = "venom5",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    exports[Venom.TargetName]:AddBoxZone("venom6", vector3(-655.83, -1111.58, 41.57), 0.5, 0.9, {
        name = "venom6",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    exports[Venom.TargetName]:AddBoxZone("venom7", vector3(-655.83, -1111.58, 46.47), 0.5, 0.9, {
        name = "venom7",
        useZ = "true",
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel:client:el",
                icon = "fas fa-elevator",
                label = "Elevetor",
                job = "all",
            },
        },
        distance = 2.0
    })
    addZones()
end)



--[[RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    addZones()
end)--]]

Citizen.CreateThread(function()
    Wait(1000)
    venom.Functions.TriggerCallback('venom-hotel_rooms:server:GetConfig', function(Rooms)
        Venom.Rooms = Rooms
    end)
end)

RegisterNetEvent('venom-hotel_rooms:client:Refresh')
AddEventHandler('venom-hotel_rooms:client:Refresh', function(room)
    Venom.Rooms = room
end)

-- Hotel Blip
Citizen.CreateThread(function()
    local scale = Venom.Blipscale
    local label = Venom.Bliplabel
    local sprite = Venom.Blipsprite
    local color = Venom.Blipcolour
    local display = Venom.Blipdisplay
    Blip = AddBlipForCoord(Venom.Reception.coords.x, Venom.Reception.coords.y, Venom.Reception.coords.z)
    SetBlipSprite(Blip, sprite)
    SetBlipDisplay(Blip, display)
    SetBlipScale(Blip, scale)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(Blip)
end)


-- Reception
Citizen.CreateThread(function()
    local Reception = Venom.Reception
    exports[Venom.TargetName]:AddBoxZone("Reception", vector3(Reception.coords.x, Venom.Reception.coords.y, Reception.coords.z), 2.5, 1, {
        name = "Reception",
        debugPoly = false,
        heading = Reception.heading,
        minZ = Reception.coords.z - 1,
        maxZ = Reception.coords.z + 1,
    }, {
        options = {
            {
                type = "client",
                event = "venom-hotel_rooms:client:ReceptionMenu",
                icon = "fa fa-hand",
                label = "Hotel Reception"
            },
            {
                type = "client",
                event = "venom-hotel_rooms:client:GiveNewKey",
                icon = "fa fa-key",
                label = "Request Room New Key"
            },
        },
        distance = 2.0
    })

    RequestModel(Reception.ped)
        while not HasModelLoaded(Reception.ped) do
        Wait(1000)
    end
    ReceptionMan = CreatePed(0, Reception.ped, Reception.coords.x, Reception.coords.y, Reception.coords.z - 1, Reception.heading, false, false) -- change here the cords for the ped 
    SetPedFleeAttributes(ReceptionMan, 0, 0)
    SetPedDiesWhenInjured(ReceptionMan, false)
    TaskStartScenarioInPlace(ReceptionMan, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetPedKeepTask(ReceptionMan, true)
    SetBlockingOfNonTemporaryEvents(ReceptionMan, true)
    SetEntityInvincible(ReceptionMan, true)
    FreezeEntityPosition(ReceptionMan, true)
end)


RegisterNetEvent('venom-hotel_rooms:client:ReceptionMenu', function()
    local PlayerData = venom.Functions.GetPlayerData()
        local menu = {}
        venom.Functions.TriggerCallback('venom-hotel_rooms:server:GetConfig', function(Rooms)
            Venom.Rooms = Rooms
        end)
        menu[#menu + 1] = {
            header = "Hotel",
            icon = "fas fa-hotel",
            isMenuHeader = true,
            }
        for k, v in pairs(Venom.Rooms) do
            if not Venom.Rooms[k].isOwned then
                menu[#menu + 1] = {
                    header = "Hotel Room "..k.."",
                    icon = "fas fa-building",
                    txt = "Rent this room for "..Venom.RoomRentCost.." $",
                    params = {
                        event = "venom-hotel_rooms:client:NewRoomRent",
                        args = {
                            room = k
                        }
                    }
                }
            end
        end
        menu[#menu + 1] = {
            header = "Exit",
            icon = "fa-duotone fa-circle-xmark",
            params = {
                event = ""
            }
          }
        if #menu <= 0 then 
            venom.Functions.Notify('All hotels rooms has been rented', 'info', 3000)
            return 
        end
        exports[Venom.MenuName]:openMenu(menu)
end)

RegisterNetEvent('venom-hotel_rooms:client:NewRoomRent', function(data)
    local room = data.room
    if Venom.Rooms[room] ~= nil then
        venom.Functions.TriggerCallback('venom-hotel_rooms:server:CheckOwned', function(boolean)
            if boolean then
                local Menu = {
                    {
                        header ='Confirm Room Rent #'..room,
                        txt = "Room contract registration price: "..Venom.RoomRentCost.."$ <br> Room Daily Rental Costs: "..Venom.DailyRental.."$",
                        disabled = true
                    },
                    {
                        header ='Yes',
                        params = {
                            event = "venom-hotel_rooms:client:rentRoom",
                            args = {
                                Room = room,
                            }
                        }
                    },
                    {
                        header ='No',
                        params = {
                            event = "",
                        }
                    },
                    
                }
                exports[Venom.MenuName]:openMenu(Menu)
            else
                venom.Functions.Notify('You already have a room', 'info', 3000)
            end
        end)
    end
end)

RegisterNetEvent('venom-hotel_rooms:client:rentRoom', function(data)
    TriggerServerEvent('venom-hotel_rooms:server:rentRoom', data.Room)
end)

-- Box Zones Add
RegisterCommand('s', function()
    addZones()
end)

RegisterNetEvent("venom-hotel:client:el", function()
    local input = lib.inputDialog('Appartment Elevator', { 
        {type = 'number', label = ' Select Floor', description = '(0 to 6) - Lobby: 0 ', icon = 'fas fa-elevator'},
    })

    local twoer = input[1]

    if twoer == nil then
    else
        if twoer >= 0 and twoer <= 6 then
            TriggerEvent("venom-hotel:client:el2", twoer)
        else
            TriggerEvent('QBCore:Notify', "Invalid Floor choose between 0 - 6", "error")
        end
    end
end)

RegisterNetEvent("venom-hotel:client:el2", function(idtower)
    local venomel = idtower
    if venomel == 1 then
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
     local coords = vector4(-655.51, -1110.35, 21.83, 62.46)
       SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
     Citizen.Wait(100)
       DoScreenFadeIn(1000)
       venom.Functions.Notify('Floor 1', 'success', 3000)
elseif venomel == 2 then
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
     local coords = vector4(-655.45, -1110.54, 26.6, 61.92)
       SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
     Citizen.Wait(100)
       DoScreenFadeIn(1000)
       venom.Functions.Notify('Floor 2', 'success', 3000)
    elseif venomel == 3 then
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
         local coords = vector4(-655.41, -1110.47, 31.37, 62.66)
           SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
         Citizen.Wait(100)
           DoScreenFadeIn(1000)
           venom.Functions.Notify('Floor 3', 'success', 3000)
    elseif venomel == 0 then
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
         local coords = vector4(-658.99, -1110.36, 15.06, 61.79)
           SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
         Citizen.Wait(100)
           DoScreenFadeIn(1000)
        venom.Functions.Notify('Floor 0', 'success', 3000)
    elseif venomel == 4 then
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
         local coords = vector4(-655.42, -1110.33, 36.14, 76.26)
           SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
         Citizen.Wait(100)
           DoScreenFadeIn(1000)
        venom.Functions.Notify('Floor 4', 'success', 3000)
    elseif venomel == 5 then
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
         local coords = vector4(-655.42, -1110.33, 40.91, 66.89)
           SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
         Citizen.Wait(100)
           DoScreenFadeIn(1000)
        venom.Functions.Notify('Floor 5', 'success', 3000)
    elseif venomel == 6 then
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
         local coords = vector4(-655.42, -1110.33, 45.68, 66.89)
           SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
         Citizen.Wait(100)
           DoScreenFadeIn(1000)
        venom.Functions.Notify('Floor 6', 'success', 3000)
   end
end)

function addZones()
    for k, v in pairs(Venom.Rooms) do 
        local ZoneName = "Locker"..k
        exports[Venom.TargetName]:AddBoxZone(ZoneName, vector3(v.locker.coords.x, v.locker.coords.y, v.locker.coords.z), v.locker.width, v.locker.hight, {
            name= ZoneName,
            heading= v.locker.heading,
            debugPoly = false,
            minZ= v.locker.minZ,
            maxZ= v.locker.maxZ
            }, {
            options = {
                {
                    event = 'venom-hotel_rooms:client:LockerOpen',
                    icon = "fas fa-vault",
                    label = "Stash",
                },
                {
                    event = 'qb-clothing:client:openOutfitMenu',
                    icon = "fas fa-shirt",
                    label = "Open Outfits Menu",
                }
            },
            distance = 1.5,
        })
    end
end


RegisterNetEvent('venom-hotel_rooms:client:LockerOpen', function(data)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local locker = data.locker
    for k,v in pairs(Venom.Rooms) do
        local distance = #(coords - Venom.Rooms[k].locker.coords)
        if distance < 2.5 then
            locker = k
                local menu = {
                    {
                        header = locker.." Room Stash",
                        icon = "fas fa-hotel",
                        isMenuHeader = true
                    },
                    {
                        header = "Open Stash",
                        txt = "Open your Stash",
                        icon = "fas fa-vault",
                        params = {
                            event = "venom-hotel_rooms:client:OpenLockerInv",
                            args = {
                                locker = locker
                            }
                        }
                    },
                }
                exports[Venom.MenuName]:openMenu(menu)
            end
    end
end)

RegisterNetEvent('venom-hotel_rooms:client:OpenLockerInv', function(data)
    local lockerNum = data.locker
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Appartment locker"..lockerNum, {
        maxweight = Venom.Maxweight,
        slots = Venom.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "Appartment locker"..lockerNum)
end)



RegisterNetEvent('venom-hotel_rooms:client:newlockerfeatures', function(data)
    TriggerServerEvent('venom-hotel_rooms:server:newlockerfeatures', data)
end)

RegisterNetEvent('venom-hotel_rooms:client:RoomKey', function(room)
    if room == nil then return end
    local roomInfo = Venom.Rooms[room]
    local doornumber = roomInfo.Door.Id
    local doorcords = roomInfo.Door.Coords
    local plyCoords = GetEntityCoords(PlayerPedId())
    local distance = #(plyCoords - roomInfo.Door.Coords)
    if distance < 2.0 then
        venom.Functions.TriggerCallback('venom-hotel_rooms:server:canOpenLocker', function(hasAccess, isOwner)
            if hasAccess then
                if roomInfo.Door.isClosed then
                    TriggerServerEvent(Venom.Doorlockevent, doornumber, false, false, false, true)
                    roomInfo.Door.isClosed = false
                elseif roomInfo.Door.isClosed == false then
                    TriggerServerEvent(Venom.Doorlockevent, doornumber, true, false, false, true)
                    roomInfo.Door.isClosed = true
                end
            end
end, room)
else
    venom.Functions.Notify("Did you try to open invisible door ?", "error", 3000)
end
end)

RegisterNetEvent('venom-hotel_rooms:client:GiveNewKey')
AddEventHandler('venom-hotel_rooms:client:GiveNewKey', function()
    local Room = nil
    local keyboard = exports[Venom.InputName]:ShowInput({
        header = "Room Number",
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                text = "Enter room number",
                name = 'room',
            }
        }
    })
	if keyboard ~= nil then
        local k = tonumber(keyboard.room)
        if Venom.Rooms[k] ~= nil then
            Room = k
            if Venom.Rooms[Room].isOwned then

                venom.Functions.TriggerCallback('venom-hotel_rooms:server:canOpenLocker', function(hasAccess, isOwner)
                    if isOwner then
                        venom.Functions.TriggerCallback('venom-hotel_rooms:server:GiveNewRoomKey', function(iscreated)
                            if iscreated then
                                venom.Functions.Notify("You have been given a new key for your room", "success", 4000)
                            end
                        end, k)
                    end
                end, Room)

            end
        end

    end

end)