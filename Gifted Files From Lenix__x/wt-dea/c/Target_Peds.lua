--لا تلعب في شييي

Citizen.CreateThread(function()

    QBCore.Functions.LoadModel(Shorts.ped.model)
    local ped = CreatePed(0, Shorts.ped.model, Shorts.ped.coords.x, Shorts.ped.coords.y, Shorts.ped.coords.z, Shorts.ped.coords.w, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', true)

    -- -- QBCore.Functions.LoadModel(Shorts.ped2.model)
    -- local ped = CreatePed(0, Shorts.ped2.model, Shorts.ped2.coords.x, Shorts.ped2.coords.y, Shorts.ped2.coords.z, Shorts.ped2.coords.w, false, false)
    -- FreezeEntityPosition(ped, true)
    -- SetEntityInvincible(ped, true)
    -- SetBlockingOfNonTemporaryEvents(ped, true)
    -- TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', true)
 
    -- Wait(500)

    exports['qb-target']:AddBoxZone("BedEnter", vector3(2535.3, -398.51, 92.06), 1, 1,
        {
            name = "BedEnter",
            heading = 317,
            debugPoly = false,
            minZ=91.11,
            maxZ=95.11
            }, {
            options = {
            {
                num = 1,
                type = "client",
                event = "DEA:OpenMenu",
                icon = 'fas fa-circle',
                label = 'إخراج مركبة',
                job = 'dea'
            }
        },
     distance = 1.5,
 })
 
 

exports['qb-target']:AddBoxZone("PersonalStash", vector3(2515.77, -339.54, 101.89), 3.2, 1, {
    name = "PersonalStash",
    heading=315,
    debugPoly=false,
    minZ=99.09,
    maxZ=103.09
    }, {
    options = {
    {
        num = 1,
        type = "client",
        event = "WT:DEV:PersonalStash",
        icon = 'fas fa-circle',
        label = 'الخزنة',
        job = 'dea'
    },
    
    },
    distance = 1.5,
})

exports['qb-target']:AddBoxZone("DEACams", vector3(2503.79, -338.24, 101.89), 1, 2.8, {
    name = "DEACams",
    heading=310,
    debugPoly=false,
    minZ=98.89,
    maxZ=102.69
    }, {
    options = {
    {
        num = 1,
        type = "client",
        event = "WTMenuCams",
        icon = 'fas fa-circle',
        label = 'كاميرات المدينة',
        job = 'dea'
    }
    },
    distance = 1.5,
})

exports['qb-target']:AddBoxZone("new Data", vector3(2484.4, -357.43, 82.69), 2.6, 1, {
    name = "new Data",
    heading=255,
    debugPoly=false,
    minZ=79.69,
    maxZ=83.69
    }, {
    options = {
    {
        num = 1,
        type = "client",
        event = "WT:DEV:Data",
        icon = 'fas fa-circle',
        label = 'طبع هوية',
        job = 'dea'
    }
    },
    distance = 1.5,
})

exports['qb-target']:AddBoxZone("armory", vector3(2526.63, -343.2, 101.89), 1.4, 1, {
    name = "armory",
    heading=136,
    debugPoly=false,
    minZ=99.89,
    maxZ=103.89
    }, {
    options = {
    {
        num = 1,
        type = "client",
        event = "wt-dea:DEAArmory",
        icon = 'fas fa-circle',
        label = 'خزنة العتاد',
        job = 'dea'
    }
    },
    distance = 1.5,
})

exports['qb-target']:AddBoxZone("DEASignInout", vector3(2503.95, -424.62, 94.58), 2, 1, {
    name = "DEASignInout",
    heading=45,
    debugPoly=false,
    minZ=91.18,
    maxZ=95.18
    }, {
    options = {
    {
        num = 1,
        type = "client",
        event = "Tkae:OnDuty",
        icon = 'fas fa-circle',
        label = 'تسجيل دخول/خروج',
        job = 'dea'
    }
    },
    distance = 1.5,
})

end)




