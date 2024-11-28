CreateThread(function()
    while Koci.Framework == nil do
        Koci.Framework = Utils.Functions:GetFramework()
        Wait(100)
    end
end)

function Koci.Client.HUD:MainThick()
    local playerId = PlayerId()
    local playerPedId = PlayerPedId()
    CreateThread(function()
        while not playerLoaded() do
            Wait(500)
        end
        while playerLoaded() do
            local oxygen, stamina
            local isTalking = NetworkIsPlayerTalking(playerId)
            self.data.bars.voice.isTalking = isTalking
            self.data.bars.voice.microphone = isTalking
            oxygen = math.floor(GetPlayerUnderwaterTimeRemaining(playerId) * 10)
            stamina = math.floor(100 - GetPlayerSprintStaminaRemaining(playerId))
            self.data.bars.oxygen = IsPedSwimmingUnderWater(playerPedId) and oxygen or 100
            self.data.bars.stamina = stamina or 0
            self.data.bars.terminal = 100 -- ?
            self.data.bars.leaf = 100     -- ?
            if Config.FrameWork == "qb" then
                local _Player = Koci.Client:GetPlayerData()
                local health = math.floor(
                    (GetEntityHealth(playerPedId) - 100) /
                    (GetEntityMaxHealth(playerPedId) - 100) *
                    100
                )
                if health > 100 then
                    health = 100
                elseif health < 0 then
                    health = 0
                end
                self.data.bars.health = health
                self.data.bars.armor = GetPedArmour(playerPedId)
                self.data.bars.stress = _Player.metadata["stress"]
                -- > Pause menu
                if IsPauseMenuActive() then
                    local isVisible = self.data.isVisible
                    if isVisible then
                        Koci.Client.HUD:Toggle(false)
                    end
                else
                    local isVisible = self.data.isVisible
                    if not isVisible then
                        Koci.Client.HUD:Toggle(true)
                    end
                end
            end
            -- > Vehicle HUD
            if Config.Settings.VehicleHUD.active then
                if IsPedInAnyVehicle(playerPedId) then
                    if not self.data.vehicle.inVehicle then
                        local vehicle = GetVehiclePedIsIn(playerPedId)
                        if DoesEntityExist(vehicle) then
                            if not IsThisModelABicycle(vehicle) then
                                self.data.vehicle.inVehicle = true
                                self.data.vehicle.entity = vehicle
                                self.data.vehicle.fuel.type = self:CheckVehicleFuelType(GetEntityModel(vehicle))
                                self.data.compass.show = true
                                self:ActivateVehicleHud(vehicle)
                                DisplayRadar(true)
                            end
                        end
                    end
                elseif self.data.vehicle.inVehicle then
                    self.data.vehicle.inVehicle = false
                    self.data.vehicle.entity = nil
                    self.data.vehicle.isPassenger = false
                    self.data.vehicle.show = false
                    self.data.vehicle.isSeatbeltOn = false
                    self.data.vehicle.cruiseControlStatus = false
                    self.data.compass.show = false
                    Koci.Client:SendReactMessage(
                        "UPDATE_HUD_VEHICLE",
                        self.data.vehicle
                    )
                    Koci.Client:SendReactMessage(
                        "UPDATE_HUD_COMPASS",
                        self.data.compass
                    )
                    DisplayRadar(false)
                end
            end
            Koci.Client:SendReactMessage(
                "UPDATE_HUD_STATUS_BARS",
                self.data.bars
            )
            Wait(250)
        end
    end)
end

function Koci.Client.HUD:fVehicleInfoThick(vehicle)
    local playerPedId = PlayerPedId()
    CreateThread(function()
        while self.data.vehicle.inVehicle and DoesEntityExist(vehicle) do
            self.data.vehicle.isPassenger = GetPedInVehicleSeat(vehicle, -1) ~= playerPedId
            if not self.data.vehicle.isPassenger then
                local currentSpeed = GetEntitySpeed(vehicle)
                local engineRunning = GetIsVehicleEngineRunning(vehicle)
                local rpm = engineRunning and GetVehicleCurrentRpm(vehicle) or 0
                local gear = nil
                if self.data.vehicle.manualMode then
                    if engineRunning then
                        gear = self.data.vehicle.manualGear
                    end
                else
                    gear = engineRunning and GetVehicleCurrentGear(vehicle) or "N"
                end
                local engineHealth = engineRunning and math.floor(GetVehicleEngineHealth(vehicle)) or 1000
                local _, lowBeam, highBeam = GetVehicleLightsState(vehicle)
                local lightsOn = false
                if lowBeam == 1 or highBeam == 1 then
                    lightsOn = true
                end
                if engineHealth < 0 then
                    engineHealth = 0
                end
                if gear == 0 then
                    gear = "R"
                end
                self.data.vehicle.speed = self.data.vehicle.kmh and math.floor(currentSpeed * 3.6) or
                    math.floor(currentSpeed * 2.236936
                    )
                if rpm > 0.5 and self.data.vehicle.speed == 0 then
                    self.data.vehicle.speed = 1
                end
                self.data.vehicle.fuel.level = self:GetFuelExport() or 100
                self.data.vehicle.fuel.max_level = 100
                self.data.vehicle.rpm = rpm
                self.data.vehicle.gear = gear
                self.data.vehicle.engineHealth = engineHealth
                self.data.vehicle.lightsOn = lightsOn
                if Config.Settings.Compass.active then
                    Koci.Client.HUD:CheckCrossRoads(playerPedId)
                    Koci.Client.HUD:HeadUpdate(playerPedId)
                    Koci.Client:SendReactMessage(
                        "UPDATE_HUD_COMPASS",
                        self.data.compass
                    )
                end
                Koci.Client:SendReactMessage(
                    "UPDATE_HUD_VEHICLE",
                    self.data.vehicle
                )
                Wait(self.data.vehicle.thick.wait)
            else
                Wait(1000)
            end
        end
    end)
end

function Koci.Client.HUD:LowFuelThread(vehicle)
    if Config.Settings.VehicleHUD.lowFuelNotify then
        local playerPedId = PlayerPedId()
        CreateThread(function()
            while self.data.vehicle.inVehicle and DoesEntityExist(vehicle) do
                if playerLoaded() then
                    if IsPedInAnyVehicle(playerPedId, false) and not IsThisModelABicycle(GetEntityModel(GetVehiclePedIsIn(playerPedId, false))) then
                        if self:GetFuelExport() <= 20 then -- At 20% fuel left.
                            Koci.Client:SendNotify(_t("notify.low_fuel"), "error")
                            Wait(60000)
                        end
                    end
                end
                Wait(10000)
            end
        end)
    end
end
