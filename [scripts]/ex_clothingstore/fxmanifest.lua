description 'cl'
name ' cl'
author 'ex_clothing'
version 'v1.0.0'



ui_page 'html/index.html'


files {
  'html/index.html',
  'html/*.js',
  'html/*.css',
  'html/*.svg',
  'html/*.png',
  'html/categoryicons/*.svg',
  'html/categoryicons/*.png'



}

client_scripts {
    'config.lua',
    'client.lua'

}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'config.lua',
  'server.lua'
}


lua54 'yes'

escrow_ignore {
  'config.lua',
}



fx_version 'adamant'
games {'gta5'}