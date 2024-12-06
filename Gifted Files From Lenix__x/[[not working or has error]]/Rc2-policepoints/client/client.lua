local QBCore = exports[Rc2store.Core]:GetCoreObject()

CreateThread(function()
    while true do
        if QBCore.Functions.GetPlayerData().job and QBCore.Functions.GetPlayerData().job.name then
            if QBCore.Functions.GetPlayerData().job.name == 'police' then
                TriggerServerEvent('Rc2-police:addpoints', Rc2store.Points)
 
            end
        end
        Wait(Rc2store.Minutes * 60 * 1000)
    end
end)

RegisterNetEvent('Rc2-policepoints:client:openmenu', function(data)
    QBCore.Functions.TriggerCallback('Rc2-playermanagement:server:getpoliceofficers', function(playerss)
        local options = {}
        for k, v in pairs(playerss) do
            table.insert(options, {
                title = v.firstname .. " " .. v.lastname,
                description = "grade: " .. v.grade .. " \n Points: " .. v.ppoints,
                icon = 'user-circle',
                event = 'Rc2-policepoints:manageplayers',
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

RegisterNetEvent('Rc2-policepoints:manageplayers', function(data)
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
                event = 'Rc2-police:allloppo',
                args = {
                    icd = data.id
                }
            }

        }
    })
    lib.showContext('policemana')
end)
RegisterNetEvent('Rc2-police:allloppo', function(data)
    TriggerServerEvent('Rc2-police:rmvallppp', data.icd)
end)
function Giveppinput(data)
    local input = lib.inputDialog('Give Policepoints',
        { { type = 'number', label = 'Points amount ', description = 'Put your amount here', icon = 'plus' } })
    if not input then return end
    TriggerServerEvent('Rc2-police:giveppoints', data, input[1])
end

function REmovepp(data)
    local input = lib.inputDialog('Remove Policepoints',
        { { type = 'number', label = 'Points amount ', description = 'Put your amount here', icon = 'plus' } })
    if not input then return end
    TriggerServerEvent('Rc2-police:rmvppoints', data, input[1])
end
