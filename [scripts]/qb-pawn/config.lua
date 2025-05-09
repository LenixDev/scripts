Config = {}

Config.PawnLocation = {
    [1] = {
        coords = vector3(92.99, -1554.1, 29.23),
        length = 5.4,
        width = 1,
        heading = 134.29,
        debugPoly = false,
        minZ = 28.79,
        maxZ = 32.79,
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
        item = "moneyroll1",--
        price = math.random(50,100)
    },
    [2] = {
        item = "moneyroll2",--
        price = math.random(100,200)
    },
    [3] = {
        item = "moneyroll3",--
        price = math.random(200,400)
    },
    [4] = {
        item = "moneyroll4",
        price = math.random(1000,1300)
    },
    [5] = {
        item = "moneybag",--
        price = math.random(1300,2000)
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
    item = '10kgoldchain',
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
