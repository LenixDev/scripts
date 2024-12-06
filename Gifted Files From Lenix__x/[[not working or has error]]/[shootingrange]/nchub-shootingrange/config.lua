Config = {}

Config.CaseItemName = "shootingtoken"
Config.TargetCoord = vector3(821.59, -2163.83, 29.66)

Config.StartPrice = 300

Config.ModeMenu = {
    [1] = {
        Label = 'Easy',
        Timer = 30 * 1000,
        Point = 20,
        Token = 'No',
    },
    [2] = {
        Label = 'Normal',
        Timer = 20 * 1000,
        Point = 5,
        Token = 'Yes',
    },
    [3] = {
        Label = 'Hard',
        Timer = 10 * 1000,
        Point = 12,
        Token = 'Yes',
    },
}

Config.Weapon = {
    [1] = {
        Label = 'Pistol',
        Items = {
            [1] = 'weapon_glock',
            [2] = 'weapon_appistol',
            [3] = 'weapon_pistol50',
            [4] = 'weapon_snspistol',
            [5] = 'weapon_heavypistol',
            [6] = 'weapon_vintagepistol',
            [7] = 'weapon_ceramicpistol',
        },
    },
    [2] = {
        Label = 'SMG',
        Items = {
            [1] = 'weapon_microsmg',
            [2] = 'weapon_smg',
            [3] = 'weapon_machinepistol',
            [4] = 'weapon_minismg',
        },
    },
    [3] = {
        Label = 'Rifle',
        Items = {
            [1] = 'weapon_carbinerifle',
            [2] = 'weapon_carbinerifle',
            [3] = 'weapon_bullpuprifle',
            [4] = 'weapon_compactrifle',
            [5] = 'weapon_militaryrifle',
        },
    },
}

Config.OpeningCaseTimer = 5 * 1000

Config.CaseLoot = {
    'weapon_knife',
    'wweapon_bat',
    'weapon_switchblade',
    'weapon_machete',
    'weapon_glock',
}

Config.PlayerShooting = vector3(821.47, -2163.65, 29.65)
Config.PlayerHeading = 182.93

Config.SpawnPedName = "ig_orleans"
Config.PedHeading = 1.31
Config.PedCoords = {
    vector3(826.27, -2189.35, 29.62),
    vector3(824.77, -2189.38, 29.62),
    vector3(822.72, -2189.42, 29.62),
    vector3(820.72, -2189.45, 29.62),
    vector3(818.87, -2189.48, 29.62),
    vector3(816.62, -2189.52, 29.62),
    vector3(816.5, -2185.46, 29.62),
    vector3(818.45, -2185.34, 29.62),
    vector3(820.4, -2185.3, 29.62),
    vector3(822.25, -2185.35, 29.62),
    vector3(824.45, -2185.41, 29.62),
    vector3(826.35, -2185.46, 29.62),
    vector3(826.16, -2181.39, 29.62),
    vector3(824.62, -2181.39, 29.62),
    vector3(822.37, -2181.43, 29.62),
    vector3(820.72, -2181.46, 29.62),
    vector3(818.53, -2181.44, 29.62),
    vector3(816.43, -2181.38, 29.62),
    vector3(816.43, -2177.21, 29.62),
    vector3(818.28, -2177.32, 29.62),
    vector3(820.31, -2177.27, 29.62),
    vector3(822.32, -2177.26, 29.62),
    vector3(824.15, -2177.17, 29.62),
    vector3(826.55, -2177.23, 29.62),
    vector3(826.37, -2173.37, 29.62),
    vector3(824.74, -2173.35, 29.62),
    vector3(822.74, -2173.39, 29.62),
    vector3(820.69, -2173.43, 29.62),
    vector3(818.79, -2173.46, 29.62),
    vector3(816.56, -2173.36, 29.62),
}
