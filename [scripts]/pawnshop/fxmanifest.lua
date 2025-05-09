fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'SKROB'
description 'Pawn Shop Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
}

dependencies {
    'ox_lib'
}

escrow_ignore {
    'config.lua', 
    'server/server.lua',
    "client/screenshot.lua",
    "client/client.lua"
}

dependency '/assetpacks'