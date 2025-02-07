Framework = Config.CoreExport()
local avatars = {}

function RegisterServerCallback(...)
	if Config.Framework == "qb" then
		Framework.Functions.CreateCallback(...)
	else
		Framework.RegisterServerCallback(...)
	end
end

function GetExtendedPlayer(player)
	return Config.Framework == "esx" and Framework.GetPlayerFromId(player) or Framework.Functions.GetPlayer(player)
end

function _GetPlayerLicense(player)
	for i = 0, GetNumPlayerIdentifiers(player) - 1 do
		local license = GetPlayerIdentifier(player, i)

		if string.sub(license, 1, string.len("license:")) == "license:" then
			return license
		end
	end
end

function GetPlayerSquad(license)
	for _, squad in pairs(Squads) do
		if squad.leader.license == license then
			return squad
		end

		for _, member in pairs(squad.members) do
			if member.license == license then
				return squad
			end
		end
	end
end

function CreatePlayerData(src)
	local license = _GetPlayerLicense(src)
	local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
	local data = json.decode(file)
	
	if not data[license] then
		local xPlayer = GetExtendedPlayer(src)
		local name = Config.Framework == "esx" and xPlayer.getName() or xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname

		data[license] = {
            name = name,
            license = license,
            exp = 0,
            invites = true,
            image = "https://media.discordapp.net/attachments/582570734174339101/1200433004082909254/img-default.png?ex=65c6295b&is=65b3b45b&hm=8b1478afe20327b2b3936e7a52a0809684d1e806b839e1650b220d2f687ea4ad&=&format=webp&quality=lossless&width=61&height=70"
        }

        SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data), -1)
	end

	return data[license]
end

function _GetPlayerFromSource(src)
	local license = _GetPlayerLicense(src)
	local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
	local data = json.decode(file)

	if not data[license] then
		return CreatePlayerData(src)
	end

	return data[license]
end

function _GetPlayerFromLicense(license, src)
	local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
	local data = json.decode(file)

	if not data[license] then
		return CreatePlayerData(src)
	end

	return data[license]
end

function table.copy(t)
	local u = { }
	for k, v in pairs(t) do u[k] = v end
	return setmetatable(u, getmetatable(t))
end

function AddMoneyToPlayer(src, salary, exp)
	local xPlayer = GetExtendedPlayer(src)
	local license = _GetPlayerLicense(src)
	local file = LoadResourceFile(GetCurrentResourceName(), "database.json")
	local data = json.decode(file)

	data[license].exp = data[license].exp + exp

	SaveResourceFile(GetCurrentResourceName(), "database.json", json.encode(data), -1)

	if Config.Framework == "esx" then
		xPlayer.addMoney(salary)
	else
		xPlayer.Functions.AddMoney("cash", salary)
	end
end

function GetPlayerAvatar(player)
	if not avatars[player] then
		local identifiers = {}
		local numId = GetNumPlayerIdentifiers(player) - 1

		for i = 0, numId, 1 do
			local identifier = {}

			for id in string.gmatch(GetPlayerIdentifier(player, i), "([^:]+)") do
				table.insert(identifier, id)
			end

			identifiers[identifier[1]] = identifier[2]
		end

		local discord = identifiers["discord"]
		local avatar

		if discord then
			local p = promise.new()

			PerformHttpRequest("https://discordapp.com/api/users/" .. discord, function(statusCode, data)
				if statusCode == 200 then
					data = json.decode(data or "{}")

					if data.avatar then
						local animated = data.avatar:gsub(1, 2) == "a_"

						avatar = "https://cdn.discordapp.com/avatars/" ..
							discord .. "/" .. data.avatar .. (animated and ".gif" or ".png")
					end
				end

				p:resolve()
			end, "GET", "", {
				Authorization = "Bot " .. Config.DiscordBotToken
			})

			Citizen.Await(p)
		end

		avatars[player] = avatar or ""
	end

	return avatars[player] ~= "" and avatars[player] or "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"
end
