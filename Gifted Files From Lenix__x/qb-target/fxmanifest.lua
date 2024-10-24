fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

files {
	'stream/*.ytd',
	'html/css/*.svg',
	'html/*.html',
	'html/css/*.css',
	'html/js/*.js',
	'compat/qb-target.lua',
}

lua54 'yes'
use_fxv2_oal 'yes'

client_scripts {
	'compat/qb-target.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'bone.lua',
	'client.lua',
}

escrow_ignore {
	'compat/qb-target.lua',
	'config.lua',
	'bone.lua',
	'client.lua',
}

dependency 'PolyZone'