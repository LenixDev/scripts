fx_version "cerulean"
game "gta5"
lua54 "yes"
description "cylex_loadingScreen"

escrow_ignore {
    'config/config.lua',
    'html/config.json',
}
--  _____  ________  ________  ________  ___       _______   ________  ___  __    ________      
-- / __  \|\  ___  \|\   __  \|\  ___  \|\  \     |\  ___ \ |\   __  \|\  \|\  \ |\   ____\     
-- |\/_|\  \ \____   \ \  \|\  \ \____   \ \  \    \ \   __/|\ \  \|\  \ \  \/  /|\ \  \___|_    
-- \|/ \ \  \|____|\  \ \  \\\  \|____|\  \ \  \    \ \  \_|/_\ \   __  \ \   ___  \ \_____  \   
--      \ \  \  __\_\  \ \  \\\  \  __\_\  \ \  \____\ \  \_|\ \ \  \ \  \ \  \\ \  \|____|\  \  
--       \ \__\|\_______\ \_______\|\_______\ \_______\ \_______\ \__\ \__\ \__\\ \__\____\_\  \ 
--        \|__|\|_______|\|_______|\|_______|\|_______|\|_______|\|__|\|__|\|__| \|__|\_________\
--                                                                                   \|_________|
-- https://www.youtube.com/watch?v=bSN7Hhfk2QU                                                                                              
-- https://www.youtube.com/@1909Leaks-FreeScriptFivem                                                                                              
-- https://discord.gg/mRJFK5sTyr  & https://discord.gg/1909leaks 
shared_script 'config/config.lua'

server_scripts {
    'server.lua',
    'serverfunctions.lua',
}

loadscreen { 'html/index.html' }
loadscreen_cursor 'yes'
loadscreen_manual_shutdown 'yes'

files {
    "html/*.*",
    "html/img/*.*"
}

