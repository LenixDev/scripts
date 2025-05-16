fx_version 'cerulean'
games { 'gta5' }
name "https://github.com/lenix-x"

client_scripts { 'client/cl_*.lua' }

shared_scripts { 'config.lua' }

server_scripts { 'server/sv_*.lua' }

ui_page {
    'html/index.html'
}

files {
    'html/*.*'
}

dependency 'MugShotBase64'