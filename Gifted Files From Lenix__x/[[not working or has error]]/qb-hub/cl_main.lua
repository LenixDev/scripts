local QBCore = exports['qb-core']:GetCoreObject()
local Enabled = false
local Break = false
local ChatArray = {}

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
                action = "close";
                job = QBCore.Functions.GetPlayerData().job.name;
            })
        end
    end
end)

RegisterNetEvent("qb-phub:client:open", function(type)
    if type == 'toggle' then
        if Enabled then
            Enabled = false
            SendNUIMessage({ 
                action = "close";
                job = QBCore.Functions.GetPlayerData().job.name;
            })
        else
            Enabled = true
            SendNUIMessage({ 
                action = "open"; 
                job = QBCore.Functions.GetPlayerData().job.name;
                duty = QBCore.Functions.GetPlayerData().job.onduty;
                Cid = QBCore.Functions.GetPlayerData().citizenid;
                candelete = QBCore.Functions.GetPlayerData().job.grade.level >= 9;
            })
        end
    elseif type == 'drag' then
        SetNuiFocus(true, true)
        SendNUIMessage({ 
            action = "drag";
            job = QBCore.Functions.GetPlayerData().job.name;
            duty = QBCore.Functions.GetPlayerData().job.onduty;
            Cid = QBCore.Functions.GetPlayerData().citizenid;
            candelete = QBCore.Functions.GetPlayerData().job.grade.level >= 9;
        })
    end
end)

local Job = nil
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Job = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    SendNUIMessage({ 
        action = "close";
        job = QBCore.Functions.GetPlayerData().job.name;
    })
end)


AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Job = QBCore.Functions.GetPlayerData().job
    end
end)
RegisterNetEvent("qb-phub:client:refresh", function(data, PoliceCount, DispatchCid, CommanderCid)
    local sendDispatchCid = nil

    if DispatchCid == nil then
        sendDispatchCid = nil
    else
        sendDispatchCid = DispatchCid
    end

    SendNUIMessage({ 
        action = 'refresh', 
        data = data, 
        title = PoliceCount;
        ComCid = CommanderCid;
        DisCid = sendDispatchCid;
        job = QBCore.Functions.GetPlayerData().job.name;
        duty = QBCore.Functions.GetPlayerData().job.onduty;
        Cid = QBCore.Functions.GetPlayerData().citizenid;
        candelete = QBCore.Functions.GetPlayerData().job.grade.level >= 9;
    })
end)

-- RegisterNUICallback
RegisterNUICallback("Close", function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent("qb-phub:client:refresh", function(data)
end)

RegisterNUICallback("EmptyChat", function(data, cb);
    if (data ~= nil) then
        TriggerServerEvent('momo-phub:EmptyChat',data);
    end
end)

RegisterNUICallback("SendMessage", function(data, cb);
    if (data ~= nil) then
        TriggerServerEvent('momo-phub:SendChat',data);
    end
end)


RegisterNetEvent("momo-phub:UpdateChat", function(data)
    SendNUIMessage({
        action = 'UpdateChat';
        Chat = data;
        job = QBCore.Functions.GetPlayerData().job.name;
    });
end)

RegisterNetEvent("momo-phub:EmptyChat", function(data)
    SendNUIMessage({
        action = 'EmptyChat';
        Chat = data;
        job = QBCore.Functions.GetPlayerData().job.name;
    });
end)


RegisterNUICallback("GetChat", function(data, cb);
    QBCore.Functions.TriggerCallback('momo-phub:GetChat', function(ChatData)
        if (ChatData ~= nil) then
            if (next(ChatData) ~= nil) then
                return cb(ChatData);
            end
        end
        return cb(nil)
    end)
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
    LocalPlayer.state.Breakhub = Break
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
    local HasItem = exports['qb-inventory']:HasItem("radio", 1)
    if HasItem then
        exports['qb-radio']:JoinRadio(tonumber(data.radio))
    else
        QBCore.Functions.Notify("You don't have a radio", "error", 4500)
    end
end)

-- RegisterCommand("plist", function(source, args)

--     if args[1] == "0" then
--         Enabled = false
--         SendNUIMessage({ 
--             action = "close";
--             job = QBCore.Functions.GetPlayerData().job.name;
--         })
--     else
--         TriggerServerEvent("qb-phub:cl:OpenPlist")
--     end

-- end)

RegisterNUICallback('notify', function (data)
    QBCore.Functions.Notify(data.why, "error", 2000)
end)

RegisterNUICallback('GetPlayerGallery', function (data, cb)
    QBCore.Functions.TriggerCallback('momo-phub:GetPlayerGallery', function(Gallery)
        if (Gallery ~= nil) then
            if (next(Gallery) ~= nil) then
                cb(Gallery);
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

RegisterKeyMapping("plist", "Toggle Job list", 'keyboard', "EQUALS")
RegisterCommand('phub', function()
    local Player = QBCore.Functions.GetPlayerData()
    Playerjob = QBCore.Functions.GetPlayerData().job
    if Playerjob.name == "police" then
        Enabled = true
   TriggerServerEvent('qb-phub:server:refresh', Player.job.name)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "drag",
        job = QBCore.Functions.GetPlayerData().job.name,
        duty = QBCore.Functions.GetPlayerData().job.onduty,
    })
end
end, false)
