Table = nil
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.Wait(100)
        if Config.AutoRestoreVehicles then
            if Table == "player_vehicles" then
                MySQL.update('UPDATE player_vehicles SET state = 1 WHERE state = 0', {})
            else
                MySQL.update('UPDATE owned_vehicles SET stored = 1 WHERE stored = 0', {})
            end
        else
            if Table == "player_vehicles" then
                MySQL.update('UPDATE player_vehicles SET depotprice = 500 WHERE state = 0', {})
            else
                MySQL.update('UPDATE owned_vehicles SET pound = 0 WHERE pound = 1', {})
            end
        end
    end
end)

-- Functions
local OutsideVehicles = {}
local vehicleClasses = {
    compacts = 0,
    sedans = 1,
    suvs = 2,
    coupes = 3,
    muscle = 4,
    sportsclassics = 5,
    sports = 6,
    super = 7,
    motorcycles = 8,
    offroad = 9,
    industrial = 10,
    utility = 11,
    vans = 12,
    cycles = 13,
    boats = 14,
    helicopters = 15,
    planes = 16,
    service = 17,
    emergency = 18,
    military = 19,
    commercial = 20,
    trains = 21,
    openwheel = 22,
}

function arrayToSet(array)
    local set = {}
    for _, item in ipairs(array) do
        set[item] = true
    end
    return set
end

function filterVehiclesByCategory(vehicles, category)
    local filtered = {}
    local categorySet = arrayToSet(category)

    for _, vehicle in pairs(vehicles) do
        local vehicleData = vehiclesData[vehicle.vehicle]
        local vehicleCategoryString = vehicleData and vehicleData.category or 'compacts'
        local vehicleCategoryNumber = vehicleClasses[vehicleCategoryString]

        if vehicleCategoryNumber and categorySet[vehicleCategoryNumber] then
            filtered[#filtered + 1] = vehicle
        end
    end

    return filtered
end

CreateCallback('qb-garages:server:getHouseGarage', function(_, cb, house)
    local houseInfo = MySQL.single.await('SELECT * FROM houselocations WHERE name = ?', {house})
    cb(houseInfo)
end)

CreateCallback('qb-garages:server:GetGarageVehicles', function(source, cb, garage, type, category)
    local Player = GetPlayer(source)
    if not Player then return end
    local citizenId = GetPlayerCid(source)
    local vehicles
    if type == 'depot' then
        if Table == "player_vehicles" then
            vehicles = MySQL.rawExecute.await('SELECT * FROM player_vehicles WHERE citizenid = ? AND depotprice > 0', {citizenId})
        else
            vehicles = MySQL.rawExecute.await('SELECT * FROM owned_vehicles WHERE owner = ? AND pound = 1', {citizenId})
        end
    elseif Config.SharedGarages then
        if Table == "player_vehicles" then
            vehicles = MySQL.rawExecute.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {citizenId})
        else
            vehicles = MySQL.rawExecute.await('SELECT * FROM owned_vehicles WHERE owner = ?', {citizenId})
        end
    else
        if Table == "player_vehicles" then
            vehicles = MySQL.rawExecute.await('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ?', {citizenId, garage})
        else
            vehicles = MySQL.rawExecute.await('SELECT * FROM owned_vehicles WHERE owner = ? AND garage = ?', {citizenId, garage})
        end
    end
    if #vehicles == 0 then
        cb(nil)
        return
    end
    if Config.ClassSystem then
        local filteredVehicles = filterVehiclesByCategory(vehicles, category)
        cb(filteredVehicles)
    else
        cb(vehicles)
    end
end)

local vehicleTypes = { -- https://docs.fivem.net/natives/?_0xA273060E
    motorcycles = 'bike',
    boats = 'boat',
    helicopters = 'heli',
    planes = 'plane',
    submarines = 'submarine',
    trailer = 'trailer',
    train = 'train'
}

function GetVehicleTypeByModel(model)
    local vehicleData = vehiclesData[model]
    if not vehicleData then return 'automobile' end
    local category = vehicleData.category
    local vehicleType = vehicleTypes[category]
    return vehicleType or 'automobile'
end

CreateCallback('qb-garages:server:spawnvehicle', function(source, cb, plate, vehicle, coords)
    local vehType = vehiclesData[vehicle] and vehiclesData[vehicle].type or GetVehicleTypeByModel(vehicle)
    local veh = CreateVehicleServerSetter(GetHashKey(vehicle), vehType, coords.x, coords.y, coords.z, coords.w)
    local netId = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleNumberPlateText(veh, plate)
    local vehProps = {}
    if Table == "player_vehicles" then
        result = MySQL.rawExecute.await('SELECT mods FROM player_vehicles WHERE plate = ?', { plate })
    else
        result = MySQL.rawExecute.await('SELECT mods FROM owned_vehicles WHERE plate = ?', { plate })
    end
    if result and result[1] and result[1].mods then
        vehProps = json.decode(result[1].mods) 
    else
        vehProps = {}
    end
    OutsideVehicles[plate] = { netID = netId, entity = veh }
    cb(netId, vehProps, plate)
end)

