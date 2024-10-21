resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
author 'Lenix__x'

server_scripts {
	"config.lua",
	"server/main.lua",
}

client_scripts {
	"config.lua",
	"client/main.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js',
	'html/images/*.png'
}
server_scripts {
	'@mysql-async/lib/MySQL.lua'
}