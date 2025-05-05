fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Canary\'s HUD UI for QBCore'
version 'v1.1'
author 'Canary\'s Development & Lenix__x'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'shared/config.lua',
}

client_scripts {
    'client/client.lua',
    'shared/config.lua',
    'essentials.lua',
    'client/gears.lua',
    'client/seatbelt.lua',
}

server_scripts {
    'server/main.lua',
    'shared/config.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/javascript.js',
}

escrow_ignore {
    'shared/config.lua',
    'stream/*.yft',
    'stream/*.gfx',
}