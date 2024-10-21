local QBCore = exports['qb-core']:GetCoreObject()
local CompanyAccounts = {}

function GetCompanyAccount(account)
	return CompanyAccounts[account] or 0
end

function AddCompanyMoney(account, amount)
	if not CompanyAccounts[account] then
		CompanyAccounts[account] = 0
	end

	CompanyAccounts[account] = CompanyAccounts[account] + amount
	MySQL.insert('INSERT INTO management_funds (job_name, amount, type) VALUES (:job_name, :amount, :type) ON DUPLICATE KEY UPDATE amount = :amount',
		{
			['job_name'] = account,
			['amount'] = CompanyAccounts[account],
			['type'] = 'boss'
		})
end

function RemoveCompanyMoney(account, amount)
	local isRemoved = false
	if amount > 0 then
		if not CompanyAccounts[account] then
			CompanyAccounts[account] = 0
		end

		if CompanyAccounts[account] >= amount then
			CompanyAccounts[account] = CompanyAccounts[account] - amount
			isRemoved = true
			MySQL.update('UPDATE management_funds SET amount = ? WHERE job_name = ? and type = "boss"', { CompanyAccounts[account], account })
		end
	end
	return isRemoved
end

MySQL.ready(function ()
	local bossmenu = MySQL.query.await('SELECT job_name,amount FROM management_funds WHERE type = "boss"', {})
	if not bossmenu then return end

	for _,v in ipairs(bossmenu) do
		CompanyAccounts[v.job_name] = v.amount
	end
end)

RegisterNetEvent("qb-bossmenu:server:CompanywithdrawMoney", function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player.PlayerData.company.isboss then ExploitBan(src, 'withdrawMoney Exploiting') return end

	local job = Player.PlayerData.company.name
	local grade = Player.PlayerData.company.grade.name
	if RemoveCompanyMoney(job, amount) then
		Player.Functions.AddMoney("cash", amount, 'Boss menu withdraw')	
		TriggerClientEvent('QBCore:Notify', src, "You have withdrawn: $" ..amount, "success")
	else
		TriggerClientEvent('QBCore:Notify', src, "You dont have enough money in the account!", "error")
	end

	TriggerClientEvent('qb-bossmenu:client:OpenCompanyMenu', src)
end)

RegisterNetEvent("qb-bossmenu:server:CompanydepositMoney", function(amount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player.PlayerData.company.isboss then ExploitBan(src, 'depositMoney Exploiting') return end

	if Player.Functions.RemoveMoney("cash", amount) then
		local job = Player.PlayerData.company.name
		local grade = Player.PlayerData.company.grade.name
		AddCompanyMoney(job, amount)
		--- Deposit Log Battal
		TriggerClientEvent('QBCore:Notify', src, "You have deposited: $" ..amount, "success")
	else
		TriggerClientEvent('QBCore:Notify', src, "You dont have enough money to add!", "error")
	end

	TriggerClientEvent('qb-bossmenu:client:OpenCompanyMenu', src)
end)

RegisterNetEvent("qb-bossmenu:server:CompanyaddAccountMoney", function(society, amount)
	if not society or not amount then return end
	AddCompanyMoney(society, amount)
end)

RegisterNetEvent("qb-bossmenu:server:CompanyremoveAccountMoney", function(society, amount)
	if not society or not amount then return end
	RemoveCompanyMoney(society, amount)
end)

QBCore.Functions.CreateCallback('qb-bossmenu:server:CompanyGetAccount', function(_, cb, jobname)
	local result = GetCompanyAccount(jobname)
	cb(result)
end)

QBCore.Functions.CreateCallback('qb-bossmenu:server:CompanyGetEmployees', function(source, cb, jobname)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if not Player.PlayerData.company.isboss then ExploitBan(src, 'GetEmployees Exploiting') return end

	local employees = {}
	local players = MySQL.query.await("SELECT * FROM `players` WHERE `company` LIKE '%".. jobname .."%'", {})
	if players[1] ~= nil then
		for _, value in pairs(players) do
			local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)

			if isOnline then
				employees[#employees+1] = {
				empSource = isOnline.PlayerData.citizenid,
				grade = isOnline.PlayerData.company.grade,
				isboss = isOnline.PlayerData.company.isboss,
				name = '🟢 ' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
				}
			else
				employees[#employees+1] = {
				empSource = value.citizenid,
				grade =  json.decode(value.company).grade,
				isboss = json.decode(value.company).isboss,
				name = '❌ ' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
				}
			end
		end
		table.sort(employees, function(a, b)
            return a.grade.level > b.grade.level
        end)
	end
	cb(employees)
end)

