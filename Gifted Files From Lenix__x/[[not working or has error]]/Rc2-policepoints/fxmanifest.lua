fx_version 'cerulean'
game 'gta5'
author 'jaber'
description 'police points made by jaber '
lua54 'yes'

client_script 'client/client.lua'
server_script { 'server/server.lua', '@oxmysql/lib/MySQL.lua' }
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }