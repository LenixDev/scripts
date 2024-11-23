local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local inChips = false
local currentShop, currentData
local pedSpawned = false
local listen = false
local ShopPed = {}
local NewZones = {}
-- Functions
local function createBlips()
    if pedSpawned then return end

    for store in pairs(Config.Locations) do
        if Config.Locations[store]["showblip"] then
            local StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"]["x"], Config.Locations[store]["coords"]["y"], Config.Locations[store]["coords"]["z"])
            SetBlipSprite(StoreBlip, Config.Locations[store]["blipsprite"])
            SetBlipScale(StoreBlip, Config.Locations[store]["blipscale"])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Locations[store]["blipcolor"])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function tableCheck(val, list)
    for _, v in ipairs(list) do
        if v == val then return true end
    end
    return false
end

local function hasLicense(licenses, playerLicenses)
    for _, license in ipairs(licenses) do
        if playerLicenses[license] then return true end
    end
    return false
end

local function openShop(shop, data)
    local shop = data.products
    
    SendNUIMessage({
        action = "OPEN",
        data = {
            marketName = Config.Products[shop].name,
            marketCategory = Config.Products[shop].category,
            marketItemList = Config.Products[shop].itemList,
            marketCategoryList = Config.Products[shop].categoryList,
            marketJob = Config.Products[shop].job,
            shared = QBCore.Shared.Items,
        }
    })
    SetNuiFocus(true, true)
end

