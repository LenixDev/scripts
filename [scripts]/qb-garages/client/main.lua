-- Citizen.CreateThread(function()
--     SetNuiFocus(true, true)
-- end)
local garageZones = {}
local listenForKey = false
-- Handlers
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    CreateBlipsZones()
end)

RegisterNetEvent('esx:playerLoaded', function()
    CreateBlipsZones()
end)

AddEventHandler('onResourceStart', function(res)
    if res ~= GetCurrentResourceName() then return end
    while CoreReady == false do Citizen.Wait(0) end
    CreateBlipsZones()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

-- Functions
function round(num, numDecimalPlaces)
    return tonumber(string.format('%.' .. (numDecimalPlaces or 0) .. 'f', num))
end

function CheckPlayers(vehicle)
    for i = -1, 5, 1 do
        local seat = GetPedInVehicleSeat(vehicle, i)
        if seat then
            TaskLeaveVehicle(seat, vehicle, 0)
        end
    end
    Wait(1500)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end

function OpenGarageMenu(data)
    TriggerCallback('qb-garages:server:GetGarageVehicles', function(result)
        if result == nil then return Notify(Lang:t('error.no_vehicles'), 5000, 'error') end
        local formattedVehicles = {}
        for _, v in pairs(result) do
            local enginePercent = round(v.engine, 0)
            local bodyPercent = round(v.body, 0)
            local vname = nil
            if CoreName == "es_extended" then
                vehData = json.decode(v.vehicle)
                vehicle = string.lower(GetDisplayNameFromVehicleModel(vehData.model))
                state = v.stored
            else
                vehicle = v.vehicle
                state = v.state
            end
            if not vehiclesData[vehicle] then
                return Notify("There is a vehicle that doesnt exist in your shared/vehicles.lua. (" .. vehicle .. ")")
            end
            pcall(function()
                vname = vehiclesData[vehicle].name
            end)
            if vehiclesData[vehicle].brand then
                vname = vehiclesData[vehicle].brand .. " " .. vehiclesData[vehicle].name
            end
            local mods = json.decode(v.mods) or {}
            local logs = json.decode(v.logs)
            table.sort(logs, function(a, b) return a.time > b.time end)
            formattedVehicles[#formattedVehicles + 1] = {
                vehicle = vehicle,
                vehClass = GetVehicleClassFromName(GetHashKey(vehicle)),
                vehicleLabel = vname or vehicle,
                plate = v.plate,
                plateIndex = mods.plateIndex or 0,
                state = state,
                fuel = v.fuel,
                engine = enginePercent,
                body = bodyPercent,
                distance = v.drivingdistance or 0,
                garage = Config.Garages[data.indexgarage],
                type = data.type,
                index = data.indexgarage,
                depotPrice = v.depotprice or 0,
                balance = v.balance or 0,
                logs = logs,
            }
        end
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'VehicleList',
            garageLabel = Config.Garages[data.indexgarage].label,
            vehicles = formattedVehicles,
            vehNum = #formattedVehicles,
            resourceName = GetCurrentResourceName(),
            garageType = data.type,
            useCarImg = Config.UseVehicleImages
        })
    end, data.indexgarage, data.type, data.category)
end

function DepositVehicle(veh, data)
    local plate = GetVehicleNumberPlateText(veh)
    TriggerCallback('qb-garages:server:canDeposit', function(canDeposit)
        if canDeposit then--[[ 
            local vehicleData = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            if vehiclesData[vehicleData] then ]]
                local bodyDamage = math.ceil(GetVehicleBodyHealth(veh))
                local engineDamage = math.ceil(GetVehicleEngineHealth(veh))
                local totalFuel = Config.GetFuel(veh)
                local props = GetVehicleProperties(veh)
                --TriggerServerEvent('qb-mechanicjob:server:SaveVehicleProps', GetVehicleProperties(veh))
                TriggerServerEvent('qb-garages:server:updateVehicleStats', plate, totalFuel, engineDamage, bodyDamage, props)
                CheckPlayers(veh)
                if plate then TriggerServerEvent('qb-garages:server:UpdateOutsideVehicle', plate, nil) end
                TriggerServerEvent('qb-garages:addGarageLog:server', {plate = plate, garage = Config.Garages[data.indexgarage].label, type = "Stored"})
                Notify(Lang:t('success.vehicle_parked'), 4500, 'primary')--[[ 
            else
                Notify("You can't park this vehicle to park this add this vehicle to shared/vehicles.lua.", 15000, "error")
            end ]]
        else
            Notify(Lang:t('error.not_owned'), 3500, 'error')
        end
    end, plate, data.type, data.indexgarage, 1)
