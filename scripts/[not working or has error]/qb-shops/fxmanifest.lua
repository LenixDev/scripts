fx_version 'cerulean'
game 'gta5'

description 'qb-Shops'
version '1.2.1'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/*otf',
    'html/*png',
    'html/fonts/*.ttf',
    'html/fonts/*.otf'
}

shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@qb-core/shared/locale.lua',
    'locale/en.lua',
    'locale/*.lua',
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

file 'json/shops-inventory.json'
lua54 'yes'