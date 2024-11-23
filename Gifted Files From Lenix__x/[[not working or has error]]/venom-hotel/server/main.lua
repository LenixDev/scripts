local venom = exports[Venom.CoreName]:GetCoreObject()
local KeysHolders = {}

CreateThread(function()
    Wait(500)
    exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms`", function(result)
        if not result then return end
        for k, v in pairs(result) do
            if result[k].isowned == 1 then
                local current = result[k].id
                Venom.Rooms[current].isOwned = true 
                Venom.Rooms[current].Owner = result[k].owner
                Venom.Rooms[current].locker.maxweight = result[k].maxweight
                Venom.Rooms[current].locker.slots = result[k].slots

                if result[k].keyholders ~= nil then
                    local keyholders = json.decode(result[k].keyholders)
                    local NamesTable = {}
                    for key, holder in pairs(keyholders) do 
                        table.insert(NamesTable, {
                            cid = holder.cid,
                            name = holder.name
                        })
                    end
                    KeysHolders[current] = NamesTable
                end
            end
        end
	end)
end)

venom.Functions.CreateCallback('venom-hotel_rooms:server:GetKeysHolders', function(source, cb, locker)
	cb(KeysHolders)
end)

venom.Functions.CreateCallback('venom-hotel_rooms:server:GetConfig', function(source, cb)
	cb(Venom.Rooms)
end)

venom.Functions.CreateUseableItem('venomkey' , function(source, item)
	local src = source
	local Info = item.info.roomnumber
	TriggerClientEvent('venom-hotel_rooms:client:RoomKey', src, tonumber(item.info.roomnumber))
end)

venom.Functions.CreateCallback('venom-hotel_rooms:server:GiveNewRoomKey', function(source, cb, roomNumber)
    local src = source
    local Player = venom.Functions.GetPlayer(src)
	local info = { roomnumber = tonumber(roomNumber)}
	if Player.Functions.AddItem("venomkey", 1, false, info) then
		TriggerClientEvent("inventory:client:ItemBox", src, venom.Shared.Items["venomkey"], "add")
		TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "hotelrooms", "Give New Room Keys Logs - Rooms", "yellow", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Room Num: "..tonumber(roomNumber).."**")
		cb(true)
	else
		cb(false)
	end

end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(Venom.DailyRentTimer)
		if nmsh ~= nil then
			exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms`", function(lockers)
				for k, v in pairs(lockers) do
					local FinalCost = (Venom.DailyRental / 24)
					if lockers[k].owner ~= nil then
						local citizenid = lockers[k].owner
						local Player = venom.Functions.GetPlayerByCitizenId(citizenid)
						if Player ~= nil then  ---online players
							local OwnerMoney = Player.Functions.GetMoney("bank")
							if tonumber(OwnerMoney) >= tonumber(FinalCost) then
								Player.Functions.RemoveMoney("bank", tonumber(FinalCost))
								TriggerEvent('venom-phone:server:sendNewMail', {
									sender = " Hotels Comapny",
									subject = "Payment completed successfully",
									message = "You just paid your hotel room fees $"..tonumber(FinalCost).."",
									button = nil
								}, citizenid)
							else
								if tonumber(lockers[k].flags) < 3 then
									lockers[k].flags = lockers[k].flags + 1
									exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `flags` = '"..lockers[k].flags.."' WHERE `id` = '"..lockers[k].id.."'")

									TriggerEvent('venom-phone:server:sendNewMail', {
										sender = " Hotels Comapny",
										subject = "Payment issue",
										message = "You did not pay your installments, and this is the "..lockers[k].flags.." warning!! <br><br>please pay the fees or you will lose your hotel room on the third warning",
										button = nil
									}, citizenid)
								elseif tonumber(lockers[k].flags) == 3 and tonumber(lockers[k].isowned) == 1 then
									exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `owner` = 'NULL',`flags` = '0', `ispaid` = '0', `keyholders` = '[]', `maxweight` = '"..Venom.Maxweight.."', `slots` = '"..Venom.MaxSlots.."', `isowned` = '0' WHERE `id` = '"..lockers[k].id.."'")

									TriggerEvent('venom-phone:server:sendNewMail', {
										sender = " Hotels Comapny",
										subject = "Payment issue",
										message = "You did not paid your installments, so you just lost your hotel room",
										button = nil
									}, citizenid)
		
									Venom.Rooms[lockers[k].id].isOwned = false
									Venom.Rooms[lockers[k].id].Owner = nil
									Venom.Rooms[lockers[k].id].locker.maxweight = lockers[k].maxweight
									Venom.Rooms[lockers[k].id].locker.slots = lockers[k].slots
		
									TriggerClientEvent('venom-hotel_rooms:client:Refresh', -1, Venom.Rooms)
								end
							end
						else
							---Offline players
							exports['oxmysql']:execute("SELECT * FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(OwnerData)
								if OwnerData[1] ~= nil then
									local OwnerMoney = json.decode(OwnerData[1].money)
									if tonumber(OwnerMoney.bank) >= tonumber(FinalCost) then
										OwnerMoney.bank = OwnerMoney.bank - tonumber(FinalCost)
										exports['oxmysql']:execute("UPDATE `players` SET `money` = '"..json.encode(OwnerMoney).."' WHERE `citizenid` = '"..citizenid.."'")
										if Player ~= nil then
											TriggerClientEvent('venom-hotelrooms:client:CinfirmPayment', Player.PlayerData.source, true)
										end
									else
										if tonumber(lockers[k].flags) < 3 then
											lockers[k].flags = lockers[k].flags + 1
											exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `flags` = '"..lockers[k].flags.."' WHERE `id` = '"..lockers[k].id.."'")

											TriggerEvent('venom-phone:server:sendNewMail', {
												sender = " Hotels Comapny",
												subject = "Payment issue",
												message = "You did not pay your installments in  palace room, and this is the "..lockers[k].flags.." warning!! <br><br>please pay the fees or you will lose your storage on the third warning",
												button = nil
											}, citizenid)
		
										elseif tonumber(lockers[k].flags) == 3 and tonumber(lockers[k].isowned) == 1 then
											exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `owner` = 'NULL',`flags` = '0', `ispaid` = '0', `keyholders` = '[]', `maxweight` = '"..Venom.Maxweight.."', `slots` = '"..Venom.MaxSlots.."', `isowned` = '0' WHERE `id` = '"..lockers[k].id.."'")

											TriggerEvent('venom-phone:server:sendNewMail', {
												sender = "Hotels Comapny",
												subject = "Payment issue",
												message = "Due to non-payment for the room at the  Palace, the room contract was cancelled..",
												button = nil
											}, citizenid)
		
											Venom.Rooms[lockers[k].id].isOwned = false
											Venom.Rooms[lockers[k].id].Owner = nil
											Venom.Rooms[lockers[k].id].locker.maxweight = lockers[k].maxweight
											Venom.Rooms[lockers[k].id].locker.slots = lockers[k].slots
			
											TriggerClientEvent('venom-hotel_rooms:client:Refresh', -1, Venom.Rooms)
										end
									end
								end
							end)
						end
					end
					Citizen.Wait(100)
				end
			end)
		end
    end
