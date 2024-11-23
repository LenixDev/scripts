--rainmad | fivem
Config = {}

Config['CasinoHeist'] = {
    ['nextHeist'] = 7200, -- seconds
    ['requiredItems'] = { -- you need to add them to database
        startKey = 'pinger',
        basementKey = 'laptop',
        drill = 'drill',
    },
    ['rewardItems'] = { -- you need to add them to database
        diamondTrolly = { 
            item = 'diamond', --item code
            count = 1, -- reward count
            sellPrice = 1300, -- for buyer sell price
        },
        goldTrolly = { 
            item = 'goldbar', 
            count = 1,
            sellPrice = 1800,
        },
        cokeTrolly = { 
            item = 'cokebaggy', 
            count = 1,
            sellPrice = 50,
        },
        cashTrolly = { 
            item = nil, -- cash
            count = 5000
        },
        lockbox = function()
            local items = {Config['CasinoHeist']['rewardItems']['diamondTrolly'], Config['CasinoHeist']['rewardItems']['goldTrolly']}
            local random = math.random(1, 2)
            local lockbaxBag = { -- random diamond or gold for lockbox drill reward
                item = items[random].item,
                count = 5
            }
            return lockbaxBag
        end,
    },
    ['startHeist'] = {
        ['cardSwipe'] = {
            scenePos = vector3(972.299, 50.9161, 120.625), -- swipe card animation position
            sceneRot = vector3(0.0, 0.0, 150.0), -- swipe card animation rotation
            swipeTeleport = vector3(2522.06, -244.12, -24.114), -- teleport after swipe
            startRappel = vector3(2517.70, -258.12, -25.114), -- start rappel action
            finishRappel = vector3(2571.85, -255.37, -145.35), -- finish rappel and play cutscene
            rappelTeleport = vector3(2512.93, -268.74, -59.623) -- teleport after rappel finish
        },
        ['rappel']= { -- rappel coords (enough)
            { coords = vector3(2570.48, -253.72, -64.660), busy = false},
            { coords = vector3(2571.48, -253.72, -64.660), busy = false},
            { coords = vector3(2572.53, -253.72, -64.660), busy = false},
            { coords = vector3(2573.53, -253.72, -64.660), busy = false},
            { coords = vector3(2574.53, -253.72, -64.660), busy = false},
        }
    },
    ['middleHeist'] = {
        ['guardPeds'] = { -- guard ped list (u can add new)
            { coords = vector3(2538.61, -274.93, -58.722), heading = 270.87, model = 'csb_tomcasino'},
            { coords = vector3(2540.50, -265.78, -58.723), heading = 177.93, model = 'csb_vincent'},
            { coords = vector3(2534.91, -284.13, -58.722), heading = 354.93, model = 'cs_fbisuit_01'},
            { coords = vector3(2534.66, -281.70, -58.722), heading = 177.88, model = 'cs_andreas'},
            { coords = vector3(2511.90, -275.53, -58.722), heading = 268.28, model = 'cs_casey'},
            { coords = vector3(2507.68, -278.53, -60.123), heading = 268.3, model = 'cs_stevehains'},
            { coords = vector3(2527.67, -280.25, -70.644), heading = 359.44, model = 's_m_m_armoured_02'},
            { coords = vector3(2488.03, -279.22, -70.694), heading = 265.05, model = 'cs_fbisuit_01'},
            { coords = vector3(2490.69, -263.38, -70.694), heading = 174.77, model = 'csb_vincent'},
            { coords = vector3(2477.92, -270.25, -70.694), heading = 180.79, model = 'cs_andreas'},
        },
        ['nightvision'] = {
            time = 20, -- seconds
            startPos = vector3(2515.47, -283.91, -70.709), -- emp start position
            baseDoors = { -- middle basement doors
                {coords = vector3(2475.37, -277.89, -70.694)},
                {coords = vector3(2475.41, -280.35, -70.694)}
            },
            baseKeypads = { -- middle basement keypads object
                {coords = vector3(2464.64, -276.69, -70.494), heading = 70.15},
                {coords = vector3(2464.64, -281.81, -70.494), heading = 110.15}
            }
        },
        ['vaultAction'] = {
            pos = vector3(2504.06, -239.36, -70.713), -- vault pos
            vaultScenePos = vector3(2504.97, -239.3403, -70.41885),
            vaultSceneRot = vector3(0.0, 0.0, 270.0)
        },
        ['vaultInside'] = {
            ['changeObjects'] = {
                --trolly (spawn new trolly) (u can add new)
                {  type = 'trolly', oldModel = 769923921, newModel = 881130828, coords = vector3(2524.77, -233.19, -71.737), heading = 44.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 881130828, coords = vector3(2517.12, -244.09, -71.737), heading = 44.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 269934519, coords = vector3(2518.17, -232.67, -71.737), heading = 204.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 269934519, coords = vector3(2517.17, -233.37, -71.737), heading = 224.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 2007413986, coords = vector3(2526.97, -241.63, -71.737), heading = 44.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 3031213828, coords = vector3(2523.12, -238.04, -71.737), heading = 284.3, grab = false},
                {  type = 'trolly', oldModel = 769923921, newModel = 3031213828, coords = vector3(2519.02, -238.71, -71.737), heading = 94.43, grab = false},
                --lockbox (they change with previous lockboxs on the map) (u can add but be careful when adding the coordinates because they are next to each other)
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2505.717, -251.9883, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2514.496, -257.8517, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2507.585, -223.1983, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2509.714, -221.5831, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2514.471, -219.1976, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2517.065, -218.5365, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2522.377, -218.1872, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2527.617, -219.2026, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2530.077, -220.2199, -71.73707), heading = nil, grab = false},
                {  type = 'lockbox', oldModel = -1578700034, newModel = -2110344306, coords = vector3(2534.500, -253.8684, -71.73707), heading = nil, grab = false},
            },
            ['keypads'] = { -- inside vault keypads
                { coords = vector3(2519.75, -250.6, -70.437), heading = 182.01, hacked = false},
                { coords = vector3(2533.1, -237.27, -70.437), heading = 269.0, hacked = false},
                { coords = vector3(2519.78, -226.47, -70.437), heading = 2.0, hacked = false},
            }
        }
    },
    ['finishHeist'] = {
        pos = vector3(2549.56, -269.40, -59.722),
        outsidePos = vector3(997.782, 44.1079, 80.9902),
        buyerPos = vector3(206.044, 7033.86, 1.15580),
    }
}

