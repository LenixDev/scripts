NCHubPunchMachine.GetCore()
local BoxMachineList = {}
local insert,query = nil

CreateThread(function()
  for k, v in pairs(NCHubPunchMachine.Coords) do
    local objectId = math.random(100,9999)
    BoxMachineList[objectId] = {
      id = objectId,
      status = false,
      coords = {x = v["coords"].x, y = v["coords"].y, z = v["coords"].z, h = v["coords"].w},
      prop = v["prop"],
      offset = {x = v["offset"].x, y = v["offset"].y}
    }
  end
end)

if NCHubPunchMachine.SQL == 'oxmysql' then 
    insert = MySQL.insert
    query = MySQL.query.await
elseif NCHubPunchMachine.SQL == 'mysql-async' then 
    insert = MySQL.Async.insert
    query = MySQL.Sync.fetchAll
end

RegisterNetEvent('nchub-punchmachine:server:objectsync', function()
    local src = source
    for k, v in pairs(BoxMachineList) do
        TriggerClientEvent('nchub-punchmachine:client:BoxMachine', src, BoxMachineList[k].id, BoxMachineList[k].coords, BoxMachineList[k].prop, BoxMachineList[k].offset)
    end
    TriggerClientEvent("nchub-punchmachine:client:updateStatus", -1, BoxMachineList)
end)

RegisterNetEvent('nchub-punchmachine:server:updateStatus', function(objectId, status)
    BoxMachineList[objectId].status = status
    TriggerClientEvent('nchub-punchmachine:client:updateStatus', -1, BoxMachineList)
end)

RegisterNetEvent('nchub-punchmachine:server:syncBmuc', function(objectId, bmuc, boxmachinepos, rottype, h)
    TriggerClientEvent('nchub-punchmachine:client:syncBmuc', -1 ,objectId, bmuc, boxmachinepos, rottype ,h)
end)

RegisterNetEvent('nchub-punchmachine:server:MaxDistance', function(score)
    TriggerClientEvent('nchub-punchmachine:client:MaxDistance', -1, GetEntityCoords(GetPlayerPed(source)), 4, score)
end)


RegisterNetEvent('nchub-punchmachine:server:newscore', function(randomscore)
    local src = source
    local name = nil
    if NCHubPunchMachine.Framework == 'qb-core' then 
       local Player = QBCore.Functions.GetPlayer(src)
       name = Player.PlayerData.charinfo.firstname  .. ' ' .. Player.PlayerData.charinfo.lastname
    elseif NCHubPunchMachine.Framework == 'esx' then 
      local xPlayer = ESX.GetPlayerFromId(src)
      name = xPlayer.getName()
    end
    if NCHubPunchMachine.SQL == 'oxmysql' then 
      insert('INSERT INTO punchmachine (`name`, `score`) VALUES (?, ?)', {name,randomscore})
    elseif NCHubPunchMachine.SQL == 'mysql-async' then 
      insert('INSERT INTO punchmachine (name, score) VALUES (@name, @score)', {['@name'] = name, ['@score'] = randomscore})
    end
  end)

  if NCHubPunchMachine.Framework == 'qb-core' then 
    QBCore.Functions.CreateCallback('nchub-punchmachine:server:leaderboard', function(source, cb)
       local result = query('SELECT * FROM punchmachine ORDER BY score DESC LIMIT 3', {})
        cb(result)
    end)
elseif NCHubPunchMachine.Framework == 'esx' then 
    ESX.RegisterServerCallback('nchub-punchmachine:server:leaderboard', function(source, cb)
      local result = query('SELECT * FROM punchmachine ORDER BY score DESC LIMIT 3', {})
        cb(result)
    end)
end
