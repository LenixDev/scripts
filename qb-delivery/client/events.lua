--[[ Core Events ]]

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        Wait(1000)
        Koci.Client.StartCore()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        Koci.Client.StopCore()
    end
end)

--[[ ESX Events ]]
if Config.FrameWork == "esx" then
    RegisterNetEvent("esx:playerLoaded", function(xPlayer)
        Wait(1000)
        Koci.Client.StartCore()
    end)
    RegisterNetEvent("esx:onPlayerLogout", function(xPlayer)
        Koci.Client.StopCore()
    end)
    RegisterNetEvent("esx:setJob", function(newJob)
        Koci.Client.Functions.CheckJob(newJob.name)
    end)
end

--[[ QB Events ]]
if Config.FrameWork == "qb" then
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        Wait(1000)
        Koci.Client.StartCore()
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
        Koci.Client.StopCore()
    end)

    RegisterNetEvent("QBCore:Client:OnJobUpdate", function()
        local xPlayer = Koci.Client.GetPlayerData()
        Koci.Client.Functions.CheckJob(xPlayer.job.name)
    end)
end

--[[ Custom Events ]]

RegisterNetEvent("qb-delivery:Client:HandleCallback", function(key, ...)
    if Koci.Callbacks[key] then
        Koci.Callbacks[key](...)
        Koci.Callbacks[key] = nil
    end
end)

RegisterNetEvent("qb-delivery:Client:ToggleDeliveryJobDuty", function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local point = nil
    for key, value in pairs(Config.JobOptions.startPoints) do
        if value.active then
            local coords = value.employerPed.spawnCoords
            local distance = #(playerCoords - vec3(coords.x, coords.y, coords.z))
            if distance < 5.0 then
                point = value
                break
            end
        end
    end
    if point then
        Koci.Client.Functions.ToggleDeliveryJobDuty(point)
    end
end)

RegisterNetEvent("qb-delivery:Client:OpenTablet", function()
    if Koci.Client.Player.onDuty then
        Koci.Client.SendReactMessage("ui:setVisible", true)
        SetNuiFocus(true, true)
    else
        Koci.Client.SendNotify(_t("game.commands.tablet.notOnDuty"), "error")
    end
end)

RegisterNetEvent("qb-delivery:Client:NewInvitationArrived", function(invitingSource, invitingName)
    Koci.Client.Functions.HandleNewInvitation(invitingSource, invitingName)
end)

RegisterNetEvent("qb-delivery:Client:AcceptInvitation", function()
    if Koci.Client.currentTeamInvitation.invitingId then
        if Koci.Client.Functions.GetMateCount() ~= 0 then
            Koci.Client.SendNotify(_t("game.delivery.already_in_team"), "error")
            return
        end
        Koci.Client.Functions.AcceptLastInvitation()
    else
        Koci.Client.SendNotify(_t("game.delivery.no_team_invitation"), "error")
    end
end)

RegisterNetEvent("qb-delivery:Client:DenyInvitation", function()
    if Koci.Client.Functions.currentTeamInvitation.invitingId then
        Koci.Client.Functions.DenyLastInvitation()
    else
        Koci.Client.SendNotify(_t("game.delivery.no_team_invitation"), "error")
    end
end)

RegisterNetEvent("qb-delivery:Client:BlockInvitations", function()
    Koci.Client.Functions.BlockInvitations()
end)

RegisterNetEvent("qb-delivery:Client:TargetAcceptedInvitation", function(invited, invitedData)
    invitedData.nextLeveLExp = Koci.Client.Functions.GetPlayerNextLevelExp(invitedData.level)
    Koci.Client.Functions.AddTeamMate(invited, invitedData)
    Koci.Client.SendNotify(_t("game.delivery.target_accepted_your_invitation"), "info")
    Koci.Client.SendReactMessage("ui:LoadTeamMateData", {
        id = invited,
        data = invitedData
    })
end)

RegisterNetEvent("qb-delivery:Client:PlayerLeaveYourTeam", function(leavingSourceId, leavingName)
    Koci.Client.Functions.LeavedTeamMate(leavingSourceId)
    Koci.Client.SendReactMessage("ui:LoadTeamMateData", { left = true })
    Koci.Client.SendNotify(_t("game.delivery.playerLeavedTeam", leavingName), "info")
end)

RegisterNetEvent("qb-delivery:Client:LeaveCurrentTeam", function()
    if Koci.Client.Functions.GetMateCount() == 0 then
        Koci.Client.SendNotify(_t("game.delivery.already_not_in_team"), "error")
        return
    end
    Koci.Client.Functions.LeaveCurrentTeam()
end)

RegisterNetEvent("qb-delivery:Client:StartTask", function(taskId, isLeader)
    if Koci.Client.Player.onTask then return end
    Koci.Client.Functions.StartNewTask(taskId, isLeader)
end)

RegisterNetEvent("qb-delivery:Client:OnTaskVehicleCreated", function(netId, plate, coords)
    Koci.Client.Functions.OnTaskVehicleCreated(netId, plate, coords)
end)

RegisterNetEvent("qb-delivery:Client:UpdateCurrentTaskCustomers", function(newDestinations)
    Koci.Client.Functions.SendTaskCustomers(newDestinations)
end)

RegisterNetEvent("qb-delivery:Client:OnCargoPickUpFromTaskVehicle", function(playerSource)
    Koci.Client.Functions.OnCargoPickUpFromTaskVehicle(playerSource)
end)

RegisterNetEvent("qb-delivery:Client:OnCargoPutOnTaskVehicle", function(playerSource)
    Koci.Client.Functions.OnCargoPutOnTaskVehicle(playerSource)
end)

RegisterNetEvent("qb-delivery:Client:StartNewTaskDestination", function(newDestination, model)
    Koci.Client.Functions.StartTaskDestination(newDestination, model)
end)

RegisterNetEvent("qb-delivery:Client:OnTaskDestionCompleted", function(prop)
    Koci.Client.Functions.OnTaskDestionCompleted(prop)
end)

RegisterNetEvent("qb-delivery:Client:HandOverTaskVehicle", function()
    Koci.Client.Functions.Thread_HandOverTaskVehicle()
end)

RegisterNetEvent("qb-delivery:Client:OnTaskCompleted", function(newLevel, newExp)
    Koci.Client.Functions.OnTaskCompleted(newLevel, newExp)
end)

RegisterNetEvent("qb-delivery:Client:OnCargoPickUpFromDestinationPed", function()
    Koci.Client.Functions.OnCargoPickUpFromDestinationPed()
end)