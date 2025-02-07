uiLoaded = false
loggedIn = false
spam = false
menuOpen = false
stopBlip = nil
npc = nil
npcBlip = nil
jobStarted = false
entered = false
level = 0
stopId = 1
CurrentJob = {}
PlayerData = {}
time = Config.TimeToGetInVehicle
passengers = {}
createdPassengers = 0       
passengersEntering = false
busySeats = {}
cam = nil
firstStart = true
goinBack = false
damaged = false
time2 = 25
local toFloat = '%f'

CreateThread(function()
    while not uiLoaded do
        Wait(10)
    end

    npc = Functions.CREATE_PED_ON_COORD()
    npcBlip = Functions.CREATE_BLIP(Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z, Config.NPC.blip.sprite, Config.NPC.blip.color, Config.NPC.blip.name, Config.NPC.blip.scale)

    while true do
        PlayerData = Config.Framework == "esx" and Framework.GetPlayerData() or Framework.Functions.GetPlayerData()

        if next(PlayerData) then
            loggedIn = true
        end

        Wait(4000)
    end
end)

CreateThread(function()
    local sleep = 1000

    while true do
        Wait(sleep)

        if uiLoaded and loggedIn and not menuOpen then
            if Functions.CHECK_JOB() then
                if not jobStarted then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local dist = #(coords - Config.Menu)
    
                    if dist > 1.5 and dist < 6.0 then
                        sleep = 1
                        Functions.DRAW_TEXT_3D(string.format(Translation[Config.Locale].DRIVER_MENU, math.floor(dist)), Config.Menu.x,Config.Menu.y,Config.Menu.z, 0.05, 0.05)
                    elseif dist < 1.5 then
                        sleep = 1
                        Functions.DRAW_TEXT_3D(Translation[Config.Locale].DRIVER_MENU_2, Config.Menu.x,Config.Menu.y,Config.Menu.z, 0.05, 0.05)
    
                        if IsControlJustReleased(0, 38) then
                            if not spam then
                                START_SPAM_TIMER()
                                menuOpen = true
    
                                Functions.TRIGGER_SERVER_CALLBACK("aty_busjob:getData", function(cb)
                                    local playerName = Config.Framework == "qb" and PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname or PlayerData.firstName .. " " .. PlayerData.lastName
                                    level = math.floor(cb.data.exp / 100)
                                    SetNuiFocus(true, true)
    
                                    SendNUIMessage({
                                        action = "openMenu",
                                        routes = Config.Routes,
                                        level = level,
                                        name = playerName,
                                        oldRoutes = cb.data.oldMissons,
                                        avatar = cb.data.avatar,
                                        workers = cb.workers
                                    })
                                end)
                            else
                                Config.Notify(Translation[Config.Locale].SPAMMING_MENU, "error", 5000)
                            end
                        end
                    else
                        sleep = 1000
                    end
                else
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local dist = #(coords - Config.Menu)

                    if dist > 1.5 and dist < 6.0 then
                        sleep = 1
                        Functions.DRAW_TEXT_3D(string.format(Translation[Config.Locale].END_MISSION, math.floor(dist)), Config.Menu.x,Config.Menu.y,Config.Menu.z, 0.05, 0.05)
                    elseif dist < 1.5 then
                        sleep = 1
                        Functions.DRAW_TEXT_3D(Translation[Config.Locale].END_MISSION_2, Config.Menu.x,Config.Menu.y,Config.Menu.z, 0.05, 0.05)
    
                        if IsControlJustReleased(0, 38) then
                            Functions.CANCEL_JOB()
                            Config.Notify(Translation[Config.Locale].MISSION_ENDED, "success", 5000)
                        end
                    else
                        sleep = 1000
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    local sleep = 1000

    while true do
        Wait(sleep)

        if jobStarted and not entered then
            if DoesEntityExist(CurrentJob.Vehicle) then
                sleep = 1
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local carCoords = GetEntityCoords(CurrentJob.Vehicle)
                local vehdist = #(coords - carCoords)

                if vehdist > 1.5 and vehdist < 25.0 then
                    DrawMarker(2, carCoords.x, carCoords.y, carCoords.z + 3, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, true, true, 2, false, false, false, false)

                    if IsPedInVehicle(ped, CurrentJob.Vehicle, true) then
                        entered = true  
                        sleep = 1000
                        Config.Notify(Translation[Config.Locale].MISSION_STARTED, "success", 5000)
                        Functions.GET_NEXT_STOP()
                        SendNUIMessage({
                            action = "startJob",
                        })
                    end
                end                    
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)

        if jobStarted then
            local ped = PlayerPedId()

            if not DoesEntityExist(CurrentJob.Vehicle) then
                Config.Notify(Translation[Config.Locale].VEHICLE_DESTROYED, "error", 5000)
                Functions.CANCEL_JOB()
            end

            if entered then
                if not IsPedInVehicle(ped, CurrentJob.Vehicle, true) then
                    time = time - 1
    
                    SendNUIMessage({
                        action = "updateTime",
                        time = time
                    })
    
                    if time == 0 then
                        Config.Notify(Translation[Config.Locale].VEHICLE_ABANDONED, "error", 5000)
                        Functions.CANCEL_JOB()
                        SendNUIMessage({
                            action = "hideTimer",
                        })
                    end
                else
                    time = Config.TimeToGetInVehicle
                    SendNUIMessage({
                        action = "hideTimer",
                    })
                end
            end
        end
    end
