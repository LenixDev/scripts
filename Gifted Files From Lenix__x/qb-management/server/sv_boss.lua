local QBCore = exports['qb-core']:GetCoreObject()
local Accounts = {}

function ExploitBan(id, reason)
	MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		GetPlayerName(id),
		QBCore.Functions.GetIdentifier(id, 'license'),
		QBCore.Functions.GetIdentifier(id, 'discord'),
		QBCore.Functions.GetIdentifier(id, 'ip'),
		reason,
		2147483647,
		'qb-management'
	})
	-- TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(id), 'qb-management', reason), true)
	DropPlayer(id, 'You were permanently banned by the server for: Exploiting')
end

function GetAccount(account)
	return Accounts[account] or 0
end

exports('GetJobsBalance', function(account)
	if not account then return 0 end 
	return GetAccount(account)
end)

function AddMoney(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	Accounts[account] = Accounts[account] + amount
	MySQL.insert('INSERT INTO management_funds (job_name, amount, type) VALUES (:job_name, :amount, :type) ON DUPLICATE KEY UPDATE amount = :amount',
		{
			['job_name'] = account,
			['amount'] = Accounts[account],
			['type'] = 'boss'
		})
end

function RemoveMoney(account, amount)
	local isRemoved = false
	if amount > 0 then
		if not Accounts[account] then
			Accounts[account] = 0
		end

		if Accounts[account] >= amount then
			Accounts[account] = Accounts[account] - amount
			isRemoved = true
		end

		MySQL.update('UPDATE management_funds SET amount = ? WHERE job_name = ? and type = "boss"', { Accounts[account], account })
	end
	return isRemoved
end

MySQL.ready(function ()
	local bossmenu = MySQL.query.await('SELECT job_name,amount FROM management_funds WHERE type = "boss"', {})
	if not bossmenu then return end

	for _,v in ipairs(bossmenu) do
		Accounts[v.job_name] = v.amount
	end
end)

RegisterNetEvent("qb-bossmenu:server:withdrawMoney", function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player.PlayerData.job.isboss then ExploitBan(src, 'withdrawMoney Exploiting') return end

	local job = Player.PlayerData.job.name
	local grade = Player.PlayerData.job.grade.name
	if RemoveMoney(job, amount) then
		Player.Functions.AddMoney("cash", amount, 'Boss menu withdraw')
		TriggerClientEvent('QBCore:Notify', src, "You have withdrawn: $" ..amount, "success")
	else
		TriggerClientEvent('QBCore:Notify', src, "You dont have enough money in the account!", "error")
	end

	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-bossmenu:server:depositMoney", function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player.PlayerData.job.isboss then ExploitBan(src, 'depositMoney Exploiting') return end

	if Player.Functions.RemoveMoney("cash", amount) then
		local job = Player.PlayerData.job.name
		local grade = Player.PlayerData.job.grade.name
		AddMoney(job, amount)
		--- Deposit Log Battal
		-- TriggerEvent('qb-log:server:CreateLog', 'depositbattal', 'Deposit Money Boss Menu', "green", Player.PlayerData.name.. "  (citizenid :   " .. Player.PlayerData.citizenid ..  "  |    id : " .. src ..  ") amount   : $" .. amount .. '  job : ' .. job .. '  grade :  ' .. grade .. '', false)
		TriggerClientEvent('QBCore:Notify', src, "You have deposited: $" ..amount, "success")
	else
		TriggerClientEvent('QBCore:Notify', src, "You dont have enough money to add!", "error")
	end

	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-bossmenu:server:societyMoney", function(society, amount)
	if not society or not amount then return end
	AddMoney(society, amount)
end)

RegisterNetEvent("qb-bossmenu:server:JobsremoveAccountMoney", function(society, amount)
	if not society or not amount then return end
	RemoveMoney(society, amount)
end)

QBCore.Functions.CreateCallback('qb-bossmenu:server:GetAccount', function(_, cb, jobname)
	local result = GetAccount(jobname)
	cb(result)
end)

QBCore.Functions.CreateCallback('qb-bossmenu:server:GetEmployees', function(source, cb, jobname)
	local src = source
	local employees = {}
	if not Accounts[jobname] then
		Accounts[jobname] = 0
	end
	if jobname == "police" then 
		local players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", {})
		if players then
			for key, value in pairs(players) do
				players[key].job = json.decode(players[key].job)
				players[key].metadata = json.decode(players[key].metadata)
				players[key].charinfo = json.decode(players[key].charinfo)
				if players[key].job.name == jobname then
					local isOnline = QBCore.Functions.GetPlayerByCitizenId(players[key].citizenid)
					if isOnline then 
						employees[#employees+1] = {
							empSource = players[key].citizenid, 
							grade = players[key].job.grade,
							isboss = players[key].job.isboss,
							name = '🟢 ' .. players[key].charinfo.firstname .. ' ' .. players[key].charinfo.lastname,
							dutyhours = players[key].metadata.cops.dutyhours,
							dispatchpoints = players[key].metadata.cops.dispatchpoints or false,
							iswing = players[key].metadata.cops.iswing or false,
							dispatch = isOnline.PlayerData.metadata.cops.dispatch or false,
						}
					else
						employees[#employees+1] = {
							empSource = players[key].citizenid, 
							grade = players[key].job.grade,
							isboss = players[key].job.isboss,
							name = '🔴 ' .. players[key].charinfo.firstname .. ' ' .. players[key].charinfo.lastname,
							dutyhours = players[key].metadata.cops.dutyhours,
							dispatchpoints = players[key].metadata.cops.dispatchpoints or false,
							iswing = players[key].metadata.cops.iswing or false,
							dispatch = players[key].metadata.cops.dispatch or false,
						}
					end
				end
			end
			table.sort(employees, function(a, b)
				return a.grade.level > b.grade.level
			end)
			cb(employees)
		end
	elseif jobname == "ambulance" then
		local players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", {})
		if players then
			for key, value in pairs(players) do
				players[key].job = json.decode(players[key].job)
				players[key].metadata = json.decode(players[key].metadata)
				players[key].charinfo = json.decode(players[key].charinfo)
				if players[key].job.name == jobname then
					local isOnline = QBCore.Functions.GetPlayerByCitizenId(players[key].citizenid)
					if isOnline then 
						employees[#employees+1] = {
							empSource = players[key].citizenid, 
							grade = players[key].job.grade,
							isboss = players[key].job.isboss,
							name = '🟢 ' .. players[key].charinfo.firstname .. ' ' .. players[key].charinfo.lastname,
							dutyhours = players[key].metadata.ems.dutyhours,
							dispatchpoints = players[key].metadata.ems.dispatchpoints or false,
							iswing = players[key].metadata.ems.iswing or false,
							dispatch = isOnline.PlayerData.metadata.ems.dispatch or false,
						}
					else
						employees[#employees+1] = {
							empSource = players[key].citizenid, 
							grade = players[key].job.grade,
							isboss = players[key].job.isboss,
							name = '🔴 ' .. players[key].charinfo.firstname .. ' ' .. players[key].charinfo.lastname,
							dutyhours = players[key].metadata.ems.dutyhours,
							dispatchpoints = players[key].metadata.ems.dispatchpoints or false,
							iswing = players[key].metadata.ems.iswing or false,
							dispatch = players[key].metadata.ems.dispatch or false,
						}
					end
				end
			end
			table.sort(employees, function(a, b)
				return a.grade.level > b.grade.level
			end)
			cb(employees)
		end
	else
		local Player = QBCore.Functions.GetPlayer(src)
	
		if not Player.PlayerData.job.isboss then ExploitBan(src, 'GetEmployees Exploiting') return end
	
		local employees = {}
		local players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", {})
		if players[1] ~= nil then
			for _, value in pairs(players) do
				local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)
	
				if isOnline then
					employees[#employees+1] = {
					empSource = isOnline.PlayerData.citizenid,
					grade = isOnline.PlayerData.job.grade,
					isboss = isOnline.PlayerData.job.isboss,
					name = '🟢 ' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
					}
				else
					employees[#employees+1] = {
					empSource = value.citizenid,
					grade =  json.decode(value.job).grade,
					isboss = json.decode(value.job).isboss,
					name = '❌ ' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
					}
				end
			end
			table.sort(employees, function(a, b)
				return a.grade.level > b.grade.level
			end)
		end
		cb(employees)
	end
end)