CreateCallback('qb-garages:server:IsSpawnOk', function(_, cb, plate, type)
    if OutsideVehicles[plate] and DoesEntityExist(OutsideVehicles[plate].entity) then
        cb(false)
        return
    end
    cb(true)
end)

CreateCallback('qb-garages:server:canDeposit', function(source, cb, plate, type, garage, state)
    local Player = GetPlayer(source)
    if Table == "player_vehicles" then
        isOwned = MySQL.scalar.await('SELECT citizenid FROM player_vehicles WHERE plate = ? LIMIT 1', { plate })
    else
        isOwned = MySQL.scalar.await('SELECT owner FROM owned_vehicles WHERE plate = ? LIMIT 1', { plate })
    end
    local citizenId = GetPlayerCid(source)
    if isOwned ~= citizenId then
        cb(false)
        return
    end
    if type == 'house' and not exports['qb-houses']:hasKey(Player.PlayerData.license, citizenId, Config.Garages[garage].houseName) then
        cb(false)
        return
    end
    if state == 1 then
        if Table == "player_vehicles" then
            MySQL.update('UPDATE player_vehicles SET state = ?, garage = ? WHERE plate = ?', { state, garage, plate })
        else
            MySQL.update('UPDATE owned_vehicles SET stored = ?, garage = ? WHERE plate = ?', { state, garage, plate })
        end
        cb(true)
    else
        cb(false)
    end
end)

-- Events
RegisterNetEvent('qb-garages:server:updateVehicleStats', function(plate, fuel, engine, body, vehicleProps)
    local src = source
    local Player = GetPlayer(src)
    if not Player then return end
    local citizenId = GetPlayerCid(src)
    if Table == "player_vehicles" then
        MySQL.update('UPDATE player_vehicles SET fuel = ?, engine = ?, body = ?, mods = ? WHERE plate = ? AND citizenid = ?', { fuel, engine, body, json.encode(vehicleProps), plate, citizenId })
    else
        MySQL.update('UPDATE owned_vehicles SET fuel = ?, engine = ?, body = ?, mods = ? WHERE plate = ? AND owner = ?', { fuel, engine, body, json.encode(vehicleProps), plate, citizenId })
    end
end)

RegisterNetEvent('qb-garages:server:updateVehicleState', function(state, plate)
    local src = source
    local Player = GetPlayer(src)
    if not Player then return end
    local citizenId = GetPlayerCid(src)
    if Table == "player_vehicles" then
        MySQL.update('UPDATE player_vehicles SET state = ?, depotprice = ? WHERE plate = ? AND citizenid = ?', { state, 0, plate, citizenId })
    else
        MySQL.update('UPDATE owned_vehicles SET stored = ?, pound = ? WHERE plate = ? AND owner = ?', { state, 0, plate, citizenId })
    end
end)

RegisterNetEvent('qb-garages:server:UpdateOutsideVehicle', function(plate, vehicleNetID)
    OutsideVehicles[plate] = {
        netID = vehicleNetID,
        entity = NetworkGetEntityFromNetworkId(vehicleNetID)
    }
end)

RegisterNetEvent('qb-garages:server:trackVehicle', function(plate)
    local src = source
    local vehicleData = OutsideVehicles[plate]
    if vehicleData and DoesEntityExist(vehicleData.entity) then
        TriggerClientEvent('qb-garages:client:trackVehicle', src, GetEntityCoords(vehicleData.entity))
        Notify(src, Lang:t('success.vehicle_tracked'), 7500, 'success')
    else
        Notify(src, Lang:t('error.vehicle_not_tracked'), 7500, 'error')
    end
end)

RegisterNetEvent('qb-garages:server:PayDepotPrice', function(data)
    local src = source
    local Player = GetPlayer(src)
    local cashBalance = GetPlayerMoney(src, 'cash')
    local bankBalance = GetPlayerMoney(src, 'bank')
    MySQL.scalar('SELECT depotprice FROM player_vehicles WHERE plate = ?', { data.plate }, function(result)
        if result then
            local depotPrice = result
            if cashBalance >= depotPrice then
                RemoveMoney(src, 'cash', depotPrice, 'paid-depot')
                TriggerClientEvent('qb-garages:client:takeOutGarage', src, data)
            elseif bankBalance >= depotPrice then
                RemoveMoney(src, 'bank', depotPrice, 'paid-depot')
                TriggerClientEvent('qb-garages:client:takeOutGarage', src, data)
            else
                Notify(src, Lang:t('error.not_enough'), 7500, 'error')
            end
        end
    end)
end)

