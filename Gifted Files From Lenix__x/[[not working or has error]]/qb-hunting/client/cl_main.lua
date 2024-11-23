QBCore = exports['qb-core']:GetCoreObject()
local cooldown = 0
local used = false
local jobSpawned = false
local refreshPed = false
local jobPed
local useBaitCooldown = 3
local illegalhunting = false
local CutAnimals = {}

local HuntingZones =  { 
  'MTCHIL',
  'CANNY',
  'MTGORDO',
  'CMSW',
  'MTJOSE',
}

local HuntingAnimals = {
  'a_c_boar',
  'a_c_deer',
  'a_c_coyote',
  'a_c_mtlion',
}

local dumbass = vector3(-676.07, 5831.46, 17.33)

local blips = {
  {title="Hunting Area", colour=3, id=141, x = -973.44, y = 4424.14, z = 18.16},}
  
  Citizen.CreateThread(function()
		Citizen.Wait(0)
  local bool = true
  if bool then
        
		for k,v in pairs(blips) do
          zoneblip = AddBlipForRadius(v.x,v.y,v.z, 4000.0)
          SetBlipSprite(zoneblip,1)
          SetBlipColour(zoneblip,62)
          SetBlipAlpha(zoneblip,75)               
        end
         
         for _, info in pairs(blips) do
        
          info.blip = AddBlipForCoord(info.x, info.y, info.z)
          SetBlipSprite(info.blip, info.id)
          SetBlipDisplay(info.blip, 4)
          SetBlipColour(info.blip, info.colour)
          SetBlipAsShortRange(info.blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(info.title)
          EndTextCommandSetBlipName(info.blip)
         end
	   bool = false
   end
end)
Citizen.CreateThread(function()
  blip = AddBlipForCoord(-676.07, 5831.46, 17.33)
  SetBlipSprite(blip, 141)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Hunting Shop")
  EndTextCommandSetBlipName(blip)


  local illlegalHunts = {
    `a_c_chop`,
    `a_c_husky`,
    `a_c_retriever`,
    `a_c_westy`,
    `a_c_shepherd`,
    `a_c_poodle`,
    `u_m_y_gunvend_01`,
  }

  local hunting = {
    `ig_hunter`
}    

exports['qb-target']:AddTargetModel(hunting, {
    options = {
        {
            event = "qb-shops:client:hunting",
            icon = "fas fa-shopping-cart",
            label = "Open Shop",
        },
        {
            event = "qb-hunting:payammo",
            icon = "fas fa-circle",
            label = "Purchase Bullets $500",
        },
        {
          event = "qb-hunting:server:sell",
          icon = "fas fa-circle",
          label = "Sell The Meat",
      },
    },
    distance = 2.5
})



  SetScenarioTypeEnabled('WORLD_DEER_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_WANDER',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_REST',false)
  --SetScenarioTypeEnabled('WORLD_RABBIT_EATING',false)
  SetScenarioTypeEnabled('WORLD_BOAR_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_WANDER',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_REST',false)
end)


local function MarkAsCut(entity)
  CutAnimals[entity] = true
  DeleteEntity(entity)
end

local function IsCutted(entity)
  return CutAnimals[entity] ~= nil
end

 Citizen.CreateThread(function()
 	while true do
 	Wait(1000)
 		if refreshPed then
       if DoesEntityExist(jobPed) then
         exports['qb-target']:AddEntityZone('huntPed', jobPed, {
         name="huntPed",
         debugPoly=false,
         useZ = true
           }, {
           options = {
             {
             event = "qb-shops:client:hunting",
             icon = "fab fa-shopify",
             label = "Hunting Shop",
             },
           },
             job = {"all"},
             distance = 1.5
           })    
         refreshPed = false
       end
     end
 	end
 end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local dst = #(dumbass - pedCoords)
    --print(dst)
    if dst < 40 and jobSpawned == false then
      TriggerEvent('qb-hunting:spawnJobPed',dumbass, 225.87)
      jobSpawned = true
      refreshPed = true
    end
    if dst >= 41  then
      if DoesEntityExist(jobPed) then
        DeletePed(jobPed)
      end
      jobSpawned = false
    end
  end
end)--

RegisterNetEvent('qb-hunting:spawnJobPed')
AddEventHandler('qb-hunting:spawnJobPed',function(coords, heading)
  local hash = GetHashKey('ig_hunter')
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  jobPed = CreatePed(5, hash, coords, heading, false, false)
  FreezeEntityPosition(jobPed, true)
  SetEntityInvincible(jobPed, true)
  SetBlockingOfNonTemporaryEvents(jobPed, true)
  SetModelAsNoLongerNeeded(hash)
end)--

RegisterNetEvent("qb-hunting:payammo")
AddEventHandler("qb-hunting:payammo", function()
  local weapon = GetSelectedPedWeapon(PlayerPedId())
  if QBCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and not QBCore.Shared.Weapons["WEAPON_SNIPERRIFLE2"] then
    TriggerServerEvent("remove:money")
  else
    QBCore.Functions.Notify("How am Im Suppose to reload your sniper if your not holding it?", "error")
  end
end)

RegisterNetEvent("qb-hunting:setammo")
AddEventHandler("qb-hunting:setammo", function()
  AddAmmoToPed(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)), 25)
  TriggerEvent('weapon:client:AddAmmo', 'AMMO_SNIPER', 10)
end)


RegisterNetEvent('qb-hunting:spawnAnimal')
AddEventHandler('qb-hunting:spawnAnimal', function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local radius = 100.0
  local x = coords.x + math.random(-radius,radius)
  local y = coords.y + math.random(-radius,radius)
  local safeCoord, outPosition = GetSafeCoordForPed(x,y,coords.z,false,16)
  --animal = Config.HuntingAnimals[math.random(#Config.HuntingAnimals)] --HuntingAnimals
  animal = HuntingAnimals[math.random(#HuntingAnimals)]
  local hash = GetHashKey(animal)
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  if outPosition.x > 1 or outPosition.x < -1  then
    --Wait(2000)
    Wait(8000)
    baitAnimal = CreatePed(28, hash, outPosition.x, outPosition.y, outPosition.z, 0, true, false)
  else
    -- print('Debug: Too Far to Spawn')
  end
  if DoesEntityExist(baitAnimal) then
    TaskGoToCoordAnyMeans(baitAnimal,coords,2.0,0,786603,0)
  end
end)


local legalHunts = {
  `a_c_boar`,
  `a_c_deer`,
  `a_c_coyote`,
  `a_c_mtlion`,
}

exports['qb-target']:AddTargetModel(legalHunts, {
  options = {
    {
      event = "qb-hunting:skinAnimal",
      icon = "far fa-hand-paper",
      label = "Skin",
      canInteract = function()
        if IsCut then return false end
        return true
    end,
    },
  },
  job = {"all"},
  distance = 1.5
})

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if DoesEntityExist(baitAnimal) then
      local ped = PlayerPedId()
      local coords = GetEntityCoords(PlayerPedId())
      local animalCoords = GetEntityCoords(baitAnimal)
      local dst = #(coords - animalCoords)
      HideHudComponentThisFrame(14)
      if dst < 2.5 then -- spook animal
        TaskCombatPed(baitAnimal,ped,0,16)
      end
    end
  end
end)

RegisterNetEvent('qb-hunting:skinAnimal')
AddEventHandler('qb-hunting:skinAnimal', function(data)
  QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
    if hasItem then
      if DoesEntityExist(baitAnimal) then
          LoadAnimDict('amb@medic@standing@kneel@base')
          LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
          TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
          TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
          QBCore.Functions.Progressbar("Skinning", "Skinning", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false, 
            disableCombat = true
          }, {}, {}, {}, function() -- Done
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent('qb-hunting:skinReward')
            
            if NetworkHasControlOfEntity(data.entity) then
              DeleteEntity(data.entity);
            else
              TriggerServerEvent('qb-hunting:delete', NetworkGetNetworkIdFromEntity(data.entity))
            end
        end)

end
else
  QBCore.Functions.Notify("You need a knife.", "error")
end
  end, "knife")
end)

RegisterNetEvent('qb-hunting:usedBait')
AddEventHandler('qb-hunting:usedBait', function()
  for k,v in pairs (HuntingZones) do
    if IsEntityInZone(PlayerPedId(),v) then
      if cooldown <= 0 then
        LoadAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        QBCore.Functions.Progressbar("bait", "Placing Bait", 5000, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true
        }, {}, {}, {}, function() -- Done
        Citizen.Wait(100)
        cooldown = useBaitCooldown * 10000
        ClearPedTasksImmediately(PlayerPedId())
        used = true
        usedBait()
        TriggerEvent('qb-hunting:spawnAnimal')
        TriggerServerEvent('qb-hunting:removeBait')
        baitCooldown()
        TriggerServerEvent('log', 'hunting', 'just used a bait.');
      end)
    else
      QBCore.Functions.Notify("You need to wait", "error")
    end
  end
end
end)

function baitCooldown()
  Citizen.CreateThread(function()
    while cooldown > 0 do
      Wait(2000)
      cooldown = cooldown - 1000
    end
  end)
end

function usedBait()
  Citizen.CreateThread(function()
    while used do
      -- print('waiting to spawn')
      Wait(1500)
      -- print('spawning')
      TriggerEvent('qb-hunting:spawnAnimal')
      used = false
    end
  end)
end

function playerAnim()
	LoadAnimDict( "mp_safehouselost@" )
  TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function LoadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(10)
  end
end





-- RegisterCommand('getzone', function()
--   Coords = GetEntityCoords(PlayerPedId())
--   ZoneName = GetNameOfZone(Coords)
--   print(ZoneName)
-- end)
