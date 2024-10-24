Config = {}
Config.Interior = vector4(-276.64, -970.42, 91.11, 7.11) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector4(-1037.85, -2737.63, 20.17, 148.64) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-276.64, -970.42, 91.11, 7.11) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-284.4, -949.21, 91.11, 58.86) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-277.37, -968.1, 91.61, 191.88) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = false -- Define if the player can delete the character or not
Config.customNationality = true -- Defines if Nationality input is custom of blocked to the list of Countries
Config.SkipSelection = false -- Skip the spawn selection and spawns the player at the last location

Config.DefaultNumberOfCharacters = 2 -- Define maximum amount of default characters (maximum 5 characters defined by default)
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}