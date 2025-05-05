NCHubPunchMachine.GetCore()
local BoxMachineList = {}
local tempid,tempbmuc,tempos,h = nil
local listen = false

local function Animation(dict,anim)
  local AnimDict = dict
  local PlayerPed = PlayerPedId()
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Wait(10)
    end
    TaskPlayAnim(PlayerPed, AnimDict, anim, 5.0, -1, -1, 0, 0, false, false, false)
end

local function ReqModel(modelHash)
  if not HasModelLoaded(modelHash) then
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
     end
  end
end

local function SyncSound(soundname)
  TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, soundname , volume)
end

local function SyncServer(event,id,bmuc,pos,rottype,h)
  TriggerServerEvent(event,id,bmuc,pos,rottype,h)
end

local function MiniGame()
  SetNuiFocus(true,true)
  SendNUIMessage({status = "minigame", type = NCHubPunchMachine.MiniGame})
end

local function ScoreList(result)
  SetNuiFocus(true,true)
  SendNUIMessage({status = "scorelist", result = result})
end

local function ZoneLoop(objectId, bmuc, boxmachinepos,heading)
  CreateThread(function()
    while listen do
        if IsControlJustPressed(0, 38) then
          TriggerEvent('nchub-punchmachine:client:insertCoin', objectId, bmuc, boxmachinepos,heading)
        elseif IsControlJustPressed(0, 47) then
          TriggerEvent('nchub-punchmachine:client:scoreList')
        end
        Wait(10)
    end
  end)
end

CreateThread(function()
  ReqModel('box_machine')
  ReqModel('box_machine2')
  ReqModel('bm_uc')
  TriggerServerEvent("nchub-punchmachine:server:objectsync")
end)

RegisterNetEvent("nchub-punchmachine:client:BoxMachine", function(objectId,coords,prop,offset)
    local boxmachine = CreateObject(GetHashKey(prop), coords.x,coords.y,coords.z - 1, false, false, false)
    local boxmachinepos = GetEntityCoords(boxmachine)
    local bmuc = CreateObject(GetHashKey('bm_uc'), boxmachinepos.x + offset.x, boxmachinepos.y - offset.y, boxmachinepos.z + 1.48, false, false, false)
    local bmucrot = vector3(90, 0, coords.h)
    SetEntityHeading(boxmachine,coords.h)
    SetEntityRotation(bmuc, bmucrot, false, true)
    FreezeEntityPosition(boxmachine,true)
    FreezeEntityPosition(bmuc,true)
    if NCHubPunchMachine.Target["open"] then
          exports[NCHubPunchMachine.Target["target"]]:AddEntityZone(objectId, boxmachine, {
          name = objectId,
          debugPoly = false,
          minZ = coords.z - 1,
          maxZ = coords.z + 1,
      }, {
        options = {
          {
            type = "server",
            icon = "fas fa-hand-rock",
            label = NCHubPunchMachine.Lang["target-1"],
            action = function()
              TriggerEvent('nchub-punchmachine:client:insertCoin', objectId, bmuc, boxmachinepos,coords.h)
            end,
          },
            {
                type = "client",
                event = "nchub-punchmachine:client:scoreList",
                icon = "fas fa-medal",
                label = NCHubPunchMachine.Lang["target-2"],
            },
        },
        distance = 2.5,
    })
  else
        LoopZone = CircleZone:Create(vector3(boxmachinepos.x,boxmachinepos.y,boxmachinepos.z), 2, {
          name = objectId,
          debugPoly = false,
      })
      LoopZone:onPlayerInOut(function(isPointInside)
          if isPointInside then
              listen = true
              NCHubPunchMachine.Notify(NCHubPunchMachine.Lang["target-false"], "success")
              ZoneLoop(objectId, bmuc, boxmachinepos,coords.h)
          else
              listen = false
          end
      end)
    end
end)

RegisterNetEvent("nchub-punchmachine:client:updateStatus", function(boxMachineListServer)
  BoxMachineList = boxMachineListServer
end)

