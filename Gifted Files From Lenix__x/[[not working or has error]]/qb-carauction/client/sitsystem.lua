
local InUse = false
local Anim = 'sit'
local TempPlayerCoords = {}
local PlayerSit = false
local IsTextInUse = false
local currentChair = nil 

local function RunLoop()
    PlayerSit = true
    if not IsTextInUse then 
        exports['qb-ui']:showInteraction('[ F ] Stand up','type')
        IsTextInUse = true
    end
    CreateThread(function()
        while PlayerSit do 
            Wait(5)
            if IsControlJustPressed(0, 23) then
                PlayerSit = false
                InUse = false
                if IsTextInUse then 
                    exports['qb-ui']:hideInteraction()
                    IsTextInUse = false
                end
                if currentChair then 
                    TriggerServerEvent('qb-carauction:Server:LockSynce', currentChair, false)
                    currentChair = nil
                end
                ClearPedTasksImmediately(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityHeading(PlayerPedId(), TempPlayerCoords.oldH)
                SetEntityCoords(PlayerPedId(), TempPlayerCoords.oldX, TempPlayerCoords.oldY, TempPlayerCoords.oldZ)
                TempPlayerCoords = {}
                break
            end
        end
    end)
    Wait(4000)
    if IsTextInUse then 
        exports['qb-ui']:hideInteraction()
        IsTextInUse = false
    end
end

RegisterNetEvent('qb-carauction:client:Chair', function(data)
    if PlayerSit then return end 
    local plyCoords = GetEntityCoords(PlayerPedId())
    Current = data.chair
    currentChair = data.chair
    if not Config.ChairLocations[data.chair].IsBusy then
        if not InUse then
            InUse = true
            TempPlayerCoords = {
                oldX = plyCoords.x,
                oldY = plyCoords.y,
                oldZ = plyCoords.z,
                oldH = GetEntityHeading(PlayerPedId())
            }
            FreezeEntityPosition(PlayerPedId(), true)
            SetEntityHeading(PlayerPedId(), Config.ChairLocations[data.chair].heading)
            SetEntityCoords(PlayerPedId(), Config.ChairLocations[data.chair].coords.x, Config.ChairLocations[data.chair].coords.y, Config.ChairLocations[data.chair].coords.z)
           
            TriggerServerEvent('qb-carauction:Server:LockSynce', data.chair, true)
            TriggerServerEvent('qb-carauction:Server:Enter', data.chair, true)
            RunLoop()
        end  
    end
end)

RegisterNetEvent('qb-carauction:Client:LockSynce', function(Place, bool)
    Config.ChairLocations[Place].IsBusy = bool
end)

RegisterNetEvent('qb-carauction:Client:Animation', function(Current)
    local ped = PlayerPedId()
    TaskStartScenarioAtPosition(ped, Config.Sit.SitAnimation.anim, Config.ChairLocations[Current].coords.x, Config.ChairLocations[Current].coords.y, Config.ChairLocations[Current].coords.z - 0.5, Config.ChairLocations[Current].heading, 0, true, true)
end)

function Animation(dict, anim, ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
end
