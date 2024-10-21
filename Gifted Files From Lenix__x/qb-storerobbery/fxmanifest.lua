fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot & Lenix__x'
description 'Allows players to rob various stores on the map for money and items'
version '1.2.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }