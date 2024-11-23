RegisterNUICallback("nui:HideFrame", function(data, cb)
    SetNuiFocus(false, false)
    Koci.Client.SendReactMessage("ui:setVisible", false)
    cb(true)
end)

RegisterNUICallback("nui:UpdatePlayerProfile", function(newProfile, cb)
    Koci.Client.Functions.UpdatePlayerProfile(newProfile)
    cb(true)
end)

RegisterNUICallback("nui:InvitePlayerToTeam", function(data, cb)
    local invited = data.targetId
    Koci.Client.Functions.InvitePlayerToTeam(invited)
    cb(true)
end)

RegisterNUICallback("nui:SendNewTaskRequest", function(data, cb)
    SetNuiFocus(false, false)
    Koci.Client.SendReactMessage("ui:setVisible", false)
    Koci.Client.Functions.SendNewTaskRequest(data.id, data.task)
    cb(true)
end)

RegisterNUICallback("nui:LeaveCurrentTeam", function(data, cb)
    Koci.Client.Functions.LeaveCurrentTeam()
    cb(true)
end)

RegisterNUICallback("nui:OpenTowTruckApp", function(data, cb)
    if Koci.Utils.hasResource("0r-towtruck") then
        SetNuiFocus(false, false)
        Koci.Client.SendReactMessage("ui:setVisible", false)
        exports["0r-towtruck"]:OpenApp()
        cb(true)
        return
    end
    cb(false)
end)

exports("OpenApp", function()
    if Koci.Client.Player.onDuty then
        Koci.Client.SendReactMessage("ui:RunDeliveryApp", true)
        Koci.Client.SendReactMessage("ui:setVisible", true)
        SetNuiFocus(true, true)
    else
        Koci.Client.SendNotify(_t("game.commands.tablet.notOnDuty"), "error")
    end
end)