end

function IsVehicleAllowed(classList, vehicle)
    if not Config.ClassSystem then return true end
    for _, class in ipairs(classList) do
        if GetVehicleClass(vehicle) == class then
            return true
        end
    end
    return false
end

function CreateBlips(setloc)
    local Garage = AddBlipForCoord(setloc.takeVehicle.x, setloc.takeVehicle.y, setloc.takeVehicle.z)
    SetBlipSprite(Garage, setloc.blipNumber)
    SetBlipDisplay(Garage, 4)
    SetBlipScale(Garage, 0.4)
    SetBlipAsShortRange(Garage, true)
    SetBlipColour(Garage, setloc.blipColor)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(setloc.blipName)
    EndTextCommandSetBlipName(Garage)
end

function CreateZone(index, garage, zoneType, job)
    if zoneType == "job" then
        local zone = CircleZone:Create(garage.takeVehicle, 2.0, {
            name = zoneType .. '_' .. index,
            debugPoly = false,
            useZ = true,
            data = {
                indexgarage = index,
                type = garage.type,
                category = garage.category,
                job = job
            }
        })
        return zone
    else
        local zone = CircleZone:Create(garage.takeVehicle, 5.0, {
            name = zoneType .. '_' .. index,
            debugPoly = false,
            useZ = true,
            data = {
                indexgarage = index,
                type = garage.type,
                category = garage.category
            }
        })
        return zone
    end
end

