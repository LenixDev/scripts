-----------------------
----   Variables   ----
-----------------------
QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local CustomsData = {}

-- Receipt system 
getVehiclePropertiesReceipt = {}

hasCustomColour = false 
customPrimaryColour = {}
customSecondaryColour = {}

receiptChange = false 


local isPlyInBennys = false
local originalCategory = nil
local originalMod = nil
local originalPrimaryColour = nil
local originalSecondaryColour = nil
local originalPearlescentColour = nil
local originalWheelColour = nil
local originalDashColour = nil
local originalInterColour = nil
local originalWindowTint = nil
local originalWheelCategory = nil
local originalWheel = nil
local originalWheelType = nil
local originalCustomWheels = nil
local originalNeonLightState = nil
local originalNeonLightSide = nil
local originalNeonColourR = nil
local originalNeonColourG = nil
local originalNeonColourB = nil
local originalXenonColour = nil
local originalOldLivery = nil
local originalPlateIndex = nil
local attemptingPurchase = false
local isPurchaseSuccessful = false
local radialMenuItemId = nil

-----------------------
----   Functions   ----
-----------------------

--#[Local Functions]#--
local function saveVehicle()
    local plyPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(plyPed, false)
    local myCar = QBCore.Functions.GetVehicleProperties(veh)
    TriggerServerEvent('customs:server:updateVehicle', myCar)
end
-- RECEIPTS SYSTEM by d3MBA#0001  

-- If you need any help join discord server and open a ticket with your TRANSACTION ID! 😃
-- Discord server: discord.gg/d3MBA

local d3VehiclesMods = { neonColor = {}, wheelSmokeColor = {}, tyreSmokeColor = {}, pearlescentColour ={}, windowTint = {}, xenonColor = {}, vehicleCosmetics = {}, wheelName = {}, wheelColor = {}, dashboardColor ={}, primaryColor = {}, secondaryColor = {}, interiorColor ={}}
function vehicleReceipt()
    local myCar = QBCore.Functions.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
    local neonColorR, neonColorG, neonColorB  = GetCurrentNeonColour()
    local wheelSmokeColorR, wheelSmokeColorG, wheelSmokeColorB = GetCurrentVehicleWheelSmokeColour(GetVehiclePedIsIn(PlayerPedId(), false))
    local tyreSmokeR, tyreSmokeG, tyreSmokeB = GetVehicleTyreSmokeColor(GetVehiclePedIsIn(PlayerPedId(), false))
    local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false))
    local xenonColor = GetCurrentXenonColour()
    local windowTintColor = GetCurrentWindowTint()
    local dashboardColor = GetVehicleDashboardColour(GetVehiclePedIsIn(PlayerPedId(), false))
    table.insert(d3VehiclesMods.primaryColor, kurceviteBoje[myCar["color1"]])
    table.insert(d3VehiclesMods.interiorColor, kurceviteBoje[myCar["interiorColor"]])
    table.insert(d3VehiclesMods.secondaryColor, kurceviteBoje[myCar["color2"]])
    table.insert(d3VehiclesMods.pearlescentColour, kurceviteBoje[vehPearlescentColour])
    table.insert(d3VehiclesMods.dashboardColor, kurceviteBoje[dashboardColor])
    table.insert(d3VehiclesMods.wheelColor, kurceviteBoje[vehWheelColour])

    local wheelName = GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), false), 23, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 23)))
    if wheelName ~= "NULL" then 
        -- print("Wheel Name: " ..wheelName) -- wheel name 
        table.insert(d3VehiclesMods.wheelName, wheelName)
    else 
        table.insert(d3VehiclesMods.wheelName, "None")
    end 


    for k, v in pairs(vehicleCustomisation) do -- GET ALL VEHICLES MODS 
        local mod, modName = GetCurrentMod(v.id) 
        if mod ~= -1 and modName ~= "NULL" then 
            -- vehCosmetics = modName
            table.insert(d3VehiclesMods.vehicleCosmetics, modName)
        end 
    end

    if neonColorR == 255 and neonColorG == 0 and neonColorB == 255 then table.insert(d3VehiclesMods.neonColor, "None") end 
    for _, v in pairs(vehicleNeonOptions.neonColours) do 
        if v.r == neonColorR and v.g == neonColorG and v.b == neonColorB then 
            -- print("Neon Color: " ..v.name) -- Neon color 
            table.insert(d3VehiclesMods.neonColor, v.name)
        end 
    end
    
    for _, v in pairs(vehicleXenonOptions.xenonColours) do 
        if xenonColor == v.id then 
            -- print("Xenon Color: " ..v.name) -- Xenon color 
            table.insert(d3VehiclesMods.xenonColor, v.name)
        end 
    end
    
    
    for _, v in pairs(vehicleTyreSmokeOptions) do 
        if v.r == wheelSmokeColorR and v.g == wheelSmokeColorG and v.b == wheelSmokeColorB then
            -- print("Wheel smoke Color: " ..v.name) -- Wheel Smoke color 
            table.insert(d3VehiclesMods.wheelSmokeColor, v.name)
        end 
    end

    for _, v in pairs(vehicleTyreSmokeOptions) do 
        if v.r == tyreSmokeR and v.g == tyreSmokeG and v.b == tyreSmoke then
            -- print("Tyre smoke Color: " ..v.name) -- Tyre Smoke color 
            table.insert(d3VehiclesMods.tyreSmokeColor, v.name)
        end 
    end

    if windowTintColor <= 0 then  
        table.insert(d3VehiclesMods.windowTint, "None")
    else
        for _, v in pairs(vehicleWindowTintOptions) do 
            if windowTintColor == v.id then 
                -- print("Window tint Color: " ..v.name) -- Window Tint color 
                table.insert(d3VehiclesMods.windowTint, v.name)
            end 
        end 
    end 

    TriggerServerEvent("d3:customs:server:getReceiptData", d3VehiclesMods)
    Wait(500)
    -- Reset variable
    d3VehiclesMods = { neonColor = {}, wheelSmokeColor = {}, tyreSmokeColor = {}, pearlescentColour ={}, windowTint = {}, xenonColor = {}, vehicleCosmetics = {}, wheelName = {}, wheelColor = {}, dashboardColor ={}, primaryColor = {}, secondaryColor = {}, interiorColor ={}, }
    -- RESET CUSTOM COLOURS 
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    if hasCustomColour == true then 
        SetVehicleCustomPrimaryColour(plyVeh, customPrimaryColourR, customPrimaryColourG, customPrimaryColourB) 
        SetVehicleCustomSecondaryColour(plyVeh, customSecondaryColourR, customSecondaryColourG, customSecondaryColourB)
    end 
    Wait(100)

    -- Reset all vehicle modifications 
    SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false), getVehiclePropertiesReceipt)
    Wait(200)
    -- Reset variable
    getVehiclePropertiesReceipt = {}
