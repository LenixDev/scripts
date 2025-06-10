Config = {}
  
Config.SQLScript = "oxmysql" -- oxmysql or mysql-async

Config.target = "qb-target"  -- qb-target or ox_target or drawtext

Config.interactionKey = 38 -- 38-E -- if you dont use target

Config.ProfilePhotoType = "steam" -- "discord", "steam", "none" --if you use steam profile photo, must be STEAM WEBAPI key in server.cfg

Config.DiscordToken = "" -- Your Discord Bot Token if you use Discord Profile Photo

Config.NoImage = "assets/images/default-pp.png"-- default image for leaderboard photo

Config.leaderboardMaxList = 30 -- max list for leaderboard
--==========================================================================================================================================
-- ======================================================GFX DEVELOPMENT=================================================================
--==========================================================================================================================================

Config.lumberjack = {
    pos = vector3(-552.54, 5348.58, 73.74),
    heading = 67.53,
    ped = "s_m_m_lathandy_01",
    blip = {
        sprite = 77,
        color = 2,
        scale = 0.8,
        name = "Lumberjack",
    },
    tutorialSection = {
        startPos =  vector3(-507.4150, 5256.8223, 80.6338),
        endPos =    vector3(-513.2879, 5271.7041, 79.5541),
        moneyPerCarriyngLog = 10, -- 1 log = 10 money
        propmodel = "prop_woodpile_01c",
        attachedCoords = {xPos = 0.715, yPos = 0.04, zPos = -0.185, xRot = -430.5, yRot = -213.5, zRot = 164.5}
        --0.715, 0.04, -0.185, -430.5, -213.5, 164.5
    },
    Money = {
        cuttingTreePerMoney  = 100, -- 1 tree = 100 money
    },
    CuttingTreeTime = 5000, -- 5 seconds
    TreeLocations = {
        vector3(-558.13, 5419.9, 62.19),
        vector3(-561.29, 5421.21, 61.28),
        vector3(-577.86, 5427.66, 58.05),
        vector3(-585.65, 5447.54, 59.35),
        vector3(-594.15, 5452.01, 58.47),
        vector3(-581.39, 5469.16, 58.75),
        vector3(-597.13, 5473.1, 55.46),
        vector3(-572.57, 5468.16, 60.43),
        vector3(-560.28, 5461.13, 62.5),
        vector3(-563.17, 5457.2, 62.15),
        vector3(-552.07, 5446.61, 63.11),
        vector3(-600.68, 5398.43, 51.42),
        vector3(-613.1, 5399.1, 50.65),
        vector3(-615.63, 5403.83, 49.2),
    },
    levelUpLimit = 5,--150 cutting trees number needed to level up
    axe = {
        tier3axe = "prop_ld_fireaxe",
        tier3axeUpgradeLimit = 100, -- 100 cutting trees number needed to upgrade tier3 axe
        tier3axeBonusPercent = 40, -- 40% bonus
        tier3axePos = {0.13, 0.055, 0.0, -304.5, 0.0, -196.0},
        tier2axe = "prop_w_me_hatchet",
        tier2axeUpgradeLimit = 50, -- 50 cutting trees number needed to upgrade tier2 axe
        tier2axeBonusPercent = 20, -- 20% bonus
        tier2axePos = {0.13,0.055,0.0,-492.5,188.5,-199.0,},
        tier1axe = "w_me_stonehatchet",
        tier1axePos = {0.13,0.055,0.0,-492.5,188.5,-199.0,},
    },
    contractSettings = {
        contractMoney = 100, -- 100 money
        maxTreeCount = 75, -- 100 tree
        maxPercent = 50, -- 50%
        contractNumberOfUses = 3, -- 3 times
        makeContractLevel = 5, -- 5 level
    }
}

Config.NotifyTexts = {
    lumberjackDataNotFound = "warning: lumberjack data not found",
    interaction = "Press [~g~E~w~] to cut tree",
    earnMoney = "You earned $%s",
    levelUp = "You're level up! Your Level %s",
    startjob = "You have started the job",
    stopjob = "You have stopped the job",
    cantmakecontract = "You can't make a contract",
    alreadystartjob = "You have already started the job",
    completeContract = "You have completed the contract",
}




function CreateBlipEntity(entity, sprite, color, text, isShortRange, blipSize)
    isShortRange = isShortRange ~= nil and isShortRange or true
    blipSize = blipSize ~= nil and blipSize or 1.0
    local blip = AddBlipForEntity(entity)
    SetBlipAsShortRange(blip, isShortRange)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, blipSize)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function CreateBlipCoord(coords, sprite, color, text, isShortRange, blipSize)
    isShortRange = isShortRange ~= nil and isShortRange or true
    blipSize = blipSize ~= nil and blipSize or 1.0
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipAsShortRange(blip, isShortRange)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, blipSize)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function DrawText3D(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextFont(4)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function Notify(msg)
    TriggerEvent('QBCore:Notify', msg)
    --TriggerEvent('esx:showNotification', msg)
end
