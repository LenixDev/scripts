----------
Config = {}
Framework = "QBCore" -- (ESX) or (QBCore)
if Framework == "QBCore" then
    Config.CoreName = "qb-core" -- your core name
    FWork = exports[Config.CoreName]:GetCoreObject()
elseif Framework == "ESX" then
    Config.CoreName = "es_extended" -- your core name
    FWork = exports[Config.CoreName]:getSharedObject()
end
----------
Config.Debug = false -- enables debugging
----------
----------
Config.Menu = 'qb-menu' -- (ox_lib) (ps-ui) (qb-menu) or if you are using qb-menu and have chanded the resource name you can put that here and it will work as well
Config.Target = "qb-target" -- (ox_target) (qb-target) or if you are using qb-target and have chanded the resource name you can put that here and it will work as well
Config.Phone = "qb" -- (quasar) (renewed) (lb) (qb) Whatever phone script you are using for email (email function is in client/main.lua and called RepoJobEmail()).
Config.VehilceKeysGivenToPlayerEvent = "vehiclekeys:client:SetOwner" -- Event used to give player keys to vehicle
----------
Config.AutomaticallHookVehicle = true -- Automatically hook the vehicle to the tow truck when it gets close enough while being pulled by the rope
Config.SetVehiclesLocked = true -- Lock the doors of the vehicle being repoed.
Config.WarpPlayerToVehicle = true -- Warp the player to the flatbed truck when it spawns.
Config.ShowMenuWhenFinished = true -- Should they recieve the menu again when finished signing the paper work to quickly start a new job again or not.
----------
----------
Config.DropOffPed = "a_m_m_stlat_02" -- Model of the ped you drop off the repoed vehicle to
Config.RepoVehicleModel = "flatbed3" -- Model of vehicle to use for vehicle repoing
Config.BlipLocation = vector3(-218.36, -1177.11, 23.03) -- Repo job blip locations
----------
Config.BlipSprite = 596 -- Repo job blip icon
Config.BlipColor = 43 -- Repo job blip color
Config.BlipScale = 0.7 -- Repo job blip size
Config.BlipLabel = "Repossession Job" -- Repo job blip text
----------
----------
Config.RepoPedModel = "s_m_y_airworker"
Config.RepoPedLocation = vector4(-218.36, -1177.11, 22.03, 94.09)
----------
Config.CraftingBenchLocation = vector3(-218.40, -1171.35, 20.50)
----------
----------
-- You can add as many or remove as many pay increase thresholds as you like
Config.RepoProgression = { 
    {RepRequired = 0, Multiplier = 1.0}, -- 0 Reputation required for 1.0x pay increase
    {RepRequired = 720, Multiplier = 1.25}, -- 720 Reputation required for 1.20x pay increase
    {RepRequired = 1830, Multiplier = 1.45}, -- 1830 Reputation required for 1.35x pay increase
    {RepRequired = 2540, Multiplier = 1.55} -- 2540 Reputation required for 1.50x pay increase
}
----------
Config.AngryPed1Chance = 15 -- % chance that one angry ped will spawn at the repo vehicle
Config.AngryPed2Chance = 45 -- % chance that a second angry ped will spawn at the repo vehicle (Config.AngryPed2Chance cant have a chance of spawning if Config.AngryPed1Chance doesnt spawn)
----------
Config.RepoTruckDeposit = 700 -- Deposit the player will be charged for borrowing the flat bed truck (player will get the money back when the tuck is put away)
----------
Config.EarnableRepMin = 32 -- Minimum amount of Rep you can earn from each repo
Config.EarnableRepMax = 43 -- Maximum amount of Rep you can earn from each repo
----------
Config.MinimalPay = 345 -- Minimum pay you can earn from each repo
Config.MaximumPay = 825 -- Maximum pay you can earn from each repo
----------
----------
-- Quick translation options
Config.LangT = {
    -- Menu
    ["NoVehicle"] = "(NO VEHICLE)",
    ["TowRemote"] = "| Tow Truck Remote |",
    ["AttachVehicle"] = "Attach vehicle to bed",
    ["UnAttachVehicle"] = "Un Attach Vehicle",
    ["WindHitch"] = "Wind Hitch",
    ["UnWindHitch"] = "Un-Wind Hitch",
    ["Close"] = "(CLOSE)",
    ["PutRemoteAway"] = "(Put Remote Away)",
    ["Max"] = "MAX",
    ["VehicleParts"] = "| Vehicle Parts | ",
    ["XRep"] = "x rep |",
    ["RepoCompany"] = "| Car Repo Company - ",
    ["LevelingSystem"] = "Leveling System | Current tier ",
    ["CurrentPay"] = "Current Pay Rate x",
    ["TotalXPEarned"] = "Total XP Earned ",
    ["NextTier"] = "Next Tier ",
    ["ParkFlatbed"] = "Park flatbed",
    ["GetNewRepoJob"] = "Get a new repo job",
    ["Deposit"] = "$"..Config.RepoTruckDeposit.." Deposit",
    ["RemoveTowHook"] = "Remove Tow Hook",
    -- DrawText
    ["ReturnHook"] = "[E] Return Hook",
    ["GrabHook"] = "[E] Grab Hook",
    ["DropOffVehicle"] = "[E] Drop off vehicle",
    -- Email
    ["EmailSender"] = "Repo Company",
    ["EmailSubject"] = "Repo order: ",
    ["EmailMessage1"] = "Find the ",
    ["EmailMessage2"] = ". The license plate is ",
    -- ProgressBar
    ["SigningPaperWork"] = "Signing the paper work..",
    ["LoweringVehicle"] = "Lowering the vehicle...",
    ["Crafting"] = "Crafting...",
    -- Target
    ["RepoJob"] = "Repo Job",
    ["CraftParts"] = "Craft Parts",
    ["SignRepoPaperwork"] = "Sign Paperwork",
    -- Notifications
    ["NoSpam"] = "you cant spam this job. Must wait 20 seconds everytime you start a run",
    ["TooFarFromTruck"] = "You wondered too far from your tow truck",
    ["AlreadyDoingRun"] = "You are doing a repo run currently",
    ["Canceled"] = "Canceled.",
    ["VehicleLowered"] = "Vehicle Lowered",
    ["VehicleMustBeLowered"] = "Vehicle must be lowered..",
    ["NeedsToBeRaised"] = "Flat bed needs to be raised..",
    ["Failed"] = "Failed",
    ["VehicleRepoed"] = "Vehicle Repoed",
    ["AreaNotClear"] = "Area is not clear",
    ["GetToRepoing"] = "Get To Repoing",
    ["NotLoweredOrRaised"] = "it is not lowered or raised yet",
    ["Missing"] = "You are missing ",
    ["RepoRep"] = " Repo rep",
    ["Wait"] = "Wait...",
    ["NoRecentRequest"] = "There are no recent repo/tow request",
    ["MissingText"] = "you need to type your message",
}
----------
----------
-- Repoed vehicle drop off locations
Config.DropoffPedLocation = {
    [1] = {
        Ped = vector4(-26.97, -1672.7, 29.49, 141.64), -- the ped to third eye location
        Truck = vector4(-29.71, -1681.59, 29.43, 292.05), -- the location you weill need have vehicle
    },
    [2] = {
        Ped = vector4(471.13, -1282.79, 29.54, 280.0),
        Truck = vector4(476.01, -1273.56, 29.65, 359.28),
    },
    [3] = {
        Ped = vector4(-248.58, -1175.87, 22.26, 266.32),
        Truck = vector4(-241.68, -1180.61, 23.03, 144.61),
    },
}
----------
----------
-- Flatbed truck location spawns for when you start the job
Config.FlatBedSpawns = {
    vector4(-213.11, -1182.31, 22.12, 92.65),
}
----------
----------
-- Items you can craft at the crafting bench
Config.CraftingParts = {
    ["engine"] = {
        rep = 720, -- Reputation required to craft this first item
        part1 = {
            part = "metalscrap", -- item 1 required to craft the engine
            amount = 20, -- item 1 amount required to craft the engine
        },
        part2 = {
            part = "plastic", -- item 2 required to craft the engine
            amount = 25, -- item 2 amount required to craft the engine
        },
        part3 = {
            part = "steel", -- item 3 required to craft the engine
            amount = 30, -- item 3 amount required to craft the engine
        },
        part4 = {
            part = "steel", -- item 4 required to craft the engine
            amount = 35, -- item 4 amount required to craft the engine
        }
    },
    ["transmission"] = {
        rep = 1830,
        part1 = {
            part = "metalscrap",
            amount = 20,
        },
        part2 = {
            part = "plastic",
            amount = 25,
        },
        part3 = {
            part = "steel",
            amount = 30,
        },
        part4 = {
            part = "steel",
            amount = 35,
        }
    },
    ["turbo"] = {
        rep = 2540,
        part1 = {
            part = "metalscrap",
            amount = 20,
        },
        part2 = {
            part = "plastic",
            amount = 25,
        },
        part3 = {
            part = "steel",
            amount = 30,
        },
        part4 = {
            part = "steel",
            amount = 35,
        }
    },
}
----------
----------
-- Random angry ped models that can spawn protecting there vehicle thats up for repo
Config.RandomAngryPedModle = {
    "a_m_y_salton_01",
    "a_m_m_genfat_02",
    "a_m_y_beach_01",
    "a_m_m_hasjew_01",
    "a_m_y_business_02",
    "mp_m_waremech_01",
}
----------
----------
-- Random weapon the angry ped models that can spawn protecting there vehicle thats up for repo can have
Config.RandomAngryPedWeapon = {
    "weapon_bat",
    "weapon_hammer",
    "weapon_golfclub",
    "weapon_bottle",
    "weapon_crowbar",
    "weapon_flashlight",
    "weapon_hatchet",
    "weapon_knife",
    "weapon_machete",
    "weapon_switchblade",
    "weapon_nightstick",
    "weapon_wrench",
    "weapon_battleaxe",
    "weapon_poolcue",
    "weapon_snspistol",
}
----------
----------
-- Random vehicles you can get to repo
Config.RandomCarList = {
    "adder",
    "banshee",
    "bullet",
    "carbonizzare",
    "cheetah",
    "coquette",
    "deveste",
    "elegy",
    "entityxf",
    "feltzer2",
    "flashgt",
    "furoregt",
    "fusilade",
    "gb200",
    "hotring",
    "infernus",
    "italigtb",
    "jester",
    "khamelion",
    "komoda",
    "kuruma",
    "locust",
    "lynx",
    "massacro",
    "neon",
    "omnis",
    "paragon",
    "penumbra",
    "raiden",
    "rapidgt",
    "reaper",
    "revolter",
    "ruston",
    "schlagen",
    "seven70",
    "specter",
    "streiter",
    "sultan",
    "surano",
    "t20",
    "tropos",
    "turismo2",
    "voltic",
}
----------
----------
-- 252 random car spawns
Config.RandomCarSpawns = {
    -- South Side
    vector4(166.65, -1928.96, 21.01, 232.07),
    vector4(308.24, -2025.55, 20.4, 320.9),
    vector4(412.46, -2066.09, 20.77, 139.58),
    vector4(550.0, -1929.69, 24.81, 300.71),
    vector4(433.68, -1839.67, 28.05, 227.06),
    vector4(380.24, -1818.31, 29.14, 49.64),
    vector4(275.58, -1935.4, 24.49, 231.29),
    vector4(88.29, -1969.12, 20.05, 320.62),
    vector4(113.03, -1917.69, 20.24, 151.85),
    vector4(41.6, -1921.2, 20.96, 321.46),
    vector4(-60.17, -1842.99, 25.88, 320.67),
    vector4(-89.76, -2009.23, 17.32, 172.86),
    vector4(-57.28, -2107.14, 16.0, 20.54),
    vector4(-151.04, -2209.59, 7.11, 178.62),
    vector4(91.13, -2221.7, 5.34, 0.38),
    vector4(321.45, -2091.01, 16.98, 118.65),
    vector4(495.6, -1968.78, 24.21, 124.94),
    vector4(555.56, -1796.83, 28.5, 351.61),
    vector4(530.67, -1755.14, 28.29, 150.3),
    vector4(458.6, -1696.55, 28.58, 320.15),
    vector4(401.34, -1648.04, 28.59, 320.67),
    vector4(225.18, -1707.86, 28.59, 215.08),
    vector4(194.54, -1698.73, 28.71, 329.05),
    vector4(201.43, -1854.27, 26.5, 138.65),
    vector4(80.33, -2528.78, 5.3, 210.59),
    vector4(116.15, -2579.93, 5.31, 180.21),
    vector4(-199.78, -1714.26, 31.97, 137.05),
    vector4(-20.64, -1677.58, 28.79, 98.98),
    vector4(-27.77, -1495.7, 29.66, 134.59),
    vector4(-257.33, -1546.37, 31.0, 230.46),
    vector4(-34.39, -1427.29, 30.76, 88.66),
    vector4(66.13, -1431.5, 28.61, 139.69),
    vector4(162.21, -1508.51, 28.44, 316.26),
    vector4(234.88, -1510.12, 28.45, 43.62),
    vector4(671.39, -1435.07, 9.03, 14.72),
    vector4(328.51, -1471.78, 29.06, 49.81),
    vector4(32.11, -1580.74, 28.53, 229.56),
    vector4(-218.71, -1635.44, 32.91, 90.84),
    vector4(-352.45, -1493.82, 29.6, 271.19),
    vector4(-182.47, -1260.49, 30.6, 269.26),
    -- Beach Side
    vector4(-1067.77, -1413.89, 4.68, 255.72),
    vector4(-966.8, -1478.01, 4.32, 109.37),
    vector4(-1012.36, -1642.48, 3.66, 231.44),
    vector4(-1042.17, -1594.91, 4.05, 303.21),
    vector4(-1094.13, -1502.74, 4.07, 124.49),
    vector4(-1195.2, -1496.07, 3.68, 125.0),
    vector4(-1171.2, -1739.75, 3.36, 215.9),
    vector4(-1133.1, -1449.0, 4.32, 39.47),
    vector4(-1178.93, -1396.47, 3.98, 303.93),
    vector4(-1204.92, -1331.65, 4.14, 199.75),
    vector4(-1295.13, -1313.84, 3.97, 358.65),
    vector4(-1156.99, -1226.11, 6.03, 201.01),
    vector4(-1074.23, -1245.2, 4.71, 119.0),
    vector4(-1039.3, -1232.92, 5.15, 211.44),
    vector4(-1126.21, -1213.57, 1.74, 29.23),
    vector4(-1161.95, -1164.47, 4.93, 104.39),
    vector4(-1261.53, -1236.04, 4.53, 107.99),
    vector4(-1144.31, -1064.79, 1.45, 210.1),
    vector4(-1091.15, -1055.19, 1.45, 30.07),
    vector4(-866.87, -1123.48, 6.37, 120.77),
    vector4(-822.05, -1197.36, 6.13, 140.39),
    vector4(-915.22, -1161.19, 4.11, 209.26),
    vector4(-827.75, -1064.26, 10.9, 298.69),
    vector4(-763.16, -1022.92, 12.45, 297.49),
    vector4(-829.64, -760.67, 21.33, 91.19),
    vector4(-786.7, -809.53, 19.94, 1.66),
    vector4(-1008.26, -785.34, 15.67, 242.29),
    vector4(-1328.71, -926.01, 10.5, 110.26),
    vector4(-1418.67, -958.65, 6.54, 239.23),
    vector4(-1632.85, -944.58, 7.56, 141.06),
    vector4(-1708.9, -899.41, 7.12, 319.74),
    vector4(-1661.65, -843.84, 8.72, 318.47),
    vector4(-1740.54, -722.0, 9.76, 50.83),
    vector4(-1855.78, -623.49, 10.48, 51.15),
    vector4(-2010.51, -484.35, 10.7, 321.24),
    vector4(-2160.17, -393.0, 12.65, 79.7),
    -- Upper beach side
    vector4(-2175.91, -421.5, 12.53, 186.26),
    vector4(-2095.32, -295.06, 12.35, 82.5),
    vector4(-2064.88, -302.74, 12.45, 175.09),
    vector4(-1810.34, -344.47, 48.43, 50.55),
    vector4(-1802.27, -404.99, 44.05, 143.61),
    vector4(-1686.42, -452.34, 39.9, 231.08),
    vector4(-1577.18, -372.05, 44.68, 265.79),
    vector4(-1566.89, -423.71, 37.18, 49.8),
    vector4(-1475.76, -509.11, 32.11, 214.15),
    vector4(-1520.16, -549.39, 32.48, 215.27),
    vector4(-1515.99, -711.72, 26.84, 0.03),
    vector4(-1408.89, -636.95, 27.97, 33.52),
    vector4(-1442.42, -684.34, 25.61, 213.57),
    vector4(-1268.52, -645.96, 26.2, 127.89),
    vector4(-1228.1, -698.33, 22.38, 306.68),
    vector4(-1136.75, -746.61, 19.04, 285.26),
    vector4(-1022.32, -510.42, 35.94, 294.67),
    vector4(-1085.08, -476.62, 35.92, 28.27),
    vector4(-1087.04, -547.99, 34.39, 25.28),
    vector4(-1113.26, -576.57, 31.13, 298.48),
    vector4(-1247.05, -527.33, 29.48, 219.65),
    vector4(-1274.52, -608.44, 25.79, 220.22),
    vector4(-726.68, -412.13, 34.34, 266.12),
    vector4(-733.66, -282.28, 36.25, 82.65),
    vector4(-579.62, -246.47, 35.16, 28.48),
    vector4(-668.18, -172.1, 36.98, 119.36),
    vector4(-470.38, -57.08, 43.82, 266.37),
    vector4(-551.38, -143.75, 37.5, 57.76),
    -- Lower vinewood
    vector4(-833.07, -36.01, 38.0, 303.3),
    vector4(-890.93, -2.79, 42.74, 209.74),
    vector4(-917.68, 9.95, 47.02, 315.82),
    vector4(-918.78, 105.41, 54.62, 26.37),
    vector4(-790.64, 40.12, 47.72, 249.31),
    vector4(-961.15, 110.24, 55.65, 312.02),
    vector4(-989.15, 144.61, 59.93, 260.81),
    vector4(-951.72, 187.26, 65.89, 79.83),
    vector4(-910.13, 189.5, 68.75, 176.43),
    vector4(-1047.81, 219.36, 63.07, 182.81),
    vector4(-827.7, 175.98, 70.19, 155.37),
    vector4(-835.58, 113.63, 54.55, 171.84),
    vector4(-1130.55, 303.5, 65.53, 172.51),
    vector4(-1061.66, 304.63, 65.28, 350.33),
    vector4(-1014.04, 359.18, 70.0, 159.52),
    vector4(-1376.98, -24.2, 52.61, 175.33),
    vector4(-1390.98, 59.1, 52.9, 306.78),
    vector4(-1433.41, -250.26, 45.67, 133.71),
    vector4(-1575.21, -84.74, 53.44, 273.97),
    vector4(-1580.15, -60.1, 55.79, 271.2),
    vector4(-1524.82, 31.6, 55.87, 260.33),
    vector4(-1557.29, 21.91, 57.97, 167.57),
    vector4(-1613.38, 20.4, 61.48, 334.57),
    vector4(-1685.52, 48.5, 63.35, 162.75),
    vector4(-1660.5, 75.76, 62.69, 349.33),
    vector4(-1887.36, 122.84, 81.0, 308.55),
    vector4(-1934.5, 183.94, 83.87, 310.06),
    -- North rockfard
    vector4(-1954.9, 213.03, 85.39, 206.06),
    vector4(-1880.71, 189.12, 83.18, 125.59),
    vector4(-1908.28, 248.4, 85.55, 31.0),
    vector4(-1974.76, 260.3, 86.52, 287.14),
    vector4(-1924.4, 283.92, 88.37, 9.51),
    vector4(-2001.25, 368.13, 93.78, 180.29),
    vector4(-1937.92, 359.58, 92.86, 158.99),
    vector4(-1915.64, 405.56, 95.6, 96.85),
    vector4(-1954.17, 449.23, 100.37, 187.99),
    vector4(-2003.71, 455.03, 101.87, 277.97),
    vector4(-2007.5, 483.47, 105.77, 256.03),
    vector4(-1987.46, 604.28, 117.29, 74.98),
    vector4(-1942.44, 582.89, 118.18, 249.98),
    vector4(-1889.39, 625.5, 129.3, 314.54),
    vector4(-1816.2, 786.87, 137.13, 39.4),
    vector4(-2580.16, 1929.75, 166.66, 248.05),
    vector4(-2776.3, 1428.95, 100.23, 140.82),
    vector4(-1797.48, 398.27, 112.09, 100.84),
    vector4(-1857.96, 328.77, 87.95, 7.89),
    vector4(-1793.81, 349.22, 87.86, 245.42),
    vector4(-1751.13, 365.2, 88.99, 116.89),
    vector4(-1667.6, 392.13, 88.44, 198.07),
    -- Vinewood
    vector4(-1547.38, 428.17, 108.65, 272.12),
    vector4(-1507.59, 428.0, 110.39, 41.65),
    vector4(-1483.11, 528.94, 117.53, 214.93),
    vector4(-1471.57, 513.56, 117.12, 194.88),
    vector4(-1416.4, 536.88, 121.07, 288.31),
    vector4(-1346.74, 609.64, 133.15, 101.17),
    vector4(-1283.34, 647.55, 138.85, 196.78),
    vector4(-1248.83, 663.74, 141.94, 255.31),
    vector4(-1120.48, 787.54, 162.17, 36.74),
    vector4(-1117.02, 769.46, 162.53, 24.78),
    vector4(-1051.97, 769.26, 166.85, 96.68),
    vector4(-1057.9, 736.92, 164.75, 121.85),
    vector4(-1022.74, 694.13, 160.6, 179.06),
    vector4(-810.98, 705.26, 146.4, 203.07),
    vector4(-763.66, 667.63, 143.3, 117.53),
    vector4(-753.14, 628.9, 141.83, 196.35),
    vector4(-671.62, 645.57, 148.5, 265.16),
    vector4(-668.09, 669.96, 149.73, 249.34),
    vector4(-710.13, 655.95, 154.48, 164.42),
    vector4(-670.57, 753.86, 173.4, 184.55),
    vector4(-581.06, 738.96, 182.88, 232.77),
    vector4(-592.01, 752.99, 183.02, 75.4),
    vector4(-596.31, 805.5, 190.14, 333.01),
    vector4(-661.71, 808.74, 198.84, 182.84),
    vector4(-905.2, 783.66, 185.26, 189.95),
    vector4(-918.28, 803.39, 183.59, 8.7),
    vector4(-955.98, 800.61, 177.2, 8.73),
    vector4(-994.08, 811.05, 171.87, 6.59),
    vector4(-970.01, 766.74, 174.47, 225.71),
    vector4(-1021.84, 811.83, 171.37, 18.99),
    vector4(-148.55, 917.96, 234.96, 227.87),
    vector4(-107.18, 836.8, 234.98, 2.29),
    vector4(-69.22, 897.4, 234.82, 292.72),
    vector4(199.44, 1228.55, 224.76, 103.86),
    vector4(174.32, 484.89, 141.75, 176.23),
    vector4(-77.01, 496.99, 143.72, 353.47),
    vector4(-245.2, 494.46, 125.0, 203.45),
    vector4(-360.77, 513.75, 118.88, 315.12),
    vector4(-410.58, 555.0, 123.06, 333.38),
    vector4(-205.51, 301.4, 96.25, 179.28),
    vector4(-250.51, 292.79, 91.12, 268.1),
    vector4(-209.12, 280.63, 91.62, 162.06),
    vector4(-209.34, 315.08, 96.25, 358.15),
    vector4(-39.71, 211.7, 105.86, 344.79),
    vector4(-35.64, 196.94, 101.28, 161.58),
    -- East cost upper city
    vector4(88.28, 183.96, 103.93, 339.01),
    vector4(57.83, 19.1, 68.68, 338.99),
    vector4(165.17, 29.36, 72.36, 247.43),
    vector4(281.74, 79.51, 99.19, 339.86),
    vector4(254.68, -13.87, 72.96, 249.59),
    vector4(479.59, -43.89, 88.16, 58.82),
    vector4(235.02, -33.19, 69.02, 339.07),
    vector4(109.02, -133.94, 54.05, 247.72),
    vector4(99.63, -206.07, 53.79, 249.67),
    vector4(283.15, -323.8, 44.22, 69.64),
    vector4(385.0, -331.9, 46.16, 246.94),
    vector4(496.55, -90.09, 65.72, 251.54),
    vector4(463.39, 227.07, 102.49, 249.85),
    vector4(428.37, 255.95, 102.51, 69.94),
    vector4(604.83, 121.86, 92.2, 69.09),
    vector4(870.02, -36.24, 78.07, 238.78),
    vector4(944.66, -256.75, 66.75, 325.71),
    vector4(941.25, -248.49, 67.89, 326.21),
    vector4(1257.57, -336.97, 68.38, 353.36),
    vector4(1269.55, -373.27, 68.32, 232.8),
    vector4(1360.49, -601.39, 73.64, 356.86),
    vector4(1360.49, -601.39, 73.64, 356.86),
    vector4(915.22, -625.93, 57.35, 300.71),
    vector4(852.62, -565.14, 57.0, 279.53),
    vector4(943.51, -471.1, 60.56, 212.45),
    vector4(1018.14, -773.63, 57.2, 130.94),
    vector4(852.58, -906.07, 24.59, 90.21),
    vector4(900.19, -1067.61, 32.13, 179.18),
    vector4(907.47, -1733.38, 29.89, 356.03),
    vector4(974.63, -1823.92, 30.44, 353.43),
    vector4(1005.41, -1868.81, 30.19, 354.83),
    vector4(1394.71, -1532.94, 56.81, 222.72),
    vector4(-463.3, 641.89, 143.49, 42.66),
    vector4(-223.54, 594.15, 189.7, 341.21),
    vector4(215.8, 758.12, 203.96, 47.59),
    vector4(-129.09, 1003.08, 235.03, 197.71),
    vector4(-2289.38, 412.66, 173.77, 325.34),
    vector4(-2338.34, 290.52, 168.77, 295.29),
    -- Middle of the city
    vector4(-326.88, -1110.13, 22.26, 161.48),
    vector4(-322.89, -945.74, 30.38, 71.28),
    vector4(-287.51, -1009.68, 29.68, 68.91),
    vector4(-134.81, -1100.53, 20.99, 323.19),
    vector4(-145.56, -1015.09, 26.57, 339.4),
    vector4(-5.9, -1051.76, 37.45, 249.88),
    vector4(325.92, -1160.04, 28.59, 269.33),
    vector4(359.03, -1159.78, 28.59, 87.21),
    vector4(424.8, -1160.77, 28.6, 270.13),
    vector4(492.02, -634.76, 24.2, 260.38),
    vector4(498.79, -584.63, 24.06, 261.68),
    vector4(433.45, -605.6, 27.8, 266.42),
    vector4(384.02, -766.19, 28.6, 181.56),
    vector4(217.88, -768.31, 30.14, 70.25),
    vector4(255.26, -745.92, 30.12, 340.34),
    vector4(357.43, -1115.55, 28.71, 0.17),
    vector4(-466.61, -800.47, 29.84, 89.82),
}

