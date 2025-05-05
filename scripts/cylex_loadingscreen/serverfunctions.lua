function GetSteamPP(source)
	local identifier = GetIdent(source, "steam")
    print(identifier)
    if identifier:match("steam") then
        local callback = promise:new()
        PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', identifier), 16) .. '/?xml=1', function(Error, Content, Head)
            local SteamProfileSplitted = stringsplit(Content, '\n')
            if SteamProfileSplitted ~= nil and next(SteamProfileSplitted) ~= nil then
                for i, Line in ipairs(SteamProfileSplitted) do
                    if Line:find('<avatarFull>') then
                        callback:resolve(Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''))
                        break
                    end
                end
            end
        end)
        local avatar = Citizen.Await(callback)
        return avatar
    end
    return CYLEX.NoImage
end
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
    idType = idType ~= nil and idType
    local identifiers = GetPlayerIdentifiers(source)
    for i = 1, #identifiers do
        if identifiers[i]:match(idType) then
            return identifiers[i]
        end
    end
    return nil
end
