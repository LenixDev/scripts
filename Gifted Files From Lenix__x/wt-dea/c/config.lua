Config = {}



--لو عندك اسلحه تبي تضيفها برتب محدد لكل سلاح من هنا

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        [1] = {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [2] = {
            name = "oxy",
            price = 0,
            amount = 10,
            info = {
                serie = "",
            },
            type = "item",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [3] = {
            name = "armor",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [4] = {
            name = "heavyarmor",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [5] = {
            name = "pistol_ammo",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [6] = {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [7] = {
            name = "empty_evidence_bag",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [8] = {
            name = "parachute",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 8,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [9] = {
            name = "repairkit",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 9,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [10] = {
            name = "radio",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 10,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [11] = {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 11,
            authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11}
        },
        [12] = {
            name = "binoculars",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 12,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [13] = {
            name = "diving_gear",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 13,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [14] = {
            name = "weapon_knife",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 14,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [15] = {
            name = "police_stormram",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 15,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [16] = {
            name = "megaphone",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 16,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [17] = {
            name = "cctv",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 17,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [18] = {
            name = "cctv360",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 18,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [19] = {
            name = "camviewer",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 19,
            authorizedJobGrades = {10, 11}
        },
        [20] = {
            name = "Tracker",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 20,
            authorizedJobGrades = {10, 11}
        },
        [21] = {
            name = "drone_flyer_1",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 21,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
        [22] = {
            name = "weapon_combatpistol",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 22,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        },
    }
}