fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    'config.lua',
    'locales/locales.lua',
}

client_scripts {
    'client/nui.lua',
    'client/utils.lua',
    'client/main.lua',
}

server_scripts {
    'serverconfig.lua',
    'server/utils.lua',
    'server/main.lua',
}

ui_page 'ui/index.html'

files {
    'ui/**/*.*',
    'ui/*.*',
    'database.json'
}

escrow_ignore {
    'config.lua',
    'locales/locales.lua',
    'client/nui.lua',
    'client/utils.lua',
    'client/main.lua',
    'serverconfig.lua',
    'server/utils.lua',
    'server/main.lua',
}
dependency '/assetpacks'