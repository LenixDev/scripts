local QBCore = exports['qb-core']:GetCoreObject()

-- تحديد موقع المخزن
local storageLocation = vector3(-112.94, 985.91, 235.75)

-- قائمة العتاد
local items = {
    { name = "weapon_pistol_mk2", label = "Pistol MK2", amount = 1 },
    { name = "handcuufs", label = "كلبشة", amount = 10 },
    { name = "armor", label = "درع", amount = 10 },
    { name = "pistol_ammo", label = "رصاص خفيف", amount = 10 },
}

-- عرض المخزن عند التفاعل مع النقطة
Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("lootgenerator", storageLocation, 1.0, 1.0, {
        name = "lootgenerator",
        heading = 0,
        debugPoly = false,
        minZ = storageLocation.z - 1,
        maxZ = storageLocation.z + 1
    }, {
        options = {
            {
                type = "client",
                event = "lootgenerator:open",
                icon = "fas fa-box",
                label = "فتح المخزن",
            },
        },
        distance = 2.5
    })
end)

-- فتح المخزن عند تفعيل الحدث
RegisterNetEvent('lootgenerator:open', function()
    local menu = {}
    for _, item in ipairs(items) do
        table.insert(menu, {
            header = item.label,
            txt = "كمية: " .. item.amount,
            params = {
                event = 'lootgenerator:takeItem',
                args = {
                    item = item.name,
                    amount = item.amount
                }
            }
        })
    end
    exports['qb-menu']:openMenu(menu)
end)

-- أخذ العنصر من المخزن
RegisterNetEvent('lootgenerator:takeItem', function(data)
    TriggerServerEvent('lootgenerator:addItem', data.item, data.amount)
end)