fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
name 'https://github.com/lenix-x'

description 'Item Air Drop System'

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua",
}

client_scripts {
    "bridge/client.lua",
    "module/client.lua"
}

server_scripts {
    "bridge/server.lua",
    "module/server.lua"
}