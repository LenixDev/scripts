-- Toxic Fivem community    https://discord.gg/toxicfivem

Config = {
    Core = "qb", -- qb - QBCore | esx - ES Extended | newesx - New ES Extended
    WeatherEvent = "qb-weathersync:client:SyncWeather",
    SpawnCoords = {
        -- Example (UI X means left, UI Y means top): {label = "Label here", icon = "Icon here (Font Awesome Pro Icons - https://fontawesome.com/v5/search)", coords = vector3(-2041.12, -368.13, 48.1), heading = 0.0, ui = {x = 40, y = 40}},
        {label = "لوس سنتوس", icon = "fas fa-globe", coords = vector3(212.59, -880.7, 31.5), heading = 322.14, ui = {x = 35.5, y = 44.5}},
        {label = "ساندي شور", icon = "fas fa-globe", coords = vector3(2046.62, 3726.15, 32.9), heading = 55.08, ui = {x = 59, y = 62}},
        {label = "باليتو", icon = "fas fa-globe", coords = vector3(581.12, 6557.45, 28.02), heading = 70.88, ui = {x = 73, y = 49}},
        {label = "المستشفى", icon = "fas fa-hospital", coords = vector3(-1891.48, -393.76, 48.49), heading = 324.92, ui = {x = 38, y = 25}},
    },
    Infos = {
        ["date"] = true,
        ["weather"] = true,
        ["windSpeed"] = true,
        ["temperature"] = true,
        ["playerCount"] = true,
    },
    TemperatureType = "c", -- f - Fahrenheit° | c - Celsius
    WeatherIcons = {
        ["EXTRASUNNY"] = "fas fa-sun",
        ["CLEAR"] = "fas fa-sun-haze",
        ["NEUTRAL"] = "fas fa-sun-dust",
        ["SMOG"] = "fas fa-smog",
        ["FOGGY"] = "fas fa-fog",
        ["OVERCAST"] = "fas fa-clouds",
        ["CLOUDS"] = "fas fa-clouds",
        ["CLEARING"] = "fad fa-sun-cloud",
        ["HALLOWEEN"] = "fas fa-cloud-rainbow",
        ["RAIN"] = "fas fa-cloud-showers",
        ["THUNDER"] = "fad fa-thunderstorm",
        ["BLIZZARD"] = "fad fa-cloud-snow",
        ["SNOWLIGHT"] = "fad fa-cloud-hail",
        ["XMAS"] = "fad fa-snow-blowing",
        ["SNOW"] = "fad fa-snowflake",
    },
    EnableLastLocation = true
}