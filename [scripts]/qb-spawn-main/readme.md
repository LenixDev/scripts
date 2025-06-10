
-- Toxic Fivem community    https://discord.gg/toxicfivem

Hello dear customer first thank you for supporting us. Here is the documentation for work ac-spawnselector compatible with qb-apartments.

- Step 1 | Open qb-apartments config.lua

When you open config file you will see apartments inside of Apartments.Locations table. And when you look inside of it you will see name, label, coords and more we will edit
coords to make spawn selector compatible with apartments system. First click on coords - enter and create a new line and add this: 
Code: x = 0, y = 0
After you add code it should look like this:
coords = {
     enter = vector4(-667.02, -1105.24, 14.63, 242.32),
     x = 0,
     y = 0
},
If your code is like this it means you did everything right. So now just edit x and y to adjust marker in the screen. X means left, Y means top.

Apartments = {}
Apartments.Starting = true
Apartments.SpawnOffset = 30
Apartments.Locations = {
    ["apartment1"] = {
        name = "apartment1",
        label = "شقة البنر",
        coords = {
            enter = vector4(-263.82, -959.11, 31.23, 30),
            x = 34,
            y = 40.5
       },
        polyzoneBoxData = {
            heading = 245,
            minZ = 28.63,
            maxZ = 32.63,
            debug = false,
            length = 2.0,
            width = 0.5,
            distance = 2.0,
            created = false
        }
    },
    ["apartment2"] = {
        name = "apartment2",
        label = "الشقة الغربية",
        coords = {
            enter = vector4(-1288.52, -430.51, 35.15, 124.81),
            x = 37.2,
            y = 30.8
        },
        polyzoneBoxData = {
            heading = 124,
            minZ = 34.0,
            maxZ = 37.0,
            debug = false,
            length = 1,
            width = 3,
            distance = 2.0,
            created = false
        }
    },
    ["apartment3"] = {
        name = "apartment3",
        label = "الشقة الشمالية",
        coords = {
            enter = vector4(435.64, 214.85, 103.17, 161.54),
            x = 40,
            y = 47
        },
        polyzoneBoxData = {
            heading = 250,
            minZ = 40,
            maxZ = 43.5,
            debug = false,
            length = 1,
            width = 1,
            distance = 2.0,
            created = false
        }
    },
    ["apartment4"] = {
        name = "apartment4",
        label = "شقة ساندي",
        coords = {
            enter = vector4(367.21, 2624.6, 44.67, 210.03),
            x = 53.5,
            y = 46.5
        },
        polyzoneBoxData = {
            heading = 180,
            minZ = 41.0,
            maxZ = 45.5,
            debug = false,
            length = 1,
            width = 2,
            distance = 2.0,
            created = false
        }
    },
    ["apartment5"] = {
        name = "apartment5",
        label = "شقة باليتو",
        coords = {
            enter = vector4(-109.54, 6336.9, 31.58, 132.97),
            x = 73,
            y = 42
        },
        polyzoneBoxData = {
            heading = 270,
            minZ = 28.5,
            maxZ = 31.0,
            debug = false,
            length = 1,
            width = 2,
            distance = 2.0,
            created = false
        }
    },
}
