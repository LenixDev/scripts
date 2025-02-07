UILoaded = false
PlayerLoaded = false
PlayerData = {}
Invites = {}
InviteId = 0
OldBucket = nil
Positions = {}
HasTrash = false
TrashProp = nil
MopProp = nil
UIOpen = false
Blip = nil
HouseType = "small"
SpawnCoords = nil
Mission = {
    Started = false,
    EnteredHouse = false,
    Blip = nil,
    House = nil,
    Finisihed = false,
}

RegisterNuiCallback('loaded', function()
    UILoaded = true
end)

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
    TriggerServerEvent("aty_housecleaning:leftSquad")
    UIOpen = false
end)

RegisterNuiCallback('getPlayerData', function(_, cb)
    TriggerServerCallback('aty_housecleaning:getPlayerData', function(data)
        PlayerData = data
        data.missions = Config.Missions
        cb(data)
    end)
end)

RegisterNuiCallback('toggleInvite', function(val, _)
    TriggerServerCallback('aty_housecleaning:toggleInvite', function(cb)
        if cb then
            PlayerData.invites = val
        end
    end, val)
end)

RegisterNuiCallback('sendInvite', function(id, cbb)
    local id = tonumber(id)
    TriggerServerCallback('aty_housecleaning:sendInvite', function(cb)
        cbb(cb)
        if cb then
            Config.Notify(Translates["sent_invite"], "success", 3500)
        else
            Config.Notify(Translates["error_invite"], "error", 3500)
        end
    end, id)
end)

RegisterNuiCallback('startMission', function(data, cb)
    local id = tonumber(data.id) + 1
    local mission = Config.Missions[id]
    HouseType = mission.HouseType
    SpawnCoords = Config.HouseTypes[HouseType].SpawnAt

    if data.members < (mission.MinMembers - 1) then
        Config.Notify(string.format(Translates["minimum_member"], mission.MinMembers), "error", 3500)
        cb(false)
    else
        TriggerServerCallback("aty_housecleaning:startMission", function(cbb)
            if cbb then
                SetNuiFocus(false, false)
                Mission.data = mission
                StartJob()
            end
           
            cb(cbb)
        end, mission)
    end
end)

RegisterNuiCallback('kickPlayer', function(license)
    TriggerServerEvent("aty_housecleaning:kick", license)
end)

RegisterNuiCallback('changeImage', function(image, cb)
    cb("ok")
    TriggerServerEvent("aty_housecleaning:changeImage", image)
    TriggerServerCallback("aty_housecleaning:createSquad", function (cb)
        if cb then
            UIOpen = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "openMenu",
                squad = cb,
                isLeader = true,
            })
        else
            Config.Notify(Translates["error_creating_squad"], "error", 3500)
        end
    end)
end)

RegisterNetEvent("aty_housecleaning:closeMenu", function()
    SetNuiFocus(false, false)
    UIOpen = false
    SendNUIMessage({
        action = "closeMenu",
    })
end)

RegisterNetEvent("aty_housecleaning:startMission", function (mission, positions)
    SetNuiFocus(false, false)
    UIOpen = false
    SendNUIMessage({
        action = "closeMenu",
    })
    Mission.data = mission
    Mission.Started = true
    Mission.EnteredHouse = false
    Positions = positions
    Config.Notify(Translates["mission_started"], "success", 3500)
    SetNewWaypoint(mission.HouseEntrance.x, mission.HouseEntrance.y)
    CreateMissionBlip()
    StartJob()
end)

RegisterNetEvent("aty_housecleaning:receiveInvite", function (inviteId)
    for _, invite in pairs(Invites) do
        if invite.id == inviteId then
            return
        end
    end

    InviteId = InviteId + 1
    
    table.insert(Invites, {
        license = inviteId,
        id = InviteId,
        time = 60,
    })

    Config.Notify(string.format(Translates["received_invite"], InviteId), "success", 3500)
end)

