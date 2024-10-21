fx_version 'cerulean'
game 'gta5'
author 'Lenix__x'

description 'qb-misc'
version '1.0.0'


shared_scripts {
    'config.lua',
	'config/backpack.lua',
	'config/vinding.lua',
	'config/bunker.lua',
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/main.lua',
	'client/backpack.lua',
	'client/vinding.lua',
	'client/megaphone.lua',
	'client/bunker.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/backpack.lua',
	'server/vinding.lua',
	'server/bunker.lua',
}

lua54 'yes'