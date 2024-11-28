-- Configuration settings for the GPS system.
Config                  = {}

-- Debug print setting for displaying debug messages.
Config.DebugPrint       = false

-- Locale setting for language localization.
Config.Locale           = "en"

-- ("esx" | "qb") -- > The latest version is always used.
Config.FrameWork        = "qb"

-- ("esx_notify" | "qb_notify" | "custom_notify") -- > System to be used
Config.NotifyType       = "qb_notify"

Config.Settings         = {
    StatusBars = {
        voice = {
            active = true
        },
        health = {
            active = true
        },
        armor = {
            active = true
        },
        hunger = {
            active = true
        },
        thirst = {
            active = true
        },
        stress = {
            active = false
        },
        terminal = {
            active = false
        },
        leaf = {
            active = false
        },
        oxygen = {
            active = true
        },
        stamina = {
            active = true
        },
    },
    VehicleHUD = {
        active = true,
        kmH = true, -- true = kmH, false = mpH
        lowFuelNotify = true,
        manualModeType = true
    },
    Compass = {
        active = true,
    },
}

Config.ElectricVehicles = {
    "Imorgon",
    "Neon",
    "Raiden",
    "Cyclone",
    "Voltic",
    "Voltic2",
    "Tezeract",
    "Dilettante",
    "Dilettante2",
    "Airtug",
    "Caddy",
    "Caddy2",
    "Caddy3",
    "Surge",
    "Khamelion",
    "RCBandito"
}
