fx_version 'bodacious'

games {"gta5"}

ui_page "html/index.html"

shared_script "config.lua"
client_script "cl_*.lua"
server_script "sv_*.lua"

files {
    "html/*.html",
    "html/*.css",
    "html/*.js",
}

lua54 'yes'