end)


venom.Functions.CreateCallback('venom-hotel_rooms:server:CheckOwned', function(source, cb)
	local src = source
	local Player = venom.Functions.GetPlayer(src)
	exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms` WHERE `owner` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
			cb(false)
		else
			cb(true)
		end
	end)
end)

RegisterNetEvent('venom-hotel_rooms:server:rentRoom', function(room)
	local src = source
	local Player = venom.Functions.GetPlayer(src)
	local Money = Player.Functions.GetMoney("bank")
    if Money >= Venom.RoomRentCost then
        if Player.Functions.RemoveMoney("bank", Venom.RoomRentCost) then
            exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms` WHERE `id` = '"..room.."'", function(result)
				if result[1] ~= nil then
                    Venom.Rooms[room].isOwned = true
                    Venom.Rooms[room].Owner = result[1].owner
                    Venom.Rooms[room].locker.maxweight = result[1].maxweight
                    Venom.Rooms[room].locker.slots = result[1].slots
					exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `isowned` = '1', `owner` = '"..Player.PlayerData.citizenid.."', `keyholders` = '[]', `ispaid` = '1' WHERE `id` = '"..room.."'")
					TriggerClientEvent('venom-hotel_rooms:client:Refresh', -1, Venom.Rooms)
					TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You have successfully Rented A new hotel room #'..room, "success")
					TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "housesrooms", "New Room Rent - houses Rooms", "red", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Room Num: "..room.."**")

					local info = { roomnumber = tonumber(room)}
					if Player.Functions.AddItem("venomkey", 1, false, info) then
						TriggerClientEvent("inventory:client:ItemBox", src, venom.Shared.Items["venomkey"], "add")
					end
				else
					exports['oxmysql']:execute("INSERT INTO `venom_hotel_rooms` (`id`, `isowned`, `owner`, `maxweight`, `slots`, `keyholders`, `ispaid`) VALUES ('"..room.."', '1', '"..Player.PlayerData.citizenid.."', '"..Venom.Maxweight.."', '"..Venom.MaxSlots.."', '[]', '1')")
					Venom.Rooms[room].isOwned = true
					Venom.Rooms[room].locker.maxweight = 500000
					Venom.Rooms[room].locker.slots = 20
					TriggerClientEvent('venom-hotel_rooms:client:Refresh', -1, Venom.Rooms)
					TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You have successfully Rented A new hotel room #'..room, "success")
					TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "housesrooms", "New Room Rent - houses Rooms", "red", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Room Num: "..room.."**")
					local info = { roomnumber = tonumber(room)}
					if Player.Functions.AddItem("venomkey", 1, false, info) then
						TriggerClientEvent("inventory:client:ItemBox", src, venom.Shared.Items["venomkey"], "add")
					end
				end
			end)
        end
	else
		TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You dont have enoght money to Rent new Room', "error")
	end
