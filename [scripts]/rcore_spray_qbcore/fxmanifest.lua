fx_version 'bodacious'
game 'gta5'
author 'Lenix__x'

description 'rcore spray'

version '1.1.0'

-- Leaked by Geritos / # Launcher Leaks

client_scripts {
	'config.lua',
	'client/warmenu.lua',
	'client/fonts.lua',
	'client/determinant.lua',
	'client/raycast.lua',
	'client/client.lua',
	'client/spray_rotation.lua',
	'client/control.lua',
	'client/remove.lua',
	'client/time.lua',
	'client/cancellable_progress.lua',
}

server_scripts {
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/db.lua',
	'server/server.lua',
	'server/remove.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua'
}
