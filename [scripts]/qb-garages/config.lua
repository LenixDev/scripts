Config = {}
Config.AutoRespawn = true          -- true == stores cars in garage on restart | false == doesnt modify car states
Config.VisuallyDamageCars = true   -- true == damage car on spawn | false == no damage on spawn
Config.SharedGarages = false       -- true == take any car from any garage | false == only take car from garage stored in
Config.ClassSystem = false         -- true == restrict vehicles by class | false == any vehicle class in any garage
Config.FuelResource = 'cdn-fuel' -- supports any that has a GetFuel() and SetFuel() export
Config.Warp = false                 -- true == warp player into vehicle | false == vehicle spawns without warping

-- https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.VehicleClass = {
    all = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22 },
    car = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 18, 22 },
    air = { 15, 16 },
    sea = { 14 },
    rig = { 10, 11, 17, 19, 20 }
}

Config.Garages = {
    motelgarage = {
        label = '7021 بالقرب من',
        takeVehicle = vector3(274.29, -334.15, 44.92),
        spawnPoint = {
            vector4(265.96, -332.3, 44.51, 250.68)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public', -- public, gang, job, depot
        category = Config.VehicleClass['car']
    },
    casinogarage = {
        label = '6047 بالقرب من',
        takeVehicle = vector3(883.96, -4.71, 78.76),
        spawnPoint = {
            vector4(895.39, -4.75, 78.35, 146.85)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    sapcounsel = {
        label = '3201 بالقرب من',
        takeVehicle = vector3(-330.01, -780.33, 33.96),
        spawnPoint = {
            vector4(-341.57, -767.45, 33.56, 92.61)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    spanishave = {
        label = '5012 بالقرب من',
        takeVehicle = vector3(-1160.86, -741.41, 19.63),
        spawnPoint = {
            vector4(-1145.2, -745.42, 19.26, 108.22)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    caears24 = {
        label = '7018 بالقرب من',
        takeVehicle = vector3(69.84, 12.6, 68.96),
        spawnPoint = {
            vector4(60.8, 17.54, 68.82, 339.7)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    caears242 = {
        label = '5038 بالقرب من',
        takeVehicle = vector3(-453.7, -786.78, 30.56),
        spawnPoint = {
            vector4(-472.39, -787.71, 30.14, 180.52)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    lagunapi = {
        label = '7016 بالقرب من',
        takeVehicle = vector3(364.37, 297.83, 103.49),
        spawnPoint = {
            vector4(375.09, 294.66, 102.86, 164.04)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    airportp = {
        label = '2017 بالقرب من',
        takeVehicle = vector3(-773.12, -2033.04, 8.88),
        spawnPoint = {
            vector4(-779.77, -2040.18, 8.47, 315.34)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    beachp = {
        label = '5033 بالقرب من',
        takeVehicle = vector3(-1185.32, -1500.64, 4.38),
        spawnPoint = {
            vector4(-1188.14, -1487.95, 3.97, 124.06)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    themotorhotel = {
        label = '706 بالقرب من',
        takeVehicle = vector3(1137.77, 2663.54, 37.9),
        spawnPoint = {
            vector4(1127.7, 2647.84, 37.58, 1.41)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    liqourparking = {
        label = '855 بالقرب من',
        takeVehicle = vector3(883.99, 3649.67, 32.87),
        spawnPoint = {
            vector4(898.38, 3649.41, 32.36, 90.75)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    shoreparking = {
        label = '834 بالقرب من',
        takeVehicle = vector3(1737.03, 3718.88, 34.05),
        spawnPoint = {
            vector4(1725.4, 3716.78, 34.15, 20.54)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    haanparking = {
        label = '908 بالقرب من',
        takeVehicle = vector3(76.88, 6397.3, 31.23),
        spawnPoint = {
            vector4(62.15, 6403.41, 30.81, 211.38)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    dumbogarage = {
        label = '3604 بالقرب من',
        takeVehicle = vector3(165.75, -3227.2, 5.89),
        spawnPoint = {
            vector4(168.34, -3236.1, 5.43, 272.05)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    pillboxgarage = {
        label = '3210 بالقرب من',
        takeVehicle = vector3(213.2, -796.05, 30.86),
        spawnPoint = {
            vector4(222.02, -804.19, 30.26, 248.19),
            vector4(223.93, -799.11, 30.25, 248.53),
            vector4(226.46, -794.33, 30.24, 248.29),
            vector4(232.33, -807.97, 30.02, 69.17),
            vector4(234.42, -802.76, 30.04, 67.2)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    grapeseedgarage = {
        label = '891 بالقرب من',
        takeVehicle = vector3(2552.68, 4671.8, 33.95),
        spawnPoint = {
            vector4(2550.17, 4681.96, 33.81, 17.05)
        },
        showBlip = true,
        blipName = 'Public Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['car']
    },
    depotLot = {
        label = 'الحجز',
        takeVehicle = vector3(-191.72, -1163.32, 23.67),
        spawnPoint = {
            vector4(-183.78, -1174.46, 22.72, 200.32),
            vector4(-187.58, -1174.24, 22.72, 200.72),
            vector4(-191.0, -1174.47, 22.72, 201.31),
            vector4(-194.52, -1174.27, 22.72, 202.54),
            vector4(-197.85, -1174.89, 22.72, 200.93)
        },
        showBlip = true,
        blipName = 'Depot Lot',
        blipNumber = 68,
        blipColor = 0,
        type = 'depot',
        category = Config.VehicleClass['car']
    },
    bloods = {
        label = 'قراج البلودز',
        takeVehicle = vector3(-1565.66, -387.78, 41.98),
        spawnPoint = {
            vector4(-1568.63, -391.79, 41.58, 50.52),
            vector4(-1566.96, -389.0, 41.58, 50.05),
            vector4(-1564.49, -386.83, 41.58, 49.82),
            vector4(-1562.58, -383.94, 41.58, 50.81),
        },
        showBlip = false,
        blipName = 'Bloods',
        blipNumber = 357,
        blipColor = 0,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'bloods',
        jobType = 'bloods'
    },
    ballas = {
        label = 'قراج البلس',
        takeVehicle = vector3(87.51, -1969.1, 20.75),
        spawnPoint = {
            vector4(93.78, -1961.73, 20.34, 319.11)
        },
        showBlip = false,
        blipName = 'Ballas',
        blipNumber = 357,
        blipColor = 0,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'ballas',
        jobType = 'ballas'
    },
    families = {
        label = 'قراج الفاميلية',
        takeVehicle = vector3(-23.89, -1436.03, 30.65),
        spawnPoint = {
            vector4(-25.47, -1445.76, 30.24, 178.5)
        },
        showBlip = false,
        blipName = 'Families',
        blipNumber = 357,
        blipColor = 0,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'families',
        jobType = 'families'
    },
    lostmc = {
        label = 'قراج ذا لوست ام سي',
        takeVehicle = vector3(985.83, -138.14, 73.09),
        spawnPoint = {
            vector4(977.65, -133.02, 73.34, 59.39)
        },
        showBlip = false,
        blipName = 'Lost MC',
        blipNumber = 357,
        blipColor = 0,
        type = 'gang',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'lostmc',
        jobType = 'lostmc'
    },
    cartel = {
        label = 'قراج كارتال',
        takeVehicle = vector3(1411.67, 1117.8, 114.84),
        spawnPoint = {
            vector4(1403.01, 1118.25, 114.84, 88.69)
        },
        showBlip = false,
        blipName = 'Cartel',
        blipNumber = 357,
        blipColor = 0,
        type = 'gang',
        category = Config.VehicleClass['car'],
        job = 'cartel',
        jobType = 'cartel'
    },
    police = {
        label = 'Police Garage',
        takeVehicle = vector3(429.35, -993.27, 21.34),
        spawnPoint = {
            vector4(435.18, -991.47, 21.15, 179.46),
            vector4(431.91, -991.24, 21.14, 180.39),
            vector4(426.69, -991.4, 21.14, 179.46),
            vector4(423.59, -991.49, 21.14, 179.42),
        },
        showBlip = false,
        blipName = 'Police',
        blipNumber = 357,
        blipColor = 0,
        type = 'job',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'police',
        jobType = 'leo'
    },
    police2 = {
        label = 'Police Garage',
        takeVehicle = vector3(-448.15, 5994.5, 31.1),
        spawnPoint = {
            vector4(-448.15, 5994.5, 31.15, 265.16),
            vector4(-451.18, 5998.39, 31.15, 267.5),
            vector4(-454.97, 6001.91, 31.15, 267.07),
        },
        showBlip = false,
        blipName = 'Police',
        blipNumber = 357,
        blipColor = 0,
        type = 'job',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'police',
        jobType = 'leo'
    },
    police3 = {
        label = 'Police Garage',
        takeVehicle = vector3(1864.88, 3695.49, 33.74),
        spawnPoint = {
            vector4(1879.1, 3690.3, 33.35, 210.65),
            vector4(1882.23, 3691.52, 33.35, 208.08),
            vector4(1871.22, 3704.02, 33.35, 28.12),
            vector4(1871.22, 3704.02, 33.35, 28.12),
        },
        showBlip = false,
        blipName = 'Police',
        blipNumber = 357,
        blipColor = 0,
        type = 'job',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'police',
        jobType = 'leo'
    },
--[[     police3 = {
        label = 'Police Garage',
        takeVehicle = vector3(1864.88, 3695.49, 33.74),
        spawnPoint = {
            vector4(1867.45, 3690.52, 33.55, 299.41),
            vector4(1865.31, 3692.95, 33.56, 301.04),
            vector4(1863.86, 3697.19, 33.55, 297.8),
            vector4(1861.76, 3700.63, 33.55, 299.36),
        },
        showBlip = false,
        blipName = 'Police',
        blipNumber = 357,
        blipColor = 0,
        type = 'job',
        category = Config.VehicleClass['car'], --car, air, sea, rig
        job = 'police',
        jobType = 'leo'
    }, ]]
    intairport = {
        label = '2011 بالقرب من',
        takeVehicle = vector3(-979.06, -2995.48, 13.95),
        spawnPoint = {
            vector4(-998.37, -2985.01, 13.95, 61.09)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    higginsheli = {
        label = '5010 بالقرب من',
        takeVehicle = vector3(-722.15, -1472.79, 5.0),
        spawnPoint = {
            vector4(-745.22, -1468.72, 5.39, 319.84),
            vector4(-724.36, -1443.61, 5.39, 135.78)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    airsshores = {
        label = '802 بالقرب من',
        takeVehicle = vector3(1737.89, 3288.13, 41.14),
        spawnPoint = {
            vector4(1742.83, 3266.83, 41.24, 102.64)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    airzancudo = {
        label = 'المطار 719',
        takeVehicle = vector3(-1828.25, 2975.44, 32.81),
        spawnPoint = {
            vector4(-1828.25, 2975.44, 32.81, 57.24)
        },
        showBlip = true,
        blipName = 'Hangar',
        blipNumber = 360,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['air']
    },
    airdepot = {
        label = '2011 بالقرب من',
        takeVehicle = vector3(-1270.01, -3377.53, 14.33),
        spawnPoint = {
            vector4(-1270.01, -3377.53, 14.33, 329.25)
        },
        showBlip = true,
        blipName = 'Air Depot',
        blipNumber = 359,
        blipColor = 0,
        type = 'depot',
        category = Config.VehicleClass['air']
    },
    lsymc = {
        label = '872 بالقرب من',
        takeVehicle = vector3(-785.95, -1497.84, -0.09),
        spawnPoint = {
            vector4(-796.64, -1502.6, -0.09, 111.49)
        },
        showBlip = true,
        blipName = 'Boathouse',
        blipNumber = 356,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['sea']
    },
    paleto = {
        label = '951 بالقرب من',
        takeVehicle = vector3(-278.21, 6638.13, 7.55),
        spawnPoint = {
            vector4(-289.2, 6637.96, 1.01, 45.5)
        },
        showBlip = true,
        blipName = 'Boathouse',
        blipNumber = 356,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['sea']
    },
    millars = {
        label = '5010 بالقرب من',
        takeVehicle = vector3(1298.56, 4212.42, 33.25),
        spawnPoint = {
            vector4(1297.82, 4209.61, 30.12, 253.5)
        },
        showBlip = true,
        blipName = 'Boathouse',
        blipNumber = 356,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['sea']
    },
    seadepot = {
        label = '5010 بالقرب من',
        takeVehicle = vector3(-742.95, -1407.58, 5.5),
        spawnPoint = {
            vector4(-729.77, -1355.49, 1.19, 142.5)
        },
        showBlip = true,
        blipName = 'LSYMC Depot',
        blipNumber = 356,
        blipColor = 0,
        type = 'depot',
        category = Config.VehicleClass['sea']
    },
    rigdepot = {
        label = '703 بالقرب من',
        takeVehicle = vector3(2334.42, 3118.62, 48.2),
        spawnPoint = {
            vector4(2324.57, 3117.79, 48.21, 4.05)
        },
        showBlip = true,
        blipName = 'Big Rig Depot',
        blipNumber = 68,
        blipColor = 0,
        type = 'depot',
        category = Config.VehicleClass['rig']
    },
    dumborigparking = {
        label = '3605 بالقرب من',
        takeVehicle = vector3(161.23, -3188.73, 5.97),
        spawnPoint = {
            vector4(167.0, -3203.89, 5.94, 271.27)
        },
        showBlip = true,
        blipName = 'Big Rig Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    popsrigparking = {
        label = '905 بالقرب من',
        takeVehicle = vector3(137.67, 6632.99, 31.67),
        spawnPoint = {
            vector4(127.69, 6605.84, 31.93, 223.67)
        },
        showBlip = true,
        blipName = 'Big Rig Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    ronsrigparking = {
        label = '719 بالقرب من',
        takeVehicle = vector3(-2529.37, 2342.67, 33.06),
        spawnPoint = {
            vector4(-2521.61, 2326.45, 33.13, 88.7)
        },
        showBlip = true,
        blipName = 'Big Rig Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    ronsrigparking2 = {
        label = '701 بالقرب من',
        takeVehicle = vector3(2561.67, 476.68, 108.49),
        spawnPoint = {
            vector4(2561.67, 476.68, 108.49, 177.86)
        },
        showBlip = true,
        blipName = 'Big Rig Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
    ronsrigparking3 = {
        label = '3600 بالقرب من',
        takeVehicle = vector3(-41.24, -2550.63, 6.01),
        spawnPoint = {
            vector4(-39.39, -2527.81, 6.08, 326.18)
        },
        showBlip = true,
        blipName = 'Big Rig Parking',
        blipNumber = 357,
        blipColor = 0,
        type = 'public',
        category = Config.VehicleClass['rig']
    },
}
