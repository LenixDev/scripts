print("^2Jim^7-^2PizzaThis ^7v^41^7.^46^7.^44 ^7- ^2PizzaThis Job Script by ^1Jimathy^7")

-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {
	Debug = true,
	Lan = "en", -- Pick your language here
	img = "qb-inventory/html/images/", -- Change this to your inventory's name and image folder (SET TO "" IF YOU HAVE DOUBLE IMAGES)
	JimShop = false, -- If true shops will open in jim-shops
	CheckMarks = true, -- If true this will show the player if they have the correct items to be able to craft the items
	Notify = "qb",

		--Simple Toy Reward Support
	RewardItem = "", --Set this to the name of an item eg "bento"
	RewardPool = { -- Set this to the list of items to be given out as random prizes when the item is used - can be more or less items in the list
		"",
		"",
		"",
	},
	Locations = {
		{	zoneEnable = false,
			job = "pizza", -- Set this to the required job
			label = "Pizza", -- Set this to the required job
			zones = {
				vector2(304.21722412109, -994.26776123047),
  				vector2(279.33389282227, -994.15307617188),
  				vector2(280.68984985352, -964.00616455078),
 				vector2(304.20974731445, -963.95965576172),
			},
			--blip = vector3(288.61, -973.64, 29.87),
			blipcolor = 43,
			garage = { spawn = vector4(284.92, -957.09, 28.76, 267.76),
			out = vector4(284.79, -964.07, 29.41, 0.0),
			list = { "speedo", } },
		},
	},
	DrinkItems = {
		label = "Drinks Store",
		slots = 6,
		items = {
			{ name = "vodka", price = 5, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "sprunk", price = 5, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "sprunklight", price = 5, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "ecola", price = 5, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "ecolalight", price = 5, amount = 50, info = {}, type = "item", slot = 5, },
			{ name = "water_bottle", price = 5, amount = 50, info = {}, type = "item", slot = 6, },
		}
	},
	WineItems = {
		label = "Wine Store",
		slots = 6,
		items = {
			{ name = "amarone", price = 100, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "barbera", price = 100, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "dolceto", price = 100, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "housered", price = 100, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "housewhite", price = 100, amount = 50, info = {}, type = "item", slot = 5, },
			{ name = "rosso", price = 100, amount = 50, info = {}, type = "item", slot = 6, },
		}
	},

	FoodItems = {
		label = "Food Fridge Store",
		slots = 7,
		items = {
			{ name = "sauce", price = 6, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "pasta", price = 6, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "olives", price = 6, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "basil", price = 6, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "mozz", price = 6, amount = 50, info = {}, type = "item", slot = 5, },
			{ name = "lettuce", price = 6, amount = 50, info = {}, type = "item", slot = 6, },
			{ name = "pizzmushrooms", price = 6, amount = 50, info = {}, type = "item", slot = 7, },
			{ name = "tiramisu", price = 10, amount = 50, info = {}, type = "item", slot = 8, },
			{ name = "gelato", price = 10, amount = 50, info = {}, type = "item", slot = 9, },
			{ name = "medfruits", price = 10, amount = 50, info = {}, type = "item", slot = 10, },
			{ name = "toy_egg", price = 200, amount = 50, info = {}, type = "item", slot = 11, },
		}
	},
	FreezerItems = {
		label = "Freezer Store",
		slots = 2,
		items = {
			{ name = "meat", price = 10, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "squid", price = 10, amount = 50, info = {}, type = "item", slot = 2, },
		}
	},
}
Crafting = {
	Beer = {
		{ ['ambeer'] = { } },
		{ ['dusche'] = { } },
		{ ['logger'] = { } },
		{ ['pisswasser'] = { } },
		{ ['pisswasser2'] = { } },
		{ ['pisswasser3'] = { } },
	},
	Base = {
		{ ['pizzabase'] = { ['pizzadough'] = 1, ['sauce'] = 1, } },
	},
	Oven = {
		{ ['bolognese'] = { ['meat'] = 1, ['sauce'] = 1, } },
		{ ['calamari'] = { ['squid'] = 1, ['sauce'] = 1, } },
		{ ['meatball'] = { ['meat'] = 1, ['pasta'] = 1, } },
		{ ['alla'] = { ['ham'] = 1, ['pasta'] = 1, ['vodka'] = 1, } },
		{ ['pescatore'] = { ['squid'] = 1, } },
	},
	PizzaOven = {
		{ ['margheritabox'] = { ['pizzabase'] = 1, ['mozz'] = 1, } },
		{ ['marinarabox'] = { ['pizzabase'] = 1, ['basil'] = 1, } },
		{ ['prosciuttiobox'] = { ['pizzabase'] = 1, ['mozz'] = 1, ['ham'] = 1, ['pizzmushrooms'] = 1, } },
		{ ['diavolabox'] = { ['pizzabase'] = 1, ['mozz'] = 1, ['salami'] = 1, ['basil'] = 1, } },
		{ ['capricciosabox'] = { ['pizzabase'] = 1, ['ham'] = 1, ['pizzmushrooms'] = 1, ['olives'] = 1, } },
		{ ['vegetarianabox'] = { ['pizzabase'] = 1, ['mozz'] = 1, ['lettuce'] = 1, ['basil'] = 1, } },
	},
	ChoppingBoard = {
		{ ['salami'] = { ['meat'] = 1, } },
		{ ['ham'] = { ['meat'] = 1, } },
	},
}

Loc = {}