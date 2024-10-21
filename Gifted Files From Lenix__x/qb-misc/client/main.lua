
QBCore = exports['qb-core']:GetCoreObject()

PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(100)
    PlayerData = QBCore.Functions.GetPlayerData()
end)

local isInBanner = false
local Shape = {
    [1] = {
        Shape = {
            vector2(-268.68176269531, -1005.9235229492),
            vector2(-295.92224121094, -995.76782226562),
            vector2(-297.27105712891, -999.06378173828),
            vector2(-341.66787719727, -982.81646728516),
            vector2(-354.80426025391, -1019.165222168),
            vector2(-318.05517578125, -1030.8612060547),
            vector2(-317.65948486328, -1029.2030029297),
            vector2(-308.05722045898, -1032.4669189453),
            vector2(-305.69100952148, -1025.3110351562),
            vector2(-279.04388427734, -1034.8322753906)
        },
        minZ = 28.249324798584,
        maxZ = 35.514898300171
    }
}

-- CreateThread(function()
--     local zone = PolyZone:Create(Shape[1].Shape, {
--         name= 'bannershitty',
--         debugPoly = false,
--         minZ = Shape[1].minZ,
--         maxZ = Shape[1].maxZ
--     })
    
--     zone:onPlayerInOut(function(isPointInside)
--         if isPointInside then
--             local ped = PlayerPedId()
--             local curVeh = GetVehiclePedIsIn(ped)
--             local driver = (GetPedInVehicleSeat(curVeh,-1) == ped) 
--             if driver then 
--                 TriggerServerEvent('banner:server:AddVehToPlayersTable', NetworkGetNetworkIdFromEntity(curVeh))
--             end
--         else
--             local ped = PlayerPedId()
--             local curVeh = GetVehiclePedIsIn(ped)
--             local driver = (GetPedInVehicleSeat(curVeh,-1) == ped) 
--             if driver then 
--                 TriggerServerEvent('banner:server:RemoveVehToPlayersTable', NetworkGetNetworkIdFromEntity(curVeh))
--             end
--         end
--     end)
-- end)

local isFlaged = false
local cheaterhook = 'https://canary.discord.com/api/webhooks/1065529730792697866/tBP7TANHKJUZhhU_vuaRPhNhm-UqcROsf_VDQ6ljI0R6lNkIg38vOD6rFGpbgWSNAmgj'
local SheSheKeys = {
    ['INSERT'] = {key = 121, name = 'INSERT'},
}
local SheSheKeys1 = {
    ['F8'] = {key = 169, name = 'F8'},
    ['LEFTALT'] = {key = 19, name = 'LEFTALT'},
}

local function TakeSheSHe(key)
    exports['screenshot-basic']:requestScreenshotUpload(tostring(cheaterhook), "files[]", function()
        isFlaged = false
        TriggerServerEvent('sheshe:server', key)
    end)
end

CreateThread(function()
    while true do
        Wait(5)
        if IsControlPressed(1, SheSheKeys['INSERT'].key) then
            if not isFlaged then 
                isFlaged = true 
                TakeSheSHe('INSERT')
            end
        end
        if IsControlPressed(1, SheSheKeys1['LEFTALT'].key) and IsDisabledControlJustReleased(0, SheSheKeys1['F8'].key) then
            if not isFlaged then 
                isFlaged = true 
                TakeSheSHe('LEFTALT and F8')
            end
        end
    end
end)