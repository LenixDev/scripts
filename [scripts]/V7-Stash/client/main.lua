local QBCore = exports[Config.core]:GetCoreObject()

AddEventHandler('onResourceRestart', function(resourceName)
    for k, v in pairs(Config.stash) do

    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    DeleteObject(obj)

    exports[Config.target]:RemoveZone("v7:stash:name".. k)

    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    for k, v in pairs(Config.stash) do

    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    DeleteObject(obj)

    exports[Config.target]:RemoveZone("v7:stash:name".. k)

    end
end)

--Citizen.CreateThread(function()
--    if TriggerEvent("stash:v7:warn") == false then
--    for k, v in pairs(Config.stash) do
--        local model = `p_v_43_safe_s`
--
--        RequestModel(model)
--
--        while (not HasModelLoaded(model)) do
--            Wait(1)
--        end
--
--        obj = CreateObject(model, v.coords.x, v.coords.y, v.coords.z, true, false, true)
--
--        PlaceObjectOnGroundProperly(obj)
--
--        SetEntityHeading(obj, v.heading)
--
--        SetEntityAsMissionEntity(obj)
--
--    end
--  end
--end)

function stash(key , data)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", key, {
        maxweight = data.maxweight .. 0 .. 0 .. 1,
        slots = data.slots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", key)
end

Citizen.CreateThread(function()
    if TriggerEvent("stash:v7:warn") == false then
    for k, v in pairs(Config.stash) do
        local label = v.label
        exports[Config.target]:AddBoxZone("v7:stash:name".. k, vector3(v.coords.x, v.coords.y, v.coords.z), 1, 1.0, {
            name = "v7:stash:name".. k,
            heading=0,
            debugPoly = false,
            minZ= v.minz,
            maxZ= v.maxZ
            }, {
                options = {
                    {
                        type = "client",
                        action = function ()
                            local PlayerData = QBCore.Functions.GetPlayerData()

                            if v.job == "none" then

                            if PlayerData.gang.name == v.gang then
                                stash(k, v)
                            else
                                QBCore.Functions.Notify("لايمكنك الوصول الى هذه الخزنة", "error", 5000)
                            end

                            elseif v.gang == "none" then
                            --
                            if PlayerData.job.name == v.job then
                                stash(k, v)
                            else
                                QBCore.Functions.Notify("لايمكنك الوصول الى هذه الخزنة", "error", 5000)
                            end
                            --
                            else
                                if PlayerData.gang.name == v.gang or PlayerData.job.name == v.job then
                                    stash(k, v)
                                else
                                    QBCore.Functions.Notify("لايمكنك الوصول الى هذه الخزنة", "error", 5000)
                                end
                            end
                        end,
                        icon = "fas fa-circle",
                        label = label,
                    },
                },
                distance = v.distance
          })
    end
 end
end)