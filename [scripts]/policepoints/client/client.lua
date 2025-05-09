local QBCore = exports[Config.Core]:GetCoreObject()
local PlayerJob = nil

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local player = QBCore.Functions.GetPlayerData()
        PlayerJob = player.job
    end
end)
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    CreateThread(function()
        while true do
            Wait(10 * 60 * 1000)

            if PlayerJob and PlayerJob.name == 'police' and PlayerJob.onduty then
                TriggerServerEvent('police:addpoints', Config.Points)
            end
        end
    end)
end)

RegisterNetEvent('policepoints:client:openmenu', function(data)
    QBCore.Functions.TriggerCallback('playermanagement:server:getpoliceofficers', function(playerss)
        local options = {}
        for k, v in pairs(playerss) do
            table.insert(options, {
                title = v.firstname .. " " .. v.lastname,
                description = "grade: " .. v.grade .. " \n Points: " .. v.ppoints,
                icon = 'user-circle',
                event = 'policepoints:manageplayers',
                arrow = true,
                args = {
                    fullname = v.firstname .. " " .. v.lastname,
                    id = v.cid,
                    jj = v.job,
                }
            })
        end
        lib.registerContext({
            id = 'police_menuu',
            title = 'Player Points',
            options = options
        })
        lib.showContext('police_menuu')
    end)
end)
RegisterNetEvent('policepoints:manageplayers', function(data)
    lib.registerContext({
        id = 'policemana',
        title = 'Player Points',
        menu = 'police_menuu',
        options = {
            {
                title = 'Give Police points',
                description = "Click here to give " .. data.fullname .. " Police points",
                icon = 'plus',
                onSelect = function()
                    Giveppinput(data.id)
                end,

            },
            {
                title = 'Remove Police points',
                description = "Click here to Remove " .. data.fullname .. " Police points",
                icon = 'minus',
                onSelect = function()
                    REmovepp(data.id)
                end

            },
            {
                title = 'Remove all Police points',
                description = "Click here to remove  " .. data.fullname .. " all Police points",
                icon = 'minus',
                event = 'police:allloppo',
                args = {
                    icd = data.id
                }
            }

        }
    })
    lib.showContext('policemana')
end)
RegisterNetEvent('police:allloppo', function(data)
    TriggerServerEvent('police:rmvallppp', data.icd)
end)
function Giveppinput(data)
    local input = lib.inputDialog('Give Policepoints',
        { { type = 'number', label = 'Points amount ', description = 'Put your amount here', icon = 'plus' } })
    if not input then return end
    TriggerServerEvent('police:giveppoints', data, input[1])
end

function REmovepp(data)
    local input = lib.inputDialog('Remove Policepoints',
        { { type = 'number', label = 'Points amount ', description = 'Put your amount here', icon = 'plus' } })
    if not input then return end
    TriggerServerEvent('police:rmvppoints', data, input[1])
end

