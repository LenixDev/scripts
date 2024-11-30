fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'jomidar-hutingprops'
version      '1.1.1'
description  'A multi-framework hunting'
author       'Hasib'

files {
    'data/*.meta'
}

data_file 'WEAPONCOMPONENTSINFO_FILE' 'data/**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'data/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'data/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'data/**/weapons.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/a3d_hunting_ytyp.ytyp'

dependency '/assetpacks'