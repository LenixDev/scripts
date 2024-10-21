fx_version 'adamant'
games { 'rdr3', 'gta5' }
author 'Lenix__x'
ui_page 'src/nui/dronemenu.html'

client_scripts {
  'config.lua',
  'src/client/scaleforms.lua',
  'src/client/functions.lua',
  'src/client/main.lua',
}

server_scripts {
  'config.lua',
  'src/server/main.lua',
}

files {
  'src/nui/dronemenu.html',
  'src/nui/*.png'
}

dependencies {
  'qb-meta_libs',
  'qb-drones_stream'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua'
}