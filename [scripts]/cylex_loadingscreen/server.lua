
local Data = {}
local playTime = {}
--  _____  ________  ________  ________  ___       _______   ________  ___  __    ________      
-- / __  \|\  ___  \|\   __  \|\  ___  \|\  \     |\  ___ \ |\   __  \|\  \|\  \ |\   ____\     
-- |\/_|\  \ \____   \ \  \|\  \ \____   \ \  \    \ \   __/|\ \  \|\  \ \  \/  /|\ \  \___|_    
-- \|/ \ \  \|____|\  \ \  \\\  \|____|\  \ \  \    \ \  \_|/_\ \   __  \ \   ___  \ \_____  \   
--      \ \  \  __\_\  \ \  \\\  \  __\_\  \ \  \____\ \  \_|\ \ \  \ \  \ \  \\ \  \|____|\  \  
--       \ \__\|\_______\ \_______\|\_______\ \_______\ \_______\ \__\ \__\ \__\\ \__\____\_\  \ 
--        \|__|\|_______|\|_______|\|_______|\|_______|\|_______|\|__|\|__|\|__| \|__|\_________\
--                                                                                   \|_________|
-- https://www.youtube.com/watch?v=bSN7Hhfk2QU                                                                                              
-- https://www.youtube.com/@1909Leaks-FreeScriptFivem                                                                                              
-- https://discord.gg/mRJFK5sTyr  & https://discord.gg/1909leaks 
RegisterServerEvent("getPlayerInfo",function()
    local player = source
    local identifier = GetIdent(player, "steam")
    local info = {
        steamPp = GetSteamPP(player),
        steamName = GetPlayerName(player),
        discordId = string.gsub(GetIdent(player, "discord"), "discord:", " "),
        steamId = identifier,
        playTime = Data[identifier].playtime
    }
    TriggerClientEvent("cylex:updateInfo", player, info)
end)

CreateThread(function()
    local file = json.decode(LoadResourceFile(GetCurrentResourceName(), "database.json"))
    if file then
        for k,v in pairs(file) do
            Data[k] = v
        end
    end
end)

function saveJson()
    SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(Data, {indent = true}), -1)
end

AddEventHandler("playerConnecting", function(name)
    local src = source
    local identifier = GetIdent(src, "steam")
    if not identifier then return end
    if not Data[identifier] then
        Data[identifier] = {
            playtime = 0
        }
        saveJson()
    end
    playTime[identifier] = os.time()
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    local identifier = GetIdent(src, "steam")
    if not playTime[identifier] then return end

    local currentTime = os.time()
    local elapsedSeconds = currentTime - playTime[identifier]
    local elapsedMinutes = math.floor(elapsedSeconds / 60)
    if elapsedMinutes > 0 then
        Data[identifier].playtime = math.floor(Data[identifier].playtime + elapsedMinutes)
        saveJson()
    end
    playTime[identifier] = nil
end)

function getSrcByIp(ip)
    -- make it without source
    for _, playerId in ipairs(GetPlayers()) do
        local playerIp = GetPlayerEndpoint(playerId)
        if playerIp:find(ip) then
            return playerId
        end
    end
    return nil
end


SetHttpHandler(function(req, res)
    local path = req.path
    -- local ipAddr = (req.address):gmatch("[^:%s]+")()
    local ip = tostring(req.address)
    local ipWithoutPort = ip:find(":") and ip:sub(1, ip:find(":") - 1) or ip
    local port = ip:sub(ip:find(":") + 1, #ip)

    res.writeHead(200, {["Access-Control-Allow-Origin"] = "*"})
    res.writeHead(200, {
        ["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    })
    res.writeHead(200, {
        ["Access-Control-Allow-Methods"] = "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    })


    
    local src = getSrcByIp(ipWithoutPort)
    if not src then return res.writeHead(404) end

    local steam = GetIdent(src, "steam")
    local tbl = {
        steamName = GetPlayerName(src),
        steamId = steam,
        discordId = GetIdent(src, "discord"),
        steamPp = GetSteamPP(src),
        playTime = Data[steam].playtime

    }

    return res.send(json.encode(tbl))

    -- req.setDataHandler(function(data)
    --     data = json.decode(data)

    --     if path:match("/getPlayerLocations") then
    --         local token = data and data.token or nil
    --         if not checkToken(token, "locations") then return res.writeHead(404) end

    --         local players = {}
            
    --         local CorePlayers = BSCore.Functions.GetQBPlayers()
    --         for _, playerId in ipairs(GetPlayers()) do
    --             playerId = tonumber(playerId)
    --             local player = CorePlayers[playerId]
    --             local playerBlip = {}
    --             local playerPed = GetPlayerPed(playerId)
    --             local coords = GetEntityCoords(playerPed)
    --             local heading = GetEntityHeading(playerPed)
    --             if player then
    --                 playerBlip = {
    --                     name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname,
    --                     source = playerId,
    --                     blip = "radar_level",
    --                     coords = coords,
    --                     heading = heading
    --                 }
        
    --                 local vehicle = GetVehiclePedIsIn(playerPed, false)
    --                 local isDead = Player(playerId).state.isDead
    --                 local noclipEnabled = Player(playerId).state.noclipEnabled
                    
    --                 if vehicle ~= 0 then
    --                     local hash = GetEntityModel(vehicle)
                        
    --                     playerBlip.blip = "radar_gang_vehicle"
    --                 end
    --             else
                    
    --                 playerBlip = {
    --                     name = "Bilinmiyor",
    --                     source = playerId,
    --                     blip = "radar_level",
    --                     coords = coords,
    --                     heading = heading
    --                 }
    --             end
    --             players[#players + 1] = playerBlip
    --         end
    --         return res.send(json.encode(players))
    --     end
    -- end)


end)