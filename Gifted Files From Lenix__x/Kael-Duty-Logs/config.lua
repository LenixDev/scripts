Config = {
    Core = 'qb-core',  
}

Config.AuthJobs = { -- Make sure this list matches with server.lua WebHooks list
    ['police'] = { -- Add Your Webhook In Server/main.lua
        Color = 3447003,  -- For Color Code go here : https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812 and get INT Color Code
        LogTitle = 'LSPD Duty',
        IconURL = 'https://cdn.discordapp.com/attachments/1188949169981902898/1206313351089758309/logotype.png',
    },
    ['ambulance'] = { -- Add Your Webhook In Server/main.lua
        Color = 15158332,  -- For Color Code go here : https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812 and get INT Color Code
        LogTitle = 'EMS Duty Log',
        IconURL = 'https://cdn.discordapp.com/attachments/1188949169981902898/1206313351089758309/logotype.png',
    },
    ['mechanic'] = { -- Add Your Webhook In Server/main.lua
        Color = 15158332,  -- For Color Code go here : https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812 and get INT Color Code
        LogTitle = 'Mechanic Duty Log',
        IconURL = 'https://cdn.discordapp.com/attachments/1188949169981902898/1206313351089758309/logotype.png',
    },
    ['cardealer'] = { -- Add Your Webhook In Server/main.lua
        Color = 15158332,   -- For Color Code go here : https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812 and get INT Color Code
        LogTitle = 'PDM Duty Log',
        IconURL = 'https://cdn.discordapp.com/attachments/1188949169981902898/1206313351089758309/logotype.png',
    },
    ['japan'] = { -- Add Your Webhook In Server/main.lua
        Color = 15844367,  -- For Color Code go here : https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812 and get INT Color Code
        LogTitle = 'KOI Duty Log',
        IconURL = 'https://cdn.discordapp.com/attachments/1188949169981902898/1206313351089758309/logotype.png',
    },
    ['bahama'] = {
        Color = 15158332,   -- For Color Code go here : https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812 and get INT Color Code
        LogTitle = 'Bahama Duty Log',
        IconURL = 'https://cdn.discordapp.com/attachments/1188949169981902898/1206313351089758309/logotype.png',
    },
}