RegisterNetEvent('qb-bossmenu:server:wing', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "sheriff" then
		if data.action == 1 then 
			if Employee then
				Employee.Functions.SetCopsPoints("iswing", true)
				TriggerClientEvent('QBCore:Notify', src, "Employee have been given a Air unit", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have a Air unit right now", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.cops.iswing = true
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Employee have been given a Air unit", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		else
			if Employee then
				Employee.Functions.SetCopsPoints("iswing", false)
				TriggerClientEvent('QBCore:Notify', src, "Air unit have been removed from this person", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "Air unit have been removed from you", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.cops.iswing = false
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Air unit have been removed from this person", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		end
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	elseif Player.PlayerData.job.name == "ambulance" then
		if data.action == 1 then 
			if Employee then
				Employee.Functions.SetEmsPoints("iswing", true)
				TriggerClientEvent('QBCore:Notify', src, "Employee have been given a air unit", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have a air unit right now", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.ems.iswing = true
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Employee have been given a Air unit", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		else
			if Employee then
				Employee.Functions.SetEmsPoints("iswing", false)
				TriggerClientEvent('QBCore:Notify', src, "Air unit have been removed from this person", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "Air unit have been removed from you", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.ems.iswing = false
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Air unit have been removed from this person", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		end
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	end
end)

RegisterNetEvent('qb-bossmenu:server:RemoveDispatch', function(target)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(target)
	if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "sheriff" then
		if Employee then
			Employee.Functions.SetCopsPoints("dispatch", false)
			TriggerClientEvent('QBCore:Notify', src, "Employee have been removed from dispatch", "success")
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been removed from dispatch", "success")
			TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
		else
			local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
			if player[1] ~= nil then
				Employee = player[1]
				Employee.metadata = json.decode(Employee.metadata)
				Employee.metadata.cops.dispatch = false
				MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), target })
				TriggerClientEvent('QBCore:Notify', src, "Employee have been removed from dispatch", "success")
			else
				TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
			end
		end
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	elseif Player.PlayerData.job.name == "ambulance" then
		if Employee then
			Employee.Functions.SetEmsPoints("dispatch", false)
			TriggerClientEvent('QBCore:Notify', src, "Employee have been removed from dispatch", "success")
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been removed from dispatch", "success")
			TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
		else
			local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
			if player[1] ~= nil then
				Employee = player[1]
				Employee.metadata = json.decode(Employee.metadata)
				Employee.metadata.ems.dispatch = false
				MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), target })
				TriggerClientEvent('QBCore:Notify', src, "Employee have been removed from dispatch", "success")
			else
				TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
			end
		end
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	end
end)

