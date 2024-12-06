--[[ Variables ]]
Koci = {}
Koci.Framework = Utils.Functions.GetFramework()
Koci.Utils = Utils.Functions
Koci.Server = {
    Framework = {},
    Players = {},
    Functions = {},
}
Koci.Callbacks = {}

--[[ Core Thread]]
CreateThread(function()
    while Koci.Framework == nil do
        Koci.Framework = Utils.Functions.GetFramework()
        Wait(100)
    end
end)

--[[ Core Functions ]]
function Koci.Server.RegisterServerCallback(key, func)
    Koci.Callbacks[key] = func
end

function Koci.Server.TriggerCallback(key, source, cb, ...)
    if not cb then
        cb = function() end
    end
    if Koci.Callbacks[key] then
        Koci.Callbacks[key](source, cb, ...)
    end
end

--- Function that executes database queries
---
--- @param query: The SQL query to execute
--- @param params: Parameters for the SQL query (in table form)
--- @param type ("insert" | "update" | "query" | "scalar" | "single" | "prepare"): Parameters for the SQL query (in table form)
--- @return query any Results of the SQL query
function Koci.Server.ExecuteSQLQuery(query, params, type)
    type = type or "query"
    return MySQL[type].await(query, params)
end

function Koci.Server.SendNotify(source, type, title, text, duration, icon)
    system = Config.NotifyType
    if not duration then duration = 1000 end
    if system == "qb_notify" then
        if Config.FrameWork == "qb" then
            TriggerClientEvent("QBCore:Notify", source, title, type)
        else
            Utils.Functions.debugPrint("error", "QB not found.")
        end
    elseif system == "esx_notify" then
        if Config.FrameWork == "esx" then
            TriggerClientEvent("esx:showNotification", source, title, type, duration)
        else
            Utils.Functions.debugPrint("error", "ESX not found.")
        end
    elseif system == "custom_notify" then
        Utils.Functions.CustomNotify(source, title, type, text, duration, icon)
    else
        Utils.Functions.debugPrint("error", "Unknown notification type. [Koci.Server.SendNotify]")
    end
end

function Koci.Server.Framework.GetPlayerBySource(source)
    if Config.FrameWork == "esx" then
        return Koci.Framework.GetPlayerFromId(source)
    elseif Config.FrameWork == "qb" then
        return Koci.Framework.Functions.GetPlayer(source)
    end
end

function Koci.Server.Framework.GetPlayerIdentity(xPlayer)
    return Config.FrameWork == "esx" and
        (xPlayer.identifier)
        or
        xPlayer.PlayerData.citizenid
end

function Koci.Server.Framework.GetPlayerCharacterName(xPlayer)
    return Config.FrameWork == "esx" and
        xPlayer.name
        or
        xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
end

function Koci.Server.Framework.AddMoneyToBankAccount(source, amount)
    local xPlayer = Koci.Server.Framework.GetPlayerBySource(source)
    if Config.FrameWork == "esx" then
        xPlayer.addAccountMoney("bank", amount)
    elseif Config.FrameWork == "qb" then
        xPlayer.Functions.AddMoney("bank", amount)
    end
end

-- @ --
function Koci.Server.Functions.GetPlayer(source)
    local xPlayer = Koci.Server.Framework.GetPlayerBySource(source)
    if xPlayer then
        local identity = Koci.Server.Framework.GetPlayerIdentity(xPlayer)
        local fxPlayer = Koci.Server.Players[identity]
        if identity and fxPlayer then
            return Koci.Server.Players[identity]
        end
    end
    return nil
end

function Koci.Server.Functions.FindTaskById(id)
    if id == -1 then return false end
    for key, value in pairs(Config.AcceptableTasks) do
        if value.unique_id == id then
            return value
        end
    end
    return false
end