end)


venom.Functions.CreateCallback('venom-hotel_rooms:server:canOpenLocker', function(source, cb, locker)
	local src = source
	local Player = venom.Functions.GetPlayer(src)
	local isOwner = false

	exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms`  WHERE `id` = '"..locker.."'", function(result)
        if result[1] ~= nil then
			if result[1].owner == Player.PlayerData.citizenid then
				isOwner = true
			   cb(true, isOwner)
			else
				if result[1].keyholders ~= nil then
					local keyholders = json.decode(result[1].keyholders)
					local hasKey = false
					for k, v in pairs(keyholders) do 
						if v.cid == Player.PlayerData.citizenid and not hasKey then
							hasKey = true
							cb(true, isOwner)
						end
					end
					if not hasKey then
						cb(false)
					end
				else
					cb(false)
				end
			end
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('venom-hotel_rooms:server:GiveNewKey')
AddEventHandler('venom-hotel_rooms:server:GiveNewKey', function(Target, data)
	local src = source
	local Player = venom.Functions.GetPlayer(src)
	local Target = venom.Functions.GetPlayer(Target)
	local locker = data.locker
	if Target ~= nil then
		local TargetName = ""..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname..""
		exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms`  WHERE `id` = '"..locker.."'", function(result)
			if result[1] ~= nil then
				if result[1].keyholders ~= nil then
					local keyholders = json.decode(result[1].keyholders)
					for k, v in pairs(keyholders) do 
						if v.cid == Target.PlayerData.citizenid then
							TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'This player already have a key'..TargetName, "error")
							return
						end
					end

					table.insert(keyholders, {
						cid = Target.PlayerData.citizenid,
						name = TargetName
					})

					exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `keyholders` = '"..json.encode(keyholders).."' WHERE `id` = '"..locker.."'")
					TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You have successfully give a key to: '..TargetName, "success")
					TriggerClientEvent(Venom.CoreTriggerName..':Notify', Target.PlayerData.source, 'You have a new key for the motel room: #'..locker, "success")
					TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "hotelrooms", "Give Room key for A Player - Rooms", "green", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Key give to: "..Target.PlayerData.Name.."\n\n Room Num: "..locker.."$**")
					KeysHolders[locker] = keyholders
				else
					local keyholders = {}
					table.insert(keyholders, {
						cid = Target.PlayerData.citizenid,
						name = TargetName
					})

					exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `keyholders` = '"..json.encode(keyholders).."' WHERE `id` = '"..locker.."'")
					TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You have successfully give a key to: '..TargetName, "success")
					TriggerClientEvent(Venom.CoreTriggerName..':Notify', Target.PlayerData.source, 'You have got a new key for the hotel room Num: #'..locker, "success")
					TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "hotelrooms", "Give Room key for A Player - Rooms", "green", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Key give to: "..Target.PlayerData.Name .."\n\n Room Num: "..locker.."$**")
					KeysHolders[locker] = keyholders
				end
			end
		end)
	else
		TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'Player is offline', "error")
	end
