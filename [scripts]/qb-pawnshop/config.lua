Config = {}

Config.PawnLocation = {
    [1] = {
        coords = vector3(98.14, -1560.09, 29.61),
        length = 0.5,
        width = 1.0,
        heading = 265.71,
        debugPoly = false,
        minZ = 29.99,
        maxZ = 33.99,
        distance = 1.0
    },
}

Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = true -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 0 -- Opening Time
Config.TimeClosed = 5 -- Closing Time
Config.SendMeltingEmail = true

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.PawnItems = {
    [1] = {
        item = 'tenkgoldchain',
        price = math.random(1900,3800)
    },
    [2] = {
        item = 'rolex',
        price = math.random(2000,4000)
    },
    [3] = {
        item = 'goldbar',
        price = math.random(6000,8000)
    },
    [4] = {
        item = 'stolencoffee',
        price = math.random(10,20)
    },
    [5] = {
        item = 'stolencomputer',
        price = math.random(100,1000)
    },
    [6] = {
        item = 'stolenmicrowave',
        price = math.random(10,20)
    },
    [7] = {
        item = 'stolenmusic',
        price = math.random(20,40)
    },
    [8] = {
        item = 'stolentv',
        price = math.random(100,1500)
    },
    [9] = {
        item = 'stolenart',
        price = math.random(25,35)
    },
    [10] = {
        item = 'diamond',
        price = math.random(3000,5000)
    },
}

Config.MeltingItems = { -- meltTime is amount of time in minutes per item
    [1] = {
        item = 'goldchain',
        rewards = {
            [1] = {
                item = 'goldbar',
                amount = 2
            }
        },
        meltTime = 0.15
    },
    [2] = {
        item = 'diamond_ring',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [3] = {
        item = 'rolex',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            },
            [3] = {
                item = 'electronickit',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [4] = {
        item = 'tenkgoldchain',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 5
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
}