RegisterNetEvent('qb-bossmenu:server:addorRemovepoints', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "sheriff" then
		if data.action == 1 then 
			if Employee then
				local globalinfo = Employee.PlayerData.metadata['cops']
				globalinfo['dutyhours'] = globalinfo['dutyhours'] + data.amount
				Employee.Functions.SetCopsData(globalinfo)
				TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully added", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "Duty hours have been successfully added to your services", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.cops.dutyhours = Employee.metadata.cops.dutyhours + data.amount
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully added", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		else
			if Employee then
				local globalinfo = Employee.PlayerData.metadata['cops']
				globalinfo['dutyhours'] = globalinfo['dutyhours'] - data.amount
				if globalinfo['dutyhours'] < 0 then 
					globalinfo['dutyhours'] = 0 
				end
				Employee.Functions.SetCopsData(globalinfo)
				TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully removed", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "Duty hours have been removed to your services", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.cops.dutyhours = Employee.metadata.cops.dutyhours - data.amount
					if Employee.metadata.cops.dutyhours < 0 then 
						Employee.metadata.cops.dutyhours = 0 
					end
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully removed", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		end
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	elseif Player.PlayerData.job.name == "ambulance" then
		if data.action == 1 then 
			if Employee then
				local globalinfo = Employee.PlayerData.metadata['ems']
				globalinfo['dutyhours'] = globalinfo['dutyhours'] + data.amount
				Employee.Functions.SetEmsData(globalinfo)
				TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully added", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "Duty hours have been successfully added to your services", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.ems.dutyhours = Employee.metadata.ems.dutyhours + data.amount
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully added", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		else
			if Employee then
				local globalinfo = Employee.PlayerData.metadata['ems']
				globalinfo['dutyhours'] = globalinfo['dutyhours'] - data.amount
				if globalinfo['dutyhours'] < 0 then 
					globalinfo['dutyhours'] = 0 
				end
				Employee.Functions.SetEmsData(globalinfo)
				TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully removed", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "Duty hours have been removed to your services", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { data.cid })
				if player[1] ~= nil then
					Employee = player[1]
					Employee.metadata = json.decode(Employee.metadata)
					Employee.metadata.ems.dutyhours = Employee.metadata.ems.dutyhours - data.amount
					if Employee.metadata.ems.dutyhours < 0 then 
						Employee.metadata.ems.dutyhours = 0 
					end
					MySQL.Async.execute('UPDATE players SET metadata = ? WHERE citizenid = ?', { json.encode(Employee.metadata), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "Duty hours have been successfully removed", "success")
				else
					TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
				end
			end
		end
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	end
end)

-- Grade Change
RegisterNetEvent('qb-bossmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetJob(Player.PlayerData.job.name, data.grado) then
			TriggerClientEvent('QBCore:Notify', src, "Sucessfulluy promoted!", "success")
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been promoted to " ..data.nomegrado..".", "success")
			TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
		else
			TriggerClientEvent('QBCore:Notify', src, "Promotion grade does not exist.", "error")
		end
	else
		local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where citizenid = ?', { data.cid })
		if PlayerData then 
			PlayerData.job = json.decode(PlayerData.job)
			if QBCore.Shared.Jobs[Player.PlayerData.job.name] then
				PlayerData.job.name = Player.PlayerData.job.name
				PlayerData.job.label = QBCore.Shared.Jobs[Player.PlayerData.job.name].label
				PlayerData.job.onduty = QBCore.Shared.Jobs[Player.PlayerData.job.name].defaultDuty
				local grade = tostring(data.grado) or '0'
				if QBCore.Shared.Jobs[Player.PlayerData.job.name].grades[grade] then
					local jobgrade = QBCore.Shared.Jobs[Player.PlayerData.job.name].grades[grade]
					PlayerData.job.grade = {}
					PlayerData.job.grade.name = jobgrade.name
					PlayerData.job.grade.level = tonumber(grade)
					PlayerData.job.payment = jobgrade.payment or 30
					PlayerData.job.isboss = jobgrade.isboss or false
				else
					PlayerData.job.grade = {}
					PlayerData.job.grade.name = 'No Grades'
					PlayerData.job.grade.level = 0
					PlayerData.job.payment = 30
					PlayerData.job.isboss = false
				end
				MySQL.Async.prepare('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(PlayerData.job), data.cid })
				TriggerClientEvent('QBCore:Notify', src, "success", "success")
			end
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qb-bossmenu:server:FireEmployee', function(target)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(target)

	if not Player.PlayerData.job.isboss then ExploitBan(src, 'FireEmployee Exploiting') return end

	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.PlayerData.job.grade.level > Player.PlayerData.job.grade.level then TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error") return end
			if Employee.Functions.SetJob("unemployed", '0') then
				TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been fired! Good luck.", "error")
			else
				TriggerClientEvent('QBCore:Notify', src, "Error..", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You can\'t fire yourself", "error")
		end
	else
		local player = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
		if player[1] ~= nil then
			Employee = player[1]
			Employee.job = json.decode(Employee.job)
			if Employee.job.grade.level > Player.PlayerData.job.grade.level then TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error") return end
			local job = {}
			job.name = "unemployed"
			job.label = "Unemployed"
			job.payment = QBCore.Shared.Jobs[job.name].grades['0'].payment or 10
			job.onduty = true
			job.isboss = false
			job.grade = {}
			job.grade.name = nil
			job.grade.level = 0
			MySQL.update('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(job), target })
			TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
		else
			TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-bossmenu:server:HireEmployee', function(recruit)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Target = QBCore.Functions.GetPlayer(recruit)

	if not Player.PlayerData.job.isboss then ExploitBan(src, 'HireEmployee Exploiting') return end

	if Target and Target.Functions.SetJob(Player.PlayerData.job.name, 0) then
		TriggerClientEvent('QBCore:Notify', src, "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.job.label .. "", "success")
		TriggerClientEvent('QBCore:Notify', Target.PlayerData.source , "You were hired as " .. Player.PlayerData.job.label .. "", "success")
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
	end
end)

-- Get closest player sv
QBCore.Functions.CreateCallback('qb-bossmenu:getplayers', function(source, cb)
	local src = source
	local players = {}
	local PlayerPed = GetPlayerPed(src)
	local pCoords = GetEntityCoords(PlayerPed)
	for _, v in pairs(QBCore.Functions.GetPlayers()) do
		local targetped = GetPlayerPed(v)
		local tCoords = GetEntityCoords(targetped)
		local dist = #(pCoords - tCoords)
		if PlayerPed ~= targetped and dist < 10 then
			local ped = QBCore.Functions.GetPlayer(v)
			players[#players+1] = {
			id = v,
			coords = GetEntityCoords(targetped),
			name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
			citizenid = ped.PlayerData.citizenid,
			sources = GetPlayerPed(ped.PlayerData.source),
			sourceplayer = ped.PlayerData.source
			}
		end
	end
		table.sort(players, function(a, b)
			return a.name < b.name
		end)
	cb(players)
end)