end)

CreateThread(function()
    if Config.DebugStreet then
        while true do
            Wait(2000)
            
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local streetHash, _ = GetStreetNameAtCoord(table.unpack(coords))
            print("Street Name:", GetStreetNameFromHashKey(streetHash))
        end
    end
end)

CreateThread(function()
    SetPlayerControl(PlayerId(), true, 0)
    local sleep = 1000
    while true do
        Wait(sleep)

        if jobStarted and entered and not passengersEntering then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local stopCoords = CurrentJob.Stops[stopId].StopCoords
            local dist = GetDistanceBetweenCoords(coords, stopCoords.x, stopCoords.y, stopCoords.z, true)
            
            if dist < 50.0 then
                sleep = 1
                DrawMarker(1, stopCoords.x, stopCoords.y, stopCoords.z - 0.5, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
                if IsPedInVehicle(ped, CurrentJob.Vehicle, false) then

                    if dist > 3.0 and dist < 30.0 then
                        sleep = 1
                        Functions.DRAW_TEXT_3D(string.format(Translation[Config.Locale].GET_CLOSER, math.floor(dist)), stopCoords.x, stopCoords.y, stopCoords.z + 2.5, 0.1, 0.1)
                    elseif dist < 3.0 then
                        sleep = 1
                        Functions.DRAW_TEXT_3D(Translation[Config.Locale].LET_PASSENGERS_IN, stopCoords.x, stopCoords.y, stopCoords.z + 2.5, 0.1, 0.1)

                        if IsControlJustReleased(0, 38) then
                            busySeats = {}
                            SetPlayerControl(PlayerId(), false, 0)
                            SetVehicleDoorOpen(CurrentJob.Vehicle, 0, false, false)
                            SetVehicleDoorOpen(CurrentJob.Vehicle, 1, false, false)
                            SetVehicleDoorOpen(CurrentJob.Vehicle, 2, false, false)
                            SetVehicleDoorOpen(CurrentJob.Vehicle, 3, false, false)
                            Config.Notify(Translation[Config.Locale].WAIT_PASSENGERS_LEAVE, "success", 5000)
                            passengersEntering = true
    
                            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                            PointCamAtEntity(cam, CurrentJob.Vehicle, 2.5, 3.5, 1.0, true)
                            SetCamCoord(cam, CurrentJob.Stops[stopId].PassengerWaitCoords.x, CurrentJob.Stops[stopId].PassengerWaitCoords.y, CurrentJob.Stops[stopId].PassengerWaitCoords.z + 1)
                            RenderScriptCams(true, true, 2000, true, true)
                            SetCamActive(cam, true)
                            SetCamFov(cam, 35.0)
                            Wait(1000)
    
                            if goinBack then
                                goinBack = false
                                TriggerServerEvent("aty_busjob:giveSalary", CurrentJob.Salary)
                                Config.Notify(string.format(Translation[Config.Locale].YOU_GOT_SALARY, CurrentJob.Salary), "success", 5000)
                            end
                            
                            for _, passenger in pairs(passengers) do
                                local random = math.random(1, 2)
    
                                if random == 1 then
                                    Functions.TASK_MAKE_RANDOM_PEDS_LEAVE_VEH(passenger.ped, CurrentJob.Vehicle)
                                end
                            end
    
                            Citizen.SetTimeout(1000, function()
                                firstStart = false
                                Config.Notify(Translation[Config.Locale].WAIT_PASSENGERS_ENTER, "success", 5000)
                                for _, passenger in pairs(passengers) do
                                    if not passenger.inVeh then
                                        FreezeEntityPosition(passenger.ped, false)
                                        TaskEnterVehicle(passenger.ped, CurrentJob.Vehicle, 20000, math.random(0, 2), 1.0, 0, 0)
                                        Wait(1000)
                                    end
                                end
                            end)
                        end
                    end
                end
            else
                sleep = 1000
            end
        end
    end
end)

CreateThread(function()
    local sleep = 1000

    while true do
        Wait(sleep)

        if jobStarted and entered then
            sleep = 1
            if (HasEntityBeenDamagedByAnyObject(CurrentJob.Vehicle) or HasEntityBeenDamagedByAnyPed(CurrentJob.Vehicle) or HasEntityBeenDamagedByAnyVehicle(CurrentJob.Vehicle)) and not damaged then
                damaged = true
                TriggerServerEvent("aty_busjob:removeMoney")
                Config.Notify(string.format(Translation[Config.Locale].CRASHED_VEHICLE, Config.CrashFine), "error", 5000)
            end

            if damaged then
                Citizen.SetTimeout(1000, function()
                    damaged = false
                    ClearEntityLastDamageEntity(CurrentJob.Vehicle)
                end)
            end
        else
            sleep = 1000
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)

        if passengersEntering then
            time2 = time2 - 1

            if time2 == 0 then
                for _, passenger in pairs(passengers) do
                    if not passenger.inVeh then
                        passenger.changed = true
                        local seats = GetVehicleModelNumberOfSeats(GetEntityModel(CurrentJob.Vehicle))
                        local seat = Functions.FIND_FREE_SEAT(seats, busySeats)
                        table.insert(busySeats, seat)
                        SetPedIntoVehicle(passenger.ped, CurrentJob.Vehicle, seat)
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    local sleep = 1000

    while true do
        Wait(sleep)

        if passengersEntering then
            sleep = 1

            for _, passenger in pairs(passengers) do
                if not passenger.inVeh then
                    if IsPedInVehicle(passenger.ped, CurrentJob.Vehicle, false) then
                        passenger.inVeh = true
                    end
                else
                    if not passenger.changed then
                        passenger.changed = true
                        local seats = GetVehicleModelNumberOfSeats(GetEntityModel(CurrentJob.Vehicle))
                        local seat = Functions.FIND_FREE_SEAT(seats, busySeats)
                        table.insert(busySeats, seat)
                        SetPedIntoVehicle(passenger.ped, CurrentJob.Vehicle, seat)
                    end

                    if Functions.IS_ALL_PEDS_IN() then
                        DestroyCam(cam, false)
                        RenderScriptCams(false, true, 1, true, true)
                        SetPlayerControl(PlayerId(), true, 0)
                        SetVehicleDoorShut(CurrentJob.Vehicle, 0, 1)
                        SetVehicleDoorShut(CurrentJob.Vehicle, 1, 1)
                        SetVehicleDoorShut(CurrentJob.Vehicle, 2, 1)
                        SetVehicleDoorShut(CurrentJob.Vehicle, 3, 1)
                        passengersEntering = false
                        stopId = stopId + 1
                        TriggerServerEvent("aty_busjob:givePrize", createdPassengers, CurrentJob.Exp, CurrentJob.TicketPrice)
                        Config.Notify(string.format(Translation[Config.Locale].YOU_LET_PASSENGERS_IN, createdPassengers), "success", 5000)
                        time2 = 25
                        Functions.GET_NEXT_STOP(stopId)
                    end
                end
            end
        else
            sleep = 1000
        end
    end
end)

function START_SPAM_TIMER()
    spam = true

    Citizen.SetTimeout(Config.SpamProtectionTime, function()
        spam = false
    end)
end