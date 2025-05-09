Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'HOME' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

Config.Toggle = false    -- If this is false the scoreboard stays open only when you hold the OpenKey button, if this is true the scoreboard will be openned and closed with the OpenKey button

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 100) -- It returns 48 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ['houserobbery'] = {
        minimumPolice = 3,
        busy = false,
        label = 'سرقة بيت',
    },
    ['storerobbery'] = {
        minimumPolice = 4,
        busy = false,
        label = 'سرقة بقالة',
    },
    ['jewellery'] = {
        minimumPolice = 7,
        busy = false,
        label = 'سرقة مجوهرات'
    },
    ['bankrobbery'] = {
        minimumPolice = 11,
        busy = false,
        label = 'سرقة بنك فليكا'
    },
    ['paleto'] = {
        minimumPolice = 12,
        busy = false,
        label = 'سرقة بنك باليتو'
    },
    ['pacific'] = {
        minimumPolice = 15,
        busy = false,
        label = 'سرقة بنك مركزي'
    },
}

-- Show ID's for all players or Opted in Staff
Config.ShowIDforALL = false