end


kurceviteBoje = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Pure Gold",
    [159] = "Brushed Gold",
    [160] = "Unknown",
}

local function CreateBlip(blipData)
    local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
    SetBlipSprite(blip, blipData.sprite)
    SetBlipDisplay(blip, blipData.display)
    SetBlipScale(blip, blipData.scale)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, blipData.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(blipData.label)
    EndTextCommandSetBlipName(blip)
end

local function AllowJob(restrictionData, job)
    if type(restrictionData.job) == "table" then
        for _,restrictedJob in ipairs(restrictionData.job) do
            if restrictedJob == job then return true end
        end
    else
        if restrictionData.job == "any" or restrictionData.job == job or not restrictionData.job then return true end
    end
    if Config.Debug then print('Denied for not having allowed job. ('..job..')') end
    return false
end

local function AllowGang(restrictionData, gang)
    if type(restrictionData.gang) == "table" then
        for _,restrictedGang in ipairs(restrictionData.gang) do
            if restrictedGang == gang then return true end
        end
    else
        if restrictionData.gang == "any" or restrictionData.gang == gang or not restrictionData.gang then return true end
    end
    if Config.Debug then print('Denied for not having allowed gang. ('..gang..')') end
    return false
end

local function AllowVehicleClass(restrictionData, vehicle)
    local vehicleClass = GetVehicleClass(vehicle)

    if restrictionData.deniedClasses then
        for _,class in ipairs(restrictionData.deniedClasses) do
            if vehicleClass == class then
                if Config.Debug then print('Denied for having denied vehicle class. ('..vehicleClass..')') end
                return false
            end
        end
    end

    if restrictionData.allowedClasses then
        for _,class in ipairs(restrictionData.allowedClasses) do
            if vehicleClass == class then return true end
        end
    end


    if (restrictionData.allowedClasses and restrictionData.allowedClasses[1] == nil) or not restrictionData.allowedClasses or vehicleClass == 0 then return true end
    if Config.Debug then print('Denied for not having allowed vehicle class. ('..vehicleClass..')') end
    return false
end


--#[Global Functions]#--
function AttemptPurchase(type, upgradeLevel) 
    if receiptCheckJob() == true or menuCheckJob() == true or varUseReceiptSystem == false or type == 'repair' then 
        if upgradeLevel ~= nil then
            upgradeLevel = upgradeLevel + 2
        end
        TriggerServerEvent("customs:server:attemptPurchase", type, upgradeLevel)
        attemptingPurchase = true
        
        while attemptingPurchase do
            Wait(1)
        end
        
        if not isPurchaseSuccessful then
            PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
        end
        return isPurchaseSuccessful
    else
        receiptChange = true
        return true 
    end 
    if varUseReceiptSystem == true and receiptCheckJob() == false or menuCheckJob() == false then receiptChange = true return true end 
end

function RepairVehicle()
    TriggerServerEvent("customs:server:updateRepairCost", repairCost)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local getFuel = GetVehicleFuelLevel(plyVeh)

    SetVehicleFixed(plyVeh)
	SetVehicleDirtLevel(plyVeh, 0.0)
    SetVehiclePetrolTankHealth(plyVeh, 4000.0)
    SetVehicleFuelLevel(plyVeh, getFuel)

    for i = 0,5 do SetVehicleTyreFixed(plyVeh, i) end

end

function GetCurrentMod(id)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local mod = GetVehicleMod(plyVeh, id)
    local modName = GetLabelText(GetModTextLabel(plyVeh, id, mod))

    return mod, modName
end

function GetCurrentWheel()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local wheel = GetVehicleMod(plyVeh, 23)
    local wheelName = GetLabelText(GetModTextLabel(plyVeh, 23, wheel))
    local wheelType = GetVehicleWheelType(plyVeh)

    return wheel, wheelName, wheelType
end

function GetCurrentCustomWheelState()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local state = GetVehicleModVariation(plyVeh, 23)

    return state and 1 or 0
end

function GetOriginalWheel()
    return originalWheel
end

function GetOriginalCustomWheel()
    return originalCustomWheels
end

function GetCurrentWindowTint()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    return GetVehicleWindowTint(plyVeh)
end

function GetCurrentVehicleWheelSmokeColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local r, g, b = GetVehicleTyreSmokeColor(plyVeh)

    return r, g, b
end

function GetCurrentNeonState(id)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsVehicleNeonLightEnabled(plyVeh, id)

    return isEnabled and 1 or 0
end

function GetCurrentNeonColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local r, g, b = GetVehicleNeonLightsColour(plyVeh)

    return r, g, b
end

function GetCurrentXenonState()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsToggleModOn(plyVeh, 22)

    return isEnabled and 1 or 0
end

function GetCurrentXenonColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    return GetVehicleHeadlightsColour(plyVeh)
end

function GetCurrentTurboState()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsToggleModOn(plyVeh, 18)

    return isEnabled and 0 or -1
end

function CheckValidMods(category, id, wheelType)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local tempWheel = GetVehicleMod(plyVeh, 23)
    local tempWheelType = GetVehicleWheelType(plyVeh)
    local tempWheelCustom = GetVehicleModVariation(plyVeh, 23)
    local validMods = {}
    local amountValidMods = 0
    local hornNames = {}

    if wheelType ~= nil then
        SetVehicleWheelType(plyVeh, wheelType)
    end

    if id == 14 then
        for k, _ in pairs(vehicleCustomisation) do
            if vehicleCustomisation[k].category == category then
                hornNames = vehicleCustomisation[k].hornNames

                break
            end
        end
    end

    local modAmount = GetNumVehicleMods(plyVeh, id)
    for i = 1, modAmount do
        local label = GetModTextLabel(plyVeh, id, (i - 1))
        local modName = GetLabelText(label)

        if modName == "NULL" then
            if id == 14 then
                if i <= #hornNames then
                    modName = hornNames[i].name
                else
                    modName = "Horn " .. i
                end
            else
                modName = category .. " " .. i
            end
        end

        validMods[i] =
        {
            id = (i - 1),
            name = modName
        }

        amountValidMods = amountValidMods + 1
    end

    if modAmount > 0 then
        table.insert(validMods, 1, {
            id = -1,
            name = "Stock " .. category
        })
    end

    if wheelType ~= nil then
        SetVehicleWheelType(plyVeh, tempWheelType)
        SetVehicleMod(plyVeh, 23, tempWheel, tempWheelCustom)
    end

    return validMods, amountValidMods
end

function RestoreOriginalMod()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleMod(plyVeh, originalCategory, originalMod)
    SetVehicleDoorsShut(plyVeh, true)

    originalCategory = nil
    originalMod = nil
end

function RestoreOriginalWindowTint()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleWindowTint(plyVeh, originalWindowTint)

    originalWindowTint = nil
end


function RestoreOriginalColours()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    -- if hasCustomColour == true then 
    --     SetVehicleCustomPrimaryColour(plyVeh, customPrimaryColourR, customPrimaryColourG, customPrimaryColourB) 
    --     SetVehicleCustomSecondaryColour(plyVeh, customSecondaryColourR, customSecondaryColourG, customSecondaryColourB) 
    -- end 

    SetVehicleColours(plyVeh, originalPrimaryColour, originalSecondaryColour)
    SetVehicleExtraColours(plyVeh, originalPearlescentColour, originalWheelColour)
    SetVehicleDashboardColour(plyVeh, originalDashColour)
    SetVehicleInteriorColour(plyVeh, originalInterColour)

    originalPrimaryColour = nil
    originalSecondaryColour = nil
    originalPearlescentColour = nil
    originalWheelColour = nil
    originalDashColour = nil
    originalInterColour = nil
end

function RestoreOriginalWheels()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleWheelType(plyVeh, originalWheelType)

    if originalWheelCategory ~= nil then
        SetVehicleMod(plyVeh, originalWheelCategory, originalWheel, originalCustomWheels)

        if GetVehicleClass(plyVeh) == 8 then --Motorcycle
            SetVehicleMod(plyVeh, 24, originalWheel, originalCustomWheels)
        end

        originalWheelType = nil
        originalWheelCategory = nil
        originalWheel = nil
        originalCustomWheels = nil
    end
end

function RestoreOriginalNeonStates()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleNeonLightEnabled(plyVeh, originalNeonLightSide, originalNeonLightState)

    originalNeonLightState = nil
    originalNeonLightSide = nil
end

function RestoreOriginalNeonColours()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleNeonLightsColour(plyVeh, originalNeonColourR, originalNeonColourG, originalNeonColourB)

    originalNeonColourR = nil
    originalNeonColourG = nil
    originalNeonColourB = nil
end

function RestoreOriginalXenonColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleHeadlightsColour(plyVeh, originalXenonColour)
    SetVehicleLights(plyVeh, 0)

    originalXenonColour = nil
end

function RestoreOldLivery()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleLivery(plyVeh, originalOldLivery)
end

function RestorePlateIndex()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleNumberPlateTextIndex(plyVeh, originalPlateIndex)
end

