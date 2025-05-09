Shorts = {}

--في حال تبي تغير مكان البوت من تحت
Shorts.ped = {
    coords = vector4(2535.3, -398.51, 92.06, 168.0),
    model = 's_m_m_fibsec_01',
    length = 1,
    width = 1,
    heading=317,
    debugPoly=false,
    minZ=95.11,
    maxZ=95.11
}


--في حال تبي تغير مكنا سبون السياره غير هنا
Shorts.vehicle = {
    coords = vector3(2542.48, -396.76, 92.56),
    heading = 7.99,
    Coordsradius = 5,
    garage = 'MRPDgarage',
}


Shorts.Vehicles = { -- في حال عندك سيارات غير حط اسمها مكان السولتن
    zeroOne = 'polas350',
    FirstOne = 'ucwashington',
    SecondOne = 'ucrancher',
    ThridOne = 'ucprimo',
    FourthOne = 'uccoquette',
    onefifth = 'uccomet',
    OneSixth = 'ucbuffalo',
    SeventhOne = 'ucbanshee',
    EighthOne = 'ucballer'
}

Shorts.SecurityCameras = { --في حال عندك احداثيات مواقع كاميرات حطهاتحت
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#2", coords = vector3(434.26, -976.0, 33.04), r = {x = -25.0, y = 0.0, z = 114.100}, canRotate = false, isOnline = true},
        [4] = {label = "Pacific Bank CAM#2", coords = vector3(443.02, -978.0, 32.35), r = {x = -24.0, y = 0.0, z = 114.100}, canRotate = false, isOnline = true},
    },
}
 




-- Config.items = {
--     label = "Police Armory",
--     slots = 30,
--     items = {
--         [1] = {
--             name = "weapon_combatpistol",
--             price = 0,
--             amount = 1,
--             info = {
--                 serie = "",
--                 attachments = {
--                     {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
--                 }
--             },
--             type = "weapon",
--             slot = 1,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [2] = {
--             name = "weapon_stungun",
--             price = 0,
--             amount = 1,
--             info = {
--                 serie = "",
--             },
--             type = "weapon",
--             slot = 2,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         -- [3] = {
--         --     name = "weapon_pumpshotgun",
--         --     price = 0,
--         --     amount = 1,
--         --     info = {
--         --         serie = "",
--         --         attachments = {
--         --             {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
--         --         }
--         --     },
--         --     type = "weapon",
--         --     slot = 3,
--         --     authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         -- },
--         -- [4] = {
--         --     name = "weapon_smg",
--         --     price = 0,
--         --     amount = 1,
--         --     info = {
--         --         serie = "",
--         --         attachments = {
--         --             {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
--         --             {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
--         --         }
--         --     },
--         --     type = "weapon",
--         --     slot = 4,
--         --     authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         -- },
--         [100] = {
--             name = "weapon_carbinerifle",
--             price = 0,
--             amount = 1,
--             info = {
--                 serie = "",
--                 attachments = {
--                     {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
--                     {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
--                 }
--             },
--             type = "weapon",
--             slot = 5,
--             authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [3] = {
--             name = "weapon_nightstick",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "weapon",
--             slot = 3,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [4] = {
--             name = "pistol_ammo",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 4,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [5] = {
--             name = "smg_ammo",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 5,
--             authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [6] = {
--             name = "shotgun_ammo",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 6,
--             authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [7] = {
--             name = "rifle_ammo",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 7,
--             authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [8] = {
--             name = "handcuffs",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 8,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [9] = {
--             name = "weapon_flashlight",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "weapon",
--             slot = 9,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [10] = {
--             name = "empty_evidence_bag",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 10,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [11] = {
--             name = "police_stormram",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 11,
--             authorizedJobGrades = {5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [12] = {
--             name = "armor",
--             price = 0,
--             amount = 50,
--             info = {},
--             type = "item",
--             slot = 12,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [13] = {
--             name = "radio",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 13,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [14] = {
--             name = "diving_gear",
--             price = 0,
--             amount = 200,
--             info = {},
--             type = "item",
--             slot = 14,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [15] = {
--             name = "weapon_fireextinguisher",
--             price = 0,
--             amount = 200,
--             info = {},
--             type = "item",
--             slot = 15,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [16] = {
--             name = "weapon_pistol50",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "weapon",
--             slot = 16,
--             authorizedJobGrades = {7, 8, 9, 10, 11, 12}
--         },
--         [17] = {
--             name = "dslrcamera",
--             price = 0,
--             amount = 200,
--             info = {},
--             type = "item",
--             slot = 17,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [18] = {
--             name = "weapon_heavypistol",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "weapon",
--             slot = 18,
--             authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [19] = {
--             name = "drone_lspd",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 19,
--             authorizedJobGrades = {10, 11, 12}
--         },
--         [20] = {
--             name = "Tracker",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 20,
--             authorizedJobGrades = {10, 11, 12}
--         },
--         [21] = {
--             name = "bodycam",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 21,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [22] = {
--             name = "dashcam",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 22,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [23] = {
--             name = "badge",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 23,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         },
--         [24] = {
--             name = "evidencebox",
--             price = 0,
--             amount = 1,
--             info = {},
--             type = "item",
--             slot = 24,
--             authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
--         }
--     }
-- }
    
