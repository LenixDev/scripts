Config = {
    Framework = "qb", -- qb or esx

    CoreExport = function()
        if Config.Framework == "qb" then
            return exports['qb-core']:GetCoreObject()
        elseif Config.Framework == "esx" then
            return exports['es_extended']:getSharedObject()
        else
            -- return something
        end
    end,

    Ped = {
        Model = "s_m_m_dockwork_01", -- https://docs.fivem.net/docs/game-references/ped-models/
        Position = vector3(292.54, -223.24, 53.98),
        Heading = 158.52,
    },

    Notify = function (message, type, length)
        if Config.Framework == "qb" then
            Framework.Functions.Notify(message, type, length)
        elseif Config.Framework == "esx" then
            Framework.ShowNotification(message)
        end
    end,

    -- House types are: small / medium / big
    Missions = {
        {
            Name = "Small House",
            HouseType = "big",
            Description = "A customer asked us to clean his house. He said that he has a small house and it shouldn't take long to clean it. He also said that he will pay us $1000 for this job.",
            Image = "https://media.discordapp.net/attachments/582570734174339101/1200527245102567605/mission-placeholder.png?ex=65c6811f&is=65b40c1f&hm=3d1505b50d6da241f8430918cf48757094ac1fdf1cf285b13473760c3427a023&=&format=webp&quality=lossless&width=296&height=286",
            Salary = 1000,
            Exp = 20,
            Level = 0,
            MinMembers = 1,
            MaxMembers = 5,
            Difficulty = 1, -- 1, 2, 3
            HouseEntrance = vector3(270.17, -1917.41, 26.18),
        },
        {
            Name = "Non Used House",
            HouseType = "medium",
            Description = "The customer said that he has a house that he doesn't use. He said that he wants us to clean it and he will pay us $1200 for this job.",
            Image = "https://media.discordapp.net/attachments/582570734174339101/1200527245102567605/mission-placeholder.png?ex=65c6811f&is=65b40c1f&hm=3d1505b50d6da241f8430918cf48757094ac1fdf1cf285b13473760c3427a023&=&format=webp&quality=lossless&width=296&height=286",
            Salary = 1200,
            Exp = 25,
            Level = 1,
            MinMembers = 1,
            MaxMembers = 4,
            Difficulty = 2, -- 1, 2, 3
            HouseEntrance = vector3(257.82, -1927.51, 25.44),
        },
        {
            Name = "Air BnB",
            HouseType = "big",
            Description = "The customer said that he has an Air BnB house. He said that he wants us to clean it and he will pay us $2500 for this job.",
            Image = "https://media.discordapp.net/attachments/582570734174339101/1200527245102567605/mission-placeholder.png?ex=65c6811f&is=65b40c1f&hm=3d1505b50d6da241f8430918cf48757094ac1fdf1cf285b13473760c3427a023&=&format=webp&quality=lossless&width=296&height=286",
            Salary = 2500,
            Exp = 30,
            Level = 2,
            MinMembers = 2,
            MaxMembers = 4,
            Difficulty = 3, -- 1, 2, 3
            HouseEntrance = vector3(282.69, -1898.98, 27.27),
        },
    },

    -- Clening types are: trash / mop / wipe
    HouseTypes = {
        ["small"] = {
            SpawnAt = vector4(277.3369, -1890.6067, -17.9813, 181.8309), -- Player will spawn at this location when they enter the house
            CleaningPositions = {
                [1] = {
                    coords = vector3(276.9104, -1897.6852, -17.9813),
                    type = "wipe",
                },
                [2] = {
                    coords = vector3(273.7520, -1897.9250, -17.9813),
                    type = "wipe",
                },
                [3] = {
                    coords = vector3(270.9424, -1897.7649, -17.9813),
                    type = "wipe",
                },
                [4] = {
                    coords = vector3(267.8316, -1897.9087, -17.9813),
                    type = "wipe",
                },
                [5] = {
                    coords = vector3(267.4478, -1895.9850, -17.9813),
                    type = "trash",
                },
                [6] = {
                    coords = vector3(269.6942, -1893.3737, -17.9813),
                    type = "wipe",
                },
                [7] = {
                    coords = vector3(267.2716, -1891.4575, -17.9813),
                    type = "mop",
                },
                [8] = {
                    coords = vector3(272.4136, -1891.3749, -17.9813),
                    type = "trash",
                },
                [9] = {
                    coords = vector3(277.2976, -1894.2819, -17.9813),
                    type = "wipe", -- mop, mop, wipe
                },
                [10] = {
                    coords = vector3(275.7133, -1890.9053, -17.9813),
                    type = "mop",
                },
                [11] = {
                    coords = vector3(274.5959, -1893.0038, -17.9813),
                    type = "trash",
                },
                [12] = {
                    coords = vector3(271.8394, -1895.4872, -17.9813),
                    type = "trash",
                }
            }
        },
        ["medium"] = {
            SpawnAt = vector4(273.8489, -1903.5608, -18.0901, 0.0805), -- Player will spawn at this location when they enter the house
            CleaningPositions = {
                [1] = {
                    coords = vector3(271.95, -1890.33, -18.09),
                    type = "trash",
                },
                [2] = {
                    coords = vector3(265.91, -1894.73, -18.09),
                    type = "mop",
                },
                [3] = {
                    coords = vector3(269.46, -1894.62, -18.09),
                    type = "wipe",
                },
                [4] = {
                    coords = vector3(276.51, -1899.3, -18.09),
                    type = "trash",
                },
                [5] = {
                    coords = vector3(275.2, -1895.71, -18.09),
                    type = "mop",
                },
                [6] = {
                    coords = vector3(279.07, -1890.27, -18.09),
                    type = "trash",
                },
                [7] = {
                    coords = vector3(275.07, -1885.33, -18.09),
                    type = "mop",
                },
                [8] = {
                    coords = vector3(265.49, -1888.07, -18.09),
                    type = "wipe",
                },
                [9] = {
                    coords = vector3(269.52, -1886.51, -18.1),
                    type = "trash",
                },
                [10] = {
                    coords = vector3(272.48, -1888.57, -18.09),
                    type = "trash",
                },
                [11] = {
                    coords = vector3(272.92, -1898.82, -18.09),
                    type = "trash",
                },
                [12] = {
                    coords = vector3(275.03, -1889.93, -18.09),
                    type = "mop",
                },
                [13] = {
                    coords = vector3(266.93, -1890.91, -18.09),
                    type = "mop",
                },
                [14] = {
                    coords = vector3(271.29, -1892.74, -18.09),
                    type = "wipe",
                },
                [15] = {
                    coords = vector3(272.17, -1884.93, -18.09),
                    type = "mop",
                },
                [16] = {
                    coords = vector3(275.24, -1893.98, -18.09),
                    type = "trash",
                }
            }
        },
        ["big"] = {
            SpawnAt = vector4(262.8908, -1888.6505, -9.2323, 269.4567), -- Player will spawn at this location when they enter the house
            CleaningPositions = {
                [1] = {
                    coords = vector3(275.2020, -1902.9507, -8.5506),
                    type = "wipe",
                },
                [2] = {
                    coords = vector3(276.3315, -1901.7844, -8.5506),
                    type = "wipe",
                },
                [3] = {
                    coords = vector3(273.6157, -1900.5760, -8.5506),
                    type = "trash",
                },
                [4] = {
                    coords = vector3(272.3337, -1896.8586, -8.5502),
                    type = "trash",
                },
                [5] = {
                    coords = vector3(276.6555, -1893.5242, -8.5506),
                    type = "mop",
                },
                [6] = {
                    coords = vector3(277.2989, -1886.4388, -8.7797),
                    type = "wipe",
                },
                [7] = {
                    coords = vector3(282.7349, -1887.0327, -8.7797),
                    type = "trash",
                },
                [8] = {
                    coords = vector3(282.8171, -1889.4551, -8.7797),
                    type = "mop",
                },
                [9] = {
                    coords = vector3(274.2350, -1886.2303, -6.3819),
                    type = "mop",
                },
                [10] = {
                    coords = vector3(273.8651, -1902.3252, -4.6444),
                    type = "trash",
                },
                [11] = {
                    coords = vector3(275.8306, -1901.0864, -4.6444),
                    type = "trash",
                },
                [12] = {
                    coords = vector3(275.8775, -1897.5806, -4.6444),
                    type = "mop",
                },
                [13] = {
                    coords = vector3(271.6022, -1900.8577, -4.6392),
                    type = "mop",
                },
                [14] = {
                    coords = vector3(266.3408, -1900.9050, -4.6444),
                    type = "trash",
                },
                [15] = {
                    coords = vector3(268.6295, -1899.9032, -4.6444),
                    type = "mop",
                },
                [16] = {
                    coords = vector3(266.8088, -1897.4298, -4.6444),
                    type = "trash",
                },
                [17] = {
                    coords = vector3(268.9191, -1893.8807, -4.6444),
                    type = "trash",
                },
                [18] = {
                    coords = vector3(265.2047, -1893.3970, -4.6444),
                    type = "trash",
                },
                [19] = {
                    coords = vector3(262.9703, -1893.4351, -4.6446),
                    type = "mop",
                },
                [20] = {
                    coords = vector3(262.2378, -1888.5680, -4.6444),
                    type = "wipe",
                },
                [21] = {
                    coords = vector3(267.9324, -1885.8445, -4.6444),
                    type = "wipe",
                },
            }
        },
    }
}
