

function Interact(Model, Object)
    -- Function Based upon: https://github.com/smallo92/xnVending
    QBCore.Functions.TriggerCallback("vending:canBuyDink", function(canBuy)
        if canBuy then
            local ped = PlayerPedId()
            local position = GetOffsetFromEntityInWorldCoords(Object, 0.0, -0.97, 0.05)
           
            TaskTurnPedToFaceEntity(ped, Object, -1)
            RequestAnimDict(Config.DispenseDict[1])

            while not HasAnimDictLoaded(Config.DispenseDict[1]) do
                Wait(0)
            end

            RequestAmbientAudioBank("VENDING_MACHINE")
            HintAmbientAudioBank("VENDING_MACHINE", 0, -1)

            SetPedCurrentWeaponVisible(ped, false, true, 1, 0)
            RequestModel(Config.VindingModels[Model].obj)
            while not HasModelLoaded(Config.VindingModels[Model].obj) do
                Wait(0)
            end
            SetPedResetFlag(ped, 322, true)
            if not IsEntityAtCoord(ped, position, 0.1, 0.1, 0.1, false, true, 0)  then
                TaskGoStraightToCoord(ped, position, 2.0, 20000, GetEntityHeading(Object), 0.1)
                while not IsEntityAtCoord(ped, position,0.1, 0.1, 0.1, false, true, 0) do
                    TaskGoStraightToCoord(ped, position, 5.0, 20000, GetEntityHeading(Object), 0.2)
                    Wait(1000)
                end
            end
            TriggerServerEvent("vending:buyDrink", Model)
            TaskTurnPedToFaceEntity(ped, Object, -1)
            Wait(500)
            TaskPlayAnim(ped, Config.DispenseDict[1], Config.DispenseDict[2], 4.0, 5.0, -1, true, 1, 0, 0, 0)
            Wait(2500)
            local canModel = CreateObjectNoOffset(Config.VindingModels[Model].obj, position, true, false, false)
            SetEntityAsMissionEntity(canModel, true, true)
            SetEntityProofs(canModel, false, true, false, false, false, false, 0, false)
            AttachEntityToEntity(canModel, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
            Wait(3700)
            TaskPlayAnim(ped, Config.DispenseDict[1], "PLYR_BUY_DRINK_PT2",4.0, 5.0, -1, true, 1, 0, 0, 0)
            Wait(1800)
            if Config.VindingModels[Model].thirst > 0 then 
                TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.VindingModels[Model].thirst)
            elseif Config.VindingModels[Model].hunger > 0 then 
                TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.VindingModels[Model].hunger)
            end
            TaskPlayAnim(ped, Config.DispenseDict[1], "PLYR_BUY_DRINK_PT3",4.0, 5.0, -1, true, 1, 0, 0, 0)
            Wait(600)
            DetachEntity(canModel, true, true)
            ApplyForceToEntity(canModel, 1, vector3(-6.0, -10.0, -2.0), 0, 0, 0, 0, true, true, false, false, true)
            SetEntityAsNoLongerNeeded(canModel)
            Wait(1600)
            ClearPedTasks(ped)
            ReleaseAmbientAudioBank()
            RemoveAnimDict(Config.DispenseDict[1])
            SetModelAsNoLongerNeeded(Config.VindingModels[Model].obj)
        else
            QBCore.Functions.Notify('Cannot Afford Drink!', 'error', 7500)
        end
    end, Model)
end

CreateThread(function()
    for i=1, #(Config.VindingModels) do
        exports['qb-target']:AddTargetModel(Config.VindingModels[i].model, {
            options = {
                {
                    icon = "fa-solid fa-whiskey-glass",
                    label = Config.VindingModels[i].interactionLabel,
                    action = function(entity)
                        Interact(i, entity)
                    end
                },
            },
            distance = 1.0,
        })
    end
end)
