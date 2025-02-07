fx_version 'cerulean'
game 'common'
author 'atiysu'
lua54 'yes'
this_is_a_map 'yes'

shared_scripts {
    'config.lua',
    'locales.lua'
}

client_scripts {
    'client/utils.lua',
    'client/main.lua'
}

server_scripts {
    'server/utils.lua',
    'server/main.lua',
    'serverconfig.lua'
}

ui_page 'ui/index.html'

files{
    'database.json',
    'ui/**/*.*',
    'ui/*.*',
    'stream/starter_shells_k4mb1.ytyp'
}

escrow_ignore {
    'config.lua',
    'serverconfig.lua',
    'locales.lua',
    'client/*.lua',
    'server/*.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/starter_shells_k4mb1.ytyp'
dependency '/assetpacks'