function PreviewMod(categoryID, modID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalMod == nil and originalCategory == nil then
        originalCategory = categoryID
        originalMod = GetVehicleMod(plyVeh, categoryID)
    end

    if categoryID == 39 or categoryID == 40 or categoryID == 41 then
        SetVehicleDoorOpen(plyVeh, 4, false, true)
    elseif categoryID == 37 or categoryID == 38 then
        SetVehicleDoorOpen(plyVeh, 5, false, true)
    end

    SetVehicleMod(plyVeh, categoryID, modID)
end

function PreviewWindowTint(windowTintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalWindowTint == nil then
        originalWindowTint = GetVehicleWindowTint(plyVeh)
    end

    SetVehicleWindowTint(plyVeh, windowTintID)
end

function PreviewColour(paintType, paintCategory, paintID)
    local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)

    if GetIsVehiclePrimaryColourCustom(playerVeh) then 
        ClearVehicleCustomPrimaryColour(playerVeh) 
    end  
    if GetIsVehicleSecondaryColourCustom(playerVeh) then 
        ClearVehicleCustomSecondaryColour(playerVeh)
    end 
    
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleModKit(plyVeh, 0)
    if originalDashColour == nil and originalInterColour == nil and originalPrimaryColour == nil and originalSecondaryColour == nil and originalPearlescentColour == nil and originalWheelColour == nil then
        originalPrimaryColour, originalSecondaryColour = GetVehicleColours(plyVeh)
        originalPearlescentColour, originalWheelColour = GetVehicleExtraColours(plyVeh)
        originalDashColour = GetVehicleDashboardColour(plyVeh)
        originalInterColour = GetVehicleInteriorColour(plyVeh)
    end
    if paintType == 0 then --Primary Colour
        if paintCategory == 1 then --Metallic Paint
            SetVehicleColours(plyVeh, paintID, originalSecondaryColour)
            SetVehicleExtraColours(plyVeh, originalPearlescentColour, originalWheelColour)
        else
            SetVehicleColours(plyVeh, paintID, originalSecondaryColour)
        end
    elseif paintType == 1 then --Secondary Colour
        SetVehicleColours(plyVeh, originalPrimaryColour, paintID)
    elseif paintType == 2 then --Pearlescent Colour
        SetVehicleExtraColours(plyVeh, paintID, originalWheelColour)
    elseif paintType == 3 then --Wheel Colour
        SetVehicleExtraColours(plyVeh, originalPearlescentColour, paintID)
    elseif paintType == 4 then --Dash Colour
        SetVehicleDashboardColour(plyVeh, paintID)
    elseif paintType == 5 then --Interior Colour
        SetVehicleInteriorColour(plyVeh, paintID)
    end
end

function PreviewWheel(categoryID, wheelID, wheelType)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local doesHaveCustomWheels = GetVehicleModVariation(plyVeh, 23)

    if originalWheelCategory == nil and originalWheel == nil and originalWheelType == nil and originalCustomWheels == nil then
        originalWheelCategory = categoryID
        originalWheelType = GetVehicleWheelType(plyVeh)
        originalWheel = GetVehicleMod(plyVeh, 23)
        originalCustomWheels = GetVehicleModVariation(plyVeh, 23)
    end

    SetVehicleWheelType(plyVeh, wheelType)
    SetVehicleMod(plyVeh, categoryID, wheelID, doesHaveCustomWheels)

    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        SetVehicleMod(plyVeh, 24, wheelID, doesHaveCustomWheels)
    end
end

function PreviewNeon(side, enabled)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalNeonLightState == nil and originalNeonLightSide == nil then
        if IsVehicleNeonLightEnabled(plyVeh, side) then
            originalNeonLightState = 1
        else
            originalNeonLightState = 0
        end

        originalNeonLightSide = side
    end

    SetVehicleNeonLightEnabled(plyVeh, side, enabled)
end

function PreviewNeonColour(r, g, b)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalNeonColourR == nil and originalNeonColourG == nil and originalNeonColourB == nil then
        originalNeonColourR, originalNeonColourG, originalNeonColourB = GetVehicleNeonLightsColour(plyVeh)
    end

    SetVehicleNeonLightsColour(plyVeh, r, g, b)
end

function PreviewXenonColour(colour)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalXenonColour == nil then
        originalXenonColour = GetVehicleHeadlightsColour(plyVeh)
    end

    SetVehicleLights(plyVeh, 2)
    SetVehicleHeadlightsColour(plyVeh, colour)
end

function PreviewOldLivery(liv)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    if originalOldLivery == nil then
        originalOldLivery = GetVehicleLivery(plyVeh)
    end

    SetVehicleLivery(plyVeh, tonumber(liv))
end

function PreviewPlateIndex(index)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    if originalPlateIndex == nil then
        originalPlateIndex = GetVehicleNumberPlateTextIndex(plyVeh)
    end

    SetVehicleNumberPlateTextIndex(plyVeh, tonumber(index))
end

function ApplyMod(categoryID, modID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if categoryID == 18 then
        ToggleVehicleMod(plyVeh, categoryID, modID+1)
    elseif categoryID == 11 or categoryID == 12 or categoryID== 13 or categoryID == 15 or categoryID == 16 then --Performance Upgrades
        originalCategory = categoryID
        originalMod = modID

        SetVehicleMod(plyVeh, categoryID, modID)
    else
        originalCategory = categoryID
        originalMod = modID

        SetVehicleMod(plyVeh, categoryID, modID)
    end
end

function ApplyExtra(extraID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsVehicleExtraTurnedOn(plyVeh, extraID)
    if isEnabled == 1 then
        SetVehicleExtra(plyVeh, tonumber(extraID), 1)
        SetVehiclePetrolTankHealth(plyVeh,4000.0)
    else
        SetVehicleExtra(plyVeh, tonumber(extraID), 0)
        SetVehiclePetrolTankHealth(plyVeh,4000.0)
    end
end

function ApplyWindowTint(windowTintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalWindowTint = windowTintID

    SetVehicleWindowTint(plyVeh, windowTintID)
end

function ApplyColour(paintType, paintCategory, paintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(plyVeh)
    local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(plyVeh)

    if paintType == 0 then --Primary Colour
        if paintCategory == 1 then --Metallic Paint
            SetVehicleColours(plyVeh, paintID, vehSecondaryColour)
            -- SetVehicleExtraColours(plyVeh, paintID, vehWheelColour)
            SetVehicleExtraColours(plyVeh, originalPearlescentColour, vehWheelColour)
            originalPrimaryColour = paintID
            -- originalPearlescentColour = paintID
        else
            SetVehicleColours(plyVeh, paintID, vehSecondaryColour)
            originalPrimaryColour = paintID
        end
    elseif paintType == 1 then --Secondary Colour
        SetVehicleColours(plyVeh, vehPrimaryColour, paintID)
        originalSecondaryColour = paintID
    elseif paintType == 2 then --Pearlescent Colour
        SetVehicleExtraColours(plyVeh, paintID, vehWheelColour)
        originalPearlescentColour = paintID
    elseif paintType == 3 then --Wheel Colour
        SetVehicleExtraColours(plyVeh, vehPearlescentColour, paintID)
        originalWheelColour = paintID
    elseif paintType == 4 then --Dash Colour
        SetVehicleDashboardColour(plyVeh, paintID)
        originalDashColour = paintID
    elseif paintType == 5 then --Interior Colour
        SetVehicleInteriorColour(plyVeh, paintID)
        originalInterColour = paintID
    end
end

function ApplyWheel(categoryID, wheelID, wheelType)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local doesHaveCustomWheels = GetVehicleModVariation(plyVeh, 23)

    originalWheelCategory = categoryID
    originalWheel = wheelID
    originalWheelType = wheelType

    SetVehicleWheelType(plyVeh, wheelType)
    SetVehicleMod(plyVeh, categoryID, wheelID, doesHaveCustomWheels)

    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        SetVehicleMod(plyVeh, 24, wheelID, doesHaveCustomWheels)
    end
end

function ApplyCustomWheel(state)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleMod(plyVeh, 23, GetVehicleMod(plyVeh, 23), state)

    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        SetVehicleMod(plyVeh, 24, GetVehicleMod(plyVeh, 24), state)
    end
end

function ApplyNeon(side, enabled)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalNeonLightState = enabled
    originalNeonLightSide = side

    SetVehicleNeonLightEnabled(plyVeh, side, enabled)
end

function ApplyNeonColour(r, g, b)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalNeonColourR = r
    originalNeonColourG = g
    originalNeonColourB = b

    SetVehicleNeonLightsColour(plyVeh, r, g, b)
end

function ApplyXenonLights(category, state)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    ToggleVehicleMod(plyVeh, category, state)
end

function ApplyXenonColour(colour)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalXenonColour = colour

    SetVehicleHeadlightsColour(plyVeh, colour)
end

function ApplyOldLivery(liv)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalOldLivery = liv

    SetVehicleLivery(plyVeh, liv)
end

function ApplyPlateIndex(index)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    originalPlateIndex = index
    SetVehicleNumberPlateTextIndex(plyVeh, index)
end

function ApplyTyreSmoke(r, g, b)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    ToggleVehicleMod(plyVeh, 20, true)
    SetVehicleTyreSmokeColor(plyVeh, r, g, b)
end


-- RECEIPT SYSTEM by d3MBA#0001 
function receiptCheckJob()
    receiptJob = false
    for _, v in pairs(saveUpgradesJobs) do 
        if QBCore.Functions.GetPlayerData().job.name == v then 
            if saveUpgradesDutyCheck == true then 
                if QBCore.Functions.GetPlayerData().job.onduty then 
                    receiptJob = true
                else
                    receiptJob = false
                end 
            else
                receiptJob = true
            end 
        end 
    end 
    return receiptJob
end 


function ExitBennys()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    -- RECEIPT SYSTEM 

    if varUseReceiptSystem == true and receiptChange == true and not receiptCheckJob() then  
        vehicleReceipt()
    end 

    if varUseReceiptSystem == false then  
        d3VehiclesMods = { neonColor = {}, wheelSmokeColor = {}, tyreSmokeColor = {}, pearlescentColour ={}, windowTint = {}, xenonColor = {}, vehicleCosmetics = {}, wheelName = {}, wheelColor = {}, dashboardColor ={}, primaryColor = {}, secondaryColor = {}, interiorColor ={}}
        getVehiclePropertiesReceipt = {}
        saveVehicle()
    end 


    receiptChange = false 
    varUseReceiptSystem = false 

    DisplayMenuContainer(false)
    FreezeEntityPosition(plyVeh, false)
    SetEntityCollision(plyVeh, true, true)

    SetTimeout(100, function()
        DestroyMenus()
    end)

    if next(CustomsData) then
        SetupInteraction()
    end

    isPlyInBennys = false    
end


function EnterLocation(override)
    local locationData = Config.Locations[CustomsData.location]
    local categories = (override and override.categories) or {
        repair = false,
        mods = false,
        armor = false,
        respray = false,
        liveries = false,
        wheels = false,
        tint = false,
        plate = false,
        extras = false,
        neons = false,
        xenons = false,
        horn = false,
        turbo = false,
        cosmetics = false,
    }

    local canEnter = false
    local repairOnly = true
    if next(CustomsData) then
        for k,v in pairs(locationData.categories) do
            if not canEnter and v then
                if k ~= "repair" then repairOnly = false end
                canEnter = true
            end
            categories[k] = v
        end
    elseif override then canEnter = true end

    if Config.Debug then
        print('***************************************************************************')
        print(string.format('EnterLocation Debug Start | CanEnter: %s | Repair Only: %s | Override: %s', canEnter, repairOnly, json.encode(override)))
        print('***************************************************************************')
        if next(locationData) then for k,v in pairs(locationData) do print(k, json.encode(v)) end end
        for k,v in pairs(categories) do print(k,v) end
        print('***************************************************************************')
        print('EnterLocation Debug End')
        print('***************************************************************************')
    end

    if not canEnter then
        QBCore.Functions.Notify('You cant do anything here!')
        ExitBennys()
        return
    end

    if Config.UseRadial then
        exports['qb-radialmenu']:RemoveOption(radialMenuItemId)
        radialMenuItemId = nil
    end

    exports["interaction"]:hideInteraction()

    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isMotorcycle

    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        isMotorcycle = true
    else
        isMotorcycle = false
    end

    SetVehicleModKit(plyVeh, 0)
    SetEntityCoords(plyVeh, ((override and override.coords) or CustomsData.coords))
    SetEntityHeading(plyVeh, ((override and override.heading) or CustomsData.heading))
    FreezeEntityPosition(plyVeh, true)
    SetEntityCollision(plyVeh, false, true)

    local welcomeLabel = (locationData and locationData.settings.welcomeLabel) or "Welcome to Benny's Motorworks!"
    InitiateMenus(isMotorcycle, GetVehicleBodyHealth(plyVeh), categories, welcomeLabel)

    SetTimeout(100, function()
        if GetVehicleBodyHealth(plyVeh) < 1000.0 then 
            DisplayMenu(true, "repairMenu")
        else
            DisplayMenu(true, "mainMenu")
        end

        DisplayMenuContainer(true)  
        PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end)

    isPlyInBennys = true
    DisableControls(repairOnly)
end


function DisableControls(repairOnly)
    CreateThread(function()
        while isPlyInBennys do
            DisableControlAction(1, 38, true) --Key: E
            DisableControlAction(1, 172, true) --Key: Up Arrow
            DisableControlAction(1, 173, true) --Key: Down Arrow
            DisableControlAction(1, 177, true) --Key: Backspace
            DisableControlAction(1, 176, true) --Key: Enter
            DisableControlAction(1, 71, true) --Key: W (veh_accelerate)
            DisableControlAction(1, 72, true) --Key: S (veh_brake)
            DisableControlAction(1, 34, true) --Key: A
            DisableControlAction(1, 35, true) --Key: D
            DisableControlAction(1, 75, true) --Key: F (veh_exit)

            if IsDisabledControlJustReleased(1, 172) then --Key: Arrow Up
                MenuScrollFunctionality("up")
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end

            if IsDisabledControlJustReleased(1, 173) then --Key: Arrow Down
                MenuScrollFunctionality("down")
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end

            if IsDisabledControlJustReleased(1, 176) then --Key: Enter
                MenuManager(true, repairOnly)
                PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end

            if IsDisabledControlJustReleased(1, 177) then --Key: Backspace
                MenuManager(false)
                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end

            Wait(0)
        end
    end)
end

function GetLocations()
    QBCore.Functions.TriggerCallback("customs:server:GetLocations", function(locations)
        Config.Locations = locations
    end)
end

function CheckForKeypress()
    if next(CustomsData) then
        CreateThread(function()
            while next(CustomsData) and not isPlyInBennys do
                if IsControlJustReleased(0, 38) and CheckRestrictions(CustomsData.location) then EnterLocation() return end
                Wait(0)
            end
        end)
    end
end

-- If a player isnt in a vehicle, when they enter the zone, the closet vehicle is checked
-- The vehicle is checked if it has collision disabled and nobody in the driver seat
-- If so it will set the collision to true and unfreeze the entity =D
function CheckForGhostVehicle()
    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then return end
    local closestVehicle, closestDistance = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    if closestVehicle ~= -1 and closestDistance < 10.0 and GetEntityCollisionDisabled(closestVehicle) and GetPedInVehicleSeat(closestVehicle, -1) == 0 then
        FreezeEntityPosition(closestVehicle, false)
        SetEntityCollision(closestVehicle, true, true)
    end
end


function CheckRestrictions(location)
    local PlayerPed = PlayerPedId()
    local _location = Config.Locations[location]
    local restrictions = _location.restrictions

    varUseReceiptSystem = Config.Locations[location].settings.useReceiptSystem

    saveUpgradesJobs = Config.Locations[location].settings.saveUpgrades.jobs
    saveUpgradesDutyCheck = Config.Locations[location].settings.saveUpgrades.dutyCheck

    upgradeMenuAccessJobs = Config.Locations[location].settings.upgradesMenuAccess.jobs
    upgradeMenuAccessDutyCheck = Config.Locations[location].settings.upgradesMenuAccess.dutyCheck
    Wait(100)

    if Config.Debug then
        print('***************************************************************************')
        print('Restriction Debug')
        print('***************************************************************************')
    end

    local isEnabled = _location.settings.enabled
    local vehicle = GetVehiclePedIsIn(PlayerPed, false)
    local allowedJob = AllowJob(restrictions, PlayerData.job.name)
    local allowedGang = AllowGang(restrictions, PlayerData.gang.name)
    local allowedClass = AllowVehicleClass(restrictions, GetVehiclePedIsIn(PlayerPed, false))

    if Config.Debug then
        print(string.format('Is Enabled: %s\nVehicle: %s\nallowedJob: %s\nallowedGang: %s\nallowedClass: %s', isEnabled, vehicle, allowedJob, allowedGang, allowedClass))
        print('***************************************************************************')
    end
    return isEnabled and vehicle ~= 0 and allowedJob and allowedGang and allowedClass
end

function SetupInteraction()
    local text = CustomsData.drawtextui
    if Config.UseRadial then
        if not radialMenuItemId then
            radialMenuItemId = exports['qb-radialmenu']:AddOption({
                id = 'customs',
                title = 'الورشة',
                icon = 'wrench',
                type = 'client',
                event = 'customs:client:EnterCustoms',
                shouldClose = true
            })
        end
    else
        CheckForKeypress()
    end
    exports["interaction"]:showInteraction('F1', text)
end

exports('GetCustomsData', function() if next(CustomsData) ~= nil then return CustomsData else return nil end end)
-----------------------
----   Threads     ----
-----------------------

-- Location Creation
CreateThread(function()
    while not PlayerData.job do Wait(2500) end
    for location, data in pairs(Config.Locations) do
        -- PolyZone + Drawtext + Locations Management
        for i, spot in ipairs(data.zones) do
            local _name = location.."-customs-"..i
            local newSpot = BoxZone:Create(spot.coords, spot.length, spot.width, {
                name = _name,
                -- debugPoly = true,
                heading = spot.heading,
                minZ = spot.minZ,
                maxZ = spot.maxZ,
            })

            newSpot:onPlayerInOut(function(isPointInside, _)
                if isPointInside then
                    CustomsData = {
                        ['location'] = location,
                        ['spot'] = _name,
                        ['coords'] = vector3(spot.coords.x, spot.coords.y, spot.coords.z),
                        ['heading'] = spot.heading,
                        ['drawtextui'] = data.drawtextui.text,
                    }
                    SetupInteraction()
                    CheckForGhostVehicle()
                elseif CustomsData['location'] == location and CustomsData['spot'] == _name then
                    CustomsData = {}
                    if Config.UseRadial then
                        exports['qb-radialmenu']:RemoveOption(radialMenuItemId)
                        radialMenuItemId = nil
                    end
                    exports["interaction"]:hideInteraction()
                end
            end)
        end

        -- Blips
        local blipData = data.blip
        if blipData and blipData.enabled then CreateBlip(blipData) end
    end
end)

-----------------------
---- Client Events ----
-----------------------

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() and QBCore.Functions.GetPlayerData() ~= {} then
        GetLocations()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() and isPlyInBennys then
        ExitBennys()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    GetLocations()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerData.gang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('customs:client:UpdateLocation', function(location, type, key, value)
    Config.Locations[location][type][key] = value
end)

RegisterNetEvent("customs:client:purchaseSuccessful", function()
    isPurchaseSuccessful = true
    attemptingPurchase = false
    QBCore.Functions.Notify("Purchase Successful")
end)

RegisterNetEvent("customs:client:purchaseFailed", function()
    isPurchaseSuccessful = false
    attemptingPurchase = false
    QBCore.Functions.Notify("Not enough money", "error")
end)

RegisterNetEvent('customs:client:EnterCustoms', function(override)
    if not override.coords or not override.heading then override = nil end
    if not IsPedInAnyVehicle(PlayerPedId(), false) or isPlyInBennys or (not next(CustomsData) and not override) then return end
    if not override and next(CustomsData) and not CheckRestrictions(CustomsData.location) then return end

    varUseReceiptSystem = Config.Locations[CustomsData.location].settings.useReceiptSystem

    saveUpgradesJobs = Config.Locations[CustomsData.location].settings.saveUpgrades.jobs
    saveUpgradesDutyCheck = Config.Locations[CustomsData.location].settings.saveUpgrades.dutyCheck

    upgradeMenuAccessJobs = Config.Locations[CustomsData.location].settings.upgradesMenuAccess.jobs
    upgradeMenuAccessDutyCheck = Config.Locations[CustomsData.location].settings.upgradesMenuAccess.dutyCheck

    EnterLocation(override)
end)



function SetVehicleProperties(vehicle, props)
    if DoesEntityExist(vehicle) then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        SetVehicleModKit(vehicle, 0)

        if props.plate then
            SetVehicleNumberPlateText(vehicle, props.plate)
        end
        if props.plateIndex then
            SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
        end
            -- SetVehicleCustomPrimaryColour(vehicle, math.ceil(props.customPrimaryColor[1]), math.ceil(props.customPrimaryColor[2]), math.ceil(props.customPrimaryColor[3]))
            -- SetVehicleCustomSecondaryColour(vehicle, math.ceil(props.customSecondaryColor[1]), math.ceil(props.customSecondaryColor[2]), math.ceil(props.customSecondaryColor[3]))
            if hasCustomColour == false then 
                SetVehicleColours(vehicle, props.color1, props.color2)
            end 
        -- if props.color2 then
        --     SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2)
        -- end
        if props.pearlescentColor then
            SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
        end
        if props.wheelColor then
            SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor)
        end
        if props.wheels then
            SetVehicleWheelType(vehicle, props.wheels)
        end
        if props.windowTint then 
            if props.windowTint == -1 then props.windowTint = 0 end 
            SetVehicleWindowTint(vehicle, 0)
        end

        if props.neonEnabled then
            SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
            SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
            SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
            SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
        end

        if props.extras then
            for extraId, enabled in pairs(props.extras) do
                if enabled then
                    SetVehicleExtra(vehicle, tonumber(extraId), 0)
                else
                    SetVehicleExtra(vehicle, tonumber(extraId), 1)
                end
            end
        end

        if props.neonColor then
            SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
        end 
        if props.xenonColor then
            SetVehicleXenonLightsColor(vehicle, props.xenonColor)
        end
        if props.customXenonColor then
            SetVehicleXenonLightsCustomColor(vehicle, props.customXenonColor[1], props.customXenonColor[2],
                props.customXenonColor[3])
        end
        if props.modSmokeEnabled then
            ToggleVehicleMod(vehicle, 20, true)
        end
        if props.tyreSmokeColor then
            SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
        end
        if props.modSpoilers then
            SetVehicleMod(vehicle, 0, props.modSpoilers, false)
        end
        if props.modFrontBumper then
            SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
        end
        if props.modRearBumper then
            SetVehicleMod(vehicle, 2, props.modRearBumper, false)
        end
        if props.modSideSkirt then
            SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
        end
        if props.modExhaust then
            SetVehicleMod(vehicle, 4, props.modExhaust, false)
        end
        if props.modFrame then
            SetVehicleMod(vehicle, 5, props.modFrame, false)
        end
        if props.modGrille then
            SetVehicleMod(vehicle, 6, props.modGrille, false)
        end
        if props.modHood then
            SetVehicleMod(vehicle, 7, props.modHood, false)
        end
        if props.modFender then
            SetVehicleMod(vehicle, 8, props.modFender, false)
        end
        if props.modRightFender then
            SetVehicleMod(vehicle, 9, props.modRightFender, false)
        end
        if props.modRoof then
            SetVehicleMod(vehicle, 10, props.modRoof, false)
        end
        if props.modEngine then
            SetVehicleMod(vehicle, 11, props.modEngine, false)
        end
        if props.modBrakes then
            SetVehicleMod(vehicle, 12, props.modBrakes, false)
        end
        if props.modTransmission then
            SetVehicleMod(vehicle, 13, props.modTransmission, false)
        end
        if props.modHorns then
            SetVehicleMod(vehicle, 14, props.modHorns, false)
        end
        if props.modSuspension then
            SetVehicleMod(vehicle, 15, props.modSuspension, false)
        end
        if props.modArmor then
            SetVehicleMod(vehicle, 16, props.modArmor, false)
        end
        if props.modTurbo then
            ToggleVehicleMod(vehicle, 18, props.modTurbo)
        end
        if props.modXenon == false then 
            ToggleVehicleMod(vehicle, 22, props.modXenon)
            SetVehicleMod(vehicle, 22, props.modXenon, false)
        end
        if props.modFrontWheels then
            SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
        end
        if props.modBackWheels then
            SetVehicleMod(vehicle, 24, props.modBackWheels, false)
        end
        if props.modPlateHolder then
            SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
        end
        if props.modVanityPlate then
            SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
        end
        if props.modTrimA then
            SetVehicleMod(vehicle, 27, props.modTrimA, false)
        end
        if props.modOrnaments then
            SetVehicleMod(vehicle, 28, props.modOrnaments, false)
        end
        if props.modDashboard then
            SetVehicleMod(vehicle, 29, props.modDashboard, false)
        end
        if props.modDial then
            SetVehicleMod(vehicle, 30, props.modDial, false)
        end
        if props.modDoorSpeaker then
            SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
        end
        if props.modSeats then
            SetVehicleMod(vehicle, 32, props.modSeats, false)
        end
        if props.modSteeringWheel then
            SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
        end
        if props.modShifterLeavers then
            SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
        end
        if props.modAPlate then
            SetVehicleMod(vehicle, 35, props.modAPlate, false)
        end
        if props.modSpeakers then
            SetVehicleMod(vehicle, 36, props.modSpeakers, false)
        end
        if props.modTrunk then
            SetVehicleMod(vehicle, 37, props.modTrunk, false)
        end
        if props.modHydrolic then
            SetVehicleMod(vehicle, 38, props.modHydrolic, false)
        end
        if props.modEngineBlock then
            SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
        end
        if props.modAirFilter then
            SetVehicleMod(vehicle, 40, props.modAirFilter, false)
        end
        if props.modStruts then
            SetVehicleMod(vehicle, 41, props.modStruts, false)
        end
        if props.modArchCover then
            SetVehicleMod(vehicle, 42, props.modArchCover, false)
        end
        if props.modAerials then
            SetVehicleMod(vehicle, 43, props.modAerials, false)
        end
        if props.modTrimB then
            SetVehicleMod(vehicle, 44, props.modTrimB, false)
        end
        if props.modTank then
            SetVehicleMod(vehicle, 45, props.modTank, false)
        end
        if props.modWindows then
            SetVehicleMod(vehicle, 46, props.modWindows, false)
        end

        if props.modLivery then
            SetVehicleMod(vehicle, 48, props.modLivery, false)
            SetVehicleLivery(vehicle, props.modLivery)
        end
        -- variables 
        hasCustomColour = false 
    end
end

-- CreateThread(function() 
--     while true do 
--         Wait(500)
--         local plyPed = PlayerPedId()
--         local veh = GetVehiclePedIsIn(plyPed, false)
--         local modovi = QBCore.Functions.GetVehicleProperties(veh)
--         print((json.encode(modovi)))
--         -- print(GetCurrentXenonState())
--         print(QBCore.Functions.GetVehicleProperties(veh))
--     end 
-- end)


-- RegisterCommand("kasd", function()
--     print("asdasd")
--     local plyPed = PlayerPedId()
--     local veh = GetVehiclePedIsIn(plyPed, false)
--     SetVehicleMod(veh, 22, 0, false)
-- end)