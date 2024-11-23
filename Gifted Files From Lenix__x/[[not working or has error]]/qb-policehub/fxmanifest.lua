fx_version 'cerulean'
game 'gta5'
lua54 'yes'

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/sv_*.lua',
}

client_script {
	'client/cl_*.lua',
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/imgs/*.png',
	'html/imgs/*.jpg',
	'html/audios/*.mp3',
	'html/audios/*.ogg',
	'html/*.ttf',
}

shared_script { 'config.lua', 'sh_main.lua' }

dependency '/assetpacks'