-- Grade Change
RegisterNetEvent('qb-bossmenu:server:CompanyGradeUpdate', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Player.PlayerData.company.isowner then 
		if Employee then
			if Employee.Functions.SetCompany(Player.PlayerData.company.name, data.grado) then
				TriggerClientEvent('QBCore:Notify', src, "Sucessfulluy promoted!", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been promoted to " ..data.nomegrado..".", "success")
				TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
			else
				TriggerClientEvent('QBCore:Notify', src, "Promotion grade does not exist.", "error")
			end
		else
			local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where citizenid = ?', { data.cid })
			if PlayerData then 
				PlayerData.company = json.decode(PlayerData.company)
				if QBCore.Shared.Company[Player.PlayerData.company.name] then
					PlayerData.company.name = Player.PlayerData.company.name
					PlayerData.company.label = QBCore.Shared.Company[Player.PlayerData.company.name].label
					PlayerData.company.onduty = QBCore.Shared.Company[Player.PlayerData.company.name].defaultDuty
					local grade = tostring(data.grado) or '1'
					if QBCore.Shared.Company[Player.PlayerData.company.name].grades[grade] then
						local companygrade = QBCore.Shared.Company[Player.PlayerData.company.name].grades[grade]
						PlayerData.company.grade = {}
						PlayerData.company.grade.name = companygrade.name
						PlayerData.company.grade.level = tonumber(grade)
						PlayerData.company.payment = companygrade.payment or 30
						PlayerData.company.isboss = companygrade.isboss or false
					else
						PlayerData.company.grade = {}
						PlayerData.company.grade.name = 'No Grades'
						PlayerData.company.grade.level = 1
						PlayerData.company.payment = 30
						PlayerData.company.isboss = false
					end
					MySQL.Async.prepare('UPDATE players SET company = ? WHERE citizenid = ?', { json.encode(PlayerData.company), data.cid })
					TriggerClientEvent('QBCore:Notify', src, "success", "success")
				end
			end
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "You are not owner", "error")
	end
	TriggerClientEvent('qb-bossmenu:client:OpenCompanyMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qb-bossmenu:server:CompanyFireEmployee', function(target)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(target)

	if not Player.PlayerData.company.isboss then ExploitBan(src, 'FireEmployee Exploiting') return end

	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.PlayerData.company.grade.level > Player.PlayerData.company.grade.level then TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error") return end
			if Employee.Functions.SetCompany("none", '1') then
				TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been fired! Good luck.", "error")
                TriggerClientEvent('QBCore:Player:UpdatePlayerData', Employee.PlayerData.source)
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
			Employee.company = json.decode(Employee.company)
			if Employee.company.grade.level > Player.PlayerData.company.grade.level then TriggerClientEvent('QBCore:Notify', src, "You cannot fire this citizen!", "error") return end
			local company = {}
			company.name = "none"
			company.label = "No Company"
			company.payment = QBCore.Shared.Company[company.name].grades['1'].payment or 10
			company.onduty = true
			company.isboss = false
			company.grade = {}
			company.grade.name = nil
			company.grade.level = 1
			MySQL.update('UPDATE players SET company = ? WHERE citizenid = ?', { json.encode(company), target })
			TriggerClientEvent('QBCore:Notify', src, "Employee fired!", "success")
		else
			TriggerClientEvent('QBCore:Notify', src, "Civilian not in city.", "error")
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenCompanyMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-bossmenu:server:CompanyHireEmployee', function(recruit)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Target = QBCore.Functions.GetPlayer(recruit)

	if not Player.PlayerData.company.isboss then ExploitBan(src, 'HireEmployee Exploiting') return end

	if Target and Target.Functions.SetCompany(Player.PlayerData.company.name, 0) then
		TriggerClientEvent('QBCore:Notify', src, "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.company.label .. "", "success")
		TriggerClientEvent('QBCore:Notify', Target.PlayerData.source , "You were hired as " .. Player.PlayerData.company.label .. "", "success")
        TriggerClientEvent('QBCore:Player:UpdatePlayerData', Target.PlayerData.source)
	end
	TriggerClientEvent('qb-bossmenu:client:OpenCompanyMenu', src)
end)

QBCore.Functions.CreateCallback('qb-bossmenu:Companygetplayers', function(source, cb)
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
            if ped.PlayerData.company.name == 'none' then 
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
	end
		table.sort(players, function(a, b)
			return a.name < b.name
		end)
	cb(players)
end)