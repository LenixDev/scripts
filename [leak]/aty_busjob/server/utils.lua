Framework = Config.Framework == "qb" and exports["qb-core"]:GetCoreObject() or exports['es_extended']:getSharedObject()
local avatars = {}

Functions = {
	REGISTER_SERVER_CALLBACK = function(...)
		if Config.Framework == "qb" then
			Framework.Functions.CreateCallback(...)
		else
			Framework.RegisterServerCallback(...)
		end
	end,

	GET_PLAYER_LICENSE = function(player)
		for i = 0, GetNumPlayerIdentifiers(player) - 1 do
			local license = GetPlayerIdentifier(player, i)
	
			if string.sub(license, 1, 7) == "license" then
				return license
			end
		end
	end,

                                                              
	GET_DATA = function(player)
		local file = LoadResourceFile(GetCurrentResourceName(), 'database.json')
		data = json.decode(file)

		local license = Functions.GET_PLAYER_LICENSE(player)

		for k, v in pairs(data) do
			if v.license == license then
				return v
			end
		end

		return false
	end,

	CHECK_IS_WORKING = function(src)
		for k, worker in pairs(Workers) do
			if worker.src == src then
				return worker
			end
		end

		return false
	end,

	GET_AVATAR = function(player)
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
					Authorization = "Bot " .. Config.Token
				})
	
				Citizen.Await(p)
			end
	
			avatars[player] = avatar or "assets/default.png"
		end
	
		return avatars[player] ~= "assets/default.png" and avatars[player] or "assets/default.png"
	end,
}