RegisterNetEvent("aty_housecleaning:refreshSquad", function (squad, isLeader)
    SendNUIMessage({
        action = "refreshSquads",
        squad = squad,
        isLeader = isLeader,
    })
end)

RegisterNetEvent("aty_housecleaning:deleteSquad", function ()
    if Mission.EnteredHouse then
        Mission.EnteredHouse = false
        DoScreenFadeOut(500)
        Wait(1000)
        SetEntityCoords(ped, Mission.data.HouseEntrance.x, Mission.data.HouseEntrance.y, Mission.data.HouseEntrance.z)
        DeleteEntity(Mission.House)
        Wait(1000)
        DoScreenFadeIn(500)
    end

    RemoveBlip(Mission.Blip)
    
    Mission = {
        Started = false,
        EnteredHouse = false,
        Blip = nil,
        House = nil
    }

    SetNuiFocus(false, false)
    UIOpen = false
    SendNUIMessage({
        action = "closeMenu",
    })
end)

RegisterNetEvent("aty_housecleaning:fetchPositions", function(pos)
    for a, position in pairs(Positions) do
        if pos == position.coords then
            table.remove(Positions, a)

            DeleteEntity(position.prop)

            if #Positions == 0 then
                Mission.Finisihed = true
                Config.Notify(Translates["cleared_house"], "success", 3500)
            end

            break
        end
    end
end)

CreateThread(function()
    local sleep = 1000
    CreatePedOnCoord(Config.Ped.Model, Config.Ped.Position.x, Config.Ped.Position.y, Config.Ped.Position.z, Config.Ped.Heading)
    CreateNPCBlip()

    while true do
        Wait(sleep)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dist = #(coords - Config.Ped.Position)

        if not UIOpen and not Mission.Started then
            if dist < 1.5 then
                sleep = 0
    
                DrawText(Translates["start_mission"])
    
                if IsControlJustPressed(0, 38) then
                    TriggerServerCallback("aty_housecleaning:createSquad", function (cb)
                        if cb then
                            UIOpen = true
                            SetNuiFocus(true, true)
                            SendNUIMessage({
                                action = "openMenu",
                                squad = cb,
                                isLeader = true,
                            })
                        else
                            Config.Notify(Translates["error_creating_squad"], "error", 3500)
                        end
                    end)
                end
            else
                sleep = 1000
            end
        end
    end
end)

CreateThread(function ()
    DoScreenFadeIn(100)

    while true do
        Wait(1000)

        for _, invite in pairs(Invites) do
            if invite.time > 0 then
                invite.time = invite.time - 1

                if invite.time == 0 then
                    table.remove(Invites, _)
                end
            else
                table.remove(Invites, _)
            end
        end
    end
end)

CreateThread(function ()
    local sleep = 1000

    while true do
        Wait(sleep)

        if Mission.Started then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local dist = #(coords - Mission.data.HouseEntrance)

            if dist < 30.0 and not Mission.EnteredHouse then
                sleep = 0

                DrawMarker(2, Mission.data.HouseEntrance.x, Mission.data.HouseEntrance.y, Mission.data.HouseEntrance.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)

                if dist < 1.0 then
                    DrawText(Translates["enter_house"])
                    if IsControlJustPressed(0, 38) then
                        EnterHouse()
                    end
                end
            else
                sleep = 1000
            end
        end
    end
end)

