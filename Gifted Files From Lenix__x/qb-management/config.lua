-- Zones for Menus
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    police = {
        vector3(461.45, -986.2, 30.73),
    },
    --police = {
    --    vector3(-436.28, 6001.23, 31.72),
    --},
    --police = {
    --    vector3(-1112.92, -831.68, 34.36),
    --},
    --sheriff = {
        --vector3(461.45, -986.2, 30.73),
    ambulance = {
        vector3(311.21, -599.36, 43.29),
    },
    cardealer = {
        vector3(-32.94, -1114.64, 26.42),
    },
    mechanic = {
        vector3(-347.59, -133.35, 39.01),
    },
    realestate = {
        vector3(-716.11, 261.21, 84.14),
    },
    burgershot = {
		vector3(-1178.14, -896.43, 13.98),
	},
    beanmachine = {
		vector3(-635.41, 227.11, 82.35),
	},
    catcafe = {
        vector3(-596.26, -1053.52, 21.85),
    },
    popsdiner = {
        vector3(1590.57, 6457.95, 26.01),
    },
	pizzathis = { 
        vector3(796.19, -767.65, 30.77),
    },
}

Config.GangMenus = {
    lostmc = {
        vector3(988.91, -135.53, 74.07),
    },
    ballas = {
        vector3(119.45, -1969.7, 21.33),
    },
    vagos = {
        vector3(340.48, -2015.42, 25.59),
    },
    bloods = {
        vector3(-1566.22, -409.14, 52.22),
    },
    crips = {
        vector3(-326.52, 72.97, 54.03),
    },
    gangleaders = {
        vector3(-60.55, 983.01, 234.58),
    },
    mafia = {
        vector3(-1816.5, 446.44, 128.42),
    },
}
