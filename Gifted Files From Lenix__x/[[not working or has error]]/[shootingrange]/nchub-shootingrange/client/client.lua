local QBCore = exports['qb-core']:GetCoreObject()
local StartShootings = false
local ScorePoint = 0
local ScoreHead = 0
local SpawnPedID = nil
local GlobalTimer = 0
local RandomSpawnNumber = 0

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

local function RoundTimer(Timer)
    return math.ceil(Timer/1000)
end

local function SelectWeapon(Gun)
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, GetHashKey(Gun), 1, false, false)
    SetPedAmmo(ped, GetHashKey(Gun), 250)
    SetCurrentPedWeapon(ped, GetHashKey(Gun), true)
end

local function DropWeapon()
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    Wait(1500)
    RemoveAllPedWeapons(ped, true)
    FreezeEntityPosition(ped, false)
end

local function SpawnPedForShot()
    local random = math.random(1, #Config.PedCoords)
    if RandomSpawnNumber == random then
        random = random + 1
        if random > #Config.PedCoords then
            random = random - 2
        end
    end
    RandomSpawnNumber = random
    SpawnPedID = CreatePed(2, GetHashKey(Config.SpawnPedName), Config.PedCoords[random].x, Config.PedCoords[random].y, Config.PedCoords[random].z-1.0, Config.PedHeading, true, true)
    FreezeEntityPosition(SpawnPedID, true)
    SetBlockingOfNonTemporaryEvents(SpawnPedID, true)
end

local function DeleteEntityShoot()
    DeleteEntity(SpawnPedID)
    SpawnPedID = nil
end

local function EndShoting()
    StartShootings = false
    DropWeapon()
    exports['casinoUi']:HideCasinoUi('hide')
    TriggerServerEvent('nchub-shootingrange:server:SetBusy', false)
    DeleteEntityShoot()
end


local function StartTimer()
    local Model = GetHashKey(Config.SpawnPedName)
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Wait(0)
    end
    TriggerServerEvent('nchub-shootingrange:server:StartServerSideTimer', GlobalTimer)
    CreateThread(function()
        local TimeToReady = 5
        while StartShootings do
            Wait(1000)
            exports['qb-core']:DrawText(TimeToReady)
            -- QBCore.Functions.Notify(TimeToReady)
            PlaySoundFrontend(-1, 'Beep_Red', 'DLC_HEIST_HACKING_SNAKE_SOUNDS', false)
            TimeToReady = TimeToReady - 1
            if TimeToReady <= 0 then
                Wait(1000)
                PlaySoundFrontend(-1, 'Checkpoint_Hit', 'GTAO_FM_Events_Soundset', false)
                exports['qb-core']:DrawText("Start!")
                QBCore.Functions.Notify("Start!", "success")
                exports['qb-core']:HideText()
                SpawnPedForShot()
                break
            end
        end
        while StartShootings do
            Wait(1000)
            GlobalTimer = GlobalTimer - 1
        end
    end)
end

local function StartShooting(GunName, Timer, Point, Label)
    TriggerServerEvent('nchub-shootingrange:server:SetBusy', true)
    local ped = PlayerPedId()
    StartShootings = true
    ScorePoint = 0
    ScoreHead = 0
    SpawnPedID = nil
    GlobalTimer = RoundTimer(Timer)
    FreezeEntityPosition(ped, true)
    SelectWeapon(GunName)
    StartTimer()
    CreateThread(function()
        while StartShootings do
            Wait(0)   

            exports['casinoUi']:DrawCasinoUi('show', '<b>Bullet Club Range</b></p>Difficulty: '..Label.. ' | Remaining: <b style="color:#fffdd0;">'..GlobalTimer..'</b><br>Score: '..ScorePoint..' | HeadShot: '..ScoreHead..'</p><b style="color:#fffdd0;">[X]</b> Cancel')

            if IsControlJustPressed(0, 252) then -- X
                EndShoting()
                exports['qb-core']:HideText()
			end
            local randomToken = math.random(1, 5)
            if ScorePoint >= Point then
                QBCore.Functions.Notify("Win | Remaining time: "..GlobalTimer.."sec", "success")
                if Label == Config.ModeMenu[2]['Label'] then
                    if ScoreHead >= (Point - 2) then
                        PlaySoundFrontend(-1, 'RANK_UP', 'HUD_AWARDS', false)
                        TriggerServerEvent("nchub-shootingrange:server:AddedItem", Config.CaseItemName, randomToken)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.CaseItemName], "add", randomToken)
                    end
                end
                if Label == Config.ModeMenu[3]['Label'] then
                    if ScoreHead >= (Point - 3) then
                        PlaySoundFrontend(-1, 'RANK_UP', 'HUD_AWARDS', false)
                        TriggerServerEvent("nchub-shootingrange:server:AddedItem", Config.CaseItemName, randomToken)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.CaseItemName], "add", randomToken)
                    end
                end
                EndShoting()
            end
            if GlobalTimer < 0 then
                QBCore.Functions.Notify("You ran out of time, you lost | Your Score: "..ScorePoint, "error")
                EndShoting()
            end
            local Health = GetEntityHealth(SpawnPedID)
            if SpawnPedID then
                if Health < 200 then
                    ScorePoint = ScorePoint + 1
                    if Health <= 0 then
                        PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', false) 
                        ScoreHead = ScoreHead + 1
                    end
                    DeleteEntityShoot()
                    SpawnPedForShot()
                end
            end
        end
    end)
end

CreateThread(function()
    Wait(500)
    local shootingrangeBlip = AddBlipForCoord(Config.TargetCoord[1], Config.TargetCoord[2], Config.TargetCoord[3])
	SetBlipSprite (shootingrangeBlip, 103)
	SetBlipScale  (shootingrangeBlip, 0.65)
	SetBlipAsShortRange(shootingrangeBlip, true)
	SetBlipColour(shootingrangeBlip, 75)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Shooting Range")
	EndTextCommandSetBlipName(shootingrangeBlip)
    -- exports['qb-target']:AddBoxZone("shootingrange_1", vector3(Config.TargetCoord[1], Config.TargetCoord[2], Config.TargetCoord[3]), 0.5, 0.5, {
    --     name = "shootingrange_1",
    --     heading = 0,
    --     debugPoly = false,
    --     minZ = Config.TargetCoord[3] - 1.0,
    --     maxZ = Config.TargetCoord[3] + 1.0,
    --     }, {
    --         options = {
    --             {
    --                 type = "client",
    --                 event = "nchub-shootingrange:OpenMenu",
    --                 icon = "fa fa-circle",
    --                 label = "Start Shooting",
    --             },
    --         },
    --         distance = 1.5
    --     })
    exports['qb-target']:AddBoxZone("menushooting", vector3(821.52, -2163.93, 29.62), 1.2, 11.8, {
        name = "menushooting",
        heading = 0,
        debugPoly = false,
        minZ = 28.57,
        maxZ = 31.77
        }, {
            options = {
                {
                    type = "client",
                    event = "nchub-shootingrange:OpenMenu",
                    icon = "fa fa-circle",
                    label = "Start Shooting",
                },
            },
            distance = 1.5
        })
end)

RegisterNetEvent('nchub-shootingrange:OpenMenu', function()

    local ShootingMenu = {
        {
            isMenuHeader = true,
            
            icon = 'fas fa-crosshairs',
            header = "Shooting Range Menu",
            subheader  = "Select mode",
        },
    }
    for k, v in pairs(Config.ModeMenu) do
        ShootingMenu[k+1] = {
            header = v.Label.." Mode",
            icon = 'fas fa-coins',
            subheader  = "Timer: <b>"..RoundTimer(v.Timer).."sec</b> | Point: <b>"..v.Point.."</b> | Token : <b>"..v.Token,
            args = {k, v},
            event = 'nchub-shootingrange:SelectWeaponType',
            submenu = true,
        }
    end
    ShootingMenu[#ShootingMenu+1] = {
        leave = true,
    }
    exports["keep-menu"]:createMenu(ShootingMenu)

end)