end)


RegisterServerEvent('venom-hotel_rooms:server:RemoveKey', function(data)
	local src = source
	local Player = venom.Functions.GetPlayer(src)
	local locker = data.locker
	local citizenid = data.citizenid
	local name = data.name
	exports['oxmysql']:execute("SELECT * FROM `venom_hotel_rooms`  WHERE `id` = '"..locker.."'", function(result)
		if result[1] ~= nil then
			if result[1].keyholders ~= nil then
				local found = false
				local keyholders = json.decode(result[1].keyholders)
				for k, v in pairs(keyholders) do 
					if v.cid == citizenid then
						found = true
						table.remove(keyholders, k)
					end
				end
				if found then
					exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `keyholders` = '"..json.encode(keyholders).."' WHERE `id` = '"..locker.."'")
				   TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You have removed hotel keys from: '..name, "success")
				   TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "hotelrooms", "Remove Keys From a player - Rooms", "red", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Key removed from : "..data.name.."\n\n Room Num: "..locker.."$**")
				   KeysHolders[locker] = keyholders
				end
			end
		end
	end)
end)

RegisterNetEvent('venom-hotel_rooms:server:newlockerfeatures', function(data)
	local src = source
	local Player = venom.Functions.GetPlayer(src)
	local Money = Player.Functions.GetMoney("bank")
	local price = data.price
	local locker = data.locker
	if tonumber(Money) >= tonumber(price) then
		if data.action == "weight" then
			if Venom.Rooms[locker].locker.maxweight < data.choosed then
				Player.Functions.RemoveMoney("bank", tonumber(price))
				Venom.Rooms[locker].locker.maxweight = data.choosed
				exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `maxweight` = '"..tonumber(data.choosed).."' WHERE `id` = '"..locker.."'")
				TriggerClientEvent('venom-hotel_rooms:client:Refresh', -1, Venom.Rooms)
				TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'Your locker Weight has been sucessfully upgraded to '..tonumber(data.choosed), "success")
				TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "hotelrooms", "Weight Upgrade - Rooms", "yellow", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Room Num: "..locker.."\n\n Capacity : "..data.choosed.."\n\n Price : "..data.price.."$**")
			else
				TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'Max wight has been reached', "error")
			end
		else
			if Venom.Rooms[locker].locker.slots < data.choosed then
				Player.Functions.RemoveMoney("bank", tonumber(price))
				Venom.Rooms[locker].locker.slots = data.choosed
				exports['oxmysql']:execute("UPDATE `venom_hotel_rooms` SET `slots` = '"..tonumber(data.choosed).."' WHERE `id` = '"..locker.."'")
				TriggerClientEvent('venom-hotel_rooms:client:Refresh', -1, Venom.Rooms)
				TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'Your locker Slots has been sucessfully upgraded to '..tonumber(data.choosed), "success")
				TriggerEvent(Venom.LogsTrigger..":server:CreateLog", "hotelrooms", "Slots Upgrade - Rooms", "yellow", "** Player Name: "..Player.PlayerData.name.."\n\n CitizenId: "..Player.PlayerData.citizenid.."\n\n Room Num: "..locker.."\n\n Slots: "..data.choosed.."\n\n Price : "..data.price.."$**")
			else
				TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'Max slots has been reached', "error")
			end
		end
	else
		TriggerClientEvent(Venom.CoreTriggerName..':Notify', src, 'You dont have enoght money to upgrade '..data.choosed, "error")
	end
end)