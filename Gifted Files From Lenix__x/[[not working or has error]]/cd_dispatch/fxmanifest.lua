fx_version 'bodacious'
games { 'gta5' }

author 'Codesign#2715'
description 'Police Dispatch'
version '1.1'

client_scripts {
	'config.lua',
    -- 'authorization.lua',
    'client/client.lua',
    'client/customise_me.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    -- 'authorization.lua',
    'server/server.lua',
    'server/customise_me.lua',
}

ui_page {
    'html/index.html',
}
files {
    'html/index.html',
    'html/css//**/*.css',
    'html/js/**/*.js',
    'html/config.js',
    'html/images/**/*.png',
    'html/images/**/*.svg',
    'html/images/**/*.jpg',
	'html/panic_sound.ogg',
    'html/notification.ogg',
}

exports {
    'GetPlayerInfo',
}





server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }