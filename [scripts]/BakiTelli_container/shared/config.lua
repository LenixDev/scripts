Config = {}

-- # Open Menu Settings # --
Config.Command = "containers"
Config.Key = true -- key true or false
Config.OpenKey = "E" -- Key Name

-- # Inventory & Money Settıngs # --
Config.KeyItem = "container_key" -- key item name
Config.Inventory = "default" -- ox_inventory, quasar, default, other
Config.Money = "cash" -- cash or bank

-- # Animations # --
Config.Animation = {
    Video = true, 
    AnimationCoord = vector4(3506.3245, 2552.6946, 8.0868, 222.1811),
    ContainerObj = "prop_container_03mb",
    ContainerCoords = vector4(3512.8557, 2547.6956, 8.1112, 265.2380),
    CharacterGoLocation = vector4(3509.0781, 2547.9773, 8.9904, 270.1053),
}

-- # Containers # --
Config.Containers = {
    [1] = {
        CaseName = "Basic",
        CaseDesc = "This case stands out for its affordable price and you can get excellent products with this case.",
        CasePriceTyp = "money", -- key or money
        CasePriceAmount = 7500,
        Products = {
            [1] = {
                itemlabel = "Bandage",
                itemname = "bandage", -- item code
                itemcount = 3,
                itemimg = "bandage.png"
            },
            [2] = {
                itemlabel = "Beer",
                itemname = "beer", -- item code
                itemcount = 2,
                itemimg = "beer.png"
            },
            [3] = {
                itemlabel = "Binoculars",
                itemname = "binoculars", -- item code
                itemcount = 1,
                itemimg = "binoculars.png"
            },
        }
    },
    [2] = {
        CaseName = "Guns",
        CaseDesc = "This safe contains mainly weapons and bullets and can be opened with a key product, you can examine the safe by clicking for details.",
        CasePriceTyp = "key", -- key or money
        CasePriceAmount = 1,
        Products = {
            [1] = {
                itemlabel = "Combat Pistol",
                itemname = "weapon_combatpistol", -- item code
                itemcount = 1,
                itemimg = "weapon_combatpistol.png"
            },
            [2] = {
                itemlabel = "Flare Gun",
                itemname = "weapon_flaregun", -- item code
                itemcount = 1,
                itemimg = "weapon_flaregun.png"
            },
            [3] = {
                itemlabel = "Bat",
                itemname = "weapon_bat", -- item code
                itemcount = 1,
                itemimg = "weapon_bat.png"
            },
        }
    },
}