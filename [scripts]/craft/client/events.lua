-- @ Start core events
RegisterNetEvent("craft:client:HandleCallback", function(key, data)
    if Koci.Callbacks[key] then
        Koci.Callbacks[key](data)
        Koci.Callbacks[key] = nil
    end
end)
AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        Wait(1000)
        Koci.Client.Craft:Setup()
    end
end)
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        Koci.Client.Craft:Stop()
    end
end)
-- @ End core events -- @
-- @ Start ESX Framework Events @
RegisterNetEvent("esx:playerLoaded", function()
    Wait(1000)
    Koci.Client.Craft:Setup()
end)
RegisterNetEvent("esx:onPlayerLogout", function()
    Wait(1000)
    Koci.Client.Craft:Stop()
end)
-- @ End ESX Framework Events @
-- @ Start QB Framework Events @
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(1000)
    Koci.Client.Craft:Setup()
end)
RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    Wait(1000)
    Koci.Client.Craft:Stop()
end)
-- @ End QB Framework Events @
