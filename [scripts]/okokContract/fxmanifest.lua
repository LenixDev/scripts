fx_version 'cerulean'

game 'gta5'

author 'JUST-ME & Lenix__x'
description 'okokContract'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_script 'config.lua'

client_scripts {
	'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'client.lua',
	'server.lua'
}
dependency '/assetpacks'
server_scripts {
	'@mysql-async/lib/MySQL.lua'
}