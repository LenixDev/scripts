GetSteamProfilePicture = function(source)
    local identifier = type(source) == "number" and  GetIdent(source) or source
    if not identifier then
        return Config.NoImage
    end
      
    if Config.ProfilePhotoType == "discord" then
        if identifier:match("discord") then
            local callback = promise:new()
            PerformHttpRequest('https://discordapp.com/api/users/' .. tonumber(GetIDFromSource('discord', identifier)), function(Error, Content, Head)
                local DiscordProfile = json.decode(Content)
                callback:resolve('https://cdn.discordapp.com/avatars/' .. DiscordProfile.id .. '/' .. DiscordProfile.avatar .. '.png')
            end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot " .. Config.DiscordToken})
            local avatar = Citizen.Await(callback)
            return avatar
        end
    elseif Config.ProfilePhotoType == "steam" then
        if identifier:match("steam") then
            local callback = promise:new()
            PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', identifier), 16) .. '/?xml=1', function(Error, Content, Head)
                local SteamProfileSplitted = stringsplit(Content, '\n')
                if SteamProfileSplitted ~= nil and next(SteamProfileSplitted) ~= nil then
                    for i, Line in ipairs(SteamProfileSplitted) do
                        if Line:find('<avatarFull>') then
                            callback:resolve(Line:gsub('<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''))
                            break
                        end
                    end
                end
            end)
            local avatar = Citizen.Await(callback)
            return avatar
        end
    elseif Config.ProfilePhotoType == "none" then
        return Config.NoImage
    end
    return ""
end

function GetIDFromSource(Type, CurrentID)
    local ID = stringsplit(CurrentID, ':')
    if (ID[1]:lower() == string.lower(Type)) then
        return ID[2]:lower()
    end
    return nil
end

function stringsplit(input, seperator)
    if seperator == nil then
        seperator = '%s'
    end

    local t={} ; i=1
    if input ~= nil then
        for str in string.gmatch(input, '([^'..seperator..']+)') do
            t[i] = str
            i = i + 1
        end
        return t
    end
end
  
function GetIdent(source, idType)
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if string.find(id, "steam:") then
            return id
        elseif string.sub(id, 1, string.len("discord:")) == "discord:" then
            return id
        end
    end
    return false
end


function ExecuteSqlPromise(query, parameters, cb)
    local promise = promise:new()

    if Config.SQLScript == "oxmysql" then
        exports.oxmysql:execute(query, parameters, function(data)
            promise:resolve(data)
            if cb then
                cb(data)
            end
        end)
    elseif Config.SQLScript == "ghmattimysql" then
        exports.ghmattimysql:execute(query, parameters, function(data)
            promise:resolve(data)
            if cb then
                cb(data)
            end
        end)
    elseif Config.SQLScript == "mysql-async" then
        MySQL.Async.fetchAll(query, parameters, function(data)
            promise:resolve(data)
            if cb then
                cb(data)
            end
        end)
    end
    return Citizen.Await(promise)
end

