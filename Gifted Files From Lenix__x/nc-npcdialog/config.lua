Config = {}

Config.Peds = {
    [1] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(73.831787, -1392.7, 28.376136, 277.04415),
        ["cam"] = vector4(74.872558, -1392.471, 29.874402, 92.32135), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [2] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(-708.8869, -151.7084, 36.415157, 112.55922),
        ["cam"] = vector4(-709.85, -152.4008, 37.845729, 300.95584), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [3] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(-1194.551, -767.4291, 16.316188, 214.22518),
        ["cam"] = vector4(-1193.935, -768.4427, 17.816808, 36.585895), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [4] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(-822.7662, -1072.156, 10.328105, 208.61535),
        ["cam"] = vector4(-822.2301, -1073.014, 11.873332, 31.267631), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [5] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(426.98831, -806.5037, 28.491153, 88.876358),
        ["cam"] = vector4(425.97729, -806.6006, 29.900154, 269.7893), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [6] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(-164.9866, -302.9776, 38.733276, 248.60443),
        ["cam"] = vector4(-163.8953, -303.1748, 40.094676, 74.902046), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [7] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(-1448.995, -238.1443, 48.813446, 44.772937),
        ["cam"] = vector4(-1449.776, -237.5166, 50.120895, 232.02082), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
    [8] = {
        ["model"] = "a_f_m_eastsa_01",
        ["coords"] = vector4(127.21329, -223.4624, 53.557811, 68.288764),
        ["cam"] = vector4(126.27536, -223.3124, 55.116981, 250.48123), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(79.030975, -1387.765, 28.376119),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38, -- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to npc", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },
        ["animDict"] = "amb@world_human_clipboard@male@base",
        ["animName"] = "idle_b",
        ["name"] = { -- Ped name
            ["firstname"] = "Candy", 
            ["lastname"] = "Miller",
        },
        ["title"] = "Clothing Store", -- the text you want to appear maybe character task etc.
        ["question"] = "Welcome, how can I assist you today? I'm here to help you refresh your style and feel absolutely comfortable at all times. Whether you're looking to upgrade your look or rejuvenate in a special way, you've come to the right place!", -- question or text
        ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. clothing menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Hm.. outfits menu", -- The answer to the option will appear in the person
                ["event"] = "qb-clothing:client:openOutfitMenu", -- Event name
                ["server"] = false, -- Make this true if there will be a server side event trigger
                ["client"] = true, -- If there will be a client side event trigger, make it true
                ["argument"] = "Hello World", -- You can send only 1 argument and this can include framework variables.                   
                ["selected"] = false, -- Don't touch this
            },
        }
    },
}