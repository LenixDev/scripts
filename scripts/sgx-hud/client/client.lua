local QBCore = exports["qb-core"]:GetCoreObject()
local stress = 0
local startHud = false
local playerInVehicle = false
local HudSettings = false
local onRadio = false
local HudSettings = false
local nos = 0
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

CreateThread(function()
    while true do
        local menuPause = IsPauseMenuActive()
        if not menuPause then
            if startHud then
                Wait(300)
                local PlayerData = QBCore.Functions.GetPlayerData()
                local player = PlayerPedId()
                local talking = NetworkIsPlayerTalking(PlayerId())
                local vehicle = GetVehiclePedIsIn(player)
                local position = GetEntityCoords(player)
                local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
                local zoneName = zones[GetNameOfZone(position.x, position.y, position.z)]
                local playerCash = PlayerData.money["cash"]
                local playerBank = PlayerData.money["bank"]
                local oxygenBar = 10.0 * GetPlayerUnderwaterTimeRemaining(PlayerId())
                local staminaBar = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
                local hungerBar = PlayerData.metadata["hunger"]
                local thirstBar = PlayerData.metadata["thirst"]
                local armorBar = GetPedArmour(player)
                local healthBar = GetEntityHealth(player) - 100
                local engine = GetVehicleEngineHealth(vehicle) / 10

                SendNUIMessage({
                    action = "show-hud",
                    health = healthBar,
                    armor = armorBar,
                    hunger = hungerBar,
                    thirst = thirstBar,
                    stress = stress,
                    talking = talking,
                    stamina = staminaBar,
                    oxygen = oxygenBar,
                    cash = playerCash,
                    bank = playerBank, 
                    street =  streetName,
                    zones =  zoneName,
                    engine = engine,
                    nitrous = nos,
                })
                checkRadioState()
            else
                SendNUIMessage({ action = "hide-hud", })
                Wait(1000)
            end
        else
            SendNUIMessage({ action = "hide-hud", })
            Wait(1000)
        end
        Wait(0)
    end
end)

RegisterNetEvent('hud:client:UpdateNitrous', function(nitroLevel, bool)
    nos = nitroLevel
    nitroActive = bool
end)

RegisterNetEvent("speedometer:show")
AddEventHandler("speedometer:show", function()
    local playerInVehicle = true
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local vehicleModel = GetEntityModel(vehicle)

    local speed = GetSpeedTypeFromConfig(vehicle)
    local fuel = GetVehicleFuelLevel(vehicle)
    local gear = getinfo(selectedgear)
    local rpm = GetVehicleCurrentRpm(vehicle)
    local selectedgear = GearSelecteds()
    local gear = getinfo(selectedgear)
    local vehicleType = "Car" 
    if IsThisModelAHeli(vehicleModel) or IsThisModelAPlane(vehicleModel) then
        vehicleType = "Helicopter" 
    end
    SendNUIMessage ({
        action = "show-carhud",
        isInVehicle = isInVehicle,
        speed = speed,
        fuel = fuel,
        gear = gear,
        rpm = rpm,
        speedType = Config.SpeedType,
        vehicleType = vehicleType, 
    })
end)

RegisterNetEvent('hud:client:UpdateNitrous', function(nitroLevel, bool)
    nos = nitroLevel
    nitroActive = bool
end)

CreateThread(function() 
    while true do
        Wait(50)
        local pedVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if pedVehicle ~= 0 and GetIsVehicleEngineRunning(pedVehicle) then
            TriggerEvent("speedometer:show") 
        else
            TriggerEvent("speedometer:hide")
            Wait(1000)
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(9)
        Wait(50)
    end
end)

RegisterNetEvent("speedometer:hide")
AddEventHandler("speedometer:hide", function() 
    local playerInVehicle = false
    SendNUIMessage({
        action = "hide-carhud"
    })
end)

function GetSpeedTypeFromConfig(vehicle)
    local speed

    local isHelicopter = IsThisModelAHeli(GetEntityModel(vehicle))
    local isPlane = IsThisModelAPlane(GetEntityModel(vehicle))

    if isHelicopter or isPlane then
        speed = GetEntityHeightAboveGround(vehicle)
    else
        if Config.SpeedType then
            speed = GetEntitySpeed(vehicle) * 2.2369 
        else
            speed = GetEntitySpeed(vehicle) * 3.6 
        end
    end

    return speed 
end

local radarEnabled = true

CreateThread(function()
    while true do
        Wait(250)

        local player = PlayerId()
        local isPlayerInVehicle = IsPedInAnyVehicle(PlayerPedId())

        if not radarEnabled then
            DisplayRadar(false)
        elseif isPlayerInVehicle then
            DisplayRadar(true)
        elseif not IsPauseMenuActive() then
            DisplayRadar(false)
        end
    end
end)

RegisterNUICallback('toggleMap', function(_, cb)
    radarEnabled = not radarEnabled
    DisplayRadar(radarEnabled)
end)

Citizen.CreateThread(
    function()
    local minimapOffset = 0
    SetMinimapComponentPosition("minimap", "L", "B", -0.01 + minimapOffset, -0.037, 0.135, 0.183)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.045 + minimapOffset, 0.005, 0.270, 0.250)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
end)

-- Events & Handlers --

RegisterNetEvent("sgx-hud:client:DisplayCash", function()
    Wait(50)
    SendNUIMessage({ action = "hide-bank",})
    SendNUIMessage({ action = "show-cash",})
    Wait(10000)
    SendNUIMessage({ action = "hide-cash",})
end)

RegisterNetEvent("sgx-hud:client:DisplayBank", function()
    Wait(50)
    SendNUIMessage({ action = "hide-cash",})
    SendNUIMessage({ action = "show-bank",})
    Wait(10000)
    SendNUIMessage({ action = "hide-bank",})
end)

RegisterNUICallback('closeMenu', function(_, cb)
    HudSettings = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "closeSettings", })
end)

RegisterNUICallback('Settings', function(data)
    HudSettings = false
    TriggerEvent('hud:client:LoadMap')
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hide-menu", })
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1)
end)

RegisterCommand(Config.Settings, function() 
    Wait(50)
    if HudSettings then return end
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "openSettings", })
    HudSettings = true
end)

RegisterKeyMapping(Config.Settings, 'Open Hud Settings', 'keyboard', 'I')

local function restartHud()
    SendNUIMessage({ action = "hide-ui" })
    QBCore.Functions.Notify(Lang:t('notify.hud_restart'), 'info', 5000)
    if IsPedInAnyVehicle(PlayerPedId()) then
        Wait(2600)
    end
    Wait(5000)
    SendNUIMessage({ action = "show-ui" })
    QBCore.Functions.Notify(Lang:t('notify.hud_restarted'), 'success')
end

function checkRadioState()
    local isRadioOn = exports["qb-radio"]:IsRadioOn(IsRadioOn)
    if isRadioOn then
        SendNUIMessage({ action = "show-radio" })
    else 
        SendNUIMessage({ action = "hide-radio" })
    end
end

RegisterNUICallback('restartHud', function(_, cb)
    Wait(50)
    restartHud()
    cb('ok')
end)

RegisterCommand(Config.HudRestart, function()
    Wait(50)
    restartHud()
end)

RegisterNetEvent('pma-voice:setTalkingMode', function(voiceMode)
    SendNUIMessage({
        action = "voiceMode",
        value = voiceMode,
    })
end)

RegisterNetEvent('pma-voice:radioActive', function(radio)
    SendNUIMessage({
        action = "radio",
        value = radio
    })
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    startHud = true
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress) 
    stress = newStress
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    PlayerData = QBCore.Functions.GetPlayerData()
    startHud = true
    Wait(3000)
    SetEntityHealth(PlayerPedId(), 200)
end)
 
RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    startHud = false
end) 

RegisterCommand('starthudfalse',function(source,args) 
    startHud = false
end)

CreateThread(function()
    local heading, lastHeading = 0, 1
    while Config.ShowCompass do
        Wait(50)
        if Config.FollowCam then
            local camRot = GetGameplayCamRot(0)
            heading = tostring(round(360.0 - ((camRot.z + 360.0) % 360.0)))

        else
            heading = tostring(round(360.0 - GetEntityHeading(PlayerPedId())))
        end

        if heading == '360' then heading = '0' end

        if heading ~= lastHeading then
            if IsPedInAnyVehicle(PlayerPedId()) then
                SendNUIMessage({ action = "display", value = heading })
            else
                SendNUIMessage({ action = "hide", value = heading })
                Wait(2000)
            end
        end
        lastHeading = heading
    end
end) 