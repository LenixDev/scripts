fx_version 'cerulean'
game 'gta5'

name "impound"
description "Impound Script"
author "https://github.com/lenix-x"
version "1.0."

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

dependencies {
	'PolyZone',
	'qb-target',
}