function CreateBlipsZones()
    while CoreReady == false do Citizen.Wait(0) end
    PlayerData = GetPlayerData()
    PlayerGang = PlayerData.gang
    PlayerJob = PlayerData.job
    for index, garage in pairs(Config.Garages) do
        local zone
        if garage.showBlip then
            CreateBlips(garage)
        end
        if garage.type == 'job' then
            zone = CreateZone(index, garage, 'job', garage.job)
        elseif garage.type == 'depot' then
            zone = CreateZone(index, garage, 'depot')
        elseif garage.type == 'public' then
            zone = CreateZone(index, garage, 'public')
        end
        if zone then
            garageZones[#garageZones + 1] = zone
        end
    end
    local comboZone = ComboZone:Create(garageZones, { name = 'garageCombo', debugPoly = false })
    comboZone:onPlayerInOut(function(isPointInside, _, zone)
        if isPointInside then
            if zone.data.job then
                if GetPlayerData().job.name == zone.data.job then
                else
                    return false
                end
            end
            listenForKey = true
            CreateThread(function()
                while listenForKey do
                    Citizen.Wait(0)
                    if IsControlJustReleased(0, 38) then
                        if GetVehiclePedIsUsing(PlayerPedId()) ~= 0 then
                            if zone.data.type == 'depot' then return end
                            local currentVehicle = GetVehiclePedIsUsing(PlayerPedId())
                            if not IsVehicleAllowed(zone.data.category, currentVehicle) then
                                Notify(Lang:t('error.not_correct_type'), 3500, 'error')
                                return
                            end
                            DepositVehicle(currentVehicle, zone.data)
                        else
                            OpenGarageMenu(zone.data)
                        end
                    end
                end
            end)

            local displayText = Lang:t('info.car_e')
            if zone.data.vehicle == 'sea' then
                displayText = Lang:t('info.sea_e')
            elseif zone.data.vehicle == 'air' then
                displayText = Lang:t('info.air_e')
            elseif zone.data.vehicle == 'rig' then
                displayText = Lang:t('info.rig_e')
            elseif zone.data.type == 'depot' then
                displayText = Lang:t('info.depot_e')
            end
            SendNUIMessage({action = "textUI", show = true, text = displayText})
        else
            listenForKey = false
            SendNUIMessage({action = "textUI", show = false})
        end
    end)
end

function doCarDamage(currentVehicle, stats, props)
    local engine = stats.engine + 0.0
    local body = stats.body + 0.0
    SetVehicleEngineHealth(currentVehicle, engine)
    SetVehicleBodyHealth(currentVehicle, body)
    if not next(props) then return end
    if props.doorStatus then
        for k, v in pairs(props.doorStatus) do
            if v then SetVehicleDoorBroken(currentVehicle, tonumber(k), true) end
        end
    end
    if props.tireBurstState then
        for k, v in pairs(props.tireBurstState) do
            if v then SetVehicleTyreBurst(currentVehicle, tonumber(k), true) end
        end
    end
    if props.windowStatus then
        for k, v in pairs(props.windowStatus) do
            if not v then SmashVehicleWindow(currentVehicle, tonumber(k)) end
        end
    end
end

function GetSpawnPoint(garage)
    local location = nil
    if #garage.spawnPoint > 1 then
        local maxTries = #garage.spawnPoint
        for i = 1, maxTries do
            local randomIndex = math.random(1, #garage.spawnPoint)
            local chosenSpawnPoint = garage.spawnPoint[randomIndex]
            local isOccupied = IsPositionOccupied(
                chosenSpawnPoint.x,
                chosenSpawnPoint.y,
                chosenSpawnPoint.z,
                5.0,   -- range
                false,
                true,  -- checkVehicles
                false, -- checkPeds
                false,
                false,
                0,
                false
            )
            if not isOccupied then
                location = chosenSpawnPoint
                break
            end
        end
    elseif #garage.spawnPoint == 1 then
        location = garage.spawnPoint[1]
    end
    if not location then
        Notify(Lang:t('error.vehicle_occupied'), 7500, 'error')
    end
    return location
end

-- Events
RegisterNetEvent('qb-garages:client:trackVehicle', function(coords)
    SetNewWaypoint(coords.x, coords.y)
end)

local function CheckPlate(vehicle, plateToSet)
    local vehiclePlate = promise.new()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if GetVehicleNumberPlateText(vehicle) == plateToSet then
                vehiclePlate:resolve(true)
                return
            else
                SetVehicleNumberPlateText(vehicle, plateToSet)
            end
        end
    end)
    return vehiclePlate
end

RegisterNetEvent('qb-garages:client:takeOutGarage', function(data)
    TriggerCallback('qb-garages:server:IsSpawnOk', function(spawn)
        if spawn then
            local location = GetSpawnPoint(Config.Garages[data.index])
            if not location then return end
            TriggerCallback('qb-garages:server:spawnvehicle', function(netId, properties, vehPlate)
                while not NetworkDoesNetworkIdExist(netId) do Wait(10) end
                local veh = NetworkGetEntityFromNetworkId(netId)
                --Citizen.Await(CheckPlate(veh, vehPlate))
                SetVehicleProperties(veh, properties)
                Config.SetFuel(veh, data.stats.fuel)
                TriggerServerEvent('qb-garages:server:updateVehicleState', 0, vehPlate)
                Config.GiveKey(vehPlate)
                if Config.Warp then TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) end
                if Config.VisuallyDamageCars then doCarDamage(veh, data.stats, properties) end
                SetVehicleEngineOn(veh, true, true, false)
                if data.type == "depot" then
                    TriggerServerEvent('qb-garages:addGarageLog:server', {plate = vehPlate, garage = Config.Garages[data.index].label, type = "Take Depot"})
                else
                    TriggerServerEvent('qb-garages:addGarageLog:server', {plate = vehPlate, garage = Config.Garages[data.index].label, type = "Take Out"})
                end
            end, data.plate, data.vehicle, location, true)
        else
            Notify(Lang:t('error.not_depot'), 5000, 'error')
        end
    end, data.plate, data.type)
end)

-- Housing functions
local houseGarageZones = {}
local listenForKeyHouse = false
local houseComboZones = nil

