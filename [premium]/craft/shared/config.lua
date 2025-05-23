-- Configuration settings for the GPS system.
Config                = {}

-- Debug print setting for displaying debug messages.
Config.DebugPrint     = true

-- Locale setting for language localization.
Config.Locale         = "en"

-- Do not CHANGE !!!
Config.FrameWork      = nil

-- ("esx_notify" | "qb_notify" | "custom_notify") -- > System to be used
Config.NotifyType     = "qb_notify"

-- ("ox_inventory" | "qb-inventory" | "custom") System to be used
Config.InventoryType  = "qb-inventory"

-- ("ox_target" | "ox_target") System to be used
Config.TargetType     = "qb-target"

Config.CraftableItems_1 = {
    ["lockpick"] = {
        name = "lockpick",
        label = "Lockpick",
        propModel = nil,
        count = 1,
        duration = 60000,
        image = "items/lockpick.png",
        ingredients = {
            aluminum = 30,
            iron = 30,
        },
        price = 50,
    },
    ["advancedlockpick"] = {
        name = "advancedlockpick",
        label = "Advanced Lockpick",
        propModel = nil,
        count = 1,
        duration = 90000,
        image = "items/advancedlockpick.png",
        ingredients = {
            metalscrap = 30,
            iron = 30,
            aluminum = 30,
            rubber = 30,
        },
        price = 80,
    },
    ["advancedrepairkit"] = {
        name = "advancedrepairkit",
        label = "Advanced Repair Kit",
        propModel = nil,
        count = 1,
        duration = 120000,
        image = "items/advancedkit.png",
        ingredients = {
            metalscrap = 30,
            iron = 30,
            copper = 30,
            steel = 30,
        },
        price = 90,
    },
    ["pistol_ammo"] = {
        name = "pistol_ammo",
        label = "Pistol Ammo",
        propModel = nil,
        count = 1,
        duration = 60000,
        image = "items/np_pistol-ammo.png",
        ingredients = {
            metalscrap = 4,
            aluminum = 4,
            plastic = 4,
            rubber = 4,
            copper = 4,
            glass = 4,
            steel = 4,
            iron = 4,
        },
        price = 12,
    },
}
Config.CraftableItems_2 = {
    ["weapon_snspistol"] = {                    -- Item name: weapon_assaultrifle, IT SHOULD BE UNIQUE !!!
        name = "weapon_snspistol",              -- Item name: weapon_assaultrifle, PLEASE SET THE SAME !!!
        label = "SNS Pistol",                   -- Item label text
        propModel = "weapon_snspistol",         -- Object prop model to be created, to show
        count = 1,                                 -- Production output
        duration = 10000,                          -- Production time | milliseconds
        image = "weapons/weapon_snspistol.png", -- Item image path
            --Ingredients images come from the folder ex: "public/images/items/*".
            --If the item starts with "weapon_" it comes from the folder ex: "public/images/weapons/*".
        ingredients = {          --Things needed to produce: [item_name] = needs
            metalscrap = 70,      -- Need 5x scrapmetal
            aluminum = 70,      -- Need 5x aluminum
            plastic = 70,      -- Need 5x plastic
            rubber = 70,      -- Need 5x rubber
            copper = 70,      -- Need 5x rubber
            glass = 70,      -- Need 5x rubber
            steel = 70,      -- Need 5x steel
            iron = 70,      -- Need 5x steel
        },
        price = 300,            -- Price of item crafting (only bank for now)
    },
    ["weapon_pistol"] = {
        name = "weapon_pistol",
        label = "Walther P99",
        propModel = nil,
        count = 1,
        duration = 300000,
        image = "weapons/weapon_pistol.png",
        ingredients = {
            metalscrap = 80,
            aluminum = 80,
            plastic = 80,
            rubber = 80,
            copper = 80,
            glass = 80,
            steel = 80,
            iron = 80,
        },
        price = 500,
    },
    ["weapon_m9"] = {
        name = "weapon_m9",
        label = "Beretta M9A3",
        propModel = nil,
        count = 1,
        duration = 600000,
        image = "weapons/weapon_m9.png",
        ingredients = {
            metalscrap = 90,
            aluminum = 90,
            plastic = 90,
            rubber = 90,
            copper = 90,
            glass = 90,
            steel = 90,
            iron = 90,
        },
        price = 1000,
    },
    ["weapon_fnx45"] = {
        name = "weapon_fnx45",
        label = "FN FNX-45",
        propModel = nil,
        count = 1,
        duration = 900000,
        image = "weapons/weapon_fnx45.png",
        ingredients = {
            metalscrap = 100,
            aluminum = 100,
            plastic = 100,
            rubber = 100,
            copper = 100,
            glass = 100,
            steel = 100,
            iron = 100,
        },
        price = 1500,
    },
    ["weapon_de"] = {
        name = "weapon_de",
        label = "Desert Eagle",
        propModel = nil,
        count = 1,
        duration = 1200000,
        image = "weapons/weapon_de.png",
        ingredients = {
            metalscrap = 130,
            aluminum = 130,
            plastic = 130,
            rubber = 130,
            copper = 130,
            glass = 130,
            steel = 130,
            iron = 130,
        },
        price = 2000,
    },
    ["weapon_glock18c"] = {
        name = "weapon_glock18c",
        label = "Glock 18C",
        propModel = nil,
        count = 1,
        duration = 1800000,
        image = "weapons/glock18c.png",
        ingredients = {
            metalscrap = 150,
            aluminum = 150,
            plastic = 150,
            rubber = 150,
            copper = 150,
            glass = 150,
            steel = 150,
            iron = 150,
        },
        price = 250,
    },
}

-- Enable a shop to access the crafting menu
Config.CraftingTables   = {
    [1] = {
        active = true,
        name = "Crafting Station",
        coords = vector4(148.364838, 317.591217, 111.0, 204.09),
        cam = {
            coords = vector3(147.80, 318.8, 112.6),
            rotation = vector3(185.0, 180.0, 25.00),
        },
        distance = 2.0,
        blip = {
            active = true,
            name = "Anonymous",
            spriteId = 310,
            color = 1,
            scale = 0.4
        },
        object = {
            name = "gr_prop_gr_bench_02b",
            preview_spawn_coord = vector3(148.40, 317.75, 112.50)
        },
        -- "target" | "drawtext"
        interact_type = "target",
        -- Bench theme color: red|blue|green|orange
        color = "blue",
        -- You can choose different items for each bench.
        craftableItems = Config.CraftableItems_1
    },
    [2] = {
        active = true,
        name = "Crafting Station",
        coords = vector4(2442.68, 4977.75, 51.26, 49.06),
        cam = {
            coords = vector3(2443.74, 4976.78, 52),
            rotation = vector3(180.0, 180.0, 230.00),
                                -- vertical rotate horizontal
        },
        distance = 2.0,
        blip = {
            active = true,
            name = "Anonymous",
            spriteId = 310,
            color = 1,
            scale = 0.4
        },
        object = {
            name = "gr_prop_gr_bench_02b",
            preview_spawn_coord = vector3(148.40, 317.75, 112.50)
        },
        -- "target" | "drawtext"
        interact_type = "target",
        -- Bench theme color: red|blue|green|orange
        color = "blue",
        -- You can choose different items for each bench.
        craftableItems = Config.CraftableItems_2
    },
}

Config.WeaponAttachment = {
    Bones = {
        ["WAPClip"]     = { label = "Magazine", key = "clip", shift_left = -2, shift_top = 13 },
        ["Gun_GripR"]   = { label = "Skin", key = "skin", shift_left = 2, shift_top = 8 },
        ["WAPSupp"]     = { label = "Muzzle", key = "suppressor", shift_left = -5, shift_top = 8 },
        ["WAPFlshLasr"] = { label = "Tactical", key = "flashlight", shift_left = -8, shift_top = -12 },
        ["WAPScop"]     = { label = "Scope", key = "scope", shift_left = -1, shift_top = -10 },
        ["WAPGrip"]     = { label = "Grip", key = "grip", shift_left = -4, shift_top = 5 },
    },
}

