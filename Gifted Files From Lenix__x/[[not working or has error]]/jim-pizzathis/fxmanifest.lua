name "Jim-PizzaThis"
author "Jimathy"
version "v1.6.4"
description "Pizza This Job Script By Jimathy"
fx_version "cerulean"
game "gta5"

shared_scripts { 'config.lua', 'locales/*.lua',	'shared/*.lua' }
server_scripts { 'server/*.lua' }

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

lua54 'yes'

dependency '/assetpacks'