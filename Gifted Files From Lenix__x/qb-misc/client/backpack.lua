local isopeningBack = false


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
end)

local function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function SetBackPackID()
    for k, v in pairs(Config.BackPack.Shop.items) do
        v.info.id = 'Backpack_'.. tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4) .. QBCore.Shared.RandomInt(3))
    end
    return true
end

RegisterNetEvent('qb-backpack:client:openshop', function()
    if SetBackPackID() then 
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "backpack", Config.BackPack.Shop)
    end
end)

RegisterNetEvent('qb-backpack:client:openbackpack', function(ID, Maxweight, Slots)
    if isopeningBack then return end 
    if not ID then return end 
    if not Maxweight then return end 
    if not Slots then return end 
    isopeningBack = true 
    LoadAnim(Config.BackPack.animations.backpack.dict)
    ClearPedTasks(PlayerPedId())
    TaskPlayAnim(PlayerPedId(), Config.BackPack.animations.backpack.dict, Config.BackPack.animations.backpack.anim, 2.0, 2.0, -1, 51, 0, false, false, false)
    RemoveAnimDict(Config.BackPack.animations.backpack.dict)
    Wait(50)
    QBCore.Functions.Progressbar("backpackopen", "Opening Back Pack... ", 8000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent("inventory:server:OpenInventory", "stash", ID, {
            maxweight = Maxweight,
            slots = Slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", ID)
        isopeningBack = false
    end, function()
        isopeningBack = false
        QBCore.Functions.Notify("Canceled", "error", 4000)
    end)
end)

CreateThread(function()
    local TripsShop = AddBlipForCoord(vec3(-1222.0130615234,-1436.2443847656,4.3738884925842))
    SetBlipSprite(TripsShop, 765)
    SetBlipDisplay(TripsShop, 4)
    SetBlipScale(TripsShop, 0.5)
    SetBlipAsShortRange(TripsShop, true)
    SetBlipColour(TripsShop, 4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName('Trips Shop')
    EndTextCommandSetBlipName(TripsShop)
end)