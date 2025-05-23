fx_version 'adamant'

game 'gta5'


version '1.5.4'

ui_page 'html/index.html'

client_scripts {
	'shared/config.lua',
	'client.lua',
	'shared/client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'shared/config.lua',
	'server.lua',
	'shared/server.lua',
}

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/imgs/*.png',
	'html/imgs/items/*.png',
	'html/imgs/*.svg',
	'html/fonts/*.otf',
}
lua54 'yes'

escrow_ignore {
	'shared/*.lua'
}