local function CreateHouseZone(index, garage, zoneType, houseName)
    local houseZone = CircleZone:Create(garage.takeVehicle, 5.0, {
        name = zoneType .. '_' .. index,
        debugPoly = false,
        useZ = true,
        data = {
            indexgarage = index,
            type = zoneType,
            category = garage.category,
            houseName = houseName
        }
    })

    if houseZone then
        houseGarageZones[#houseGarageZones + 1] = houseZone

        if not houseComboZones then
            houseComboZones = ComboZone:Create(houseGarageZones, { name = 'houseComboZones', debugPoly = false })
        else
            houseComboZones:AddZone(houseZone)
        end
    end

    houseComboZones:onPlayerInOut(function(isPointInside, _, zone)
        if isPointInside then
            listenForKeyHouse = true
            CreateThread(function()
                while listenForKeyHouse do
                    Wait(0)
                    if IsControlJustReleased(0, 38) then
                        if GetVehiclePedIsUsing(PlayerPedId()) ~= 0 then
                            local currentVehicle = GetVehiclePedIsUsing(PlayerPedId())
                            DepositVehicle(currentVehicle, zone.data)
                        else
                            OpenGarageMenu(zone.data)
                        end
                    end
                end
            end)
            SendNUIMessage({action = "textUI", show = true, text = Lang:t('info.house_garage')})
        else
            listenForKeyHouse = false
            SendNUIMessage({action = "textUI", show = false})
        end
    end)
end

local function ZoneExists(zoneName)
    for _, zone in ipairs(houseGarageZones) do
        if zone.name == zoneName then
            return true
        end
    end
    return false
end

local function RemoveHouseZone(zoneName)
    local removedZone = houseComboZones:RemoveZone(zoneName)
    if removedZone then
        removedZone:destroy()
    end
    for index, zone in ipairs(houseGarageZones) do
        if zone.name == zoneName then
            table.remove(houseGarageZones, index)
            break
        end
    end
end

RegisterNetEvent('qb-garages:client:setHouseGarage', function(house, hasKey) -- event sent periodically from housing
    if not house then return end
    local formattedHouseName = string.gsub(string.lower(house), ' ', '')
    local zoneName = 'house_' .. formattedHouseName
    if Config.Garages[formattedHouseName] then
        if hasKey and not ZoneExists(zoneName) then
            CreateHouseZone(formattedHouseName, Config.Garages[formattedHouseName], 'house', formattedHouseName)
        elseif not hasKey and ZoneExists(zoneName) then
            RemoveHouseZone(zoneName)
        end
    else
        TriggerCallback('qb-garages:server:getHouseGarage', function(garageInfo) -- create garage if not exist
            local garageCoords = json.decode(garageInfo.garage)
            if garageCoords then
                Config.Garages[formattedHouseName] = {
                    houseName = house,
                    takeVehicle = vector3(garageCoords.x, garageCoords.y, garageCoords.z),
                    spawnPoint = {
                        vector4(garageCoords.x, garageCoords.y, garageCoords.z, garageCoords.w or garageCoords.h)
                    },
                    label = garageInfo.label,
                    type = 'house',
                    category = Config.VehicleClasses['all']
                }
                TriggerServerEvent('qb-garages:server:syncGarage', Config.Garages)
            end
        end, house)
    end
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig', function(houseGarages)
    for _, garageConfig in pairs(houseGarages) do
        local formattedHouseName = string.gsub(string.lower(garageConfig.label), ' ', '')
        if garageConfig.takeVehicle and garageConfig.takeVehicle.x and garageConfig.takeVehicle.y and garageConfig.takeVehicle.z and garageConfig.takeVehicle.w then
            Config.Garages[formattedHouseName] = {
                houseName = string.gsub(string.lower(garageConfig.label), ' '),
                takeVehicle = vector3(garageConfig.takeVehicle.x, garageConfig.takeVehicle.y, garageConfig.takeVehicle.z),
                spawnPoint = {
                    vector4(garageConfig.takeVehicle.x, garageConfig.takeVehicle.y, garageConfig.takeVehicle.z, garageConfig.takeVehicle.w)
                },
                label = garageConfig.label,
                type = 'house',
                category = Config.VehicleClasses['all']
            }
        end
    end
    TriggerServerEvent('qb-garages:server:syncGarage', Config.Garages)
end)

RegisterNetEvent('qb-garages:client:addHouseGarage', function(house, garageInfo) -- event from housing on garage creation
    local formattedHouseName = string.gsub(string.lower(house), ' ', '')
    Config.Garages[formattedHouseName] = {
        houseName = house,
        takeVehicle = vector3(garageInfo.takeVehicle.x, garageInfo.takeVehicle.y, garageInfo.takeVehicle.z),
        spawnPoint = {
            vector4(garageInfo.takeVehicle.x, garageInfo.takeVehicle.y, garageInfo.takeVehicle.z, garageInfo.takeVehicle.w)
        },
        label = garageInfo.label,
        type = 'house',
        category = Config.VehicleClasses['all']
    }
    TriggerServerEvent('qb-garages:server:syncGarage', Config.Garages)
end)

-- NUI Functions
RegisterNUICallback('callback', function(data)
    if data.action == "nuiFocus" then
        SetNuiFocus(false, false)
    elseif data.action == "takeOutVehicle" then
        TriggerEvent('qb-garages:client:takeOutGarage', data.data)
    elseif data.action == "trackVehicle" then
        TriggerServerEvent('qb-garages:server:trackVehicle', data.plate)
    elseif data.action == "takeOutDepo" then
        local depotPrice = data.depotPrice
        if depotPrice ~= 0 then
            TriggerServerEvent('qb-garages:server:PayDepotPrice', data.data)
        else
            TriggerEvent('qb-garages:client:takeOutGarage', data.data)
        end
    end
end)