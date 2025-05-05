fx_version "cerulean"
game "gta5"

client_script {"client.lua", "cl_camera.lua"}

lua54 "yes"

ui_page "html/index.html"

files {
    "html/index.html",
    "html/style.css",
    "html/script.js",
    "assets/sfx/*.wav",
    "html/main.js",
}

shared_scripts {
    'config.lua',
}