-- House Garages
RegisterNetEvent('qb-garages:server:syncGarage', function(updatedGarages)
    Config.Garages = updatedGarages
end)

-- Log
RegisterNetEvent('qb-garages:addGarageLog:server', function(data)
    local src = source
    local Player = GetPlayer(src)
    local citizenId = GetPlayerCid(src)
    if Table == "player_vehicles" then
        vehicleLogs = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ? AND plate = ?', {citizenId, data.plate})
    else
        vehicleLogs = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {citizenId, data.plate})
    end
    if vehicleLogs[1] then
        local logData = json.decode(vehicleLogs[1].logs)
        local logs = {}
        if next(logData) and next(logData) ~= nil then
            for k, v in pairs(logData) do
                logs[#logs + 1] = {
                    garage = v.garage, 
                    time = v.time, 
                    type = v.type
                }
            end
        end
        logs[#logs + 1] = {
            garage = data.garage, 
            time = os.date("!%Y-%m-%d-%H:%M"), 
            type = data.type
        }
        if Table == "player_vehicles" then
            MySQL.update('UPDATE player_vehicles SET logs = ? WHERE citizenid = ? AND plate = ?', {json.encode(logs), citizenId, data.plate})
        else
            MySQL.update('UPDATE owned_vehicles SET logs = ? WHERE owner = ? AND plate = ?', {json.encode(logs), citizenId, data.plate})
        end
    end
end)

--Call from qb-phone
while CoreReady == false do Citizen.Wait(0) end
if CoreName == "qb-core" or CoreName == "qbx_core" then
    Core.Functions.CreateCallback('qb-garages:server:GetPlayerVehicles', function(source, cb)
        local Player = GetPlayer(source)
        local VehiclesData = {}
        MySQL.rawExecute('SELECT * FROM player_vehicles WHERE citizenid = ?', { Player.PlayerData.citizenid }, function(result)
            if result[1] then
                for _, v in pairs(result) do
                    local VehicleData = vehiclesData[v.vehicle]
                    local VehicleGarage = Lang:t('error.no_garage')
                    if v.garage ~= nil then
                        if Config.Garages[v.garage] ~= nil then
                            VehicleGarage = Config.Garages[v.garage].label
                        else
                            VehicleGarage = Lang:t('info.house')
                        end
                    end
                    local stateTranslation
                    if v.state == 0 then
                        stateTranslation = Lang:t('status.out')
                    elseif v.state == 1 then
                        stateTranslation = Lang:t('status.garaged')
                    elseif v.state == 2 then
                        stateTranslation = Lang:t('status.impound')
                    end
                    local fullname
                    if VehicleData and VehicleData['brand'] then
                        fullname = VehicleData['brand'] .. ' ' .. VehicleData['name']
                    else
                        fullname = VehicleData and VehicleData['name'] or 'Unknown Vehicle'
                    end
                    VehiclesData[#VehiclesData + 1] = {
                        fullname = fullname,
                        brand = VehicleData and VehicleData['brand'] or '',
                        model = VehicleData and VehicleData['name'] or '',
                        plate = v.plate,
                        garage = VehicleGarage,
                        state = stateTranslation,
                        fuel = v.fuel,
                        engine = v.engine,
                        body = v.body
                    }
                end
                cb(VehiclesData)
            else
                cb(nil)
            end
        end)
    end)
end

function getAllGarages()
    local garages = {}
    for k, v in pairs(Config.Garages) do
        garages[#garages + 1] = {
            name = k,
            label = v.label,
            type = v.type,
            takeVehicle = v.takeVehicle,
            putVehicle = v.putVehicle,
            spawnPoint = v.spawnPoint,
            showBlip = v.showBlip,
            blipName = v.blipName,
            blipNumber = v.blipNumber,
            blipColor = v.blipColor,
            vehicle = v.vehicle
        }
    end
    return garages
end

exports('getAllGarages', getAllGarages)

RegisterNetEvent('nc-garage:wasabi:impound', function(plate)
    if Table == "player_vehicles" then
        MySQL.update('UPDATE player_vehicles SET state = 0, depotprice = 500 WHERE plate = ?', {plate})
    else
        MySQL.update('UPDATE owned_vehicles SET stored = 0, depotprice = 500 WHERE plate = ?', {plate})
    end
end)