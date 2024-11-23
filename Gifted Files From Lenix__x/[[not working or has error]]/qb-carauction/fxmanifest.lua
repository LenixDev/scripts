fx_version "cerulean"

games { "gta5" }


ui_page "./html/ui.html"


files{
    "./html/ui.html",
    "./html/*.css",
    "./html/*.js",
}

shared_scripts {
    'config.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

lua54 'yes'