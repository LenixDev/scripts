local QBCore = exports['qb-core']:GetCoreObject()
local clearGSR = 15 -- minutes
local shotRecently = false
local shotRecently = false
local PlayerJob = {}

CreateThread(function() 
    if QBCore.Functions.GetPlayerData().job then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

-- RegisterCommand("cleargsr", function(source, args, raw)
-- 	if shotRecently then
-- 		local plyPed = PlayerPedId()
-- 		ClearPedBloodDamage(plyPed)
-- 		ClearPedEnvDirt(plyPed)
-- 		ResetPedVisibleDamage(plyPed)
-- 		shotRecently = false
-- 		-- Notify("You have cleared GSR from yourself")
--         TriggerClientEvent('QBCore:Notify',"You have cleared GSR from yourself", "error")
-- 	end
-- end)
-- TriggerEvent('chat:addSuggestion', "/cleargsr", "Clear GSR", {})

RegisterCommand("gsrtest", function(source, args, raw)
    plyData = QBCore.Functions.GetPlayerData()
    PlayerJob = plyData.job
    local player = PlayerPedId()
    local playerServerId = GetPlayerServerId(PlayerId())
    if ((PlayerJob.name == "police") and PlayerJob.onduty) or (source == GetPlayerServerId(PlayerId())) then
        local target = GetClosestPlayerRadius(2.0)
        if target == nil then
            QBCore.Functions.Notify('Target player not found', 'error')
            return
        end
        TriggerServerEvent("gsr:doTest", GetPlayerServerId(target))
    else
        QBCore.Functions.Notify('You must be a police officer to use this command / You are not a officer on duty', 'error')
    end
end)
TriggerEvent('chat:addSuggestion', "/gsrtest", "Do GSR test on closest player", {})

RegisterNetEvent('police:client:gsr', function(playerId, isSoftcuff)
    plyData = QBCore.Functions.GetPlayerData()
    PlayerJob = plyData.job
    local player = PlayerPedId()
    local playerServerId = GetPlayerServerId(PlayerId())

    if ((PlayerJob.name == "police") and PlayerJob.onduty) or (source == GetPlayerServerId(PlayerId())) then
        local target = GetClosestPlayerRadius(1.0)
        if target == nil then
            QBCore.Functions.Notify('Target player not found', 'error')
            return
        end
        exports["rpemotes"]:EmoteCommandStart("texting", 1)
        QBCore.Functions.Progressbar("gsr", "GSR Testing...", 15000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("gsr:doTest", GetPlayerServerId(target))
            Citizen.Wait(3000)
            exports["rpemotes"]:EmoteCancel(forceCancel)
        end, function() -- Cancel
            QBCore.Functions.Notify("GSR test canceled ..", "error")
        end)
    else
        QBCore.Functions.Notify('You must be a police officer to use this command / You are not a officer on duty', 'error')
    end
end)

-- Listen for when the "glaptop" item is used (event triggered)
RegisterNetEvent("gsr:testGSR")
AddEventHandler("gsr:testGSR", function()
    local playerPed = PlayerPedId()
    local playerServerId = GetPlayerServerId(PlayerId())

    local plyData = QBCore.Functions.GetPlayerData()
    local PlayerJob = plyData.job

    -- Check if the player is police or if it's the player triggering the event
    if (PlayerJob.name == "police" and PlayerJob.onduty) or (playerServerId == source) then
        local target = GetClosestPlayerRadius(2.0)

        if target then
            TriggerServerEvent("gsr:doTest", GetPlayerServerId(target))  -- Trigger server event for GSR test
        else
            QBCore.Functions.Notify('No target found', 'error')
        end
    else
        QBCore.Functions.Notify('You must be a police officer on duty to use this', 'error')
    end
end)

local whitelistedWeapons = {
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = true,
    [GetHashKey('WEAPON_SNOWBALL')] = true,
    [GetHashKey('WEAPON_PETROLCAN')] = true,
    [GetHashKey('WEAPON_BALL')] = true,
    [GetHashKey("WEAPON_STUNGUN")] = true,

}
Citizen.CreateThread(function()
	local lastShot = 0
	while true do
		Citizen.Wait(1)
		local plyPed = PlayerPedId()
		if IsPedShooting(plyPed) then
			local whash = GetSelectedPedWeapon(plyPed)
			if not whitelistedWeapons[whash] then		
				lastShot = GetGameTimer()
				shotRecently = true
			end
		end
		--print(tostring(shotRecently))

		if shotRecently and GetGameTimer() - lastShot >= (clearGSR * 60 * 1000) then; shotRecently = false; end 
	end
end)

RegisterNetEvent("gsr:requestGSR")
AddEventHandler("gsr:requestGSR", function(policeId)
	TriggerServerEvent("gsr:returnGSR", shotRecently, policeId)
end)

function GetClosestPlayerRadius(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(targetCoords - plyCoords)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

RegisterNetEvent("notify")
AddEventHandler("notify", function(s) Notify(s); end)

function Notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(false, true)
end