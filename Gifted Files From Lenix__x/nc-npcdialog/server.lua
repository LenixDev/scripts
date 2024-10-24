-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded', function(joiner)
    local src = joiner
    TriggerClientEvent('nc:pload:npctalk', src)
end)

RegisterNetEvent('QBCore:Server:PlayerLoaded', function(p)
    local src = p.PlayerData.source
    TriggerClientEvent('nc:pload:npctalk', src)
end)

-----------------------------------------------------------------------------------------
-- CALLBACK'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- THREAD'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- VERSION CHECK --
-----------------------------------------------------------------------------------------

local resource  = GetInvokingResource() or GetCurrentResourceName()
local script    = GetResourceMetadata(resource, 'scriptname', 0)
local version   = GetResourceMetadata(resource, 'version', 0)

SetTimeout(1000, function()
    checkversion()
end)

function checkversion()
    PerformHttpRequest('https://ayazwai.dev/version', function(errorCode, resultData, resultHeaders)
        if resultData ~= nil then
            local data = json.decode(resultData)
            if errorCode == 202 then
                print(data.message)
                if data.havelog then
                    for k, v in pairs(data.changelogs) do
                        print(v)
                    end
                end
            else
                print(data.message)
            end
        else
            print('Could not check the script version...')
        end
    end, 'GET', '', {
        ["x-script"] = script, 
        ["x-version"] = version
    })
end