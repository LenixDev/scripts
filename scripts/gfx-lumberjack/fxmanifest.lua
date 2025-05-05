
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
Author 'GFX - Psytion'
description 'GFX Lumberjack Job'
  
server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/open.lua',
    'server/server.lua'
}

client_scripts{
    'config.lua',
    'client/client.lua'
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/script.js',
    'nui/style.css',
    'nui/assets/images/**',
    'nui/assets/fonts/**'
}

escrow_ignore {
    'config.lua',
    'server/*.lua',
    'client/*.lua'
}
dependency '/assetpacks'