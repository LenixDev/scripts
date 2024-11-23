local QBCore = exports['qb-core']:GetCoreObject()
local Enabled = false
local Break = false

-- Create Thread
-- CreateThread(function()
--     while true do
--         Wait(0)
--         TriggerServerEvent("qb-phub:client:refresh")
--         Wait(8500)
--     end
-- end)

-- Events

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
    if Enabled then
        local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name ~= "police" or Player.job.name ~= "ambulance" then
            SendNUIMessage({ 
                action = "close" 
            })
        end
    end
end)

RegisterNetEvent("qb-phub:client:open", function(type)
    if type == 'toggle' then
        if Enabled then
            Enabled = false
            SendNUIMessage({ 
                action = "close"
            })
        else
            Enabled = true
            SendNUIMessage({ 
                action = "open"; 
                job = QBCore.Functions.GetPlayerData().job.name;
                duty = QBCore.Functions.GetPlayerData().job.onduty;

            })
        end
    elseif type == 'drag' then
        SetNuiFocus(true, true)
        SendNUIMessage({ 
            action = "drag";
            job = QBCore.Functions.GetPlayerData().job.name;
            duty = QBCore.Functions.GetPlayerData().job.onduty;
        })
    end
end)

local Job = nil
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Job = QBCore.Functions.GetPlayerData().job
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Job = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent("qb-phub:client:refresh", function(data, title)
    SendNUIMessage({ 
        action = 'refresh', 
        data = data, 
        title = title;
        job = QBCore.Functions.GetPlayerData().job.name;
        duty = QBCore.Functions.GetPlayerData().job.onduty;
    })
end)

-- RegisterNUICallback
RegisterNUICallback("Close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("onduty", function()
    local Player = QBCore.Functions.GetPlayerData()
    local PlayerJob = Player.job

    if PlayerJob.name == "police" then
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("police:server:UpdateCurrentCops")
        TriggerServerEvent("police:server:UpdateBlips")
        TriggerServerEvent("shx-bodycam/server/openBodycam", not PlayerJob.onduty)
        TriggerServerEvent("qb-phub:sv:refresh", "police")
    else
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("qb-phub:sv:refresh", "ambulance")
    end
end)

RegisterNUICallback("break", function()
    Break = not Break
    TriggerServerEvent("qb-phub:client:break", Break)
end)

RegisterNUICallback("dispatch", function()
    TriggerServerEvent("qb-phub:client:dispatch")
end)

RegisterNUICallback("commander", function()
    TriggerServerEvent("qb-phub:client:commander")
end)

RegisterNUICallback("changecallsign", function(data)
    TriggerServerEvent("qb-phub:cl:changecallsign", data.callsign)
end)

RegisterNUICallback("jointhisbitchradio", function(data)

    if not exports['qb-inventory']:HasItem("radio", 1) then
        QBCore.Functions.Notify("You don't have a radio", "error")
        return
    end

    if LocalPlayer.state.RadioChanel == data.radio then
        QBCore.Functions.Notify("You are on the same Chanel", "error")
        return
    end

    exports['qb-radio']:JoinRadio(tonumber(data.radio))

    QBCore.Functions.Notify('Connected to ' .. data.radio .. ' MHz', 'success')
end)

RegisterCommand("plist", function(source, args)

    if args[1] == "0" then
        Enabled = false
        SendNUIMessage({ 
            action = "close"
        })
    else
        TriggerServerEvent("qb-phub:cl:OpenPlist")
    end

end)

RegisterKeyMapping("plist", "Toggle Job list", 'keyboard', "EQUALS")