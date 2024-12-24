fx_version "adamant"
name 'https://github.com/lenix-x'

game "gta5"
lua54 'yes'
description 'an-pursuitmode'

client_scripts { 
    "config.lua",
    "client.lua",
    "import.lua"
}

shared_scripts {
    '@ox_lib/init.lua',
}

exports {
    'GetVehicleMode',
}
 
