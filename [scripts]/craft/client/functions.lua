--- @ Start Core Func.

function Koci.Client:TriggerServerCallback(key, payload, func)
    if not func then
        func = function() end
    end
    Koci.Callbacks[key] = func
    TriggerServerEvent("craft:server:HandleCallback", key, payload)
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

--- Gets player data based on the configured framework.
---@return PlayerData table player data.
function Koci.Client:GetPlayerData()
    if Config.FrameWork == "esx" then
        return Koci.Framework.GetPlayerData()
    elseif Config.FrameWork == "qb" then
        return Koci.Framework.Functions.GetPlayerData()
    end
end

function Koci.Client:PlayerLoaded()
    return Config.FrameWork == "esx" and
        Koci.Framework.IsPlayerLoaded() or
        LocalPlayer.state.isLoggedIn
end

-- @ End core func.
-- @ Start script func.

function Koci.Client.Craft:Setup()
    self:SetupShops()
    self:ReadQueueDB()
end

function Koci.Client.Craft:Stop()
    self:DeleteWeaponObjects()
    self:DeleteCraftableItemObjects()
    self:DeleteShopBenchObjects()
    self:DeleteCreatedBlips()
    if self.isTheShopOpen then
        self:DestroyCam()
        SetEntityVisible(PlayerPedId(), true)
        SetNuiFocus(false, false)
        DisplayRadar(true)
        Koci.Utils:OpenHud()
    end
end

function Koci.Client.Craft:DeleteCreatedBlips()
    for i = #self.createdShopBlips, 1, -1 do
        if DoesBlipExist(self.createdShopBlips[i]) then
            RemoveBlip(self.createdShopBlips[i])
            table.remove(self.createdShopBlips, i)
        end
    end
end

function Koci.Client.Craft:DeleteShopBenchObjects()
    for _, value in pairs(self.createdShopBenchObjects) do
        if DoesEntityExist(value) then
            DeleteObject(value)
        end
    end
end

function Koci.Client.Craft:DeleteWeaponObjects()
    if Koci.Client.Craft.createdWeaponObjectOnTable then
        DeleteObject(Koci.Client.Craft.createdWeaponObjectOnTable)
        Koci.Client.Craft.createdWeaponObjectOnTable = nil
        Koci.Client.Craft.selectedWeapon = nil
    end
end

function Koci.Client.Craft:DeleteCraftableItemObjects()
    if Koci.Client.Craft.createdItemObjectOnTable then
        DeleteObject(Koci.Client.Craft.createdItemObjectOnTable)
        Koci.Client.Craft.createdItemObjectOnTable = nil
    end
end

function Koci.Client.Craft:SetupShops()
    local _shops = Config.CraftingTables
    local _iDrawTextShops = {}
    local _iTargetShops = {}
    for key, value in pairs(_shops) do
        if value.active then
            if value.blip.active then
                self:AddBlipForCraftShop(value.blip, value.coords)
            end
            local isObjectCreated = self:CreateObjectOfShop(value.name, value.object, value.coords)
            if isObjectCreated then
                if value.interact_type == "drawtext" then
                    _iDrawTextShops[#_iDrawTextShops + 1] = {
                        index = key,
                        name = value.name,
                        coords = value.coords,
                        cam = value.cam,
                        distance = value.distance,
                        weapon = value.weapon,
                        object = value.object,
                        color = value.color,
                        craftableItems = value.craftableItems
                    }
                elseif value.interact_type == "target" then
                    _iTargetShops[#_iTargetShops + 1] = {
                        index = key,
                        name = value.name,
                        coords = value.coords,
                        cam = value.cam,
                        distance = value.distance,
                        weapon = value.weapon,
                        object = value.object,
                        color = value.color,
                        craftableItems = value.craftableItems
                    }
                end
            end
        end
    end
    self:CreateDrawTexts(_iDrawTextShops)
    self:CreateObjectTargets(_iTargetShops)
end

