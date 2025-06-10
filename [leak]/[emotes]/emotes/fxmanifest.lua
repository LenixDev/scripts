fx_version "cerulean"
lua54 'yes'
games { "gta5" }
name 'https://github.com/lenix-x'

description "Boilerplate"

version "0.1.0"

-- Load NUI project
--ui_page 'http://localhost:3000'
ui_page 'nui/dist/index.html'

files {
    "nui/dist/**/*",
}

server_scripts { "build/sv_*.js" }
client_scripts { "build/cl_*.js", "*.js", "animals.lua", "client.lua" }
