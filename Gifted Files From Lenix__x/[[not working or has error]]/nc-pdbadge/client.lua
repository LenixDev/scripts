local QBCore = exports['qb-core']:GetCoreObject()


local badgeShowing = false

RegisterNetEvent('qb-pdbadge:showPoliceBadge')
AddEventHandler('qb-pdbadge:showPoliceBadge', function(sentInfo)
	if not badgeShowing then
		local info = sentInfo
		local callsign = info['callsign']
		local firstname = info['firstname']
		local lastname = info['lastname']
		local job = info['job']
		local rank = info['rank']
		local picture = info['picture']
		local plyPed = PlayerPedId()
		local plyCoords = GetEntityCoords(plyPed)
		local badgeProp = CreateObject(`prop_fib_badge`, plyCoords.x, plyCoords.y, plyCoords.z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(plyPed, 28422)

		AttachEntityToEntity(badgeProp, plyPed, boneIndex, 0.065, 0.029, -0.035, 80.0, -1.90, 75.0, true, true, false, true, 1, true)
		RequestAnimDict('paper_1_rcm_alt1-9')
		TaskPlayAnim(plyPed, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, -1, 49, 0, 0, 0, 0)
		CreateThread(function()
			Wait(3100)
			ClearPedSecondaryTask(plyPed)
			DeleteObject(badgeProp)
		end)

		for _, player in ipairs(GetActivePlayers()) do
			local targetPed = GetPlayerPed(player)
			local targetPos = GetEntityCoords(targetPed)

			local dist = #(plyCoords -targetPos)
			if dist < 2.5 then
				local tgtId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed))
				TriggerServerEvent('qb-pdbadge:showTargetPoliceBadge', tgtId, callsign, firstname, lastname, job, rank, picture)
			end
		end	
	end
end)

RegisterNetEvent('qb-badge:client:createbadge',function()
    TriggerServerEvent('qb-badge:server:createbadge')
end)

RegisterNetEvent('qb-pdbadge:showTargetPoliceBadge')
AddEventHandler('qb-pdbadge:showTargetPoliceBadge', function(callsign, firstname, lastname, job, rank, picture)
	if badgeShowing then
        QBCore.Functions.Notify('Badge is already shown.', 'error')
		return
	end
	CreateThread(function()
		badgeShowing = true

		local Info = {
			callsign = callsign,
			firstname = firstname,
			lastname = lastname,
			job = job,
			rank = rank,
			picture = picture
		}

		SendNUIMessage({show = true, info = Info, type = "policebadge"})

		Wait(5000)
		SendNUIMessage({show = false })
		badgeShowing = false
	end)
end)