local QBCore = exports['qb-core']:GetCoreObject()
local bones = {'bonnet', 'boot'}


RegisterNetEvent('impound:client:OpenImpoundMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "حجز المركبة",
            txt = " ركن المركبة في مكان محظور أو غير مصرح به",
            params = {
                event = "impound:client:ParkingViolation",
            }
        },
        {
            header = "حجز شرطة",
            txt = "حجز المركبة الي مستودع الشرطة",
            params = {
                event = "police:client:ImpoundVehicle",
            }
        },
    })
end)

RegisterNetEvent('impound:client:VehicleScuff', function()
    QBCore.Functions.Progressbar("random_task", "Requesting Impound...", 7000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
     }, {
     }, {}, {}, function() -- Done
        TriggerServerEvent("impound:server:VehicS")
        QBCore.Functions.Notify("تم الحجز بنجاح", "success")
     end, function() -- Cancel
     end)
end)

RegisterNetEvent('impound:client:ParkingViolation', function()
    QBCore.Functions.Progressbar("random_task", "Requesting Impound...", 7000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
     }, {
     }, {}, {}, function() -- Done
        TriggerServerEvent("impound:server:ParkingVio")
     end, function() -- Cancel
     end)
end)

RegisterNetEvent('impound:client:PDImpound', function()
    TriggerServerEvent("impound:server:PDIm")
    QBCore.Functions.Notify("تم الحجز بنجاح", "success")
end)
