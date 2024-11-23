Config = Config or {}

local whitelist = {
     models = {
          -- if a vehicle model exist in models script will skip class check!
          -- 'fiat600',
          'sjcop1'
     },
     classes = {
          -- https://docs.fivem.net/natives/?_0x29439776AAA00A62
          18 -- emergency
     },
     jobs = { 'police' },
     key_cutting_citizenid = {
          ''
     }
}

Config.gunrack = {
     keybind = 'j',
     install_duration = 3, --sec
     opening_duration = 3, --sec
     while_open_animation = true, -- while inventory screen is on
     slots = 15,
     size = 50000,
     whitelist = whitelist,
     disable_job_check = false, -- make sure it's false if your not using keys or everybody can unlock gunracks
     -- optional make sure you did optional part of installation
     use_keys_to_unlock_gunrack = false,
     cutting_duration = 3,
}
