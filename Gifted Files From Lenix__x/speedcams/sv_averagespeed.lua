local mph = true
local units = "mph"
if main.useKmh ~= nil then
    mph = not main.useKmh
    if not mph then units = "km/h" end
end

RegisterServerEvent("Server:AverageSpeedDetection")
AddEventHandler("Server:AverageSpeedDetection",function(cameraId, speed, roadName, numberplate)
    local source = source
    if main.enableDiscordLogs then
        logToDiscord(source, cameraId, speed, roadName, numberplate)
    end
    -- Add permission checks here or link in with your database for vRP / ESX
    triggerevent('esx_billing:sendBill', source, 'society_police', _U('police'), amount, true)
end)

function mathRound(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10^numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end

function logToDiscord(source, cameraId, speed, roadName, numberplate)
    local webhookId = main.webhook
    local name = GetPlayerName(source)
    local date = os.date('*t')
    local time = os.date("*t")
    local embed = {
        {
            ["fields"] = {
                {
                    ["name"] = "**"..translations.name.."**",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "**"..translations.cameraId.."**",
                    ["value"] = cameraId * 12,
                    ["inline"] = true
                },
                {
                    ["name"] = "**"..translations.speedLimit.."**",
                    ["value"] = config[cameraId].limit.." "..units,
                    ["inline"] = true
                },
                {
                    ["name"] = "**"..translations.speedDetected.."**",
                    ["value"] = mathRound(speed, 1).." "..units,
                    ["inline"] = true
                },
                {
                    ["name"] = "**"..translations.roadName.."**",
                    ["value"] = roadName,
                    ["inline"] = true
                },
                {
                    ["name"] = "**"..translations.numberPlate.."**",
                    ["value"] = numberplate,
                    ["inline"] = true
                },
            },
            ["color"] = 16767002,
            ["title"] = "**"..translations.cameraActivation.."**",
            ["description"] = "",
            ["footer"] = {
                ["text"] = translations.timestamp..os.date("%A, %m %B %Y | "), ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec),
            },
            ["thumbnail"] = {
                ["url"] = main.webhookImage,
            },
        }
    }
    PerformHttpRequest(webhookId, function(err, text, headers) end, 'POST', json.encode({username = main.webhookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
end