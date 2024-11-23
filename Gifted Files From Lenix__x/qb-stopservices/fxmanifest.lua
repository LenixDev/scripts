fx_version 'cerulean'
game 'gta5'

description 'Scripted By 24claw'
author 'Trust Store'
version '1.0.1'

client_scripts {
	'client/client.lua',
}

server_scripts {
	'server/main.lua'
}

lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }