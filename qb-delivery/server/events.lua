RegisterNetEvent("qb-delivery:Server:HandleCallback", function(key, ...)
    local src = source
    if Koci.Callbacks[key] then
        Koci.Callbacks[key](src, function(...)
            TriggerClientEvent("qb-delivery:Client:HandleCallback", src, key, ...)
        end, ...)
    end
end)

RegisterNetEvent("qb-delivery:Server:UpdatePlayerProfile", function(newProfile)
    local src = source
    Koci.Server.Functions.UpdateProfile(src, newProfile)
end)

RegisterNetEvent("qb-delivery:Server:PlayerDeclinedInvitation", function(inviting)
    local xTarget = Koci.Server.Framework.GetPlayerBySource(inviting)
    if xTarget then
        Koci.Server.SendNotify(inviting, "info", _t("game.delivery.target_declined_your_invitation"))
    end
end)

RegisterNetEvent("qb-delivery:Server:LeaveAllTeams", function()
    local xPlayerSource = source
    local xPlayer = Koci.Server.Framework.GetPlayerBySource(xPlayerSource)
    local fxPlayer = Koci.Server.Functions.GetPlayer(xPlayerSource)
    if fxPlayer then
        local teamMates = Koci.Utils.deepCopy(fxPlayer.PlayerData.TeamMate or {})
        local xPlayerName = Koci.Server.Framework.GetPlayerCharacterName(xPlayer)
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Server.Functions.GetPlayer(mateSource)
            if fxTarget then
                TriggerClientEvent("qb-delivery:Client:PlayerLeaveYourTeam",
                    mateSource,
                    xPlayerSource,
                    xPlayerName
                )
                Koci.Server.Functions.LeavedTeamMate(mateSource, xPlayerSource)
            end
        end
        fxPlayer.PlayerData.TeamMate = {}
    end
end)

RegisterNetEvent("qb-delivery:Server:UpdateCurrentTaskCustomers", function(newDestinations)
    local xPlayerSource = source
    local fxPlayer = Koci.Server.Functions.GetPlayer(xPlayerSource)
    if fxPlayer then
        local teamMates = Koci.Utils.deepCopy(fxPlayer.PlayerData.TeamMate or {})
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Server.Functions.GetPlayer(mateSource)
            if fxTarget then
                TriggerClientEvent(
                    "qb-delivery:Client:UpdateCurrentTaskCustomers",
                    mateSource,
                    newDestinations
                )
            end
        end
    end
end)

RegisterNetEvent("qb-delivery:Server:StartNewTaskDestination", function()
    local xPlayerSource = source
    local fxPlayer = Koci.Server.Functions.GetPlayer(xPlayerSource)
    if fxPlayer then
        if fxPlayer.PlayerData.currentTask.type == "collecting" then
            --[[ First Start]]
            Koci.Server.Functions.StartNewTaskDestination(xPlayerSource)
        end
    end
end)

RegisterNetEvent("qb-delivery:Server:OnCreatedTaskVehicle", function(netId, coords, plate)
    local src = source
    Koci.Server.Functions.OnCreatedTaskVehicle(src, netId, coords, plate)
end)

RegisterNetEvent("qb-delivery:Server:OnCargoPutOnTaskVehicle", function()
    local src = source
    if Koci.Server.Functions.CanLoadCargoInVehicle(src) then
        Koci.Server.Functions.OnCargoPutOnTaskVehicle(src)
    end
end)

RegisterNetEvent("qb-delivery:Server:StopTask", function()
    local src = source
    Koci.Server.Functions.StopTask(src)
end)

RegisterNetEvent("qb-delivery:Server:GetOnDuty", function()
    local src = source
    Koci.Server.Functions.GetOnDuty(src)
end)

