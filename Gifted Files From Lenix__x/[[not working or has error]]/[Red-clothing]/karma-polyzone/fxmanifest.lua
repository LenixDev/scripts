fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

dependencies {
  "PolyZone"
}

client_scripts {
  "@PolyZone/client.lua",
  "@PolyZone/BoxZone.lua",
  "@PolyZone/CircleZone.lua",
  "@PolyZone/ComboZone.lua",
  "@PolyZone/EntityZone.lua",
  'client/cl_*.lua'
}

server_scripts {
  'server/sv_*.lua',
  'server/sv_*.js',
}