RegisterNetEvent("nchub-punchmachine:client:syncBmuc", function(id,bmuc,pos,rottype,h)
    local bmucsync = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, GetHashKey('bm_uc'))
    local number = 90
    if rottype == 'coin' then
      for i=number,1,-1 do
            max = i
            rot = vector3(max, 0, h)
            Wait(5)
            SetEntityRotation(bmucsync, rot, false, true)
      end
    elseif rottype == 'punch' then
        rot = vector3(number, 0, h)
        SetEntityRotation(bmucsync, rot, false, true)
        TriggerServerEvent('nchub-punchmachine:server:updateStatus',id,false)
    end
end)

RegisterNetEvent('nchub-punchmachine:client:MaxDistance', function(otherPlayerCoords,maxDistance,score)
  local myCoords = GetEntityCoords(PlayerPedId())
  local distance = #(myCoords - otherPlayerCoords)
  if distance < maxDistance then
    SendNUIMessage({status = "totalscore", score = score})
  end
end)

RegisterNetEvent("nchub-punchmachine:client:insertCoin", function(id,bmuc,pos,h)
  TriggerServerEvent('nchub-punchmachine:server:updateStatus',id,true)
  if not BoxMachineList[id].status then
      local PlayerPed = PlayerPedId()
      SetEntityHeading(PlayerPed, h)
      FreezeEntityPosition(PlayerPed, true)
      Animation("mini@sprunk","plyr_buy_drink_pt1")
      SyncSound('coininsert', 0.4)
      Wait(1000)
      StopAnimTask(PlayerPed, "mini@sprunk", "plyr_buy_drink_pt1", 1.0)
      SyncServer('nchub-punchmachine:server:syncBmuc',id,bmuc,pos,'coin',h)
      SyncSound('bell', 0.1)
      Wait(1000)
      MiniGame()
      tempid = id
      tempbmuc = bmuc
      tempos = pos
      temph = h
  else
      NCHubPunchMachine.Notify(NCHubPunchMachine.Lang["error-1"], 'error')
  end
end)

RegisterNetEvent("nchub-punchmachine:client:scoreList", function()
  if NCHubPunchMachine.Framework == 'qb-core' then
      QBCore.Functions.TriggerCallback('nchub-punchmachine:server:leaderboard', function(result)
        ScoreList(result)
      end)
  elseif NCHubPunchMachine.Framework == 'esx' then
      ESX.TriggerServerCallback('nchub-punchmachine:server:leaderboard', function(result)
        ScoreList(result)
      end)
    end
end)


RegisterNUICallback("escape", function()
    SetNuiFocus(false,false)
    tempid,tempbmuc,tempos,h = nil
end)

RegisterNUICallback("getscore", function(score)
    local score = score.load
    local PlayerPed = PlayerPedId()
    Animation("melee@unarmed@streamed_variations","plyr_takedown_rear_lefthook")
    Wait(700)
    SyncSound('punch', 0.2)
    SyncServer('nchub-punchmachine:server:syncBmuc',tempid,tempbmuc,tempos,'punch',temph)
    Wait(500)
    TriggerServerEvent('nchub-punchmachine:server:MaxDistance',score)
    TriggerServerEvent('nchub-punchmachine:server:newscore', score)
    FreezeEntityPosition(PlayerPed, false)
end)

CreateThread(function()
  if NCHubPunchMachine.Blips then
    for k, v in pairs(NCHubPunchMachine.Coords) do
      local nchublip = AddBlipForCoord(v["coords"].x, v["coords"].y, v["coords"].z)
      SetBlipSprite(nchublip, 144)
      SetBlipDisplay(nchublip, 4)
      SetBlipScale(nchublip, 0.3)
      SetBlipColour(nchublip, 35)
      SetBlipAsShortRange(nchublip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(NCHubPunchMachine.Lang["blipname"])
      EndTextCommandSetBlipName(nchublip)
    end
  end
end)