RegisterNetEvent("qb-delivery:Server:LeaveDuty", function()
    local src = source
    Koci.Server.Functions.LeaveDuty(src)
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:OnTaskCompleted", function(source, cb)
    local xPlayerSource = source
    Koci.Server.Functions.OnTaskCompleted(xPlayerSource)
    cb(true)
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:PlayerAcceptedInvitation", function(source, cb, inviting)
    local invited = source
    local fxInvited = Koci.Server.Functions.GetPlayer(invited)
    local fxInviting = Koci.Server.Functions.GetPlayer(inviting)
    if fxInvited and fxInviting then
        local invitingData = Koci.Utils.deepCopy(fxInviting.PlayerData)
        local invitedData = Koci.Utils.deepCopy(fxInvited.PlayerData)
        invitingData.TeamMate = nil
        invitedData.TeamMate = nil
        Koci.Server.Functions.AddTeamMate(invited, inviting, {})
        Koci.Server.Functions.AddTeamMate(inviting, invited, {})
        Koci.Server.SendNotify(invited, "info", _t("game.delivery.accepted_team_invitation"))
        TriggerClientEvent("qb-delivery:Client:TargetAcceptedInvitation",
            inviting,
            invited,
            invitedData
        )
        cb(invitingData)
        return
    end
    cb(false)
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:SendInvitationToPlayer", function(source, cb, invited)
    local src = source
    if src == invited then
        cb({
            status = false,
            error = _t("game.delivery.not_invitation_yourself")
        })
        return
    end
    local xPlayer = Koci.Server.Framework.GetPlayerBySource(src)
    local fxPlayer = Koci.Server.Functions.GetPlayer(src)
    local fxTarget = Koci.Server.Functions.GetPlayer(invited)
    if fxTarget and fxPlayer then
        if not fxTarget then
            cb({ status = false, error = _t("game.player_not_found") })
            return
        end
        if not fxTarget.PlayerData.onDuty or fxTarget.PlayerData.onTask then
            cb({ status = false, error = _t("game.player_not_available") })
            return
        end
        if Koci.Server.Functions.GetMateCount(invited) ~= 0 then
            cb({ status = false, error = _t("game.delivery.target_already_in_team") })
            return
        end
        local xPlayerCharacterName = Koci.Server.Framework.GetPlayerCharacterName(xPlayer)
        TriggerClientEvent("qb-delivery:Client:NewInvitationArrived", invited, src, xPlayerCharacterName)
        cb({ status = true })
    else
        cb({ status = false, error = _t("game.player_not_found") })
    end
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:LoadPlayerData", function(source, cb)
    local src = source
    local xPlayer = Koci.Server.Framework.GetPlayerBySource(src)
    local PlayerData = {
        sourceId = src,
        characterName = "unknown",
        profile = "profile_1",
        level = 1,
        exp = 0,
    }
    if xPlayer then
        local identifier = Koci.Server.Framework.GetPlayerIdentity(xPlayer)
        PlayerData.characterName = Koci.Server.Framework.GetPlayerCharacterName(xPlayer)
        local _data = Koci.Server.ExecuteSQLQuery("SELECT * FROM `nchub_delivery_employees` WHERE user = ?",
            { identifier },
            "single"
        )
        if not _data or not next(_data) then
            Koci.Server.ExecuteSQLQuery(
                "INSERT INTO `nchub_delivery_employees` (user, profile, level, exp) VALUES (?, ?, ?, ?)",
                { identifier, "profile_1", 1, 0 },
                "insert"
            )
        else
            PlayerData.profile = _data.profile
            PlayerData.level = _data.level
            PlayerData.exp = _data.exp
        end
        Koci.Server.Functions.NewPlayer(src, identifier, PlayerData)
    end
    cb(PlayerData)
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:StartTaskWithTeamMates", function(source, cb, taskId)
    local src = source
    local task = Koci.Server.Functions.FindTaskById(taskId)
    if not task then
        cb({ error = _t("game.delivery.task_invalid", taskId) })
        return
    end
    CreateThread(function()
        Koci.Server.Functions.StartTaskWithTeamMates(src, taskId)
    end)
    cb({ error = false })
    return
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:PickUpCargoFromCargoLoad", function(source, cb)
    local src = source
    if Koci.Server.Functions.CanLoadCargoInVehicle(src) then
        cb({ error = false })
        return
    else
        cb({ error = _t("game.delivery.cant_take_anymore_cargo") })
        return
    end
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:PickUpCargoFromTaskVehicle", function(source, cb)
    local src = source
    if Koci.Server.Functions.CanCargoPickUpFromVehicle(src) then
        Koci.Server.Functions.OnCargoPickUpFromTaskVehicle(src)
        cb({ error = false })
        return
    else
        cb({ error = _t("game.delivery.cant_take_anymore_cargo") })
        return
    end
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:PickUpCargoFromDestinationPed", function(source, cb)
    local src = source
    if Koci.Server.Functions.CanLoadCargoInVehicle(src) then
        Koci.Server.Functions.OnCargoPickUpFromDestinationPed(src)
        cb({ error = false })
        return
    else
        cb({ error = _t("game.delivery.cant_take_anymore_cargo") })
        return
    end
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:CanLoadCargoInVehicle", function(source, cb)
    local src = source
    if Koci.Server.Functions.CanLoadCargoInVehicle(src) then
        cb({ error = false })
        return
    else
        cb({ error = _t("game.delivery.cant_take_anymore_cargo") })
        return
    end
end)

Koci.Server.RegisterServerCallback("qb-delivery:Server:HandleTaskDestionCompleted", function(source, cb, prop)
    local src = source
    Koci.Server.Functions.OnTaskDestionCompleted(src, prop)
    cb({ error = false })
    return
end)
