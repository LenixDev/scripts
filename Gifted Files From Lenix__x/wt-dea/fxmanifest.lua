fx_version 'cerulean'
games { 'gta5' }
author 'Lenix__x'
client_scripts { 'c/*.lua', 'shorts.lua' }

server_scripts { 's/*.lua', 'shorts.lua' }
ui_page { "./ui/index.html" }



files{ "./ui/index.html", "./ui/main.css", "./ui/main.js", "script.js" }
server_scripts { '@mysql-async/lib/MySQL.lua' }