--[[
    ['Innocence'] = {
    settings = {
        label = 'Bennys Motorworks', -- Text label for anything that wants it
        welcomeLabel = "Welcome to Benny's Motorworks!", -- Welcome label in the UI
        enabled = true, -- If the location can be used at all

        ---------- Receipt system ----------
        useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
        -- pay for evenry modification and all modifications will be saved on the vehicle. 
        -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
        -- will receive a receipt and not have to pay for modifications. 

        
        saveUpgrades = { 
            jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                    -- modification, and all will be saved on the vehicle.
            dutyCheck = true, 
        } ,

        upgradesMenuAccess = {
            jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
            dutyCheck = true,
        },
        ------------------------------------
    },
    blip = {
        label = 'Bennys Motorworks',
        coords = vector3(-205.6992, -1312.7377, 31.1588),
        sprite = 446,
        scale = 0.65,
        color = 0,
        display = 4,
        enabled = true,
    },
    categories = { -- Only include the categories you want. A category not listed defaults to FALSE.
        mods = true, -- Performance Mods
        repair = true,
        armor = true,
        respray = true,
        liveries = true,
        wheels = true,
        tint = true,
        plate = true,
        extras = true,
        neons = true,
        xenons = true,
        horn = true,
        turbo = true,
        cosmetics = true, -- Cosmetic Mods
    },
    drawtextui = {
        text = "Bennys Motorworks",
    },
    restrictions = { -- A person must pass ALL the restriction checks. Remove an item below to automatically pass that check.
        job = "any", -- Allowed job. Can be an array of strings for multiple jobs. Any for all jobs
        gang = "any", -- Allowed gang. Can be an array of strings for multiple gangs. Any for all gangs
        allowedClasses = {}, -- Array of allowed classes. Empty will allow any but denied classes.
        deniedClasses = {}, -- Array of denied classes.
    },
    zones = {
        { coords = vector3(-212.55, -1320.56, 31.0), length = 6.0, width = 4.0, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
        { coords = vector3(-222.47, -1329.73, 31.0), length = 6.0, width = 4.4, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
    }
},

Vehicle Classes:
0: Compacts     1: Sedans       2: SUVs         3: Coupes       4: Muscle       5: Sports Classics
6: Sports       7: Super        8: Motorcycles  9: Off-road     10: Industrial  11: Utility
12: Vans        13: Cycles      14: Boats       15: Helicopters 16: Planes      17: Service
18: Emergency   19: Military    20: Commercial  21: Trains
 ]]

Config = Config or {}

Config.Locations = {
    ['lscustoms'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for every modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = false, 
            },

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(-205.6992, -1312.7377, 31.1588),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            mods = true, 
            repair = true,
            armor = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            turbo = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(-349.33, -131.44, 38.6), length = 4.0, width = 7.0, heading = 72.53, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-346.61, -124.61, 38.6), length = 4.0, width = 7.0, heading = 72.96, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-343.27, -113.5, 38.6), length = 4.0, width = 7.0, heading = 72.01, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-365.26, -85.83, 38.61), length = 4.0, width = 7.0, heading = 68.12, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-352.41, -90.54, 38.61), length = 4.0, width = 7.0, heading = 73.03, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-338.83, -95.14, 38.61), length = 4.0, width = 7.0, heading = 68.23, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-311.75, -102.86, 38.6), length = 4.0, width = 7.0, heading = 249.57, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-313.22, -108.14, 38.6), length = 4.0, width = 7.0, heading = 249.39, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-315.89, -113.2, 38.6), length = 4.0, width = 7.0, heading = 251.28, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-318.12, -118.39, 38.6), length = 4.0, width = 7.0, heading = 251.19, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-319.13, -123.69, 38.61), length = 4.0, width = 7.0, heading = 249.68, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-320.98, -128.87, 38.61), length = 4.0, width = 7.0, heading = 250.63, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-323.23, -134.16, 38.6), length = 4.0, width = 7.0, heading = 251.79, minZ = 38.01, maxZ = 42.01 },
            { coords = vector3(-325.44, -139.15, 38.6), length = 4.0, width = 7.0, heading = 249.14, minZ = 38.01, maxZ = 42.01 },
        }
    },
    ['Innocence'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for every modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            },

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(-205.6992, -1312.7377, 31.1588),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            mods = true, 
            repair = true,
            armor = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            turbo = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(-212.55, -1320.56, 31.0), length = 6.0, width = 4.0, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
            { coords = vector3(-222.47, -1329.73, 31.0), length = 6.0, width = 4.0, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
        }
    },

    ['Power'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(-41.8942, -1044.1943, 28.6297),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            mods = false, 
            repair = true,
            armor = false,
            respray = false,
            liveries = false,
            wheels = false,
            tint = false,
            plate = false,
            extras = false,
            neons = false,
            xenons = false,
            horn = false,
            turbo = false,
            cosmetics = false,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(-32.48, -1065.38, 28.4), length = 6.0, width = 4.0, heading = 340.0, minZ = 27.0, maxZ = 31.0 },
            { coords = vector3(-38.12, -1052.85, 28.4), length = 6.0, width = 4.0, heading = 340.0, minZ = 27.0, maxZ = 31.0 },
        }
    },

    ['Popular'] = {
        settings = {
            label = 'Customs Motorworks',
            welcomeLabel = "Welcome to Customs Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(725.8828, -1088.7747, 22.1693),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            mods = false, 
            repair = true,
            armor = false,
            respray = false,
            liveries = false,
            wheels = false,
            tint = false,
            plate = false,
            extras = false,
            neons = false,
            xenons = false,
            horn = false,
            turbo = false,
            cosmetics = false,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(732.99, -1075.0, 22.17), length = 6.0, width = 4.0, heading = 180.0, minZ = 21.0, maxZ = 25.0 },
            { coords = vector3(731.47, -1088.91, 22.17), length = 6.0, width = 4.0, heading = 90.0, minZ = 21.0, maxZ = 25.0 },
        }
    },

    ['Harmony'] = {
        settings = {
            label = 'Harmony Motorworks',
            welcomeLabel = "Welcome to Harmony Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(1178.3921, 2640.5449, 37.7539),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            mods = false, 
            repair = true,
            armor = false,
            respray = false,
            liveries = false,
            wheels = false,
            tint = false,
            plate = false,
            extras = false,
            neons = false,
            xenons = false,
            horn = false,
            turbo = false,
            cosmetics = false,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(1182.11, 2640.3, 37.75), length = 6.0, width = 4.0, heading = 0.0, minZ = 36.0, maxZ = 40.0 },
            { coords = vector3(1174.78, 2640.17, 37.75), length = 6.0, width = 4.0, heading = 0.0, minZ = 36.0, maxZ = 40.0 },
        }
    },

    ['Hayes'] = {
        settings = {
            label = 'Hayes Motorworks',
            welcomeLabel = "Welcome to Hayes Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(-1420.1882, -441.8745, 35.9097),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = false,
        },
        categories = {
            mods = false, 
            repair = true,
            armor = false,
            respray = false,
            liveries = false,
            wheels = false,
            tint = false,
            plate = false,
            extras = false,
            neons = false,
            xenons = false,
            horn = false,
            turbo = false,
            cosmetics = false,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(-1417.12, -445.98, 35.91), length = 6.0, width = 4.0, heading = 32.0, minZ = 35.0, maxZ = 39.0 },
            { coords = vector3(-1423.67, -450.03, 35.91), length = 6.0, width = 4.0, heading = 32.0, minZ = 35.0, maxZ = 39.0 },
        }
    },

    ['Paleto'] = {
        settings = {
            label = 'Billys Motorworks',
            welcomeLabel = "Welcome to Billys Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(108.3242, 6624.0996, 31.7873),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            mods = false, 
            repair = true,
            armor = false,
            respray = false,
            liveries = false,
            wheels = false,
            tint = false,
            plate = false,
            extras = false,
            neons = false,
            xenons = false,
            horn = false,
            turbo = false,
            cosmetics = false,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {},
        zones = {
            { coords = vector3(110.93, 6626.51, 31.79), length = 6.0, width = 4.0, heading = 225.0, minZ = 30.5, maxZ = 34.5 },
            { coords = vector3(105.8, 6621.43, 31.79), length = 6.0, width = 4.0, heading = 225.0, minZ = 30.5, maxZ = 34.5 },
        }
    },

    ['Tunershop'] = {
        settings = {
            label = 'Tunershop',
            welcomeLabel = "Welcome to the Tunershop!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        blip = {
            label = 'Tunershop',
            coords = vector3(140.6093, -3030.3933, 7.0409),
            sprite = 446,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = false,
        },
        categories = {
            mods = false, 
            repair = true,
            armor = false,
            respray = false,
            liveries = false,
            wheels = false,
            tint = false,
            plate = false,
            extras = false,
            neons = false,
            xenons = false,
            horn = false,
            turbo = false,
            cosmetics = false,
        },
        drawtextui = {
            text = "الورشة",
            icon = "material-icons",
            materialIcon = 'construction',
        },
        restrictions = {},
        zones = {
            { coords = vector3(144.96, -3030.46, 7.06), length = 6.0, width = 4.0, heading = 180.0, minZ = 6.0, maxZ = 10.0 },
            { coords = vector3(135.92, -3030.5, 7.04), length = 6.0, width = 4.0, heading = 180.0, minZ = 6.0, maxZ = 10.0 },
        }
    },

    ['SASP'] = {
        settings = {
            label = 'SASP Motorworks',
            welcomeLabel = "Welcome to SASP Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            } ,

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
            
        },
        categories = {
            mods = true,
            repair = true,
            armor = true,
            respray = true,
            liveries = true,
            wheels = false,
            tint = true,
            plate = false,
            extras = true,
            neons = false,
            xenons = true,
            horn = false,
            turbo = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "الورشة",
        },
        restrictions = {
            job = { 'police', 'bcso', 'sasp' },
            allowedClasses = { 18, 15},
        },
        zones = {
            { coords = vector3(415.91, -998.07, 20.64), length = 9.0, width = 4.0, heading = 87.53, minZ = 20.34, maxZ = 24.34 },
            { coords = vector3(415.25, -1006.23, 20.647), length = 9.0, width = 4.0, heading = 268.71, minZ = 20.34, maxZ = 24.34 },
            { coords = vector3(-1079.59, -844.78, 4.88), length = 6.8, width = 4.0, heading = 36.46, minZ = 3.68, maxZ = 7.68 },
            { coords = vector3(-1111.67, -836.18, 13.34), length = 6.6, width = 4.0, heading = 306.72, minZ = 11.74, maxZ = 15.74 },
            { coords = vector3(-1115.25, -831.94, 13.34), length = 7, width = 4.0, heading = 306.72, minZ = 11.74, maxZ = 15.74 },
            { coords = vector3(-458.33, 6043.75, 31.15), length = 5.8, width = 3.0, heading = 315.47, minZ = 30.34, maxZ = 34.34 },
            { coords = vector3(-454.89, 6040.63, 31.15), length = 5.8, width = 3.0, heading = 315.47, minZ = 30.34, maxZ = 34.34 },--[[ 
            { coords = vector3(1880.31, 3696.86, 33.35), length = 5.6, width = 3.0, heading = 301.61, minZ = 32.88, maxZ = 36.88 },
            { coords = vector3(1877.7, 3701.49, 33.35), length = 5.6, width = 3.0, heading = 120.44, minZ = 32.88, maxZ = 36.88 }, ]]
            { coords = vector3(1856.9, 3693.01, 33.42), length = 5.6, width = 3.0, heading = 118.55, minZ = 32.47, maxZ = 34.47 },
            { coords = vector3(1853.23, 3699.25, 33.43), length = 5.6, width = 3.0, heading = 118.55, minZ = 32.47, maxZ = 34.47 },
            { coords = vector3(369.57, 792.94, 187.19), length = 5.6, width = 3.0, heading = 12.38, minZ = 186.47, maxZ = 188.47 },
            { coords = vector3(443.9, -1008.66, 24.26), length = 5.6, width = 3.0, heading = 91.01, minZ = 23.23, maxZ = 26.47 },
            { coords = vector3(443.99, -1012.98, 24.26), length = 5.6, width = 3.0, heading = 268.8, minZ = 23.23, maxZ = 26.47 },
            { coords = vector3(451.39, -976.05, 24.98), length = 5.6, width = 3.0, heading = 90.64, minZ = 23.23, maxZ = 26.47 },
            { coords = vector3(436.06, -975.91, 24.98), length = 5.6, width = 3.0, heading = 90.64, minZ = 23.23, maxZ = 26.47 },
--[[            { coords = vector3(374.03, 796.62, 186.94), length = 5.6, width = 3.0, heading = 356.34, minZ = 184, maxZ = 188 },
            { coords = vector3(1852.59, 3698.23, 33.37), length = 5.6, width = 3.0, heading = 122.6, minZ = 32.88, maxZ = 36.88 },
            { coords = vector3(1856.3, 3692.68, 33.8), length = 5.6, width = 3.0, heading = 119.13, minZ = 32.88, maxZ = 36.88 }, ]]
        }
    },
    

    ['Pillbox'] = {
        settings = {
            label = 'Pillbox Motorworks',
            welcomeLabel = "Welcome to Pillbox Motorworks!",
            enabled = true,
            ---------- Receipt system ----------
            useReceiptSystem = false,  -- In the case of "useReceiptSystem" = false everyone will need 
            -- pay for evenry modification and all modifications will be saved on the vehicle. 
            -- In the case of "useReceiptSystem = false" only players who don't have any job from list below "saveUpgrades"
            -- will receive a receipt and not have to pay for modifications. 

            
            saveUpgrades = { 
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will need to pay for every 
                                     -- modification, and all will be saved on the vehicle.
                dutyCheck = true, 
            },

            upgradesMenuAccess = {
                jobs = {"mechanic"}, -- If a player has some of these jobs, they will have access to the "upgrades menu" - engine upgrades, brake upgrades...
                dutyCheck = true,
            },
            ------------------------------------
        },
        categories = {
            mods = true, 
            repair = true,
            armor = false,
            respray = true,
            liveries = true,
            wheels = false,
            tint = false,
            plate = false,
            extras = true,
            neons = false,
            xenons = true,
            horn = false,
            turbo = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "الورشة"
        },
        restrictions = {
            job = { 'ambulance' },
            allowedClasses = { 18 },
        },
        zones = {
            { coords = vector3(306.78, -1427.95, 29.69), length = 9.4, width = 4.2, heading = 138.55, minZ = 27.5, maxZ = 31.5 },
        }
    },
}