CreateThread(function ()
    local sleep = 1000

    while true do
        Wait(sleep)

        if Mission.Started and Mission.EnteredHouse then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local dist = #(coords - vector3(SpawnCoords.x, SpawnCoords.y, SpawnCoords.z))

            if dist < 10.0 then
                sleep = 0

                DrawMarker(2, SpawnCoords.x, SpawnCoords.y, SpawnCoords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)

                if dist < 1.0 then
                    if HasTrash then
                        DrawText(Translates["throw_trash"])
                        if IsControlJustPressed(0, 38) then
                            Config.Notify(Translates["threw_out_trash"], "success", 3500)
                            HasTrash = false
                            DeleteEntity(TrashProp)
                            TrashProp = nil
                            ClearPedTasks(ped)
                        end
                    else
                        DrawText(Translates["leave_house"])
                        if IsControlJustPressed(0, 38) then
                            DoScreenFadeOut(500)
                            Wait(1000)
                            SetEntityCoords(ped, Mission.data.HouseEntrance.x, Mission.data.HouseEntrance.y, Mission.data.HouseEntrance.z)
                            DeleteEntity(Mission.House)
                            Wait(1000)
                            Mission.EnteredHouse = false
                            TriggerServerEvent("aty_housecleaning:leaveHouse")
                            DoScreenFadeIn(500)
                        end
                    end
                end
            else
                sleep = 1000
            end
        end
    end
end)

CreateThread(function ()
    local sleep = 1000

    while true do
        Wait(sleep)

        if Mission.Started and Mission.EnteredHouse and not HasTrash then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local closestPosition = GetClosestCleaningPosition(coords)

            if closestPosition then
                local dist = #(coords - closestPosition?.coords)
                sleep = 0

                for _, position in pairs(Positions) do
                    DrawMarker(2, position.coords.x, position.coords.y, position.coords.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                end

                if dist < 1.0 then
                    if closestPosition.type == "trash" then
                        DrawText(Translates["pickup_trash"])
                    elseif closestPosition.type == "mop" then
                        DrawText(Translates["mop_floor"])
                    else
                        DrawText(Translates["wipe"])
                    end

                    if IsControlJustPressed(0, 38) then
                        PlayCleaningAnim(closestPosition.type)
                        TriggerServerEvent("aty_housecleaning:fetchPositions", closestPosition.coords)
                    end
                end
            end
        else
            sleep = 1000
        end
    end
end)

CreateThread(function ()
    local sleep = 1000

    while true do
        Wait(sleep)

        if Mission.Started and not Mission.EnteredHouse and Mission.Finisihed then
            sleep = 0
            FinishMission()
        else
            sleep = 1000
        end
    end
end)

-- RegisterCommand("opencleaning", function ()
--     TriggerServerCallback("aty_housecleaning:createSquad", function (cb)
--         if cb then
--             SetNuiFocus(true, true)
--             SendNUIMessage({
--                 action = "openMenu",
--                 squad = cb,
--                 isLeader = true,
--             })
--         else
--             Config.Notify("An error occured while creating the squad", "error", 3500)
--         end
--     end)
-- end, false)

RegisterCommand("acceptinvite", function (src, args)
    local id = tonumber(args[1])

    if not id then
        Config.Notify(Translates["specify_id"], "error", 3500)
        return
    else
        for _, invite in pairs(Invites) do
            if invite.id == id then
                table.remove(Invites, _)
                TriggerServerCallback("aty_housecleaning:acceptInvite", function (cb)
                    if cb then
                        UIOpen = true
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            action = "openMenu",
                            squad = cb,
                            isLeader = false,
                        })
                    else
                        Config.Notify(Translates["error_accepting"], "error", 3500)
                    end
                end, invite.license)
                return
            end
        end

        Config.Notify(Translates["specify_id"], "error", 3500)
    end
end, false)

RegisterCommand("myinvites", function ()
    if not UILoaded then
        return
    end

    local text = ""

    for _, invite in pairs(Invites) do
        text = text .. "Invite id: "..invite.id.."\n"
    end

    if text == "" then
        text = Translates["no_invites"]
    end

    Config.Notify(text, "success", 3500)
end, false)

AddEventHandler("onResourceStop", function (resource)
    if resource == GetCurrentResourceName() then
        SetNuiFocus(false, false)
        DeleteEntity(Mission.House)
        RemoveBlip(Mission.Blip)

        for _, position in pairs(Positions) do
            DeleteEntity(position.prop)
        end
    end
end)