-- Do not touch any of this unless
-- YOU REALLY KNOW WHAT YOU ARE DOING
Config.FrameworkFunctions = {
    -- Client-side trigger callback
    TriggerCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.TriggerCallback(...)
        else
            FWork.TriggerServerCallback(...)
        end
    end,

    -- Server-side register callback
    CreateCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.CreateCallback(...)
        else
            FWork.RegisterServerCallback(...)
        end
    end,

    -- Server-side Get All Players
    GetPlayers = function()
        if Framework == 'QBCore' then
            return FWork.Functions.GetPlayers()
        else
            return FWork.GetPlayers()
        end
    end,
    
    GetIdentifiers = function(source, idtype)
        return GetIdentifiers(source, idtype)
    end,

    GetItemByName = function(source, item, amount) 
        if Framework == 'QBCore' then 
            local player = FWork.Functions.GetPlayer(source)
            return player.Functions.GetItemByName(item, amount)
        else
            local player = FWork.GetPlayerFromId(source)
            return player.getInventoryItem(item)
        end
    end,
    
    -- Server-side get player data
    GetPlayer = function(source,cid,client)
        if Framework == 'QBCore' then
            local self = {}
            local player = nil
            if cid then
                player = FWork.Functions.GetPlayerByCitizenId(source)
            elseif client then
                player = FWork.Functions.GetPlayerData()
            else
                player = FWork.Functions.GetPlayer(source)
            end

            if (player ~= nil) then
                self.source = source
                if client then
                    self.PlayerData = { charinfo = { firstname = player.charinfo.firstname, lastname = player.charinfo.lastname}, citizenid = player.citizenid, money = player.money, metadata = player.metadata }
                else
                    self.PlayerData = { charinfo = { firstname = player.PlayerData.charinfo.firstname, lastname = player.PlayerData.charinfo.lastname, citizenid = player.PlayerData.citizenid}, metadata = player.PlayerData.metadata}
                end
                self.AddMoney = function(currency, amount) 
                    player.Functions.AddMoney(currency, amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.Functions.RemoveMoney(currency, amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.Functions.RemoveItem(item, amount, false)
                end

                self.AddItem = function(item, amount, info) 
                    player.Functions.AddItem(item, amount, false, info)
                end

                self.SetMetaData = function(type, data) 
                    player.Functions.SetMetaData(type,data) -- this is for setting inventory to nothing in qbcore
                end

                return self
            end
        else
            local self = {}
            local player = nil
            if cid then
                player = FWork.GetPlayerFromId(source)
            elseif client then
                player = FWork.GetPlayerData()
            else
                player = FWork.GetPlayerFromId(source)
            end

            if (player ~= nil) then
                self.source = source
                
                self.PlayerData = { charinfo = { firstname = player.get('firstName'), lastname = player.get('lastName')}, citizenid = FWork.GetIdentifier(source)}
                
                self.AddMoney = function(currency, amount) 
                    player.addMoney(amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.removeMoney(amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.removeInventoryItem(item, amount)
                end

                self.AddItem = function(item, amount, info) 
                    player.addInventoryItem(item, amount, false, info)
                end

                return self
            end
        end

        return nil
    end,
}