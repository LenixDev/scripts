--- @ Start Core Func.

function Koci.Client:TriggerServerCallback(key, payload, func)
    if not func then
        func = function() end
    end
    Koci.Callbacks[key] = func
    TriggerServerEvent("0r-hud:Server:HandleCallback", key, payload)
end

--- A simple wrapper around SendNUIMessage that you can use to
--- dispatch actions to the React frame.
---
---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function Koci.Client:SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

---@param system ("esx_notify" | "qb_notify" | "custom_notify") System to be used
---@param type string inform / success / error
---@param title string Notification text
---@param text? string (optional) description, custom notify.
---@param duration? number (optional) Duration in miliseconds, custom notify.
---@param icon? string (optional) icon.
function Koci.Client:SendNotify(title, type, duration, icon, text)
    system = Config.NotifyType
    if system == "esx_notify" then
        if Config.FrameWork == "esx" then
            Koci.Framework.ShowNotification(title, type, duration)
        end
    elseif system == "qb_notify" then
        if Config.FrameWork == "qb" then
            Koci.Framework.Functions.Notify(title, type)
        end
    elseif system == "custom_notify" then
        Utils.Functions:CustomNotify(nil, title, type, text, duration, icon)
    end
end

-- Close Radar
DisplayRadar(false)

--- Gets player data based on the configured framework.
---@return PlayerData table player data.
function Koci.Client:GetPlayerData()
    if Config.FrameWork == "esx" then
        return Koci.Framework.GetPlayerData()
    elseif Config.FrameWork == "qb" then
        return Koci.Framework.Functions.GetPlayerData()
    end
end

-- @ End core func.
-- @ Start script func.

function playerLoaded()
    return Config.FrameWork == "esx" and
        Koci.Framework.IsPlayerLoaded() or
        LocalPlayer.state.isLoggedIn
end

function Koci.Client.HUD:Start(xPlayer)
    if not xPlayer then
        xPlayer = Koci.Client:GetPlayerData()
    end
    self:MainThick()
    DisplayRadar(false)
    self:SetMiniMap(self.data.vehicle.miniMap.style)
    self.data.vehicle.kmh = Config.Settings.VehicleHUD.kmH
    Koci.Client:SendReactMessage("SET_HUD_STATUS_BARS_ACTIVE", Config.Settings.StatusBars)
    Koci.Client:SendReactMessage("SET_HUD_VEHICLE_ACTIVE", Config.Settings.VehicleHUD)
    Wait(1000)
    Koci.Client:SendReactMessage("LOAD_HUD_STORAGE")
    Koci.Client:SendReactMessage("setVisible", true)
end

function Koci.Client.HUD:Toggle(state)
    if state == nil then
        self.data.isVisible = not self.data.isVisible
    else
        self.data.isVisible = state
    end
    Koci.Client:SendReactMessage("setVisible", self.data.isVisible)
end

function Koci.Client.HUD:SetMiniMap(_type)
    Wait(50)
    local defaultAspectRatio = 1920 / 1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
    end
    local defaultAspectRatio = 1920 / 1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX / resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
    end
    local minimap = RequestScaleformMovie("minimap")
    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do
            Wait(1)
        end
    end
    if _type == "square" then
        RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(150)
        end
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    else
        RequestStreamedTextureDict("circlemap", false)
        if not HasStreamedTextureDictLoaded("circlemap") then
            Wait(150)
        end
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
    end
    SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.00, 0.128, 0.20)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.01 + minimapOffset, 0.025, 0.262, 0.300)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    SetMinimapClipType(_type == "square" and 0 or 1)
    Wait(500)
    SetRadarBigmapEnabled(false, false)
end