RegisterNetEvent('nchub-shootingrange:SelectWeaponType', function(Data)
    local ShootingMenu = {
        {
            isMenuHeader = true,
            icon = 'fas fa-circle-info',
            header = "Mode: "..Data[2].Label.." | Timer: "..RoundTimer(Data[2].Timer).."sec | Point: "..Data[2].Point,
            subheader  = "Select weapon type",
		},
        {
            header = "Go Back",
            back = true,
            event = "nchub-shootingrange:OpenMenu",
            
        },
    }

    for k, v in pairs(Config.Weapon) do
		ShootingMenu[k+2] = {
			header = v.Label,
            event = "nchub-shootingrange:WeaponList",
            icon = 'fas fa-gun',
            submenu = true,
			args = {Data[1], Data[2], v},
		}
	end

    exports["keep-menu"]:createMenu(ShootingMenu)
end)

RegisterNetEvent('nchub-shootingrange:WeaponList', function(Data)

    local ShootingMenu = {
        {
            isMenuHeader = true,
            icon = 'fas fa-circle-info',
            header = "Mode: "..Data[2].Label.." | Gun Type: "..Data[3].Label,
            subheader  = "Select weapon ",
		},
        {
            header = "Go Back",
            back = true,
            event = 'nchub-shootingrange:SelectWeaponType',
            args = {Data[1], Data[2]},
        },
    }
    for k, v in pairs(Data[3].Items) do
        local ItemName = QBCore.Shared.Items[v].label
        local ItemImage = QBCore.Shared.Items[v].name
		ShootingMenu[k+2] = {
			header = ItemName,
            image = ItemImage,
            event = "nchub-shootingrange:ConfirmStart",
            icon = 'fas fa-circle',
            args = {v, Data[2]},
		}
	end

    exports["keep-menu"]:createMenu(ShootingMenu)
end)

RegisterNetEvent('nchub-shootingrange:ConfirmStart', function(Data)

    local ShootingMenu = {
        {
            isMenuHeader = true,
            header = "Payment Confirmation",
            subheader = 'Do you agree to pay <b>$'..Config.StartPrice,
            icon = 'fas fa-circle-dollar-to-slot',
		},
        {
            header = "Cancel",
            back = true,
            event = 'nchub-shootingrange:OpenMenu',
        },
        {
            header = 'Yes',
            subheader = "Pay <b>$"..Config.StartPrice,
            event = 'nchub-shootingrange:StartShooting',
            icon = "fas fa-money-bill-1-wave",
            args = {Data[1], Data[2]},
        },
    }
    
    exports["keep-menu"]:createMenu(ShootingMenu)
end)

RegisterNetEvent('nchub-shootingrange:StartShooting', function(Data)
    local GunName = Data[1]
    local Timer = Data[2].Timer
    local Point = Data[2].Point
    local Label = Data[2].Label
    QBCore.Functions.TriggerCallback('nchub-shootingrange:server:GetCheckMoney', function(HasMoney)
        if HasMoney then
            StartShooting(GunName, Timer, Point, Label)
        end
    end)
end)

RegisterNetEvent('nchub-shootingrange:client:UseCaseItem', function()
    QBCore.Functions.Progressbar("openingcase", "Opening Case..", Config.OpeningCaseTimer, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("Nchub-additem:shooting")
    end, function() -- Cancel
        QBCore.Functions.Notify("Process canceled..", "error")
    end)
end)



-- Citizen.CreateThread(function()
--     local alreadyEnteredZone = false
--     while true do
--         Sleep = 2000
--         local PlayerPed = PlayerPedId()
--         local PlayerCoord = GetEntityCoords(PlayerPed)
--         local inZone = false
--         local Distance = #(PlayerCoord - Config.CraftCoord)
--         if Distance <= 1.0 then
--             Sleep = 5
--             inZone  = true
--             if IsControlJustReleased(0, 38) then
--                 exports['qb-core']:HideText()
--                 TriggerEvent('inventory:client:Crafting')
--             end
--         else
--             Sleep = 2000
--         end
--         if inZone and not alreadyEnteredZone then
--             alreadyEnteredZone = true
--             exports['qb-core']:DrawText("<b>[E]</b> Craft")
--         end
--         if not inZone and alreadyEnteredZone then
--             alreadyEnteredZone = false
--             exports['qb-core']:HideText()
--         end
--         Citizen.Wait(wait)
--     end
-- end)