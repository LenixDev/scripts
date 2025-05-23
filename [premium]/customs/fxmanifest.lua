fx_version 'cerulean'
game 'gta5'
author 'Lenix__x'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/menu.css',
    'html/js/ui.js',
    'html/imgs/*.png',
    'html/sounds/wrench.ogg',
    'html/sounds/respray.ogg'
}

shared_scripts {
    'config.lua',
    'shared/locations.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client/cl_ui.lua',
    'client/cl_bennys.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_bennys.lua', 
    'server/print_support_message.lua', 

}

lua54 'yes'