Config.Weapons          = {
    ["weapon_pistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_PISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_PISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP_02" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_PISTOL_VARMOD_LUXE" }
        }
    },
    ["weapon_combatpistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_COMBATPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_COMBATPISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_appistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_APPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_APPISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_APPISTOL_VARMOD_LUXE" }
        }
    },
    ["weapon_pistol50"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_PISTOL50_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_PISTOL50_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_heavy",     type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_PISTOL50_VARMOD_LUXE" }
        }
    },
    ["weapon_snspistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip", hash = "COMPONENT_SNSPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip", hash = "COMPONENT_SNSPISTOL_CLIP_02" },
            { item = "at_skin_luxe",            type = "skin", hash = "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_heavypistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_HEAVYPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_HEAVYPISTOL_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_HEAVYPISTOL_VARMOD_LUXE" }
        }
    },
    ["weapon_vintagepistol"] = {
        components = {
            { item = "at_clip_pistol",          type = "clip",       hash = "COMPONENT_VINTAGEPISTOL_CLIP_01" },
            { item = "at_clip_extended_pistol", type = "clip",       hash = "COMPONENT_VINTAGEPISTOL_CLIP_02" },
            { item = "at_suppressor_light",     type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" }
        }
    },
    -- ["weapon_machinepistol"] = {
    --     components = {
    --         { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_MACHINEPISTOL_CLIP_01" },
    --         { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_MACHINEPISTOL_CLIP_02" },
    --         { item = "at_clip_drum_smg",     type = "clip",       hash = "COMPONENT_MACHINEPISTOL_CLIP_03" },
    --         { item = "at_suppressor_light",  type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" }
    --     }
    -- },
    -- ["weapon_smg"] = {
    --     components = {
    --         { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_SMG_CLIP_01" },
    --         { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_SMG_CLIP_02" },
    --         { item = "at_clip_drum_smg",     type = "clip",       hash = "COMPONENT_SMG_CLIP_03" },
    --         { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
    --         { item = "at_scope_macro",       type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO_02" },
    --         { item = "at_suppressor_light",  type = "suppressor", hash = "COMPONENT_AT_PI_SUPP" },
    --         { item = "at_skin_luxe",         type = "skin",       hash = "COMPONENT_SMG_VARMOD_LUXE" }
    --     }
    -- },
    ["weapon_assaultsmg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_ASSAULTSMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_ASSAULTSMG_CLIP_02" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_macro",       type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO" },
            { item = "at_suppressor_heavy",  type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",         type = "skin",       hash = "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_microsmg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_MICROSMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_MICROSMG_CLIP_02" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_PI_FLSH" },
            { item = "at_scope_macro",       type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO" },
            { item = "at_suppressor_heavy",  type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",         type = "skin",       hash = "COMPONENT_MICROSMG_VARMOD_LUXE" }
        }
    },
    ["weapon_minismg"] = {
        components = {
            { item = "at_clip_smg",          type = "clip", hash = "COMPONENT_MINISMG_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip", hash = "COMPONENT_MINISMG_CLIP_02" }
        }
    },
    ["weapon_combatpdw"] = {
        components = {
            { item = "at_clip_smg",          type = "clip",       hash = "COMPONENT_COMBATPDW_CLIP_01" },
            { item = "at_clip_extended_smg", type = "clip",       hash = "COMPONENT_COMBATPDW_CLIP_02" },
            { item = "at_clip_drum_smg",     type = "clip",       hash = "COMPONENT_COMBATPDW_CLIP_03" },
            { item = "at_flashlight",        type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_grip",              type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_scope_small",       type = "scope",      hash = "COMPONENT_AT_SCOPE_SMALL" }
        }
    },
    ["weapon_pumpshotgun"] = {
        components = {
            { item = "at_flashlight",       type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_light", type = "suppressor", hash = "COMPONENT_AT_SR_SUPP" },
            { item = "at_skin_luxe",        type = "skin",       hash = "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_sawnoffshotgun"] = {
        components = {
            { item = "at_skin_luxe", type = "skin", hash = "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE" }
        }
    },
    ["weapon_assaultshotgun"] = {
        components = {
            { item = "at_clip_shotgun",          type = "clip",       hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_01" },
            { item = "at_clip_extended_shotgun", type = "clip",       hash = "COMPONENT_ASSAULTSHOTGUN_CLIP_02" },
            { item = "at_flashlight",            type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_heavy",      type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                  type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" }
        }
    },
    ["weapon_bullpupshotgun"] = {
        components = {
            { item = "at_flashlight",       type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_heavy", type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",             type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" }
        }
    },
    ["weapon_heavyshotgun"] = {
        components = {
            { item = "at_clip_shotgun",          type = "clip",       hash = "COMPONENT_HEAVYSHOTGUN_CLIP_01" },
            { item = "at_clip_extended_shotgun", type = "clip",       hash = "COMPONENT_HEAVYSHOTGUN_CLIP_02" },
            { item = "at_clip_drum_shotgun",     type = "clip",       hash = "COMPONENT_HEAVYSHOTGUN_CLIP_03" },
            { item = "at_flashlight",            type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_suppressor_heavy",      type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",                  type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" }
        }
    },
    ["weapon_assaultrifle"] = {
        components = {
            { item = "assaultrifle_defaultclip",          type = "clip",       hash = "COMPONENT_ASSAULTRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_ASSAULTRIFLE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip",       hash = "COMPONENT_ASSAULTRIFLE_CLIP_03" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_macro",         type = "scope",      hash = "COMPONENT_AT_SCOPE_MACRO" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_carbinerifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_CARBINERIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_CARBINERIFLE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip",       hash = "COMPONENT_CARBINERIFLE_CLIP_03" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_medium",        type = "scope",      hash = "COMPONENT_AT_SCOPE_MEDIUM" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_CARBINERIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_advancedrifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_ADVANCEDRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_ADVANCEDRIFLE_CLIP_02" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_small",         type = "scope",      hash = "COMPONENT_AT_SCOPE_SMALL" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_specialcarbine"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_SPECIALCARBINE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_SPECIALCARBINE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip",       hash = "COMPONENT_SPECIALCARBINE_CLIP_03" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_medium",        type = "scope",      hash = "COMPONENT_AT_SCOPE_MEDIUM" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_bullpuprifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip",       hash = "COMPONENT_BULLPUPRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip",       hash = "COMPONENT_BULLPUPRIFLE_CLIP_02" },
            { item = "at_flashlight",          type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_small",         type = "scope",      hash = "COMPONENT_AT_SCOPE_SMALL" },
            { item = "at_suppressor_heavy",    type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",           type = "skin",       hash = "COMPONENT_BULLPUPRIFLE_VARMOD_LOW" }
        }
    },
    ["weapon_compactrifle"] = {
        components = {
            { item = "at_clip_rifle",          type = "clip", hash = "COMPONENT_COMPACTRIFLE_CLIP_01" },
            { item = "at_clip_extended_rifle", type = "clip", hash = "COMPONENT_COMPACTRIFLE_CLIP_02" },
            { item = "at_clip_drum_rifle",     type = "clip", hash = "COMPONENT_COMPACTRIFLE_CLIP_03" }
        }
    },
    ["weapon_mg"] = {
        components = {
            { item = "at_clip_extended_mg", type = "clip",  hash = "COMPONENT_MG_CLIP_02" },
            { item = "at_scope_small",      type = "scope", hash = "COMPONENT_AT_SCOPE_SMALL_02" },
            { item = "at_skin_luxe",        type = "skin",  hash = "COMPONENT_MG_VARMOD_LOWRIDER" }
        }
    },
    ["weapon_combatmg"] = {
        components = {
            { item = "at_clip_extended_mg", type = "clip",  hash = "COMPONENT_COMBATMG_CLIP_01" },
            { item = "at_clip_extended_mg", type = "clip",  hash = "COMPONENT_COMBATMG_CLIP_02" },
            { item = "at_scope_medium",     type = "scope", hash = "COMPONENT_AT_SCOPE_MEDIUM" },
            { item = "at_grip",             type = "grip",  hash = "COMPONENT_AT_AR_AFGRIP" },
        }
    },
    ["weapon_gusenberg"] = {
        components = {
            { item = "at_clip_extended_mg", type = "clip", hash = "COMPONENT_GUSENBERG_CLIP_01" },
            { item = "at_clip_extended_mg", type = "clip", hash = "COMPONENT_GUSENBERG_CLIP_02" },
        }
    },
    ["weapon_sniperrifle"] = {
        components = {
            { item = "at_scope_large",      type = "scope",      hash = "COMPONENT_AT_SCOPE_LARGE" },
            { item = "at_scope_advanced",   type = "scope",      hash = "COMPONENT_AT_SCOPE_MAX" },
            { item = "at_suppressor_heavy", type = "suppressor", hash = "COMPONENT_AT_AR_SUPP_02" },
            { item = "at_skin_luxe",        type = "skin",       hash = "COMPONENT_SNIPERRIFLE_VARMOD_LUXE" }
        }
    },
    ["weapon_heavysniper"] = {
        components = {
            { item = "at_scope_large",    type = "scope", hash = "COMPONENT_AT_SCOPE_LARGE" },
            { item = "at_scope_advanced", type = "scope", hash = "COMPONENT_AT_SCOPE_MAX" }
        }
    },
    ["weapon_marksmanrifle"] = {
        components = {
            { item = "at_clip_sniper",          type = "clip",       hash = "COMPONENT_MARKSMANRIFLE_CLIP_01" },
            { item = "at_clip_extended_sniper", type = "clip",       hash = "COMPONENT_MARKSMANRIFLE_CLIP_02" },
            { item = "at_flashlight",           type = "flashlight", hash = "COMPONENT_AT_AR_FLSH" },
            { item = "at_scope_large",          type = "scope",      hash = "COMPONENT_AT_SCOPE_LARGE_MK2" },
            { item = "at_suppressor_heavy",     type = "suppressor", hash = "COMPONENT_AT_AR_SUPP" },
            { item = "at_grip",                 type = "grip",       hash = "COMPONENT_AT_AR_AFGRIP" },
            { item = "at_skin_luxe",            type = "skin",       hash = "COMPONENT_MARKSMANRIFLE_VARMOD_LUXE" }
        }
    }
}
