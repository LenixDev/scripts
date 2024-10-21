Config.BackPack = {}

Config.BackPack.Shop = {
    label = 'Trips Shop',
    slots = 5,
    items = {
        [1] = {
            name = "backpack",
            price = 1500,
            amount = 1,
            info = {
                maxweight = 15000,
                slots = 5,
            },
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "backpackgirl",
            price = 1500,
            amount = 1,
            info = {
                maxweight = 15000,
                slots = 5,
            },
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "parachute",
            price = 3000,
            amount = 1,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "chair64",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "chair63",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "chair62",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "chair81",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "chair101",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "chair97",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            slot = 9,
        },
    }
}

Config.BackPack.animations = {
    backpack = {
        dict = 'amb@world_human_hiker_standing@female@base',
        anim = 'base',
        bone = 'Back',
        attaching_position = {
            x = -0.15,
            y = -0.15,
            z = -0.05,
            x_rotation = -5.0,
            y_rotation = 90.0,
            z_rotation = 0.0,
        }
    },
}