Strings = {
    ['start_heist'] = 'Press ~INPUT_CONTEXT~ to start Diamond Casino Heist',
    ['wait_nextheist'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['need_item'] = 'You need this: ',
    ['police_alert'] = 'Casino robbery alert! Check your gps.',
    ['go_rappel'] = 'Go to rappel',
    ['rappels_busy'] = 'All rappels is busy, try again in seconds.',
    ['rappel_start'] = 'Press ~INPUT_CONTEXT~ to rappel',
    ['rappel_action'] = '~INPUT_MOVE_DOWN_ONLY~ Down / ~INPUT_PICKUP~ Slide',
    ['go_base'] = 'Go to basement',
    ['emp_activated'] = 'EMP is active, be careful!',
    ['emp_deactivated'] = 'EMP is deactive, be careful! Go to middle doors.',
    ['swipe_card_base'] = 'Press ~INPUT_CONTEXT~ to swipe card',
    ['door_opened'] = 'Doors is opened. Go to vault.',
    ['laser_drill'] = 'Press ~INPUT_CONTEXT~ to laser drill',
    ['vault_open'] = 'Hurry up! Check at the gps to get out of the casino. You will need to use the via staff door again.',
    ['grab'] = 'Press ~INPUT_CONTEXT~ to grab trolly',
    ['lockbox_drill'] = 'Press ~INPUT_CONTEXT~ to lockbox drill',
    ['hack_keypad'] = 'Press ~INPUT_CONTEXT~ to hack keypad',
    ['exit_casino'] = 'Press ~INPUT_CONTEXT~ to exit casino',
    ['deliver_to_buyer'] = 'Deliver the loot to the buyer',
    ['base_blip'] = 'Basement',
    ['middle_doors_blip'] = 'Middle Doors',
    ['vault_blip'] = 'Vault',
    ['exit_blip'] = 'Exit Casino',
    ['buyer_blip'] = 'Buyer'
}

--Dont change cuzz those main and required things.
LaserDrill = {
    ['animations'] = {
        {'intro', 'bag_intro', 'intro_drill_bit'},
        {'drill_straight_start', 'bag_drill_straight_start', 'drill_straight_start_drill_bit'},
        {'drill_straight_end_idle', 'bag_drill_straight_idle', 'drill_straight_idle_drill_bit'},
        {'drill_straight_fail', 'bag_drill_straight_fail', 'drill_straight_fail_drill_bit'},
        {'drill_straight_end', 'bag_drill_straight_end', 'drill_straight_end_drill_bit'},
        {'exit', 'bag_exit', 'exit_drill_bit'},
    },
    ['scenes'] = {}
}

Lockbox = {
    ['objects'] = {
        'ch_prop_vault_drill_01a',
        'hei_p_m_bag_var22_arm_s',
        'ch_prop_ch_moneybag_01a'
    },
    ['animations'] = {
        {'enter', 'enter_ch_prop_ch_sec_cabinet_01abc', 'enter_ch_prop_vault_drill_01a', 'enter_p_m_bag_var22_arm_s'},
        {'action', 'action_ch_prop_ch_sec_cabinet_01abc', 'action_ch_prop_vault_drill_01a', 'action_p_m_bag_var22_arm_s'},
        {'reward', 'reward_ch_prop_ch_sec_cabinet_01abc', 'reward_ch_prop_vault_drill_01a', 'reward_p_m_bag_var22_arm_s', 'reward_ch_prop_ch_moneybag_01a'},
        {'no_reward', 'no_reward_ch_prop_ch_sec_cabinet_01abc', 'no_reward_ch_prop_vault_drill_01a', 'no_reward_p_m_bag_var22_arm_s'},
    }
}

Trolly = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'intro', 'bag_intro'},
        {'grab', 'bag_grab', 'cart_cash_dissapear'},
        {'exit', 'bag_exit'}
    }
}

HackKeypad = {
    ['animations'] = {
        {'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing'},
        {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
        {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
        {'fail_react', 'fail_react_ch_prop_ch_usb_drive01x', 'fail_react_prop_phone_ing'},
        {'reattempt', 'reattempt_ch_prop_ch_usb_drive01x', 'reattempt_prop_phone_ing'},
    },
    ['scenes'] = {}
}