function Koci.Server.Functions.CheckPlayerLevel(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    local playerLevel = 1
    if xPlayer then
        local ranks = Config.JobOptions.ranks
        local exp = xPlayer.PlayerData.exp
        for i = 1, #ranks do
            if exp >= ranks[i] then
                playerLevel = i
            else
                break
            end
        end
    end
    return playerLevel
end

function Koci.Server.Functions.UpdateProfile(source, newProfile)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.PlayerData.profile = newProfile
    end
end

function Koci.Server.Functions.OnCreatedTaskVehicle(source, netId, coords, plate)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        local _vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
        xPlayer.PlayerData.taskVehicleNetId = netId
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
            if fxTarget then
                fxTarget.PlayerData.taskVehicleNetId = netId
                if DoesEntityExist(_vehicle) then
                    SetPedIntoVehicle(GetPlayerPed(mateSource), _vehicle, 0)
                end
                Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                TriggerClientEvent("qb-delivery:Client:OnTaskVehicleCreated", mateSource, netId, plate, coords)
            end
        end
    end
end

function Koci.Server.Functions.StartNewTaskDestination(source)
    local function getRandomDestination(destinations)
        local undeliveredDestinations = {}
        for key, destination in pairs(destinations) do
            destinations[key].id = key
            if not destination.delivered then
                table.insert(undeliveredDestinations, destinations[key])
            end
        end
        local undeliveredCount = #undeliveredDestinations
        if undeliveredCount == 0 then
            return destinations[math.random(1, #destinations)]
        end
        return undeliveredDestinations[math.random(1, undeliveredCount)]
    end
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        if not xPlayer.PlayerData.onDelivery then
            local Task = xPlayer.PlayerData.currentTask
            local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
            local Destination = getRandomDestination(Task.destinations)
            xPlayer.PlayerData.onDelivery = true
            xPlayer.PlayerData.currentDestination = Destination
            local pedModel = Koci.Utils.GetRandomTaskPed()
            TriggerClientEvent("qb-delivery:Client:StartNewTaskDestination",
                source,
                Destination,
                pedModel
            )
            for _, mate in pairs(teamMates) do
                local mateSource = mate.source
                local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
                if fxTarget then
                    fxTarget.PlayerData.onDelivery = true
                    fxTarget.PlayerData.currentDestination = Destination
                    Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                    TriggerClientEvent("qb-delivery:Client:StartNewTaskDestination",
                        mateSource,
                        Destination,
                        pedModel
                    )
                end
            end
        end
    end
end

function Koci.Server.Functions.StartTaskWithTeamMates(source, taskId)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        local Task = Koci.Server.Functions.FindTaskById(taskId)
        if Task then
            xPlayer.PlayerData.onTask                     = true
            xPlayer.PlayerData.currentTask                = Task
            xPlayer.PlayerData.currentTask.completed_goal = 0
            xPlayer.PlayerData.isLeader                   = true
            xPlayer.PlayerData.onDelivery                 = false
            xPlayer.PlayerData.currentDestination         = nil
            xPlayer.PlayerData.numberOfCargoInVehicle     = 0
            TriggerClientEvent("qb-delivery:Client:StartTask", source, taskId, true)
            local teamMates    = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
            local leaderCoords = GetEntityCoords(GetPlayerPed(source))
            for _, mate in pairs(teamMates) do
                local mateSource = mate.source
                local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
                if fxTarget then
                    SetEntityCoords(GetPlayerPed(mateSource), leaderCoords.x, leaderCoords.y, leaderCoords.z)
                    fxTarget.PlayerData.onTask                          = true
                    fxTarget.PlayerData.currentTask                     = Task
                    fxTarget.PlayerData.currentTask.completed_goal      = 0
                    fxTarget.PlayerData.isLeader                        = false
                    fxTarget.PlayerData.onDelivery                      = false
                    fxTarget.PlayerData.currentDestination              = nil
                    fxTarget.PlayerData.numberOfCargoInVehicle          = 0
                    Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                    TriggerClientEvent("qb-delivery:Client:StartTask", mateSource, taskId, false)
                end
            end
        end
    end
end

function Koci.Server.Functions.CanLoadCargoInVehicle(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.numberOfCargoInVehicle < xPlayer.PlayerData.currentTask.goal
    end
    return false
end

function Koci.Server.Functions.CanCargoPickUpFromVehicle(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.numberOfCargoInVehicle > 0 and
            (xPlayer.PlayerData.currentTask.goal - xPlayer.PlayerData.currentTask.completed_goal) ==
            xPlayer.PlayerData.numberOfCargoInVehicle
    end
    return false
end

function Koci.Server.Functions.OnCargoPutOnTaskVehicle(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.PlayerData.numberOfCargoInVehicle =
            xPlayer.PlayerData.numberOfCargoInVehicle + 1
        local PlayerPedId = GetPlayerPed(source)
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
            if fxTarget then
                fxTarget.PlayerData.numberOfCargoInVehicle =
                    fxTarget.PlayerData.numberOfCargoInVehicle + 1
                Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                TriggerClientEvent("qb-delivery:Client:OnCargoPutOnTaskVehicle",
                    mateSource,
                    source
                )
            end
        end
        if xPlayer.PlayerData.currentTask.type == "delivery" then
            if xPlayer.PlayerData.numberOfCargoInVehicle >= xPlayer.PlayerData.currentTask.goal then
                --[[ First Start]]
                Koci.Server.Functions.StartNewTaskDestination(source)
            end
        end
    end
end

function Koci.Server.Functions.OnCargoPickUpFromTaskVehicle(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        if not Koci.Server.Functions.CanCargoPickUpFromVehicle(source) then return end
        xPlayer.PlayerData.numberOfCargoInVehicle =
            xPlayer.PlayerData.numberOfCargoInVehicle - 1
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
            if fxTarget then
                fxTarget.PlayerData.numberOfCargoInVehicle =
                fxTarget.PlayerData.numberOfCargoInVehicle - 1
                Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                TriggerClientEvent("qb-delivery:Client:OnCargoPickUpFromTaskVehicle",
                    mateSource,
                    source
                )
            end
        end
    end
end

function Koci.Server.Functions.OnCargoPickUpFromDestinationPed(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        if not Koci.Server.Functions.CanLoadCargoInVehicle(source) then return end
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Server.Functions.GetPlayer(mateSource)
            if fxTarget then
                TriggerClientEvent("qb-delivery:Client:OnCargoPickUpFromDestinationPed",
                    mateSource,
                    source
                )
            end
        end
    end
end

function Koci.Server.Functions.GiveTaskAwards(source, task)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.PlayerData.exp = xPlayer.PlayerData.exp + task.exp
        xPlayer.PlayerData.level = Koci.Server.Functions.CheckPlayerLevel(source)
        local newExp = xPlayer.PlayerData.exp
        local newLevel = xPlayer.PlayerData.level
        Koci.Server.Framework.AddMoneyToBankAccount(source, task.fee)
        return newLevel, newExp
    end
    return 0, 0
end

function Koci.Server.Functions.HandOverTaskVehicle(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        TriggerClientEvent("qb-delivery:Client:HandOverTaskVehicle", source)
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Server.Functions.GetPlayer(mateSource)
            if fxTarget then
                TriggerClientEvent("qb-delivery:Client:HandOverTaskVehicle", mateSource)
            end
        end
    end
end

function Koci.Server.Functions.TickDeliveredDestionById(source, id)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        for key, value in pairs(xPlayer.PlayerData.currentTask.destinations) do
            if key == id then
                xPlayer.PlayerData.currentTask.destinations[key].delivered = true
                return true
            end
        end
    end
    return false
end

function Koci.Server.Functions.OnTaskDestionCompleted(source, prop)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        Koci.Server.Functions.TickDeliveredDestionById(source, xPlayer.PlayerData.currentDestination.id)
        local cg = xPlayer.PlayerData.currentTask.completed_goal
        xPlayer.PlayerData.currentTask.completed_goal = cg + 1
        xPlayer.PlayerData.onDelivery = false
        xPlayer.PlayerData.currentDestination = nil
        TriggerClientEvent("qb-delivery:Client:OnTaskDestionCompleted",
            source,
            prop
        )
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
            if fxTarget then
                Koci.Server.Functions.TickDeliveredDestionById(mateSource, fxTarget.PlayerData.currentDestination.id)
                local cg = fxTarget.PlayerData.currentTask.completed_goal
                fxTarget.PlayerData.currentTask.completed_goal = cg + 1
                fxTarget.PlayerData.onDelivery = false
                fxTarget.PlayerData.currentDestination = nil
                Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                TriggerClientEvent("qb-delivery:Client:OnTaskDestionCompleted",
                    mateSource,
                    prop
                )
            end
        end
        if xPlayer.PlayerData.currentTask.completed_goal >= xPlayer.PlayerData.currentTask.goal then
            CreateThread(function()
                Wait(1000)
                Koci.Server.Functions.HandOverTaskVehicle(source)
            end)
        else
            CreateThread(function()
                Wait(1000)
                Koci.Server.Functions.StartNewTaskDestination(source)
            end)
        end
    end
end

function Koci.Server.Functions.SaveData(source)
    local xPlayer = Koci.Server.Framework.GetPlayerBySource(source)
    if xPlayer then
        local xPlayerIdentity = Koci.Server.Framework.GetPlayerIdentity(xPlayer)
        local fxPlayer = Koci.Server.Functions.GetPlayer(source)
        CreateThread(function()
            Koci.Server.ExecuteSQLQuery(
                "UPDATE `nchub_delivery_employees` SET profile = ?, level = ?, exp = ? WHERE user = ?",
                {
                    fxPlayer.PlayerData.profile,
                    fxPlayer.PlayerData.level,
                    fxPlayer.PlayerData.exp,
                    xPlayerIdentity
                }, "update"
            )
        end)
    end
end

function Koci.Server.Functions.OnTaskCompleted(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        local newLevel, newExp = Koci.Server.Functions.GiveTaskAwards(source, xPlayer.PlayerData.currentTask)
        xPlayer.PlayerData.level = newLevel
        xPlayer.PlayerData.exp = newExp
        xPlayer.PlayerData.isLeader = false
        xPlayer.PlayerData.numberOfCargoInVehicle = 0
        xPlayer.PlayerData.onDelivery = false
        xPlayer.PlayerData.currentDestination = nil
        xPlayer.PlayerData.onTask = false
        xPlayer.PlayerData.currentTask = nil
        TriggerClientEvent("qb-delivery:Client:OnTaskCompleted", source, newLevel, newExp)
        Koci.Server.Functions.SaveData(source)
        local teamMates = Koci.Utils.deepCopy(xPlayer.PlayerData.TeamMate or {})
        for _, mate in pairs(teamMates) do
            local mateSource = mate.source
            local fxTarget = Koci.Utils.deepCopy(Koci.Server.Functions.GetPlayer(mateSource))
            if fxTarget then
                local newLevel, newExp = Koci.Server.Functions.GiveTaskAwards(
                    mateSource,
                    fxTarget.PlayerData.currentTask
                )
                fxTarget.PlayerData.level = newLevel
                fxTarget.PlayerData.exp = newExp
                fxTarget.PlayerData.isLeader = false
                fxTarget.PlayerData.numberOfCargoInVehicle = 0
                fxTarget.PlayerData.onDelivery = false
                fxTarget.PlayerData.currentDestination = nil
                fxTarget.PlayerData.onTask = false
                fxTarget.PlayerData.currentTask = nil
                Koci.Server.Players[fxTarget.PlayerData.identifier] = fxTarget
                TriggerClientEvent("qb-delivery:Client:OnTaskCompleted", mateSource, newLevel, newExp)
                Koci.Server.Functions.SaveData(mateSource)
            end
        end
    end
end

function Koci.Server.Functions.GetMateCount(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        return #xPlayer.PlayerData.TeamMate
    end
    return 0
end

function Koci.Server.Functions.AddTeamMate(playerSrc, targetSource, data)
    local xPlayer = Koci.Server.Functions.GetPlayer(playerSrc)
    if xPlayer then
        local found = false
        for key, value in pairs(xPlayer.PlayerData.TeamMate) do
            if value.source == targetSource then
                value = data
                value.source = targetSource
                found = true
                break
            end
        end
        if not found then
            local _v = data
            _v.source = targetSource
            xPlayer.PlayerData.TeamMate[#xPlayer.PlayerData.TeamMate + 1] = _v
        end
    end
end

function Koci.Server.Functions.LeavedTeamMate(playerSrc, leavedSource)
    local xPlayer = Koci.Server.Functions.GetPlayer(playerSrc)
    if xPlayer then
        for index, value in pairs(xPlayer.PlayerData.TeamMate) do
            if value.source == leavedSource then
                table.remove(xPlayer.PlayerData.TeamMate, index)
                break
            end
        end
    end
end

function Koci.Server.Functions.GetOnDuty(playerSrc)
    local xPlayer = Koci.Server.Functions.GetPlayer(playerSrc)
    if xPlayer then
        xPlayer.PlayerData.onDuty = true
    end
end

function Koci.Server.Functions.LeaveDuty(src)
    local xPlayer = Koci.Server.Functions.GetPlayer(playerSrc)
    if xPlayer then
        xPlayer.PlayerData.onDuty = false
    end
end

function Koci.Server.Functions.StopTask(source)
    local xPlayer = Koci.Server.Functions.GetPlayer(source)
    if xPlayer then
        local xTarget                                      = Koci.Utils.deepCopy(xPlayer)
        xTarget.PlayerData.onTask                          = false
        xTarget.PlayerData.currentTask                     = nil
        xTarget.PlayerData.isLeader                        = false
        xTarget.PlayerData.onDelivery                      = false
        xTarget.PlayerData.currentDestination              = nil
        xTarget.PlayerData.numberOfCargoInVehicle          = 0
        Koci.Server.Players[xTarget.PlayerData.identifier] = xTarget
    end
end

function Koci.Server.Functions.NewPlayer(source, identifier, data)
    local Player                             = {}
    Player.PlayerData                        = {}

    Player.PlayerData.sourceId               = source
    Player.PlayerData.identifier             = identifier
    Player.PlayerData.characterName          = data.characterName or "unknown"
    Player.PlayerData.profile                = data.profile or "profile_1"
    Player.PlayerData.level                  = data.level or 1
    Player.PlayerData.exp                    = data.exp or 0
    Player.PlayerData.onDuty                 = data.onDuty or false
    Player.PlayerData.workingPoint           = data.workingPoint or nil
    Player.PlayerData.TeamMate               = data.TeamMate or {}
    Player.PlayerData.onTask                 = data.onTask or false
    Player.PlayerData.currentTask            = data.currentTask or nil
    Player.PlayerData.isLeader               = data.isLeader or false
    Player.PlayerData.onDelivery             = data.onDelivery or false
    Player.PlayerData.currentDestination     = data.currentDestination or nil
    Player.PlayerData.numberOfCargoInVehicle = data.numberOfCargoInVehicle or 0
    Koci.Server.Players[identifier]          = Player
end