function Koci.Client.HUD:GetFuelExport()
    if GetResourceState("ox_fuel") == "started" then
        if Entity(self.data.vehicle.entity) then
            local ent = Entity(self.data.vehicle.entity).state.fuel or 0
            if Config.FrameWork == "esx" then
                return Koci.Framework.Math.Round(ent, 2)
            elseif Config.FrameWork == "qb" then
                return Koci.Framework.Shared.Round(ent, 2)
            end
        else
            return false
        end
    elseif GetResourceState(" cdn-fuel") == "started" then
        if Config.FrameWork == "esx" then
            return Koci.Framework.Math.Round(exports[" cdn-fuel"]:GetFuel(self.data.vehicle.entity) or 0, 2)
        elseif Config.FrameWork == "qb" then
            return Koci.Framework.Shared.Round(exports[" cdn-fuel"]:GetFuel(self.data.vehicle.entity) or 0, 2)
        end
    else
        local response = Koci.Utils:CustomFuelExport(self.data.vehicle.entity)
        if Config.FrameWork == "esx" then
            return Koci.Framework.Math.Round(response or 0, 2)
        elseif Config.FrameWork == "qb" then
            return Koci.Framework.Shared.Round(response or 0, 2)
        end
    end
end

function Koci.Client.HUD:VehicleDriverCheck(vehicle)
    if not DoesEntityExist(vehicle) then
        return false
    end
    if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
        return true
    end
    return false
end

function Koci.Client.HUD:ActivateVehicleHud(veh)
    self.data.vehicle.show = true
    self:fVehicleInfoThick(veh)
    self:LowFuelThread(veh)
end

function Koci.Client.HUD:UpdateVehicleHud(data)
    if self.data.vehicle.miniMap.style ~= data.miniMap.style then
        self.data.vehicle.miniMap.style = data.miniMap.style
        self:SetMiniMap(data.miniMap.style)
    end
    if self.data.vehicle.speedoMeter.fps ~= data.speedoMeter.fps then
        self.data.vehicle.speedoMeter.fps = data.speedoMeter.fps
        local w = 200
        if data.speedoMeter.fps == 15 then
            w = 200
        elseif data.speedoMeter.fps == 30 then
            w = 150
        elseif data.speedoMeter.fps == 60 then
            w = 100
        end
        self.data.vehicle.thick.wait = w
    end
end

function Koci.Client.HUD:CheckCrossRoads(entity)
    local updateTick = GetGameTimer()
    if self.data.compass.lastCrossRoadCheck == -1 or updateTick - self.data.compass.lastCrossRoadCheck > 1500 then
        local pos = GetEntityCoords(entity)
        local street1, street2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        self.data.compass.lastCrossRoadCheck = updateTick
        self.data.compass.crossRoad = {
            street1 = GetStreetNameFromHashKey(street1),
            street2 = GetStreetNameFromHashKey(street2)
        }
    end
end

function Koci.Client.HUD:HeadUpdate(entity)
    local camRot = GetGameplayCamRot(0)
    local heading = string.format("%.0f", (360.0 - ((camRot.z + 360.0) % 360.0)))
    heading = tonumber(heading)
    if heading == 360 then heading = 0 end
    if heading ~= lastHeading then
        self.data.compass.heading = heading
    end
    lastHeading = heading
end

function Koci.Client.HUD:CheckVehicleFuelType(vehicle)
    for k, v in pairs(Config.ElectricVehicles) do
        if vehicle == GetHashKey(v) then
            return "electric"
        end
    end
    return "gasoline"
end

function Koci.Client.HUD:ChangeGearMode(value)
    if Config.Settings.VehicleHUD.manualModeType then
        if Koci.Utils:hasResource("hrsgears") then
            if not Koci.Client.HUD.data.vehicle.inVehicle then
                if type(value) ~= nil then
                    Koci.Client.HUD.data.vehicle.manualMode = value
                else
                    Koci.Client.HUD.data.vehicle.manualMode = not Koci.Client.HUD.data.vehicle.manualMode
                end
                TriggerEvent("hrsgears:SetManualMode", Koci.Client.HUD.data.vehicle.manualMode)
                if Koci.Client.HUD.data.vehicle.manualMode then
                    Koci.Client:SendNotify(_t("notify.opened_manual_mode"), "success")
                else
                    Koci.Client:SendNotify(_t("notify.closed_manual_mode"), "success")
                end
            else
                Koci.Client:SendNotify(_t("notify.manual_mode_change_error"), "error")
            end
        else
            Koci.Client:SendNotify(_t("notify.hrsgears_script_error"), "error")
        end
    end
end