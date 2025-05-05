Config = {
    Framework = "qb", -- "esx" or "qb"
    Locale = "en", -- Locale of the script
    DebugStreet = false, -- Debug street name

    JobRequirement = false,
    Job = "busdriver",
    SpamProtectionTime = 2000, -- Time between opening menu (in milliseconds)
    Menu = vector3(468.8964, -577.0377, 29.4997), -- Coords of the menu
    Vehicle = "bus", -- Vehicle model name (https://wiki.gtanet.work/index.php?title=Vehicle_Models)
    TimeToGetInVehicle = 30, -- Time to get in the vehicle (in seconds)
    CrashFine = 100, -- Fine for crashing

    NPC = {
        hash = "a_m_y_business_02", -- Hash of the NPC (https://wiki.gtanet.work/index.php?title=Peds)
        coords = vector3(468.8964, -577.0377, 28.4997), -- Coords of the NPC
        heading = 172.1323, -- Heading of the NPC

        blip = {
            sprite = 513, -- Blip sprite (https://docs.fivem.net/docs/game-references/blips/)
            color = 4, -- Blip color
            scale = 0.6, -- Blip scale
            name = "Bus Driver Job", -- Blip name
        }
    },

    PassengerPeds = { -- Peds that will be spawned as passengers
        "a_f_m_bevhills_01",
        "a_f_m_bevhills_02",
        "a_f_m_business_02",
        "a_f_m_downtown_01",
        "a_f_m_eastsa_01",
        "a_f_m_eastsa_02",
        "a_f_m_ktown_01",
        "a_f_m_ktown_02",
        "a_f_m_prolhost_01",
        "a_f_m_salton_01",
    },

    ParkingLots = { -- Parking lots where the bus will be spawned
        vector4(439.9370, -581.0314, 28.4998, 263.1297),
        vector4(437.3640, -585.4839, 28.4998, 264.4554),
        vector4(434.4360, -589.4965, 28.4998, 266.5495),
        vector4(474.4873, -586.5387, 28.4996, 352.9474),
        vector4(470.7718, -606.2182, 28.4994, 355.4654),
    },

    Routes = {
        {
            RouteName = "Little Bighorn Route", -- Name of the route
            Salary = 100, -- Salary of the route
            Level = 0, -- Level required to do the route
            TicketPrice = 10, -- Price of the ticket
            Exp = 10, -- Exp to give to the player

            Stops = {
                {
                    Preview = "https://cdn.discordapp.com/attachments/582570734174339101/1169775464148107305/image.png?ex=6556a14c&is=65442c4c&hm=8a0180939fafeb0f6c2c0f2339e0901451a61bda046e80bbed0bb1efaa953f4e&", -- Image of the stop (in the menu)
                    StopName = "Little Bighorn Ave", -- Name of the stop
                    Level = 0, -- Level required to do the stop
                    StopCoords = vector3(460.4128, -618.2562, 28.4998), -- Coords of the stop
                    PassengerWaitCoords = vector4(455.2104, -615.7665, 28.4998, 291.3041), -- Coords where the passengers will wait
                    MaxPassengers = 6, -- Max passengers to create on stop
                    MinPassengers = 3, -- Min passengers to create on stop
                    StopBlip = { -- Blip of the stop (https://docs.fivem.net/docs/game-references/blips/)
                        Sprite = 1,
                        Color = 4,
                        Scale = 0.6,
                        Text = "Little Bighorn Ave"
                    }
                },
                {
                    Preview = "https://cdn.discordapp.com/attachments/582570734174339101/1169775589914312765/image.png?ex=6556a16a&is=65442c6a&hm=f53e79ddfaab8b84f261eda9d756d172dd6c65066087a68174addbfeaa883ddd&", -- Image of the stop (in the menu)
                    StopName = "Strawberry Ave", -- Name of the stop
                    Level = 0, -- Level required to do the stop
                    StopCoords = vector3(308.2967, -768.3861, 29.3087), -- Coords of the stop
                    PassengerWaitCoords = vector4(305.4775, -765.5773, 29.1584, 248.1796), -- Coords where the passengers will wait
                    MaxPassengers = 5, -- Max passengers to create on stop
                    MinPassengers = 1, -- Min passengers to create on stop
                    StopBlip = { -- Blip of the stop (https://docs.fivem.net/docs/game-references/blips/)
                        Sprite = 1,
                        Color = 4,
                        Scale = 0.6,
                        Text = "Strawberry Ave"
                    }
                },
                {
                    Preview = "https://cdn.discordapp.com/attachments/582570734174339101/1169775669425733743/image.png?ex=6556a17c&is=65442c7c&hm=a5f86aec8864cd93dd27d515e7bea00a957b0dff5a3e16097c93448864a1cd70&", -- Image of the stop (in the menu)
                    StopName = "San Andreas Ave", -- Name of the stop
                    Level = 1, -- Level required to do the stop
                    StopCoords = vector3(113.2419, -787.1599, 31.4317), -- Coords of the stop
                    PassengerWaitCoords = vector4(114.7808, -783.2462, 31.2577, 163.8454), -- Coords where the passengers will wait
                    MaxPassengers = 5, -- Max passengers to create on stop
                    MinPassengers = 1, -- Min passengers to create on stop
                    StopBlip = { -- Blip of the stop (https://docs.fivem.net/docs/game-references/blips/)
                        Sprite = 1,
                        Color = 4,
                        Scale = 0.6,
                        Text = "San Andreas Ave"
                    }
                },
                {
                    Preview = "https://cdn.discordapp.com/attachments/582570734174339101/1169775731547590766/image.png?ex=6556a18b&is=65442c8b&hm=59ac4979b3455a9e1c5976b4b6f3d12ec5f65ad8ba7d88ef16efcb1441279317&", -- Image of the stop (in the menu)
                    StopName = "Alta Street", -- Name of the stop
                    Level = 3, -- Level required to do the stop
                    TimeToGetNextStop = 30, -- Time to get to the next stop (in seconds)
                    StopCoords = vector3(-171.0328, -820.0461, 31.1545), -- Coords of the stop
                    PassengerWaitCoords = vector4(-174.1514, -818.9521, 30.9964, 247.5936), -- Coords where the passengers will wait
                    MaxPassengers = 5, -- Max passengers to create on stop
                    MinPassengers = 1, -- Min passengers to create on stop
                    StopBlip = { -- Blip of the stop (https://docs.fivem.net/docs/game-references/blips/)
                        Sprite = 1,
                        Color = 4,
                        Scale = 0.6,
                        Text = "Alta Street"
                    }
                },
            }
        },
    },

    Notify = function(msg, type, length)
        if Config.Framework == "qb" then
            Framework.Functions.Notify(msg, type, length)
        else
            Framework.ShowNotification(msg)
        end
    end
}