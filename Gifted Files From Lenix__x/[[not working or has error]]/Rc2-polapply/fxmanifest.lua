fx_version 'cerulean'
games { 'gta5' }

description '[STANDALONE] Police Apply'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'cl_main.lua'
}

server_scripts {
    'sv_main.lua'
}

lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }