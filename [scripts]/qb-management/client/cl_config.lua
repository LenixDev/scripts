-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.45, -986.2, 30.73),
    },
    ['ambulance'] = {
        vector3(335.46, -594.52, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(-339.53, -156.44, 44.59),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.56, -986.41, 30.73), length = 1.0, width = 1.0, heading = 0.0, minZ = 27.33, maxZ = 31.33 } ,
    },
    ['ambulance'] = {
        { coords = vector3(335.46, -594.52, 43.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0,0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },
}

Config.GangMenuZones = {
    ['families'] = {
        { coords = vector3(-164.97, -1616.72, 33.65), length = 0.4, width = 0.6, heading = 356, minZ = 33.25, maxZ = 33.85 },
    },
    ['vagos'] = {
        { coords = vector3(337.72, -1980.65, 24.21), length = 0.4, width = 0.6, heading = 321, minZ = 23.81, maxZ = 24.41 },
    },
    ['lostmc'] = {
        { coords = vector3(988.86, -135.7, 74.07), length = 0.4, width = 0.6, heading = 241, minZ = 73.67, maxZ = 74.27 },
    },
    ['ballas'] = {
        { coords = vector3(0.85, -1809.82, 29.15), length = 0.4, width = 0.4, heading = 0, minZ = 28.75, maxZ = 29.35 },
    },
    ['marabunta'] = {
        { coords = vector3(1247.88, -1582.13, 58.35), length = 0.4, width = 0.4, heading = 346, minZ = 57.95, maxZ = 58.55 },
    },
    ['aztecaz'] = {
        { coords = vector3(484.52, -1536.02, 29.29), length = 0.4, width = 0.4, heading = 325, minZ = 28.89, maxZ = 29.49 },
    },
}
