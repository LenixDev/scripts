fx_version "cerulean"
game "gta5"

name "V7-LesterV1"
description "V7-LesterV1"
author "yazeed#5874"

shared_scripts {
	'config.lua'
}

server_scripts {
	"server/*",
	'@oxmysql/lib/MySQL.lua',
}

client_script 	"client/*"

ui_page 'html/html.html'
files {
	"html/lis.mp3",
	"html/script.js",
	"html/card.mp3",
	"html/html.html",
	"html/dril.mp3",
	"html/mask2.mp3",
	"html/mask.mp3",
	"html/yesornolister.mp3",
} -- Yazeed By {	}

lua54 'yes'