function Koci.Client.Craft:CreateObjectOfShop(shopName, object, coords)
    local _coords = nil
    local success, err = pcall(function()
        _coords = vector4(tonumber(coords.x), tonumber(coords.y), tonumber(coords.z), tonumber(coords.w))
    end)
    if not success and err then
        Koci.Client:SendNotify(_t("game.invalid_vector_type", shopName), "error")
        return false
    end
    local modelHash = object.name
    Koci.Utils:LoadModel(modelHash)
    local createdObject = CreateObject(modelHash, _coords.x, _coords.y, _coords.z, false, false, false)
    if createdObject ~= 0 then
        PlaceObjectOnGroundProperly(createdObject)
        FreezeEntityPosition(createdObject, true)
        SetEntityInvincible(createdObject, true)
        SetEntityHeading(createdObject, _coords.w)
        self.createdShopBenchObjects[#self.createdShopBenchObjects + 1] = createdObject
    end
    SetModelAsNoLongerNeeded(modelHash)
    return true
end

function Koci.Client.Craft:AddBlipForCraftShop(settings, coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    self.createdShopBlips[#self.createdShopBlips + 1] = blip
    SetBlipSprite(blip, settings.spriteId)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, settings.scale)
    SetBlipColour(blip, settings.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(settings.name)
    EndTextCommandSetBlipName(blip)
end

function Koci.Client.Craft:ReadQueueDB()
    Koci.Client:TriggerServerCallback("craft:server:GetPlayerQueueDB", nil, function(queue)
        self.completedCraftingQueues = queue
    end)
end

function Koci.Client.Craft:OpenTheShopBench(shop)
    self.openedShop = shop
    Koci.Client:SendReactMessage("ui:setTheme", shop.color)
    Koci.Client:SendReactMessage("ui:setCraftableItems", shop.craftableItems)
    Koci.Client:SendReactMessage("ui:setCompletedCraftingQueue", self.completedCraftingQueues)
    self.isTheShopOpen = true
    Koci.Client:TriggerServerCallback("craft:server:GetPlayerInventory", nil, function(data)
        local inventory = data.inventory
        if not IsNuiFocused() then
            SetNuiFocus(true, true)
        end
        if not IsRadarHidden() then
            DisplayRadar(false)
        end
        local weapons = self:GetPlayerOwnedWeapons(inventory)
        Koci.Client:SendReactMessage("ui:setInventoryWeapons", weapons)
        Koci.Utils:CloseHud()
        self:CreateCam(shop.cam)
        SetEntityVisible(PlayerPedId(), false)
        Koci.Client:SendReactMessage("ui:setVisible", true)
    end)
end

function Koci.Client.Craft:CreateCam(cam)
    if not DoesCamExist(self.shopCam) then
        local gCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        SetCamCoord(gCam, cam.coords)
        SetCamRot(gCam, cam.rotation, 2)
        SetCamActive(gCam, true)
        RenderScriptCams(true, true, 1000)
        self.shopCam = gCam
    end
end

function Koci.Client.Craft:DestroyCam()
    local gCam = self.shopCam
    if DoesCamExist(gCam) then
        DestroyCam(gCam, true)
        RenderScriptCams(false, false, 1)
        self.shopCam = nil
    end
end

function Koci.Client.Craft:CreateObjectTargets(items)
    if next(items) then
        if not Koci.Utils:hasResource(Config.TargetType) then
            Koci.Utils:debugPrint(Config.TargetType .. " not found !")
            return
        end
        local uniqueZoneId = nil
        if Config.TargetType == "ox_target" then
            for _, item in pairs(items) do
                uniqueZoneId = exports.ox_target:addSphereZone({
                    coords = item.coords,
                    radius = item.distance,
                    debug = false,
                    drawSprite = true,
                    options = {
                        {
                            label = _t("game.interact_with_bench_target"),
                            name = "craft:ox_target:spherezone:shop:" .. item.index,
                            icon = "fa-solid fa-screwdriver-wrench",
                            distance = item.distance,
                            onSelect = function()
                                Koci.Client.Craft:OpenTheShopBench(item)
                            end,
                        }
                    }
                })
            end
        elseif Config.TargetType == "qb-target" then
            for _, item in pairs(items) do
                uniqueZoneId = "craft:qb-target:spherezone:shop:" .. item.index
                exports["qb-target"]:AddCircleZone(uniqueZoneId, item.coords,
                    item.distance,
                    {
                        name = uniqueZoneId,
                        debugPoly = false,
                    }, {
                        options = {
                            {
                                num = 1,
                                type = "client",
                                icon = "fa-solid fa-screwdriver-wrench",
                                label = _t("game.interact_with_bench_target"),
                                targeticon = "fa-solid fa-screwdriver-wrench",
                                action = function()
                                    Koci.Client.Craft:OpenTheShopBench(item)
                                end,
                            }
                        },
                        distance = item.distance,
                    }
                )
            end
        end
    end
end

function Koci.Client.Craft:CreateDrawTexts(items)
    if next(items) then
        CreateThread(function()
            while true do
                local sleep = 2000
                if not self.isTheShopOpen then
                    local playerCoord = GetEntityCoords(PlayerPedId())
                    for key, item in pairs(items) do
                        if #(playerCoord - vector3(item.coords.x, item.coords.y, item.coords.z)) <= item.distance then
                            Koci.Utils:DrawText3D(item.coords, _t("game.interact_with_bench_drawtext"))
                            if IsControlJustPressed(1, 38) then
                                Koci.Client.Craft:OpenTheShopBench(item)
                                Wait(1500)
                            end
                            sleep = 1
                        end
                    end
                end
                Wait(sleep)
            end
        end)
    end
end

function Koci.Client.Craft:LoadWeaponOnTable(weapon)
    self:DeleteWeaponObjects()
    local weaponObject = -1
    if Koci.ResmonLib then
        self.selectedWeapon = weapon
        local weaponComponents = self.selectedWeapon.attachments or {}
        local x, y, z = table.unpack(self.openedShop.object.preview_spawn_coord)
        local _rot = vector3(0.0, 0.0, 30.0)
        local weaponModel = weapon.name
        weaponObject = Koci.ResmonLib.Craft.LoadPropOnTable(weaponModel, x, y, z, "weapon")
        self.selectedWeapon.object = weaponObject
        self.createdWeaponObjectOnTable = weaponObject
        SetEntityCoords(weaponObject, x, y, z)
        SetEntityRotation(weaponObject, _rot)
        FreezeEntityPosition(weaponObject, true)
        for _, component in pairs(weaponComponents) do
            if component.type ~= "skin" then
                local componentModel = GetWeaponComponentTypeModel(component.hash)
                Koci.Utils:LoadModel(componentModel)
                GiveWeaponComponentToWeaponObject(weaponObject, GetHashKey(component.hash))
                SetModelAsNoLongerNeeded(componentModel)
            end
        end
        self:LoadAttachmentBoxes(self.selectedWeapon)
    end
    return weaponObject
end

function Koci.Client.Craft:LoadPropOnTable(item)
    self:DeleteCraftableItemObjects()
    local objNumber = -1
    if Koci.ResmonLib then
        local x, y, z = table.unpack(self.openedShop.object.preview_spawn_coord)
        local _rot = vector3(0.0, 0.0, 30.0)
        local itemModel = item.propModel
        local prefix = "weapon"
        if itemModel then
            local type = (itemModel:sub(1, #prefix) == prefix) and "weapon" or "object"
            objNumber = Koci.ResmonLib.Craft.LoadPropOnTable(itemModel, x, y, z, type)
            self.createdItemObjectOnTable = objNumber
            FreezeEntityPosition(objNumber, true)
            SetEntityCoords(objNumber, x, y, z)
            SetEntityRotation(objNumber, _rot)
        end
    end
    return objNumber
end

function Koci.Client.Craft:LoadAttachmentBoxes(weapon)
    local weaponObject = weapon.object
    local components = weapon.attachments or {}
    local boxes = {}
    for k, v in pairs(Config.WeaponAttachment.Bones) do
        local boneIndex = GetEntityBoneIndexByName(weaponObject, k)
        if boneIndex ~= -1 then
            local bonePosition = GetWorldPositionOfEntityBone(weaponObject, boneIndex)
            local _, screenX, screenY = GetScreenCoordFromWorldCoord(
                bonePosition.x,
                bonePosition.y,
                bonePosition.z
            )
            boxes[#boxes + 1] = {
                key = k,
                x = screenX,
                y = screenY,
                label = v.label,
                slot = v.key,
                shift_left = v.shift_left,
                shift_top = v.shift_top,
                child = nil
            }
        end
    end
    if #components > 0 then
        for key, box in pairs(boxes) do
            for k, component in pairs(components) do
                if box.slot == component.type then
                    boxes[key].child = component
                end
            end
        end
    end
    Koci.Client:SendReactMessage("ui:SETUP_ATTACHMENT_BOXES", boxes)
end

function Koci.Client.Craft:GetPlayerOwnedWeapons(inventory)
    local ownedWeapons = {}
    local playerInventory = inventory
    -- @ --
    local _index = 1
    local prefix = "weapon_"
    for _, item in pairs(playerInventory) do
        if item.name == nil then item.name = _ end
        item.name = string.lower(item.name)
        if string.sub(item.name, 1, #prefix) == prefix then
            if item.amount == nil then item.amount = item.count end
            if item.amount > 0 then
                item.metadata = item.metadata or item.info
                local weapon = Config.Weapons[item.name]
                if weapon then
                    for i = 1, item.amount do
                        ownedWeapons[#ownedWeapons + 1] = {
                            index = _index,
                            name = item.name,
                            label = item.label,
                            image = item.name .. ".png",
                            amount = 1,
                            attachments = self:GetWeaponComponents(item),
                            _item = item
                        }
                        _index = _index + 1
                    end
                end
            end
        end
    end
    return ownedWeapons
end

function Koci.Client.Craft:GetPlayerOwnedAttachmentsByWeapon(weapon_name, inventory)
    local componentItems = {}
    local playerInventory = inventory
    -- @ --
    local _index = 1
    local prefix = "weapon_"
    for _, item in pairs(playerInventory) do
        if item.name == nil then item.name = _ end
        item.name = string.lower(item.name)
        if item.amount == nil then item.amount = item.count or 0 end
        if item.amount > 0 then
            local weapon = Config.Weapons[weapon_name]
            local weaponName = string.sub(weapon_name, #prefix + 1)
            if weapon then
                for _, component in pairs(weapon.components or {}) do
                    local componentName = string.lower(component.item)
                    if item.name == componentName then
                        for i = 1, item.amount do
                            componentItems[#componentItems + 1] = {
                                index = _index,
                                type = component.type,
                                name = item.name,
                                label = item.label,
                                hash = component.hash,
                                image = "attachments/" .. component.item .. ".png",
                                weapon_name = weaponName,
                            }
                            _index = _index + 1
                        end
                        break
                    end
                end
            end
        end
    end
    return componentItems
end

function Koci.Client.Craft:GetWeaponComponents(weapon)
    -- info: weapon == item
    local cWeapon = Config.Weapons[weapon.name]
    if cWeapon then
        local weaponMetadata = weapon.metadata or weapon.info
        if weaponMetadata then
            local result = {}
            if Config.FrameWork == "esx" then
                local item_components = weaponMetadata.components
                if type(item_components) == "table" and #item_components > 0 then
                    local _index = 1
                    for _, iComponent in pairs(item_components) do
                        for _, cWeaponComponent in pairs(cWeapon.components) do
                            if iComponent == cWeaponComponent.item then
                                result[#result + 1] = {
                                    index = _index,
                                    type = cWeaponComponent.type,
                                    name = iComponent,
                                    label = string.gsub(iComponent, "_", " "),
                                    hash = cWeaponComponent.hash,
                                    weapon_name = weapon.name,
                                    image = "attachments/" .. iComponent .. ".png"
                                }
                                _index = _index + 1
                                break
                            end
                        end
                    end
                end
            elseif Config.FrameWork == "qb" then
                local item_components = weaponMetadata.attachments
                if type(item_components) == "table" and #item_components > 0 then
                    local _index = 1
                    for _, iComponent in pairs(item_components) do
                        for _, cWeaponComponent in pairs(cWeapon.components) do
                            local componentHash = iComponent.component or iComponent
                            if componentHash == GetHashKey(cWeaponComponent.hash) then
                                result[#result + 1] = {
                                    index = _index,
                                    type = cWeaponComponent.type,
                                    name = cWeaponComponent.item,
                                    label = string.gsub(cWeaponComponent.item, "_", " "),
                                    hash = cWeaponComponent.hash,
                                    weapon_name = weapon.name,
                                    image = "attachments/" .. cWeaponComponent.item .. ".png"
                                }
                                _index = _index + 1
                                break
                            end
                        end
                    end
                end
            end
            return result
        end
    end
    return {}
end

function Koci.Client.Craft:AddAttachmentToWeapon(_weapon, newAttachment, cb)
    if _weapon.object == self.createdWeaponObjectOnTable then
        if not DoesWeaponTakeWeaponComponent(GetHashKey(self.selectedWeapon.name), GetHashKey(newAttachment.hash)) then
            Koci.Client:SendNotify(_t("game.cannot_be_attached_weapon"), "error")
            cb(false)
            return
        end
        Koci.Client:TriggerServerCallback("craft:server:AddAttachmentData", {
            weapon = self.selectedWeapon,
            attachment = newAttachment
        }, function(data)
            if not data.status then
                Koci.Client:SendNotify(data.error, "error")
                cb(false)
                return
            end
            local weaponObject = self.createdWeaponObjectOnTable
            local selectedWeapon = self.selectedWeapon
            if newAttachment.type ~= "skin" then
                local componentModel = GetWeaponComponentTypeModel(newAttachment.hash)
                Koci.Utils:LoadModel(componentModel)
                GiveWeaponComponentToWeaponObject(weaponObject, GetHashKey(newAttachment.hash))
                SetModelAsNoLongerNeeded(componentModel)
            end
            if DoesWeaponTakeWeaponComponent(GetHashKey(selectedWeapon.name), GetHashKey(newAttachment.hash)) then
                if not HasPedGotWeaponComponent(PlayerPedId(), GetHashKey(selectedWeapon.name), GetHashKey(newAttachment.hash)) then
                    GiveWeaponComponentToPed(
                        PlayerPedId(), GetHashKey(selectedWeapon.name),
                        GetHashKey(newAttachment.hash)
                    )
                end
            end
            newAttachment.index = tonumber(math.random(99) .. math.random(99) .. math.random(99))
            self.selectedWeapon._item.metadata = data.newMetadata
            self.selectedWeapon.attachments[#self.selectedWeapon.attachments + 1] = newAttachment
            cb({
                newAttachment = newAttachment,
                newMetadata = data.newMetadata
            })
        end)
    else
        Koci.Client:SendNotify(_t("game.unknown_weapon_object"))
        cb(false)
    end
end

function Koci.Client.Craft:RemoveAttachmentToWeapon(_weapon, attachment, cb)
    if _weapon.object == self.createdWeaponObjectOnTable then
        Koci.Client:TriggerServerCallback("craft:server:RemoveAttachmentData", {
            weapon = self.selectedWeapon,
            attachment = attachment
        }, function(data)
            if not data.status then
                Koci.Client:SendNotify(data.error, "error")
                cb(false)
                return
            end
            local weaponObject = self.createdWeaponObjectOnTable
            local selectedWeapon = self.selectedWeapon
            if attachment.type ~= "skin" then
                RemoveWeaponComponentFromWeaponObject(weaponObject, GetHashKey(attachment.hash))
            end
            RemoveWeaponComponentFromPed(
                PlayerPedId(),
                GetHashKey(selectedWeapon.name),
                GetHashKey(attachment.hash)
            )
            if attachment.type == "clip" then
                local newClipHash = self:FindDefaultClipComponentHash(self.selectedWeapon.name)
                if newClipHash then
                    local newClipModel = GetWeaponComponentTypeModel(newClipHash)
                    Koci.Utils:LoadModel(newClipModel)
                    GiveWeaponComponentToWeaponObject(weaponObject, GetHashKey(newClipHash))
                    SetModelAsNoLongerNeeded(newClipModel)
                end
            end
            self.selectedWeapon._item.metadata = data.newMetadata
            for i = #self.selectedWeapon.attachments, 1, -1 do
                if self.selectedWeapon.attachments[i] and self.selectedWeapon.attachments[i].index == attachment.index then
                    table.remove(self.selectedWeapon.attachments, i)
                end
            end
            cb({
                newMetadata = data.newMetadata
            })
        end)
    else
        Koci.Client:SendNotify(_t("game.unknown_weapon_object"))
        cb(false)
    end
end

function Koci.Client.Craft:FindDefaultClipComponentHash(weapon)
    if not Config.Weapons[weapon] then
        return false
    end
    for k, v in pairs(Config.Weapons[weapon].components or {}) do
        if v.type == "clip" then
            if string.find(v.hash, "_01") then
                return v.hash
            end
        end
    end
    return false
end

function Koci.Client.Craft:RemoveNilValuesQueueThread()
    local newCraftingQueues = {}
    for _, queue in pairs(self.CraftingQueues) do
        if queue ~= nil then
            newCraftingQueues[#newCraftingQueues + 1] = queue
        end
    end
    self.CraftingQueues = newCraftingQueues
end

function Koci.Client.Craft:StartQueueThread()
    if self.queueThreadIsActive then return end
    self.queueThreadIsActive = true
    CreateThread(function()
        while #self.CraftingQueues > 0 do
            Wait(1000)
            for key, queue in pairs(self.CraftingQueues) do
                local _remaining = queue.remaining and queue.remaining or queue.duration
                self.CraftingQueues[key].remaining = _remaining > 1000 and _remaining - 1000 or 0
                if _remaining == 0 and not queue.informed then
                    self.completedCraftingQueues[#self.completedCraftingQueues + 1] = queue
                    Koci.Client:SendNotify(_t("game.notify_item_has_been_crafted", queue.label))
                    self.CraftingQueues[key].informed = true
                    self.CraftingQueues[key] = nil
                end
            end
            self:RemoveNilValuesQueueThread()
            if self.isTheShopOpen then
                Koci.Client:SendReactMessage("ui:updateCraftingQueue", {
                    queues = self.CraftingQueues,
                    completedQueues = self.completedCraftingQueues
                })
            end
        end
        self.queueThreadIsActive = false
    end)
end

function Koci.Client.Craft:RemoveQueueToTable(queue)
    for i = #self.completedCraftingQueues, 1, -1 do
        if self.completedCraftingQueues[i].index == queue.index then
            table.remove(self.completedCraftingQueues, i)
        end
    end
end