exports("OpenShop", function(data)
    SendNUIMessage({
        action = "OPEN",
        data = {
            marketName = data.name,
            marketCategory = data.category,
            marketItemList = data.itemList,
            marketCategoryList = data.categoryList,
            marketJob = data.job,
            shared = QBCore.Shared.Items,
        }
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent("qb-shops:cl:OpenShop", function(data)
    SendNUIMessage({
        action = "OPEN",
        data = {
            marketName = data.name,
            marketCategory = data.category,
            marketItemList = data.itemList,
            marketCategoryList = data.categoryList,
            marketJob = data.job,
            shared = QBCore.Shared.Items,
        }
    })
    SetNuiFocus(true, true)
end)

local function listenForControl()
    if listen then return end
    CreateThread(function()
        listen = true
        while listen do
            if IsControlJustPressed(0, 38) then -- E
                TriggerServerEvent('qb-shops:server:SetShopList')
                if inChips then
                    exports["qb-core"]:KeyPressed()
                    TriggerServerEvent("qb-shops:server:sellChips")
                else
                    exports["qb-core"]:KeyPressed()
                    openShop(currentShop, currentData)
                end
                listen = false
                break
            end
            Wait(0)
        end
    end)
end

local function createPeds()
    if pedSpawned then return end

    local num = 1
    for k, v in pairs(Config.Locations) do
        local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(ShopPed[k], v["scenario"], 0, true)
        FreezeEntityPosition(ShopPed[k], true)
        SetEntityInvincible(ShopPed[k], true)
        SetBlockingOfNonTemporaryEvents(ShopPed[k], true)

        exports.interact:AddLocalEntityInteraction({
            entity = ShopPed[k],
            id = k, -- needed for removing interactions
            distance = 4.0, -- optional
            interactDst = 2.0, -- optional
            ignoreLos = false, -- optional ignores line of sight
            offset = vec3(0.0, 0.0, 0.0), -- optional
            options = {
                {
                    label = 'Open Shop',
                    action = function()
                        openShop(k, Config.Locations[k])
                    end,
                },
            }
        })

        num += 1
        -- if Config.UseTarget then
        --     exports['qb-target']:AddTargetEntity(ShopPed[k], {
        --         options = {
        --             {
        --                 label = v["targetLabel"],
        --                 icon = v["targetIcon"],
        --                 item = v["item"],
        --                 action = function()
        --                     openShop(k, Config.Locations[k])
        --                 end,
        --                 job = v.requiredJob,
        --                 gang = v.requiredGang
        --             }
        --         },
        --         distance = 2.0
        --     })
        -- end
    end

    if Config.SellCasinoChips.enable then
        local current = type(Config.SellCasinoChips.ped) == 'number' and Config.SellCasinoChips.ped or joaat(Config.SellCasinoChips.ped)

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ShopPed["casino"] = CreatePed(0, current, Config.SellCasinoChips.coords.x, Config.SellCasinoChips.coords.y, Config.SellCasinoChips.coords.z-1, Config.SellCasinoChips.coords.w, false, false)
        FreezeEntityPosition(ShopPed["casino"], true)
        SetEntityInvincible(ShopPed["casino"], true)
        SetBlockingOfNonTemporaryEvents(ShopPed["casino"], true)

        if Config.UseTarget then
            exports['qb-target']:AddTargetEntity(ShopPed["casino"], {
                options = {
                    {
                        label = 'Sell Chips',
                        icon = 'fa-solid fa-coins',
                        action = function()
                            TriggerServerEvent("qb-shops:server:sellChips")
                        end
                    }
                },
                distance = 2.0
            })
        end
    end

    pedSpawned = true
end

local function deletePeds()
    if not pedSpawned then return end

    for _, v in pairs(ShopPed) do
        DeletePed(v)
    end
    pedSpawned = false
end

-- Events
RegisterNetEvent("qb-shops:client:UpdateShop", function(shop, itemData, amount)
    TriggerServerEvent("qb-shops:server:UpdateShopItems", shop, itemData, amount)
end)

RegisterNetEvent("qb-shops:client:SetShopItems", function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent("qb-shops:client:RestockShopItems", function(shop, amount)
    if not Config.Locations[shop].products then return end
    for k in pairs(Config.Locations[shop].products) do
        Config.Locations[shop].products[k].amount = Config.Locations[shop]["products"][k].amount + amount
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    createBlips()
    createPeds()
    TriggerServerEvent('qb-shops:server:SetShopList')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
    PlayerData = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    createBlips()
    createPeds()
    TriggerServerEvent('qb-shops:server:SetShopList')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    deletePeds()
end)

-- Threads
if not Config.UseTarget then
    CreateThread(function()
        for shop in pairs(Config.Locations) do
            NewZones[#NewZones+1] = CircleZone:Create(vector3(Config.Locations[shop]["coords"]["x"], Config.Locations[shop]["coords"]["y"], Config.Locations[shop]["coords"]["z"]), Config.Locations[shop]["radius"], {
                useZ = true,
                debugPoly = false,
                name = shop,
            })
        end

        local combo = ComboZone:Create(NewZones, {name = "RandomZOneName", debugPoly = false})
        combo:onPlayerInOut(function(isPointInside, _, zone)
            if isPointInside then
                currentShop = zone.name
                TriggerServerEvent('qb-shops:server:SetShopList')
                currentData = Config.Locations[zone.name]
                exports["qb-core"]:DrawText(Lang:t("info.open_shop"))
                listenForControl()
            else
                exports["qb-core"]:HideText()
                listen = false
            end
        end)

        local sellChips = CircleZone:Create(vector3(Config.SellCasinoChips.coords["x"], Config.SellCasinoChips.coords["y"], Config.SellCasinoChips.coords["z"]), Config.SellCasinoChips.radius, {useZ = true})
        sellChips:onPlayerInOut(function(isPointInside)
            if isPointInside then
                inChips = true
                exports["qb-core"]:DrawText(Lang:t("info.sell_chips"))
                listenForControl()
            else
                inChips = false
                exports["qb-core"]:HideText()
            end
        end)
    end)
end

CreateThread(function()
    for k1, v in pairs(Config.Locations) do
        if v.requiredJob and next(v.requiredJob) then
            for k in pairs(v.requiredJob) do
                Config.Locations[k1].requiredJob[k] = 0
            end
        end
        if v.requiredGang and next(v.requiredGang) then
            for k in pairs(v.requiredGang) do
                Config.Locations[k1].requiredGang[k] = 0
            end
        end
    end
end)

RegisterNUICallback("close",function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("pay",function(data)
    if next(data.cartArr) == nil then
        QBCore.Functions.Notify("The Shopping Cart empty", "error")
        return
    end
    TriggerServerEvent("qb-shops:sv:pay", data)
end)