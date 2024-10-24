Config = {}
Config.Interior = vector3(968.2522, 75.63226, 116.16) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1037.69, -2736.86, 20.17) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(968.2522, 75.63226, 116.16, 212.0) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(972.33, 79.62, 116.18, 277.55) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(970.0944, 73.03827, 116.57, 33.0) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = false -- Define if the player can delete the character or not

Config.DefaultNumberOfCharacters = 2 -- Define maximum amount of default characters, Max 4 //ST4LTH
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}

Config.cinematiclocation = {
    [1] = vector4(-1007.53, -480.73, 50.22, 15.44), --start
    [2] = vector4(-1007.53, -479.14, 50.52, 15.44), --start left to right
    [3] = vector4(-1004.53, -477.33, 50.52, 75.44),  --stop right
    [4] = vector4(-1006.53, -473.53, 50.52, 135.00),  --move other way and right to left
    [5] = vector4(-1011.03, -476.33, 50.52, 275.00),  --stop left
}